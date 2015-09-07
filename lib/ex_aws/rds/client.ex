defmodule ExAws.RDS.Client do
  defstruct config: nil, service: :"rds", version: "2014-10-31"

  @defaults [
    region: "us-east-1",
    port: 80,
    scheme: "https://",
    host: "rds.us-east-1.amazonaws.com"
  ]

  def new(opts \\ []) do
    %__MODULE__{}
    |> ExAws.Config.build(opts)
  end

  def config_root do
    Application.get_all_env(:ex_aws)
    |> Keyword.put(:"rds", @defaults)
  end

  def request(client, uri, action, data) do
    ExAws.Request.Query.request(client, uri, action, data)
  end
end
