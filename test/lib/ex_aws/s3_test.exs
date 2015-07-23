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
        "x-amz-storage-class" => "spicy"},
      path: "object.json"}

    assert expected == S3.put_object("bucket", "object.json", "data",
      content_encoding: "application/json",
      storage_class: "spicy",
      acl: :public_read,
      encryption: "AES256"
    )
  end

  test "#put_object_copy" do
    expected = %{bucket: "dest-bucket",
      headers: %{"x-amz-acl" => "public-read",
        "x-amz-copy-source" => "/src-bucket/src-object",
        "x-amz-server-side-encryption-customer-algorithm" => "md5"},
      path: "dest-object"}
    assert expected == S3.put_object_copy("dest-bucket", "dest-object", "src-bucket", "src-object", source_encryption: [customer_algorithm: "md5"], acl: :public_read)
  end

  test "#complete_multipart_upload" do
    expected = %{
      body: "<CompleteMultipartUpload><Part><PartNumber>1</PartNumber><ETag>foo</ETag></Part><Part><PartNumber>2</PartNumber><ETag>bar</ETag></Part></CompleteMultipartUpload>",
      bucket: "bucket", params: %{"uploadId" => "upload-id"}, path: "object"}
    assert expected == S3.complete_multipart_upload("bucket", "object", "upload-id", %{1 => "foo", 2 => "bar"})
  end

end
