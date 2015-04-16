defmodule ExAws.Dynamo.Request do
  def request(data, action, adapter) do
    {operation, http_method} = ExAws.Dynamo.Impl |> ExAws.Actions.get(action)
    headers = [
      {"x-amz-target", operation},
      {"content-type", "application/x-amz-json-1.0"}
    ]
    ExAws.Request.request(http_method, adapter |> url, data, headers, adapter)
  end

  defp url(adapter) do
    config = adapter.config
    [
      Keyword.get(config, :scheme),
      Keyword.get(config, :host),
      Keyword.get(config, :port) |> port,
      "/"
    ] |> IO.iodata_to_binary
  end

  defp port(80), do: ""
  defp port(p),  do: ":#{p}"
end
