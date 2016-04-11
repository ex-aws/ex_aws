defmodule ExAws.SQS.Request do
  alias ExAws.Config
  @moduledoc false

  def request(client, queue_name, action, params = %{}) do
    client = client
    |> Config.parse_host_for_region

    query = params
    |> Map.put("Action", action)
    |> URI.encode_query

    headers = [
      {"content-type", "application/x-www-form-urlencoded"},
    ]

    ExAws.Request.request(:post, url(client.config, queue_name), query, headers, client)
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
