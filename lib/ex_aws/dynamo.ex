defmodule ExAws.Dynamo do
  @moduledoc """
  Operations on the AWS Dynamo service.

  NOTE: When Mix.env in [:test, :dev] dynamo clients will run by default against
  Dynamodb local.

  ## Basic usage
  ```elixir
  defmodule User do
    @derive [ExAws.Dynamo.Encodable]
    defstruct [:email, :name, :age, :admin]
  end

  alias ExAws.Dynamo

  # Create a users table with a primary key of email [String]
  # and 1 unit of read and write capacity
  Dynamo.create_table("Users", "email", %{email: :string}, 1, 1)
  |> ExAws.request!

  user = %User{email: "bubba@foo.com", name: "Bubba", age: 23, admin: false}
  # Save the user
  Dynamo.put_item("Users", user) |> ExAws.request!

  # Retrieve the user by email and decode it as a User struct.
  result = Dynamo.get_item("Users", %{email: user.email})
  |> ExAws.request!
  |> Dynamo.decode_item(as: User)

  assert user == result
  ```

  ## General notes
  All options are handled as underscored atoms instead of camelcased binaries as specified
  in the Dynamo API. IE `IndexName` would be `:index_name`. Anywhere in the API that requires
  dynamo type annotation (`{"S":"mystring"}`) is handled for you automatically. IE

  ```elixir
  ExAws.Dynamo.scan("Users", expression_attribute_values: [api_key: "foo"])
  ```
  Transforms into a query of
  ```elixir
  %{"ExpressionAttributeValues" => %{api_key: %{"S" => "foo"}}, "TableName" => "Users"}
  ```

  Consult the function documentation to see precisely which options are handled this way.

  If you wish to avoid this kind of automatic behaviour you are free to specify the types yourself.
  IE:
  ```elixir
  ExAws.Dynamo.scan("Users", expression_attribute_values: [api_key: %{"B" => "Treated as binary"}])
  ```
  Becomes:
  ```elixir
  %{"ExpressionAttributeValues" => %{api_key: %{"B" => "Treated as binary"}}, "TableName" => "Users"}
  ```
  Alternatively, if what's being encoded is a struct, you're always free to implement ExAws.Dynamo.Encodable for that struct.

  http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_Operations.html
  """

  import ExAws.Utils, only: [camelize_keys: 1, camelize_keys: 2, upcase: 1]
  alias __MODULE__

  @nested_opts [:exclusive_start_key, :expression_attribute_values, :expression_attribute_names]
  @upcase_opts [:return_values, :return_item_collection_metrics, :select, :total_segments]
  @special_opts @nested_opts ++ @upcase_opts

  @namespace "DynamoDB_20120810"

  ## Tables
  ######################

  @type table_name :: binary
  @type primary_key :: [{atom, binary}] | %{atom => binary}
  @type exclusive_start_key_vals :: [{atom, binary}] | %{atom => binary}
  @type expression_attribute_names_vals :: %{binary => binary}
  @type expression_attribute_values_vals :: [{atom, binary}] | %{atom => binary}
  @type return_consumed_capacity_vals ::
    :none |
    :total |
    :indexes
  @type select_vals ::
    :all_attributes |
    :all_projected_attributes |
    :specific_attributes |
    :count
  @type return_values_vals ::
    :none |
    :all_old |
    :updated_old |
    :all_new |
    :updated_new
  @type return_item_collection_metrics_vals ::
    :size |
    :none
  @type dynamo_type_names :: :blob
    | :boolean
    | :blob_set
    | :list
    | :map
    | :number_set
    | :null
    | :number
    | :string
    | :string_set

  @type key_schema :: [{atom | binary, :hash | :range}, ...]
  @type key_definitions :: [{atom | binary, dynamo_type_names}, ...]

  @doc """
  Decode an item returned from Dynamo. This will handle items wrapped in the ordinary
  `get_item` response map of `%{"Item" => item}`.

  ## Example
  ```elixir
  Dynamo.get_item("users", %{id: "asdf"})
  |> ExAws.request!
  |> Dynamo.decode_item(as: User)
  ```
  """
  @spec decode_item(Map.t) :: Map.t
  @spec decode_item(Map.t, as: atom) :: Map.t
  def decode_item(item, opts \\ [])
  def decode_item(%{"Item" => item}, opts) do
    decode_item(item, opts)
  end
  def decode_item(item, opts) do
    ExAws.Dynamo.Decoder.decode(item, opts)
  end

  @doc "List tables"
  @spec list_tables() :: ExAws.Operation.JSON.t
  def list_tables() do
    request(:list_tables, %{})
  end

  @doc """
  Create table

  key_schema can be a simple binary or atom indicating a simple hash key
  """
  @spec create_table(
    table_name      :: binary,
    key_schema      :: binary | atom | key_schema,
    key_definitions :: key_definitions,
    read_capacity   :: pos_integer,
    write_capacity  :: pos_integer) :: ExAws.Operation.JSON.t
  def create_table(name, primary_key, key_definitions, read_capacity, write_capacity)
  when is_atom(primary_key) or is_binary(primary_key) do
    create_table(name, [{primary_key, :hash}], key_definitions, read_capacity, write_capacity)
  end
  def create_table(name, key_schema, key_definitions, read_capacity, write_capacity) when is_list(key_schema) do
    create_table(name, key_schema, key_definitions, read_capacity, write_capacity, [], [])
  end

  @doc """
  Create table with secondary indices

  Each index should follow the format outlined here: http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_CreateTable.html

  For convenience, the keys in each index map are allowed to be atoms. IE:
  `"KeySchema"` in the aws docs can be `key_schema:`

  Note that both the `global_indexes` and `local_indexes` arguments expect a list of such indices.

  Examples
  ```
  secondary_index = [%{
    index_name: "my-global-index",
    key_schema: [%{
      attribute_name: "email",
      key_type: "HASH",
    }],
    provisioned_throughput: %{
      read_capacity_units: 1,
      write_capacity_units: 1,
    },
    projection: %{
      projection_type: "KEYS_ONLY",
    }
  }]
  create_table("TestUsers", [id: :hash], %{id: :string, email: :string}, 1, 1, secondary_index, [])
  ```

  """
  @spec create_table(
    table_name      :: binary,
    key_schema      :: key_schema,
    key_definitions :: key_definitions,
    read_capacity   :: pos_integer,
    write_capacity  :: pos_integer,
    global_indexes  :: [Map.t],
    local_indexes   :: [Map.t]) :: ExAws.ExAws.Operation.JSON.t
  def create_table(name, key_schema, key_definitions, read_capacity, write_capacity, global_indexes, local_indexes) do
    data = %{
      "TableName" => name,
      "AttributeDefinitions" => key_definitions |> encode_key_definitions,
      "KeySchema" => key_schema |> build_key_schema,
      "ProvisionedThroughput" => %{
        "ReadCapacityUnits"  => read_capacity,
        "WriteCapacityUnits" => write_capacity
      }
    }
    data = %{
      "GlobalSecondaryIndexes" => global_indexes |> Enum.map(&camelize_keys(&1, deep: true)),
      "LocalSecondaryIndexes"  => local_indexes  |> Enum.map(&camelize_keys(&1, deep: true))
    } |> Enum.reduce(data, fn
      {_, []}, data -> data
      {name, indices}, data ->
        Map.put(data, name, indices)
    end)

    request(:create_table, data)
  end

  defp build_key_schema(key_schema) do
    Enum.map(key_schema, fn({attr, type}) ->
      %{
        "AttributeName" => attr,
        "KeyType" => type |> upcase
      }
    end)
  end

  @doc "Describe table"
  @spec describe_table(name :: binary) :: ExAws.Operation.JSON.t
  def describe_table(name) do
    request(:describe_table, %{"TableName" => name})
  end

  @doc "Update Table"
  @spec update_table(name :: binary, attributes :: Keyword.t) :: ExAws.Operation.JSON.t
  def update_table(name, attributes) do
    data = attributes
    |> camelize_keys(deep: true)
    |> Map.merge(%{"TableName" => name})

    request(:update_table, data)
  end

  @doc "Delete Table"
  @spec delete_table(table :: binary) :: ExAws.Operation.JSON.t
  def delete_table(table) do
    request(:delete_table, %{"TableName" => table})
  end

  ## Records
  ######################
  @doc """
  Scan table

  Please read http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_Scan.html

  ```
  Dynamo.scan("Users"
    limit: 1,
    expression_attribute_values: [desired_api_key: "adminkey"],
    expression_attribute_names: %{"#asdf" => "api_key"},
    filter_expression: "#asdf = :desired_api_key")
  ```

  Generally speaking you won't need to use `:expression_attribute_names`. It exists
  to alias a column name if one of the columns you want to search against is a reserved dynamo word,
  like `Percentile`. In this case it's totally unnecessary as `api_key` is not a reserved word.

  Parameters with keys that are automatically annotated with dynamo types are:
  `[:exclusive_start_key, :expression_attribute_names]`
  """
  @type scan_opts :: [
    {:exclusive_start_key, exclusive_start_key_vals} |
    {:expression_attribute_names, expression_attribute_names_vals} |
    {:expression_attribute_values, expression_attribute_values_vals} |
    {:filter_expression, binary} |
    {:index_name, binary} |
    {:limit, pos_integer} |
    {:projection_expression, binary} |
    {:return_consumed_capacity, return_consumed_capacity_vals} |
    {:segment, non_neg_integer} |
    {:select, select_vals} |
    {:total_segments, pos_integer}]
  @spec scan(table_name :: table_name) :: ExAws.Operation.JSON.t
  @spec scan(table_name :: table_name, opts :: scan_opts) :: ExAws.Operation.JSON.t
  def scan(name, opts \\ []) do
    data = opts
    |> build_opts
    |> Map.merge(%{"TableName" => name})

    request(:scan, data, %{stream_builder: &ExAws.Dynamo.Lazy.stream_scan(name, opts, &1)})
  end

  @doc """
  Query Table

  Please read: http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_Query.html

  ```
  Dynamo.query("Users",
    limit: 1,
    expression_attribute_values: [desired_api_key: "adminkey"],
    key_condition_expression: "api_key = :desired_api_key")
  ```

  Parameters with keys that are automatically annotated with dynamo types are:
  `[:exclusive_start_key, :expression_attribute_names]`
  """
  @type query_opts :: [
    {:consistent_read, boolean} |
    {:exclusive_start_key, exclusive_start_key_vals} |
    {:expression_attribute_names, expression_attribute_names_vals} |
    {:expression_attribute_values, expression_attribute_values_vals} |
    {:filter_expression, binary} |
    {:index_name, binary} |
    {:key_condition_expression, binary} |
    {:limit, pos_integer} |
    {:projection_expression, binary} |
    {:return_consumed_capacity, return_consumed_capacity_vals} |
    {:scan_index_forward, boolean} |
    {:select, select_vals}]
  @spec query(table_name :: table_name) :: ExAws.Operation.JSON.t
  @spec query(table_name :: table_name, opts :: query_opts) :: ExAws.Operation.JSON.t
  def query(name, opts \\ []) do
    data = opts
    |> build_opts
    |> Map.merge(%{"TableName" => name})

    request(:query, data, %{stream_builder: &ExAws.Dynamo.Lazy.stream_query(name, opts, &1)})
  end

  @doc """
  Get up to 100 items (16mb)

  Map of table names to request parameter maps.
  http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_BatchGetItem.html

  Parameters with keys that are automatically annotated with dynamo types are:
  `[:keys]`

  ```elixir
  Dynamo.batch_get_item(%{
    "Users" => [
      consistent_read: true,
      keys: [
        [api_key: "key1"],
        [api_key: "api_key2"]
      ]
    ],
    "Subscriptions" => %{
      keys: [
        %{id: "id1"}
      ]
    }
  })
  ```
  As you see you're largely free to use either keyword args or maps in the body. A map
  is required for the argument itself because the table names are most often binaries, and I refuse
  to inflict proplists on anyone.

  """
  @type batch_get_item_opts :: [
    {:return_consumed_capacity, return_consumed_capacity_vals}
  ]
  @type get_item :: [
    {:consistent_read, boolean} |
    {:keys, [primary_key]}
  ]
  @spec batch_get_item(%{table_name => get_item}) :: ExAws.Operation.JSON.t
  @spec batch_get_item(%{table_name => get_item}, opts :: batch_get_item_opts) :: ExAws.Operation.JSON.t
  def batch_get_item(data, opts \\ []) do
    request_items = data
    |> Enum.reduce(%{}, fn {table_name, table_query}, query ->
      keys = table_query[:keys]
      |> Enum.map(&encode_values/1)

      dynamized_table_query = table_query
      |> Map.new
      |> Map.drop(@special_opts ++ [:keys])
      |> camelize_keys
      |> build_expression_attribute_names(table_query)
      |> Map.put("Keys", keys)

      Map.put(query, table_name, dynamized_table_query)
    end)

    data = opts
    |> camelize_keys
    |> Map.merge(%{"RequestItems" => request_items})

    request(:batch_get_item, data)
  end

  @doc "Put item in table"
  @type put_item_opts :: [
    {:condition_expression, binary} |
    {:expression_attribute_names, expression_attribute_names_vals} |
    {:expression_attribute_values, expression_attribute_values_vals} |
    {:return_consumed_capacity, return_consumed_capacity_vals} |
    {:return_item_collection_metrics, return_item_collection_metrics_vals } |
    {:return_values, return_values_vals}
  ]
  @spec put_item(table_name :: table_name, record :: map()) :: ExAws.Operation.JSON.t
  @spec put_item(table_name :: table_name, record :: map(), opts :: put_item_opts) :: ExAws.Operation.JSON.t
  def put_item(name, record, opts \\ []) do
    data = opts
    |> build_opts
    |> Map.merge(%{
      "TableName" => name,
      "Item" => Dynamo.Encoder.encode_root(record)
    })

    request(:put_item, data)
  end

  @doc """
  Put or delete up to 25 items (16mb)

  Map of table names to request parameter maps.
  http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_BatchWriteItem.html

  Parameters with keys that are automatically annotated with dynamo types are:
  `[:keys]`
  """
  @type write_item :: [
    [delete_request: [key: primary_key]] |
    [put_request: [item: map()]]
  ]
  @type batch_write_item_opts :: [
    {:return_consumed_capacity, return_consumed_capacity_vals} |
    {:return_item_collection_metrics, return_item_collection_metrics_vals}
  ]
  @spec batch_write_item(%{table_name => [write_item]}) :: ExAws.Operation.JSON.t
  @spec batch_write_item(%{table_name => [write_item]}, opts :: batch_write_item_opts) :: ExAws.Operation.JSON.t
  def batch_write_item(data, opts \\ []) do
    request_items = data
    |> Enum.reduce(%{}, fn {table_name, table_queries}, query ->
      queries = table_queries
      |> Enum.map(fn
        [delete_request: [key: primary_key]] ->
          %{"DeleteRequest" => %{"Key" => primary_key |> Dynamo.Encoder.encode_root}}
        [put_request: [item: item]] ->
          %{"PutRequest" => %{"Item" => Dynamo.Encoder.encode_root(item)}}
      end)
      Map.put(query, table_name, queries)
    end)

    data = opts
    |> camelize_keys
    |> Map.merge(%{"RequestItems" => request_items})

    request(:batch_write_item, data)
  end

  @doc "Get item from table"
  @type get_item_opts :: [
    {:consistent_read, boolean} |
    {:expression_attribute_names, expression_attribute_names_vals} |
    {:projection_expression, binary} |
    {:return_consumed_capacity, return_consumed_capacity_vals}
  ]
  @spec get_item(table_name :: table_name, primary_key :: primary_key) :: ExAws.Operation.JSON.t
  @spec get_item(table_name :: table_name, primary_key :: primary_key, opts :: get_item_opts) :: ExAws.Operation.JSON.t
  def get_item(name, primary_key, opts \\ []) do
    data = opts
    |> build_opts
    |> Map.merge(%{
      "TableName" => name,
      "Key" => primary_key |> Map.new |> Dynamo.Encoder.encode_root
    })

    request(:get_item, data)
  end

  @doc """
  Update item in table

  For update_args format see
  http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_UpdateItem.html
  """
  @type update_item_opts :: [
    {:condition_expression, binary} |
    {:expression_attribute_names, expression_attribute_names_vals} |
    {:expression_attribute_values, expression_attribute_values_vals} |
    {:return_consumed_capacity, return_consumed_capacity_vals} |
    {:return_item_collection_metrics, return_item_collection_metrics_vals } |
    {:return_values, return_values_vals } |
    {:update_expression, binary}
  ]
  @spec update_item(table_name :: table_name, primary_key :: primary_key, opts :: update_item_opts) :: ExAws.Operation.JSON.t
  def update_item(table_name, primary_key, update_opts) do
    data = update_opts
    |> build_opts
    |> Map.merge(%{
      "TableName" => table_name,
      "Key" => primary_key |> Map.new |> Dynamo.Encoder.encode_root
    })

    request(:update_item, data)
  end

  @doc "Delete item in table"
  @type delete_item_opts :: [
    {:condition_expression, binary} |
    {:expression_attribute_names, expression_attribute_names_vals} |
    {:expression_attribute_values, expression_attribute_values_vals} |
    {:return_consumed_capacity, return_consumed_capacity_vals} |
    {:return_item_collection_metrics, return_item_collection_metrics_vals } |
    {:return_values, return_values_vals}
  ]
  @spec delete_item(table_name :: table_name, primary_key :: primary_key) :: ExAws.Operation.JSON.t
  @spec delete_item(table_name :: table_name, primary_key :: primary_key, opts :: delete_item_opts) :: ExAws.Operation.JSON.t
  def delete_item(name, primary_key, opts \\ []) do
    data = opts
    |> build_opts
    |> Map.merge(%{
      "TableName" => name,
      "Key" => primary_key |> Map.new |> Dynamo.Encoder.encode_root})

    request(:delete_item, data)
  end

  ## Options builder
  ###################
  defp build_opts(opts) do
    opts = opts |> Map.new

    opts
    |> Map.drop(@special_opts)
    |> add_upcased_opt(opts, :total_segments)
    |> add_upcased_opt(opts, :return_item_collection_metrics)
    |> add_upcased_opt(opts, :select)
    |> add_upcased_opt(opts, :return_values)
    |> add_upcased_opt(opts, :return_consumed_capacity)
    |> camelize_keys
    |> build_special_opts(opts)
  end

  ## Builders for special options
  ################################

  defp build_special_opts(data, opts) do
    data
    |> build_exclusive_start_key(opts)
    |> build_expression_attribute_names(opts)
    |> build_expression_attribute_values(opts)
  end

  defp build_exclusive_start_key(data, %{exclusive_start_key: start_key}) do
    Map.put(data, "ExclusiveStartKey", start_key |> encode_values)
  end
  defp build_exclusive_start_key(data, _), do: data

  defp build_expression_attribute_names(data, %{expression_attribute_names: names}) do
    Map.put(data, "ExpressionAttributeNames", names |> Map.new)
  end
  defp build_expression_attribute_names(data, _), do: data

  defp build_expression_attribute_values(data, %{expression_attribute_values: values}) do
    values = values
    |> encode_values
    |> Enum.reduce(%{}, fn {k ,v}, map ->
      Map.put(map, ":#{k}", v)
    end)
    Map.put(data, "ExpressionAttributeValues", values)
  end
  defp build_expression_attribute_values(data, _), do: data

  ## Various other helpers
  ################

  defp add_upcased_opt(data, opts, key) do
    case Map.fetch(opts, key) do
      :error     -> data
      {:ok, nil} -> data
      {:ok, v}   -> Map.put(data, key, v |> upcase)
    end
  end

  defp encode_values(dict) do
    Enum.reduce(dict, %{}, fn {attr, value}, attribute_values ->
      Map.put(attribute_values, attr, Dynamo.Encoder.encode(value))
    end)
  end

  defp encode_key_definitions(attrs) do
    attrs |> Enum.map(fn({name, type}) ->
      %{"AttributeName" => name, "AttributeType" => type |> Dynamo.Encoder.atom_to_dynamo_type}
    end)
  end

  defp request(op, data, opts \\ %{}) do
    operation =
      op
      |> Atom.to_string
      |> Macro.camelize

    ExAws.Operation.JSON.new(:dynamodb, %{
      data: data,
      headers: [
        {"x-amz-target", "#{@namespace}.#{operation}"},
        {"content-type", "application/x-amz-json-1.0"},
      ]
    } |> Map.merge(opts))
  end

end
