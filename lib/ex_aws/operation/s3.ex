defmodule ExAws.Operation.S3 do
  @moduledoc """
  Holds data necessary for an operation on the S3 service.
  """

  defstruct stream_builder: nil,
            parser: &ExAws.Utils.identity/1,
            bucket: "",
            path: "/",
            http_method: nil,
            body: "",
            resource: "",
            params: %{},
            headers: %{},
            service: :s3

  @type t :: %__MODULE__{}

  defimpl ExAws.Operation do
    def perform(operation, config) do
      body = operation.body
      headers = operation.headers
      http_method = operation.http_method

      {operation, config} = add_bucket_to_path(operation, config)

      url =
        operation
        |> normalize_path()
        |> add_resource_to_params()
        |> ExAws.Request.Url.build(config)

      hashed_payload = ExAws.Auth.Utils.hash_sha256(body)

      headers =
        headers
        |> Map.put("x-amz-content-sha256", hashed_payload)
        |> put_content_length_header(body, http_method)
        |> Map.to_list()

      ExAws.Request.request(http_method, url, body, headers, config, operation.service)
      |> operation.parser.()
    end

    def stream!(%{stream_builder: fun}, config), do: fun.(config)

    defp put_content_length_header(headers, "", :get), do: headers

    defp put_content_length_header(headers, body, _) do
      Map.put(headers, "content-length", byte_size(body) |> Integer.to_string())
    end

    @spec add_bucket_to_path(operation :: ExAws.Operation.S3.t(), config :: map) ::
            {operation :: ExAws.Operation.S3.t(), config :: map}
    def add_bucket_to_path(operation, config \\ %{})

    def add_bucket_to_path(operation, %{virtual_host: true, host: base_host} = config) do
      vhost_domain = "#{operation.bucket}.#{base_host}"
      {operation, Map.put(config, :host, vhost_domain)}
    end

    def add_bucket_to_path(operation, config) do
      path = Path.join(["/", operation.bucket, operation.path]) |> Path.expand()
      {operation |> Map.put(:path, path), config}
    end

    @spec normalize_path(operation :: ExAws.Operation.S3.t()) ::
            ExAws.Operation.S3.t()
    def normalize_path(operation) do
      normalized_path =
        if String.first(operation.path) === "/" do
          operation.path
        else
          Path.join(["/", operation.path])
        end

      operation |> Map.put(:path, normalized_path)
    end

    @spec add_resource_to_params(operation :: ExAws.Operation.S3.t()) :: ExAws.Operation.S3.t()
    def add_resource_to_params(operation) do
      params = operation.params |> Map.new() |> Map.put(operation.resource, 1)
      operation |> Map.put(:params, params)
    end
  end
end
