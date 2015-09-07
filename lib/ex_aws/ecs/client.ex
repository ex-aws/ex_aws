defmodule ExAws.Ecs.Client do
  defstruct config: nil, service: :"ecs"

  @type t :: %__MODULE__{config: %{}, service: atom}

  @target_prefix "AmazonEC2ContainerServiceV20141113"
  @json_version  "1.1"

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
    ExAws.Request.JSON.request(client, action, data, @target_prefix, @json_version)
  end
end
