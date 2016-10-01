defmodule ExAws.SQSIntegrationTest do
  use ExUnit.Case, async: true

  test "list_queues works" do
    assert {:ok, %{body: %{queues: _}}} = ExAws.SQS.list_queues |> ExAws.request
  end
end
