defmodule ExAws.Route53Test do
  use ExUnit.Case, async: true
  alias ExAws.Route53

  test "list hosted zones" do
    expected =
      %ExAws.Operation.RestQuery{
        service: :route53,
        path: "/2013-04-01/hostedzone",
        action: :list_hosted_zones,
        http_method: :get,
        params: %{},
        parser: &ExAws.Route53.Parsers.parse/2
      }
      assert expected == Route53.list_hosted_zones
  end

  test "list hosted zones with options" do
    zones = %ExAws.Operation.RestQuery{} = Route53.list_hosted_zones marker: "marker", max_items: 10
    assert Map.get(zones, :params) == %{ marker: "marker", maxitems: 10 }
  end
end
