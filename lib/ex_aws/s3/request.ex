defmodule ExAws.S3.Request do
  def request(adapter, http_method, bucket, path, data \\ []) do
    body     = data |> Keyword.get(:body, "")
    resource = data |> Keyword.get(:resource, "")
    query    = data |> Keyword.get(:params, []) |> URI.encode_query
    headers  = data |> Keyword.get(:headers, [])


    url = adapter.config
    |> url(bucket, path)
    |> add_query(resource, query)

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
      bucket |> bucket?,
      config |> Keyword.get(:host),
      path   |> ensure_slash
    ] |> IO.iodata_to_binary
  end

  def add_query(url, "", ""),          do: url
  def add_query(url, "", query),       do: url <> "?" <> query
  def add_query(url, resource, ""),    do: url <> "?" <> resource
  def add_query(url, resource, query), do: url <> "?" <> resource <> "&" <> query

  defp ensure_slash("/" <> _ = path), do: path
  defp ensure_slash(path), do:  "/" <> path

  defp bucket?(""), do: ""
  defp bucket?(bucket), do: bucket <> "."
end
