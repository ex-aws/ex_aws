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
      body     = operation.body
      headers  = operation.headers
      http_method = operation.http_method

      url = operation
      |> add_bucket_to_path
      |> add_resource_to_params
      |> ExAws.Request.Url.build(config)

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

    def add_bucket_to_path(operation) do
      path = "/#{operation.bucket}/#{operation.path}" |> String.trim_leading("//")
      operation |> Map.put(:path, path)
    end

    def add_resource_to_params( operation) do
      params = operation.params |> Map.new |> Map.put(operation.resource, 1)
      operation |> Map.put(:params, params)
    end
  end
end


defmodule ExAws.Operation.S3DeleteAllObjects do
  defstruct [
    bucket: nil,
    objects: [],
    opts: [],
    service: :s3
  ]

  @type t :: %__MODULE__{}

  defimpl ExAws.Operation do

    def perform(%{bucket: bucket, objects: objects, opts: opts}, config) do
      request_fun = fn objects_in_batch ->
        bucket
        |> ExAws.S3.delete_multiple_objects(objects_in_batch, opts)
        |> ExAws.request(config)
      end
      delete_all_objects(request_fun, objects, opts, [])
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

    def stream!(%{bucket: bucket, objects: objects, opts: opts}, config) do
      objects
      |> Stream.chunk(1000, 1000, [])
      |> Stream.flat_map(fn objects_in_batch ->
        bucket
        |> ExAws.S3.delete_multiple_objects(objects_in_batch, opts)
        |> ExAws.request!(config)
      end)
    end
  end
end
