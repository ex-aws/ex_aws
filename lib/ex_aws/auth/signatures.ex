defmodule ExAws.Auth.Signatures do
  @moduledoc false
  import ExAws.Auth.Utils, only: [hmac_sha256: 2, date: 1, bytes_to_hex: 1]

  def generate_signature_v4(service, config, datetime, string_to_sign) do
    service
    |> signing_key(datetime, config)
    |> hmac_sha256(string_to_sign)
    |> bytes_to_hex
  end

  defp signing_key(service, datetime, config) do
    ["AWS4", config[:secret_access_key]]
    |> hmac_sha256(date(datetime))
    |> hmac_sha256(config[:region])
    |> hmac_sha256(service)
    |> hmac_sha256("aws4_request")
  end
end
