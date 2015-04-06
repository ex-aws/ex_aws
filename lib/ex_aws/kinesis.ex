defmodule ExAws.Kinesis do
  alias __MODULE__
  require Logger
  use ExAws.Kinesis.Adapter

  ## Streams
  ######################

  def list_streams(config) do
    request(:list_streams, %{}, config)
  end

  def describe_stream(config, name, opts) do
    data = %{
      StreamName: name
    } |> Map.merge(opts)
    request(:describe_stream, data, config)
  end

  def create_stream(config, name, shard_count) do
    data = %{
      ShardCount: shard_count,
      StreamName: name
    }
    request(:create_stream, data, config)
  end

  def delete_stream(config, name) do
    data = %{StreamName: name}

    request(:delete_stream, data, config)
  end

  ## Records
  ######################

  def get_records(config, shard_iterator, opts) do
    data = %{
      ShardIterator: shard_iterator
    } |> Map.merge(opts)

    request(:get_records, data, config)
    |> do_get_records
  end

  defp do_get_records({:ok, %{"Records" => records} = results}) do
    {:ok, Map.put(results, "Records", decode_records(records))}
  end
  defp do_get_records(result), do: result

  defp decode_records(records) do
    Enum.flat_map(records, fn(%{"Data" => data} = record) ->
      case data |> Base.decode64 do
        {:ok, decoded} -> %{record | "Data" => decoded}
        :error -> Logger.error("Could not decode data from: #{inspect record}"); []
      end
    end)
  end

  def put_record(config, stream_name, partition_key, blob, opts) when is_list(blob) do
    put_record(config, stream_name, partition_key, IO.iodata_to_binary(blob), opts)
  end

  def put_record(config, stream_name, partition_key, blob, opts) when is_binary(blob) do
    data = %{
      Data: blob |> Base.encode64,
      PartitionKey: partition_key,
      StreamName: stream_name
    } |> Map.merge(opts)
    request(:put_record, data, config)
  end

  ## Shards
  ######################

  def get_shard_iterator(config, name, shard_id, shard_iterator_type, opts) do
    data = %{
      StreamName: name,
      ShardId: shard_id,
      ShardIteratorType: shard_iterator_type
    } |> Map.merge(opts)
    request(:get_shard_iterator, data, config)
  end

  def merge_shards(config, name, adjacent_shard, shard) do
    data = %{
      StreamName: name,
      AdjacentShardToMerge: adjacent_shard,
      ShardToMerge: shard
    }
    request(:merge_shards, data, config)
  end

  def split_shard(config, name, shard, new_starting_hash_key) do
    data = %{
      StreamName: name,
      ShardToSplit: shard,
      NewStartingHashKey: new_starting_hash_key
    }
    request(:split_shard, data, config)
  end

  ## Tags
  ######################

  def add_tags_to_stream(config, name, tags) do
    data = %{
      StreamName: name,
      Tags: tags
    }
    request(:add_tags_to_stream, data, config)
  end

  def list_tags_for_stream(config, name, opts) do
    data = %{
      StreamName: name
    } |> Map.merge(opts)
    request(:list_tags_for_stream, data, config)
  end

  def remove_tags_for_stream(config, name, tag_keys) when is_list(tag_keys) do
    data = %{
      StreamName: name,
      TagKeys: tag_keys
    }
    request(:remove_tags_for_stream, data, config)
  end

  def request(action, data, config) do
    ExAws.Request.request(:kinesis, Kinesis.Actions.get(action), data, config)
  end

  def config do
    ExAws.Config.for_service(:kinesis)
  end
end
