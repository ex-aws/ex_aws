defmodule ExAws.CognitoIdentity do
  defstruct config: nil, service: :"cognito-identity"

  @defaults [
    region: "us-east-1",
    port: 80,
    scheme: "https://",
    host: "cognito-identity.us-east-1.amazonaws.com"
  ]

  def new(opts \\ []) do
    %__MODULE__{}
    |> ExAws.Config.build(opts)
  end

  def config_root do
    Application.get_all_env(:ex_aws)
    |> Keyword.put(:"cognito-identity", @defaults)
  end

  def request(client, action, data) do
    ExAws.CognitoIdentity.Request.request(client, action, data)
  end
end
