defmodule ExAws.Config do

  @moduledoc false

  # Generates the configuration for a client.
  # It starts with the defaults for a given environment
  # and then merges in the common config from the ex_aws config root,
  # and then finally any config specified for the particular service

  @common_config [:http_client, :json_codec, :access_key_id, :secret_access_key, :debug_requests]

  def get(%{__struct__: client, service: service}) do
    config_root = client.config_root
    unless config_root, do: raise "A valid configuration root is required in your #{client.service} client"

    config      = config_root |> Keyword.get(service, [])
    common      = defaults
    |> Keyword.merge(config_root)
    |> Keyword.take(@common_config)

    defaults
    |> Keyword.get(service, [])
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
      ],
      s3: [
        scheme: "https://",
        host: "s3.amazonaws.com",
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
      ]
    ]
  end

end
