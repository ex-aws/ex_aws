defmodule ExAws.Mixfile do
  use Mix.Project

  def project do
    [app: :ex_aws,
     version: "0.4.16",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     description: "AWS client. Currently supports Dynamo, Kinesis, Lambda, S3, SQS",
     name: "ExAws",
     source_url: "https://github.com/cargosense/ex_aws",
     package: package,
     dialyzer: [flags: "--fullpath"],
     deps: deps]
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
end
