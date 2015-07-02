defmodule ExAws.Lambda.Request do
  @moduledoc false
  # Lambda specific request logic.

  def request(client, action, path, data, params \\ [], headers \\ []) do
    {_, http_method} = ExAws.Lambda.Impl |> ExAws.Actions.get(action)
    path = [path, params |> URI.encode_query] |> IO.iodata_to_binary

    headers = [
      {"content-type", "application/json"},
      {"x-amz-content-sha256", ""} |
      headers
    ]
    ExAws.Request.request(http_method, client.config |> url(path), data, headers , client)
    |> parse(client.config)
  end

  def parse({:error, result}, _), do: {:error, result}
  def parse({:ok, %{body: body}}, config) do
    {:ok, config[:json_codec].decode!(body)}
  end

  defp url(%{scheme: scheme, host: host}, path) do
    [scheme, host, path]
    |> IO.iodata_to_binary
  end
end
