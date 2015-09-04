
defmodule ExAws.Dynamodb.Streams.Test do
  use ExUnit.Case, async: true

  test "Basic integration test" do
    assert {:ok, _} = ExAws.Dynamodb.Streams.new
    |> ExAws.Dynamodb.Streams.Core.list_streams(%{})
  end
end
