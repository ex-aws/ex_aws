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

    parser = wrap_parser(operation.parser, operation.action, config)

    ExAws.Request.request(
      operation.http_method,
      url,
      operation.body,
      headers,
      config,
      operation.service,
      operation_parser: parser
    )
    |> ExAws.Request.default_aws_error()
    |> parser.()
  end

  defp wrap_parser(parser, _action, _config) when is_function(parser, 1),
    do: parser

  defp wrap_parser(parser, action, _config) when is_function(parser, 2),
    do: fn result -> parser.(result, action) end

  defp wrap_parser(parser, action, config) when is_function(parser, 3),
    do: fn result -> parser.(result, action, config) end

  def stream!(%ExAws.Operation.RestQuery{stream_builder: nil}, _) do
    raise ArgumentError, """
    This operation does not support streaming!
    """
  end

  def stream!(%ExAws.Operation.RestQuery{stream_builder: stream_builder}, config_overrides) do
    stream_builder.(config_overrides)
  end
end
