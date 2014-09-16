defmodule ExAws.Mixfile do
  use Mix.Project

  def project do
    [app: :ex_aws,
     version: "0.0.2",
     elixir: "~> 1.0.0",
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger, :erlcloud, :httpoison]]
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
      {:erlcloud, github: "gleber/erlcloud"},
      {:httpoison, github: "edgurgel/httpoison"},
      {:poison, github: "devinus/poison"}
    ]
  end
end
