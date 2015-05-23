defmodule ExAws.Config do

  @moduledoc false

  # Generates the configuration for a client.
  # It starts with the defaults for a given environment
  # and then merges in the common config from the ex_aws config root,
  # and then finally any config specified for the particular service

  @common_config [:http_client, :json_codec, :access_key_id, :secret_access_key, :debug_requests]

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

    config = config_root |> Keyword.get(service, [])
    common = ExAws.Config.Defaults.defaults
    |> Keyword.merge(config_root)
    |> Keyword.take(@common_config)

    ExAws.Config.Defaults.defaults
    |> Keyword.get(service, [])
    |> Keyword.merge(common)
    |> Keyword.merge(config)
    |> Enum.into(%{})
  end

  def retrieve_runtime_config(%{config: config} = client) do
    new_config = config
    |> Enum.reduce(%{}, fn {k, v}, config ->
      Map.put(config, k, retrieve_runtime_value(k, v, client))
    end)

    %{client | config: new_config}
  end

  def retrieve_runtime_value(_, {:system, env_key}, _) do
    System.get_env(env_key)
  end
  def retrieve_runtime_value(k, :instance_role, client) do
    client
    |> ExAws.Config.AuthCache.get
    |> Map.get(k)
  end
  def retrieve_runtime_value(key, values, client) when is_list(values) do
    values
    |> Stream.map(&retrieve_runtime_value(key, &1, client))
    |> Enum.find(&(&1))
  end
  def retrieve_runtime_value(_, value, _), do: value

end
