
defmodule ExAws.Ecs.Test do
  use ExUnit.Case, async: true

  test "Basic integration test" do
    assert {:ok, _} = ExAws.Ecs.new
    |> ExAws.Ecs.Core.list_clusters(%{})
  end
end
