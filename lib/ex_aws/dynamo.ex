defmodule ExAws.Dynamo do
  alias Dynamo.Conversions
  # These function should be used for everything.
  def request(action) do
    request(action, [])
  end

  def request(action, data) do
    :erlcloud_ddb_impl.request(Dynamo.Config.config, Dynamo.Actions.get(action), data)
  end

  ## Tables
  ######################

  def list_tables do
    request(:list_tables)
  end

  def create_table(name, primary_key, key_definitions, read_capacity, write_capacity) do
    key_schema = [[
      AttributeName: primary_key,
      KeyType: "HASH"
    ]]
    create_table(name, key_schema, key_definitions, read_capacity, write_capacity, [], [])
  end

  def create_table(name, key_schema, key_definitions, read_capacity, write_capacity, global_indexes, local_indexes) do
    data = [
      TableName: name,
      AttributeDefinitions: key_definitions |> Conversions.dynamize_attrs,
      KeySchema: key_schema,
      ProvisionedThroughput: [
        ReadCapacityUnits: read_capacity,
        WriteCapacityUnits: write_capacity
      ]
    ]
    if length(global_indexes) > 0 do
      data = [GlobalSecondaryIndexes: global_indexes] ++ data
    end

    if length(local_indexes) > 0 do
      data = [LocalSecondaryIndexes: local_indexes] ++ data
    end

    request(:create_table, data)
  end

  def delete_table(table) do
    request(:delete_table, [TableName: table])
  end

  ## Records
  ######################

  def scan(table) do
    data = [
      TableName: table
    ]
    request(:scan, data)
  end

  def put_item(%{__struct__: module} = record) do
    data = [
      TableName: module,
      Item: Dynamo.Conversions.dynamize(record)
    ]
    request(:put_item, data)
  end

  def get_item(primary_key, module) do
    data = [
      TableName: module,
      Key: module.dynamo_key(primary_key)
    ]
    request(:get_item, data)
  end

  def delete_item(%{__struct__: module} = record) do
    data = [
      TableName: module,
      Key: module.dynamo_key(record)
    ]
    request(:delete_item, data)
  end

end
