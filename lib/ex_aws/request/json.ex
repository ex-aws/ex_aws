defmodule ExAws.Request.JSON do
  @moduledoc false
  # JSON style api specific request logic.

  @type success_t :: %{}
  @type response_t :: {:ok, success_t} | ExAws.Request.error_t

  def request(client, action, data, target_prefix, json_version) do
    headers = [
      {"x-amz-target", "#{target_prefix}.#{action}"},
      {"content-type", "application/x-amz-json-#{json_version}"},
      {"x-amz-content-sha256", ""}
    ]
    ExAws.Request.request(:post, client.config |> url, data, headers, client)
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
