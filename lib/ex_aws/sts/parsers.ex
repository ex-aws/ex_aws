if Code.ensure_loaded?(SweetXml) do
  defmodule ExAws.STS.Parsers do
    import SweetXml, only: [sigil_x: 2]

    def parse({:ok, %{body: xml}=resp}, :get_federation_token) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//GetFederationTokenResponse",
                        access_key_id: ~x"./GetFederationTokenResult/Credentials/AccessKeyId/text()"s,
                        secret_access_key: ~x"./GetFederationTokenResult/Credentials/SecretAccessKey/text()"s,
                        session_token: ~x"./GetFederationTokenResult/Credentials/SessionToken/text()"s,
                        expiration: ~x"./GetFederationTokenResult/Credentials/Expiration/text()"s,
                        request_id: request_id_xpath())

      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse({:error, {type, http_status_code, %{body: xml}}}, _) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//ErrorResponse",
                        request_id: ~x"./RequestId/text()"s,
                        type: ~x"./Error/Type/text()"s,
                        code: ~x"./Error/Code/text()"s,
                        message: ~x"./Error/Message/text()"s,
                        detail: ~x"./Error/Detail/text()"s)

      {:error, {type, http_status_code, parsed_body}}
    end

    def parse(val, _), do: val

    defp request_id_xpath do
      ~x"./ResponseMetadata/RequestId/text()"s
    end
  end
else
  defmodule ExAws.STS.Parsers do
    def parse(val, _), do: val
  end
end
