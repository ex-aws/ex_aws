defmodule ExAws.Operation.Query do
  @moduledoc """
  Datastructure representing an operation on a Query based AWS service

  These include:
  - SQS
  - SNS
  - SES
  """

  defstruct path: "/",
            params: %{},
            content_encoding: "identity",
            service: nil,
            action: nil,
            parser: &ExAws.Utils.identity/2

  @type t :: %__MODULE__{}
end

defimpl ExAws.Operation, for: ExAws.Operation.Query do
  def perform(operation, config) do
    data = operation.params |> URI.encode_query()

    data =
      case operation.content_encoding do
        "identity" -> data
        "gzip" -> :zlib.gzip(data)
      end

    url =
      operation
      |> Map.delete(:params)
      |> ExAws.Request.Url.build(config)

    headers = [
      {"content-type", "application/x-www-form-urlencoded"},
      {"content-encoding", operation.content_encoding}
    ]

    parser = wrap_parser(operation.parser, operation.action, config)

    ExAws.Request.request(:post, url, data, headers, config, operation.service,
      operation_parser: parser
    )
    |> ExAws.Request.default_aws_error()
    |> parser.()
  end

  def stream!(_, _), do: nil

  defp wrap_parser(parser, _action, _config) when is_function(parser, 1),
    do: parser

  defp wrap_parser(parser, action, _config) when is_function(parser, 2),
    do: fn result -> parser.(result, action) end

  defp wrap_parser(parser, action, config) when is_function(parser, 3),
    do: fn result -> parser.(result, action, config) end
end
