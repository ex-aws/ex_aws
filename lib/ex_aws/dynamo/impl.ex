defmodule ExAws.Dynamo.Impl do
  alias ExAws.Dynamo
  import ExAws.Utils, only: [camelize_keys: 1, camelize_keys: 2, upcase: 1]
  use ExAws.Actions

  @nested_opts [:exclusive_start_key, :expression_attribute_values, :expression_attribute_names]
  @upcase_opts [:return_values, :return_item_collection_metrics, :select, :total_segments]
  @special_opts @nested_opts ++ @upcase_opts


  defdelegate stream_scan(client, name), to: ExAws.Dynamo.Lazy
  defdelegate stream_scan(client, name, opts), to: ExAws.Dynamo.Lazy
  defdelegate stream_query(client, name), to: ExAws.Dynamo.Lazy
  defdelegate stream_query(client, name, opts), to: ExAws.Dynamo.Lazy

  @namespace "DynamoDB_20120810"
  @actions [
    batch_get_item:   :post,
    batch_write_item: :post,
    create_table:     :post,
    delete_item:      :post,
    delete_table:     :post,
    describe_table:   :post,
    get_item:         :post,
    list_tables:      :post,
    put_item:         :post,
    query:            :post,
    scan:             :post,
    update_item:      :post,
    update_table:     :post]

  @moduledoc false
  # Implimentation of the AWS Dynamo API.
  #
  # See ExAws.Dynamo.Client for usage.

  ## Tables
  ######################

  def list_tables(client) do
    request(client, :list_tables, %{})
  end

  def create_table(client, name, primary_key, key_definitions, read_capacity, write_capacity)
  when is_atom(primary_key) or is_binary(primary_key) do
    create_table(client, name, [{primary_key, :hash}], key_definitions, read_capacity, write_capacity)
  end

  def create_table(client, name, key_schema, key_definitions, read_capacity, write_capacity) when is_list(key_schema) do
    create_table(client, name, key_schema, key_definitions, read_capacity, write_capacity, [], [])
  end

  def create_table(client, name, key_schema, key_definitions, read_capacity, write_capacity, global_indexes, local_indexes) do
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

    request(client, :create_table, data)
  end

  defp build_key_schema(key_schema) do
    Enum.map(key_schema, fn({attr, type}) ->
      %{
        "AttributeName" => attr,
        "KeyType" => type |> upcase
      }
    end)
  end

  def describe_table(client, name) do
    request(client, :describe_table, %{"TableName" => name})
  end

  def update_table(client, name, attributes) do
    data = attributes
    |> camelize_keys(deep: true)
    |> Map.merge(%{"TableName" => name})

    request(client, :update_table, data)
  end

  def delete_table(client, table) do
    request(client, :delete_table, %{"TableName" => table})
  end

  ## Records
  ######################
  def scan(client, name, opts \\ []) do
    data = opts
    |> build_opts
    |> Map.merge(%{"TableName" => name})

    request(client, :scan, data)
  end

  def query(client, name, opts \\ []) do
    data = opts
    |> build_opts
    |> Map.merge(%{"TableName" => name})

    request(client, :query, data)
  end

  def batch_get_item(client, data, opts \\ []) do
    request_items = data
    |> Enum.reduce(%{}, fn {table_name, table_query}, query ->
      keys = table_query
      |> Dict.get(:keys)
      |> Enum.map(&encode_values/1)

      dynamized_table_query = table_query
      |> Enum.into(%{})
      |> Map.drop(@special_opts ++ [:keys])
      |> camelize_keys
      |> build_expression_attribute_names(table_query)
      |> Map.put("Keys", keys)

      Map.put(query, table_name, dynamized_table_query)
    end)

    data = opts
    |> camelize_keys
    |> Map.merge(%{"RequestItems" => request_items})

    request(client, :batch_get_item, data)
  end

  def put_item(client, name, record, opts \\ []) do
    data = opts
    |> build_opts
    |> Map.merge(%{
      "TableName" => name,
      "Item" => Dynamo.Encoder.encode_root(record)
    })

    request(client, :put_item, data)
  end

  def batch_write_item(client, data, opts \\ []) do
    request_items = data
    |> Enum.reduce(%{}, fn {table_name, table_queries}, query ->
      queries = table_queries
      |> Enum.map(fn
        [delete_request: [key: primary_key]] ->
          %{"DeleteRequest" => %{"Key" => primary_key |> Dynamo.Encoder.encode}}
        [put_request: [item: item]] ->
          %{"PutRequest" => %{"Item" => Dynamo.Encoder.encode_root(item)}}
      end)
      Map.put(query, table_name, queries)
    end)

    data = opts
    |> camelize_keys
    |> Map.merge(%{"RequestItems" => request_items})

    request(client, :batch_write_item, data)
  end

  def get_item(client, name, primary_key, opts \\ []) do
    data = opts
    |> build_opts
    |> Map.merge(%{
      "TableName" => name,
      "Key" => primary_key |> Enum.into(%{}) |> Dynamo.Encoder.encode_root
    })

    request(client, :get_item, data)
  end

  def get_item!(client, name, primary_key, opts \\ []) do
    {:ok, %{"Item" => item}} = get_item(client, name, primary_key, opts)
    item
  end

  def update_item(client, table_name, primary_key, update_opts) do
    data = update_opts
    |> build_opts
    |> Map.merge(%{
      "TableName" => table_name,
      "Key" => primary_key |> Enum.into(%{}) |> Dynamo.Encoder.encode_root
    })

    request(client, :update_item, data)
  end

  def delete_item(client, name, primary_key, opts \\ []) do
    data = opts
    |> build_opts
    |> Map.merge(%{
      "TableName" => name,
      "Key" => primary_key |> Enum.into(%{}) |> Dynamo.Encoder.encode_root})

    request(client, :delete_item, data)
  end

  defp request(%{__struct__: client_module} = client, action, data) do
    client_module.request(client, action, data)
  end

  ## Options builder
  ###################
  defp build_opts(opts) do
    opts = opts |> Enum.into(%{})

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
    Map.put(data, "ExpressionAttributeNames", names |> Enum.into(%{}))
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
    case Map.get(opts, key) do
      nil -> data
      value ->
        Map.put(data, key, value |> upcase)
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

end
