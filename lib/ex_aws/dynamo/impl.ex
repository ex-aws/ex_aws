defmodule ExAws.Dynamo.Impl do
  alias ExAws.Dynamo
  import ExAws.Utils, only: [camelize_keys: 1, camelize_keys: 2]
  use ExAws.Actions


  defdelegate stream_scan(client, name), to: ExAws.Dynamo.Lazy
  defdelegate stream_scan(client, name, opts), to: ExAws.Dynamo.Lazy

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

  def create_table(client, name, primary_key, key_definitions, read_capacity, write_capacity) when is_atom(primary_key) do
    key_schema = [%{
      attribute_name: primary_key,
      key_type:       "HASH"
    }]
    create_table(client, name, key_schema, key_definitions, read_capacity, write_capacity)
  end

  def create_table(client, name, key_schema, key_definitions, read_capacity, write_capacity) when is_list(key_schema) do
    create_table(client, name, key_schema, key_definitions, read_capacity, write_capacity)
  end

  def create_table(client, name, key_schema, key_definitions, read_capacity, write_capacity, global_indexes, local_indexes) do
    data = %{
      "TableName" => name,
      "AttributeDefinitions" => key_definitions |> encode_key_definitions,
      "KeySchema" => key_schema |> camelize_keys,
      "ProvisionedThroughput" => %{
        "ReadCapacityUnits"  => read_capacity,
        "WriteCapacityUnits" => write_capacity
      }
    }
    %{
      "GlobalSecondaryIndexes" => global_indexes |> camelize_keys(deep: true),
      "LocalSecondaryIndexes"  => local_indexes  |> camelize_keys(deep: true)
    } |> Enum.reduce(data, fn
      {_, []}, data -> data
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
    special_opts = [:exclusive_start_key, :expression_attribute_values]

    regular_opts = opts
    |> Map.drop(special_opts)
    |> camelize_keys

    %{"TableName" => name}
    |> build_exclusive_start_key(opts)
    |> build_expression_attribute_values(opts)
    |> Map.merge(regular_opts)
    |> client.request(:scan)
  end

  def query(client, name, opts \\ []) do
    opts = opts |> Enum.into(%{})
    special_opts = [:exclusive_start_key, :expression_attribute_values]

    regular_opts = opts
    |> Map.drop(special_opts)
    |> camelize_keys

    %{"TableName" => name}
    |> build_exclusive_start_key(opts)
    |> build_expression_attribute_values(opts)
    |> Map.merge(regular_opts)
    |> client.request(:query)
  end

  def batch_get_item(client, data) do
    data
    client.request(data, :batch_get_item)
  end

  def put_item(client, name, record) do
    %{
      "TableName" => name,
      "Item" => Dynamo.Encoder.encode(record)
    } |> client.request(:put_item)
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

  # Expects exclusive_start_key shape like
  defp build_exclusive_start_key(data, %{exclusive_start_key: start_key}) do
    Map.put(data, "ExclusiveStartKey", start_key |> encode_values)
  end
  defp build_exclusive_start_key(data, _), do: data

  defp build_expression_attribute_values(data, %{expression_attribute_values: values}) do
    Map.put(data, "ExpressionAttributeValues", values |> encode_values)
  end
  defp build_expression_attribute_values(data, _), do: data

  defp encode_values(map) do
    Enum.reduce(map, %{}, fn {attr, value}, attribute_values ->
      Map.put(attribute_values, attr, Dynamo.Encoder.encode(value))
    end)
  end

end
