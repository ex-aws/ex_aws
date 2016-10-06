defmodule ExAws.FirehoseIntegrationTest do
  use ExUnit.Case, async: true

  # NOTE
  # These tests run against the actual Kinesis service.
  # No functions should be called that in any way alter state.
  #

  test "#list_delivery_streams" do
    assert {:ok, %{"HasMoreDeliveryStreams" => _, "DeliveryStreamNames" => _}} = ExAws.Firehose.list_delivery_streams |> ExAws.request
  end

end
