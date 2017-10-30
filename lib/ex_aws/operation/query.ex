defmodule ExAws.Operation.Query do
  @moduledoc """
  Datastructure representing an operation on a Query based AWS service

  These include:
  - SQS
  - SNS
  - SES
  """

  defstruct [
    path: "/",
    params: %{},
    service: nil,
    action: nil,
    parser: &ExAws.Utils.identity/2
  ]

  @type t :: %__MODULE__{}
end

defimpl ExAws.Operation, for: ExAws.Operation.Query do
  def perform(operation, config) do

    # If the content type is json, do not convert to URI encoded. Will get converted
    # to JSON as part of the ExAWs.Request.request
    data = if Map.get(config, :content_type, "") =~ "application/x-amz-json" do
      operation.params

    # Convert params to URI encoded
    else
      operation.params |> URI.encode_query
    end

    url = operation
    |> Map.delete(:params)
    |> ExAws.Request.Url.build(config)

    headers = [
      {"content-type", config[:content_type] || "application/x-www-form-urlencoded"},
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
