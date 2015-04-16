defmodule ExAws.Config do

  @common_config [:http_client, :json_codec, :access_key_id, :secret_access_key, :debug_requests]

  def get(adapter) do
    config_root = adapter.config_root
    config      = adapter.config_root |> Keyword.get(adapter.service, [])
    common      = defaults
    |> Keyword.merge(config_root)
    |> Keyword.take(@common_config)

    defaults
    |> Keyword.get(adapter.service, [])
    |> Keyword.merge(common)
    |> Keyword.merge(config)
  end

  def defaults do
    Mix.env |> defaults
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
      ],
      s3: [
        scheme: "https://",
        host: "s3.amazonaws.com",
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
        host: "kinesis.us-east-1.amazonaws.com",
        region: "us-east-1",
        port: 80
      ],
      lambda: [
        host: "lambda.us-east-1.amazonaws.com",
        scheme: "https://",
        region: "us-east-1",
        port: 80
      ]
    ]
  end

end
