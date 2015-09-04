defmodule ExAws.AWS.Config do
  defstruct config: nil, service: :"config"

  @defaults [
    region: "us-east-1",
    port: 80,
    scheme: "https://",
    host: "config.us-east-1.amazonaws.com"
  ]

  def new(opts \\ []) do
    %__MODULE__{}
    |> ExAws.Config.build(opts)
  end

  def config_root do
    Application.get_all_env(:ex_aws)
    |> Keyword.put(:"config", @defaults)
  end

  def request(client, action, data) do
    ExAws.AWS.Config.Request.request(client, action, data)
  end
end
