defmodule ExAws.Operation.S3Test do
  use ExUnit.Case, async: true

  alias Elixir.ExAws.Operation.ExAws.Operation.S3

  import Mox

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

  test "S3 object encoding with query parameter seperator (?)" do
    config = %{
      http_client: ExAws.Request.HttpMock,
      json_codec: JSX,
      access_key_id: "AKIAIOSFODNN7EXAMPLE",
      secret_access_key: "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
      region: "us-east-1",
      retries: [
        max_attempts: 5,
        base_backoff_in_ms: 1,
        max_backoff_in_ms: 20
      ],
      normalize_path: false,
      scheme: "https://",
      host: "s3.amazonaws.com",
      virtual_host: true,
      port: 443
    }

    headers = %{
      "x-amz-bucket-region" => "us-east-1",
      "x-amz-content-sha256" => ExAws.Auth.Utils.hash_sha256(""),
      "content-length" => byte_size("")
    }

    expect(
      ExAws.Request.HttpMock,
      :request,
      fn _method, url, _body, _headers, _opts ->
        assert url == "https://examplebucket.s3.amazonaws.com/test%20hello%20%233.txt%3Facl%3D21"
        {:ok, %{status_code: 200}}
      end
    )

    operation = %ExAws.Operation.S3{
      s3_operation()
      | path: "test hello #3.txt?acl=21",
        headers: headers,
        bucket: "examplebucket"
    }

    assert {:ok, %{status_code: 200}} == S3.perform(operation, config)
  end

  test "S3 object encoding with query parameter seperator (?) and version_id" do
    config = %{
      http_client: ExAws.Request.HttpMock,
      json_codec: JSX,
      access_key_id: "AKIAIOSFODNN7EXAMPLE",
      secret_access_key: "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
      region: "us-east-1",
      retries: [
        max_attempts: 5,
        base_backoff_in_ms: 1,
        max_backoff_in_ms: 20
      ],
      normalize_path: false,
      scheme: "https://",
      host: "s3.amazonaws.com",
      virtual_host: true,
      port: 443
    }

    headers = %{
      "x-amz-bucket-region" => "us-east-1",
      "x-amz-content-sha256" => ExAws.Auth.Utils.hash_sha256(""),
      "content-length" => byte_size("")
    }

    expect(
      ExAws.Request.HttpMock,
      :request,
      fn _method, url, _body, _headers, _opts ->
        assert url ==
                 "https://examplebucket.s3.amazonaws.com/test%20hello%20%233.txt%3Facl%3D21?version-id=v1"

        {:ok, %{status_code: 200}}
      end
    )

    operation = %ExAws.Operation.S3{
      s3_operation()
      | path: "test hello #3.txt?acl=21",
        headers: headers,
        bucket: "examplebucket",
        params: %{"version-id" => "v1"}
    }

    assert {:ok, %{status_code: 200}} == S3.perform(operation, config)
  end

  describe "encode_path_query_fragment_into_path" do
    test "fetch object ending in question mark (?)" do
      %{path: "object.txt%3F"} =
        %ExAws.Operation.S3{path: "object.txt?"}
        |> S3.encode_path_query_fragment_into_path()
    end

    test "fetch object with name contains query parameters" do
      %{path: "object.txt%3Fid%3D3"} =
        %ExAws.Operation.S3{path: "object.txt?id=3"}
        |> S3.encode_path_query_fragment_into_path()
    end
  end
end
