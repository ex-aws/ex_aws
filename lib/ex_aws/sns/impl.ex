defmodule ExAws.SNS.Impl do
  import ExAws.Utils, only: [camelize_key: 1]
  use ExAws.Actions

  @namespace "SNS_20100331"

  @actions [
    list_topics:          :post,
    create_topic:         :post,
    get_topic_attributes: :post,
    set_topic_attributes: :post,
    delete_topic:         :post]

  @moduledoc false
  # Implementation of the AWS SNS API.
  #
  # See ExAws.SNS.Client for usage.

  ## Topics
  ######################

  def list_topics(client) do
    request(client, :list_topics, %{})
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

  ## Request
  ######################

  defp request(%{__struct__: client_module} = client, action, data) do
    client_module.request(client, action, data)
  end

end
