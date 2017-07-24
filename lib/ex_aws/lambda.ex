defmodule ExAws.Lambda do
  @moduledoc """
  Operations on ExAws Lambda
  """

  import ExAws.Utils, only: [camelize_key: 1, camelize_keys: 1, upcase: 1]
  require Logger

  @actions %{
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
  }

  @type starting_position_vals :: :trim_horizon | :latest

  @type add_permission_opts :: [
    {:source_account, binary} |
    {:source_arn, binary}
  ]

  @doc """
  Adds a permission to the access policy associated with the specified AWS Lambda function

  Action pattern: (lambda:[*]|lambda:[a-zA-Z]+|[*])
  """
  @spec add_permission(
    function_name :: binary,
    principal :: binary,
    action :: binary,
    statement_id :: binary) :: ExAws.Operation.JSON.t
  @spec add_permission(
    function_name :: binary,
    principal :: binary,
    action :: binary,
    statement_id :: binary,
    opts :: add_permission_opts) :: ExAws.Operation.JSON.t
  def add_permission(function_name, principal, action, statement_id, opts \\ []) do
    data = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"      => action,
      "Principal"   => principal,
      "StatementId" => statement_id})
    request(:add_permission, data, "/2015-03-31/functions/#{function_name}/versions/HEAD/policy")
  end

  @type create_event_source_mapping_opts :: [
    {:batch_size, pos_integer} |
    {:enabled, boolean}
  ]
  @doc """
  Creates a stream based event source for a function
  """
  @spec create_event_source_mapping(
    function_name     :: binary,
    event_source_arn  :: binary,
    starting_position :: starting_position_vals) :: ExAws.Operation.JSON.t
  @spec create_event_source_mapping(
    function_name     :: binary,
    event_source_arn  :: binary,
    starting_position :: starting_position_vals,
    opts              :: create_event_source_mapping_opts) :: ExAws.Operation.JSON.t
  def create_event_source_mapping(function_name, event_source_arn, starting_position, opts \\ []) do
    data = opts
    |> normalize_opts
    |> Map.merge(%{
      "FunctionName"     => function_name,
      "EventSourceArn"   => event_source_arn,
      "StartingPosition" => starting_position |> upcase})
    request(:create_event_source_mapping, data, "/2015-03-31/event-source-mappings/")
  end

  @type create_function_opts :: [
    {:description, binary} |
    {:memory_size, pos_integer} |
    {:timeout, pos_integer}
  ]
  @doc """
  Create a function.

  Runtime defaults to nodejs, as that is the only one available.
  """
  @spec create_function(
    function_name :: binary,
    handler       :: binary,
    zipfile       :: binary) :: ExAws.Operation.JSON.t
  @spec create_function(
    function_name :: binary,
    handler       :: binary,
    zipfile       :: binary,
    opts          :: create_function_opts) :: ExAws.Operation.JSON.t
  def create_function(function_name, handler, zipfile, opts \\ []) do
    data = opts
    |> normalize_opts
    |> Map.merge(%{
      "FunctionName" => function_name,
      "Handler"      => handler,
      "Code"         => %{"ZipFile" => zipfile}})
    request(:create_function, data, "/2015-03-31/functions")
  end

  @doc "Delete an event source mapping"
  @spec delete_event_source_mapping(source_mapping_uuid :: binary) :: ExAws.Operation.JSON.t
  def delete_event_source_mapping(source_mapping_uuid) do
    request(:delete_event_source_mapping, %{}, "/2015-03-31/event-source-mappings/#{source_mapping_uuid}")
  end

  @doc "Delete a lambda function"
  @spec delete_function(function_name :: binary) :: ExAws.Operation.JSON.t
  def delete_function(function_name) do
    request(:delete_function, %{}, "/2015-03-31/functions/#{function_name}")
  end

  @doc "Get an event source mapping"
  @spec get_event_source_mapping(source_mapping_uuid :: binary) :: ExAws.Operation.JSON.t
  def get_event_source_mapping(source_mapping_uuid) do
    request(:get_event_source_mapping, %{}, "/2015-03-31/event-source-mappings/#{source_mapping_uuid}")
  end

  @doc "Get a function"
  @spec get_function(function_name :: binary) :: ExAws.Operation.JSON.t
  def get_function(function_name) do
    request(:get_function, %{}, "/2015-03-31/functions/#{function_name}/versions/HEAD")
  end

  @doc "Get a function configuration"
  @spec get_function_configuration(function_name :: binary) :: ExAws.Operation.JSON.t
  def get_function_configuration(function_name) do
    request(:get_function_configuration, %{}, "/2015-03-31/functions/#{function_name}/versions/HEAD/configuration")
  end

  @doc "Get a function access policy"
  @spec get_policy(function_name :: binary) :: ExAws.Operation.JSON.t
  def get_policy(function_name) do
    request(:get_policy, %{}, "/2015-03-31/functions/#{function_name}/versions/HEAD/policy")
  end

  @doc "Invoke a lambda function"
  @type invoke_opts :: [
    {:invocation_type, :event | :request_response | :dry_run} |
    {:log_type, :none | :tail} |
    {:qualifier, String.t}
  ]
  @spec invoke(function_name :: binary, payload :: map(), client_context :: map()) :: ExAws.Operation.JSON.t
  @spec invoke(function_name :: binary, payload :: map(), client_context :: map(), opts :: invoke_opts) :: ExAws.Operation.JSON.t
  @context_header "X-Amz-Client-Context"
  def invoke(function_name, payload, client_context, opts \\ []) do
    {qualifier, opts} = Map.pop(Enum.into(opts, %{}), :qualifier)

    headers = [invocation_type: "X-Amz-Invocation-Type", log_type: "X-Amz-Log-Type"]
    |> Enum.reduce([], fn({opt, header}, headers) ->
      case Map.fetch(opts, opt) do
        :error       -> headers
        {:ok, nil}   -> headers
        {:ok, value} -> [{header, value |> camelize_key} | headers]
      end
    end)

    headers = case client_context do
      %{} ->
        headers
      context ->
        [{@context_header, context} | headers]
    end

    url = "/2015-03-31/functions/#{function_name}/invocations"
    url = if qualifier, do: url <> "?Qualifier=#{qualifier}", else: url

    request(:invoke, payload, url, [], headers, fn operation, config ->
      headers =
        operation.headers
        |> List.keyfind(@context_header, 0, nil)
        |> case do
          nil ->
            operation.headers
          {_, val} ->
            new_val = val |> config.json_codec.encode! |> Base.encode64
            List.keyreplace(operation.headers, @context_header, 0, {@context_header, new_val})
        end

      %{operation | headers: headers}
    end)
  end

  @doc "Invoke a lambda function asynchronously"
  @spec invoke_async(function_name :: binary, args :: map()) :: ExAws.Operation.JSON.t
  def invoke_async(function_name, args) do
    Logger.info("This API is deprecated. See invoke/5 with the Event value set as invocation type")
    request(:invoke, args |> normalize_opts, "/2014-11-13/functions/#{function_name}/invoke-async/")
  end

  @doc "List event source mappings"
  @type list_event_source_mappings_opts :: [
    {:event_source_arn, binary} |
    {:function_name, binary} |
    {:marker, binary} |
    {:max_items, pos_integer}
  ]
  @spec list_event_source_mappings() :: ExAws.Operation.JSON.t
  @spec list_event_source_mappings(opts :: list_event_source_mappings_opts) :: ExAws.Operation.JSON.t
  def list_event_source_mappings(opts \\ []) do
    params = opts
    |> normalize_opts

    request(:list_event_source_mappings, %{}, "/2015-03-31/event-source-mappings/", params)
  end

  @doc "List functions"
  @type list_functions_opts :: [
    {:marker, binary} |
    {:max_items, pos_integer}
  ]
  @spec list_functions() :: ExAws.Operation.JSON.t
  @spec list_functions(opts :: list_functions_opts) :: ExAws.Operation.JSON.t
  def list_functions(opts \\ []) do
    request(:list_functions, %{}, "/2015-03-31/functions/", normalize_opts(opts))
  end

  @doc "Remove individual permissions from an function's access policy"
  @spec remove_permission(function_name :: binary, statement_id :: binary) :: ExAws.Operation.JSON.t
  def remove_permission(function_name, statement_id) do
    request(:remove_permission, %{}, "/2015-03-31/functions/#{function_name}/versions/HEAD/policy/#{statement_id}")
  end

  @doc "Update event source mapping"
  @spec update_event_source_mapping(uuid :: binary, attrs_to_update :: map()) :: ExAws.Operation.JSON.t
  def update_event_source_mapping(uuid, attrs_to_update) do
    request(:update_event_source_mapping, attrs_to_update, "/2015-03-31/event-source-mappings/#{uuid}")
  end

  @doc "Update function code"
  @spec update_function_code(function_name :: binary, zipfile :: binary) :: ExAws.Operation.JSON.t
  def update_function_code(function_name, zipfile) do
    data = %{"ZipFile" => zipfile}
    request(:update_function_code, data, "/2015-03-31/functions/#{function_name}/versions/HEAD/code")
  end

  @doc "Update a function configuration"
  @spec update_function_configuration(function_name :: binary, configuration :: map()) :: ExAws.Operation.JSON.t
  def update_function_configuration(function_name, configuration) do
    data = configuration |> normalize_opts
    request(:update_function_configuration, data, "/2015-03-31/functions/#{function_name}/versions/HEAD/configuration")
  end

  defp normalize_opts(opts) do
    opts
    |> Map.new
    |> camelize_keys
  end

  defp request(action, data, path, params \\ [], headers \\ [], before_request \\ nil) do
    path = [path, "?", params |> URI.encode_query] |> IO.iodata_to_binary
    http_method = @actions |> Map.fetch!(action)
    ExAws.Operation.JSON.new(:lambda, %{
      http_method: http_method,
      path: path,
      data: data,
      headers: [{"content-type", "application/json"} | headers],
      before_request: before_request,
    })
  end
end
