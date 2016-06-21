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

  defimpl ExAws.Operation do

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
      [scheme, do_url(host, bucket, path)]
      |> IO.iodata_to_binary
    end

    defp do_url(host, "", path) do
      [host, "/", no_slash(path)]
    end
    defp do_url(host, bucket, path) do
      [host, "/", bucket, ensure_slash(path)]
    end

    defp no_slash("/" <> path), do: path
    defp no_slash(path), do: path

    def ensure_slash("/" <> _ = path), do: path
    def ensure_slash(path), do:  "/" <> path

    def add_query(url, "", ""),          do: url
    def add_query(url, "", query),       do: url <> "?" <> query
    def add_query(url, resource, ""),    do: url <> "?" <> resource
    def add_query(url, resource, query), do: url <> "?" <> resource <> "&" <> query
  end
end


defmodule ExAws.Operation.S3DeleteAllObjects do
  defstruct [
    bucket: nil,
    objects: [],
    opts: []
  ]

  @type t :: %__MODULE__{}

  defimpl ExAws.Operation do

    def perform(%{bucket: bucket, files: files, opts: opts}, config) do
      request_fun = fn objects ->
        bucket
        |> ExAws.S3.delete_multiple_objects(objects, opts)
        |> ExAws.request(config)
      end
      delete_all_objects(request_fun, files, opts, [])
    end

    defp delete_all_objects(_request_fun, [], _opts, acc) do
      {:ok, Enum.reverse(acc)}
    end
    defp delete_all_objects(request_fun, objects, opts, acc) do
      {objects, rest} = Enum.split(objects, 1000)
      with {:ok, result} <- request_fun.(objects) do
        delete_all_objects(request_fun, rest, opts, [result | acc])
      end
    end

    def stream!(%{bucket: bucket, files: files, opts: opts}, config) do
      files
      |> Stream.chunk(1000, 1000, [])
      |> Stream.flat_map(fn objects ->
        bucket
        |> ExAws.S3.delete_multiple_objects(objects, opts)
        |> ExAws.request!(config)
      end)
    end
  end
end
