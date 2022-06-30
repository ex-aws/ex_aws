defmodule ExAws.Mixfile do
  use Mix.Project

  @source_url "https://github.com/ex-aws/ex_aws"
  @version "2.3.3"

  def project do
    [
      app: :ex_aws,
      version: @version,
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      description: "Generic AWS client",
      name: "ExAws",
      source_url: @source_url,
      package: package(),
      deps: deps(),
      docs: docs(),
      dialyzer: [
        plt_add_apps: [:mix, :hackney, :configparser_ex, :jsx]
      ],
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  def application do
    [extra_applications: [:logger, :crypto], mod: {ExAws, []}]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps() do
    [
      {:telemetry, "~> 0.4.3 or ~> 1.0"},
      # mime 2.x requires Elixir ~> 1.10
      {:mime, "~> 1.2 or ~> 2.0"},
      {:bypass, "~> 2.1", only: :test},
      {:configparser_ex, "~> 4.0", optional: true},
      {:dialyxir, "~> 1.0", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.16", only: [:dev, :test]},
      {:hackney, "~> 1.16", optional: true},
      {:jason, "~> 1.1", optional: true},
      {:jsx, "~> 2.8 or ~> 3.0", optional: true},
      {:mox, "~> 1.0", only: :test},
      {:sweet_xml, "~> 0.7", optional: true},
      {:excoveralls, "~> 0.10", only: :test},
      {:httpotion, "~> 3.1", only: :test}
    ]
  end

  defp package do
    [
      description: description(),
      files: ["priv", "lib", "config", "mix.exs", "README*", "LICENSE"],
      maintainers: ["Bernard Duggan", "Ben Wilson"],
      licenses: ["MIT"],
      links: %{
        Changelog: "#{@source_url}/blob/master/CHANGELOG.md",
        GitHub: @source_url
      }
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
      main: "readme",
      source_ref: "v#{@version}",
      source_url: @source_url,
      extras: ["README.md"]
    ]
  end
end
