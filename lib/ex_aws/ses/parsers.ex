if Code.ensure_loaded?(SweetXml) do
  defmodule ExAws.SES.Parsers do
    import SweetXml, only: [sigil_x: 2]

    @moduledoc false

    def parse({:ok, %{body: xml}=resp}, :verify_email_identity) do
      parsed_body = SweetXml.xpath(xml, ~x"//VerifyEmailIdentityResponse", request_id: request_id_xpath())

      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse({:ok, %{body: xml}=resp}, :get_identity_verification_attributes) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//GetIdentityVerificationAttributesResponse",
                        verification_attributes: [
                          ~x"./GetIdentityVerificationAttributesResult/VerificationAttributes/entry"l,
                          entry: ~x"./key/text()"s,
                          verification_status: ~x"./value/VerificationStatus/text()"s,
                          verification_token: ~x"./value/VerificationToken/text()"so
                        ],
                        request_id: request_id_xpath()
      )
      |> update_in([:verification_attributes], &verification_attributes_list_to_map/1)

      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse({:ok, %{body: xml}=resp}, :list_configuration_sets) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//ListConfigurationSetsResponse",
                        configuration_sets: [
                          ~x"./ListConfigurationSetsResult",
                            members: ~x"./ConfigurationSets/member/Name/text()"ls,
                            next_token: ~x"./NextToken/text()"so,
                          ],
                          request_id: request_id_xpath()
      )

      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse({:ok, %{body: xml}=resp}, :send_email) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//SendEmailResponse",
                        message_id: ~x"./SendEmailResult/MessageId/text()"s,
                        request_id: request_id_xpath()
      )

      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse({:ok, %{body: xml}=resp}, :delete_identity) do
      parsed_body = SweetXml.xpath(xml, ~x"//DeleteIdentityResponse", request_id: request_id_xpath())

      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse({:ok, %{body: xml}=resp}, :set_identity_notification_topic) do
      parsed_body = SweetXml.xpath(xml, ~x"//SetIdentityNotificationTopicResponse", request_id: request_id_xpath())

      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse({:ok, %{body: xml}=resp}, :set_identity_feedback_forwarding_enabled) do
      parsed_body = SweetXml.xpath(
        xml, ~x"//SetIdentityFeedbackForwardingEnabledResponse", request_id: request_id_xpath()
      )

      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse({:ok, %{body: xml}=resp}, :set_identity_headers_in_notifications_enabled) do
      parsed_body = SweetXml.xpath(
        xml, ~x"//SetIdentityHeadersInNotificationsEnabledResponse", request_id: request_id_xpath()
      )

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

    defp verification_attributes_list_to_map(attributes) do
      Enum.reduce(attributes, %{}, fn(%{entry: key} = attribute, acc) ->
        props =
          attribute
          |> Map.delete(:entry)
          |> Enum.reject(fn (kv) -> elem(kv, 1) in ["", nil] end)
          |> Enum.into(%{})

        Map.put_new(acc, key, props)
      end)
    end
  end
else
  defmodule ExAws.SES.Parsers do
    @moduledoc false

    def parse(val, _), do: val
  end
end
