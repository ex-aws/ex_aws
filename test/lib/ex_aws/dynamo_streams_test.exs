defmodule ExAws.DynamoStreamsTest do
  use ExUnit.Case, async: true
  alias ExAws.DynamoStreams

  ## NOTE:
  # These tests are not intended to be operational examples, but intead mere
  # ensure that the form of the data to be sent to AWS is correct.
  #

  test "#get_shard_iterator" do
    assert DynamoStreams.get_shard_iterator("logs", "shard-0000", :after_sequence_number).data ==
      %{"ShardId" => "shard-0000", "ShardIteratorType" => "AFTER_SEQUENCE_NUMBER",
        "StreamArn" => "logs"}
  end

end
