defmodule ExAws.Config.AuthCache do
  use GenServer

  @update_interval 30 * 60 * 1000

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def get(%{__struct__: client_module} = client) do
    case :ets.lookup(__MODULE__, client_module) do
      [{^client_module, auth_config}] -> auth_config
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

  def refresh_config(%{__struct__: client_module} = client, ets) do
    result = ExAws.InstanceMeta.request(client, "/iam/security-credentials/#{client.config.role}")
    auth = %{
      access_key_id: result["AccessKeyId"],
      secret_access_key: result["SecretAccessKey"]
    }

    :ets.insert(ets, {client_module, auth})

    Process.send_after(self, {:refresh_config, client}, @update_interval)

    auth
  end

end
