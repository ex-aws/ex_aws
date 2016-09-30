if Code.ensure_loaded?(SweetXml) do
  defmodule ExAws.SQS.Parsers do
    import SweetXml, only: [sigil_x: 2]

    def parse({:ok, resp=%{body: xml}}, :list_queues) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//ListQueuesResponse",
                        queues: ~x"./ListQueuesResult/QueueUrl/text()"sl,
                        request_id: request_id_xpath())

      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse({:ok, resp=%{body: xml}}, :create_queue) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//CreateQueueResponse",
                        queue_url: ~x"./CreateQueueResult/QueueUrl/text()"s,
                        request_id: request_id_xpath())

      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse(rsp={:ok, _}, :change_message_visibility) do
      parse_request_id(rsp, ~x"//ChangeMessageVisibilityResponse")
    end

    def parse({:ok, resp=%{body: xml}}, :change_message_visibility_batch) do
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

    def parse({:ok, resp=%{body: xml}}, :delete_message_batch) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//DeleteMessageBatchResponse",
                        successes: ~x"./DeleteMessageBatchResult/DeleteMessageBatchResultEntry/Id/text()"sl,
                        request_id: request_id_xpath())

      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse({:ok, resp=%{body: xml}}, :get_queue_attributes) do
      parsed_body =  xml
      |> SweetXml.xpath(~x"//GetQueueAttributesResponse",
                        attributes: [
                          ~x"./GetQueueAttributesResult/Attribute"l,
                          name: ~x"./Name/text()"s,
                          value: ~x"./Value/text()"s |> SweetXml.transform_by(&try_cast_to_number/1)
                        ],
                        request_id: request_id_xpath())
      |> update_in([:attributes], &attribute_list_to_map/1)

      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse({:ok, resp=%{body: xml}}, :get_queue_url) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//GetQueueUrlResponse",
                        queue_url: ~x"./GetQueueUrlResult/QueueUrl/text()"s,
                        request_id: request_id_xpath())

      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse({:ok, resp=%{body: xml}}, :list_dead_letter_source_queues) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//ListDeadLetterSourceQueuesResponse",
                        queue_urls: ~x"./ListDeadLetterSourceQueuesResult/QueueUrl/text()"sl,
                        request_id: request_id_xpath())

      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse(msg={:ok, _resp}, :purge_queue) do
      parse_request_id(msg, ~x"//PurgeQueueResponse")
    end

    def parse({:ok, resp=%{body: xml}}, :remove_permission) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//RemovePermissionResponse",
                        request_id: request_id_xpath())

      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse({:ok, resp=%{body: xml}}, :receive_message) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//ReceiveMessageResponse",
                        request_id: request_id_xpath(),
                        message: [
                          ~x"./ReceiveMessageResult/Message"o,
                          message_id: ~x"./MessageId/text()"s,
                          receipt_handle: ~x"./ReceiptHandle/text()"s,
                          md5_of_body: ~x"./MD5OfBody/text()"s,
                          body: ~x"./Body/text()"s,

                          attributes: [
                            ~x"./Attribute"lo,
                            name: ~x"./Name/text()"s,
                            value: ~x"./Value/text()"s |> SweetXml.transform_by(&try_cast_to_number/1)
                          ]
                        ])
      fixed_attributes = case get_in(parsed_body, [:message, :attributes]) do
                           nil ->
                             parsed_body

                             v when is_list(v) ->
                             update_in(parsed_body, [:message, :attributes], &attribute_list_to_map/1)
                         end

      {:ok, Map.put(resp, :body, fixed_attributes)}
    end

    def parse({:ok, resp=%{body: xml}}, :send_message) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//SendMessageResponse",
                        request_id: request_id_xpath(),
                        message_id: ~x"./SendMessageResult/MessageId/text()"s,
                        md5_of_message_body: ~x"./SendMessageResult/MD5OfMessageBody/text()"s,
                        md5_of_message_attributes: ~x"./SendMessageResult/MD5OfMessageAttributes/text()"s,
      )

      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse({:ok, resp=%{body: xml}}, :send_message_batch) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//SendMessageBatchResponse",
                        request_id: request_id_xpath(),
                        successes: [
                          ~x"./SendMessageBatchResult/SendMessageBatchResultEntry"l,
                          id: ~x"./Id/text()"s,
                          message_id: ~x"./MessageId/text()"s,
                          md5_of_message_body: ~x"./MD5OfMessageBody/text()"s,
                          md5_of_message_attributes: ~x"./MD5OfMessageAttributes/text()"s
                        ])
      {:ok, Map.put(resp, :body, parsed_body)}

    end

    def parse(resp={:ok, _}, :set_queue_attributes) do
      parse_request_id(resp, ~x"//SetQueueAttributesResponse")
    end

    def parse({:error, {type, http_status_code, xml}}, _) do
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

    def parse_request_id({:ok, resp=%{body: xml}}, parent_xpath) do
      parsed_body = xml
      |> SweetXml.xpath(parent_xpath,
                        request_id: request_id_xpath())

      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def attribute_list_to_map(list_of_maps) do
      list_of_maps
      |> Enum.reduce(%{}, fn(%{name: name, value: val}, acc) ->
        attribute_name = name
        |> Macro.underscore
        |> String.to_atom
        Map.put(acc, attribute_name, val)
      end)
    end

    defp try_cast_to_number(string_val) do
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
    def parse(val, _), do: val
  end
end
