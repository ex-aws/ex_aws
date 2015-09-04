
defmodule ExAws.DataPipeline.Test do
  use ExUnit.Case, async: true

  test "Basic integration test" do
    assert {:ok, _} = ExAws.DataPipeline.new
    |> ExAws.DataPipeline.Core.list_pipelines(%{})
  end
end
