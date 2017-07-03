if Code.ensure_loaded?(SweetXml) do
  defmodule ExAws.SQS.Parsers do
    use ExAws.Operation.Query.Parser

    def parse({:ok, %{body: xml}=resp}, :list_queues) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//ListQueuesResponse",
                        queues: ~x"./ListQueuesResult/QueueUrl/text()"sl,
                        request_id: request_id_xpath())

      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse({:ok, %{body: xml}=resp}, :create_queue) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//CreateQueueResponse",
                        queue_url: ~x"./CreateQueueResult/QueueUrl/text()"s,
                        request_id: request_id_xpath())

      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse(rsp={:ok, _}, :change_message_visibility) do
      parse_request_id(rsp, ~x"//ChangeMessageVisibilityResponse")
    end

    def parse({:ok, %{body: xml}=resp}, :change_message_visibility_batch) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//ChangeMessageVisibilityBatchResponse",
                        successes: ~x"./ChangeMessageVisibilityBatchResult/ChangeMessageVisibilityBatchResultEntry/Id/text()"sl,
                        request_id: request_id_xpath())

      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse(rsp={:ok, _}, :delete_message) do
      parse_request_id(rsp, ~x"//DeleteMessageResponse")
    end

    def parse(rsp={:ok, _}, :delete_queue) do
      parse_request_id(rsp, ~x"//DeleteQueueResponse")
    end

    def parse({:ok, %{body: xml}=resp}, :delete_message_batch) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//DeleteMessageBatchResponse",
                        successes: ~x"./DeleteMessageBatchResult/DeleteMessageBatchResultEntry/Id/text()"sl,
                        request_id: request_id_xpath())

      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse({:ok, %{body: xml}=resp}, :get_queue_attributes) do
      parsed_body =  xml
      |> SweetXml.xpath(~x"//GetQueueAttributesResponse",
                        attributes: [
                          ~x"./GetQueueAttributesResult/Attribute"l,
                          name: ~x"./Name/text()"s,
                          value: ~x"./Value/text()"s |> SweetXml.transform_by(&try_cast/1)
                        ],
                        request_id: request_id_xpath())
      |> update_in([:attributes], &attribute_list_to_map(&1, true))

      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse({:ok, %{body: xml}=resp}, :get_queue_url) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//GetQueueUrlResponse",
                        queue_url: ~x"./GetQueueUrlResult/QueueUrl/text()"s,
                        request_id: request_id_xpath())

      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse({:ok, %{body: xml}=resp}, :list_dead_letter_source_queues) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//ListDeadLetterSourceQueuesResponse",
                        queue_urls: ~x"./ListDeadLetterSourceQueuesResult/QueueUrl/text()"sl,
                        request_id: request_id_xpath())

      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse(msg={:ok, _resp}, :purge_queue) do
      parse_request_id(msg, ~x"//PurgeQueueResponse")
    end

    def parse({:ok, %{body: xml}=resp}, :remove_permission) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//RemovePermissionResponse",
                        request_id: request_id_xpath())

      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse({:ok, %{body: xml}=resp}, :receive_message) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//ReceiveMessageResponse",
                        request_id: request_id_xpath(),
                        messages: [
                          ~x"./ReceiveMessageResult/Message"lo,
                          message_id: ~x"./MessageId/text()"s,
                          receipt_handle: ~x"./ReceiptHandle/text()"s,
                          md5_of_body: ~x"./MD5OfBody/text()"s,
                          body: ~x"./Body/text()"s,

                          attributes: [
                            ~x"./Attribute"lo,
                            name: ~x"./Name/text()"s,
                            value: ~x"./Value/text()"s |> SweetXml.transform_by(&try_cast/1)
                          ],
                          message_attributes: [
                            ~x"./MessageAttribute"lo,
                            name: ~x"./Name/text()"s,
                            string_value: ~x"./Value/StringValue/text()"os,
                            binary_value: ~x"./Value/BinaryValue/text()"os,
                            data_type: ~x"./Value/DataType/text()"s
                          ]
                        ])

      new_messages = parsed_body
      |> Map.get(:messages, [])
      |> Enum.map(fn(message) ->
        message
        |> fix_attributes([:attributes], &attribute_list_to_map/1)
        |> fix_attributes([:message_attributes], &message_attributes_to_map/1)
      end)

      parsed_body = Map.put(parsed_body, :messages, new_messages)

      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse({:ok, %{body: xml}=resp}, :send_message) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//SendMessageResponse",
                        request_id: request_id_xpath(),
                        message_id: ~x"./SendMessageResult/MessageId/text()"s,
                        md5_of_message_body: ~x"./SendMessageResult/MD5OfMessageBody/text()"s,
                        md5_of_message_attributes: ~x"./SendMessageResult/MD5OfMessageAttributes/text()"s,
      )

      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse({:ok, %{body: xml}=resp}, :send_message_batch) do
      # https://docs.aws.amazon.com/AWSSimpleQueueService/latest/APIReference/API_SendMessageBatch.html#API_SendMessageBatch_ResponseElements
      parsed_body = xml
      |> SweetXml.xpath(~x"//SendMessageBatchResponse",
                        request_id: request_id_xpath(),
                        successes: [
                          ~x"./SendMessageBatchResult/SendMessageBatchResultEntry"l,
                          id: ~x"./Id/text()"s,
                          message_id: ~x"./MessageId/text()"s,
                          md5_of_message_body: ~x"./MD5OfMessageBody/text()"s,
                          md5_of_message_attributes: ~x"./MD5OfMessageAttributes/text()"s
                        ],
                        # https://docs.aws.amazon.com/AWSSimpleQueueService/latest/APIReference/API_BatchResultErrorEntry.html
                        failures: [
                          ~x"./SendMessageBatchResult/BatchResultErrorEntry"l,
                          code: ~x"./Code/text()"s,
                          id: ~x"./Id/text()"s,
                          message: ~x"./Message/text()"s,
                          sender_fault: ~x"./SenderFault/text()"s, # FIXME Cast to boolean
                        ])
      {:ok, Map.put(resp, :body, parsed_body)}

    end

    def parse({:ok, _}=resp, :set_queue_attributes) do
      parse_request_id(resp, ~x"//SetQueueAttributesResponse")
    end


    def parse(val, _), do: val

    def parse_request_id({:ok, %{body: xml}=resp}, parent_xpath) do
      parsed_body = xml
      |> SweetXml.xpath(parent_xpath,
                        request_id: request_id_xpath())

      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def message_attributes_to_map(list_of_message_attribtues) do
      list_of_message_attribtues
      |> Enum.reduce(%{}, fn(%{name: name, data_type: data_type} = attr, acc) ->
        case parse_attribute_value(data_type, attr) do
          ^attr ->
            Map.put(acc, name, attr)
          parsed ->
            Map.put(acc, name, Map.put(attr, :value, parsed))
        end
      end)
    end

    defp fix_attributes(parsed_body, attribute_path, fixup_fn) do
      case get_in(parsed_body, attribute_path) do
        nil ->
          parsed_body

        [] ->
          parsed_body

        v when is_list(v) ->
          update_in(parsed_body, attribute_path, fixup_fn)
      end
    end

    defp parse_attribute_value(<<"String", _ :: binary>>, %{string_value: string_value}) do
      string_value
    end

    defp parse_attribute_value(<<"Binary", _ :: binary>>, %{binary_value: b64_encoded}) do
      case Base.decode64(b64_encoded) do
        {:ok, decoded} ->
          decoded
        _ ->
          b64_encoded
      end
    end

    defp parse_attribute_value(<<"Number", _ :: binary>>, %{string_value: string_value}) do
      try do
        String.to_integer(string_value)
      rescue ArgumentError ->
          try do
            String.to_float(string_value)
          rescue ArgumentError ->
              string_value
          end
      end
    end

    defp parse_attribute_value(_data_type, other) do
      other
    end

    def attribute_list_to_map(list_of_maps, convert_to_atoms \\ false)
    def attribute_list_to_map(list_of_maps, convert_to_atoms) do
      list_of_maps
      |> Enum.reduce(%{}, fn(%{name: name, value: val}, acc) ->
        attribute_name = name
        |> Macro.underscore

        attribute_name = if convert_to_atoms do
          String.to_atom(attribute_name)
        else
          attribute_name
        end

        Map.put(acc, attribute_name, val)
      end)
    end

    defp try_cast("true"), do: true
    defp try_cast("false"), do: false
    defp try_cast(string_val) do
      try do
        String.to_integer(string_val)
      rescue ArgumentError ->
        string_val
      end
    end

    defp request_id_xpath do
      ~x"./ResponseMetadata/RequestId/text()"s
    end
  end
else
  defmodule ExAws.SQS.Parsers do
    def parse(_val, _), do: raise ExAws.Error, "Missing XML parser. Please see docs"

  end
end
