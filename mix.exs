defmodule ExAws.Mixfile do
  use Mix.Project

  @version "1.1.3"

  def project do
    [app: :ex_aws,
     version: @version,
     elixir: "~> 1.4",
     elixirc_paths: elixirc_paths(Mix.env),
     description: "AWS client. Currently supports Dynamo, DynamoStreams, EC2, Firehose, Kinesis, KMS, Lambda, RRDS, Route53, S3, SES, SNS, SQS, STS",
     name: "ExAws",
     source_url: "https://github.com/cargosense/ex_aws",
     package: package(),
     dialyzer: [flags: "--fullpath"],
     deps: deps(),
     docs: [main: "ExAws", source_ref: "v#{@version}",
       source_url: "https://github.com/cargosense/ex_aws"]
     ]
  end

  def application do
    [applications: [:logger, :crypto],
     mod: {ExAws, []}]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib",]

  defp deps do
    deps(:test_dev)
  end

  defp deps(:test_dev) do
    [
      {:xml_builder, "~> 0.0.6", optional: true},
      {:sweet_xml, "~> 0.6", optional: true},
      {:ex_doc, "~> 0.14", only: :dev},
      {:hackney, "1.8.6", optional: true},
      {:poison, "~> 3.1.0", optional: true},
      {:jsx, "~> 2.8", optional: true},
      {:dialyze, "~> 0.2.1", only: :dev},
      {:bypass, "~> 0.1", only: :test},
      {:configparser_ex, "~> 0.2.1", optional: true},
    ]
  end

  defp package do
    [description: "AWS client. Currently supports Dynamo, DynamoStreams, EC2, Firehose, Kinesis, KMS, Lambda, RRDS, Route53, S3, SES, SNS, SQS, STS",
     files: ["lib", "config", "mix.exs", "README*"],
     maintainers: ["Ben Wilson"],
     licenses: ["MIT"],
     links: %{github: "https://github.com/CargoSense/ex_aws"}]
  end
end
