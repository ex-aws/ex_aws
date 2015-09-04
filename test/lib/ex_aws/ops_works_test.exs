
defmodule ExAws.OpsWorks.Test do
  use ExUnit.Case, async: true

  test "Basic integration test" do
    assert {:ok, _} = ExAws.OpsWorks.new
    |> ExAws.OpsWorks.Core.describe_stacks(%{})
  end
end
