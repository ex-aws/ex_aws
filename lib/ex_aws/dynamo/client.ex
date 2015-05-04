defmodule ExAws.Dynamo.Client do
  use Behaviour

  @moduledoc """
  Defines a Dynamo Client

  By default you can use ExAws.Dynamo

  ## Usage
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

  ## Examples

  ```elixir
  defmodule User do
    @derive [ExAws.Dynamo.Encodable]
    defstruct [:email, :name, :age, :admin]
  end

  alias ExAws.Dynamo

  # Create a users table with a primary key of email [String]
  # and 1 unit of read and write capacity
  Dynamo.create_table("Users", "email", %{email: :string}, 1, 1)

  user = %User{email: "bubba@foo.com", name: "Bubba", age: 23, admin: false}
  # Save the user
  Dynamo.put_item("Users", user)

  # Retrieve the user by email and decode it as a User struct.
  result = Dynamo.get_item!("Users", %{email: user.email})
  |> Dynamo.Decoder.decode(as: User)

  assert user == result
  ```

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
    global_indexes  :: Keyword.t,
    local_indexes   :: Keyword.t) :: ExAws.Request.response_t

  @doc "Describe table"
  defcallback describe_table(name :: binary) :: ExAws.Request.response_t

  @doc "Update Table"
  defcallback update_table(name :: binary, attributes :: Keyword.t) :: ExAws.Request.response_t

  @doc "Delete Table"
  defcallback delete_table(table :: binary) :: ExAws.Request.response_t

  ## Records
  ######################

  @doc "Scan table"
  defcallback scan(table_name :: binary) :: ExAws.Request.response_t
  defcallback scan(table_name :: binary, opts :: Keyword.t) :: ExAws.Request.response_t

  @doc """
  Stream records from table

  Same as scan/1,2 but the records are a stream which will automatically handle pagination
  """
  defcallback stream_scan(table_name :: binary) :: ExAws.Request.response_t
  defcallback stream_scan(table_name :: binary, opts :: Keyword.t) :: ExAws.Request.response_t

  @doc "Query Table"
  defcallback query(table_name :: binary) :: ExAws.Request.response_t
  defcallback query(table_name :: binary, opts :: Keyword.t) :: ExAws.Request.response_t

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
