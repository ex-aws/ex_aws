defmodule ExAws.Route53IntegrationTest do
  use ExUnit.Case, async: true

  test "#list_hosted_zones" do
    assert {:ok, %{body: body}} = ExAws.Route53.list_hosted_zones
    assert body |> String.contains?("ListHostedZonesResponse")
  end

end
