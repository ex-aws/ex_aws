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

    def parse({:ok, %{body: xml}=resp}, :cancel_update_stack, _) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//CancelUpdateStackResponse", request_id: request_id_xpath() )
      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse({:ok, %{body: xml}=resp}, :continue_update_rollback, _) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//ContinueUpdateRollbackResponse", request_id: request_id_xpath() )
      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse({:ok, %{body: xml}=resp}, :create_stack, _) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//CreateStackResponse",
        request_id: request_id_xpath(),
        stack_id: ~x"./CreateStackResult/StackId/text()"s
      )

      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse({:ok, %{body: xml}=resp}, :delete_stack, _) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//DeleteStackResponse", request_id: request_id_xpath())
      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse({:ok, %{body: xml}=resp}, :describe_stack_resource, config) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//DescribeStackResourceResponse",
           request_id: request_id_xpath(),
           resource: [
             ~x"./DescribeStackResourceResult/StackResourceDetail",
             last_updated_timestamp: ~x"./LastUpdatedTimestamp/text()"s,
             metadata: ~x"./Metadata/text()"so |> transform_by(&(parse_metadata_json(&1, config)))
           ] ++ resource_description_fields() ++ stack_fields()
         )

        {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse({:ok, %{body: xml}=resp}, :describe_stack_resources, _) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//DescribeStackResourcesResponse",
           request_id: request_id_xpath(),
           resources: [
             ~x"./DescribeStackResourcesResult/StackResources/member"l,
             timestamp: ~x"./Timestamp/text()"s,
           ] ++ resource_description_fields() ++ stack_fields()
         )

        {:ok, Map.put(resp, :body, parsed_body)}
    end


    def parse({:ok, %{body: xml} = resp}, :get_template, _) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//GetTemplateResponse",
          template_body: ~x"./GetTemplateResult/TemplateBody/text()"s,
          request_id: request_id_xpath()
       )
     {:ok, Map.put(resp, :body, parsed_body)}
    end


    def parse({:ok, %{body: xml} = resp}, :get_template_summary, _) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//GetTemplateSummaryResponse",
        description: ~x"./GetTemplateSummaryResult/Description/text()"s,
        parameters: [
          ~x"./GetTemplateSummaryResult/Parameters/member"l,
          no_echo: ~x"./NoEcho/text()"s,
          parameter_key: ~x"./ParameterKey/text()"s,
          description: ~x"./Description/text()"s,
          parameter_type: ~x"./ParameterType/text()"s,
        ],
        metadata: ~x"./GetTemplateSummaryResult/Metadata/text()"s,
        version: ~x"./GetTemplateSummaryResult/Version/text()"s,
        request_id: request_id_xpath())

      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse({:ok, %{body: xml}=resp}, :list_stacks, _) do
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

    def parse({:ok, %{body: xml}=resp}, :list_stack_resources, _) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//ListStackResourcesResponse",
          next_token: ~x"./ListStackResourcesResult/NextToken/text()"s,
          request_id: request_id_xpath(),
          resources: [
            ~x"./ListStackResourcesResult/StackResourceSummaries/member"l,
            last_updated_timestamp: ~x"./LastUpdatedTimestamp/text()"s
           ] ++ resource_description_fields()
         )

      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse({:ok, %{body: xml}=resp}, :describe_stacks, _) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//DescribeStacksResponse",
                        stacks: [
                          ~x"./DescribeStacksResult/Stacks/member"lo,
                          name: ~x"./StackName/text()"s,
                          id: ~x"./StackId/text()"s,
                          creation_time: ~x"./CreationTime/text()"s,
                          status: ~x"./StackStatus/text()"s |> transform_by(&const_to_atom/1),
                          disable_rollback: ~x"./DisableRollback/text()"s,
                          outputs: [
                            ~x"./Outputs/member"lo,
                            key: ~x"./OutputKey/text()"s,
                            value: ~x"./OutputValue/text()"s
                          ] 
                        ],
                        request_id: request_id_xpath())

      processStack = fn stack ->
        Map.update!( stack, :outputs, &Map.new( &1, fn kv -> {kv[:key], kv[:value]} end ) )
      end
      
      #Convert the list of outputs to a map
      processed_body = Map.update!( parsed_body, :stacks, &Enum.map( &1, fn stack -> processStack.( stack ) end ) )

      {:ok, Map.put(resp, :body, processed_body)}
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
        physical_resource_id: ~x"./PhysicalResourceId/text()"s,
        resource_type: ~x"./ResourceType/text()"s
      ]
    end

    defp stack_fields do
      [
        stack_id: ~x"./StackId/text()"s,
        stack_name: ~x"./StackName/text()"s
      ]
    end

    defp request_id_xpath do
      ~x"./ResponseMetadata/RequestId/text()"s
    end

    defp const_to_atom(string) do
      _load_status_atoms()
      string |> String.downcase |> String.to_existing_atom
    end

    defp parse_metadata_json("", _), do: %{}
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
