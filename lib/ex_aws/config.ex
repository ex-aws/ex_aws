defmodule ExAws.Config do

  @moduledoc false

  # Generates the configuration for a service.
  # It starts with the defaults for a given environment
  # and then merges in the common config from the ex_aws config root,
  # and then finally any config specified for the particular service

  @common_config [
    :http_client, :http_opts, :json_codec, :retries, :debug_requests,
    :access_key_id, :secret_access_key, :security_token, :region, :host
  ]

  @type t :: %{} | Keyword.t

  @doc """
  Builds a complete set of config for an operation.

  1) Defaults are pulled from `ExAws.Config.Defaults`
  2) Common values set via e.g `config :ex_aws` are merged in.
  3) Keys set on the individual service e.g `config :ex_aws, :s3` are merged in
  4) Finally, any configuration overrides are merged in
  """
  def new(service, opts \\ []) do
    overrides = Map.new(opts)

    service
    |> build_base(overrides)
    |> retrieve_runtime_config
    |> parse_host_for_region
  end

  defp build_base(service, overrides) do
    defaults = ExAws.Config.Defaults.get(service)
    common_config = Application.get_all_env(:ex_aws) |> Map.new |> Map.take(@common_config)
    service_config = Application.get_env(:ex_aws, service, []) |> Map.new

    base =
      defaults
      |> Map.merge(common_config)
      |> Map.merge(service_config)
      |> Map.merge(overrides)

    manual_host? =
      [common_config, service_config, overrides]
      |> Enum.any?(&Map.has_key?(&1, :host))

    if manual_host? do
      base
    else
      base |> derive_host(service)
    end
  end

  @runtime_values [:access_key_id, :secret_access_key, :security_token, :host, :region]

  defp retrieve_runtime_config(config) do
    config
    |> Enum.map(fn {key, value_or_descriptor} ->
      value = if key in @runtime_values do
        retrieve_runtime_value(value_or_descriptor, key, config)
      else
        value_or_descriptor
      end
      {key, value}
    end)
    |> Enum.into(%{})
  end

  defp retrieve_runtime_value({:system, env_key}, _key, _config) do
    System.get_env(env_key)
  end
  defp retrieve_runtime_value(:instance_role, key, config) do
    config
    |> ExAws.Config.AuthCache.get
    |> Map.get(key)
  end
  defp retrieve_runtime_value({:awscli, profile, expiration}, key, _config) do
    ExAws.Config.AuthCache.get(profile, expiration * 1000)
    |> Map.get(key)
  end
  defp retrieve_runtime_value(values, key, config) when is_list(values) do
    values
    |> Stream.map(&retrieve_runtime_value(&1, key, config))
    |> Enum.find(& &1 != nil)
  end
  defp retrieve_runtime_value(value, _key, _config), do: value

  defp derive_host(config, service) do
    region = Map.get(config, :region, "us-east-1")
    config
    |> Map.put(:host, ExAws.Config.Host.get_host(service, region))
  end

  defp parse_host_for_region(%{host: {stub, host}, region: region} = config) do
    Map.put(config, :host, String.replace(host, stub, region))
  end
  defp parse_host_for_region(%{host: map, region: region} = config) when is_map(map) do
    case Map.fetch(map, region) do
      {:ok, host} -> Map.put(config, :host, host)
      :error      -> "A host for region #{region} was not found in host map #{inspect(map)}"
    end
  end
  defp parse_host_for_region(config), do: config
end
