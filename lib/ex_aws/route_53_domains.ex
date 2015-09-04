defmodule ExAws.Route53Domains do
  defstruct config: nil, service: :"route53domains"

  @defaults [
    region: "us-east-1",
    port: 80,
    scheme: "https://",
    host: "route53domains.us-east-1.amazonaws.com"
  ]

  def new(opts \\ []) do
    %__MODULE__{}
    |> ExAws.Config.build(opts)
  end

  def config_root do
    Application.get_all_env(:ex_aws)
    |> Keyword.put(:"route53domains", @defaults)
  end

  def request(client, action, data) do
    ExAws.Route53Domains.Request.request(client, action, data)
  end
end
