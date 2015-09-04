defmodule ExAws.Ecs do
  defstruct config: nil, service: :"ecs"

  @defaults [
    region: "us-east-1",
    port: 80,
    scheme: "https://",
    host: "ecs.us-east-1.amazonaws.com"
  ]

  def new(opts \\ []) do
    %__MODULE__{}
    |> ExAws.Config.build(opts)
  end

  def config_root do
    Application.get_all_env(:ex_aws)
    |> Keyword.put(:"ecs", @defaults)
  end

  def request(client, action, data) do
    ExAws.Ecs.Request.request(client, action, data)
  end
end
