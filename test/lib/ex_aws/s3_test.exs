defmodule Test.Dummy.S3 do
  use ExAws.S3.Client

  def config_root, do: Application.get_all_env(:ex_aws)

  def request(_client, _http_method, bucket, path, data \\ []) do
    data
    |> Enum.into(%{})
    |> Map.put(:bucket, bucket)
    |> Map.put(:path, path)
  end
end

defmodule ExAws.S3Test do
  use ExUnit.Case, async: true
  alias Test.Dummy.S3

  test "#get_object" do
    expected = %{bucket: "bucket", headers: %{"x-amz-server-side-encryption-customer-algorithm" => "md5"}, params: %{"response-content-type" => "application/json"}, path: "object.json"}
    assert expected == S3.get_object("bucket", "object.json", response: [content_type: "application/json"], encryption: [customer_algorithm: "md5"])
  end

  test "#put_object" do
    expected = %{
      body: "data", bucket: "bucket",
      headers: %{
        "content-encoding" => "application/json",
        "x-amz-acl" => "public-read",
        "x-amz-server-side-encryption" => "AES256",
        "x-amz-storage-class" => "spicy",
        "x-amz-meta-foo" => "sqiggles"},
      path: "object.json"}

    assert expected == S3.put_object("bucket", "object.json", "data",
      content_encoding: "application/json",
      storage_class: "spicy",
      acl: :public_read,
      encryption: "AES256",
      meta: [foo: "sqiggles"]
    )
  end

  test "#put_object_copy" do
    expected = %{bucket: "dest-bucket",
      headers: %{"x-amz-acl" => "public-read",
        "x-amz-copy-source" => "/src-bucket/src-object",
        "x-amz-server-side-encryption-customer-algorithm" => "md5",
        "x-amz-copy-source-server-side-encryption-customer-algorithm" => "md5",
        "x-amz-meta-foo" => "sqiggles"},
      path: "dest-object"}
    assert expected == S3.put_object_copy("dest-bucket", "dest-object", "src-bucket", "src-object",
      source_encryption: [customer_algorithm: "md5"],
      acl: :public_read,
      destination_encryption: [customer_algorithm: "md5"],
      meta: [foo: "sqiggles"])
  end

  test "#put_object_copy basic" do
    expected = %{bucket: "dest-bucket", headers: %{"x-amz-copy-source" => "/src-bucket/src-object"}, path: "dest-object"}
    assert expected == S3.put_object_copy("dest-bucket", "dest-object", "src-bucket", "src-object")
  end

  test "#put_object_copy utf8" do
    expected = %{bucket: "dest-bucket", headers: %{"x-amz-copy-source" => "/src-bucket//foo/%C3%BC.txt"}, path: "dest-object"}
    assert expected == S3.put_object_copy("dest-bucket", "dest-object", "src-bucket", "/foo/ü.txt")
  end

  test "#complete_multipart_upload" do
    expected = %{
      body: "<CompleteMultipartUpload><Part><PartNumber>1</PartNumber><ETag>foo</ETag></Part><Part><PartNumber>2</PartNumber><ETag>bar</ETag></Part></CompleteMultipartUpload>",
      bucket: "bucket", params: %{"uploadId" => "upload-id"}, path: "object"}
    assert expected == S3.complete_multipart_upload("bucket", "object", "upload-id", %{1 => "foo", 2 => "bar"})
  end

  test "#upload_part_copy" do
    expected = %{bucket: "dest-bucket",
      headers: %{"x-amz-copy-source" => "/src-bucket/src-object",
        "x-amz-copy-source-range" => "bytes=1-9",
        "x-amz-copy-source-server-side-encryption-customer-algorithm" => "md5"},
      path: "dest-object"}

    assert expected == S3.upload_part_copy("dest-bucket", "dest-object", "src-bucket", "src-object", source_encryption: [customer_algorithm: "md5"], copy_source_range: 1..9)
  end

  test "#delete_multiple_objects" do
    expected = %{body: "<?xml version=\"1.0\" encoding=\"UTF-8\"?><Delete><Object><Key>foo</Key></Object><Object><Key>bar</Key><VersionId>v1</VersionId></Object></Delete>",
      bucket: "bucket", path: "/?delete", headers: %{"content-md5" => "lvfX5nHeLllWDA7QnpsnrA=="}}

    assert expected == S3.delete_multiple_objects("bucket", ["foo", {"bar", "v1"}])
  end

  test "#post_object_restore" do
    expected = %{body: "<RestoreRequest xmlns=\"http://s3.amazonaws.com/doc/2006-3-01\">\n  <Days>5</Days>\n</RestoreRequest>\n",
      bucket: "bucket", params: %{"versionId" => 123}, path: "object",
      resource: "restore"}
    assert expected == S3.post_object_restore("bucket", "object", 5, version_id: 123)
  end

  test "#head_object" do
    expected = %{bucket: "bucket",
      headers: %{"x-amz-server-side-encryption-customer-algorithm" => "md5"},
      params: %{"versionId" => 123}, path: "object"}

    assert expected == S3.head_object("bucket", "object", encryption: [customer_algorithm: "md5"], version_id: 123)
  end

  test "#presigned_url no opts" do
    {:ok, url} = S3.presigned_url(:get, "bucket", "foo.txt")
    assert_pre_signed_url(url, "https://s3.amazonaws.com/bucket/foo.txt", "3600")
  end

  test "#presigned_url passing expires_in option" do
    {:ok, url} = S3.presigned_url(:get, "bucket", "foo.txt", [expires_in: 100])
    assert_pre_signed_url(url, "https://s3.amazonaws.com/bucket/foo.txt", "100")
  end

  test "#presigned_url passing virtual_host=false option" do
    {:ok, url} = S3.presigned_url(:get, "bucket", "foo.txt", [virtual_host: false])
    assert_pre_signed_url(url, "https://s3.amazonaws.com/bucket/foo.txt", "3600")
  end

  test "#presigned_url passing virtual_host=true option" do
    {:ok, url} = S3.presigned_url(:get, "bucket", "foo.txt", [virtual_host: true])
    assert_pre_signed_url(url, "https://bucket.s3.amazonaws.com/foo.txt", "3600")
  end

  test "#presigned_url passing both expires_in and virtual_host options" do
    opts = [expires_in: 100, virtual_host: true]
    {:ok, url} = S3.presigned_url(:get, "bucket", "foo.txt", opts)
    assert_pre_signed_url(url, "https://bucket.s3.amazonaws.com/foo.txt", "100")
  end

  test "#presigned_url file is path with slash" do
    {:ok, url} = S3.presigned_url(:get, "bucket", "/foo/bar.txt")
    assert_pre_signed_url(url, "https://s3.amazonaws.com/bucket/foo/bar.txt", "3600")
  end

  test "#presigned_url raises exception on bad expires_in option" do
    opts = [expires_in: 60 * 60 * 24 * 8]
    {:error, reason} = S3.presigned_url(:get, "bucket", "foo.txt", opts)
    assert "expires_in_exceeds_one_week" == reason
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
end
