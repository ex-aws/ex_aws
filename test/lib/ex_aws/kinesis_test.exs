defmodule ExAws.KinesisTest do
  use ExUnit.Case, async: true

  test "#list_streams" do
    assert {:ok, %{"HasMoreStreams" => _, "StreamNames" => _}} = Test.Kinesis.list_streams
  end

end
