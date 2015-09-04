defmodule ExAws.CloudTrail do
  defstruct config: nil, service: :"cloudtrail"

  @defaults [
    region: "us-east-1",
    port: 80,
    scheme: "https://",
    host: "cloudtrail.us-east-1.amazonaws.com"
  ]

  def new(opts \\ []) do
    %__MODULE__{}
    |> ExAws.Config.build(opts)
  end

  def config_root do
    Application.get_all_env(:ex_aws)
    |> Keyword.put(:"cloudtrail", @defaults)
  end

  def request(client, action, data) do
    ExAws.CloudTrail.Request.request(client, action, data)
  end
end
