defmodule ExAws.Kinesis.Request do
  def request(client, action, data) do
    {operation, http_method} = ExAws.Kinesis.Impl |> ExAws.Actions.get(action)
    headers = [
      {"x-amz-target", operation},
      {"content-type", "application/x-amz-json-1.1"},
      {"x-amz-content-sha256", ""}
    ]
    ExAws.Request.request(http_method, client.config |> url, data, headers, client)
    |> parse(client.config)
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
      "/"
    ] |> IO.iodata_to_binary
  end
end
