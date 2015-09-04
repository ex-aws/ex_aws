
defmodule ExAws.CodeDeploy.Test do
  use ExUnit.Case, async: true

  test "Basic integration test" do
    assert {:ok, _} = ExAws.CodeDeploy.new
    |> ExAws.CodeDeploy.Core.list_applications(%{})
  end
end
