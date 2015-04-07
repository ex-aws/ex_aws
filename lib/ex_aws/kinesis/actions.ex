defmodule ExAws.Kinesis.Actions do
  use ExAws.Actions

  @namespace "Kinesis_20131202"
  @actions [
    :add_tags_to_stream,
    :create_stream,
    :delete_stream,
    :describe_stream,
    :get_records,
    :get_shard_iterator,
    :list_streams,
    :list_tags_for_stream,
    :merge_shards,
    :put_record,
    :put_records,
    :remove_tags_from_stream,
    :split_shard]
end
