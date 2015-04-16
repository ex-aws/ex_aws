defmodule ExAws.S3.Request do
  def request(adapter, http_method, bucket, path, body \\ "", params \\ [], headers \\ []) do
    url = url(adapter.config, bucket, path)
    hashed_payload = AWSAuth.Utils.hash_sha256(body)
    headers = [
      {"x-amz-content-sha256", hashed_payload} |
      headers
    ]
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
