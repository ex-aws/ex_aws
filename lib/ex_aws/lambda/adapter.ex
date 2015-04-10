defmodule ExAws.Lambda.Adapter do
  use Behaviour

  @doc """
  Adds a permission to the access policy associated with the specified AWS Lambda function

  Action pattern: (lambda:[*]|lambda:[a-zA-Z]+|[*])
  """
  defcallback add_permission(function_name :: binary, principal :: binary, action :: binary, statement_id :: binary) :: %{}
  defcallback add_permission(function_name :: binary, principal :: binary, action :: binary, statement_id :: binary, opts :: %{}) :: %{}

  @doc """
  Creates a stream based event source for a function
  """
  defcallback create_event_source_mapping(
    function_name     :: binary,
    event_source_arn  :: binary,
    starting_position :: binary | :trim_horizon | :latest) :: %{}
  defcallback create_event_source_mapping(
    function_name     :: binary,
    event_source_arn  :: binary,
    starting_position :: binary | :trim_horizon | :latest,
    opts              :: %{}) :: %{}

  @doc """
  Create a function.

  Runtime defaults to nodejs, as that is the only one available.
  """
  defcallback create_function(
    function_name :: binary,
    handler       :: binary,
    zipfile       :: File.Stat.t) :: %{}
  defcallback create_function(
    function_name :: binary,
    handler       :: binary,
    zipfile       :: File.Stat.t,
    opts          :: %{}) :: %{}

  @doc "Delete an event source mapping"
  defcallback delete_event_source_mapping(source_mapping_uuid :: binary) :: %{}

  @doc "Delete a lambda function"
  defcallback delete_function(function_name :: binary) :: %{}

  @doc "Get an event source mapping"
  defcallback get_event_source_mapping(source_mapping_uuid :: binary) :: %{}

  @doc "Get a function"
  defcallback get_function(function_name :: binary) :: %{}

  @doc "Get a function configuration"
  defcallback get_function_configuration(function_name :: binary) :: %{}

  @doc "Get a function access policy"
  defcallback get_policy(function_name :: binary) :: %{}

  @doc "Invoke a lambda function"
  defcallback invoke(function_name :: binary, client_context :: %{}) :: %{}
  defcallback invoke(function_name :: binary, client_context :: %{}, opts :: %{}) :: %{}

  @doc "Invoke a lambda function asynchronously"
  defcallback invoke_async(function_name :: binary, args :: %{}) :: %{}

  @doc "List event source mappings"
  defcallback list_event_source_mappings(function_name :: binary, event_source_arn :: binary) :: %{}
  defcallback list_event_source_mappings(function_name :: binary, event_source_arn :: binary, opts :: %{}) :: %{}

  @doc "List functions"
  defcallback list_functions() :: %{}
  defcallback list_functions(opts :: %{}) :: %{}

  @doc "Remove individual permissions from an function's access policy"
  defcallback remove_permission(function_name :: binary, statement_id :: binary) :: %{}

  @doc "Update event source mapping"
  defcallback update_event_source_mapping(function_name :: binary, uuid :: binary, attrs_to_update :: %{}) :: %{}

  @doc "Update function code"
  defcallback update_function_code(function_name :: binary, zipfile :: File.Stat.t) :: %{}

  @doc "Update a function configuration"
  defcallback update_function_configuration(function_name :: binary, configuration :: %{}) :: %{}

  @doc "Service"
  defcallback service() :: atom

  @doc "Config"
  defcallback config() :: %{}

  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts, behavior_module: __MODULE__] do
      @otp_app Keyword.get(opts, :otp_app)
      @behaviour behavior_module

      @doc false
      def add_permission(function_name, principal, action, statement_id, opts \\ %{}) do
        ExAws.Lambda.add_permission(__MODULE__, function_name, principal, action, statement_id , opts)
      end

      @doc false
      def create_event_source_mapping(function_name, event_source_arn, starting_position, opts \\ %{}) do
        ExAws.Lambda.create_event_source_mapping(__MODULE__, function_name, event_source_arn, starting_position, opts)
      end

      @doc false
      def create_function(function_name, handler, zipfile, opts \\ %{}) do
        ExAws.Lambda.create_function(__MODULE__, function_name, handler, zipfile, opts)
      end

      @doc false
      def delete_event_source_mapping(source_mapping_uuid) do
        ExAws.Lambda.delete_event_source_mapping(__MODULE__, source_mapping_uuid)
      end

      @doc false
      def delete_function(function_name) do
        ExAws.Lambda.delete_function(__MODULE__, function_name)
      end

      @doc false
      def get_event_source_mapping(source_mapping_uuid) do
        ExAws.Lambda.get_event_source_mapping(__MODULE__, source_mapping_uuid)
      end

      @doc false
      def get_function(function_name) do
        ExAws.Lambda.get_function(__MODULE__, function_name)
      end

      @doc false
      def get_function_configuration(function_name) do
        ExAws.Lambda.get_function_configuration(__MODULE__, function_name)
      end

      @doc false
      def get_policy(function_name) do
        ExAws.Lambda.get_policy(__MODULE__, function_name)
      end

      @doc false
      def invoke(function_name, client_context, opts \\ %{}) do
        ExAws.Lambda.invoke(__MODULE__, function_name, client_context, opts)
      end

      @doc false
      def invoke_async(function_name, args) do
        ExAws.Lambda.invoke_async(__MODULE__, function_name, args)
      end

      @doc false
      def list_event_source_mappings(function_name, event_source_arn, opts \\ %{}) do
        ExAws.Lambda.list_event_source_mappings(__MODULE__, function_name, event_source_arn, opts)
      end

      @doc false
      def list_functions(opts \\ %{}) do
        ExAws.Lambda.list_functions(__MODULE__, opts)
      end

      @doc false
      def remove_permission(function_name, statement_id) do
        ExAws.Lambda.remove_permission(__MODULE__, function_name, statement_id)
      end

      @doc false
      def update_event_source_mapping(function_name, uuid, attrs_to_update) do
        ExAws.Lambda.update_event_source_mapping(__MODULE__, function_name, uuid, attrs_to_update)
      end

      @doc false
      def update_function_code(function_name, zipfile) do
        ExAws.Lambda.update_function_code(__MODULE__, function_name, zipfile)
      end

      @doc false
      def update_function_configuration(function_name, configuration) do
        ExAws.Lambda.update_function_configuration(__MODULE__, function_name, configuration)
      end

      @doc false
      def service do
        :lambda
      end

      @doc false
      def config_root, do: Application.get_env(@otp_app, :ex_aws)

      @doc false
      def config do
        __MODULE__ |> ExAws.Config.get
      end

      defoverridable config: 0, config_root: 0
    end
  end

end
