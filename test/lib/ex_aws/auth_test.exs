defmodule ExAws.AuthTest do
  use ExUnit.Case, async: true
  import ExAws.Auth, only: [
    build_canonical_request: 4
  ]

  test "build_canonical_request can handle : " do
    expected = "GET\n/bar%3Abaz%40blag\n\n\n\n\ne3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
    assert build_canonical_request(:get, "http://foo.com/bar:baz@blag", %{}, "") == expected
  end

  test "presigned url" do
    # Data taken from example in:
    # http://docs.aws.amazon.com/AmazonS3/latest/API/sigv4-query-string-auth.html
    http_method = :get
    url = "https://examplebucket.s3.amazonaws.com/test.txt"
    service = :s3
    datetime = {{2013, 5, 24}, {0, 0, 0}}
    config = [access_key_id: "AKIAIOSFODNN7EXAMPLE",
              secret_access_key: "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
              region: "us-east-1"
             ]
    expires = 86400
    actual = ExAws.Auth.presigned_url(http_method, url, service, datetime, config, expires)

    expected = "https://examplebucket.s3.amazonaws.com/test.txt?X-Amz-Algorithm=AWS4-HMAC-SHA256" <>
      "&X-Amz-Credential=AKIAIOSFODNN7EXAMPLE/20130524/us-east-1/s3/aws4_request" <>
      "&X-Amz-Date=20130524T000000Z" <>
      "&X-Amz-Expires=86400" <>
      "&X-Amz-SignedHeaders=host" <>
      "&X-Amz-Signature=967eb6d21e6164b944401d81f83d4946b0509ce03ddbae333d14651e2e007cc6"

    assert expected == actual
  end
end
