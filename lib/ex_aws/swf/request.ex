defmodule ExAws.SWF.Request do
  @moduledoc false
  # SWF specific request logic.

  def request(client, action, data) do
    headers = [
      {"x-amz-target", "SimpleWorkflowService.#{action}"},
      {"content-type", "application/x-amz-json-1.0"},
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
