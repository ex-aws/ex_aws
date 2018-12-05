if Code.ensure_loaded?(SweetXml) do
  # TODO: Extract this.
  defmodule ExAws.Operation.Query.Parser do
    defmacro __using__(_opts) do
      quote do
        import SweetXml, only: [sigil_x: 2]

        def parse({:error, {type, http_status_code, %{body: xml}}}, _) do
          parsed_body =
            xml
            |> SweetXml.xpath(
              ~x"//ErrorResponse",
              request_id: ~x"./RequestId/text()"s,
              type: ~x"./Error/Type/text()"s,
              code: ~x"./Error/Code/text()"s,
              message: ~x"./Error/Message/text()"s,
              detail: ~x"./Error/Detail/text()"s
            )

          {:error, {type, http_status_code, parsed_body}}
        end
      end
    end
  end
end
