defmodule ExAws.Config.AuthCache do
  use GenServer

  @moduledoc false

  # http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/iam-roles-for-amazon-ec2.html

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def get(config) do
    case :ets.lookup(__MODULE__, :aws_instance_auth) do
      [{:aws_instance_auth, auth_config}] -> auth_config
      [] -> GenServer.call(__MODULE__, {:refresh_config, config}, 30_000)
    end
  end
  def get(profile, expiration) do
    case :ets.lookup(__MODULE__, :awscli) do
      [{:awscli, auth_config}] -> auth_config
      [] -> GenServer.call(__MODULE__, {:refresh_awscli_config, profile, expiration}, 30_000)
    end
  end

  ## Callbacks

  def init(:ok) do
    ets = :ets.new(__MODULE__, [:named_table, read_concurrency: true])
    {:ok, ets}
  end

  def handle_call({:refresh_config, config}, _from, ets) do
    auth = refresh_config(config, ets)
    {:reply, auth, ets}
  end
  def handle_call({:refresh_awscli_config, profile, expiration}, _from, ets) do
    auth = refresh_awscli_config(profile, expiration, ets)
    {:reply, auth, ets}
  end

  def handle_info({:refresh_config, config}, ets) do
    refresh_config(config, ets)
    {:noreply, ets}
  end
  def handle_info({:refresh_awscli_config, profile, expiration}, ets) do
    refresh_awscli_config(profile, expiration, ets)
    {:noreply, ets}
  end

  def refresh_awscli_config(profile, expiration, ets) do
    auth = ExAws.CredentialsIni.security_credentials(profile)
    case auth do
      %{source_profile: source_profile} ->
        :ets.insert(ets, {
          :awscli, ExAws.CredentialsIni.security_credentials(source_profile)
        })
      auth -> :ets.insert(ets, auth)
    end

    assume_role_options = [
      duration: credential_duration_seconds(expiration),
      external_id: auth.external_id,
    ]
    role_session_name = auth.role_session_name || "default_session"

    auth = if auth.role_arn do
      {:ok, result} = auth.role_arn
      |> ExAws.STS.assume_role(role_session_name, assume_role_options)
      |> ExAws.Operation.perform(ExAws.Config.new(:sts))

      IO.inspect auth

      assumed_auth = %{
        access_key_id: result.body.access_key_id,
        secret_access_key: result.body.secret_access_key,
        security_token: result.body.session_token,
        expiration: result.body.expiration
      }

      :ets.insert(ets, {:awscli, assumed_auth})
      assumed_auth
    else
      auth
    end

    Process.send_after(self(), {:refresh_awscli_config, profile, expiration}, expiration)
    auth
  end

  defp credential_duration_seconds(expiration_ms) do
    # assume_role accepts a duration between 900 and 3600 seconds
    # We're adding a buffer to make sure the credentials live longer than
    # the refresh interval.
    {min, max, buffer} = {900, 3600, 5}
    seconds = div(expiration_ms, 1000) + buffer
    Enum.max([ Enum.min([max, seconds]), min ])
  end

  def refresh_config(config, ets) do
    auth = ExAws.InstanceMeta.security_credentials(config)
    :ets.insert(ets, {:aws_instance_auth, auth})
    Process.send_after(self(), {:refresh_config, config}, refresh_in(auth[:expiration]))
    auth
  end

  def refresh_in(expiration) do
    expiration = expiration |> ExAws.Utils.iso_z_to_secs
    time_to_expiration = expiration - ExAws.Utils.now_in_seconds
    refresh_in = time_to_expiration - 5 * 60 # check five mins prior to expiration
    max(0, refresh_in * 1000) # check now if we should have checked in the past
  end

end
