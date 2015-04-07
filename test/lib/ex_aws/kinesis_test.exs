defmodule ExAws.KinesisTest do
  alias ExAws.Kinesis
  use ExUnit.Case, async: true

  test "#list_streams" do
    assert {:ok, %{"HasMoreStreams" => _, "StreamNames" => _}} = Kinesis.list_streams
  end

end
