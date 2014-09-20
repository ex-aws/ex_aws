defmodule ExAws.Kinesis do
  alias __MODULE__
  alias ExAws.Config

  ## Streams
  ######################

  def list_streams do
    request(:list_streams)
  end

  def describe_stream(name, opts \\ %{}) do
    data = %{
      StreamName: name
    } |> Map.merge(opts)
    request(:describe_stream, data)
  end

  def create_stream(name, shard_count \\ 1) do
    data = %{
      ShardCount: shard_count,
      StreamName: name
    }
    request(:create_stream, data)
  end

  def delete_stream(name) do
    data = %{StreamName: name}

    request(:delete_stream, data)
  end

  ## Records
  ######################

  def get_records(shard_iterator, opts \\ %{}) do
    data = %{
      ShardIterator: shard_iterator
    } |> Map.merge(opts)
    request(:get_records, data)
      |> do_get_records
  end

  def do_get_records({:ok, %{"Records" => records}}) do
    decoded_records = records
      |> Enum.map(fn(%{"Data" => data} = record) ->
        %{record | "Data" => Base.decode64!(data)}
      end)
    {:ok, %{"Records" => decoded_records}}
  end

  def do_get_records(result), do: result

  def put_record(stream_name, partition_key, blob) do
    put_record(stream_name, partition_key, blob, %{})
  end

  def put_record(stream_name, partition_key, blob, opts) when is_list(blob) do
    put_record(stream_name, partition_key, IO.iodata_to_binary(blob), opts)
  end

  def put_record(stream_name, partition_key, blob, opts) when is_binary(blob) do
    data = %{
      Data: blob |> Base.encode64,
      PartitionKey: partition_key,
      StreamName: stream_name
    } |> Map.merge(opts)
    request(:put_record, data)
  end

  ## Shards
  ######################

  def get_shard_iterator(name, shard_id, shard_iterator_type, opts \\ %{}) do
    data = %{
      StreamName: name,
      ShardId: shard_id,
      ShardIteratorType: shard_iterator_type
    } |> Map.merge(opts)
    request(:get_shard_iterator, data)
  end

  def merge_shards(name, adjacent_shard, shard) do
    data = %{
      StreamName: name,
      AdjacentShardToMerge: adjacent_shard,
      ShardToMerge: shard
    }
    request(:merge_shards, data)
  end

  def split_shard(name, shard, new_starting_hash_key) do
    data = %{
      StreamName: name,
      ShardToSplit: shard,
      NewStartingHashKey: new_starting_hash_key
    }
    request(:split_shard, data)
  end

  ## Tags
  ######################

  def add_tags_to_stream(name, tags = %{}) do
    data = %{
      StreamName: name,
      Tags: tags
    }
    request(:add_tags_to_stream, data)
  end

  def list_tags_for_stream(name, opts \\ %{}) do
    data = %{
      StreamName: name
    } |> Map.merge(opts)
    request(:list_tags_for_stream, data)
  end

  def remove_tags_for_stream(name, tag_keys) when is_list(tag_keys) do
    data = %{
      StreamName: name,
      TagKeys: tag_keys
    }
    request(:remove_tags_for_stream, data)
  end

  # This function should be used for everything.
  def request(action) do
    request(action, %{})
  end

  def request(action, data) do
    ExAws.Request.request(:kinesis, ExAws.Config.erlcloud_config, Kinesis.Actions.get(action), Config.namespace(data, :kinesis))
  end

end
