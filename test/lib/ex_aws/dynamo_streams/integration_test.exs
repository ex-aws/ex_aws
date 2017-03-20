defmodule ExAws.DynamoStreamsIntegrationTest do
  alias ExAws.{Dynamo, DynamoStreams}
  use ExUnit.Case, async: true
  require Logger

  ## These tests run against DynamoDb Local unless otherwise specified
  #
  # http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Tools.DynamoDBLocal.html
  # In this way they can safely delete data and tables without risking actual data on
  # Dynamo
  #

  @moduletag :dynamo

  setup_all do
    Dynamo.delete_table("StreamUser") |> ExAws.request
    Dynamo.create_table("StreamUser", [email: :hash, age: :range], [email: :string, age: :number], 1, 1) |> ExAws.request!
    Dynamo.update_table("StreamUser", stream_specification: %{ stream_enabled: true, stream_view_type: "NEW_AND_OLD_IMAGES"}) |> ExAws.request!
    %{"Table" => %{ "LatestStreamArn" => arn }} = Dynamo.describe_table("StreamUser") |> ExAws.request!
    {:ok, [arn: arn]}
  end

  test "#validate arn", context do
    assert context[:arn] =~ "arn:aws:dynamodb:ddblocal:000000000000:table/StreamUser/stream"
  end

  test "#list streams" do
    assert {:ok, _} = DynamoStreams.list_streams |> ExAws.request
  end

  test "#list streams (aws)" do
    assert {:ok, %{"Streams" => _}} = DynamoStreams.list_streams |> ExAws.request(
      host: {"$region", "streams.dynamodb.$region.amazonaws.com"},
      region: "us-east-1",
      port: 80
    )
  end

  test "#describe stream", context do
    assert {:ok, %{"StreamDescription" => _}} = DynamoStreams.describe_stream(context[:arn]) |> ExAws.request
  end

  test "#insert record and retrieve from stream", context do
    user = %Test.User{email: "foo@bar.com", name: %{first: "bob", last: "bubba"}, age: 23, admin: false}
    assert Dynamo.put_item("StreamUser", user) |> ExAws.request
    # There should only be one shard in our test, so grab that one
    {:ok, %{"StreamDescription" => %{"Shards" => [%{"ShardId" => shard}|_]}}} = DynamoStreams.describe_stream(context[:arn]) |> ExAws.request
    assert shard =~ "shardId"
    # Retrieve the shard iterator
    assert {:ok, %{"ShardIterator" => iterator}} = DynamoStreams.get_shard_iterator(context[:arn], shard, :trim_horizon) |> ExAws.request
    assert {:ok, %{"Records" => [record]}} = DynamoStreams.get_records(iterator) |> ExAws.request

    item = record["dynamodb"]["NewImage"]
    |> Dynamo.decode_item(as: Test.User)

    assert item == user
  end

end
