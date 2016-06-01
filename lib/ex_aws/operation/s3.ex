defmodule ExAws.Operation.S3 do
  @moduledoc """
  Holds data necessary for an operation on the S3 service.
  """

  defstruct [
    stream_builder: nil,
    parser: &ExAws.Utils.identity/1,
    bucket: "",
    path: "/",
    http_method: nil,
    body: "",
    resource: "",
    params: %{},
    headers: %{},
    service: :s3
  ]

  @type t :: %__MODULE__{}
end

defimpl ExAws.Operation, for: ExAws.Operation.S3 do

  def perform(operation, config) do
    bucket   = operation.bucket
    body     = operation.body
    resource = operation.resource
    query    = operation.params |> URI.encode_query
    headers  = operation.headers
    path     = operation.path
    http_method = operation.http_method

    url =
      config
      |> url(bucket, path)
      |> add_query(resource, query)

    hashed_payload = ExAws.Auth.Utils.hash_sha256(body)

    headers = headers
    |> Map.put("x-amz-content-sha256", hashed_payload)
    |> Map.put("content-length", byte_size(body))
    |> Map.to_list

    ExAws.Request.request(http_method, url, body, headers, config, operation.service)
    |> operation.parser.()
  end

  def stream!(%{stream_builder: fun}, config) do
    fun.(config)
  end

  def url(%{scheme: scheme, host: host}, bucket, path) do
    [ scheme, host_and_bucket(host, bucket), ExAws.S3.Utils.ensure_slash(path) ]
    |> IO.iodata_to_binary
  end

  def add_query(url, "", ""),          do: url
  def add_query(url, "", query),       do: url <> "?" <> query
  def add_query(url, resource, ""),    do: url <> "?" <> resource
  def add_query(url, resource, query), do: url <> "?" <> resource <> "&" <> query

  defp host_and_bucket(host, ""), do: host
  defp host_and_bucket(host, bucket) do
    case bucket |> String.contains?(".") do
      true  -> [host, "/", bucket]
      false -> [bucket, ".", host]
    end
  end
end
