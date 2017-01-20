defmodule ExAws.Mixfile do
  use Mix.Project

  @version "1.0.0"

  def project do
    [app: :ex_aws,
     version: @version,
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     description: "AWS client. Currently supports Dynamo, EC2, Kinesis, Lambda, RDS, S3, SNS, SQS",
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
    [applications: [:logger, :crypto, :gen_stage],
     mod: {ExAws, []}]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib",]

  defp deps do
    deps(:test_dev)
  end

  defp deps(:test_dev) do
    [
      {:sweet_xml, "~> 0.6", optional: true},
      {:ex_doc, "~> 0.14", only: :dev},
      {:hackney, "~> 1.6.5", optional: true},
      {:poison, ">= 1.2.0", optional: true},
      {:jsx, "~> 2.8", optional: true},
      {:flow, "~> 0.11"},
      {:dialyze, "~> 0.2.0", only: :dev},
      {:bypass, "~> 0.1", only: :test},
      {:configparser_ex, "~> 0.2.1", optional: true},
    ]
  end

  defp package do
    [description: "AWS client. Currently supports Dynamo, EC2, Kinesis, Lambda, RDS, S3, SNS, SQS",
     files: ["lib", "config", "mix.exs", "README*"],
     maintainers: ["Ben Wilson"],
     licenses: ["MIT"],
     links: %{github: "https://github.com/CargoSense/ex_aws"}]
  end
end
