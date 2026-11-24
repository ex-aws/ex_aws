defmodule ExAws.Operation.S3 do
  @moduledoc """
  Holds data necessary for an operation on the S3 service.

  ## Request host

  By default the bucket is placed in the request path. Two S3 config options
  move it into the request host instead:

    * `virtual_host: true` - the request is sent to `<bucket>.<host>`. The
      bucket may only contain letters, digits, `.`, `-` and `_`, so the request
      always stays under the configured `host`.
    * `virtual_host: true, bucket_as_host: true` - the bucket name is used as
      the *whole* hostname (for example a CNAME pointing at a bucket).

  ### Security of `bucket_as_host`

  With `bucket_as_host: true` whoever chooses the bucket name chooses the
  server the signed request is sent to, including its body, the
  `Authorization` header and any `x-amz-security-token`. A name such as
  `attacker.example`, `localhost` or `169.254.169.254` is a perfectly valid
  hostname, so no character check can prevent this. **Never pass an untrusted
  bucket name when `bucket_as_host` is enabled.**

  If bucket names are not fully under your control, set
  `bucket_as_host_allowlist` to the hostnames you trust. Any other bucket
  raises `ArgumentError` before a request is built:

      config :ex_aws, :s3,
        virtual_host: true,
        bucket_as_host: true,
        bucket_as_host_allowlist: ["assets.example.com", "media.example.com"]

  Hostnames are compared case-insensitively. When the option is not set, any
  syntactically valid hostname is accepted.
  """

  defstruct stream_builder: nil,
            parser: &Function.identity/1,
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
      |> ExAws.Request.default_aws_error()
      |> operation.parser.()
    end

    def stream!(%{stream_builder: fun}, config), do: fun.(config)

    defp put_content_length_header(headers, "", :get), do: headers

    defp put_content_length_header(headers, "", :head), do: headers

    defp put_content_length_header(headers, "", :delete), do: headers

    defp put_content_length_header(headers, body, _) do
      Map.put(headers, "content-length", IO.iodata_length(body) |> Integer.to_string())
    end

    @spec add_bucket_to_path(operation :: ExAws.Operation.S3.t(), config :: map) ::
            {operation :: ExAws.Operation.S3.t(), config :: map}
    def add_bucket_to_path(operation, config \\ %{})

    def add_bucket_to_path(%{bucket: nil}, _config) do
      raise "#{__MODULE__}.perform/2 cannot perform operation on `nil` bucket"
    end

    def add_bucket_to_path(operation, %{virtual_host: true, bucket_as_host: true} = config) do
      # When bucket_as_host is true, use the bucket name as the full hostname
      host =
        operation.bucket
        |> validate_host_bucket!()
        |> validate_allowed_host!(Map.get(config, :bucket_as_host_allowlist))

      {put_in(operation.path, ensure_absolute(operation.path)), Map.put(config, :host, host)}
    end

    def add_bucket_to_path(operation, %{virtual_host: true, host: base_host} = config) do
      vhost_domain = "#{validate_host_bucket!(operation.bucket)}.#{base_host}"

      {put_in(operation.path, ensure_absolute(operation.path)),
       Map.put(config, :host, vhost_domain)}
    end

    def add_bucket_to_path(operation, config) do
      path = "/#{operation.bucket}#{ensure_absolute(operation.path)}"
      {operation |> Map.put(:path, path), config}
    end

    @spec add_resource_to_params(operation :: ExAws.Operation.S3.t()) :: ExAws.Operation.S3.t()
    def add_resource_to_params(operation) do
      params = operation.params |> Map.new() |> Map.put(operation.resource, 1)
      operation |> Map.put(:params, params)
    end

    defp ensure_absolute(<<"/", _rest::binary>> = path), do: path
    defp ensure_absolute(path), do: "/#{path}"

    # When the bucket is used as (part of) the hostname it must only contain
    # characters that are valid in a DNS name. Anything else (`/`, `?`, `#`,
    # `@`, `:`, whitespace, control characters, ...) would change which host the
    # signed request is sent to: with the bucket "attacker.example/x?" the URL
    # becomes https://attacker.example/x?.s3.amazonaws.com/key and the HTTP
    # client connects to attacker.example.
    defp validate_host_bucket!(bucket) when is_binary(bucket) and bucket != "" do
      if hostname_chars?(bucket) do
        bucket
      else
        raise ArgumentError,
              "invalid bucket name #{inspect(bucket)} for virtual host style requests: " <>
                "only letters, digits, `.`, `-` and `_` are allowed"
      end
    end

    defp validate_host_bucket!(bucket) when is_atom(bucket) and bucket != nil do
      bucket |> Atom.to_string() |> validate_host_bucket!()
    end

    defp validate_host_bucket!(bucket) do
      raise ArgumentError,
            "invalid bucket name #{inspect(bucket)} for virtual host style requests"
    end

    # With `bucket_as_host: true` the bucket is the entire hostname, so the
    # character check above cannot stop a bucket such as "attacker.example" or
    # "169.254.169.254" from receiving the signed request. Callers that cannot
    # fully trust their bucket names opt in to an explicit list of hosts.
    defp validate_allowed_host!(host, nil), do: host

    defp validate_allowed_host!(host, allowlist) when is_list(allowlist) do
      downcased = String.downcase(host)

      if Enum.any?(allowlist, &(is_binary(&1) and String.downcase(&1) == downcased)) do
        host
      else
        raise ArgumentError,
              "bucket #{inspect(host)} is not in the configured `bucket_as_host_allowlist`"
      end
    end

    defp validate_allowed_host!(_host, allowlist) do
      raise ArgumentError,
            "invalid `bucket_as_host_allowlist` #{inspect(allowlist)}: expected a list of hostnames"
    end

    defp hostname_chars?(<<c, rest::binary>>)
         when c in ?a..?z or c in ?A..?Z or c in ?0..?9 or c in [?., ?-, ?_],
         do: hostname_chars?(rest)

    defp hostname_chars?(<<>>), do: true
    defp hostname_chars?(_), do: false
  end
end
