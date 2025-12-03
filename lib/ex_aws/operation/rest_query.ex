defmodule ExAws.Operation.RestQuery do
  @moduledoc false

  defstruct stream_builder: nil,
            http_method: nil,
            path: "/",
            params: %{},
            body: "",
            service: nil,
            action: nil,
            parser: &ExAws.Utils.identity/2

  @type t :: %__MODULE__{}
end

defimpl ExAws.Operation, for: ExAws.Operation.RestQuery do
  def perform(operation, config) do
    headers = config[:headers] || []
    url = ExAws.Request.Url.build(operation, config)

    ExAws.Request.request(
      operation.http_method,
      url,
      operation.body,
      headers,
      config,
      operation.service
    )
    |> ExAws.Request.default_aws_error()
    |> operation.parser.(operation.action)
  end

  def stream!(%ExAws.Operation.RestQuery{stream_builder: nil}, _) do
    raise ArgumentError, """
    This operation does not support streaming!
    """
  end

  def stream!(%ExAws.Operation.RestQuery{stream_builder: stream_builder}, config_overrides) do
    stream_builder.(config_overrides)
  end
end
