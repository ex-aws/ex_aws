defmodule ExAws.Mixfile do
  use Mix.Project

  def project do
    [app: :ex_aws,
     version: "0.4.8",
     elixir: "~> 1.0",
     description: "AWS client. Currently supports Dynamo, Kinesis, Lambda, S3",
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
      {:sweet_xml, "~> 0.2.1", optional: true},
      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.7", only: :dev},
      {:httpoison, "~> 0.7", optional: true},
      {:poison, "~> 1.2.0", optional: true},
      {:ibrowse, github: "cmullaparthi/ibrowse", tag: "v4.1.2", optional: true},
      {:httpotion, "~> 2.0.0", optional: true},
      {:jsx, "~> 2.5.2", optional: true}
    ]
  end

  defp package do
    [description: "AWS client. Currently supports Dynamo, Kinesis, Lambda, S3",
     files: ["lib", "config", "mix.exs", "README*"],
     contributors: ["Ben Wilson"],
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
      sqs: [
        scheme: "https://",
        host: "sqs.us-east-1.amazonaws.com",
        region: "us-east-1"
      ]
    ]
  end
end
