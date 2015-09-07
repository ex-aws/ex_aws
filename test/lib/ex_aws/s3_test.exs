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
      bucket: "bucket", path: "/?delete"}

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

end
