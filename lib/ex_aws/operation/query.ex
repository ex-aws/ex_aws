defmodule ExAws.Operation.Query do
  @moduledoc """
  Datastructure representing an operation on a JSON based AWS service

  These include:
  - SQS
  - SNS
  """

  defstruct [
    path: "/",
    params: %{},
    service: nil
  ]
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
  end

  def url(%{scheme: scheme, host: host, port: port}, queue_name) do
    [
      scheme,
      host,
      port |> port(),
      queue_name |> with_slash
    ] |> IO.iodata_to_binary
  end

  defp port(80), do: ""
  defp port(p),  do: ":#{p}"

  def with_slash(""), do: "/"
  def with_slash(queue), do: ["/", queue]
end
