defmodule ExAws.Lambda.Client do
  use Behaviour

  @moduledoc """
  The purpose of this module is to surface the ExAws.Lambda API with a single
  configuration chosen, such that it does not need passed in with every request.

  Usage:
  ```
  defmodule MyApp.Lambda do
    use ExAws.Lambda.Client, otp_app: :my_otp_app
  end
  ```

  In your config
  ```
  config :my_otp_app, ExAws,
    lambda: [], # lambda config goes here
  ```

  You can now use MyApp.Lambda as the module for the Lambda api without needing
  to pass in a particular configuration.
  This enables different otp apps to configure their AWS configuration separately.

  The alignment with a particular OTP app however is entirely optional.
  The following also works:

  ```
  defmodule MyApp.Lambda do
    use ExAws.Lambda.Client

    def config_root do
      Application.get_all_env(:my_aws_config_root)
    end
  end
  ```
  ExAws now expects the config for that lambda client to live under

  ```elixir
  config :my_aws_config_root
    lambda: [] # Lambda config goes here
  ```

  Default config values can be found in ExAws.Config

  http://docs.aws.amazon.com/kinesis/latest/APIReference/API_Operations.html
  """

  @doc """
  Adds a permission to the access policy associated with the specified AWS Lambda function

  Action pattern: (lambda:[*]|lambda:[a-zA-Z]+|[*])
  """
  defcallback add_permission(function_name :: binary, principal :: binary, action :: binary, statement_id :: binary) :: ExAws.Request.response_t
  defcallback add_permission(function_name :: binary, principal :: binary, action :: binary, statement_id :: binary, opts :: Keyword.t) :: ExAws.Request.response_t

  @doc """
  Creates a stream based event source for a function
  """
  defcallback create_event_source_mapping(
    function_name     :: binary,
    event_source_arn  :: binary,
    starting_position :: binary | :trim_horizon | :latest) :: ExAws.Request.response_t
  defcallback create_event_source_mapping(
    function_name     :: binary,
    event_source_arn  :: binary,
    starting_position :: binary | :trim_horizon | :latest,
    opts              :: %{}) :: ExAws.Request.response_t

  @doc """
  Create a function.

  Runtime defaults to nodejs, as that is the only one available.
  """
  defcallback create_function(
    function_name :: binary,
    handler       :: binary,
    zipfile       :: File.Stat.t) :: ExAws.Request.response_t
  defcallback create_function(
    function_name :: binary,
    handler       :: binary,
    zipfile       :: File.Stat.t,
    opts          :: %{}) :: ExAws.Request.response_t

  @doc "Delete an event source mapping"
  defcallback delete_event_source_mapping(source_mapping_uuid :: binary) :: ExAws.Request.response_t

  @doc "Delete a lambda function"
  defcallback delete_function(function_name :: binary) :: ExAws.Request.response_t

  @doc "Get an event source mapping"
  defcallback get_event_source_mapping(source_mapping_uuid :: binary) :: ExAws.Request.response_t

  @doc "Get a function"
  defcallback get_function(function_name :: binary) :: ExAws.Request.response_t

  @doc "Get a function configuration"
  defcallback get_function_configuration(function_name :: binary) :: ExAws.Request.response_t

  @doc "Get a function access policy"
  defcallback get_policy(function_name :: binary) :: ExAws.Request.response_t

  @doc "Invoke a lambda function"
  defcallback invoke(function_name :: binary, payload :: %{}, client_context :: %{}) :: ExAws.Request.response_t
  defcallback invoke(function_name :: binary, payload :: %{}, client_context :: %{}, opts :: Keyword.t) :: ExAws.Request.response_t

  @doc "Invoke a lambda function asynchronously"
  defcallback invoke_async(function_name :: binary, args :: %{}) :: ExAws.Request.response_t

  @doc "List event source mappings"
  defcallback list_event_source_mappings(function_name :: binary, event_source_arn :: binary) :: ExAws.Request.response_t
  defcallback list_event_source_mappings(function_name :: binary, event_source_arn :: binary, opts :: Keyword.t) :: ExAws.Request.response_t

  @doc "List functions"
  defcallback list_functions() :: ExAws.Request.response_t
  defcallback list_functions(opts :: Keyword.t) :: ExAws.Request.response_t

  @doc "Remove individual permissions from an function's access policy"
  defcallback remove_permission(function_name :: binary, statement_id :: binary) :: ExAws.Request.response_t

  @doc "Update event source mapping"
  defcallback update_event_source_mapping(uuid :: binary, attrs_to_update :: %{}) :: ExAws.Request.response_t

  @doc "Update function code"
  defcallback update_function_code(function_name :: binary, zipfile :: File.Stat.t) :: ExAws.Request.response_t

  @doc "Update a function configuration"
  defcallback update_function_configuration(function_name :: binary, configuration :: %{}) :: ExAws.Request.response_t

  @doc """
  Enables custom request handling.

  By default this just forwards the request to the ExAws.Lambda.Request.request/4.
  However, this can be overriden in your client to provide pre-request adjustments to headers, params, etc.
  """
  defcallback request(data :: %{}, action :: atom, path :: binary)
  defcallback request(data :: %{}, action :: atom, path :: binary, params :: Dict.t)
  defcallback request(data :: %{}, action :: atom, path :: binary, params :: Dict.t, headers :: [{binary, binary}, ...])

  @doc "Service"
  defcallback service() :: atom

  @doc "Retrieves the root AWS config for this client"
  defcallback config_root() :: Keyword.t

  @doc "Returns the canonical configuration for this service"
  defcallback config() :: Keyword.t

  defmacro __using__(opts) do
    boilerplate = __MODULE__
    |> ExAws.Client.generate_boilerplate(opts)

    quote do
      unquote(boilerplate)

      @doc false
      def request(data, action, path, params \\ [], headers \\ []) do
        ExAws.Lambda.Request.request(__MODULE__, action, path, data, params, headers)
      end

      @doc false
      def service, do: :lambda

      defoverridable config_root: 0, request: 3, request: 4, request: 5
    end
  end

end
