defmodule ExAws.SNS.Impl do
  import ExAws.Utils, only: [camelize_key: 1, camelize_keys: 1]

  @moduledoc false
  # Implementation of the AWS SNS API.
  #
  # See ExAws.SNS.Client for usage.

  ## Topics
  ######################

  def list_topics(client, opts \\ []) do
    opts = opts
    |> Enum.into(%{})
    |> camelize_keys

    request(client, :list_topics, opts)
  end

  def create_topic(client, topic_name) do
    request(client, :create_topic, %{"Name" => topic_name})
  end

  def get_topic_attributes(client, topic_arn) do
    request(client, :get_topic_attributes, %{"TopicArn" => topic_arn})
  end

  def set_topic_attributes(client, attribute_name, attribute_value, topic_arn) do
    request(client, :set_topic_attributes, %{
      "AttributeName" => attribute_name |> camelize_key,
      "AttributeValue" => attribute_value,
      "TopicArn" => topic_arn
    })
  end

  def delete_topic(client, topic_arn) do
    request(client, :delete_topic, %{"TopicArn" => topic_arn})
  end

  def publish(client, message, opts) do
    opts = opts |> Enum.into(%{})

    message_attrs = opts
    |> Map.get(:message_attributes, [])
    |> build_message_attributes

    params = opts
    |> Map.drop([:message_attributes])
    |> camelize_keys
    |> Map.put("Message", message)
    |> Map.merge(message_attrs)

    request(client, :publish, params)
  end

  defp build_message_attributes(attrs) do
    attrs
    |> Stream.with_index
    |> Enum.reduce(%{}, &build_message_attribute/2)
  end

  def build_message_attribute({%{name: name, data_type: data_type, value: {value_type, value}}, i}, params) do
    param_root = "MessageAttribute.#{i}"
    value_type = value_type |> String.capitalize

    params
    |> Map.put(param_root <> ".Name", name)
    |> Map.put(param_root <> ".Value.#{value_type}Value", value)
    |> Map.put(param_root <> ".Value.DataType", data_type)
  end

  ## Request
  ######################

  defp request(%{__struct__: client_module} = client, action, params) do
    client_module.request(client, action, params)
  end

end
