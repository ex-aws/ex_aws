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
      path = "/#{operation.bucket}#{ensure_absolute(operation.path)}" |> expand_dot()
      {operation |> Map.put(:path, path), config}
    end

    @spec add_resource_to_params(operation :: ExAws.Operation.S3.t()) :: ExAws.Operation.S3.t()
    def add_resource_to_params(operation) do
      params = operation.params |> Map.new() |> Map.put(operation.resource, 1)
      operation |> Map.put(:params, params)
    end

    defp ensure_absolute(<<"/", _rest::binary>> = path), do: path
    defp ensure_absolute(path), do: "/#{path}"

    # A subset of Elixir's built-in Path.expand/1 - because it's OS-specific
    # we can't use it to normalise paths with "." or ".." in them (otherwise
    # it breaks on Windows because the /'s become \'s).
    defp expand_dot(<<"/", rest::binary>>), do: "/" <> do_expand_dot(rest)
    defp expand_dot(path), do: do_expand_dot(path)

    defp do_expand_dot(path), do: do_expand_dot(:binary.split(path, "/", [:global]), [])
    defp do_expand_dot([".." | t], [_, _ | acc]), do: do_expand_dot(t, acc)
    defp do_expand_dot([".." | t], []), do: do_expand_dot(t, [])
    defp do_expand_dot(["." | t], acc), do: do_expand_dot(t, acc)
    defp do_expand_dot([h | t], acc), do: do_expand_dot(t, ["/", h | acc])
    defp do_expand_dot([], []), do: ""
    defp do_expand_dot([], ["/" | acc]), do: IO.iodata_to_binary(:lists.reverse(acc))
  end
end
