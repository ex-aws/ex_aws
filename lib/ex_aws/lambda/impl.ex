defmodule ExAws.Lambda.Impl do
  use ExAws.Actions
  import ExAws.Utils, only: [camelize_keys: 1, upcase: 1]
  require Logger

  @moduledoc false
  # Implimentation of the AWS Kinesis API.
  #
  # See ExAws.Kinesis.Client for usage.

  @namespace "Lambda"
  @actions [
    add_permission:                :post,
    create_event_source_mapping:   :post,
    create_function:               :post,
    delete_event_source_mapping:   :delete,
    delete_function:               :delete,
    get_event_source_mapping:      :get,
    get_function:                  :get,
    get_function_configuration:    :get,
    get_policy:                    :get,
    invoke:                        :post,
    invoke_async:                  :post,
    list_event_source_mappings:    :get,
    list_functions:                :get,
    remove_permission:             :delete,
    update_event_source_mapping:   :put,
    update_function_code:          :put,
    update_function_configuration: :put
  ]

  def add_permission(client, function_name, principal, action, statement_id, opts \\ []) do
    data = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"      => action,
      "Principal"   => principal,
      "StatementId" => statement_id})
    request(client, :add_permission, data, "/2015-03-31/functions/#{function_name}/versions/HEAD/policy")
  end

  def create_event_source_mapping(client, function_name, event_source_arn, starting_position, opts \\ []) do
    data = opts
    |> normalize_opts
    |> Map.merge(%{
      "FunctionName"     => function_name,
      "EventSourceArn"   => event_source_arn,
      "StartingPosition" => starting_position |> upcase})
    request(client, :create_event_source_mapping, data, "/2015-03-31/event-source-mappings/")
  end

  def create_function(client, function_name, handler, zipfile, opts \\ []) do
    data ,opts
    |> normalize_opts
    |> Map.merge(%{
      "FunctionName" => function_name,
      "Handler"      => handler,
      "Code"         => %{"ZipFile" => zipfile}})
    request(client, :create_function, data, "/2015-03-31/functions")
  end

  def delete_event_source_mapping(client, source_mapping_uuid) do
    request(client, :delete_event_source_mapping, data, "/2015-03-31/event-source-mappings/#{source_mapping_uuid}")
  end

  def delete_function(client, function_name) do
    request(client, :delete_function, data, "/2015-03-31/functions/#{function_name}")
  end

  def get_event_source_mapping(client, source_mapping_uuid) do
    request(client, :get_event_source_mapping, data, "/2015-03-31/event-source-mappings/#{source_mapping_uuid}")
  end

  def get_function(client, function_name) do
    request(client, :get_function, data, "/2015-03-31/functions/#{function_name}/versions/HEAD")
  end

  def get_function_configuration(client, function_name) do
    request(client, :get_function_configuration, data, "/2015-03-31/functions/#{function_name}/versions/HEAD/configuration")
  end

  def get_policy(client, function_name) do
    request(client, :get_policy, data, "/2015-03-31/functions/#{function_name}/versions/HEAD/policy")
  end

  def invoke(client, function_name, payload, client_context, opts \\ []) do
    opts = Enum.into(opts, %{})

    headers = [invocation_type: "X-Amz-Invocation-Type", log_type: "X-Amz-Log-Type"]
    |> Enum.reduce([], fn({opt, header}, headers) ->
      case Map.get(opts, opt) do
        nil -> headers
        value -> [{header, value} |headers]
      end
    end)

    headers = case client_context do
      %{} -> headers
      context ->
        header = {"X-Amz-Client-Context", context |> client.config[:json_codec].encode! |> Base.encode64}
        [header | headers]
    end
    client.request(payload, :invoke, data, "/2015-03-31/functions/#{function_name}/invocations", [], headers)
  end

  def invoke_async(client, function_name, args) do
    Logger.info("This API is deprecated. See invoke/5 with the Event value set as invocation type")
    client.request(args |> normalize_opts, :invoke, data, "/2014-11-13/functions/#{function_name}/invoke-async/")
  end

  def list_event_source_mappings(client, opts \\ []) do
    params = opts
    |> normalize_opts

    request(client, :list_event_source_mappings, data, "/2015-03-31/event-source-mappings/", params)
  end

  def list_functions(client, opts \\ []) do
    request(client, :list_functions, data, "/2015-03-31/functions/", normalize_opts(opts))
  end

  def remove_permission(client, function_name, statement_id) do
    request(client, :remove_permission, data, "/2015-03-31/functions/#{function_name}/versions/HEAD/policy/#{statement_id}")
  end

  def update_event_source_mapping(client, uuid, attrs_to_update) do
    client.request(attrs_to_update, :update_event_source_mapping, data, "/2015-03-31/event-source-mappings/#{uuid}")
  end

  def update_function_code(client, function_name, zipfile) do
    %{"ZipFile" => zipfile}
    request(client, :update_function_code, data, "/2015-03-31/functions/#{function_name}/versions/HEAD/code")
  end

  def update_function_configuration(client, function_name, configuration) do
    client.request(configuration |> normalize_opts, :update_function_configuration, data, "/2015-03-31/functions/#{function_name}/versions/HEAD/configuration")
  end

  defp normalize_opts(opts) do
    opts
    |> Enum.into(%{})
    |> camelize_keys
  end

end
