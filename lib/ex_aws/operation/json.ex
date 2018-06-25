defmodule ExAws.Operation.JSON do
  @moduledoc """
  Datastructure representing an operation on a JSON based AWS service.

  This module is generally not used directly, but rather is constructed by one
  of the relevant AWS services.

  These include:
  - DynamoDB
  - Kinesis
  - Lambda (Rest style)
  - ElasticTranscoder

  JSON services are generally pretty simple. You just need to populate the `data`
  attribute with whatever request body parameters need converted to JSON, and set
  any service specific headers.

  The `before_request`
  """

  defstruct stream_builder: nil,
            http_method: :post,
            parser: nil,
            path: "/",
            data: %{},
            params: %{},
            headers: [],
            service: nil,
            before_request: nil

  @type t :: %__MODULE__{}

  def new(service, opts) do
    struct(%__MODULE__{service: service, parser: & &1}, opts)
  end
end

defimpl ExAws.Operation, for: ExAws.Operation.JSON do
  @type response_t :: %{} | ExAws.Request.error_t()

  def perform(operation, config) do
    operation = handle_callbacks(operation, config)
    url = ExAws.Request.Url.build(operation, config)

    headers = [
      {"x-amz-content-sha256", ""} | operation.headers
    ]

    ExAws.Request.request(
      operation.http_method,
      url,
      operation.data,
      headers,
      config,
      operation.service
    )
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

  defp handle_callbacks(%{before_request: nil} = op, _), do: op

  defp handle_callbacks(%{before_request: callback} = op, config) do
    callback.(op, config)
  end

  defp parse({:error, result}, _), do: {:error, result}
  defp parse({:ok, %{body: ""}}, _), do: {:ok, %{}}

  defp parse({:ok, %{body: body}}, config) do
    {:ok, config[:json_codec].decode!(body)}
  end
end
