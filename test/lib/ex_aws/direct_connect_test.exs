
defmodule ExAws.DirectConnect.Test do
  use ExUnit.Case, async: true

  test "Basic integration test" do
    assert {:ok, _} = ExAws.DirectConnect.new
    |> ExAws.DirectConnect.Core.describe_connections(%{})
  end
end
