defmodule ExAws.Request.UrlTest do
  use ExUnit.Case, async: true
  alias ExAws.Request.Url
  alias ExAws.Operation.RestQuery

  setup do
    rest_query = %RestQuery{
      path: "/path",
      params: %{foo: :bar},
    }
    config = %{
      scheme: "https",
      host: "example.com",
      port: 443
    }
    {:ok, %{rest_query: rest_query, config: config}}
  end

  test "it build urls for rest query operation", %{rest_query: rest_query, config: config} do
    assert Url.build(rest_query, config) == "https://example.com/path?foo=bar"
  end

  test "it allows setting custom port", %{rest_query: rest_query, config: config} do
    config = config |> Map.put(:port, 4430)
    assert Url.build(rest_query, config) == "https://example.com:4430/path?foo=bar"
  end

  test "it allows passing scheme with trailing ://", %{rest_query: rest_query, config: config} do
    config = config |> Map.put(:scheme, "https://")
    assert Url.build(rest_query, config) == "https://example.com/path?foo=bar"
  end
end
