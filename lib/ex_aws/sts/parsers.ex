if Code.ensure_loaded?(SweetXml) do
  defmodule ExAws.STS.Parsers do
    import SweetXml, only: [sigil_x: 2]

    def parse({:ok, %{body: xml}=resp}, :assume_role) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//AssumeRoleResponse",
                        access_key_id: ~x"./AssumeRoleResult/Credentials/AccessKeyId/text()"s,
                        secret_access_key: ~x"./AssumeRoleResult/Credentials/SecretAccessKey/text()"s,
                        session_token: ~x"./AssumeRoleResult/Credentials/SessionToken/text()"s,
                        expiration: ~x"./AssumeRoleResult/Credentials/Expiration/text()"s,
                        assumed_role_id: ~x"./AssumeRoleResult/AssumedRoleUser/AssumedRoleId/text()"s,
                        assumed_role_arn: ~x"./AssumeRoleResult/AssumedRoleUser/Arn/text()"s,
                        request_id: request_id_xpath())

      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse({:ok, %{body: xml} = resp}, :get_caller_identity) do
      parsed_body = SweetXml.xpath(xml, ~x"//GetCallerIdentityResponse", [
        arn: ~x"./GetCallerIdentityResult/Arn/text()"s,
        user_id: ~x"./GetCallerIdentityResult/UserId/text()"s,
        account: ~x"./GetCallerIdentityResult/Account/text()"s,
        request_id: request_id_xpath()
      ])

      {:ok, Map.put(resp, :body, parsed_body)}
    end

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

    def parse({:ok, %{body: xml}=resp}, :get_session_token) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//GetSessionTokenResponse",
                        access_key_id: ~x"./GetSessionTokenResult/Credentials/AccessKeyId/text()"s,
                        secret_access_key: ~x"./GetSessionTokenResult/Credentials/SecretAccessKey/text()"s,
                        session_token: ~x"./GetSessionTokenResult/Credentials/SessionToken/text()"s,
                        expiration: ~x"./GetSessionTokenResult/Credentials/Expiration/text()"s,
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

    def parse({:ok, %{body: xml}=resp}, :decode_authorization_message, config) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//DecodeAuthorizationMessageResponse",
                        decoded_message: ~x"./DecodeAuthorizationMessageResult/DecodedMessage/text()"s,
                        request_id: request_id_xpath())
      |> Map.update!(:decoded_message, fn msg -> config[:json_codec].decode!(msg) end)

      {:ok, Map.put(resp, :body, parsed_body)}
    end

    defp request_id_xpath do
      ~x"./ResponseMetadata/RequestId/text()"s
    end
  end
else
  defmodule ExAws.STS.Parsers do
    def parse(val, _), do: val
    def parse(val, _, _), do: val
  end
end
