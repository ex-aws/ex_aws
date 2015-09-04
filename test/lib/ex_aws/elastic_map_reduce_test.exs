
defmodule ExAws.ElasticMapReduce.Test do
  use ExUnit.Case, async: true

  test "Basic integration test" do
    assert {:ok, _} = ExAws.ElasticMapReduce.new
    |> ExAws.ElasticMapReduce.Core.list_clusters(%{})
  end
end
