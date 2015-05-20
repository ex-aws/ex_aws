defmodule ExAws.Config.AuthCache do
  use GenServer

  @update_interval 30 * 60 * 1000

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def get(%{__struct__: client_module} = client, role) do
    key = {client_module, role}
    case :ets.lookup(__MODULE__, key) do
      [{^key, auth_config}] -> auth_config
      [] -> GenServer.call(__MODULE__, {:refresh_config, client, role})
    end
  end

  ## Callbacks

  def init(:ok) do
    ets = :ets.new(__MODULE__, [:named_table, read_concurrency: true])
    {:ok, ets}
  end

  def handle_call({:refresh_config, client, role}, _from, ets) do
    auth = refresh_config(client, role, ets)
    {:reply, auth, ets}
  end

  def handle_info({:refresh_config, client, role}, ets) do
    refresh_config(client, role, ets)
    {:noreply, ets}
  end

  def refresh_config(%{__struct__: client_module} = client, role, ets) do
    result = ExAws.InstanceMeta.request(client, "/iam/security-credentials/#{client.config.role}")
    auth = %{
      access_key_id: result["AccessKeyId"],
      secret_access_key: result["SecretAccessKey"]
    }

    :ets.insert(ets, {{client_module, role}, auth})

    Process.send_after(self, {:refresh_config, client}, @update_interval)

    auth
  end

end
