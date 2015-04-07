defmodule ExAws.Dynamo do
  alias __MODULE__
  alias ExAws.Config
  use ExAws.Dynamo.Adapter

  ## Tables
  ######################

  def list_tables(config) do
    request(:list_tables, %{}, config)
  end

  def create_table(config, name, primary_key, key_definitions, read_capacity, write_capacity) do
    key_schema = [%{
      AttributeName: primary_key,
      KeyType: "HASH"
    }]
    create_table(config, name, key_schema, key_definitions, read_capacity, write_capacity, [], [])
  end

  def create_table(config, name, key_schema, key_definitions, read_capacity, write_capacity, global_indexes, local_indexes) do
    data = %{
      TableName: name,
      AttributeDefinitions: key_definitions |> encode_attrs,
      KeySchema: key_schema,
      ProvisionedThroughput: %{
        ReadCapacityUnits: read_capacity,
        WriteCapacityUnits: write_capacity
      }
    }
    if length(global_indexes) > 0 do
      data = Map.put(data, :GlobalSecondaryIndexes, global_indexes)
    end

    if length(local_indexes) > 0 do
      data = Map.put(data, :LocalSecondaryIndexes, local_indexes)
    end

    request(:create_table, data, config)
  end

  @doc "Describe table"
  def describe_table(config, name) do
    request(:describe_table, %{TableName: name}, config)
  end

  @doc "Update Table"
  def update_table(config, name, attributes) do
    data = %{TableName: name}
    |> Map.merge(attributes)
    request(:update_table, data, config)
  end

  def delete_table(config, table) do
    request(:delete_table, %{TableName: table}, config)
  end

  ## Records
  ######################

  def scan(config, name, opts) do
    data = %{
      TableName: name
    } |> Map.merge(opts)
    request(:scan, data, config)
  end

  def query(config, name, key_conditions, opts) do
    data = %{
      TableName: name,
      KeyConditions: key_conditions
    } |> Map.merge(opts)
    request(:query, data, config)
  end

  def batch_get_item(config, data) do
    request(:batch_get_item, data, config)
  end

  def put_item(config, name, record) do
    data = %{
      TableName: name,
      Item: Dynamo.Encoder.encode(record)
    }
    request(:put_item, data, config)
  end

  def batch_write_item(config, data) do
    request(:batch_write_item, data, config)
  end

  def get_item(config, name, primary_key) do
    data = %{
      TableName: name,
      Key: Dynamo.Encoder.encode_flat(primary_key)
    }
    request(:get_item, data, config)
  end

  def delete_item(config, name, primary_key) do
    data = %{
      TableName: name,
      Key: primary_key
    }
    request(:delete_item, data, config)
  end

  def request(action, data, config) do
    ExAws.Request.request(:dynamodb, Dynamo.Actions.get(action), data, config)
  end

  def encode_attrs(attrs) do
    attrs |> Enum.map(fn({name, type}) ->
      %{AttributeName: name, AttributeType: type}
    end)
  end

  def config do
    ExAws.Config.for_service(:dynamodb)
  end

end
