defmodule ExAws.Config.AuthCache do
  @moduledoc false

  use GenServer

  # http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/iam-roles-for-amazon-ec2.html

  @refresh_lead_time 300_000
  @instance_auth_key :aws_instance_auth

  defmodule AuthConfigAdapter do
    @moduledoc false

    @doc "Compute the awscli auth information."
    @callback adapt_auth_config(auth :: map, profile :: String.t(), expiration :: integer) :: any
  end

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, Keyword.put(opts, :name, __MODULE__))
  end

  def get(config) do
    :ets.lookup(__MODULE__, @instance_auth_key)
    |> refresh_auth_if_required(config)
  end

  def get(profile, expiration) do
    case :ets.lookup(__MODULE__, {:awscli, profile}) do
      [{{:awscli, ^profile}, auth_config}] ->
        auth_config

      [] ->
        GenServer.call(__MODULE__, {:refresh_awscli_config, profile, expiration}, 30_000)
    end
  end

  ## Callbacks

  def init(:ok) do
    ets = :ets.new(__MODULE__, [:named_table, read_concurrency: true])
    {:ok, ets}
  end

  def handle_call({:refresh_auth, config}, _from, ets) do
    auth = refresh_auth(config, ets)
    {:reply, auth, ets}
  end

  def handle_call({:refresh_awscli_config, profile, expiration}, _from, ets) do
    auth = refresh_awscli_config(profile, expiration, ets)
    {:reply, auth, ets}
  end

  def handle_info({:refresh_auth, config}, ets) do
    refresh_auth(config, ets)
    {:noreply, ets}
  end

  def handle_info({:refresh_awscli_config, profile, expiration}, ets) do
    refresh_awscli_config(profile, expiration, ets)
    {:noreply, ets}
  end

  def refresh_awscli_config(profile, expiration, ets) do
    Process.send_after(self(), {:refresh_awscli_config, profile, expiration}, expiration)

    auth = ExAws.Config.awscli_auth_credentials(profile)

    auth =
      case ExAws.Config.awscli_auth_adapter() do
        nil ->
          auth

        adapter ->
          adapter.adapt_auth_config(auth, profile, expiration)
      end

    :ets.insert(ets, {{:awscli, profile}, auth})

    auth
  end

  defp refresh_auth_if_required([], config) do
    GenServer.call(__MODULE__, {:refresh_auth, config}, 30_000)
  end

  defp refresh_auth_if_required([{_key, cached_auth}], config) do
    if next_refresh_in(cached_auth) > 0 do
      cached_auth
    else
      GenServer.call(__MODULE__, {:refresh_auth, config}, 30_000)
    end
  end

  defp refresh_auth(config, ets) do
    :ets.lookup(__MODULE__, @instance_auth_key)
    |> refresh_auth_if_stale(config, ets)
  end

  defp refresh_auth_if_stale([], config, ets) do
    refresh_auth_now(config, ets)
  end

  defp refresh_auth_if_stale([{_key, cached_auth}], config, ets) do
    if next_refresh_in(cached_auth) > @refresh_lead_time do
      # we still have a valid auth token, so simply return that
      cached_auth
    else
      refresh_auth_now(config, ets)
    end
  end

  defp refresh_auth_if_stale(_, config, ets), do: refresh_auth_now(config, ets)

  defp refresh_auth_now(config, ets) do
    auth = ExAws.InstanceMeta.security_credentials(config)
    :ets.insert(ets, {@instance_auth_key, auth})
    Process.send_after(__MODULE__, {:refresh_auth, config}, next_refresh_in(auth))
    auth
  end

  defp next_refresh_in(%{expiration: expiration}) do
    try do
      expires_in_ms =
        expiration
        |> NaiveDateTime.from_iso8601!()
        |> NaiveDateTime.diff(NaiveDateTime.utc_now(), :millisecond)

      # refresh lead_time before auth expires, unless the time has passed
      # otherwise refresh needed now
      max(0, expires_in_ms - @refresh_lead_time)
    rescue
      _e -> 0
    end
  end

  defp next_refresh_in(_), do: 0
end
