defmodule ExAws.Cloudsearch.Client do
  defstruct config: nil, service: :"cloudsearch", version: "2013-01-01"

  @defaults [
    region: "us-east-1",
    port: 80,
    scheme: "https://",
    host: "cloudsearch.us-east-1.amazonaws.com"
  ]

  def new(opts \\ []) do
    %__MODULE__{}
    |> ExAws.Config.build(opts)
  end

  def config_root do
    Application.get_all_env(:ex_aws)
    |> Keyword.put(:"cloudsearch", @defaults)
  end

  def request(client, uri, action, data) do
    ExAws.Request.Query.request(client, uri, action, data)
  end
end
