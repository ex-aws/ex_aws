defmodule ExAws.Dynamo.Request do
  alias ExAws.Config
  @moduledoc false

  @type response_t :: %{} | ExAws.Request.error_t

  def request(client, action, data) do
    client = client
    |> Config.parse_host_for_region

    {operation, http_method} = ExAws.Dynamo.Impl |> ExAws.Actions.get(action)
    headers = [
      {"x-amz-target", operation},
      {"content-type", "application/x-amz-json-1.0"},
      {"x-amz-content-sha256", ""}
    ]
    ExAws.Request.request(http_method, client.config |> url, data, headers, client)
    |> parse(client.config)
  end

  def parse({:error, result}, _), do: {:error, result}
  def parse({:ok, %{body: body}}, config) do
    {:ok, config[:json_codec].decode!(body)}
  end

  defp url(%{scheme: scheme, host: host, port: port}) do
    [scheme, host, port |> port, "/"]
    |> IO.iodata_to_binary
  end

  defp port(80), do: ""
  defp port(p),  do: ":#{p}"
end
