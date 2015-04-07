defmodule ExAws.Config do
  require Record
  @attrs Record.extract(:aws_config, from_lib: "erlcloud/include/erlcloud_aws.hrl")
  Record.defrecord :aws_config, @attrs

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

  def erlcloud_config(config) do
    aws_config(
      access_key_id: config[:access_key_id],
      secret_access_key: config[:secret_access_key]
    )
  end

end
