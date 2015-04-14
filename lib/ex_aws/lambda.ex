defmodule ExAws.Lambda do
  use ExAws.Actions
  use ExAws.Lambda.Adapter
  import ExAws.Lambda.Request
  require Logger

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


  def add_permission(adapter, function_name, principal, action, statement_id, opts) do
    opts
    |> Map.merge(%{Action: action, Principal: principal, StatementId: statement_id})
    |> request(:add_permission, "/2015-03-31/functions/#{function_name}/versions/HEAD/policy", adapter)
  end

  def create_event_source_mapping(adapter, function_name, event_source_arn, starting_position, opts) do
    opts
    |> Map.merge(%{
      FunctionName:     function_name,
      EventSourceArn:   event_source_arn,
      StartingPosition: starting_position})
    |> request(:create_event_source_mapping, "/2015-03-31/event-source-mappings/", adapter)
  end

  def create_function(adapter, function_name, handler, zipfile, opts) do
    opts
    |> Map.merge(%{
      FunctionName: function_name,
      Handler: handler,
      Code: %{ZipFile: zipfile}})
    |> request(:create_function, "/2015-03-31/functions", adapter)
  end

  def delete_event_source_mapping(adapter, source_mapping_uuid) do
    request(%{}, :delete_event_source_mapping, "/2015-03-31/event-source-mappings/#{source_mapping_uuid}", adapter)
  end

  def delete_function(adapter, function_name) do
    request(%{}, :delete_function, "/2015-03-31/functions/#{function_name}", adapter)
  end

  def get_event_source_mapping(adapter, source_mapping_uuid) do
    request(%{}, :get_event_source_mapping, "/2015-03-31/event-source-mappings/#{source_mapping_uuid}", adapter)
  end

  def get_function(adapter, function_name) do
    request(%{}, :get_function, "/2015-03-31/functions/#{function_name}/versions/HEAD", adapter)
  end

  def get_function_configuration(adapter, function_name) do
    request(%{}, :get_function_configuration, "/2015-03-31/functions/#{function_name}/versions/HEAD/configuration", adapter)
  end

  def get_policy(adapter, function_name) do
    request(%{}, :get_policy, "/2015-03-31/functions/#{function_name}/versions/HEAD/policy", adapter)
  end

  def invoke(adapter, function_name, payload, client_context, opts) do
    json_codec = adapter.config[:json_codec]
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
    request(payload, :invoke, "/2015-03-31/functions/#{function_name}/invocations", adapter, [], headers)
  end

  def invoke_async(adapter, function_name, args) do
    Logger.info("This API is deprecated. See invoke/5 with the Event value set as invocation type")
    request(args, :invoke, "/2014-11-13/functions/#{function_name}/invoke-async/", adapter)
  end

  def list_event_source_mappings(adapter, function_name, event_source_arn, opts) do
    params = opts
    |> Map.merge(%{FunctionName: function_name, EventSourceArn: event_source_arn})
    request(%{}, :list_event_source_mappings, "/2015-03-31/event-source-mappings/", adapter, params)
  end

  def list_functions(adapter, opts) do
    request(%{}, :list_functions, "/2015-03-31/functions/", adapter, opts)
  end

  def remove_permission(adapter, function_name, statement_id) do
    request(%{}, :remove_permission, "/2015-03-31/functions/#{function_name}/versions/HEAD/policy/#{statement_id}", adapter)
  end

  def update_event_source_mapping(adapter, uuid, attrs_to_update) do
    request(attrs_to_update, :update_event_source_mapping, "/2015-03-31/event-source-mappings/#{uuid}", adapter)
  end

  def update_function_code(adapter, function_name, zipfile) do
    %{ZipFile: zipfile}
    |> request(:update_function_code, "/2015-03-31/functions/#{function_name}/versions/HEAD/code", adapter)
  end

  def update_function_configuration(adapter, function_name, configuration) do
    request(configuration, :update_function_configuration, "/2015-03-31/functions/#{function_name}/versions/HEAD/configuration", adapter)
  end

  def config_root, do: Application.get_all_env(:ex_aws)

end
