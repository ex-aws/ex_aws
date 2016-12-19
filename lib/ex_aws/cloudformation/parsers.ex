if Code.ensure_loaded?(SweetXml) do
  defmodule ExAws.Cloudformation.Parsers do
    import SweetXml, only: [sigil_x: 2, transform_by: 2]

    def parse({:ok, %{body: xml}=resp}, :list_stack_resources) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//ListStackResourcesResponse",
        next_token: ~x"./ListPlatformApplicationsResult/NextToken/text()"s,
        request_id: request_id_xpath(),
        resources: [
          ~x"./ListStackResourcesResult/StackResourceSummaries/member"l,
          resource_status: ~x"./ResourceStatus/text()"s |> transform_by(&const_to_atom/1),
          last_updated_timestamp: ~x"./LastUpdatedTimestamp/text()"s,
          logical_resource_id: ~x"./LogicalResourceId/text()"s,
          physical_resource_id: ~x"./PhysicalResourceId/text()"s,
          resource_type: ~x"./ResourceType/text()"s
          ]
        )

      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse(val, _), do: val

    defp request_id_xpath do
      ~x"./ResponseMetadata/RequestId/text()"s
    end

    defp const_to_atom(string) do
      string |> String.downcase |> String.to_atom
    end
  end
end
