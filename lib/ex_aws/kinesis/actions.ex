defmodule ExAws.Kinesis.Actions do
  @actions [:create_stream, :delete_stream, :list_streams, :describe_stream,
            :get_shard_iterator, :get_records, :put_record,
            :merge_shards, :split_shard]
    |> Enum.reduce(%{}, fn(action, actions) ->
      name = action |> Atom.to_string |> Mix.Utils.camelize
      Map.put(actions, action, "Kinesis_20131202.#{name}")
    end)

  def list, do: @actions

  def get(op) do
    @actions |> Map.get(op)
  end

end
