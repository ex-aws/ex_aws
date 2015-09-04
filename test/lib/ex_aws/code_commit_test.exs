
defmodule ExAws.CodeCommit.Test do
  use ExUnit.Case, async: true

  test "Basic integration test" do
    assert {:ok, _} = ExAws.CodeCommit.new
    |> ExAws.CodeCommit.Core.list_repositories(%{})
  end
end
