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
        "x-amz-grant-read" => "emailAddress=\"foo@bar.com\", id=\"foo-id\"",
        "x-amz-server-side-encryption" => "AES256",
        "x-amz-storage-class" => "spicy"},
      path: "object.json"}

    assert expected == S3.put_object("bucket", "object.json", "data",
      content_encoding: "application/json",
      storage_class: "spicy",
      grant_read: [email: "foo@bar.com", id: "foo-id"],
      acl: :public_read, #ordinarily you wouldn't do both this and the grant_read but it's just for testing
      encryption: "AES256"
    )
  end

end
