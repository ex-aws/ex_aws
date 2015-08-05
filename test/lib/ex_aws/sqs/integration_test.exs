defmodule ExAws.SQSIntegrationTest do
  use ExUnit.Case, async: true

  test "list_queues works" do
    assert {:ok, %{body: body}} = ExAws.SQS.list_queues
    assert body |> String.contains?("ListQueuesResponse")
  end
end
