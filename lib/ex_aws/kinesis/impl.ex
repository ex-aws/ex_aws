defmodule ExAws.Kinesis.Impl do
  use ExAws.Actions
  import ExAws.Kinesis.Request
  require Logger

  @namespace "Kinesis_20131202"
  @actions [
    add_tags_to_stream:      :post,
    create_stream:           :post,
    delete_stream:           :post,
    describe_stream:         :post,
    get_records:             :post,
    get_shard_iterator:      :post,
    list_streams:            :post,
    list_tags_for_stream:    :post,
    merge_shards:            :post,
    put_record:              :post,
    put_records:             :post,
    remove_tags_from_stream: :post,
    split_shard:             :post]

  @moduledoc "See ExAws.Kinesis.Adapter for documentation"

  ## Streams
  ######################

  def list_streams(adapter) do
    request(%{}, :list_streams, adapter)
  end

  def describe_stream(adapter, name, opts) do
    %{StreamName: name}
    |> Map.merge(opts)
    |> request(:describe_stream, adapter)
  end

  def create_stream(adapter, name, shard_count) do
    %{
      ShardCount: shard_count,
      StreamName: name
    }
    |> request(:create_stream, adapter)
  end

  def delete_stream(adapter, name) do
    %{StreamName: name}
    |> request(:delete_stream, adapter)
  end

  ## Records
  ######################

  def get_records(adapter, shard_iterator, opts) do
    %{ShardIterator: shard_iterator}
    |> Map.merge(opts)
    |> request(:get_records, adapter)
    |> do_get_records
  end

  defp do_get_records({:ok, %{"Records" => records} = results}) do
    {:ok, Map.put(results, "Records", decode_records(records))}
  end
  defp do_get_records(result), do: result

  defp decode_records(records) do
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

  def put_record(adapter, stream_name, partition_key, data, opts) when is_list(data) do
    put_record(adapter, stream_name, partition_key, IO.iodata_to_binary(data), opts)
  end

  def put_record(adapter, stream_name, partition_key, data, opts) when is_binary(data) do
    %{
      format_record(%{data: data, partition_key: partition_key}) |
      StreamName: stream_name
    }
    |> Map.merge(opts)
    |> request(:put_record, adapter)
  end

  def put_records(adapter, stream_name, records) when is_list(records) do
    %{
      Data: records |> Enum.map(&format_record/1),
      StreamName: stream_name
    }
    |> request(:put_records, adapter)
  end

  defp format_record(%{data: data, partition_key: partition_key, explicit_hash_key: hash_key}) do
    %{format_record(%{data: data, partition_key: partition_key}) | ExplicitHashKey: hash_key}
  end
  defp format_record(%{data: data, partition_key: partition_key}) do
    %{
      Data: data |> Base.encode64,
      PartitionKey: partition_key
    }
  end

  ## Shards
  ######################

  def get_shard_iterator(adapter, name, shard_id, shard_iterator_type, opts) do
    %{
      StreamName: name,
      ShardId: shard_id,
      ShardIteratorType: shard_iterator_type
    } |> Map.merge(opts)
    |> request(:get_shard_iterator, adapter)
  end

  def merge_shards(adapter, name, adjacent_shard, shard) do
    %{
      StreamName: name,
      AdjacentShardToMerge: adjacent_shard,
      ShardToMerge: shard
    }
    |> request(:merge_shards, adapter)
  end

  def split_shard(adapter, name, shard, new_starting_hash_key) do
    %{
      StreamName: name,
      ShardToSplit: shard,
      NewStartingHashKey: new_starting_hash_key
    }
    |> request(:split_shard, adapter)
  end

  ## Tags
  ######################

  def add_tags_to_stream(adapter, name, tags) do
    %{StreamName: name, Tags: tags}
    |> request(:add_tags_to_stream, adapter)
  end

  def list_tags_for_stream(adapter, name, opts) do
    %{StreamName: name}
    |> Map.merge(opts)
    |> request(:list_tags_for_stream, adapter)
  end

  def remove_tags_from_stream(adapter, name, tag_keys) when is_list(tag_keys) do
    %{StreamName: name, TagKeys: tag_keys}
    |> request(:remove_tags_from_stream, adapter)
  end
end
