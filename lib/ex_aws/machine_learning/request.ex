defmodule ExAws.MachineLearning.Request do
  @moduledoc false
  # MachineLearning specific request logic.

  def request(client, action, data) do
    headers = [
      {"x-amz-target", "AmazonML_20141212.#{action}"},
      {"content-type", "application/x-amz-json-1.1"},
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
