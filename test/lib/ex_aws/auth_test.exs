defmodule ExAws.AuthTest do
  use ExUnit.Case, async: true
  import ExAws.Auth, only: [
    build_canonical_request: 4
  ]

  test "build_canonical_request can handle : " do
    expected = "GET\n/bar%3Abaz%40blag\n\n\n\n\ne3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
    assert build_canonical_request("get", "http://foo.com/bar:baz@blag", %{}, "") == expected
  end
end
