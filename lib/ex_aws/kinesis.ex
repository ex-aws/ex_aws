defmodule ExAws.Kinesis do
  alias __MODULE__
  alias ExAws.Config

  def list_streams do
    request(:list_streams)
  end

  def create_stream(name, shard_count \\ 1) do
    data = [
      ShardCount: shard_count,
      StreamName: name
    ]
    data |> IO.inspect
    request(:create_stream, data)
  end

  def delete_stream(name) do
    data = [
      StreamName: name
    ]

    request(:delete_stream, data)
  end

  def put_record(stream_name, partition_key, blob, opts \\ []) do
    data = [
      Data: blob,
      PartitionKey: partition_key,
      StreamName: stream_name
    ] ++ opts
    request(:put_record, data)
  end

  # This function should be used for everything.
  def request(action) do
    request(action, [])
  end

  def request(action, data) do
    :erlcloud_kinesis_impl.request(Config.erlcloud_config, Kinesis.Actions.get(action), Config.namespace(data, :kinesis))
  end

end
