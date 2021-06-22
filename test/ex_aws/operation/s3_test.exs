defmodule ExAws.Operation.S3Test do
  use ExUnit.Case, async: true

  alias Elixir.ExAws.Operation.ExAws.Operation.S3

  def s3_operation() do
    %ExAws.Operation.S3{
      body: "",
      bucket: "my-bucket-1",
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

  test "S3 adds buck to path when virtual_host is true" do
    config = ExAws.Config.new(:s3) |> Map.put(:virtual_host, true)
    operation = s3_operation()

    {processed_operation, processed_config} = S3.add_bucket_to_path(operation, config)

    assert(processed_config.host == "#{operation.bucket}.#{config.host}")
    assert(processed_operation.path == operation.path)
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
end
