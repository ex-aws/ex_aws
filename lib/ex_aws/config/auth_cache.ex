defmodule ExAws.Config.AuthCache do
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def get(client) do
    case :ets.lookup(__MODULE__, :aws_instance_auth) do
      [{:aws_instance_auth, auth_config}] -> auth_config
      [] -> GenServer.call(__MODULE__, {:refresh_config, client})
    end
  end

  ## Callbacks

  def init(:ok) do
    ets = :ets.new(__MODULE__, [:named_table, read_concurrency: true])
    {:ok, ets}
  end

  def handle_call({:refresh_config, client}, _from, ets) do
    auth = refresh_config(client, ets)
    {:reply, auth, ets}
  end

  def handle_info({:refresh_config, client}, ets) do
    refresh_config(client, ets)
    {:noreply, ets}
  end

  def refresh_config(client, ets) do
    auth = ExAws.InstanceMeta.security_credentials(client)
    :ets.insert(ets, {:aws_instance_auth, auth})
    Process.send_after(self(), {:refresh_config, client}, refresh_in(auth[:expiration]))
    auth
  end

  def refresh_in(expiration) do
    expiration = Timex.DateFormat.parse!(expiration, "{ISOz}")
    |> Timex.Date.convert(:secs)
    time_to_expiration = expiration - Timex.Date.now(:secs)
    refresh_in = time_to_expiration - 2 * 60 # check two min prior to expiration
    refresh_in * 1000
  end

end
