defmodule ExAws.SQS.Impl do

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

  def delete_message(client, queue, receipt_handle) do
    request(client, queue, "DeleteMessage", %{"ReceiptHandle" => receipt_handle})
  end

  def receive_message(client, queue, opts \\ []) do
    {_attrs, opts} = opts
    |> Keyword.split([:attributes, :message_attributes])

    params = opts
    |> format_regular_opts

    request(client, queue, "ReceiveMessage", params)
  end

  defp request(%{__struct__: module} = client, queue, action, params) do
    module.request(client, queue, action, params)
  end

  defp format_regular_opts(opts) do
    opts |> Enum.into(%{}, fn {k, v} ->
      {format_param_key(k), v}
    end)
  end

  defp format_param_key(key) do
    key
    |> Atom.to_string
    |> Mix.Utils.camelize
  end

  def format_queue_attributes(:all), do: format_queue_attributes([:all])
  def format_queue_attributes(attributes) do
    attributes
    |> Enum.with_index
    |> Enum.map(&format_queue_attribute/1)
    |> Enum.reduce(%{}, &Map.merge(&1, &2))
  end

  def format_queue_attribute({attribute, index}) do
    key = "AttributeName.#{index + 1}"

    Map.put(%{}, key, format_param_key(attribute))
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
    prefix = "MessageAttribute.#{index}."
    %{}
    |> Map.put(prefix <> "Name", attr.name)
    |> Map.put(prefix <> "Value.DataType", attr.data_type)
    |> message_attr_value(prefix, attr)
  end

  defp message_attr_value(param, prefix, %{value: value, data_type: :binary}) do
    Map.put(param, prefix <> "Value.BinaryValue", value)
  end

  defp message_attr_value(param, prefix, %{value: value, data_type: :string}) do
    Map.put(param, prefix <> "Value.StringValue", value)
  end

end
