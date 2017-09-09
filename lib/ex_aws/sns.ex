defmodule ExAws.SNS do
  import ExAws.Utils, only: [camelize_key: 1, camelize_keys: 1]

  @moduledoc """
  Operations on AWS SNS

  http://docs.aws.amazon.com/sns/latest/api/API_Operations.html
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
    param_root = "MessageAttribute.entry.#{i + 1}"
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
  @spec create_platform_application(name :: binary, platform :: binary, attributes :: %{String.t => String.t}) :: ExAws.Operation.Query.t
  def create_platform_application(name, platform, attributes) do
    attributes =
      attributes
      |> build_kv_attrs
      |> Map.merge(%{
        "Name" => name,
        "Platform" => platform,
      })
    request(:create_platform_application, attributes)
  end

  @doc "Delete platform application"
  @spec delete_platform_application(platform_application_arn :: platform_application_arn) :: ExAws.Operation.Query.t
  def delete_platform_application(platform_application_arn) do
    request(:delete_platform_application, %{
      "PlatformApplicationArn" => platform_application_arn
    })
  end

  @doc "List platform applications"
  @spec list_platform_applications() :: ExAws.Operation.Query.t
  def list_platform_applications() do
    request(:list_platform_applications, %{})
  end

  @spec list_platform_applications(next_token :: binary) :: ExAws.Operation.Query.t
  def list_platform_applications(next_token) do
    request(:list_platform_applications, %{"NextToken" => next_token})
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

  @doc "Get platform application attributes"
  @spec get_platform_application_attributes(platform_application_arn :: platform_application_arn) :: ExAws.Operation.Query.t
  def get_platform_application_attributes(platform_application_arn) do
    request(:get_platform_application_attributes, %{"PlatformApplicationArn" => platform_application_arn})
  end

  ## Subscriptions
  ######################

  @type subscription_attribute_name :: :delivery_policy | :raw_message_delivery

  @doc "Create Subscription"
  @spec subscribe(topic_arn :: binary, protocol :: binary, endpoint :: binary) :: ExAws.Operation.Query.t
  def subscribe(topic_arn, protocol, endpoint) do
    request(:subscribe, %{
      "TopicArn" => topic_arn,
      "Protocol" => protocol,
      "Endpoint" => endpoint,
    })
  end

  @doc "Confirm Subscription"
  @spec confirm_subscription(topic_arn :: binary, token :: binary, authenticate_on_unsubscribe :: boolean) :: ExAws.Operation.Query.t
  def confirm_subscription(topic_arn, token, authenticate_on_unsubscribe \\ false) do
    request(:confirm_subscription, %{
      "TopicArn" => topic_arn,
      "Token" => token,
      "AuthenticateOnUnsubscribe" => to_string(authenticate_on_unsubscribe),
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

  @type list_subscriptions_by_topic_opt :: {:next_token, binary}

  @doc "List Subscriptions by Topic"
  @spec list_subscriptions_by_topic(topic_arn :: topic_arn) :: ExAws.Operation.Query.t
  @spec list_subscriptions_by_topic(topic_arn :: topic_arn, [list_subscriptions_by_topic_opt]) :: ExAws.Operation.Query.t
  def list_subscriptions_by_topic(topic_arn, opts \\ []) do
    params = case opts do
      [next_token: next_token] ->
        %{"TopicArn" => topic_arn, "NextToken" => next_token}
      _ ->
        %{"TopicArn" => topic_arn}
    end
    request(:list_subscriptions_by_topic, params)
  end

  @doc "Unsubscribe"
  @spec unsubscribe(subscription_arn :: binary) :: ExAws.Operation.Query.t
  def unsubscribe(subscription_arn) do
    request(:unsubscribe, %{
      "SubscriptionArn" => subscription_arn
    })
  end

  @doc "Get subscription attributes"
  @spec get_subscription_attributes(subscription_arn :: binary) :: ExAws.Operation.Query.t
  def get_subscription_attributes(subscription_arn) do
    request(:get_subscription_attributes, %{
      "SubscriptionArn" => subscription_arn
    })
  end

  @doc "Set subscription attributes"
  @spec set_subscription_attributes(attribute_name :: subscription_attribute_name,
                                    attribute_value :: binary,
                                    subscription_arn :: binary) :: ExAws.Operation.Query.t
  def set_subscription_attributes(attribute_name, attribute_value, subscription_arn) do
    request(:set_subscription_attributes, %{
      "AttributeName" => attribute_name |> camelize_key,
      "AttributeValue" => attribute_value,
      "SubscriptionArn" => subscription_arn
    })
  end

  @doc "List phone numbers opted out"
  @spec list_phone_numbers_opted_out() :: ExAws.Operation.Query.t
  def list_phone_numbers_opted_out() do
    request(:list_phone_numbers_opted_out, %{})
  end

  @spec list_phone_numbers_opted_out(next_token :: binary) :: ExAws.Operation.Query.t
  def list_phone_numbers_opted_out(next_token) do
    request(:list_phone_numbers_opted_out, %{"NextToken" => next_token})
  end

  @doc "Opt in phone number"
  @spec opt_in_phone_number(phone_number :: binary) :: ExAws.Operation.Query.t
  def opt_in_phone_number(phone_number) do
    request(:opt_in_phone_number, %{"phoneNumber" => phone_number})
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

  @type list_endpoints_by_platform_application_opt :: {:next_token, binary}

  @doc "List endpooints and endpoint attributes for devices in a supported push notification service"
  @spec list_endpoints_by_platform_application(topic_arn :: topic_arn) :: ExAws.Operation.Query.t
  @spec list_endpoints_by_platform_application(topic_arn :: topic_arn, [list_endpoints_by_platform_application_opt]) :: ExAws.Operation.Query.t
  def list_endpoints_by_platform_application(platform_application_arn, opts \\ []) do
    params = case opts do
              [next_token: next_token] ->
                %{ "PlatformApplicationArn" => platform_application_arn,
                   "NextToken" => next_token }
               _ ->
                 %{ "PlatformApplicationArn" => platform_application_arn }
            end
    request(:list_endpoints_by_platform_application, params)
  end

  ## Messages
  ######################

  @notification_params ["Message", "MessageId", "Subject", "Timestamp", "TopicArn", "Type"]
  @optional_notification_params ["Subject"]
  @confirmation_params ["Message", "MessageId", "SubscribeURL", "Timestamp", "Token", "TopicArn", "Type"]
  @signature_params ["SignatureVersion", "Signature", "SigningCertURL"]
  @message_types ["SubscriptionConfirmation", "UnsubscribeConfirmation", "Notification"]

  @doc "Verify message signature"
  @spec verify_message(message_params :: %{String.t => String.t}) :: [:ok | {:error, String.t}]
  def verify_message(message_params) do
    with :ok <- validate_message_params(message_params),
         :ok <- validate_signature_version(message_params["SignatureVersion"]),
         {:ok, public_key} <- ExAws.SNS.PublicKeyCache.get(message_params["SigningCertURL"]) do
      message_params
      |> get_string_to_sign
      |> verify(message_params["Signature"], public_key)
    end
  end

  defp validate_message_params(message_params) do
    with {:ok, required_params} <- get_required_params(message_params["Type"]) do
      case required_params -- Map.keys(message_params) do
        [] -> :ok
        missing_params -> {:error, "The following parameters are missing: #{inspect missing_params}"}
      end
    end
  end

  defp get_required_params(message_type) do
    case message_type do
      "Notification" -> {:ok, (@notification_params -- @optional_notification_params) ++ @signature_params}
      "SubscriptionConfirmation" -> {:ok, @confirmation_params ++ @signature_params}
      "UnsubscribeConfirmation" -> {:ok, @confirmation_params ++ @signature_params}
      type when is_binary(type) -> {:error, "Invalid Type, expected one of #{inspect @message_types}"}
      type when is_nil(type) -> {:error, "Missing message type parameter (Type)"}
      type -> {:error, "Invalid message type's type, expected a String, got #{inspect type}"}
    end
  end

  defp validate_signature_version(version) do
    case version do
      "1" -> :ok
      val when is_binary(val) -> {:error, "Unsupported SignatureVersion, expected \"1\", got #{version}"}
      _ -> {:error, "Invalid SignatureVersion format, expected a String, got #{version}"}
    end
  end

  defp get_string_to_sign(message_params) do
    message_params
    |> Map.take(get_params_to_sign(message_params["Type"]))
    |> Enum.map(fn {key, value} -> [to_string(key), "\n", to_string(value), "\n"] end)
    |> IO.iodata_to_binary
  end

  defp get_params_to_sign(message_type) do
    case message_type do
      "Notification" -> @notification_params
      "SubscriptionConfirmation" -> @confirmation_params
      "UnsubscribeConfirmation" -> @confirmation_params
    end
  end

  defp verify(message, signature, public_key) do
    case :public_key.verify(message, :sha, Base.decode64!(signature), public_key) do
      true -> :ok
      false -> {:error, "Signature is invalid"}
    end
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

  defp build_kv_attrs(attrs) do
    attrs
    |> Enum.with_index(1)
    |> Enum.map(&build_kv_attr/1)
    |> Enum.reduce(%{}, &Map.merge(&1, &2))
  end

  defp build_kv_attr({{key, value}, index}) do
    prefix = "Attributes.entry.#{index}."
    %{}
    |> Map.put(prefix <> "key", key)
    |> Map.put(prefix <> "value", value)
  end

  defp format_param_key("*"), do: "*"
  defp format_param_key(key) do
    key
    |> Atom.to_string
    |> ExAws.Utils.camelize
  end
end
