
defmodule ExAws.DirectoryService.Test do
  use ExUnit.Case, async: true

  test "Basic integration test" do
    assert {:ok, _} = ExAws.DirectoryService.new
    |> ExAws.DirectoryService.Core.describe_directories(%{})
  end
end
