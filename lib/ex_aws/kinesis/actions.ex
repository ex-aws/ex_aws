defmodule ExAws.Kinesis.Actions do
  use ExAws.Actions

  @namespace "Kinesis_20131202"
  @actions [:create_stream, :delete_stream, :list_streams, :describe_stream,
            :get_shard_iterator, :get_records, :put_record,
            :merge_shards, :split_shard]
end
