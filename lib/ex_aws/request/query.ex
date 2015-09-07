defmodule ExAws.Request.Query do
  @moduledoc false
  # Query style specific request logic.

  @type success_t :: binary
  @type response_t :: {:ok, success_t} | ExAws.Request.error_t

  def request(client, uri, action, params) do
    query = params
    |> Enum.into(%{})
    |> Map.put("Action", action)
    |> Map.put("Version", client.version)
    |> URI.encode_query

    url = client.config
    |> url(uri)

    headers = [
      {"content-type", "application/x-www-form-urlencoded"},
    ]
    ExAws.Request.request(:post, url, query, headers, client)
  end

  defp url(%{scheme: scheme, host: host}, uri) do
    [scheme, host, uri]
    |> IO.iodata_to_binary
  end
end
