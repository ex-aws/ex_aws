if Code.ensure_loaded?(SweetXml) do
  defmodule ExAws.Cloudformation.Parsers do
    import SweetXml, only: [sigil_x: 2, transform_by: 2]

    @type resource_status ::
      :create_in_progress | :create_failed | :create_complete |
      :delete_in_progress | :delete_failed | :delete_complete | :delete_skipped |
      :update_in_progress | :update_failed | :update_complete

    @type stack_status ::
      resource_status |
      :rollback_in_progress     | :rollback_failed    | :rollback_complete |
      :update_rollback_failed   | :update_rollback_in_progress |
      :update_rollback_complete | :review_in_progress |
      :update_complete_cleanup_in_progress            |
      :update_rollback_complete_cleanup_in_progress

    def parse({:ok, %{body: xml}=resp}, :describe_stack_resource, config) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//DescribeStackResourceResponse",
        request_id: request_id_xpath(),
        resource: [
          ~x"./DescribeStackResourceResult/StackResourceDetail",
          stack_id: ~x"./StackId/text()"s,
          stack_name: ~x"./StackName/text()"s,
          metadata: ~x"./Metadata/text()"s |> transform_by(&(parse_metadata_json(&1, config))),
          ] ++ resource_description_fields
        )

        {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse({:ok, %{body: xml}=resp}, :list_stacks, _config) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//ListStacksResponse",
        next_token: ~x"./ListStacksResult/NextToken/text()"s,
        request_id: request_id_xpath(),
        stacks: [
          ~x"./ListStacksResult/StackSummaries/member"l,
          id: ~x"./StackId/text()"s,
          name: ~x"./StackName/text()"s,
          status: ~x"./StackStatus/text()"s |> transform_by(&const_to_atom/1),
          creation_time: ~x"./CreationTime/text()"s,
          template_description: ~x"./TemplateDescription/text()"so,
          resource_types: ~x"./ResourceTypes/member/text()"slo
        ]
      )

      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse({:ok, %{body: xml}=resp}, :list_stack_resources, _config) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//ListStackResourcesResponse",
        next_token: ~x"./ListStackResourcesResult/NextToken/text()"s,
        request_id: request_id_xpath(),
        resources: [ ~x"./ListStackResourcesResult/StackResourceSummaries/member"l ]
                    ++ resource_description_fields
        )

      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse({:error, {type, http_status_code, %{body: xml}}}, _, _) do
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
      _load_status_atoms
      string |> String.downcase |> String.to_existing_atom
    end

    defp parse_metadata_json(json, config) do
      json
      |> String.trim
      |> config.json_codec.decode!
    end

    defp _load_status_atoms do
      ~w(
        create_in_progress create_failed create_complete delete_in_progress delete_failed
        delete_complete delete_skipped update_in_progress update_failed update_complete
         rollback_in_progress rollback_failed rollback_complete update_rollback_failed
         update_rollback_in_progress update_rollback_complete review_in_progress
         update_complete_cleanup_in_progress update_rollback_complete_cleanup_in_progress
       )a
    end
  end
end
