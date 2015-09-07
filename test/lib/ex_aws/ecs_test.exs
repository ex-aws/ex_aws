
defmodule ExAws.Ecs.Test do
  use ExUnit.Case, async: true

  test "Basic sanity check" do
    client = ExAws.Ecs.Client.new
    assert apply(ExAws.Ecs.Core, :list_clusters, [client | [%{}]])
  end
end
