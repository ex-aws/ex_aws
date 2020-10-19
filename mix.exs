defmodule ExAws.Mixfile do
  use Mix.Project

  @source_url "https://github.com/ex-aws/ex_aws"
  @version "2.1.6"

  def project do
    [
      app: :ex_aws,
      version: @version,
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      description: "Generic AWS client",
      name: "ExAws",
      source_url: @source_url,
      package: package(),
      dialyzer: [flags: "--fullpath"],
      deps: deps(),
      docs: docs(),
    ]
  end

  def application do
    [extra_applications: [:logger, :crypto], mod: {ExAws, []}]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps() do
    [
      {:sweet_xml, "~> 0.6", optional: true},
      {:ex_doc, "~> 0.16", only: [:dev, :test]},
      {:hackney, "~> 1.9", optional: true},
      {:jason, "~> 1.1", optional: true},
      {:jsx, "~> 2.8", optional: true},
      {:dialyze, "~> 0.2.0", only: [:dev, :test]},
      {:mox, "~> 0.3", only: :test},
      {:bypass, "~> 1.0", only: :test},
      {:configparser_ex, "~> 4.0", optional: true},
      {:credo, "~> 1.5.0-rc.2", only: [:dev, :test], runtime: false}
    ]
  end

  defp package do
    [
      description: description(),
      files: ["priv", "lib", "config", "mix.exs", "README*"],
      maintainers: ["Bernard Duggan", "Ben Wilson"],
      licenses: ["MIT"],
      links: %{GitHub: @source_url}
    ]
  end

  defp description do
    """
    AWS client for Elixir. Currently supports Dynamo, DynamoStreams, EC2,
    Firehose, Kinesis, KMS, Lambda, RRDS, Route53, S3, SES, SNS, SQS, STS
    """
  end

  defp docs do
    [
      main: "ExAws",
      source_ref: "v#{@version}",
      source_url: @source_url
    ]
  end
end
