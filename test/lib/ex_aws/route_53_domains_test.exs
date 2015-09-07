
defmodule ExAws.Route53Domains.Test do
  use ExUnit.Case, async: true

  test "Basic sanity check" do
    client = ExAws.Route53Domains.Client.new
    assert apply(ExAws.Route53Domains.Core, :list_domains, [client | [%{}]])
  end
end
