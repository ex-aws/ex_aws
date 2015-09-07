
defmodule ExAws.ElasticLoadBalancing.Test do
  use ExUnit.Case, async: true

  test "Basic sanity check" do
    client = ExAws.ElasticLoadBalancing.Client.new
    assert apply(ExAws.ElasticLoadBalancing.Core, :describe_load_balancers, [client | [[]]])
  end
end
