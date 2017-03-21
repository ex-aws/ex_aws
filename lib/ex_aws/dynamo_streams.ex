defmodule ExAws.DynamoStreams do
  @moduledoc """
  Operations on DynamoDB Streams

  http://docs.aws.amazon.com/dynamodbstreams/latest/APIReference/API_Operations.html

  NOTE: When Mix.env in [:test, :dev] dynamo clients will run by default against
  Dynamodb local.

  Enabling/Disabling streams on a table is performed through the `Dynamo.update_table` operation.
  The stream arn can then be retrieved with `Dynamo.describe_table` in the `LatestStreamArn` key.

  """

  import ExAws.Utils, only: [camelize_keys: 1, upcase: 1]
  require Logger

  @namespace "DynamoDBStreams_20120810"

  ## Streams
  ######################

  @type stream_arn :: binary

  @doc """
  Lists all of the streams associated with an account.
  If you have multiple streams on a table (created by disabling/enabling the stream)
  you may have difficulty identifying the active stream from this operation.
  """
  @type list_stream_opts :: [
    {:limit, pos_integer} |
    {:exclusive_start_stream_arn, binary} |
    {:table_name, binary}
  ]
  @spec list_streams() :: ExAws.Operation.JSON.t
  @spec list_streams(opts :: list_stream_opts) :: ExAws.Operation.JSON.t
  def list_streams(opts \\ []) do
    data = opts
    |> camelize_keys
    request(:list_streams, data)
  end

  @doc "Describe Stream"
  @type describe_stream_opts :: [
    {:limit, pos_integer} |
    {:exclusive_start_shard_id, binary}
  ]
  @spec describe_stream(stream_arn :: stream_arn) :: ExAws.Operation.JSON.t
  @spec describe_stream(stream_arn :: stream_arn, opts :: describe_stream_opts) :: ExAws.Operation.JSON.t
  def describe_stream(stream_arn, opts \\ []) do
    data = opts
    |> camelize_keys
    |> Map.merge(%{"StreamArn" => stream_arn})
    request(:describe_stream, data)
  end

  ## Records
  ######################

  @doc "Get stream records"
  @type get_records_opts :: [
    {:limit, pos_integer}
  ]
  @spec get_records(shard_iterator :: binary) :: ExAws.Operation.JSON.t
  @spec get_records(shard_iterator :: binary, opts :: get_records_opts) :: ExAws.Operation.JSON.t
  def get_records(shard_iterator, opts \\ []) do
    data = opts
    |> camelize_keys
    |> Map.merge(%{"ShardIterator" => shard_iterator})

    request(:get_records, data)
  end

  ## Shards
  ######################

  @doc """
  Get a shard iterator
  """
  @type shard_iterator_types ::
    :at_sequence_number |
    :after_sequence_number |
    :trim_horizon |
    :latest
  @type get_shard_iterator_opts :: [
    {:sequence_number, binary}
  ]
  @spec get_shard_iterator(
    stream_arn :: stream_arn,
    shard_id :: binary,
    shard_iterator_type :: shard_iterator_types) :: ExAws.Operation.JSON.t
  @spec get_shard_iterator(
    stream_arn :: stream_arn,
    shard_id :: binary,
    shard_iterator_type :: shard_iterator_types,
    opts :: get_shard_iterator_opts) :: ExAws.Operation.JSON.t
  def get_shard_iterator(stream_arn, shard_id, shard_iterator_type, opts \\ []) do
    data = opts
    |> Map.new
    |> camelize_keys
    |> Map.merge(%{
      "StreamArn" => stream_arn,
      "ShardId" => shard_id,
      "ShardIteratorType" => shard_iterator_type |> upcase
    })

    request(:get_shard_iterator, data)
  end

  defp request(action, data, opts \\ %{}) do
    operation =
      action
      |> Atom.to_string
      |> Macro.camelize

    ExAws.Operation.JSON.new(:dynamodb_streams, %{
      data: data,
      headers: [
        {"x-amz-target", "#{@namespace}.#{operation}"},
        {"content-type", "application/x-amz-json-1.0"}
      ]
    } |> Map.merge(opts))
  end

end
