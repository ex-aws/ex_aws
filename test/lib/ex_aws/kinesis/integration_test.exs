defmodule ExAws.KinesisIntegrationTest do
  use ExUnit.Case, async: true

  # NOTE
  # These tests run against the actual Kinesis service.
  # No functions should be called that in any way alter state.
  #

  test "#list_streams" do
    assert {:ok, %{"HasMoreStreams" => _, "StreamNames" => _}} = ExAws.Kinesis.list_streams |> ExAws.request
  end

end
