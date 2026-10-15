defmodule ExAws.Operation.S3Test do
  use ExUnit.Case, async: true
  import Mox

  alias Elixir.ExAws.Operation.ExAws.Operation.S3

  setup :verify_on_exit!

  @request_opts [
    access_key_id: "AKIAIOSFODNN7EXAMPLE",
    secret_access_key: "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
    region: "us-east-1",
    http_client: ExAws.Request.HttpMock
  ]

  def s3_operation(bucket \\ "my-bucket-1") do
    %ExAws.Operation.S3{
      body: "",
      bucket: bucket,
      headers: %{},
      http_method: :get,
      params: [],
      parser: & &1,
      path: "/folder",
      resource: "",
      service: :s3,
      stream_builder: nil
    }
  end

  test "S3 adds bucket to path when virtual_host is missing from config" do
    config = ExAws.Config.new(:s3)
    operation = s3_operation()

    {processed_operation, processed_config} = S3.add_bucket_to_path(operation, config)

    assert(processed_config.host == config.host)
    assert(processed_operation.path == "/#{operation.bucket}#{operation.path}")
  end

  test "S3 adds bucket to path when virtual_host is false" do
    config = ExAws.Config.new(:s3) |> Map.put(:virtual_host, false)
    operation = s3_operation()

    {processed_operation, processed_config} = S3.add_bucket_to_path(operation, config)

    assert(processed_config.host == config.host)
    assert(processed_operation.path == "/#{operation.bucket}#{operation.path}")
  end

  test "S3 adds bucket to path when virtual_host is true" do
    config = ExAws.Config.new(:s3) |> Map.put(:virtual_host, true)
    operation = s3_operation()

    {processed_operation, processed_config} = S3.add_bucket_to_path(operation, config)

    assert(processed_config.host == "#{operation.bucket}.#{config.host}")
    assert(processed_operation.path == operation.path)
  end

  test "S3 raises when bucket is nil" do
    config = ExAws.Config.new(:s3)
    operation = s3_operation(nil)

    assert_raise RuntimeError,
                 "#{S3}.perform/2 cannot perform operation on `nil` bucket",
                 fn -> S3.add_bucket_to_path(operation, config) end
  end

  test "ensure paths with . and .. are correctly resolved" do
    config = ExAws.Config.new(:s3)
    operation = %{s3_operation() | path: "a/../b/../c/./d"}

    {processed_operation, _processed_config} = S3.add_bucket_to_path(operation, config)
    assert processed_operation.path == "/my-bucket-1/c/d"
  end

  test "ensure paths ending with / preserve the trailing /" do
    config = ExAws.Config.new(:s3) |> Map.put(:virtual_host, false)
    operation = %{s3_operation() | path: "folder/"}

    {processed_operation, _processed_config} = S3.add_bucket_to_path(operation, config)
    assert processed_operation.path == "/my-bucket-1/folder/"
  end

  test "ensure paths ending with / preserve the trailing / (virtual-host)" do
    config = ExAws.Config.new(:s3) |> Map.put(:virtual_host, true)
    operation = %{s3_operation() | path: "folder/"}

    {processed_operation, _processed_config} = S3.add_bucket_to_path(operation, config)
    assert processed_operation.path == "/folder/"
  end

  test "S3 uses bucket as host when both virtual_host and bucket_as_host are true" do
    config =
      ExAws.Config.new(:s3) |> Map.put(:virtual_host, true) |> Map.put(:bucket_as_host, true)

    operation = s3_operation("my-custom-domain.com")

    {processed_operation, processed_config} = S3.add_bucket_to_path(operation, config)

    assert(processed_config.host == "my-custom-domain.com")
    assert(processed_operation.path == "/folder")
  end

  test "S3 uses standard virtual host when virtual_host is true but bucket_as_host is false" do
    config =
      ExAws.Config.new(:s3) |> Map.put(:virtual_host, true) |> Map.put(:bucket_as_host, false)

    operation = s3_operation()

    {processed_operation, processed_config} = S3.add_bucket_to_path(operation, config)

    assert(processed_config.host == "#{operation.bucket}.#{ExAws.Config.new(:s3).host}")
    assert(processed_operation.path == "/folder")
  end

  describe "perform/2 with reserved characters in the object key" do
    test "requests the percent-encoded key when it contains ?" do
      operation = %{s3_operation("victim-bucket") | path: "export.dump?.txt"}

      assert requested_url(operation) ==
               "https://s3.amazonaws.com/victim-bucket/export.dump%3F.txt"
    end

    test "does not let ? in the key inject an S3 sub-resource" do
      operation = %{s3_operation("victim-bucket") | path: "report.pdf?acl"}

      assert requested_url(operation) ==
               "https://s3.amazonaws.com/victim-bucket/report.pdf%3Facl"
    end

    test "keeps the key apart from the query string" do
      operation = %{
        s3_operation("victim-bucket")
        | path: "a?b.txt",
          params: %{"versionId" => "1"}
      }

      assert requested_url(operation) ==
               "https://s3.amazonaws.com/victim-bucket/a%3Fb.txt?versionId=1"
    end

    test "still encodes space, +, # and % in the key" do
      operation = %{s3_operation("victim-bucket") | path: "dir/a b+c#d%25.txt"}

      assert requested_url(operation) ==
               "https://s3.amazonaws.com/victim-bucket/dir/a%20b%2Bc%23d%2525.txt"
    end

    test "encodes the key with virtual host addressing" do
      operation = %{s3_operation("victim-bucket") | path: "export.dump?.txt"}

      assert requested_url(operation, virtual_host: true) ==
               "https://victim-bucket.s3.amazonaws.com/export.dump%3F.txt"
    end
  end

  # Performs the operation through the public ExAws.request/2 entry point and
  # returns the URL that reached the HTTP client.
  defp requested_url(operation, extra_opts \\ []) do
    test_pid = self()

    expect(ExAws.Request.HttpMock, :request, fn _method, url, _body, _headers, _opts ->
      send(test_pid, {:requested_url, url})
      {:ok, %{status_code: 200, body: "", headers: []}}
    end)

    assert {:ok, _} = ExAws.request(operation, @request_opts ++ extra_opts)
    assert_received {:requested_url, url}
    url
  end
end
