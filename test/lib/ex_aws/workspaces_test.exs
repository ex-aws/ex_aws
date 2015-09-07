
defmodule ExAws.Workspaces.Test do
  use ExUnit.Case, async: true

  test "Basic sanity check" do
    client = ExAws.Workspaces.Client.new
    assert apply(ExAws.Workspaces.Core, :describe_workspaces, [client | [%{}]])
  end
end
