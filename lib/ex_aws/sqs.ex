defmodule ExAws.SQS do
  @moduledoc """
  Operations on AWS SQS
  """

  @type sqs_permission ::
    :send_message |
    :receive_message |
    :delete_message |
    :change_message_visibility |
    :get_queue_attributes
  @type sqs_acl :: %{ binary => :all | [sqs_permission, ...]}
  @type sqs_message_attribute_name ::
    :sender_id |
    :sent_timestamp |
    :approximate_receive_count |
    :approximate_first_receive_timestamp |
    :wait_time_seconds |
    :receive_message_wait_time_seconds
  @type sqs_queue_attribute_name ::
    :policy
    | :visibility_timeout
    | :maximum_message_size
    | :message_retention_period
    | :approximate_number_of_messages
    | :approximate_number_of_messages_not_visible
    | :created_timestamp
    | :last_modified_timestamp
    | :queue_arn
    | :approximate_number_of_messages_delayed
    | :delay_seconds
    | :receive_message_wait_time_seconds
    | :redrive_policy
    | :fifo_queue
    | :content_based_deduplication
  @type visibility_timeout :: 0..43200
  @type queue_attributes :: [
    {:policy, binary}
    | {:visibility_timeout, visibility_timeout}
    | {:maximum_message_size, 1024..262144}
    | {:message_retention_period, 60..1209600}
    | {:approximate_number_of_messages, binary}
    | {:approximate_number_of_messages_not_visible, binary}
    | {:created_timestamp, binary}
    | {:last_modified_timestamp, binary}
    | {:queue_arn, binary}
    | {:approximate_number_of_messages_delayed, binary}
    | {:delay_seconds, 0..900}
    | {:receive_message_wait_time_seconds, 0..20}
    | {:redrive_policy, binary}
    | {:fifo_queue, boolean}
    | {:content_based_deduplication, boolean}
  ]
  @type sqs_message_attribute :: %{
    :name => binary,
    :data_type => :string | :binary | :number,
    :custom_type => binary | none,
    :value => binary | number
  }

  @doc """
  Adds a permission with the provided label to the Queue
  for a specific action for a specific account.
  """
  @spec add_permission(queue_url :: binary, label :: binary, permissions :: sqs_acl) :: ExAws.Operation.Query.t
  def add_permission(queue, label, permissions \\ %{}) do
    params =
      permissions
      |> format_permissions
      |> Map.put("Label", label)

    request(queue, :add_permission, params)
  end

  @doc """
  Extends the read lock timeout for the specified message from
  the specified queue to the specified value
  """
  @spec change_message_visibility(queue_url :: binary, receipt_handle :: binary, visibility_timeout :: visibility_timeout) :: ExAws.Operation.Query.t
  def change_message_visibility(queue, receipt_handle, visibility_timeout) do
    request(queue, :change_message_visibility, %{"ReceiptHandle" => receipt_handle, "VisibilityTimeout" => visibility_timeout})
  end

  @doc """
  Extends the read lock timeout for a batch of 1..10 messages
  """
  @type message_visibility_batch_item :: %{
    :id => binary,
    :receipt_handle => binary,
    :visibility_timeout => visibility_timeout
  }
  @spec change_message_visibility_batch(queue_url :: binary, opts :: [message_visibility_batch_item, ...]) :: ExAws.Operation.Query.t
  def change_message_visibility_batch(queue, messages) do
    params =
      messages
      |> Enum.with_index
      |> Enum.reduce(%{}, fn({message, index}, params) ->
        Map.merge(params, format_batch_visibility_change(message, index))
      end)

    request(queue, :change_message_visibility_batch, params)
  end

  @doc "Create queue"
  @spec create_queue(queue_name :: binary) :: ExAws.Operation.Query.t
  @spec create_queue(queue_name :: binary, queue_attributes :: queue_attributes) :: ExAws.Operation.Query.t
  def create_queue(queue, attributes \\ []) do
    params =
      attributes
      |> build_attrs
      |> Map.put("QueueName", queue)

    request("", :create_queue, params)
  end

  @doc "Delete a message from a SQS Queue"
  @spec delete_message(queue_url :: binary, receipt_handle :: binary) :: ExAws.Operation.Query.t
  def delete_message(queue, receipt_handle) do
    request(queue, :delete_message, %{"ReceiptHandle" => receipt_handle})
  end

  @doc "Deletes a list of messages from a SQS Queue in a single request"
  @type delete_message_batch_item :: %{
    :id => binary,
    :receipt_handle => binary
  }
  @spec delete_message_batch(queue_url :: binary, message_receipts :: [delete_message_batch_item, ...]) :: ExAws.Operation.Query.t
  def delete_message_batch(queue, messages) do
    params =
      messages
      |> Enum.with_index
      |> Enum.reduce(%{}, fn({message, index}, params) ->
        Map.merge(params, format_batch_deletion(message, index))
      end)

    request(queue, :delete_message_batch, params)
  end

  @doc "Delete a queue"
  @spec delete_queue(queue_url :: binary) :: ExAws.Operation.Query.t
  def delete_queue(queue) do
    request(queue, :delete_queue, %{})
  end

  @doc "Gets attributes of a SQS Queue"
  @spec get_queue_attributes(queue_url :: binary) :: ExAws.Operation.Query.t
  @spec get_queue_attributes(queue_url :: binary, attribute_names :: :all | [sqs_queue_attribute_name, ...]) :: ExAws.Operation.Query.t
  def get_queue_attributes(queue, attributes \\ :all) do
    params =
    attributes
    |> format_queue_attributes

    request(queue, :get_queue_attributes, params)
  end

  @doc "Get queue URL"
  @spec get_queue_url(queue_name :: binary) :: ExAws.Operation.Query.t
  @spec get_queue_url(queue_name :: binary, opts :: [queue_owner_aws_account_id: binary]) :: ExAws.Operation.Query.t
  def get_queue_url(queue_name, opts \\ []) do
    params = opts
      |> format_regular_opts
      |> Map.put("QueueName", queue_name)
    request("", :get_queue_url, params)
  end

  @doc "Retrieves the dead letter source queues for a given SQS Queue"
  @spec list_dead_letter_source_queues(queue_url :: binary) :: ExAws.Operation.Query.t
  def list_dead_letter_source_queues(queue) do
    request(queue, :list_dead_letter_source_queues, %{})
  end

  @doc "Retrieves a list of all the SQS Queues"
  @spec list_queues() :: ExAws.Operation.Query.t
  @spec list_queues(opts :: [queue_name_prefix: binary]) :: ExAws.Operation.Query.t
  def list_queues(opts \\ []) do
    params = opts
    |> format_regular_opts

    request("", :list_queues, params)
  end

  @doc "Purge all messages in a SQS Queue"
  @spec purge_queue(queue_url :: binary) :: ExAws.Operation.Query.t
  def purge_queue(queue) do
    request(queue, :purge_queue, %{})
  end

  @type receive_message_opts :: [
    {:attribute_names, :all | [sqs_message_attribute_name, ...]} |
    {:message_attribute_names, :all | [String.Chars.t, ...]} |
    {:max_number_of_messages, 1..10} |
    {:visibility_timeout, 0..43200} |
    {:wait_time_seconds, 0..20}
  ]

  @doc "Read messages from a SQS Queue"
  @spec receive_message(queue_name :: binary) :: ExAws.Operation.Query.t
  @spec receive_message(queue_name :: binary, opts :: receive_message_opts) :: ExAws.Operation.Query.t
  def receive_message(queue, opts \\ []) do
    {attrs, opts} = opts
    |> Keyword.pop(:attribute_names, [])

    {message_attrs, opts} = opts
    |> Keyword.pop(:message_attribute_names, [])

    params = attrs
    |> format_queue_attributes
    |> Map.merge(format_message_attributes(message_attrs))
    |> Map.merge(format_regular_opts(opts))

    request(queue, :receive_message, params)
  end

  @doc "Removes permission with the given label from the Queue"
  @spec remove_permission(queue_name :: binary, label :: binary) :: ExAws.Operation.Query.t
  def remove_permission(queue, label) do
    request(queue, :remove_permission, %{"Label" => label})
  end

  @type sqs_message_opts :: [
    {:delay_seconds, 0..900} |
    {:message_attributes, sqs_message_attribute | [sqs_message_attribute, ...]} |
    {:message_deduplication_id, binary} |
    {:message_group_id, binary}
  ]

  @doc "Send a message to a SQS Queue"
  @spec send_message(queue_name :: binary, message_body :: binary) :: ExAws.Operation.Query.t
  @spec send_message(queue_name :: binary, message_body :: binary, opts :: sqs_message_opts) :: ExAws.Operation.Query.t
  def send_message(queue, message, opts \\ []) do
    {attrs, opts} = opts
    |> Keyword.pop(:message_attributes, [])

    attrs = attrs |> build_message_attrs

    params = opts
    |> format_regular_opts
    |> Map.merge(attrs)
    |> Map.put("MessageBody", message)

    request(queue, :send_message, params)
  end

  @type sqs_batch_message :: binary | [
      {:id, binary} |
      {:message_body, binary} |
      {:delay_seconds, 0..900} |
      {:message_attributes, sqs_message_attribute | [sqs_message_attribute, ...]} |
      {:message_deduplication_id, binary} |
      {:message_group_id, binary}
    ]

  @doc "Send up to 10 messages to a SQS Queue in a single request"
  @spec send_message_batch(queue_name :: binary, messages :: [sqs_batch_message, ...]) :: ExAws.Operation.Query.t
  def send_message_batch(queue, messages) do
    params =
      messages
      |> Enum.with_index
      |> Enum.reduce(%{}, fn({message, index}, params) ->
        Map.merge(params, format_batch_message(message, index))
      end)

    request(queue, :send_message_batch, params)
  end

  @doc "Set attributes of a SQS Queue"
  @spec set_queue_attributes(queue_name :: binary, attributes :: queue_attributes) :: ExAws.Operation.Query.t
  def set_queue_attributes(queue, attributes \\ []) do
    params =
      attributes
      |> build_attrs

    request(queue, :set_queue_attributes, params)
  end

  defp request(queue, action, params) do
    action_string = action |> Atom.to_string |> Macro.camelize

    %ExAws.Operation.Query{
      path: "/" <> queue,
      params: params |> Map.put("Action", action_string),
      service: :sqs,
      action: action,
      parser: &ExAws.SQS.Parsers.parse/2
    }
  end

  ## Helpers

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

  defp format_message_attribute({attribute, index}) do
    %{"MessageAttributeName.#{index + 1}" => to_string(attribute)}
  end

  defp format_message_attributes(:all) do
    %{"MessageAttributeNames" => "All"}
  end

  defp format_message_attributes(attributes) do
    attributes
    |> Enum.with_index
    |> Enum.map(&format_message_attribute/1)
    |> Enum.reduce(%{}, &Map.merge(&1, &2))
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
