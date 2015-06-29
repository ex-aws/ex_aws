defmodule ExAws.Mixfile do
  use Mix.Project

  def project do
    [app: :ex_aws,
     version: "0.3.1",
     elixir: "~> 1.0",
     description: "AWS client. Currently supports Dynamo, Kinesis, Lambda, S3",
     name: "ExAws",
     source_url: "https://github.com/cargosense/ex_aws",
     package: package,
     dialyzer: [flags: "--fullpath"],
     deps: deps]
  end

  def application do
    [applications: [:logger, :timex, :crypto],
     mod: {ExAws, []}]
  end

  defp deps do
    [
      {:timex, "~> 0.13.4"} |
      deps(:test_dev)
    ]
  end

  defp deps(:test_dev) do
    [
      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.7", only: :dev},
      {:sweet_xml, "~> 0.2.1", only: [:test]},
      {:httpoison, "~> 0.6.0", only: [:test, :dev]},
      {:poison, "~> 1.2.0", only: [:test, :dev]},
      {:ibrowse, github: "cmullaparthi/ibrowse", tag: "v4.1.1", only: :test},
      {:httpotion, "~> 2.0.0", only: :test},
      {:jsx, "~> 2.5.2", only: :test}
    ]
  end

  defp package do
    [description: "AWS client. Currently supports Dynamo, Kinesis, Lambda, S3",
     files: ["lib", "config", "mix.exs", "README*"],
     contributors: ["Ben Wilson"],
     licenses: ["MIT"],
     links: %{github: "https://github.com/CargoSense/ex_aws"}]
  end
end
