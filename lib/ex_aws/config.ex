defmodule ExAws.Config do

  def for_service(service_name) do
    defaults[service_name]
  end

  def get(attr) do
    Application.get_env(:ex_aws, attr)
  end

  def defaults do
    Mix.env |> defaults
  end
  def defaults(:dev) do
    defaults(:prod)
    |> Keyword.merge(dynamodb: [
      access_key_id: System.get_env("AWS_ACCESS_KEY_ID"),
      secret_access_key: System.get_env("AWS_SECRET_ACCESS_KEY"),
      scheme: "https://",
      host: "kinesis.us-east-1.amazonaws.com",
      region: "us-east-1",
      port: 80
    ])
  end
  def defaults(:test) do
    defaults(:prod)
  end
  def defaults(:prod) do
    [
      kinesis: [
        access_key_id: System.get_env("AWS_ACCESS_KEY_ID"),
        secret_access_key: System.get_env("AWS_SECRET_ACCESS_KEY"),
        scheme: "https://",
        host: "kinesis.us-east-1.amazonaws.com",
        region: "us-east-1",
        port: 80
      ],
      dynamodb: [
        access_key_id: System.get_env("AWS_ACCESS_KEY_ID"),
        secret_access_key: System.get_env("AWS_SECRET_ACCESS_KEY"),
        scheme: "https://",
        host: "kinesis.us-east-1.amazonaws.com",
        region: "us-east-1",
        port: 80
      ]
    ]
  end

end
