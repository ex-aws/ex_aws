defmodule ExAws.Config.Defaults do
  def defaults do
    Mix.env
    |> defaults
    |> Keyword.merge([
      access_key_id: [{:system, "AWS_ACCESS_KEY_ID"}, :instance_role],
      secret_access_key: [{:system, "AWS_SECRET_ACCESS_KEY"}, :instance_role]
    ])
  end
  def defaults(:dev) do
    [
      http_client: HTTPoison,
      json_codec: Poison,
      kinesis: [
        scheme: "https://",
        host: "kinesis.us-east-1.amazonaws.com",
        region: "us-east-1",
        port: 80
      ],
      dynamodb: [
        scheme: "http://",
        host: "localhost",
        port: 8000,
        region: "us-east-1"
      ],
      lambda: [
        host: "lambda.us-east-1.amazonaws.com",
        scheme: "https://",
        region: "us-east-1",
        port: 80
      ],
      s3: [
        scheme: "https://",
        host: "s3.amazonaws.com",
        region: "us-east-1"
      ],
      sns: [
        host: "sns.us-east-1.amazonaws.com",
        scheme: "https://",
        region: "us-east-1"
      ]
    ]
  end
  def defaults(:test) do
    [
      http_client: HTTPoison,
      json_codec: Poison,
      dynamodb: [
        scheme: "http://",
        host: "localhost",
        port: 8000,
        region: "us-east-1"
      ]
    ]
  end
  def defaults(:prod) do
    [
      http_client: HTTPoison,
      json_codec: Poison,
      kinesis: [
        scheme: "https://",
        host: "kinesis.us-east-1.amazonaws.com",
        region: "us-east-1",
        port: 80
      ],
      dynamodb: [
        scheme: "https://",
        host: "dynamodb.us-east-1.amazonaws.com",
        region: "us-east-1",
        port: 80
      ],
      lambda: [
        host: "lambda.us-east-1.amazonaws.com",
        scheme: "https://",
        region: "us-east-1",
        port: 80
      ],
      s3: [
        scheme: "https://",
        host: "s3.amazonaws.com",
        region: "us-east-1"
      ],
      sns: [
        host: "sns.us-east-1.amazonaws.com",
        scheme: "https://",
        region: "us-east-1"
      ]
    ]
  end
end
