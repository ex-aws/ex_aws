
defmodule ExAws.Route53Domains.Test do
  use ExUnit.Case, async: true

  test "Basic integration test" do
    assert {:ok, _} = ExAws.Route53Domains.new
    |> ExAws.Route53Domains.Core.list_domains(%{})
  end
end
