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
    query =
      operation.params
      |> URI.encode_query

    headers = [
      {"content-type", "application/x-www-form-urlencoded"},
    ]

    ExAws.Request.request(:post, url(config, operation.path), query, headers, config, operation.service)
    |> operation.parser.(operation.action)
  end

  def stream!(_, _), do: nil

  def url(%{scheme: scheme, host: host, port: port}, queue_name) do
    [
      scheme,
      host,
      port |> port(),
      queue_name
    ] |> IO.iodata_to_binary
  end

  defp port(80), do: ""
  defp port(p),  do: ":#{p}"
end
