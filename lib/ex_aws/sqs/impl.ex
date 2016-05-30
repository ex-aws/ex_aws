defmodule ExAws.SQS.Impl do

  def get_queue_url(client, queue_name, opts \\ []) do
    params = opts
      |> format_regular_opts
      |> Map.put("QueueName", queue_name)
    request(client, "", "GetQueueUrl", params)
  end

  def create_queue(client, queue, attributes \\ []) do
    params =
      attributes
      |> build_attrs
      |> Map.put("QueueName", queue)

    request(client, "", "CreateQueue", params)
  end

  def delete_queue(client, queue) do
    request(client, queue, "DeleteQueue", %{})
  end

  def list_queues(client, opts \\ []) do
    request(client, "", "ListQueues", Enum.into(opts, %{}))
  end

  def get_queue_attributes(client, queue, attributes \\ :all) do
    params =
      attributes
      |> format_queue_attributes

    request(client, queue, "GetQueueAttributes", params)
  end

  def set_queue_attributes(client, queue, attributes \\ []) do
    params =
      attributes
      |> build_attrs

    request(client, queue, "SetQueueAttributes", params)
  end

  def purge_queue(client, queue) do
    request(client, queue, "PurgeQueue", %{})
  end

  def list_dead_letter_source_queues(client, queue) do
    request(client, queue, "ListDeadLetterSourceQueues", %{})
  end

  def add_permission(client, queue, label, permissions \\ %{}) do
    params =
      permissions
      |> format_permissions
      |> Map.put("Label", label)

      request(client, queue, "AddPermission", params)
  end

  def remove_permission(client, queue, label) do
    request(client, queue, "RemovePermission", %{"Label" => label})
  end

  def send_message(client, queue, message, opts \\ []) do
    {attrs, opts} = opts
    |> Keyword.pop(:message_attributes, [])

    attrs = attrs |> build_message_attrs

    params = opts
    |> format_regular_opts
    |> Map.merge(attrs)
    |> Map.put("MessageBody", message)

    request(client, queue, "SendMessage", params)
  end

  def send_message_batch(client, queue, messages) do
    params =
      messages
      |> Enum.with_index
      |> Enum.reduce(%{}, fn({message, index}, params) ->
        Map.merge(params, format_batch_message(message, index))
      end)

    request(client, queue, "SendMessageBatch", params)
  end

  def receive_message(client, queue, opts \\ []) do
    {attrs, opts} = opts
    |> Keyword.pop(:attribute_names, [])

    params =
      attrs
      |> format_queue_attributes
      |> Map.merge(format_regular_opts(opts))

    request(client, queue, "ReceiveMessage", params)
  end

  def delete_message(client, queue, receipt_handle) do
    request(client, queue, "DeleteMessage", %{"ReceiptHandle" => receipt_handle})
  end

  def delete_message_batch(client, queue, messages) do
    params =
      messages
      |> Enum.with_index
      |> Enum.reduce(%{}, fn({message, index}, params) ->
        Map.merge(params, format_batch_deletion(message, index))
      end)

    request(client, queue, "DeleteMessageBatch", params)
  end

  def change_message_visibility(client, queue, receipt_handle, visibility_timeout) do
    request(client, queue, "ChangeMessageVisibility", %{"ReceiptHandle" => receipt_handle, "VisibilityTimeout" => visibility_timeout})
  end

  def change_message_visibility_batch(client, queue, messages) do
    params =
      messages
      |> Enum.with_index
      |> Enum.reduce(%{}, fn({message, index}, params) ->
        Map.merge(params, format_batch_visibility_change(message, index))
      end)

    request(client, queue, "ChangeMessageVisibilityBatch", params)
  end

  defp request(%{__struct__: module} = client, queue, action, params) do
    module.request(client, queue, action, params)
  end

  defp format_permissions(%{} = permissions) do
    permissions
    |> expand_permissions
    |> Enum.with_index
    |> Enum.map(&format_permission/1)
    |> Enum.reduce(%{}, &Map.merge(&1, &2))
  end

  defp expand_permissions(%{} = permissions) do
    Enum.reduce(permissions, [], fn(permission, permissions) ->
      [expand_permission(permission) | permissions]
    end)
    |> List.flatten
  end

  defp expand_permission({account_id, :all}), do: {account_id, "*"}
  defp expand_permission({account_id, permissions}) do
    Enum.map(permissions, &({account_id, &1}))
  end

  defp format_permission({{account_id, permission}, index}) do
    %{}
    |> Map.put("AWSAccountId.#{index + 1}", account_id)
    |> Map.put("ActionName.#{index + 1}", format_param_key(permission))
  end

  defp format_regular_opts(opts) do
    opts |> Enum.into(%{}, fn {k, v} ->
      {format_param_key(k), v}
    end)
  end

  defp format_param_key("*"), do: "*"
  defp format_param_key(key) do
    key
    |> Atom.to_string
    |> ExAws.Utils.camelize
  end

  defp format_queue_attributes(:all), do: format_queue_attributes([:all])
  defp format_queue_attributes(attributes) do
    attributes
    |> Enum.with_index
    |> Enum.map(&format_queue_attribute/1)
    |> Enum.reduce(%{}, &Map.merge(&1, &2))
  end

  defp format_queue_attribute({attribute, index}) do
    key = "AttributeName.#{index + 1}"

    Map.put(%{}, key, format_param_key(attribute))
  end

  defp format_batch_message(message, index) do
    prefix = "SendMessageBatchRequestEntry.#{index + 1}."

    {attrs, opts} = message
    |> Keyword.pop(:message_attributes, [])

    attrs =
      attrs
      |> build_message_attrs

    opts
    |> format_regular_opts
    |> Map.merge(attrs)
    |> Enum.reduce(%{}, fn({key, value}, params) ->
         Map.put(params, prefix <> key, value)
       end)
  end

  defp format_batch_deletion(message, index) do
    prefix = "DeleteMessageBatchRequestEntry.#{index + 1}."

    message
    |> format_regular_opts
    |> Enum.reduce(%{}, fn({key, value}, params) ->
         Map.put(params, prefix <> key, value)
       end)
  end

  defp format_batch_visibility_change(message, index) do
    prefix = "ChangeMessageVisibilityBatchRequestEntry.#{index + 1}."

    message
    |> format_regular_opts
    |> Enum.reduce(%{}, fn({key, value}, params) ->
         Map.put(params, prefix <> key, value)
       end)
  end

  defp build_attrs(attrs) do
    attrs
    |> Enum.with_index
    |> Enum.map(&build_attr/1)
    |> Enum.reduce(%{}, &Map.merge(&1, &2))
  end

  defp build_attr({{name, value}, index}) do
    prefix = "Attribute.#{index + 1}."
    %{}
    |> Map.put(prefix <> "Name",  format_param_key(name))
    |> Map.put(prefix <> "Value", value)
  end

  defp build_message_attrs(%{} = attr), do: build_message_attr({attr, 0})
  defp build_message_attrs(attrs) do
    attrs
    |> Enum.with_index
    |> Enum.map(&build_message_attr/1)
    |> Enum.reduce(%{}, &Map.merge(&1, &2))
  end

  defp build_message_attr({attr, index}) do
    prefix = "MessageAttribute.#{index + 1}."
    %{}
    |> Map.put(prefix <> "Name", attr.name)
    |> Map.put(prefix <> "Value.DataType", message_data_type(attr))
    |> message_attr_value(prefix, attr)
  end

  defp message_data_type(%{data_type: data_type, custom_type: custom_type}) do
    format_param_key(data_type) <> "." <> custom_type
  end
  defp message_data_type(%{data_type: data_type}) do
    format_param_key(data_type)
  end

  defp message_attr_value(param, prefix, %{value: value, data_type: :binary}) do
    Map.put(param, prefix <> "Value.BinaryValue", value)
  end

  defp message_attr_value(param, prefix, %{value: value}) do
    Map.put(param, prefix <> "Value.StringValue", value)
  end

end
