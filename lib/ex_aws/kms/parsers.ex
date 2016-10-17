if Code.ensure_loaded?(SweetXml) do
  defmodule ExAws.KMS.Parsers do
    import SweetXml, only: [sigil_x: 2]

    def parse_list_keys({:ok, %{body: xml}=resp}, :list_keys) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//Keys"l,
      key_id: ~x"./member/KeyId/text()",
      key_arn: ~x"./member/KeyArn/text()"
      )

      {:ok, %{resp | body: parsed_body}}
    end
  end
else
  defmodule ExAws.KMS.Parsers do
    def parse_list_keys(val), do: val
  end
end
