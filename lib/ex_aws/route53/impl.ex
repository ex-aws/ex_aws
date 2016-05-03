defmodule ExAws.Route53.Impl do
  def list_hosted_zones(client, opts \\ []) do
    request(client, :get, "hostedzone", Enum.into(opts, %{}))
  end

  defp request(%{__struct__: module} = client, method, path, params) do
    module.request(client, method, path, params)
  end
end