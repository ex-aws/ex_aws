defmodule ExAws.Dynamo.Client do
  use Behaviour

  @moduledoc """
  Defines a Dynamo Client

  Usage:
  ```
  defmodule MyApp.Dynamo do
    use ExAws.Dynamo.Client, otp_app: :my_otp_app
  end
  ```

  In your config
  ```
  config :my_otp_app, :ex_aws,
    dynamodb: [], # Dynamo config goes here
  ```

  You can now use MyApp.Dynamo as the root module for the Dynamo api without needing
  to pass in a particular configuration.
  This enables different otp apps to configure their AWS configuration separately.

  The alignment with a particular OTP app while convenient is however entirely optional.
  The following also works:

  ```
  defmodule MyApp.Dynamo do
    use ExAws.Dynamo.Client

    def config_root do
      Application.get_all_env(:my_aws_config_root)
    end
  end
  ```
  ExAws now expects the config for that dynamo client to live under

  ```elixir
  config :my_aws_config_root
    dynamodb: [] # Dynamo config goes here
  ```

  Default config values can be found in ExAws.Config.

  http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_Operations.html
  """

  ## Tables
  ######################

  @doc "List tables"
  defcallback list_tables() :: ExAws.Request.response_t

  @doc "Create table"
  defcallback create_table(
    table_name      :: binary,
    primary_key     :: binary,
    key_definitions :: Keyword.t,
    read_capacity   :: pos_integer,
    write_capacity  :: pos_integer) :: ExAws.Request.response_t

  @doc "Create table with indices"
  defcallback create_table(
    table_name      :: binary,
    primary_key     :: binary,
    key_definitions :: [%{}],
    read_capacity   :: pos_integer,
    write_capacity  :: pos_integer,
    global_indexes  :: %{},
    local_indexes   :: %{}) :: ExAws.Request.response_t

  @doc "Describe table"
  defcallback describe_table(name :: binary) :: ExAws.Request.response_t

  @doc "Update Table"
  defcallback update_table(name :: binary, attributes :: %{}) :: ExAws.Request.response_t

  @doc "Delete Table"
  defcallback delete_table(table :: binary) :: ExAws.Request.response_t

  ## Records
  ######################

  @doc "Scan table"
  defcallback scan(table_name :: binary) :: ExAws.Request.response_t
  defcallback scan(table_name :: binary, opts :: %{}) :: ExAws.Request.response_t

  @doc """
  Stream records from table

  Same as scan/1,2 but the records are a stream which will automatically handle pagination
  """
  defcallback stream_scan(table_name :: binary) :: ExAws.Request.response_t
  defcallback stream_scan(table_name :: binary, opts :: %{}) :: ExAws.Request.response_t

  @doc "Query Table"
  defcallback query(table_name :: binary, key_conditions :: %{}) :: ExAws.Request.response_t
  defcallback query(table_name :: binary, key_conditions :: %{}, opts :: %{}) :: ExAws.Request.response_t

  @doc """
  Get up to 100 items (16mb)

  Map of table names to request parameter maps.
  http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_BatchGetItem.html
  """
  defcallback batch_get_item(%{String.t => %{}}) :: ExAws.Request.response_t

  @doc """
  Put or delete up to 25 items (16mb)

  Map of table names to request parameter maps.
  http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_BatchWriteItem.html
  """
  defcallback batch_write_item(%{String.t => %{}}) :: ExAws.Request.response_t

  @doc "Put item in table"
  defcallback put_item(table_name :: binary, record :: %{}) :: ExAws.Request.response_t

  @doc "Get item from table"
  defcallback get_item(table_name :: binary, primary_key_value :: binary) :: ExAws.Request.response_t

  @doc "Get an item from a dynamo table, and raise if it does not exist or there is an error"
  defcallback get_item!(table_name :: binary, primary_key_value :: binary) :: %{}

  @doc """
  Update item in table

  For update_args format see
  http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_UpdateItem.html
  """
  defcallback update_item(table_name :: binary, primary_key_value :: binary, update_args :: %{}) :: ExAws.Request.response_t

  @doc "Delete item in table"
  defcallback delete_item(table_name :: binary, primary_key_value :: binary) :: ExAws.Request.response_t

  @doc """
  Enables custom request handling.

  By default this just forwards the request to the `ExAws.Dynamo.Request.request/2`.
  However, this can be overriden in your client to provide pre-request adjustments to headers, params, etc.
  """
  defcallback request(data :: %{}, action :: atom)

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
      def request(data, action) do
        ExAws.Dynamo.Request.request(__MODULE__, action, data)
      end

      @doc false
      def service, do: :dynamodb

      defoverridable config_root: 0, request: 2
    end
  end

end
