defmodule ExAws.Kinesis.Request do
  def request(data, action, adapter) do
    {operation, http_method} = ExAws.Kinesis.Impl |> ExAws.Actions.get(action)
    headers = [
      {"x-amz-target", operation},
      {"content-type", "application/x-amz-json-1.1"}
    ]
    ExAws.Request.request(http_method, adapter.config |> url, data, headers, adapter)
  end

  defp url(config) do
    [
      Keyword.get(config, :scheme),
      Keyword.get(config, :host),
      "/"
    ] |> IO.iodata_to_binary
  end
end
