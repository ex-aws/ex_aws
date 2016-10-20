defmodule ExAws.SNS do
  import ExAws.Utils, only: [camelize_key: 1, camelize_keys: 1]

  @moduledoc """
  Operations on AWS SNS

  http://docs.aws.amazon.com/sns/latest/APIReference/API_Operations.html
  """

  ## Topics
  ######################

  @type topic_name   :: binary
  @type topic_arn    :: binary
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

    request(:list_topics, opts)
  end

  @doc "Create topic"
  @spec create_topic(topic_name :: topic_name) :: ExAws.Operation.Query.t
  def create_topic(topic_name) do
    request(:create_topic, %{"Name" => topic_name})
  end

  @doc "Get topic attributes"
  @spec get_topic_attributes(topic_arn :: topic_arn) :: ExAws.Operation.Query.t
  def get_topic_attributes(topic_arn) do
    request(:get_topic_attributes, %{"TopicArn" => topic_arn})
  end

  @doc "Set topic attributes"
  @spec set_topic_attributes(attribute_name :: topic_attribute_name,
                                   attribute_value :: binary,
                                   topic_arn :: topic_arn) :: ExAws.Operation.Query.t
  def set_topic_attributes(attribute_name, attribute_value, topic_arn) do
    request(:set_topic_attributes, %{
      "AttributeName" => attribute_name |> camelize_key,
      "AttributeValue" => attribute_value,
      "TopicArn" => topic_arn
    })
  end

  @doc "Delete topic"
  @spec delete_topic(topic_arn :: topic_arn) :: ExAws.Operation.Query.t
  def delete_topic(topic_arn) do
    request(:delete_topic, %{"TopicArn" => topic_arn})
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
    {:phone_number, binary} |
    {:target_arn, binary} |
    {:topic_arn, binary}]

  @doc """
  Publish message to a target/topic ARN

  You must set either :phone_number, :target_arn or :topic_arn but only one, via the options argument.

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

    request(:publish, params)
  end

  defp build_message_attributes(attrs) do
    attrs
    |> Stream.with_index
    |> Enum.reduce(%{}, &build_message_attribute/2)
  end

  def build_message_attribute({%{name: name, data_type: data_type, value: {value_type, value}}, i}, params) do
    param_root = "MessageAttribute.#{i}"
    value_type = value_type |> to_string |> String.capitalize

    params
    |> Map.put(param_root <> ".Name", name)
    |> Map.put(param_root <> ".Value.#{value_type}Value", value)
    |> Map.put(param_root <> ".Value.DataType", data_type |> to_string |> String.capitalize)
  end

  ## Platform
  ######################

  @type platform_application_arn:: binary

  @doc "Create plaform application"
  @spec create_platform_application(name :: binary, platform :: binary) :: ExAws.Operation.Query.t
  def create_platform_application(name, platform),
    do: request(:create_platform_application, %{"Name" => name, "Platform" => platform})

  @doc "Delete platform application"
  @spec delete_platform_application(platform_application_arn :: platform_application_arn) :: ExAws.Operation.Query.t
  def delete_platform_application(platform_application_arn) do
    request(:delete_platform_application, %{
      "PlatformApplicationArn" => platform_application_arn
    })
  end

  @doc "Create platform endpoint"
  @spec create_platform_endpoint(platform_application_arn :: platform_application_arn,
                                   token :: binary) :: ExAws.Operation.Query.t
  @spec create_platform_endpoint(platform_application_arn :: platform_application_arn,
                                   token :: binary,
                                   custom_user_data :: binary) :: ExAws.Operation.Query.t
  def create_platform_endpoint(platform_application_arn, token, custom_user_data \\ nil) do
    request(:create_platform_endpoint, %{
      "PlatformApplicationArn" => platform_application_arn,
      "Token" => token,
      "CustomUserData" => custom_user_data
    })
  end

  ## Subscriptions
  ######################

  @doc "Create Subscription"
  @spec subscribe(topic_arn :: binary, protocol :: binary, endpoint :: binary) :: ExAws.Operation.Query.t
  def subscribe(topic_arn, protocol, endpoint) do
    request(:subscribe, %{
      "TopicArn" => topic_arn,
      "Protocol" => protocol,
      "Endpoint" => endpoint,
    })
  end

  @doc "List Subscriptions"
  @spec list_subscriptions() :: ExAws.Operation.Query.t
  def list_subscriptions() do
    request(:list_subscriptions, %{})
  end

  @spec list_subscriptions(next_token :: binary) :: ExAws.Operation.Query.t
  def list_subscriptions(next_token) do
    request(:list_subscriptions, %{"NextToken" => next_token})
  end

  ## Endpoints
  ######################

  @type endpoint_arn :: binary

  @type endpoint_attributes :: [
    {:token, binary}
    | {:enabled, boolean}
    | {:custom_user_data, binary}
  ]

  @doc "Get endpoint attributes"
  @spec get_endpoint_attributes(endpoint_arn :: endpoint_arn) :: ExAws.Operation.Query.t
  def get_endpoint_attributes(endpoint_arn) do
    request(:get_endpoint_attributes, %{"EndpointArn" => endpoint_arn})
  end

  @doc "Set endpoint attributes"
  @spec set_endpoint_attributes(endpoint_arn :: endpoint_arn, attributes :: endpoint_attributes) :: ExAws.Operation.Query.t
  def set_endpoint_attributes(endpoint_arn, attributes) do
    params =
      attributes
      |> build_attrs

    request(:set_endpoint_attributes, Map.put(params, "EndpointArn", endpoint_arn))
  end

  @doc "Delete endpoint"
  @spec delete_endpoint(endpoint_arn :: endpoint_arn) :: ExAws.Operation.Query.t
  def delete_endpoint(endpoint_arn) do
    request(:delete_endpoint, %{
      "EndpointArn" => endpoint_arn
    })
  end

  ## Request
  ######################

  defp request(action, params) do
    action_string = action |> Atom.to_string |> Macro.camelize

    %ExAws.Operation.Query{
      path: "/",
      params: params |> Map.put("Action", action_string),
      service: :sns,
      action: action,
      parser: &ExAws.SNS.Parsers.parse/2
    }
  end

  defp build_attrs(attrs) do
    attrs
    |> Enum.with_index(1)
    |> Enum.map(&build_attr/1)
    |> Enum.reduce(%{}, &Map.merge(&1, &2))
  end

  defp build_attr({{name, value}, index}) do
    prefix = "Attributes.entry.#{index}."
    %{}
    |> Map.put(prefix <> "name",  format_param_key(name))
    |> Map.put(prefix <> "value", value)
  end

  defp format_param_key("*"), do: "*"
  defp format_param_key(key) do
    key
    |> Atom.to_string
    |> ExAws.Utils.camelize
  end
end
