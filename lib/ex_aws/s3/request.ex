defmodule ExAws.S3.Request do
  @moduledoc false
  # S3 specific request logic.

  def request(client, http_method, bucket, path, data \\ []) do
    body     = data |> Keyword.get(:body, "")
    resource = data |> Keyword.get(:resource, "")
    query    = data |> Keyword.get(:params, %{}) |> URI.encode_query
    headers  = data |> Keyword.get(:headers, %{})


    url = client.config
    |> url(bucket, path)
    |> add_query(resource, query)

    hashed_payload = ExAws.Auth.Utils.hash_sha256(body)

    headers = headers
    |> Map.put("x-amz-content-sha256", hashed_payload)
    |> Map.put("content-length", byte_size(body))
    |> Map.to_list

    ExAws.Request.request(http_method, url, body, headers, client)
  end

  def url(%{scheme: scheme, host: host}, bucket, path) do
    [ scheme, host_and_bucket(host, bucket), ensure_slash(path) ]
    |> IO.iodata_to_binary
  end

  def add_query(url, "", ""),          do: url
  def add_query(url, "", query),       do: url <> "?" <> query
  def add_query(url, resource, ""),    do: url <> "?" <> resource
  def add_query(url, resource, query), do: url <> "?" <> resource <> "&" <> query

  defp ensure_slash("/" <> _ = path), do: path
  defp ensure_slash(path), do:  "/" <> path

  defp host_and_bucket(host, ""), do: host
  defp host_and_bucket(host, bucket) do
    case bucket |> String.contains?(".") do
      true  -> [host, "/", bucket]
      false -> [bucket, ".", host]
    end
  end
end
