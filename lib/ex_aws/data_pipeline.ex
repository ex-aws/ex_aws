defmodule ExAws.DataPipeline do
  defstruct config: nil, service: :"datapipeline"

  @defaults [
    region: "us-east-1",
    port: 80,
    scheme: "https://",
    host: "datapipeline.us-east-1.amazonaws.com"
  ]

  def new(opts \\ []) do
    %__MODULE__{}
    |> ExAws.Config.build(opts)
  end

  def config_root do
    Application.get_all_env(:ex_aws)
    |> Keyword.put(:"datapipeline", @defaults)
  end

  def request(client, action, data) do
    ExAws.DataPipeline.Request.request(client, action, data)
  end
end
