defmodule ExAws.Auth do
  import ExAws.Auth.Utils

  alias ExAws.Auth.Credentials
  alias ExAws.Auth.Signatures
  alias ExAws.Request.Url

  @moduledoc false

  @unsignable_headers ["x-amzn-trace-id"]
  @unsignable_headers_multi_case ["x-amzn-trace-id", "X-Amzn-Trace-Id"]

  def validate_config(config) do
    with :ok <- get_key(config, :secret_access_key),
         :ok <- get_key(config, :access_key_id) do
      {:ok, config}
    end
  end

  defp get_key(config, key) do
    case Map.fetch(config, key) do
      :error ->
        {:error, "Required key: #{inspect(key)} not found in config!"}

      {:ok, nil} ->
        {:error, "Required key: #{inspect(key)} is nil in config!"}

      {:ok, val} when is_binary(val) ->
        :ok

      {:ok, val} ->
        {:error, "Required key: #{inspect(key)} must be a string, but instead is #{inspect(val)}"}
    end
  end

  def headers(http_method, url, service, config, headers, body) do
    with {:ok, config} <- validate_config(config) do
      datetime = :calendar.universal_time()

      headers =
        [
          {"host", URI.parse(url).authority},
          {"x-amz-date", amz_date(datetime)}
          | headers
        ]
        |> handle_temp_credentials(config)

      auth_header =
        auth_header(
          http_method,
          url,
          headers,
          body,
          service |> service_override(config) |> service_name,
          datetime,
          config
        )

      {:ok, [{"Authorization", auth_header} | headers]}
    end
  end

  def presigned_url(
        http_method,
        url,
        service,
        datetime,
        config,
        expires,
        query_params \\ [],
        body \\ nil,
        headers \\ []
      ) do
    with {:ok, config} <- validate_config(config) do
      service = service_name(service)
      signed_headers = presigned_url_headers(url, headers)

      uri = URI.parse(url)
      uri_query = query_from_parsed_uri(uri)

      org_query_params =
        Enum.reduce(query_params, uri_query, fn {k, v}, acc -> [{to_string(k), v} | acc] end)

      amz_query_params =
        build_amz_query_params(service, datetime, config, expires, signed_headers)

      query_to_sign = (org_query_params ++ amz_query_params) |> canonical_query_params()

      amz_query_string = canonical_query_params(amz_query_params)

      query_for_url =
        if Enum.any?(org_query_params) do
          canonical_query_params(org_query_params) <> "&" <> amz_query_string
        else
          amz_query_string
        end

      path = url |> Url.get_path(service) |> Url.uri_encode()

      signature =
        signature(
          http_method,
          url,
          query_to_sign,
          signed_headers,
          body,
          service,
          datetime,
          config
        )

      {:ok,
       "#{uri.scheme}://#{uri.authority}#{path}?#{query_for_url}&X-Amz-Signature=#{signature}"}
    end
  end

  defp handle_temp_credentials(headers, %{security_token: token}) do
    [{"X-Amz-Security-Token", token} | headers]
  end

  defp handle_temp_credentials(headers, _), do: headers

  defp auth_header(http_method, url, headers, body, service, datetime, config) do
    query =
      url
      |> URI.parse()
      |> query_from_parsed_uri()
      |> canonical_query_params()

    signature = signature(http_method, url, query, headers, body, service, datetime, config)

    [
      "AWS4-HMAC-SHA256 Credential=",
      Credentials.generate_credential_v4(service, config, datetime),
      ",",
      "SignedHeaders=",
      signed_headers(headers),
      ",",
      "Signature=",
      signature
    ]
    |> IO.iodata_to_binary()
  end

  defp query_from_parsed_uri(%{query: nil}), do: []

  defp query_from_parsed_uri(%{query: query_string}) do
    query_string
    |> URI.decode_query()
    |> Enum.to_list()
  end

  defp signature(http_method, url, query, headers, body, service, datetime, config) do
    path = url |> Url.get_path(service) |> Url.uri_encode()
    request = build_canonical_request(http_method, path, query, headers, body)
    string_to_sign = string_to_sign(request, service, datetime, config)
    Signatures.generate_signature_v4(service, config, datetime, string_to_sign)
  end

  def build_canonical_request(http_method, path, query, headers, body) do
    http_method = http_method |> method_string |> String.upcase()

    headers = headers |> canonical_headers

    header_string =
      headers
      |> Enum.map(fn {k, v} -> "#{k}:#{remove_dup_spaces(to_string(v))}" end)
      |> Enum.join("\n")

    signed_headers_list = signed_headers_value(headers)

    payload =
      case body do
        nil -> "UNSIGNED-PAYLOAD"
        _ -> ExAws.Auth.Utils.hash_sha256(body)
      end

    [
      http_method,
      "\n",
      path,
      "\n",
      query,
      "\n",
      header_string,
      "\n",
      "\n",
      signed_headers_list,
      "\n",
      payload
    ]
    |> IO.iodata_to_binary()
  end

  defp remove_dup_spaces(""), do: ""
  defp remove_dup_spaces("  " <> rest), do: remove_dup_spaces(" " <> rest)

  defp remove_dup_spaces(<<char::binary-1, rest::binary>>) do
    char <> remove_dup_spaces(rest)
  end

  defp string_to_sign(request, service, datetime, config) do
    request = hash_sha256(request)

    """
    AWS4-HMAC-SHA256
    #{amz_date(datetime)}
    #{Credentials.generate_credential_scope_v4(service, config, datetime)}
    #{request}
    """
    |> String.trim_trailing()
  end

  defp signed_headers(headers) do
    headers
    |> Enum.map(fn {k, _} -> String.downcase(k) end)
    |> Kernel.--(@unsignable_headers)
    |> Enum.sort(&(&1 < &2))
    |> Enum.join(";")
  end

  defp canonical_query_params(params) do
    params
    |> Enum.sort(&compare_query_params/2)
    |> Enum.map_join("&", &pair/1)
  end

  defp compare_query_params({key, value1}, {key, value2}), do: value1 < value2
  defp compare_query_params({key_1, _}, {key_2, _}), do: key_1 < key_2

  defp pair({k, _}) when is_list(k) do
    raise ArgumentError, "encode_query/1 keys cannot be lists, got: #{inspect(k)}"
  end

  defp pair({_, v}) when is_list(v) do
    raise ArgumentError, "encode_query/1 values cannot be lists, got: #{inspect(v)}"
  end

  defp pair({k, v}) do
    URI.encode_www_form(Kernel.to_string(k)) <> "=" <> aws_encode_www_form(Kernel.to_string(v))
  end

  # is basically the same as URI.encode_www_form
  # but doesn't use %20 instead of "+"
  def aws_encode_www_form(str) when is_binary(str) do
    import Bitwise

    for <<c <- str>>, into: "" do
      case URI.char_unreserved?(c) do
        true -> <<c>>
        false -> "%" <> hex(bsr(c, 4)) <> hex(band(c, 15))
      end
    end
  end

  defp hex(n) when n <= 9, do: <<n + ?0>>
  defp hex(n), do: <<n + ?A - 10>>

  defp canonical_headers(headers) do
    headers
    |> Enum.reduce([], fn
      {k, _v}, acc when k in @unsignable_headers_multi_case -> acc
      {k, v}, acc when is_binary(v) -> [{String.downcase(to_string(k)), String.trim(v)} | acc]
      {k, v}, acc -> [{String.downcase(to_string(k)), v} | acc]
    end)
    |> Enum.sort(fn {k1, _}, {k2, _} -> k1 < k2 end)
  end

  defp presigned_url_headers(url, headers) do
    uri = URI.parse(url)
    canonical_headers([{"host", uri.authority} | headers])
  end

  defp build_amz_query_params(service, datetime, config, expires, signed_headers) do
    [
      {"X-Amz-Algorithm", "AWS4-HMAC-SHA256"},
      {"X-Amz-Credential", Credentials.generate_credential_v4(service, config, datetime)},
      {"X-Amz-Date", amz_date(datetime)},
      {"X-Amz-Expires", expires},
      {"X-Amz-SignedHeaders", signed_headers_value(signed_headers)}
    ] ++
      if config[:security_token] do
        [{"X-Amz-Security-Token", config[:security_token]}]
      else
        []
      end
  end

  defp signed_headers_value(headers) do
    headers
    |> Enum.map(&elem(&1, 0))
    |> Enum.join(";")
  end

  defp service_override(service, config) do
    if config[:service_override] do
      config[:service_override]
    else
      service
    end
  end
end
