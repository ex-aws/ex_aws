defmodule ExAws.S3.Request do
  def request(adapter, http_method, bucket, path, params \\ [], headers \\ []) do
    body = ""
    url = url(adapter.config, bucket, path)
    ExAws.Request.request(http_method, url, body, headers, adapter)
  end

  def url(config, bucket, path) do
    [
      config |> Keyword.get(:scheme),
      bucket,
      config |> Keyword.get(:host),
      path
    ] |> IO.iodata_to_binary
  end
end
