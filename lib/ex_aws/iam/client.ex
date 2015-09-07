defmodule ExAws.Iam.Client do
  defstruct config: nil, service: :"iam", version: "2010-05-08"

  @defaults [
    region: "us-east-1",
    port: 80,
    scheme: "https://",
    host: "iam.amazonaws.com"
  ]

  def new(opts \\ []) do
    %__MODULE__{}
    |> ExAws.Config.build(opts)
  end

  def config_root do
    Application.get_all_env(:ex_aws)
    |> Keyword.put(:"iam", @defaults)
  end

  def request(client, uri, action, data) do
    ExAws.Request.Query.request(client, uri, action, data)
  end
end
