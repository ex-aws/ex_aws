defmodule ExAws.S3Test do
  use ExUnit.Case, async: true
  alias ExAws.{S3, Operation}

  test "#get_object" do
    expected = %Operation.S3{bucket: "bucket", headers: %{"x-amz-server-side-encryption-customer-algorithm" => "md5"}, params: %{"response-content-type" => "application/json"}, path: "object.json", http_method: :get}
    assert expected == S3.get_object("bucket", "object.json", response: [content_type: "application/json"], encryption: [customer_algorithm: "md5"])
  end

  test "#put_object" do
    expected = %Operation.S3{
      body: "data", bucket: "bucket",
      headers: %{
        "content-encoding" => "application/json",
        "x-amz-acl" => "public-read",
        "x-amz-server-side-encryption" => "AES256",
        "x-amz-storage-class" => "spicy",
        "content-md5" => "asdf",
        "x-amz-meta-foo" => "sqiggles"},
      path: "object.json",
      http_method: :put
    }

    assert expected == S3.put_object("bucket", "object.json", "data",
      content_encoding: "application/json",
      storage_class: "spicy",
      content_md5: "asdf",
      acl: :public_read,
      encryption: "AES256",
      meta: [foo: "sqiggles"]
    )
  end

  test "#put_bucket with non-us-east-1 region" do
    region = "not-us-east-1"
    bucket = "new.bucket"
    expected = %Operation.S3{
      body: """
      <CreateBucketConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
        <LocationConstraint>#{region}</LocationConstraint>
      </CreateBucketConfiguration>
      """,
      bucket: bucket,
      path: "/",
      http_method: :put
    }

    assert expected == S3.put_bucket(bucket, region)
  end

  test "#put_bucket with us-east-1 region" do
    bucket = "new.bucket"
    expected = %Operation.S3{
      body: "",
      bucket: bucket,
      path: "/",
      http_method: :put
    }

    assert expected == S3.put_bucket(bucket, "us-east-1")
  end

  test "#put_bucket with empty region" do
    bucket = "new.bucket"
    expected = %Operation.S3{
      body: "",
      bucket: bucket,
      path: "/",
      http_method: :put
    }

    assert expected == S3.put_bucket(bucket, "")
  end

  test "#put_object_copy" do
    expected = %Operation.S3{bucket: "dest-bucket",
      headers: %{"x-amz-acl" => "public-read",
        "x-amz-copy-source" => "/src-bucket/src-object",
        "x-amz-server-side-encryption-customer-algorithm" => "md5",
        "x-amz-copy-source-server-side-encryption-customer-algorithm" => "md5",
        "x-amz-meta-foo" => "sqiggles"},
      path: "dest-object", http_method: :put}
    assert expected == S3.put_object_copy("dest-bucket", "dest-object", "src-bucket", "src-object",
      source_encryption: [customer_algorithm: "md5"],
      acl: :public_read,
      destination_encryption: [customer_algorithm: "md5"],
      meta: [foo: "sqiggles"])
  end

  test "#put_object_copy basic" do
    expected = %Operation.S3{bucket: "dest-bucket", headers: %{"x-amz-copy-source" => "/src-bucket/src-object"}, path: "dest-object", http_method: :put}
    assert expected == S3.put_object_copy("dest-bucket", "dest-object", "src-bucket", "src-object")
  end

  test "#put_object_copy utf8" do
    expected = %Operation.S3{bucket: "dest-bucket", headers: %{"x-amz-copy-source" => "/src-bucket//foo/%C3%BC.txt"}, path: "dest-object", http_method: :put}
    assert expected == S3.put_object_copy("dest-bucket", "dest-object", "src-bucket", "/foo/ü.txt")
  end

  test "#complete_multipart_upload" do
    expected = %Operation.S3{
      body: "<CompleteMultipartUpload><Part><PartNumber>1</PartNumber><ETag>foo</ETag></Part><Part><PartNumber>2</PartNumber><ETag>bar</ETag></Part></CompleteMultipartUpload>",
      bucket: "bucket", params: %{"uploadId" => "upload-id"}, path: "object", http_method: :post, parser: &ExAws.S3.Parsers.parse_complete_multipart_upload/1}
    assert expected == S3.complete_multipart_upload("bucket", "object", "upload-id", %{1 => "foo", 2 => "bar"})
  end

  test "#upload_part_copy" do
    expected = %Operation.S3{bucket: "dest-bucket",
      headers: %{"x-amz-copy-source" => "/src-bucket/src-object",
        "x-amz-copy-source-range" => "bytes=1-9",
        "x-amz-copy-source-server-side-encryption-customer-algorithm" => "md5"},
      path: "dest-object", http_method: :put, parser: &ExAws.S3.Parsers.parse_upload_part_copy/1}

    assert expected == S3.upload_part_copy("dest-bucket", "dest-object", "src-bucket", "src-object", source_encryption: [customer_algorithm: "md5"], copy_source_range: 1..9)
  end

  test "#delete_multiple_objects" do
    expected = %Operation.S3{body: "<?xml version=\"1.0\" encoding=\"UTF-8\"?><Delete><Object><Key>foo</Key></Object><Object><Key>bar</Key><VersionId>v1</VersionId></Object></Delete>",
      bucket: "bucket", path: "/?delete", headers: %{"content-md5" => "lvfX5nHeLllWDA7QnpsnrA=="}, http_method: :post}

    assert expected == S3.delete_multiple_objects("bucket", ["foo", {"bar", "v1"}])
  end

  test "#post_object_restore" do
    expected = %Operation.S3{body: "<RestoreRequest xmlns=\"http://s3.amazonaws.com/doc/2006-3-01\">\n  <Days>5</Days>\n</RestoreRequest>\n",
      bucket: "bucket", params: %{"versionId" => 123}, path: "object",
      resource: "restore", http_method: :post}
    assert expected == S3.post_object_restore("bucket", "object", 5, version_id: 123)
  end

  test "#head_object" do
    expected = %Operation.S3{bucket: "bucket",
      headers: %{"x-amz-server-side-encryption-customer-algorithm" => "md5"},
      params: %{"versionId" => 123}, path: "object", http_method: :head}

    assert expected == S3.head_object("bucket", "object", encryption: [customer_algorithm: "md5"], version_id: 123)
  end

  test "#presigned_url no opts" do
    {:ok, url} = S3.presigned_url(config(), :get, "bucket", "foo.txt")
    assert_pre_signed_url(url, "https://s3.amazonaws.com/bucket/foo.txt", "3600")
  end

  test "#presigned_url passing expires_in option" do
    {:ok, url} = S3.presigned_url(config(), :get, "bucket", "foo.txt", [expires_in: 100])
    assert_pre_signed_url(url, "https://s3.amazonaws.com/bucket/foo.txt", "100")
  end

  test "#presigned_url passing virtual_host=false option" do
    {:ok, url} = S3.presigned_url(config(), :get, "bucket", "foo.txt", [virtual_host: false])
    assert_pre_signed_url(url, "https://s3.amazonaws.com/bucket/foo.txt", "3600")
  end

  test "#presigned_url passing virtual_host=true option" do
    {:ok, url} = S3.presigned_url(config(), :get, "bucket", "foo.txt", [virtual_host: true])
    assert_pre_signed_url(url, "https://bucket.s3.amazonaws.com/foo.txt", "3600")
  end

  test "#presigned_url passing both expires_in and virtual_host options" do
    opts = [expires_in: 100, virtual_host: true]
    {:ok, url} = S3.presigned_url(config(), :get, "bucket", "foo.txt", opts)
    assert_pre_signed_url(url, "https://bucket.s3.amazonaws.com/foo.txt", "100")
  end

  test "#presigned_url passing query_params option" do
    query_params = [
      key_one: "value_one",
      key_two: "value_two"
    ]
    {:ok, url} = S3.presigned_url(config(), :get, "bucket", "foo.txt", [query_params: query_params])
    uri = URI.parse(url)
    actual_query = URI.query_decoder(uri.query) |> Enum.map(&(&1))
    assert [{"key_one", "value_one"},
            {"key_two", "value_two"},
            {"X-Amz-Algorithm", "AWS4-HMAC-SHA256"},
            {"X-Amz-Credential", _},
            {"X-Amz-Date", _},
            {"X-Amz-Expires", _},
            {"X-Amz-SignedHeaders", "host"},
            {"X-Amz-Signature", _}] = actual_query
  end

  test "#presigned_url file is path with slash" do
    {:ok, url} = S3.presigned_url(config(), :get, "bucket", "/foo/bar.txt")
    assert_pre_signed_url(url, "https://s3.amazonaws.com/bucket/foo/bar.txt", "3600")
  end

  test "#presigned_url file is key with query params" do
    {:ok, url} = S3.presigned_url(config(), :get, "bucket", "/foo/bar.txt?d=400")
    assert_pre_signed_url(url, "https://s3.amazonaws.com/bucket/foo/bar.txt%3Fd%3D400", "3600")
  end

  test "#presigned_url raises exception on bad expires_in option" do
    opts = [expires_in: 60 * 60 * 24 * 8]
    {:error, reason} = S3.presigned_url(config(), :get, "bucket", "foo.txt", opts)
    assert "expires_in_exceeds_one_week" == reason
  end

  test "#presigned_url respects port configuration" do
    config = ExAws.Config.new(:s3, [port: 1234])
    {:ok, url} = S3.presigned_url(config, :get, "bucket", "foo.txt")
    uri = URI.parse(url)
    assert uri.port == 1234
  end

  defp assert_pre_signed_url(url, expected_scheme_host_path, expected_expire) do
    uri = URI.parse(url)
    assert expected_scheme_host_path == "#{uri.scheme}://#{uri.host}#{uri.path}"
    headers = URI.query_decoder(uri.query) |> Enum.map(&(&1))
    assert [{"X-Amz-Algorithm", "AWS4-HMAC-SHA256"},
            {"X-Amz-Credential", _},
            {"X-Amz-Date", _},
            {"X-Amz-Expires", _},
            {"X-Amz-SignedHeaders", "host"},
            {"X-Amz-Signature", _}] = headers
    assert {"X-Amz-Expires", expected_expire} ==
      List.keyfind(headers, "X-Amz-Expires", 0)
  end

  defp config(), do: ExAws.Config.new(:s3, [])
end
