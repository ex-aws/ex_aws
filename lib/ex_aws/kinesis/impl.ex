defmodule ExAws.Kinesis.Impl do
  use ExAws.Actions
  import ExAws.Utils, only: [camelize_keys: 1, upcase: 1]
  require Logger

  defdelegate stream_shards(client, stream_name), to: ExAws.Kinesis.Lazy
  defdelegate stream_shards(client, stream_name, opts), to: ExAws.Kinesis.Lazy

  defdelegate stream_records(client, shard_iterator), to: ExAws.Kinesis.Lazy
  defdelegate stream_records(client, shard_iterator, opts), to: ExAws.Kinesis.Lazy
  defdelegate stream_records(client, shard_iterator, opts, iterator_fun), to: ExAws.Kinesis.Lazy

  @moduledoc false
  # Implimentation of the AWS Kinesis API.
  #
  # See ExAws.Kinesis.Client for usage.

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

  ## Streams
  ######################

  def list_streams(client) do
    request(client, :list_streams, %{})
  end

  def describe_stream(client, stream_name, opts \\ []) do
    data = opts
    |> camelize_keys
    |> Map.merge(%{"StreamName" => stream_name})
    request(client, :describe_stream, data)
  end

  def create_stream(client, stream_name, shard_count \\ 1) do
    data = %{
      "ShardCount" => shard_count,
      "StreamName" => stream_name}
    request(client, :create_stream, data)
  end

  def delete_stream(client, stream_name) do
    request(client, :delete_stream, %{"StreamName" => stream_name})
  end

  ## Records
  ######################

  def get_records(client, shard_iterator, opts \\ []) do
    data = opts
    |> camelize_keys
    |> Map.merge(%{"ShardIterator" => shard_iterator})

    request(client, :get_records, data)
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

  def put_record(client, stream_name, partition_key, data, opts \\ []) do
    data = opts
    |> camelize_keys
    |> Map.merge(%{
      "Data" => data |> Base.encode64,
      "PartitionKey" => partition_key,
      "StreamName" => stream_name})

    request(client, :put_record, data)
  end

  def put_records(client, stream_name, records) when is_list(records) do
    data = %{
      "Records"    => records |> Enum.map(&format_record/1),
      "StreamName" => stream_name
    }

    request(client, :put_records, data)
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

  def get_shard_iterator(client, stream_name, shard_id, shard_iterator_type, opts \\ []) do
    data = opts
    |> Enum.into(%{})
    |> camelize_keys
    |> Map.merge(%{
      "StreamName" => stream_name,
      "ShardId" => shard_id,
      "ShardIteratorType" => shard_iterator_type |> upcase
    })

    request(client, :get_shard_iterator, data)
  end

  def merge_shards(client, stream_name, adjacent_shard, shard) do
    data = %{
      "StreamName" => stream_name,
      "AdjacentShardToMerge" => adjacent_shard,
      "ShardToMerge" => shard
    }

    request(client, :merge_shards, data)
  end

  def split_shard(client, stream_name, shard, new_starting_hash_key) do
    data = %{
      "StreamName" => stream_name,
      "ShardToSplit" => shard,
      "NewStartingHashKey" => new_starting_hash_key
    }

    request(client, :split_shard, data)
  end

  ## Tags
  ######################

  def add_tags_to_stream(client, stream_name, tags) do
    data = %{"StreamName" => stream_name, "Tags" => tags |> Enum.into(%{})}
    request(client, :add_tags_to_stream, data)
  end

  def list_tags_for_stream(client, stream_name, opts \\ []) do
    data = opts
    |> Enum.into(%{})
    |> camelize_keys
    |> Map.merge(%{"StreamName" => stream_name})

    request(client, :list_tags_for_stream, data)
  end

  def remove_tags_from_stream(client, stream_name, tag_keys) do
    data = %{"StreamName" => stream_name, "TagKeys" => tag_keys}
    request(client, :remove_tags_from_stream, data)
  end

  defp request(%{__struct__: client_module} = client, action, data) do
    client_module.request(client, action, data)
  end
end
