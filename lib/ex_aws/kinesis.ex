defmodule ExAws.Kinesis do
  @moduledoc """
  Operations on AWS Kinesis

  http://docs.aws.amazon.com/kinesis/latest/APIReference/API_Operations.html
  """

  import ExAws.Utils, only: [camelize_keys: 1, upcase: 1]
  require Logger

  @namespace "Kinesis_20131202"

  ## Streams
  ######################

  @type stream_name :: binary

  @doc "Lists streams"
  @spec list_streams() :: ExAws.Operation.JSON.t
  def list_streams() do
    request(:list_streams, %{})
  end

  @doc "Describe Stream"
  @type describe_stream_opts :: [
    {:limit, pos_integer} |
    {:exclusive_start_shard_id, binary}
  ]
  @spec describe_stream(stream_name :: stream_name) :: ExAws.Operation.JSON.t
  @spec describe_stream(stream_name :: stream_name, opts :: describe_stream_opts) :: ExAws.Operation.JSON.t
  def describe_stream(stream_name, opts \\ []) do
    data = opts
    |> camelize_keys
    |> Map.merge(%{"StreamName" => stream_name})
    request(:describe_stream, data)
  end

  @doc "Creates stream"
  @spec create_stream(stream_name :: stream_name) :: ExAws.Operation.JSON.t
  @spec create_stream(stream_name :: stream_name, shard_count :: pos_integer) :: ExAws.Operation.JSON.t
  def create_stream(stream_name, shard_count \\ 1) do
    data = %{
      "ShardCount" => shard_count,
      "StreamName" => stream_name}
    request(:create_stream, data)
  end

  @doc "Deletes stream"
  @spec delete_stream(stream_name :: stream_name) :: ExAws.Operation.JSON.t
  def delete_stream(stream_name) do
    request(:delete_stream, %{"StreamName" => stream_name})
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

    request(:get_records, data, %{parser: &decode_records/1})
  end

  def decode_records({:ok, %{"Records" => records} = results}) do
    {:ok, Map.put(results, "Records", do_decode_records(records))}
  end
  def decode_records(result), do: result

  defp do_decode_records(records) do
    records
    |> Enum.reduce([], fn(%{"Data" => data} = record, acc) ->
      case data |> Base.decode64 do
        {:ok, decoded} -> [%{record | "Data" => decoded} | acc]
        :error ->
          Logger.error("Could not decode data from: #{inspect record}")
          acc
      end
    end)
    |> Enum.reverse
  end

  @doc "Puts a record on a stream"
  @type put_record_opts :: [
    {:explicit_hash_key, binary} |
    {:sequence_number_for_ordering, binary}
  ]
  @spec put_record(stream_name :: stream_name, partition_key :: binary, data :: binary) :: ExAws.Operation.JSON.t
  @spec put_record(stream_name :: stream_name, partition_key :: binary, data :: binary, opts :: put_record_opts) :: ExAws.Operation.JSON.t
  def put_record(stream_name, partition_key, data, opts \\ []) do
    data = opts
    |> camelize_keys
    |> Map.merge(%{
      "Data" => data |> Base.encode64,
      "PartitionKey" => partition_key,
      "StreamName" => stream_name})

    request(:put_record, data)
  end

  @doc "Put multiple records on a stream"
  @type put_records_record :: [
    {:data, binary} |
    {:explicit_hash_key, binary}
  ]
  @spec put_records(stream_name :: stream_name, records :: [put_records_record]) :: ExAws.Operation.JSON.t
  def put_records(stream_name, records) when is_list(records) do
    data = %{
      "Records"    => records |> Enum.map(&format_record/1),
      "StreamName" => stream_name
    }

    request(:put_records, data)
  end

  defp format_record(%{data: data, partition_key: partition_key} = record) do
    formatted = %{"Data" => data |> Base.encode64, "PartitionKey" => partition_key}
    case record do
      %{explicit_hash_key: hash_key} ->
        formatted |> Map.put("ExplicitHashKey", hash_key)
      _ -> formatted
    end
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
    {:starting_sequence_number, binary}
  ]
  @spec get_shard_iterator(
    stream_name :: stream_name,
    shard_id :: binary,
    shard_iterator_type :: shard_iterator_types) :: ExAws.Operation.JSON.t
  @spec get_shard_iterator(
    stream_name :: stream_name,
    shard_id :: binary,
    shard_iterator_type :: shard_iterator_types,
    opts :: get_shard_iterator_opts) :: ExAws.Operation.JSON.t
  def get_shard_iterator(stream_name, shard_id, shard_iterator_type, opts \\ []) do
    data = opts
    |> Map.new
    |> camelize_keys
    |> Map.merge(%{
      "StreamName" => stream_name,
      "ShardId" => shard_id,
      "ShardIteratorType" => shard_iterator_type |> upcase
    })

    request(:get_shard_iterator, data)
  end

  @doc "Merge adjacent shards"
  @spec merge_shards(stream_name :: stream_name, adjacent_shard_id :: binary, shard_id :: binary) :: ExAws.Operation.JSON.t
  def merge_shards(stream_name, adjacent_shard, shard) do
    data = %{
      "StreamName" => stream_name,
      "AdjacentShardToMerge" => adjacent_shard,
      "ShardToMerge" => shard
    }

    request(:merge_shards, data)
  end

  @doc "Split a shard"
  @spec split_shard(stream_name :: binary, shard :: binary, new_starting_hash_key :: binary) :: ExAws.Operation.JSON.t
  def split_shard(stream_name, shard, new_starting_hash_key) do
    data = %{
      "StreamName" => stream_name,
      "ShardToSplit" => shard,
      "NewStartingHashKey" => new_starting_hash_key
    }

    request(:split_shard, data)
  end

  ## Tags
  ######################

  @type stream_tags :: [{atom, binary} | {binary, binary}]

  @doc "Add tags to stream"
  @spec add_tags_to_stream(stream_name :: binary, tags :: stream_tags) :: ExAws.Operation.JSON.t
  def add_tags_to_stream(stream_name, tags) do
    data = %{"StreamName" => stream_name, "Tags" => tags |> Map.new}
    request(:add_tags_to_stream, data)
  end

  @type list_tags_for_stream_opts :: [
    {:limit, pos_integer} |
    {:exclusive_start_tag_key, binary}
  ]

  @doc "List tags for a stream"
  @spec list_tags_for_stream(stream_name :: binary) :: ExAws.Operation.JSON.t
  @spec list_tags_for_stream(stream_name :: binary, opts :: list_tags_for_stream_opts) :: ExAws.Operation.JSON.t
  def list_tags_for_stream(stream_name, opts \\ []) do
    data = opts
    |> Map.new
    |> camelize_keys
    |> Map.merge(%{"StreamName" => stream_name})

    request(:list_tags_for_stream, data)
  end

  @doc "Remove tags from stream"
  @spec remove_tags_from_stream(stream_name :: binary, tag_keys :: [binary]) :: ExAws.Operation.JSON.t
  def remove_tags_from_stream(stream_name, tag_keys) do
    data = %{"StreamName" => stream_name, "TagKeys" => tag_keys}
    request(:remove_tags_from_stream, data)
  end

  defp request(action, data, opts \\ %{}) do
    operation =
      action
      |> Atom.to_string
      |> Macro.camelize

    ExAws.Operation.JSON.new(:kinesis, %{
      data: data,
      headers: [
        {"x-amz-target", "#{@namespace}.#{operation}"},
        {"content-type", "application/x-amz-json-1.1"}
      ]
    } |> Map.merge(opts))
  end

end
