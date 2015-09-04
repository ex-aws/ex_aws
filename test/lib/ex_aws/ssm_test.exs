
defmodule ExAws.SSM.Test do
  use ExUnit.Case, async: true

  test "Basic integration test" do
    assert {:ok, _} = ExAws.SSM.new
    |> ExAws.SSM.Core.list_documents(%{})
  end
end
