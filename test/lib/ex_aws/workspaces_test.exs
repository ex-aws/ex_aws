
defmodule ExAws.Workspaces.Test do
  use ExUnit.Case, async: true

  test "Basic integration test" do
    assert {:ok, _} = ExAws.Workspaces.new
    |> ExAws.Workspaces.Core.describe_workspaces(%{})
  end
end
