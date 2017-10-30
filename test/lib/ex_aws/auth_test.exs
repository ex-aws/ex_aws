defmodule ExAws.AuthTest do
  use ExUnit.Case, async: true
  import ExAws.Auth, only: [
    headers: 6,
    build_canonical_request: 5
  ]
  import ExAws.Auth.Utils, only: [
    uri_encode: 1
  ]

  @config %{
    access_key_id: "AKIAIOSFODNN7EXAMPLE",
    secret_access_key: "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
    region: "us-east-1"
  }

  test "headers includes headers from config" do
    headers_config = Map.merge(@config, %{
        headers: [
          {"Fancy-Header-A", "So Fancy"},
          {"Fancy-Header-B", "More Fancy"}
        ]
    })

    # Cram the generated headers into a map for easy lookup
    result = headers(:post, "http://localhost/path", :test, headers_config, [], "")
    |> elem(1)
    |> Enum.into(%{})

    assert result["Fancy-Header-A"] == "So Fancy"
    assert result["Fancy-Header-B"] == "More Fancy"
    assert result["Authorization"] =~ "fancy-header-a;fancy-header-b"
  end

  test "build_canonical_request can handle : " do
    expected = "GET\n/bar%3Abaz%40blag\n\n\n\n\ne3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
    path = URI.parse("http://foo.com/bar:baz@blag").path |> uri_encode
    assert build_canonical_request(:get, path, "", %{}, "") == expected
  end

  test "presigned url" do
    # Data taken from example in:
    # http://docs.aws.amazon.com/AmazonS3/latest/API/sigv4-query-string-auth.html
    http_method = :get
    url = "https://examplebucket.s3.amazonaws.com/test.txt"
    service = :s3
    datetime = {{2013, 5, 24}, {0, 0, 0}}
    expires = 86400
    actual = ExAws.Auth.presigned_url(http_method, url, service, datetime, @config, expires)

    expected =
      "https://examplebucket.s3.amazonaws.com/test.txt" <>
      "?X-Amz-Algorithm=AWS4-HMAC-SHA256" <>
      "&X-Amz-Credential=AKIAIOSFODNN7EXAMPLE%2F20130524%2Fus-east-1%2Fs3%2Faws4_request" <>
      "&X-Amz-Date=20130524T000000Z" <>
      "&X-Amz-Expires=86400" <>
      "&X-Amz-SignedHeaders=host" <>
      "&X-Amz-Signature=aeeed9bbccd4d02ee5c0109b86d86835f995330da4c265957d157751f604d404"

    assert {:ok, expected} == actual
  end

  test "presigned url with query params" do
    # Data taken from example in:
    # http://docs.aws.amazon.com/AmazonS3/latest/API/sigv4-query-string-auth.html
    http_method = :put
    url = "https://examplebucket.s3.amazonaws.com/test.txt"
    service = :s3
    datetime = {{2013, 5, 24}, {0, 0, 0}}
    expires = 86400
    query_params = [partNumber: 1, uploadId: "sample.upload.id"]
    actual = ExAws.Auth.presigned_url(http_method, url, service, datetime, @config, expires, query_params)

    expected =
      "https://examplebucket.s3.amazonaws.com/test.txt" <>
      "?partNumber=1" <>
      "&uploadId=sample.upload.id" <>
      "&X-Amz-Algorithm=AWS4-HMAC-SHA256" <>
      "&X-Amz-Credential=AKIAIOSFODNN7EXAMPLE%2F20130524%2Fus-east-1%2Fs3%2Faws4_request" <>
      "&X-Amz-Date=20130524T000000Z" <>
      "&X-Amz-Expires=86400" <>
      "&X-Amz-SignedHeaders=host" <>
      "&X-Amz-Signature=1fdac5451b2996880dc23162853ce76e4cf0a05257e430aec59e309ecd126ade"

    assert {:ok, expected} == actual
  end
end
