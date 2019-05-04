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

    result = ExAws.Request.request(:post, url, data, headers, config, operation.service)
    parser = operation.parser

    cond do
      is_function(parser, 2) ->
        parser.(result, operation.action)

      is_function(parser, 3) ->
        parser.(result, operation.action, config)

      true ->
        result
    end
  end

  def stream!(_, _), do: nil
end
