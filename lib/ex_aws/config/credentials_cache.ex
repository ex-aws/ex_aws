defmodule ExAws.Config.CredentialsCache do
  use GenServer

  @moduledoc false
  @refresh_time 10

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def get(config) do
    case :ets.lookup(__MODULE__, :awscli) do
      [{:awscli, auth_config}] -> auth_config
      [] -> GenServer.call(__MODULE__, {:refresh_config, config})
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

  def handle_info({:refresh_config, config}, ets) do
    refresh_config(config, ets)
    {:noreply, ets}
  end

  def refresh_config(config, ets) do
    auth = ExAws.CredentialsIni.security_credentials(config)
    :ets.insert(ets, {:awscli, auth})
    Process.send_after(self(), {:refresh_config, config}, @refresh_time)
    auth
  end
end
