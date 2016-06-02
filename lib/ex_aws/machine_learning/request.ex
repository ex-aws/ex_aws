defmodule ExAws.MachineLearning.Request do
  @moduledoc false
  # MachineLearning specific request logic.

  def request(client, action, data, headers \\ []) do
    {operation, http_method} = ExAws.MachineLearning.Impl |> ExAws.Actions.get(action)
    headers = [
      {"x-amz-target", operation},
      {"content-type", "application/x-amz-json-1.1"}
    ]

    predict_endpoint = client.config |> url
    data = data
    |> Map.put("PredictEndpoint", predict_endpoint)
    |> Map.put("MLModelId", client.config[:model_id])

    request = ExAws.Request.request(http_method, predict_endpoint, data, headers, client)
    request |> parse(client.config)
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
