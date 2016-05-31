defmodule ExAws.Dynamo.Operation do
  defstruct [
    stream_builder: nil,
    http_method: :post,
    path: "/",
    data: %{},
    headers: [],
    target: nil,
    service: :dynamodb
  ]
end

defimpl ExAws.Operation, for: ExAws.Dynamo.Operation do
  @type response_t :: %{} | ExAws.Request.error_t

  def perform(operation, config) do
    headers = [
      {"x-amz-target", operation.target},
      {"content-type", "application/x-amz-json-1.0"},
      {"x-amz-content-sha256", ""}
    ]

    ExAws.Request.request(operation.http_method, config |> url, operation.data, headers, config, operation.service)
    |> parse(config)
  end

  def stream(%ExAws.Dynamo.Operation{stream_builder: nil}, _) do
    raise ArgumentError, """
    This operation does not support streaming!
    """
  end
  def stream(%ExAws.Dynamo.Operation{stream_builder: stream_builder}, config_overrides) do
    stream_builder.(config_overrides)
  end

  defp parse({:error, result}, _), do: {:error, result}
  defp parse({:ok, %{body: body}}, config) do
    {:ok, config.json_codec.decode!(body)}
  end

  defp url(%{scheme: scheme, host: host, port: port}) do
    [scheme, host, port |> port, "/"]
    |> IO.iodata_to_binary
  end

  defp port(80), do: ""
  defp port(p),  do: ":#{p}"
end
