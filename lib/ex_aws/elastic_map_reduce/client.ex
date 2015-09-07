defmodule ExAws.ElasticMapReduce.Client do
  defstruct config: nil, service: :"elasticmapreduce"

  @type t :: %__MODULE__{config: %{}, service: atom}

  @target_prefix "ElasticMapReduce"
  @json_version  "1.1"

  @defaults [
    region: "us-east-1",
    port: 80,
    scheme: "https://",
    host: "elasticmapreduce.us-east-1.amazonaws.com"
  ]

  def new(opts \\ []) do
    %__MODULE__{}
    |> ExAws.Config.build(opts)
  end

  def config_root do
    Application.get_all_env(:ex_aws)
    |> Keyword.put(:"elasticmapreduce", @defaults)
  end

  def request(client, action, data) do
    ExAws.Request.JSON.request(client, action, data, @target_prefix, @json_version)
  end
end
