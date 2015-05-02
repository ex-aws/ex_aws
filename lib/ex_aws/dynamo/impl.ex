defmodule ExAws.Dynamo.Impl do
  alias ExAws.Dynamo
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

  def create_table(client, name, primary_key, key_definitions, read_capacity, write_capacity) do
    key_schema = [%{
      AttributeName: primary_key,
      KeyType: "HASH"
    }]
    create_table(client, name, key_schema, key_definitions, read_capacity, write_capacity, [], [])
  end

  def create_table(client, name, key_schema, key_definitions, read_capacity, write_capacity, global_indexes, local_indexes) do
    data = %{
      TableName: name,
      AttributeDefinitions: key_definitions |> encode_attrs,
      KeySchema: key_schema,
      ProvisionedThroughput: %{
        ReadCapacityUnits: read_capacity,
        WriteCapacityUnits: write_capacity
      }
    }
    [GlobalSecondaryIndexes: global_indexes, LocalSecondaryIndexes: local_indexes]
    |> Enum.reduce(data, fn
      {_, []}, data -> data
      {name, indices}, data -> Map.put(data, name, Enum.into(indices, %{}))
    end)
    |> client.request(:create_table)
  end

  @doc "Describe table"
  def describe_table(client, name) do
    %{TableName: name}
    |> client.request(:describe_table)
  end

  @doc "Update Table"
  def update_table(client, name, attributes) do
    %{TableName: name}
    |> Map.merge(attributes)
    |> client.request(:update_table)
  end

  def delete_table(client, table) do
    %{TableName: table}
    |> client.request(:delete_table)
  end

  ## Records
  ######################

  def scan(client, name, opts \\ %{}) do
    %{TableName: name}
    |> Map.merge(opts)
    |> client.request(:scan)
  end

  def query(client, name, key_conditions, opts \\ %{}) do
    %{TableName: name, KeyConditions: key_conditions}
    |> Map.merge(opts)
    |> client.request(:query)
  end

  def batch_get_item(client, data) do
    client.request(data, :batch_get_item)
  end

  def put_item(client, name, record) do
    %{
      TableName: name,
      Item: Dynamo.Encoder.encode(record)
    } |> client.request(:put_item)
  end

  def batch_write_item(client, data) do
    client.request(data, :batch_write_item)
  end

  def get_item(client, name, primary_key) do
    %{
      TableName: name,
      Key: Dynamo.Encoder.encode_flat(primary_key)
    }
    |> client.request(:get_item)
  end

  def get_item!(client, name, primary_key) do
    {:ok, %{"Item" => item}} = %{
      TableName: name,
      Key: Dynamo.Encoder.encode_flat(primary_key)
    }
    |> client.request(:get_item)

    item
  end

  def update_item(client, table_name, primary_key, update_args) do
    %{
      TableName: table_name,
      Key: Dynamo.Encoder.encode_flat(primary_key)
    }
    |> Map.merge(update_args)
    |> client.request(:update_item)
  end

  def delete_item(client, name, primary_key) do
    %{TableName: name, Key: primary_key}
    |> client.request(:delete_item)
  end

  defp encode_attrs(attrs) do
    attrs |> Enum.map(fn({name, type}) ->
      %{AttributeName: name, AttributeType: type |> atom_to_dynamo_type}
    end)
  end

  defp atom_to_dynamo_type(:string),  do: "S"
  defp atom_to_dynamo_type(:integer), do: "N"
  defp atom_to_dynamo_type(:float),   do: "N"
  defp atom_to_dynamo_type(value) do
    raise ArgumentError, "Unknown dynamo type for value: #{inspect value}"
  end

end
