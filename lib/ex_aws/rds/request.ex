defmodule ExAws.RDS.Request do
  
  @moduledoc false
  # RDS specific request logic

  #@region Application.get_all_env(:ex_aws) |> Keyword.fetch!(:rds) |> Keyword.fetch!(:region)

  def request(client, http_method, path, data \\ []) do
    body     = data |> Keyword.get(:body, "")
    resource = data |> Keyword.get(:resource, "")
    query    = data |> Keyword.get(:params, %{}) |> URI.encode_query
    headers  = data |> Keyword.get(:headers, %{})

    url = client.config
    |> url(path)
    |> add_query(resource, query)

    hashed_payload = ExAws.Auth.Utils.hash_sha256(body)

    headers = headers
    |> Map.put("x-amz-content-sha256", hashed_payload)
    |> Map.put("content-length", byte_size(body))
    |> Map.to_list

    ExAws.Request.request(http_method, url, body, headers, client)
  end

  def url(%{scheme: scheme, host: host} = config, path) do 
    (scheme <> host <> path)
    |> IO.iodata_to_binary
  end

  def add_query(url, "", ""),          do: url
  def add_query(url, "", query),       do: url <> "?" <> query
  def add_query(url, resource, ""),    do: url <> "?" <> resource
  def add_query(url, resource, query), do: url <> "?" <> resource <> "&" <> query

  def ensure_slash("/" <> _ = path), do: path
  def ensure_slash(path), do:  "/" <> path
end
