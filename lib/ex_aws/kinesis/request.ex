defmodule ExAws.Kinesis.Request do
  @moduledoc false
  # Kinesis specific request logic.

  @type response_t :: %{} | ExAws.Request.error_t

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
  def parse({:ok, %{body: body}}, config) do
    {:ok, config[:json_codec].decode!(body)}
  end

  defp url(%{scheme: scheme, host: host}) do
    [scheme, host, "/"]
    |> IO.iodata_to_binary
  end
end
