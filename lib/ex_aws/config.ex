defmodule ExAws.Config do

  @common_config [:http_client, :json_codec, :access_key_id, :secret_access_key, :debug_requests]

  def common do
    :ex_aws
    |> Application.get_all_env
    |> Keyword.take(@common_config)
  end

  def defaults_for_service(service_name) do
    defaults
    |> Keyword.take(@common_config)
    |> Keyword.merge(Keyword.get(defaults, service_name, []))
  end

  def get(attr) do
    Application.get_env(:ex_aws, attr)
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
        host: "kinesis.us-east-1.amazonaws.com",
        region: "us-east-1",
        port: 80
      ]
    ]
  end

end
