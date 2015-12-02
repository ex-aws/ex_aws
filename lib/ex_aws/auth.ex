defmodule ExAws.Auth do
  import ExAws.Auth.Utils

  @moduledoc false

  def headers(http_method, url, service, config, headers, body) do
    now = :os.timestamp |> :calendar.now_to_universal_time
    headers = [
      {"host", URI.parse(url).host},
      {"x-amz-date", amz_date(now)} |
      headers
    ]
    |> handle_temp_credentials(config)

    auth_header = auth_header(
      config[:access_key_id],
      config[:secret_access_key],
      http_method |> method_string,
      url,
      config[:region],
      service |> service_name,
      headers,
      body,
      now)

    [{"Authorization", auth_header} | headers ]
  end

  def handle_temp_credentials(headers, %{security_token: token}) do
    [{"X-Amz-Security-Token", token} | headers]
  end
  def handle_temp_credentials(headers, _), do: headers

  def auth_header(access_key, secret_key, http_method, url, region, service, headers, body, {date, _} = now) do
    date  = date |> quasi_iso_format
    scope = "#{date}/#{region}/#{service}/aws4_request"

    signing_key = build_signing_key(secret_key, date, region, service)

    signature = http_method
    |> build_canonical_request(url, headers, body)
    |> build_string_to_sign(now, scope)
    |> sign_with(signing_key)

    [
      "AWS4-HMAC-SHA256 Credential=", access_key, "/", scope, ",",
      "SignedHeaders=", signed_headers(headers), ",",
      "Signature=", signature
    ] |> IO.iodata_to_binary
  end

  def build_signing_key(secret_key, date, region, service) do
    ["AWS4", secret_key]
    |> hmac_sha256(date)
    |> hmac_sha256(region)
    |> hmac_sha256(service)
    |> hmac_sha256("aws4_request")
  end

  def build_string_to_sign(canonical_request, now, scope) do
    timestamp = now |> amz_date
    hashed_canonical_request = hash_sha256(canonical_request)

    [
      "AWS4-HMAC-SHA256", "\n",
      timestamp, "\n",
      scope, "\n",
      hashed_canonical_request
    ] |> IO.iodata_to_binary
  end

  def sign_with(string_to_sign, signing_key) do
    signing_key
    |> hmac_sha256(string_to_sign)
    |> bytes_to_hex
  end

  def signed_headers(headers) do
    headers
    |> Enum.map(fn({k, _}) -> String.downcase(k) end)
    |> Enum.sort(&(&1 < &2))
    |> Enum.join(";")
  end

  def build_canonical_request(http_method, url, headers, body) do
    uri = URI.parse(url)
    http_method = http_method |> String.upcase

    query_params = uri.query |> canonical_query_params

    headers = headers |> canonical_headers
    header_string = headers
    |> Enum.map(fn {k, v} -> "#{k}:#{v}" end)
    |> Enum.join("\n")

    signed_headers_list = headers
    |> Keyword.keys
    |> Enum.join(";")

    [
      http_method, "\n",
      uri.path |> URI.encode(&valid_path_char?/1), "\n",
      query_params, "\n",
      header_string, "\n",
      "\n",
      signed_headers_list, "\n",
      ExAws.Auth.Utils.hash_sha256(body)
    ] |> IO.iodata_to_binary
  end

  def canonical_query_params(nil), do: ""
  def canonical_query_params(params) do
    params
    |> URI.query_decoder
    |> Enum.sort(fn {k1, _}, {k2, _} -> k1 < k2 end)
    |> URI.encode_query
    |> String.replace("+", "%20")
    |> String.replace("%7E", "~")
  end

  def canonical_headers(headers) do
    headers
    |> Enum.map(fn {k, v} -> {String.downcase(k), String.strip(v)} end)
    |> Enum.sort(fn {k1, _}, {k2, _} -> k1 < k2 end)
  end
end
