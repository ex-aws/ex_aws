defmodule ExAws.Route53.Request do
  @moduledoc false

  def request(client, method, path, params = %{}) do

    headers = [
      {"content-type", "text/plain"}
    ]

    query = params
    |> URI.encode_query

    ExAws.Request.request(method, url(client.config, path), query, headers, client)
  end

  def url(%{scheme: scheme, host: host, port: port, version: version}, path) do
    [
      scheme,
      host,
      port |> port,
      "/",
      version,
      "/",
      path,
    ] |> IO.iodata_to_binary
  end

  defp port(443), do: ""
  defp port(p),  do: ":#{p}"
end
