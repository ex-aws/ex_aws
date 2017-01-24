defmodule ExAws.Route53IntergrationTest do
  use ExUnit.Case, async: true

  test "#list_hosted_zones" do
    assert {:ok, %{body: body}} = ExAws.Route53.list_hosted_zones(max_items: 5) |> ExAws.request
    assert body |> Map.has_key?(:hosted_zones)
    assert body[:max_items] == 5
  end
end
