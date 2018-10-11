defmodule ExAws.Config.ApiKey do
  use GenServer
  use ExAws.Config.Adapter

  @moduledoc false

  @valid_keys [:access_key_id, :secret_access_key]

  def start_link(config, opts \\ []) do
    GenServer.start_link(__MODULE__, Map.take(config, @valid_keys), opts)
  end

  @doc "Retrieve config options"
  def get(pid, _config) do
    GenServer.call(pid, :get)
  end

  ## Callbacks

  def init(config) do
    {:ok, config}
  end

  def handle_call(:get, _from, config) do
    {:reply, config, config}
  end
end
