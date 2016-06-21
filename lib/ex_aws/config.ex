defmodule ExAws.Config do

  @moduledoc false

  # Generates the configuration for a service.
  # It starts with the defaults for a given environment
  # and then merges in the common config from the ex_aws config root,
  # and then finally any config specified for the particular service

  @common_config [
    :http_client, :json_codec, :access_key_id, :secret_access_key, :debug_requests,
    :region, :security_token
  ]

  def build(service, opts \\ []) do
    overrides = Map.new(opts)

    service
    |> ExAws.Config.get(overrides)
    |> retrieve_runtime_config
    |> parse_host_for_region
  end

  @doc """
  Builds a complete set of config for an operation.

  1) Defaults are pulled from `ExAws.Config.Defaults`
  2) Common values set via e.g `config :ex_aws` are merged in.
  3) Keys set on the individual service e.g `config :ex_aws, :s3` are merged in
  4) Finally, any configuration overrides are merged in
  """
  def get(service, overrides) do
    defaults = ExAws.Config.Defaults.get(service)
    common_config = Application.get_all_env(:ex_aws) |> Map.new |> Map.take(@common_config)
    service_config = Application.get_env(:ex_aws, service, []) |> Map.new

    defaults
    |> Map.merge(common_config)
    |> Map.merge(service_config)
    |> Map.merge(overrides)
  end

  def retrieve_runtime_config(config) do
    Enum.reduce(config, %{}, fn
      {:host, host}, config ->
        Map.put(config, :host, retrieve_runtime_value(host, config))
      {k, v}, config ->
        case retrieve_runtime_value(v, config) do
          %{} = result -> Map.merge(config, result)
          value -> Map.put(config, k, value)
        end
    end)
  end

  def retrieve_runtime_value({:system, env_key}, _) do
    System.get_env(env_key)
  end
  def retrieve_runtime_value(:instance_role, config) do
    config
    |> ExAws.Config.AuthCache.get
    |> Map.take([:access_key_id, :secret_access_key, :security_token])
  end
  def retrieve_runtime_value(values, config) when is_list(values) do
    values
    |> Stream.map(&retrieve_runtime_value(&1, config))
    |> Enum.find(&(&1))
  end
  def retrieve_runtime_value(value, _), do: value

  def parse_host_for_region(%{host: {stub, host}, region: region} = config) do
    Map.put(config, :host, String.replace(host, stub, region))
  end
  def parse_host_for_region(%{host: map, region: region} = config) when is_map(map) do
    case Map.fetch(map, region) do
      {:ok, host} -> Map.put(config, :host, host)
      :error      -> "A host for region #{region} was not found in host map #{inspect(map)}"
    end
  end
  def parse_host_for_region(config), do: config

end
