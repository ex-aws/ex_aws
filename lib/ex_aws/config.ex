defmodule ExAws.Config do
  @moduledoc false

  # Generates the configuration for a service.
  # It starts with the defaults for a given environment
  # and then merges in the common config from the ex_aws config root,
  # and then finally any config specified for the particular service

  @common_config [
    :http_client,
    :json_codec,
    :access_key_id,
    :secret_access_key,
    :debug_requests,
    :region,
    :security_token,
    :retries,
    :normalize_path,
    :telemetry_event,
    :telemetry_options
  ]

  @type t :: %{} | Keyword.t()

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

  def build_base(service, overrides \\ %{}) do
    common_config = Application.get_all_env(:ex_aws) |> Map.new() |> Map.take(@common_config)
    service_config = Application.get_env(:ex_aws, service, []) |> Map.new()

    region =
      (Map.get(overrides, :region) ||
         Map.get(service_config, :region) ||
         Map.get(common_config, :region) ||
         "us-east-1")
      |> retrieve_runtime_value(%{})

    defaults = ExAws.Config.Defaults.get(service, region)

    defaults
    |> Map.merge(common_config)
    |> Map.merge(service_config)
    |> Map.merge(overrides)
  end

  def retrieve_runtime_config(config) do
    Enum.reduce(config, config, fn
      {:host, host}, config ->
        Map.put(config, :host, retrieve_runtime_value(host, config))

      {:retries, retries}, config ->
        Map.put(config, :retries, retries)

      {:http_opts, http_opts}, config ->
        Map.put(config, :http_opts, http_opts)

      {:telemetry_event, telemetry_event}, config ->
        Map.put(config, :telemetry_event, telemetry_event)

      {:telemetry_options, telemetry_options}, config ->
        Map.put(config, :telemetry_options, telemetry_options)

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
    |> ExAws.Config.AuthCache.get()
    |> Map.take([:access_key_id, :secret_access_key, :security_token])
    |> valid_map_or_nil
  end

  def retrieve_runtime_value({:awscli, profile, expiration}, _) do
    ExAws.Config.AuthCache.get(profile, expiration * 1000)
    |> Map.take([
      :source_profile,
      :role_arn,
      :access_key_id,
      :secret_access_key,
      :region,
      :security_token,
      :role_session_name,
      :external_id
    ])
    |> valid_map_or_nil
  end

  def retrieve_runtime_value(values, config) when is_list(values) do
    values
    |> Stream.map(&retrieve_runtime_value(&1, config))
    |> Enum.find(& &1)
  end

  def retrieve_runtime_value(value, _), do: value

  def parse_host_for_region(%{host: {stub, host}, region: region} = config) do
    Map.put(config, :host, String.replace(host, stub, region))
  end

  def parse_host_for_region(%{host: map, region: region} = config) when is_map(map) do
    case Map.fetch(map, region) do
      {:ok, host} -> Map.put(config, :host, host)
      :error -> "A host for region #{region} was not found in host map #{inspect(map)}"
    end
  end

  def parse_host_for_region(config), do: config

  def awscli_auth_adapter, do: Application.get_env(:ex_aws, :awscli_auth_adapter, nil)

  def awscli_auth_credentials(profile, credentials_ini_provider \\ ExAws.CredentialsIni.File) do
    case Application.get_env(:ex_aws, :awscli_credentials, nil) do
      nil ->
        credentials_ini_provider.security_credentials(profile)

      %{^profile => profile_credentials} ->
        profile_credentials

      _otherwise ->
        raise("Missing #{profile} in provided credentials.")
    end
  end

  defp valid_map_or_nil(map) when map == %{}, do: nil
  defp valid_map_or_nil(map), do: map
end
