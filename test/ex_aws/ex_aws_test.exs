defmodule ExAwsTest do
  use ExUnit.Case, async: true

  # Skip until I figure out what the issue here is
  @tag :skip
  test "basic S3 operation works" do
    op = %ExAws.Operation.S3{
      body: "",
      bucket: "",
      headers: %{},
      http_method: :get,
      params: [],
      parser: & &1,
      path: "/",
      resource: "",
      service: :s3,
      stream_builder: nil
    }

    assert {:ok, %{body: _}} = ExAws.request(op)
  end

  test "basic json operation works" do
    op = %ExAws.Operation.JSON{
      http_method: :post,
      service: :dynamodb,
      headers: [
        {"x-amz-target", "DynamoDB_20120810.ListTables"},
        {"content-type", "application/x-amz-json-1.0"}
      ]
    }

    assert {:ok, %{"TableNames" => _}} = ExAws.request(op)
  end

  test "json operation with differently named service" do
    op = %ExAws.Operation.JSON{
      before_request: nil,
      data: %{},
      headers: [
        {"x-amz-target", "DynamoDBStreams_20120810.ListStreams"},
        {"content-type", "application/x-amz-json-1.0"}
      ],
      http_method: :post,
      params: %{},
      parser: & &1,
      path: "/",
      service: :dynamodb_streams,
      stream_builder: nil
    }

    assert {:ok, %{"Streams" => _}} = ExAws.request(op)
  end
end
