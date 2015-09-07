
defmodule ExAws.ElasticMapReduce.Test do
  use ExUnit.Case, async: true

  test "Basic sanity check" do
    client = ExAws.ElasticMapReduce.Client.new
    assert apply(ExAws.ElasticMapReduce.Core, :list_clusters, [client | [%{}]])
  end
end
