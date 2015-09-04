defmodule ExAws.CodeDeploy do
  defstruct config: nil, service: :"codedeploy"

  @defaults [
    region: "us-east-1",
    port: 80,
    scheme: "https://",
    host: "codedeploy.us-east-1.amazonaws.com"
  ]

  def new(opts \\ []) do
    %__MODULE__{}
    |> ExAws.Config.build(opts)
  end

  def config_root do
    Application.get_all_env(:ex_aws)
    |> Keyword.put(:"codedeploy", @defaults)
  end

  def request(client, action, data) do
    ExAws.CodeDeploy.Request.request(client, action, data)
  end
end
