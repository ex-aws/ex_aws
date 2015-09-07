defmodule ExAws.SDB.Client do
  defstruct config: nil, service: :"sdb", version: "2009-04-15"

  @defaults [
    region: "us-east-1",
    port: 80,
    scheme: "https://",
    host: "sdb.amazonaws.com"
  ]

  def new(opts \\ []) do
    %__MODULE__{}
    |> ExAws.Config.build(opts)
  end

  def config_root do
    Application.get_all_env(:ex_aws)
    |> Keyword.put(:"sdb", @defaults)
  end

  def request(client, uri, action, data) do
    ExAws.Request.Query.request(client, uri, action, data)
  end
end
