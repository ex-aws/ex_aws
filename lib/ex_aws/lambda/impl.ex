defmodule ExAws.Lambda.Impl do
  use ExAws.Actions
  import ExAws.Utils, only: [camelize_keys: 1]
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
    opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"      => action,
      "Principal"   => principal,
      "StatementId" => statement_id})
    |> client.request(:add_permission, "/2015-03-31/functions/#{function_name}/versions/HEAD/policy")
  end

  def create_event_source_mapping(client, function_name, event_source_arn, starting_position, opts \\ []) do
    opts
    |> normalize_opts
    |> Map.merge(%{
      "FunctionName"     => function_name,
      "EventSourceArn"   => event_source_arn,
      "StartingPosition" => starting_position})
    |> client.request(:create_event_source_mapping, "/2015-03-31/event-source-mappings/")
  end

  def create_function(client, function_name, handler, zipfile, opts \\ []) do
    opts
    |> normalize_opts
    |> Map.merge(%{
      "FunctionName" => function_name,
      "Handler"      => handler,
      "Code"         => %{"ZipFile" => zipfile}})
    |> client.request(:create_function, "/2015-03-31/functions")
  end

  def delete_event_source_mapping(client, source_mapping_uuid) do
    client.request(%{}, :delete_event_source_mapping, "/2015-03-31/event-source-mappings/#{source_mapping_uuid}")
  end

  def delete_function(client, function_name) do
    client.request(%{}, :delete_function, "/2015-03-31/functions/#{function_name}")
  end

  def get_event_source_mapping(client, source_mapping_uuid) do
    client.request(%{}, :get_event_source_mapping, "/2015-03-31/event-source-mappings/#{source_mapping_uuid}")
  end

  def get_function(client, function_name) do
    client.request(%{}, :get_function, "/2015-03-31/functions/#{function_name}/versions/HEAD")
  end

  def get_function_configuration(client, function_name) do
    client.request(%{}, :get_function_configuration, "/2015-03-31/functions/#{function_name}/versions/HEAD/configuration")
  end

  def get_policy(client, function_name) do
    client.request(%{}, :get_policy, "/2015-03-31/functions/#{function_name}/versions/HEAD/policy")
  end

  def invoke(client, function_name, payload, client_context, opts \\ []) do
    opts = normalize_opts(opts)
    json_codec = client.config[:json_codec]
    headers = [
      {"X-Amz-Invocation-Type", Map.get(opts, :InvocationType, "RequestResponse")},
      {"X-Amz-Log-Type", Map.get(opts, :InvocationType, "RequestResponse")},
    ]
    headers = case client_context do
      %{} -> headers
      context ->
        header = {"X-Amz-Client-Context", context |> json_codec.encode! |> Base.encode64}
        [header | headers]
    end
    client.request(payload, :invoke, "/2015-03-31/functions/#{function_name}/invocations", [], headers)
  end

  def invoke_async(client, function_name, args) do
    Logger.info("This API is deprecated. See invoke/5 with the Event value set as invocation type")
    client.request(args |> normalize_opts, :invoke, "/2014-11-13/functions/#{function_name}/invoke-async/")
  end

  def list_event_source_mappings(client, function_name, event_source_arn, opts \\ []) do
    params = opts
    |> normalize_opts
    |> Map.merge(%{"FunctionName" => function_name, "EventSourceArn" => event_source_arn})
    client.request(%{}, :list_event_source_mappings, "/2015-03-31/event-source-mappings/", params)
  end

  def list_functions(client, opts \\ []) do
    client.request(%{}, :list_functions, "/2015-03-31/functions/", normalize_opts(opts))
  end

  def remove_permission(client, function_name, statement_id) do
    client.request(%{}, :remove_permission, "/2015-03-31/functions/#{function_name}/versions/HEAD/policy/#{statement_id}")
  end

  def update_event_source_mapping(client, uuid, attrs_to_update) do
    client.request(attrs_to_update, :update_event_source_mapping, "/2015-03-31/event-source-mappings/#{uuid}")
  end

  def update_function_code(client, function_name, zipfile) do
    %{ZipFile: zipfile}
    |> client.request(:update_function_code, "/2015-03-31/functions/#{function_name}/versions/HEAD/code")
  end

  def update_function_configuration(client, function_name, configuration) do
    client.request(configuration |> normalize_opts, :update_function_configuration, "/2015-03-31/functions/#{function_name}/versions/HEAD/configuration")
  end

  defp normalize_opts(opts) do
    opts
    |> Enum.into(%{})
    |> camelize_keys
  end

end
