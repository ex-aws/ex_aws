defmodule ExAws.Request.UrlTest do
  use ExUnit.Case, async: true
  alias ExAws.Request.Url

  setup do
    query = %{
      path: "/path",
      params: %{foo: :bar}
    }

    config = %{
      scheme: "https",
      host: "example.com",
      port: 443,
      normalize_path: true
    }

    {:ok, %{query: query, config: config}}
  end

  test "it build urls for query operation", %{query: query, config: config} do
    assert Url.build(query, config) == "https://example.com/path?foo=bar"
  end

  test "it allows setting custom port", %{query: query, config: config} do
    config = config |> Map.put(:port, 4430)
    assert Url.build(query, config) == "https://example.com:4430/path?foo=bar"
  end

  test "it converts the port to an integer if it is a string", %{query: query, config: config} do
    config = config |> Map.put(:port, "4430")
    assert Url.build(query, config) == "https://example.com:4430/path?foo=bar"
  end

  test "it allows passing scheme with trailing ://", %{query: query, config: config} do
    config = config |> Map.put(:scheme, "https://")
    assert Url.build(query, config) == "https://example.com/path?foo=bar"
  end

  test "it accepts params as a list of keywords", %{query: query, config: config} do
    query = query |> Map.put(:params, foo: :bar)
    assert Url.build(query, config) == "https://example.com/path?foo=bar"
  end

  test "it does not have trailing ? when params is an empty map", %{query: query, config: config} do
    query = query |> Map.put(:params, %{})
    assert Url.build(query, config) == "https://example.com/path"
  end

  test "it does not have trailing ? when params is an empty list", %{query: query, config: config} do
    query = query |> Map.put(:params, [])
    assert Url.build(query, config) == "https://example.com/path"
  end

  test "it accepts query without params key", %{query: query, config: config} do
    query = query |> Map.delete(:params)
    assert Url.build(query, config) == "https://example.com/path"
  end

  test "it cleans up excessive slashes in the path", %{query: query, config: config} do
    query = query |> Map.put(:path, "//path///with/too/many//slashes//")
    assert Url.build(query, config) == "https://example.com/path/with/too/many/slashes/?foo=bar"
  end

  test "it ignores empty parameter key", %{query: query, config: config} do
    query = query |> Map.put(:params, %{"foo" => "bar", "" => 1})
    assert Url.build(query, config) == "https://example.com/path?foo=bar"
  end

  test "it ignores nil parameter key", %{query: query, config: config} do
    query = query |> Map.put(:params, %{"foo" => "bar", nil => 1})
    assert Url.build(query, config) == "https://example.com/path?foo=bar"
  end

  describe "get_path" do
    test "it uses S3-specific URL parsing to keep the path for S3 services" do
      url = "https://example.com/uploads/invalid path but+valid//for#s3/haha.txt"
      assert Url.get_path(url, :s3) == "/uploads/invalid path but+valid//for#s3/haha.txt"
    end

    test "it uses standard URL parsing for the path for non-S3 services" do
      url = "https://example.com/uploads/invalid path but+valid//for#i-am-anchor"
      assert Url.get_path(url) == "/uploads/invalid path but+valid//for"
    end
  end
end
