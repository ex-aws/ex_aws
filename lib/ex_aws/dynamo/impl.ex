defmodule ExAws.Dynamo.Impl do
  alias ExAws.Dynamo
  import ExAws.Utils, only: [camelize_keys: 1, camelize_keys: 2]
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
    client.request(%{}, :list_tables)
  end

  def create_table(client, name, primary_key, key_definitions, read_capacity, write_capacity)
  when is_atom(primary_key) or is_binary(primary_key) do
    key_schema = [%{
      attribute_name: primary_key,
      key_type:       "HASH"
    }]
    create_table(client, name, key_schema, key_definitions, read_capacity, write_capacity)
  end

  def create_table(client, name, key_schema, key_definitions, read_capacity, write_capacity) when is_list(key_schema) do
    create_table(client, name, key_schema, key_definitions, read_capacity, write_capacity, [], [])
  end

  def create_table(client, name, key_schema, key_definitions, read_capacity, write_capacity, global_indexes, local_indexes) do
    data = %{
      "TableName" => name,
      "AttributeDefinitions" => key_definitions |> encode_key_definitions,
      "KeySchema" => key_schema |> Enum.map(&camelize_keys/1),
      "ProvisionedThroughput" => %{
        "ReadCapacityUnits"  => read_capacity,
        "WriteCapacityUnits" => write_capacity
      }
    }
    %{
      "GlobalSecondaryIndexes" => global_indexes |> camelize_keys(deep: true),
      "LocalSecondaryIndexes"  => local_indexes  |> camelize_keys(deep: true)
    } |> Enum.reduce(data, fn
      ({_, indices = %{}}, data) when map_size(indices) == 0 -> data
      {name, indices}, data -> Map.put(data, name, Enum.into(indices, %{}))
    end)
    |> client.request(:create_table)
  end

  def describe_table(client, name) do
    %{"TableName" => name}
    |> client.request(:describe_table)
  end

  def update_table(client, name, attributes) do
    %{"TableName" => name}
    |> Map.merge(camelize_keys(attributes, deep: true))
    |> client.request(:update_table)
  end

  def delete_table(client, table) do
    %{TableName: table}
    |> client.request(:delete_table)
  end

  ## Records
  ######################
  def scan(client, name, opts \\ []) do
    opts = opts |> Enum.into(%{})

    regular_opts = opts
    |> Map.drop(@special_opts)
    |> camelize_keys

    %{"TableName" => name}
    |> build_exclusive_start_key(opts)
    |> build_expression_attribute_names(opts)
    |> build_expression_attribute_values(opts)
    |> build_total_segments(opts)
    |> Map.merge(regular_opts)
    |> client.request(:scan)
  end

  def query(client, name, opts \\ []) do
    opts = opts
    |> Enum.into(%{})

    regular_opts = opts
    |> Map.drop(@special_opts)
    |> camelize_keys

    %{"TableName" => name}
    |> build_exclusive_start_key(opts)
    |> build_expression_attribute_values(opts)
    |> build_select(opts)
    |> Map.merge(regular_opts)
    |> client.request(:query)
  end

  def batch_get_item(client, data) do
    data
    |> Enum.reduce(%{}, fn {table_name, table_query}, query ->
      keys = table_query
      |> Enum.into(%{})
      |> Map.get(:keys)
      |> Enum.map(&encode_values/1)

      dynamized_table_query = table_query
      |> camelize_keys
      |> Map.put("Keys", keys)
      Map.put(query, table_name, dynamized_table_query)
    end)
    |> client.request(:batch_get_item)
  end

  def put_item(client, name, record, opts \\ []) do
    opts
    |> Enum.into(%{})
    |> Map.drop(@special_opts)
    |> build_exclusive_start_key(opts)
    |> build_expression_attribute_values(opts)
    |> build_return_item_collection_metrics(opts)
    |> build_return_values(opts)
    |> Map.merge(%{
      "TableName" => name,
      "Item" => Dynamo.Encoder.encode(record)
    }) |> client.request(:put_item)
  end

  def batch_write_item(client, data) do
    client.request(data, :batch_write_item)
  end

  def get_item(client, name, primary_key) do
    %{
      "TableName" => name,
      "Key" => Dynamo.Encoder.encode_flat(primary_key)
    }
    |> client.request(:get_item)
  end

  def get_item!(client, name, primary_key) do
    {:ok, %{"Item" => item}} = %{
      "TableName" => name,
      "Key" => Dynamo.Encoder.encode_flat(primary_key)
    }
    |> client.request(:get_item)

    item
  end

  def update_item(client, table_name, primary_key, update_args) do
    %{
      "TableName" => table_name,
      "Key" => Dynamo.Encoder.encode_flat(primary_key)
    }
    |> Map.merge(camelize_keys(update_args))
    |> client.request(:update_item)
  end

  def delete_item(client, name, primary_key) do
    %{"TableName" => name, Key: primary_key}
    |> client.request(:delete_item)
  end

  defp encode_key_definitions(attrs) do
    attrs |> Enum.map(fn({name, type}) ->
      %{"AttributeName" => name, "AttributeType" => type |> Dynamo.Encoder.atom_to_dynamo_type}
    end)
  end

  ## Builders for special options
  ###################

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

  ## TODO: metaprogram these upcase ones.

  defp build_total_segments(data, %{total_segments: segments}) do
    Map.put(data, "TotalSegments", segments |> upcase)
  end
  defp build_total_segments(data, _), do: data

  defp build_return_item_collection_metrics(data, %{return_item_collection_metrics: metrics}) do
    Map.put(data, "ReturnItemCollectionMetrics", metrics |> upcase)
  end
  defp build_return_item_collection_metrics(data, _), do: data

  defp build_select(data, %{select: select}) do
    Map.put(data, "Select", select |> upcase)
  end
  defp build_select(data, _), do: data

  defp build_return_values(data, %{return_values: return_values}) do
    Map.put(data, "ReturnValues", return_values |> upcase)
  end
  defp build_return_values(data, _), do: data

  ## Various other helpers
  ################

  defp upcase(value) when is_atom(value) do
    value
    |> Atom.to_string
    |> String.upcase
  end

  defp upcase(value) when is_binary(value) do
    String.upcase(value)
  end

  defp encode_values(dict) do
    Enum.reduce(dict, %{}, fn {attr, value}, attribute_values ->
      Map.put(attribute_values, attr, Dynamo.Encoder.encode(value))
    end)
  end

end
