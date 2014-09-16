defmodule ExAws.KinesisTest do
  alias ExAws.Kinesis
  use ExUnit.Case, async: true

  test "#list_streams" do
    assert {:ok, %{"HasMoreStreams" => _, "StreamNames" => _}} = Kinesis.list_streams
  end

  test "#create_stream" do
    assert {:ok, 1} = Kinesis.create_stream(Foo)
  end

end
