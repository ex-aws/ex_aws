defmodule ExAws.DirectConnect.Client do
  defstruct config: nil, service: :"directconnect"

  @type t :: %__MODULE__{config: %{}, service: atom}

  @target_prefix "OvertureService"
  @json_version  "1.1"

  @defaults [
    region: "us-east-1",
    port: 80,
    scheme: "https://",
    host: "directconnect.us-east-1.amazonaws.com"
  ]

  def new(opts \\ []) do
    %__MODULE__{}
    |> ExAws.Config.build(opts)
  end

  def config_root do
    Application.get_all_env(:ex_aws)
    |> Keyword.put(:"directconnect", @defaults)
  end

  def request(client, action, data) do
    ExAws.Request.JSON.request(client, action, data, @target_prefix, @json_version)
  end
end
