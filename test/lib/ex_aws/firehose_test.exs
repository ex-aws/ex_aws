defmodule ExAws.FirehoseTest do
  use ExUnit.Case, async: true
  alias ExAws.Firehose

  ## NOTE:
  # These tests are not intended to be operational examples, but instead mere
  # ensure that the form of the data to be sent to AWS is correct.
  #

  test "#put_record_batch" do
    records = [
      %{data: "asdfasdfasdf"},
      %{data: "foobar"}
    ]
    assert Firehose.put_record_batch("logs", records).data ==
      %{"Records" => [%{"Data" => "YXNkZmFzZGZhc2Rm"}, %{"Data" => "Zm9vYmFy"}],
        "DeliveryStreamName" => "logs"}
  end

  test "#put_record" do
    assert Firehose.put_record("logs", "hey there").data ==
      %{"Record" => %{"Data" => "aGV5IHRoZXJl"},
        "DeliveryStreamName" => "logs"}
  end

end
