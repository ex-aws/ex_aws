defmodule ExAws.Dynamo.Request do
  @moduledoc false

  @type response_t :: %{} | ExAws.Request.error_t

  def request(operation, config) do
    ExAws.Request.request(operation.http_method, config |> url, operation.data, operation.headers, config, operation.service)
    |> parse(config)
  end

  def parse({:error, result}, _), do: {:error, result}
  def parse({:ok, %{body: body}}, config) do
    {:ok, config.json_codec.decode!(body)}
  end

  defp url(%{scheme: scheme, host: host, port: port}) do
    [scheme, host, port |> port, "/"]
    |> IO.iodata_to_binary
  end

  defp port(80), do: ""
  defp port(p),  do: ":#{p}"
end
