defmodule ExAws.Mixfile do
  use Mix.Project

  def project do
    [app: :ex_aws,
     version: "0.4.13",
     elixir: "~> 1.0",
     description: "AWS client. Currently supports Dynamo, Kinesis, Lambda, S3, SQS",
     name: "ExAws",
     source_url: "https://github.com/cargosense/ex_aws",
     package: package,
     dialyzer: [flags: "--fullpath"],
     deps: deps]
  end

  def application do
    [applications: [:logger, :crypto],
     mod: {ExAws, []},
     env: env]
  end

  defp deps do
    deps(:test_dev)
  end

  defp deps(:test_dev) do
    [
      {:sweet_xml, "~> 0.5", optional: true},
      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.7", only: :dev},
      {:httpoison, "~> 0.7", optional: true},
      {:poison, "~> 1.2", optional: true},
      {:ibrowse, github: "cmullaparthi/ibrowse", tag: "v4.1.2", optional: true},
      {:httpotion, "~> 2.0", optional: true},
      {:jsx, "~> 2.5", optional: true}
    ]
  end

  defp package do
    [description: "AWS client. Currently supports Dynamo, Kinesis, Lambda, S3",
     files: ["lib", "config", "mix.exs", "README*"],
     maintainers: ["Ben Wilson"],
     licenses: ["MIT"],
     links: %{github: "https://github.com/CargoSense/ex_aws"}]
  end

  defp env do
    [
      access_key_id: [{:system, "AWS_ACCESS_KEY_ID"}, :instance_role],
      secret_access_key: [{:system, "AWS_SECRET_ACCESS_KEY"}, :instance_role],
      http_client: ExAws.Request.HTTPoison,
      json_codec: Poison,
      kinesis: [
        scheme: "https://",
        host: {"$region", "kinesis.$region.amazonaws.com"},
        region: "us-east-1",
        port: 80
      ],
      dynamodb: [
        scheme: "https://",
        host: {"$region", "dynamodb.$region.amazonaws.com"},
        region: "us-east-1",
        port: 80
      ],
      lambda: [
        host: {"$region", "lambda.$region.amazonaws.com"},
        scheme: "https://",
        region: "us-east-1",
        port: 80
      ],
      s3: [
        scheme: "https://",
        host: %{
          "us-east-1" => "s3.amazonaws.com",
          "us-west-1" => "s3-us-west-1.amazonaws.com",
          "us-west-2" => "s3-us-west-2.amazonaws.com",
          "eu-west-1" => "s3-eu-west-1.amazonaws.com",
          "eu-central-1" => "s3-eu-central-1.amazonaws.com",
          "ap-southeast-1" => "s3-ap-southeast-1.amazonaws.com",
          "ap-southeast-2" => "s3-ap-southeast-2.amazonaws.com",
          "ap-northeast-1" => "s3-ap-southeast-1.amazonaws.com",
          "sa-east-1" => "s3-sa-east-1.amazonaws.com",
        },
        region: "us-east-1"
      ],
      sqs: [
        scheme: "https://",
        host: {"$region", "sqs.$region.amazonaws.com"},
        region: "us-east-1",
        port: 80
      ]
    ]
  end
end
