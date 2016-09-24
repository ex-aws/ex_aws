defmodule ExAws.Operation.RestQuery do
  defstruct [
    http_method: nil,
    path: "/",
    params: %{},
    service: nil,
  ]

  @type t :: %__MODULE__{}
end

defimpl ExAws.Operation, for: ExAws.Operation.RestQuery do
  def perform(operation, config) do
    query = operation.params
    |> URI.encode_query

    headers = [
      {"content-type", "application/x-www-form-urlencoded"},
    ]

    ExAws.Request.request(operation.http_method, url(config, operation.path), query, headers, config, operation.service)
  end

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
