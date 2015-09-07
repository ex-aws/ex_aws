
defmodule ExAws.ElastiCache.Test do
  use ExUnit.Case, async: true

  test "Basic sanity check" do
    client = ExAws.ElastiCache.Client.new
    assert apply(ExAws.ElastiCache.Core, :describe_cache_clusters, [client | [[]]])
  end
end
