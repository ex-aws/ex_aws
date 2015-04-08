defmodule ExAws.Mixfile do
  use Mix.Project

  def project do
    [app: :ex_aws,
     version: "0.0.3",
     elixir: "~> 1.0",
     description: "AWS client. Currently supports DynamoDB and Kinesis.",
     package: package,
     deps: deps]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [
      {:aws_auth, github: "benwilson512/aws_auth"},
      {:httpoison, "~> 0.6.0", only: [:dev, :test]},
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
