
defmodule ExAws.DirectoryService.Test do
  use ExUnit.Case, async: true

  test "Basic sanity check" do
    client = ExAws.DirectoryService.Client.new
    assert apply(ExAws.DirectoryService.Core, :describe_directories, [client | [%{}]])
  end
end
