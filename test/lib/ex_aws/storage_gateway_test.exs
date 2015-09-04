
defmodule ExAws.StorageGateway.Test do
  use ExUnit.Case, async: true

  test "Basic integration test" do
    assert {:ok, _} = ExAws.StorageGateway.new
    |> ExAws.StorageGateway.Core.list_gateways(%{})
  end
end
