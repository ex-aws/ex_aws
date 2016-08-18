defmodule ExAws.Auth do
  import ExAws.Auth.Utils

  @moduledoc false

  def headers(http_method, url, service, config, headers, body) do
    datetime = :calendar.universal_time
    headers = [
      {"host", URI.parse(url).host},
      {"x-amz-date", amz_date(datetime)} |
      headers
    ]
    |> handle_temp_credentials(config)

    auth_header = auth_header(
      http_method,
      url,
      headers,
      body,
      service |> service_name,
      datetime,
      config)

    [{"Authorization", auth_header} | headers ]
  end

  def presigned_url(http_method, url, service, datetime, config, expires, query_params \\ []) do
    service = service_name(service)
    headers = presigned_url_headers(url)
    query = presigned_url_query(service, datetime, config, expires, query_params)
    url = "#{url}?#{query}"
    signature = signature(http_method, url, headers, nil, service, datetime, config)
    "#{url}&X-Amz-Signature=#{signature}"
  end

  defp handle_temp_credentials(headers, %{security_token: token}) do
    [{"X-Amz-Security-Token", token} | headers]
  end
  defp handle_temp_credentials(headers, _), do: headers

  defp auth_header(http_method, url, headers, body, service, datetime, config) do
    signature = signature(http_method, url, headers, body, service, datetime, config)
    [
      "AWS4-HMAC-SHA256 Credential=", credentials(service, datetime, config), ",",
      "SignedHeaders=", signed_headers(headers), ",",
      "Signature=", signature
    ] |> IO.iodata_to_binary
  end

  defp signature(http_method, url, headers, body, service, datetime, config) do
    request = build_canonical_request(http_method, url, headers, body)
    string_to_sign = string_to_sign(request, service, datetime, config)
    signing_key = signing_key(service, datetime, config)
    hmac_sha256(signing_key, string_to_sign) |> bytes_to_hex
  end

  def build_canonical_request(http_method, url, headers, body) do
    uri = URI.parse(url)
    http_method = http_method |> method_string |> String.upcase

    query_params = uri.query |> canonical_query_params

    headers = headers |> canonical_headers
    header_string = headers
    |> Enum.map(fn {k, v} -> "#{k}:#{remove_dup_spaces(to_string(v))}" end)
    |> Enum.join("\n")

    signed_headers_list = headers
    |> Keyword.keys
    |> Enum.join(";")

    payload = case body do
      nil -> "UNSIGNED-PAYLOAD"
      _ -> ExAws.Auth.Utils.hash_sha256(body)
    end

    [
      http_method, "\n",
      uri_encode(uri.path), "\n",
      query_params, "\n",
      header_string, "\n",
      "\n",
      signed_headers_list, "\n",
      payload
    ] |> IO.iodata_to_binary
  end

  defp remove_dup_spaces(""), do: ""
  defp remove_dup_spaces("  " <> rest), do: remove_dup_spaces(" " <> rest)
  defp remove_dup_spaces(<< char :: binary-1, rest :: binary>>) do
    char <> remove_dup_spaces(rest)
  end

  defp signing_key(service, datetime, config) do
    ["AWS4", config[:secret_access_key]]
    |> hmac_sha256(date(datetime))
    |> hmac_sha256(config[:region])
    |> hmac_sha256(service)
    |> hmac_sha256("aws4_request")
  end

  defp string_to_sign(request, service, datetime, config) do
    request = hash_sha256(request)

    """
    AWS4-HMAC-SHA256
    #{amz_date(datetime)}
    #{scope(service, datetime, config)}
    #{request}
    """
    |> String.rstrip
  end

  defp signed_headers(headers) do
    headers
    |> Enum.map(fn({k, _}) -> String.downcase(k) end)
    |> Enum.sort(&(&1 < &2))
    |> Enum.join(";")
  end

  defp canonical_query_params(nil), do: ""
  defp canonical_query_params(params) do
    params
    |> URI.query_decoder
    |> Enum.sort(fn {k1, _}, {k2, _} -> k1 < k2 end)
    |> Enum.map_join("&", &pair/1)
  end

  defp pair({k, _}) when is_list(k) do
    raise ArgumentError, "encode_query/1 keys cannot be lists, got: #{inspect k}"
  end

  defp pair({_, v}) when is_list(v) do
    raise ArgumentError, "encode_query/1 values cannot be lists, got: #{inspect v}"
  end

  defp pair({k, v}) do
    URI.encode_www_form(Kernel.to_string(k)) <>
    "=" <> aws_encode_www_form(Kernel.to_string(v))
  end

  # is basically the same as URI.encode_www_form
  # but doesn't use %20 instead of "+"
  def aws_encode_www_form(str) when is_binary(str) do
    import Bitwise
    for <<c <- str>>, into: "" do
      case URI.char_unreserved?(c) do
        true  -> <<c>>
        false -> "%" <> hex(bsr(c, 4)) <> hex(band(c, 15))
      end
    end
  end

  defp hex(n) when n <= 9, do: <<n + ?0>>
  defp hex(n), do: <<n + ?A - 10>>

  defp canonical_headers(headers) do
    headers
    |> Enum.map(fn
      {k, v} when is_binary(v) -> {String.downcase(k), String.strip(v)}
      {k, v} -> {String.downcase(k), v}
    end)
    |> Enum.sort(fn {k1, _}, {k2, _} -> k1 < k2 end)
  end

  defp presigned_url_headers(url) do
    uri = URI.parse(url)
    [{"host", uri.host}]
  end

  defp presigned_url_query(service, datetime, config, expires, query_params) do
    Enum.reduce(query_params, "", fn({key,value}, acc) ->
      acc <> "#{to_string(key)}=#{to_string(value)}&"
    end)
    <> "X-Amz-Algorithm=AWS4-HMAC-SHA256&"
    <> "X-Amz-Credential=#{uri_encode(credentials(service, datetime, config))}&"
    <> "X-Amz-Date=#{amz_date(datetime)}&"
    <> "X-Amz-Expires=#{expires}&"
    <> "X-Amz-SignedHeaders=host"
    <> case config[:security_token] do
         nil -> ""
         token -> "&X-Amz-Security-Token=#{uri_encode(token)}"
       end
  end

  defp credentials(service, datetime, config) do
    "#{config[:access_key_id]}/#{scope(service, datetime, config)}"
  end

  defp scope(service, datetime, config) do
    "#{date(datetime)}/#{config[:region]}/#{service}/aws4_request"
  end
end
