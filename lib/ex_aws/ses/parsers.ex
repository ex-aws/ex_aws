if Code.ensure_loaded?(SweetXml) do
  defmodule ExAws.SES.Parsers do
    import SweetXml, only: [sigil_x: 2]

    def parse({:ok, %{body: xml}=resp}, :verify_email_identity) do
      parsed_body = SweetXml.xpath(xml, ~x"//VerifyEmailIdentityResponse", request_id: request_id_xpath())

      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse(val, _), do: val

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

    defp request_id_xpath do
      ~x"./ResponseMetadata/RequestId/text()"s
    end
  end
else
  defmodule ExAws.SES.Parsers do
    def parse(val, _), do: val
  end
end
