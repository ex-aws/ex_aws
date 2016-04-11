defmodule ExAws.Config do

  @moduledoc false

  # Generates the configuration for a client.
  # It starts with the defaults for a given environment
  # and then merges in the common config from the ex_aws config root,
  # and then finally any config specified for the particular service

  @common_config [:http_client, :json_codec, :access_key_id, :secret_access_key, :debug_requests, :region]

  def build(client, opts \\ []) do
    config = client
    |> ExAws.Config.get
    |> Map.merge(Enum.into(opts, %{}))

    %{client | config: config}
    |> retrieve_runtime_config
  end

  def get(%{__struct__: client_module, service: service}) do
    config_root = client_module.config_root
    unless config_root, do: raise "A valid configuration root is required in your #{service} client"

    defaults = ExAws.Config.Defaults.get
    config   = config_root |> Keyword.get(service, [])
    common   = defaults
    |> Keyword.merge(config_root)
    |> Keyword.take(@common_config)

    defaults
    |> Keyword.get(service, [])
    |> Keyword.merge(common)
    |> Keyword.merge(config)
    |> Enum.into(%{})
  end

  def retrieve_runtime_config(%{config: config} = client) do
    new_config = config
    |> Enum.reduce(%{}, fn
      {:host, host}, config ->
        Map.put(config, :host, host)
      {k, v}, config ->
        case retrieve_runtime_value(v, client) do
          %{} = result -> Map.merge(config, result)
          value -> Map.put(config, k, value)
        end
    end)

    %{client | config: new_config}
  end

  def retrieve_runtime_value({:system, env_key}, _) do
    System.get_env(env_key)
  end
  def retrieve_runtime_value(:instance_role, client) do
    client
    |> ExAws.Config.AuthCache.get
    |> Map.take([:access_key_id, :secret_access_key, :security_token])
  end
  def retrieve_runtime_value(values, client) when is_list(values) do
    values
    |> Stream.map(&retrieve_runtime_value(&1, client))
    |> Enum.find(&(&1))
  end
  def retrieve_runtime_value(value, _), do: value

  def parse_host_for_region(%{config: %{host: {stub, host}, region: region} = config} = client) do
    %{client | config: Map.put(config, :host, String.replace(host, stub, region))}
  end
  def parse_host_for_region(%{config: %{host: map, region: region} = config} = client) when is_map(map) do
    case Map.fetch(map, region) do
      {:ok, host} -> %{client | config: Map.put(config, :host, host)}
      :error      -> "A host for region #{region} was not found in host map #{inspect(map)}"
    end
  end
  def parse_host_for_region(client), do: client

end
