defmodule ExAws.AuthTest do
  use ExUnit.Case, async: true

  import ExAws.Auth,
    only: [
      build_canonical_request: 5
    ]

  import ExAws.Auth.Utils,
    only: [
      uri_encode: 1
    ]

  @config %{
    access_key_id: "AKIAIOSFODNN7EXAMPLE",
    secret_access_key: "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
    region: "us-east-1"
  }

  test "build_canonical_request can handle : " do
    expected =
      "GET\n/bar%3Abaz%40blag\n\n\n\n\ne3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

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

    actual =
      ExAws.Auth.presigned_url(
        http_method,
        url,
        service,
        datetime,
        @config,
        expires,
        query_params
      )

    expected =
      "https://examplebucket.s3.amazonaws.com/test.txt?partNumber=1&uploadId=sample.upload.id&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIOSFODNN7EXAMPLE%2F20130524%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20130524T000000Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host%3Bpartnumber%3Buploadid&X-Amz-Signature=1412f890faf2f24896692c9508d79a5e31585789e2529c98c6516fcff3d0bf51"

    assert {:ok, expected} == actual
  end

  test "presigned url with empty request body" do
    # Required for RDS generate_db_token
    # Data taken from botocore https://github.com/boto/botocore/blob/master/tests/unit/test_signers.py#L922
    http_method = :get
    url = "https://prod-instance.us-east-1.rds.amazonaws.com:3306/"
    service = :"rds-db"
    datetime = {{2016, 11, 7}, {17, 39, 33}}
    expires = 900
    query_params = [Action: "connect", DBUser: "someusername"]
    body = ""
    config = %{access_key_id: "akid", secret_access_key: "skid", region: "us-east-1"}

    actual =
      ExAws.Auth.presigned_url(
        http_method,
        url,
        service,
        datetime,
        config,
        expires,
        query_params,
        body
      )

    expected =
      "https://prod-instance.us-east-1.rds.amazonaws.com:3306/?Action=connect&DBUser=someusername&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=akid%2F20161107%2Fus-east-1%2Frds-db%2Faws4_request&X-Amz-Date=20161107T173933Z&X-Amz-Expires=900&X-Amz-SignedHeaders=action%3Bdbuser%3Bhost&X-Amz-Signature=d5c838ff074ccc8246e3ee56dd8607b106afb5624321cb5ad982e57fcd346dfa"

    assert {:ok, expected} == actual
  end

  test "allow custom host & region" do
    config =
      ExAws.Config.new(:s3, host: %{"nyc3" => "nyc3.digitaloceanspaces.com"}, region: "nyc3")

    assert config.region == "nyc3"
    assert config.host == "nyc3.digitaloceanspaces.com"

    config = ExAws.Config.new(:s3, host: "nyc3.digitaloceanspaces.com", region: "nyc3")
    assert config.region == "nyc3"
    assert config.host == "nyc3.digitaloceanspaces.com"
  end
end
