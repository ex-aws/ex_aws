defmodule ExAws.SNS do
  import ExAws.Utils, only: [camelize_key: 1, camelize_keys: 1]

  @moduledoc """
  Operations on AWS SNS

  http://docs.aws.amazon.com/sns/latest/APIReference/API_Operations.html
  """

  ## Topics
  ######################

  @type topic_name :: binary
  @type topic_arn  :: binary
  @type topic_attribute_name ::
    :policy |
    :display_name |
    :delivery_policy

  @doc "List topics"
  @spec list_topics() :: ExAws.Operation.Query.t
  @spec list_topics(opts :: [next_token: binary]) :: ExAws.Operation.Query.t
  def list_topics(opts \\ []) do
    opts = opts
    |> Map.new
    |> camelize_keys

    request("ListTopics", opts)
  end

  @doc "Create topic"
  @spec create_topic(topic_name :: topic_name) :: ExAws.Operation.Query.t
  def create_topic(topic_name) do
    request("CreateTopic", %{"Name" => topic_name})
  end

  @doc "Get topic attributes"
  @spec get_topic_attributes(topic_arn :: topic_arn) :: ExAws.Operation.Query.t
  def get_topic_attributes(topic_arn) do
    request("GetTopicAttributes", %{"TopicArn" => topic_arn})
  end

  @doc "Set topic attributes"
  @spec set_topic_attributes(attribute_name :: topic_attribute_name,
                                   attribute_value :: binary,
                                   topic_arn :: topic_arn) :: ExAws.Operation.Query.t
  def set_topic_attributes(attribute_name, attribute_value, topic_arn) do
    request("SetTopicAttributes", %{
      "AttributeName" => attribute_name |> camelize_key,
      "AttributeValue" => attribute_value,
      "TopicArn" => topic_arn
    })
  end

  @doc "Delete topic"
  @spec delete_topic(topic_arn :: topic_arn) :: ExAws.Operation.Query.t
  def delete_topic(topic_arn) do
    request("DeleteTopic", %{"TopicArn" => topic_arn})
  end

  @type message_attribute :: %{
    :name => binary,
    :data_type => :string | :number | :binary,
    :value => {:string, binary} | {:binary, binary}
  }
  @type publish_opts :: [
    {:message_attributes, [message_attribute]} |
    {:message_structure, :json} |
    {:subject, binary} |
    {:target_arn, binary} |
    {:topic_arn, binary}]

  @doc """
  Publish message to a target/topic ARN

  You must set either :target_arn or :topic_arn but not both via the options argument.

  Do NOT assume that because your message is a JSON blob that you should set
  message_structure: to :json. This has a very specific meaning, please see
  http://docs.aws.amazon.com/sns/latest/api/API_Publish.html for details.
  """
  @spec publish(message :: binary, opts :: publish_opts) :: ExAws.Operation.Query.t
  def publish(message, opts) do
    opts = opts |> Map.new

    message_attrs = opts
    |> Map.get(:message_attributes, [])
    |> build_message_attributes

    params = opts
    |> Map.drop([:message_attributes])
    |> camelize_keys
    |> Map.put("Message", message)
    |> Map.merge(message_attrs)

    request("Publish", params)
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

  defp request(action, params) do
    %ExAws.Operation.Query{
      path: "/",
      params: params |> Map.put("Action", action),
      service: :sns
    }
  end
end
