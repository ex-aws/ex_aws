defmodule ExAws.Dynamo.Request do
  def request(adapter, action, data) do
    {operation, http_method} = ExAws.Dynamo.Impl |> ExAws.Actions.get(action)
    headers = [
      {"x-amz-target", operation},
      {"content-type", "application/x-amz-json-1.0"},
      {"x-amz-content-sha256", ""}
    ]
    ExAws.Request.request(http_method, adapter.config |> url, data, headers, adapter)
    |> parse(adapter.config)
  end

  def parse({:error, result}, _), do: {:error, result}
  def parse({:ok, body}, config) do
    case config[:json_codec].decode(body) do
      {:ok, result} -> {:ok, result}
      {:error, _}   -> {:error, body}
    end
  end

  defp url(config) do
    [
      Keyword.get(config, :scheme),
      Keyword.get(config, :host),
      Keyword.get(config, :port) |> port,
      "/"
    ] |> IO.iodata_to_binary
  end

  defp port(80), do: ""
  defp port(p),  do: ":#{p}"
end
