defmodule ExAws.Route53Test do
  use ExUnit.Case, async: true
  alias ExAws.Route53
  alias ExAws.Operation.RestQuery
  import SweetXml, only: [xpath: 2, xpath: 3, sigil_x: 2]

  test "list hosted zones" do
    expected = %RestQuery{
      service: :route53,
      path: "/2013-04-01/hostedzone",
      action: :list_hosted_zones,
      http_method: :get,
      params: %{},
      body: "",
      parser: &ExAws.Route53.Parsers.parse/2
    }
    assert expected == Route53.list_hosted_zones
  end

  test "list hosted zones with options" do
    request = Route53.list_hosted_zones marker: "marker", max_items: 10
    assert %{ marker: "marker", maxitems: 10 } == request.params
  end

  test "create hosted zone" do
    expected_response = %{
      service: :route53,
      path: "/2013-04-01/hostedzone",
      action: :create_hosted_zone,
      http_method: :post,
      params: %{},
      parser: &ExAws.Route53.Parsers.parse/2
    }

    response = %RestQuery{} = Route53.create_hosted_zone name: "example.com"
    assert expected_response == Map.take(response, [:service, :path, :action, :http_method, :params, :parser])
    payload = response.body |> xpath(
      ~x"//CreateHostedZoneRequest",
      caller_reference: ~x"./CallerReference/text()"s,
      name: ~x"./Name/text()"s
    )
    assert String.length(payload.caller_reference) > 0
    assert "example.com" == payload.name
  end

  test "create hosted zone with comment" do
    response = Route53.create_hosted_zone name: "example.com", comment: "my blog"
    comment = response.body |> xpath(~x"//CreateHostedZoneRequest/HostedZoneConfig/Comment/text()"s)
    is_private = response.body |> xpath(~x"//CreateHostedZoneRequest/HostedZoneConfig/PrivateZone"o)
    assert "my blog" == comment
    refute is_private
  end

  test "create private hosted zone" do
    response = Route53.create_hosted_zone name: "example.com", private: true
    comment = response.body |> xpath(~x"//CreateHostedZoneRequest/HostedZoneConfig/Comment"o)
    is_private = response.body |> xpath(~x"//CreateHostedZoneRequest/HostedZoneConfig/PrivateZone/text()"s)
    assert "true" == is_private
    refute comment
  end

  test "create private hosted zone with a comment" do
    response = Route53.create_hosted_zone name: "example.com", private: true, comment: "private zone"
    payload = response.body |> xpath(
      ~x"//CreateHostedZoneRequest/HostedZoneConfig",
      comment: ~x"./Comment/text()"s,
      is_private: ~x"./PrivateZone/text()"s
    )
    assert "true" == payload[:is_private]
    assert "private zone" == payload[:comment]
  end

  test "create private hosted zone associated with a vpc" do
    response = Route53.create_hosted_zone name: "example.com", vpc_id: "VPC_ID", vpc_region: "VPC_REGION"
    payload = response.body |> xpath(
      ~x"//CreateHostedZoneRequest/VPC",
      vpc_id: ~x"./VPCId/text()"s,
      vpc_region: ~x"./VPCRegion/text()"s
    )
    assert "VPC_ID" == payload[:vpc_id]
    assert "VPC_REGION" == payload[:vpc_region]
  end

  test "delete hosted zone" do
    expected = %RestQuery{
      service: :route53,
      path: "/2013-04-01/hostedzone/ZONE_ID",
      action: :delete_hosted_zone,
      http_method: :delete,
      params: %{},
      body: "",
      parser: &ExAws.Route53.Parsers.parse/2
    }
    assert expected == Route53.delete_hosted_zone("ZONE_ID")
  end
end
