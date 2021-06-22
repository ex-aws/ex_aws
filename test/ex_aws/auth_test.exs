defmodule ExAws.AuthTest do
  use ExUnit.Case, async: true

  import ExAws.Auth,
    only: [
      headers: 6,
      build_canonical_request: 5
    ]

  import ExAws.Request.Url,
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

  test "build_canonical_request ignores unsignable headers" do
    path = URI.parse("http://foo.com/bar:baz@blag").path |> uri_encode
    without_unsignable_header = build_canonical_request(:get, path, "", %{}, "")

    with_unsignable_header =
      build_canonical_request(
        :get,
        path,
        "",
        %{
          "X-Amzn-Trace-Id" => "1-aaaaaaa-bbbbbbbbbbbbb"
        },
        ""
      )

    assert with_unsignable_header == without_unsignable_header
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

  test "presigned url with special characters" do
    http_method = :get
    url = "https://examplebucket.s3.amazonaws.com/folder-one/test+ #3.txt"
    service = :s3
    datetime = {{2013, 5, 24}, {0, 0, 0}}
    expires = 86400
    actual = ExAws.Auth.presigned_url(http_method, url, service, datetime, @config, expires)

    expected =
      "https://examplebucket.s3.amazonaws.com/folder-one/test%2B%20%233.txt" <>
        "?X-Amz-Algorithm=AWS4-HMAC-SHA256" <>
        "&X-Amz-Credential=AKIAIOSFODNN7EXAMPLE%2F20130524%2Fus-east-1%2Fs3%2Faws4_request" <>
        "&X-Amz-Date=20130524T000000Z" <>
        "&X-Amz-Expires=86400" <>
        "&X-Amz-SignedHeaders=host" <>
        "&X-Amz-Signature=d1892eeaf3110a6c1a805d8ad7a0c825a72a4255c7f48908922be55a7c4ae753"

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
      "https://examplebucket.s3.amazonaws.com/test.txt?partNumber=1&uploadId=sample.upload.id&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIOSFODNN7EXAMPLE%2F20130524%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20130524T000000Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=1fdac5451b2996880dc23162853ce76e4cf0a05257e430aec59e309ecd126ade"

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
      "https://prod-instance.us-east-1.rds.amazonaws.com:3306/?Action=connect&DBUser=someusername&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=akid%2F20161107%2Fus-east-1%2Frds-db%2Faws4_request&X-Amz-Date=20161107T173933Z&X-Amz-Expires=900&X-Amz-SignedHeaders=host&X-Amz-Signature=d1138cdbc0ca63eec012ec0fc6c2267e03642168f5884a7795320d4c18374c61"

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

  describe "headers/6" do
    @config ExAws.Config.new(:s3,
              host: "nyc3.digitaloceanspaces.com",
              region: "eu-west-1",
              secret_access_key: "",
              access_key_id: ""
            )

    test "builds authentication headers with X-Amzn-Trace-Id" do
      assert {:ok, headers} =
               headers(
                 :get,
                 "https://my-bucket.s3-eu-west-1.amazonaws.com",
                 :s3,
                 @config,
                 [
                   {"X-Amzn-Trace-Id", "1-aaaaaaa-bbbbbbbbbbbbb"},
                   {"content-type", "application/json"}
                 ],
                 _body = ""
               )

      {"Authorization", auth_header} = List.keyfind(headers, "Authorization", 0)
      assert String.contains?(auth_header, "x-amz-date")
      assert String.contains?(auth_header, "host")
      assert String.contains?(auth_header, "content-type")
      refute String.contains?(auth_header, "x-amz-security-token")
      refute String.contains?(auth_header, "x-amzn-trace-id")
    end

    test "keeps unsignable headers in the headers list" do
      assert {:ok, headers} =
               headers(
                 :get,
                 "https://my-bucket.s3-eu-west-1.amazonaws.com",
                 :s3,
                 @config,
                 [
                   {"X-Amzn-Trace-Id", "1-aaaaaaa-bbbbbbbbbbbbb"},
                   {"content-type", "application/json"}
                 ],
                 _body = ""
               )

      assert {"X-Amzn-Trace-Id", "1-aaaaaaa-bbbbbbbbbbbbb"} =
               List.keyfind(headers, "X-Amzn-Trace-Id", 0)
    end

    test "when security token is provided" do
      assert {:ok, headers} =
               headers(
                 :get,
                 "https://my-bucket.s3-eu-west-1.amazonaws.com",
                 :s3,
                 @config |> Map.put(:security_token, "abc"),
                 [
                   {"content-type", "application/json"}
                 ],
                 _body = ""
               )

      {"Authorization", auth_header} = List.keyfind(headers, "Authorization", 0)

      assert String.contains?(auth_header, "x-amz-security-token")
    end
  end
end
