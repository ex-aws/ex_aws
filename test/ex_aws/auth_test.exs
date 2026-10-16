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

  @s3_config %{
    access_key_id: "AKIAIOSFODNN7EXAMPLE",
    secret_access_key: "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
    region: "us-east-1",
    scheme: "https://",
    host: "s3.amazonaws.com",
    port: 443,
    normalize_path: true
  }

  describe "headers/6 for S3 object keys" do
    test "signs the whole percent-encoded key rather than a key truncated at ?" do
      operation = %ExAws.Operation.S3{path: "/victim-bucket/export.dump?.txt"}
      url = ExAws.Request.Url.build(operation, @s3_config)
      assert url == "https://s3.amazonaws.com/victim-bucket/export.dump%3F.txt"

      assert {:ok, headers} = headers(:get, url, :s3, @s3_config, [], "")

      assert authorization(headers) ==
               expected_authorization(:get, "/victim-bucket/export.dump%3F.txt", "", headers, "")
    end

    test "does not encode the key a second time" do
      operation = %ExAws.Operation.S3{
        path: "/bucket/dir/a b+c#d%25.txt",
        params: %{"versionId" => "1"}
      }

      url = ExAws.Request.Url.build(operation, @s3_config)
      assert {:ok, headers} = headers(:get, url, :s3, @s3_config, [], "")

      assert authorization(headers) ==
               expected_authorization(
                 :get,
                 "/bucket/dir/a%20b%2Bc%23d%2525.txt",
                 "versionId=1",
                 headers,
                 ""
               )
    end
  end

  # `@config` is rebound to `ExAws.Config.new/2` further up, so the presigned
  # URL tests below pin the credentials they sign with.
  @presign_config %{
    access_key_id: "AKIAIOSFODNN7EXAMPLE",
    secret_access_key: "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
    region: "us-east-1"
  }
  @presign_datetime {{2013, 5, 24}, {0, 0, 0}}
  @presign_amz_query "X-Amz-Algorithm=AWS4-HMAC-SHA256" <>
                       "&X-Amz-Credential=AKIAIOSFODNN7EXAMPLE%2F20130524%2Fus-east-1%2Fs3%2Faws4_request" <>
                       "&X-Amz-Date=20130524T000000Z" <>
                       "&X-Amz-Expires=86400" <>
                       "&X-Amz-SignedHeaders=host"

  describe "presigned_url/9 given a %URI{}" do
    test "produces the same URL as the string form for a key without ?" do
      # Same input and expectation as "presigned url with special characters".
      uri = %URI{
        scheme: "https",
        host: "examplebucket.s3.amazonaws.com",
        path: "/folder-one/test+ #3.txt"
      }

      assert {:ok, url} =
               ExAws.Auth.presigned_url(:get, uri, :s3, @presign_datetime, @presign_config, 86400)

      assert url ==
               "https://examplebucket.s3.amazonaws.com/folder-one/test%2B%20%233.txt" <>
                 "?X-Amz-Algorithm=AWS4-HMAC-SHA256" <>
                 "&X-Amz-Credential=AKIAIOSFODNN7EXAMPLE%2F20130524%2Fus-east-1%2Fs3%2Faws4_request" <>
                 "&X-Amz-Date=20130524T000000Z" <>
                 "&X-Amz-Expires=86400" <>
                 "&X-Amz-SignedHeaders=host" <>
                 "&X-Amz-Signature=d1892eeaf3110a6c1a805d8ad7a0c825a72a4255c7f48908922be55a7c4ae753"
    end

    test "keeps a ? in the object key out of the query string" do
      uri = %URI{
        scheme: "https",
        host: "examplebucket.s3.amazonaws.com",
        path: "/export.dump?.txt"
      }

      assert {:ok, url} =
               ExAws.Auth.presigned_url(:get, uri, :s3, @presign_datetime, @presign_config, 86400)

      assert url ==
               "https://examplebucket.s3.amazonaws.com/export.dump%3F.txt?" <>
                 @presign_amz_query <>
                 "&X-Amz-Signature=" <>
                 presigned_signature(
                   :get,
                   "/export.dump%3F.txt",
                   @presign_amz_query,
                   "examplebucket.s3.amazonaws.com"
                 )
    end

    test "does not let a ? in the object key inject a sub-resource" do
      uri = %URI{scheme: "https", host: "examplebucket.s3.amazonaws.com", path: "/report.pdf?acl"}

      assert {:ok, url} =
               ExAws.Auth.presigned_url(:put, uri, :s3, @presign_datetime, @presign_config, 86400)

      assert %URI{path: "/report.pdf%3Facl", query: query} = URI.parse(url)
      refute Map.has_key?(URI.decode_query(query), "acl")

      assert url ==
               "https://examplebucket.s3.amazonaws.com/report.pdf%3Facl?" <>
                 @presign_amz_query <>
                 "&X-Amz-Signature=" <>
                 presigned_signature(
                   :put,
                   "/report.pdf%3Facl",
                   @presign_amz_query,
                   "examplebucket.s3.amazonaws.com"
                 )
    end

    test "signs query params from uri.query and from query_params" do
      uri = %URI{
        scheme: "https",
        host: "examplebucket.s3.amazonaws.com",
        path: "/a?b.txt",
        query: "versionId=1"
      }

      assert {:ok, url} =
               ExAws.Auth.presigned_url(:get, uri, :s3, @presign_datetime, @presign_config, 86400,
                 partNumber: 1
               )

      # Uppercase sorts before lowercase, so the canonical (signed) query puts
      # the X-Amz-* params first.
      canonical_query = @presign_amz_query <> "&partNumber=1&versionId=1"

      assert url ==
               "https://examplebucket.s3.amazonaws.com/a%3Fb.txt?partNumber=1&versionId=1&" <>
                 @presign_amz_query <>
                 "&X-Amz-Signature=" <>
                 presigned_signature(
                   :get,
                   "/a%3Fb.txt",
                   canonical_query,
                   "examplebucket.s3.amazonaws.com"
                 )
    end

    test "derives the host header from host and port when authority is not set" do
      uri = %URI{scheme: "http", host: "localhost", port: 9000, path: "/bucket/a b.txt"}

      assert {:ok, url} =
               ExAws.Auth.presigned_url(:get, uri, :s3, @presign_datetime, @presign_config, 86400)

      assert url ==
               "http://localhost:9000/bucket/a%20b.txt?" <>
                 @presign_amz_query <>
                 "&X-Amz-Signature=" <>
                 presigned_signature(
                   :get,
                   "/bucket/a%20b.txt",
                   @presign_amz_query,
                   "localhost:9000"
                 )
    end

    test "omits the default port from the host" do
      uri = %URI{scheme: "https", host: "s3.amazonaws.com", port: 443, path: "/bucket/a.txt"}

      assert {:ok, url} =
               ExAws.Auth.presigned_url(:get, uri, :s3, @presign_datetime, @presign_config, 86400)

      assert String.starts_with?(url, "https://s3.amazonaws.com/bucket/a.txt?")
    end

    test "keeps an explicit port in the authority of a parsed URI" do
      uri = URI.parse("https://s3.amazonaws.com:443/bucket")
      uri = %{uri | path: uri.path <> "/a?b.txt"}

      assert {:ok, url} =
               ExAws.Auth.presigned_url(:get, uri, :s3, @presign_datetime, @presign_config, 86400)

      assert String.starts_with?(url, "https://s3.amazonaws.com:443/bucket/a%3Fb.txt?")
    end
  end

  # Recomputes the SigV4 query-string signature for a presigned URL with only
  # the host header signed and an unsigned payload. See
  # https://docs.aws.amazon.com/AmazonS3/latest/API/sigv4-query-string-auth.html
  defp presigned_signature(method, canonical_path, canonical_query, host) do
    canonical_request =
      build_canonical_request(method, canonical_path, canonical_query, [{"host", host}], nil)

    scope =
      ExAws.Auth.Credentials.generate_credential_scope_v4(
        "s3",
        @presign_config,
        @presign_datetime
      )

    string_to_sign =
      "AWS4-HMAC-SHA256\n20130524T000000Z\n#{scope}\n#{ExAws.Auth.Utils.hash_sha256(canonical_request)}"

    ExAws.Auth.Signatures.generate_signature_v4(
      "s3",
      @presign_config,
      @presign_datetime,
      string_to_sign
    )
  end

  defp authorization(headers) do
    {"Authorization", value} = List.keyfind(headers, "Authorization", 0)
    value
  end

  # Recomputes the SigV4 Authorization header from the returned headers, so the
  # expectation does not depend on the clock. See
  # https://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-header-based-auth.html
  defp expected_authorization(method, canonical_path, canonical_query, headers, body) do
    {"x-amz-date", amz_date} = List.keyfind(headers, "x-amz-date", 0)

    <<y::binary-4, mo::binary-2, d::binary-2, "T", h::binary-2, mi::binary-2, sec::binary-2, "Z">> =
      amz_date

    datetime =
      {{String.to_integer(y), String.to_integer(mo), String.to_integer(d)},
       {String.to_integer(h), String.to_integer(mi), String.to_integer(sec)}}

    signed_headers = List.keydelete(headers, "Authorization", 0)

    canonical_request =
      build_canonical_request(method, canonical_path, canonical_query, signed_headers, body)

    scope = ExAws.Auth.Credentials.generate_credential_scope_v4("s3", @s3_config, datetime)

    string_to_sign =
      "AWS4-HMAC-SHA256\n#{amz_date}\n#{scope}\n#{ExAws.Auth.Utils.hash_sha256(canonical_request)}"

    signature =
      ExAws.Auth.Signatures.generate_signature_v4("s3", @s3_config, datetime, string_to_sign)

    credential = ExAws.Auth.Credentials.generate_credential_v4("s3", @s3_config, datetime)

    "AWS4-HMAC-SHA256 Credential=#{credential},SignedHeaders=host;x-amz-date,Signature=#{signature}"
  end
end
