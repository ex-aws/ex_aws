defmodule Test.Dummy.Kinesis do
  use ExAws.Kinesis.Client

  def config_root, do: Application.get_all_env(:ex_aws)

  def request(data, _action), do: data
end

defmodule ExAws.KinesisTest do
  use ExUnit.Case, async: true
  alias Test.Dummy.Kinesis

  test "#put_records" do
    records = [
      %{data: "asdfasdfasdf", partition_key: "foo"},
      %{data: "foobar", partition_key: "bar", explicit_hash_key: "wuff"}
    ]
    assert Kinesis.put_records("logs", records) ==
      %{"Records" => [%{"Data" => "YXNkZmFzZGZhc2Rm", "PartitionKey" => "foo"},
        %{"Data" => "Zm9vYmFy", "ExplicitHashKey" => "wuff", "PartitionKey" => "bar"}], "StreamName" => "logs"}
  end

  test "#get_shard_iterator" do
    assert Kinesis.get_shard_iterator("logs", "shard-0000", :after_sequence_number) ==
      %{"ShardId" => "shard-0000", "ShardIteratorType" => "AFTER_SEQUENCE_NUMBER",
        "StreamName" => "logs"}
  end

end
