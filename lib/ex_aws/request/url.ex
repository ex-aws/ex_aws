defmodule ExAws.Request.Url do
  @moduledoc false

  @s3_services ["s3", :s3]

  @doc """
  Builds URL for an operation and a config"
  """
  def build(operation, config) do
    config
    |> Map.take([:scheme, :host, :port])
    |> Map.put(:query, query(operation))
    |> Map.put(:path, path(operation, config[:base_path]))
    |> normalize_scheme
    |> normalize_path(config.normalize_path)
    |> convert_port_to_integer
    |> (&struct(URI, &1)).()
    |> URI.to_string()
    |> trim_dangling_query()
  end

  # Some services put the query string in the operation path themselves:
  # ex_aws_lambda builds "<path>?<query>", which is just "<path>?" when there
  # are no params. Drop that dangling `?`, as this function always has. An S3
  # path is percent-encoded above, so it can never end in a literal `?` and a
  # key such as "foo?" is left alone.
  defp trim_dangling_query(url), do: String.trim_trailing(url, "?")

  # S3 object keys may contain any UTF-8 character, including ones that are
  # reserved in URLs such as `?` and `#`. Percent-encode the whole S3 path
  # (`base_path` included, as `sanitize/2` used to do) here, once, so that the
  # URL we build is well-formed: nothing in the key can then be mistaken for the
  # query string or a fragment by the signer, by `sanitize/2` or by the HTTP
  # client. Paths of other services are inserted verbatim, as before.
  defp path(%{path: path} = operation, base_path) do
    path = build_path(path, base_path)
    if Map.get(operation, :service) in @s3_services, do: uri_encode(path), else: path
  end

  defp build_path(path, nil), do: path
  defp build_path(path, ""), do: path

  defp build_path(path, base_path) do
    base_path
    |> String.trim_leading("/")
    |> then(&("/" <> &1))
    |> Path.join(path)
  end

  # Returns nil rather than "" when there are no params so that
  # `URI.to_string/1` does not emit a dangling `?`.
  defp query(operation) do
    case operation |> Map.get(:params, %{}) |> normalize_params() |> URI.encode_query() do
      "" -> nil
      query -> query
    end
  end

  defp normalize_scheme(url) do
    url |> Map.update(:scheme, "", &String.replace(&1, "://", ""))
  end

  defp normalize_path(url, false), do: url

  defp normalize_path(url, _normalize) do
    url |> Map.update(:path, "", &String.replace(&1, ~r/\/{2,}/, "/"))
  end

  defp convert_port_to_integer(url = %{port: port}) when is_binary(port) do
    {port, _} = Integer.parse(port)
    put_in(url[:port], port)
  end

  defp convert_port_to_integer(url), do: url

  defp normalize_params(params) when is_map(params) do
    params |> Map.delete("") |> Map.delete(nil)
  end

  defp normalize_params(params), do: params

  # The URL handed to `ExAws.Request.request/6` comes from `build/2`, so for S3
  # its path is already percent-encoded and must not be re-parsed or re-encoded
  # here. All that is left is to replace the `+` that `URI.encode_query/1` uses
  # for spaces in the query string with `%20`, which is what the canonical
  # (signed) query string contains.
  def sanitize(url, _service), do: String.replace(url, "+", "%20")

  def get_path(url, service \\ nil)
  # Used by `ExAws.Auth.presigned_url/9`, which is handed a URL whose path is
  # *not* percent-encoded (for example by `ExAws.S3.presigned_url/5`).
  #
  # Elixir's URI.parse will treat everything after the # sign
  # as a fragment. This is correct, but S3 treats it as part
  # of the path of the object.
  #
  # This will split the URL at the base with the right side
  # being the path, except for the query params.
  #
  # for example:
  # `"https://bucket.aws.com/my/path/here+ #3.txt?t=21"`
  # https://bucket.aws.com | /my/path/here+ #3.txt?t=21
  # ________base__________ | /my/path/here+ #3.txt | t=21
  # ________base__________ | /my/path/here+ #3.txt | _params_
  #
  # After using `uri_encode` it will be `/my/path/here%2B%20%233.txt`
  #
  # Note that because the path is unencoded, a `?` inside the object key cannot
  # be told apart from the start of the query string. That is why `build/2`
  # encodes S3 paths up front instead of relying on this function.
  def get_path(url, service) when service in @s3_services do
    base =
      url
      |> URI.parse()
      |> Map.put(:path, nil)
      |> Map.put(:query, nil)
      |> Map.put(:fragment, nil)
      |> URI.to_string()

    [_base, path_with_params] = String.split(url, base, parts: 2)
    [path | _query_params] = String.split(path_with_params, "?", parts: 2)

    path
  end

  def get_path(url, _), do: URI.parse(url).path || "/"

  def uri_encode(url), do: URI.encode(url, &valid_path_char?/1)

  @doc """
  Percent-encodes a caller-supplied value so that it occupies exactly one
  segment of a request path.

  Everything outside the RFC 3986 unreserved set is encoded, including `/`,
  `?`, `#` and `:`, so a value such as `"a/../b?x"` cannot add path segments or
  start the query string. The dot segments `.` and `..` are encoded as `%2E`
  and `%2E%2E` so that nothing between the client and the service can resolve
  them as path traversal. Other values that only contain unreserved characters
  are returned unchanged.

  Use this for a single segment (a resource name, an ARN, an email address).
  `uri_encode/1` is for whole paths and leaves `/` as it is.

      iex> ExAws.Request.Url.encode_path_segment("a/../b?x")
      "a%2F..%2Fb%3Fx"
      iex> ExAws.Request.Url.encode_path_segment("..")
      "%2E%2E"
      iex> ExAws.Request.Url.encode_path_segment("my-fn_1.0~")
      "my-fn_1.0~"
  """
  @spec encode_path_segment(String.Chars.t()) :: binary
  def encode_path_segment(segment) do
    case to_string(segment) do
      "." -> "%2E"
      ".." -> "%2E%2E"
      string -> URI.encode(string, &URI.char_unreserved?/1)
    end
  end

  # Space character
  defp valid_path_char?(?\s), do: false
  defp valid_path_char?(?/), do: true

  defp valid_path_char?(c) do
    URI.char_unescaped?(c) && !URI.char_reserved?(c)
  end
end
