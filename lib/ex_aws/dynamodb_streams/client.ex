defmodule ExAws.Dynamodb.Streams.Client do
  defstruct config: nil, service: :"dynamodb"

  @type t :: %__MODULE__{config: %{}, service: atom}

  @target_prefix "DynamoDBStreams_20120810"
  @json_version  "1.0"

  @defaults [
    region: "us-east-1",
    port: 80,
    scheme: "https://",
    host: "streams.dynamodb.us-east-1.amazonaws.com"
  ]

  def new(opts \\ []) do
    %__MODULE__{}
    |> ExAws.Config.build(opts)
  end

  def config_root do
    Application.get_all_env(:ex_aws)
    |> Keyword.put(:"dynamodb", @defaults)
  end

  def request(client, action, data) do
    ExAws.Request.JSON.request(client, action, data, @target_prefix, @json_version)
  end
end
