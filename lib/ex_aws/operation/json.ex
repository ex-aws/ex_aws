defmodule ExAws.Operation.JSON do
  @moduledoc """
  Datastructure representing an operation on a JSON based AWS service

  These include:
  - DynamoDB
  - Kinesis
  - Lambda (Rest style)
  """

  defstruct [
    stream_builder: nil,
    http_method: :post,
    path: "/",
    data: %{},
    headers: [],
    service: nil,
  ]

  @type t :: %__MODULE__{}

  def new(service, opts) do
    struct(%__MODULE__{service: service}, opts)
  end
end

defimpl ExAws.Operation, for: ExAws.Operation.JSON do
  @type response_t :: %{} | ExAws.Request.error_t

  def perform(operation, config) do
    headers = [
      {"x-amz-content-sha256", ""} | operation.headers
    ]

    ExAws.Request.request(operation.http_method, config |> url(operation.path), operation.data, headers, config, operation.service)
    |> parse(config)
  end

  def stream!(%ExAws.Operation.JSON{stream_builder: nil}, _) do
    raise ArgumentError, """
    This operation does not support streaming!
    """
  end
  def stream!(%ExAws.Operation.JSON{stream_builder: stream_builder}, config_overrides) do
    stream_builder.(config_overrides)
  end

  defp parse({:error, result}, _), do: {:error, result}
  defp parse({:ok, %{body: ""}}, _), do: {:ok, %{}}
  defp parse({:ok, %{body: body}}, config) do
    {:ok, config[:json_codec].decode!(body)}
  end

  defp url(%{scheme: scheme, host: host, port: port}, path) do
    [scheme, host, port |> port, path]
    |> IO.iodata_to_binary
  end

  defp port(80), do: ""
  defp port(443), do: ""
  defp port(p),  do: ":#{p}"
end
