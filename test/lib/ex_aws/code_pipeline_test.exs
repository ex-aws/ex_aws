
defmodule ExAws.CodePipeline.Test do
  use ExUnit.Case, async: true

  test "Basic integration test" do
    assert {:ok, _} = ExAws.CodePipeline.new
    |> ExAws.CodePipeline.Core.list_pipelines(%{})
  end
end
