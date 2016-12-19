if Code.ensure_loaded?(SweetXml) do
  defmodule ExAws.Cloudformation.Parsers do
    import SweetXml, only: [sigil_x: 2, transform_by: 2]

    def parse({:ok, %{body: xml}=resp}, :describe_stack_resource) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//DescribeStackResourceResponse",
        request_id: request_id_xpath(),
        resource: [
          ~x"./DescribeStackResourceResult/StackResourceDetail",
          stack_id: ~x"./StackId/text()"s,
          stack_name: ~x"./StackName/text()"s,
          metadata: ~x"./Metadata/text()"s |> transform_by(&parse_metadata_json/1),
          ] ++ resource_description_fields
        )

        {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse({:ok, %{body: xml}=resp}, :list_stack_resources) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//ListStackResourcesResponse",
        next_token: ~x"./ListPlatformApplicationsResult/NextToken/text()"s,
        request_id: request_id_xpath(),
        resources: [ ~x"./ListStackResourcesResult/StackResourceSummaries/member"l ]
                    ++ resource_description_fields
        )

      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse(val, _), do: val

    defp resource_description_fields do
      [
        resource_status: ~x"./ResourceStatus/text()"s |> transform_by(&const_to_atom/1),
        logical_resource_id: ~x"./LogicalResourceId/text()"s,
        last_updated_timestamp: ~x"./LastUpdatedTimestamp/text()"s,
        physical_resource_id: ~x"./PhysicalResourceId/text()"s,
        resource_type: ~x"./ResourceType/text()"s
      ]
    end

    defp request_id_xpath do
      ~x"./ResponseMetadata/RequestId/text()"s
    end

    defp const_to_atom(string) do
      string |> String.downcase |> String.to_existing_atom
    end

    defp parse_metadata_json(json) do
      config = ExAws.Config.new(:cloudformation)

      json
      |> String.trim
      |> config.json_codec.decode!
    end
  end
end
