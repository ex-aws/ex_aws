defmodule ExAws.Mixfile do
  use Mix.Project

  def project do
    [app: :ex_aws,
     version: "0.0.3",
     elixir: "~> 1.0.0",
     description: "AWS client. Currently supports DynamoDB and Kinesis.",
     package: package,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger, :httpoison]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:aws_auth, "~> 0.2.2"},
      {:httpoison, "~> 0.6.0"},
      {:poison, "~> 1.2.0"},
      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.7", only: :dev}
    ]
  end

  defp package do
    [description: "AWS client. Currently supports DynamoDB and Kinesis.",
     files: ["lib", "config", "mix.exs", "README*"],
     contributors: ["Ben Wilson"],
     licenses: ["MIT"],
     links: %{github: "https://github.com/CargoSense/ex_aws"}]
  end
end
