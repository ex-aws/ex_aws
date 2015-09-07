defmodule ExAws.SNS.Core do
  @actions [
    "AddPermission",
    "ConfirmSubscription",
    "CreatePlatformApplication",
    "CreatePlatformEndpoint",
    "CreateTopic",
    "DeleteEndpoint",
    "DeletePlatformApplication",
    "DeleteTopic",
    "GetEndpointAttributes",
    "GetPlatformApplicationAttributes",
    "GetSubscriptionAttributes",
    "GetTopicAttributes",
    "ListEndpointsByPlatformApplication",
    "ListPlatformApplications",
    "ListSubscriptions",
    "ListSubscriptionsByTopic",
    "ListTopics",
    "Publish",
    "RemovePermission",
    "SetEndpointAttributes",
    "SetPlatformApplicationAttributes",
    "SetSubscriptionAttributes",
    "SetTopicAttributes",
    "Subscribe",
    "Unsubscribe"]

  @moduledoc """
  ## Amazon Simple Notification Service

  Amazon Simple Notification Service

  Amazon Simple Notification Service (Amazon SNS) is a web service that
  enables you to build distributed web-enabled applications. Applications can
  use Amazon SNS to easily push real-time notification messages to interested
  subscribers over multiple delivery protocols. For more information about
  this product see [http://aws.amazon.com/sns](http://aws.amazon.com/sns/).
  For detailed information about Amazon SNS features and their associated API
  calls, see the [Amazon SNS Developer
  Guide](http://docs.aws.amazon.com/sns/latest/dg/).

  We also provide SDKs that enable you to access Amazon SNS from your
  preferred programming language. The SDKs contain functionality that
  automatically takes care of tasks such as: cryptographically signing your
  service requests, retrying requests, and handling error responses. For a
  list of available SDKs, go to [Tools for Amazon Web
  Services](http://aws.amazon.com/tools/).
  """

  @type actions_list :: [action]

  @type add_permission_input :: [
    aws_account_id: delegates_list,
    action_name: actions_list,
    label: label,
    topic_arn: topic_arn,
  ]

  @type authorization_error_exception :: [
    message: binary,
  ]

  @type confirm_subscription_input :: [
    authenticate_on_unsubscribe: authenticate_on_unsubscribe,
    token: token,
    topic_arn: topic_arn,
  ]

  @type confirm_subscription_response :: [
    subscription_arn: subscription_arn,
  ]

  @type create_endpoint_response :: [
    endpoint_arn: binary,
  ]

  @type create_platform_application_input :: [
    attributes: map_string_to_string,
    name: binary,
    platform: binary,
  ]

  @type create_platform_application_response :: [
    platform_application_arn: binary,
  ]

  @type create_platform_endpoint_input :: [
    attributes: map_string_to_string,
    custom_user_data: binary,
    platform_application_arn: binary,
    token: binary,
  ]

  @type create_topic_input :: [
    name: topic_name,
  ]

  @type create_topic_response :: [
    topic_arn: topic_arn,
  ]

  @type delegates_list :: [delegate]

  @type delete_endpoint_input :: [
    endpoint_arn: binary,
  ]

  @type delete_platform_application_input :: [
    platform_application_arn: binary,
  ]

  @type delete_topic_input :: [
    topic_arn: topic_arn,
  ]

  @type endpoint :: [
    attributes: map_string_to_string,
    endpoint_arn: binary,
  ]

  @type endpoint_disabled_exception :: [
    message: binary,
  ]

  @type get_endpoint_attributes_input :: [
    endpoint_arn: binary,
  ]

  @type get_endpoint_attributes_response :: [
    attributes: map_string_to_string,
  ]

  @type get_platform_application_attributes_input :: [
    platform_application_arn: binary,
  ]

  @type get_platform_application_attributes_response :: [
    attributes: map_string_to_string,
  ]

  @type get_subscription_attributes_input :: [
    subscription_arn: subscription_arn,
  ]

  @type get_subscription_attributes_response :: [
    attributes: subscription_attributes_map,
  ]

  @type get_topic_attributes_input :: [
    topic_arn: topic_arn,
  ]

  @type get_topic_attributes_response :: [
    attributes: topic_attributes_map,
  ]

  @type internal_error_exception :: [
    message: binary,
  ]

  @type invalid_parameter_exception :: [
    message: binary,
  ]

  @type invalid_parameter_value_exception :: [
    message: binary,
  ]

  @type list_endpoints_by_platform_application_input :: [
    next_token: binary,
    platform_application_arn: binary,
  ]

  @type list_endpoints_by_platform_application_response :: [
    endpoints: list_of_endpoints,
    next_token: binary,
  ]

  @type list_of_endpoints :: [endpoint]

  @type list_of_platform_applications :: [platform_application]

  @type list_platform_applications_input :: [
    next_token: binary,
  ]

  @type list_platform_applications_response :: [
    next_token: binary,
    platform_applications: list_of_platform_applications,
  ]

  @type list_subscriptions_by_topic_input :: [
    next_token: next_token,
    topic_arn: topic_arn,
  ]

  @type list_subscriptions_by_topic_response :: [
    next_token: next_token,
    subscriptions: subscriptions_list,
  ]

  @type list_subscriptions_input :: [
    next_token: next_token,
  ]

  @type list_subscriptions_response :: [
    next_token: next_token,
    subscriptions: subscriptions_list,
  ]

  @type list_topics_input :: [
    next_token: next_token,
  ]

  @type list_topics_response :: [
    next_token: next_token,
    topics: topics_list,
  ]

  @type map_string_to_string :: [{binary, binary}]

  @type message_attribute_map :: [{binary, message_attribute_value}]

  @type message_attribute_value :: [
    binary_value: binary,
    data_type: binary,
    string_value: binary,
  ]

  @type not_found_exception :: [
    message: binary,
  ]

  @type platform_application :: [
    attributes: map_string_to_string,
    platform_application_arn: binary,
  ]

  @type platform_application_disabled_exception :: [
    message: binary,
  ]

  @type publish_input :: [
    message: message,
    message_attributes: message_attribute_map,
    message_structure: message_structure,
    subject: subject,
    target_arn: binary,
    topic_arn: topic_arn,
  ]

  @type publish_response :: [
    message_id: message_id,
  ]

  @type remove_permission_input :: [
    label: label,
    topic_arn: topic_arn,
  ]

  @type set_endpoint_attributes_input :: [
    attributes: map_string_to_string,
    endpoint_arn: binary,
  ]

  @type set_platform_application_attributes_input :: [
    attributes: map_string_to_string,
    platform_application_arn: binary,
  ]

  @type set_subscription_attributes_input :: [
    attribute_name: attribute_name,
    attribute_value: attribute_value,
    subscription_arn: subscription_arn,
  ]

  @type set_topic_attributes_input :: [
    attribute_name: attribute_name,
    attribute_value: attribute_value,
    topic_arn: topic_arn,
  ]

  @type subscribe_input :: [
    endpoint: endpoint_name,
    protocol: protocol,
    topic_arn: topic_arn,
  ]

  @type subscribe_response :: [
    subscription_arn: subscription_arn,
  ]

  @type subscription :: [
    endpoint: endpoint_name,
    owner: account,
    protocol: protocol,
    subscription_arn: subscription_arn,
    topic_arn: topic_arn,
  ]

  @type subscription_attributes_map :: [{attribute_name, attribute_value}]

  @type subscription_limit_exceeded_exception :: [
    message: binary,
  ]

  @type subscriptions_list :: [subscription]

  @type topic :: [
    topic_arn: topic_arn,
  ]

  @type topic_attributes_map :: [{attribute_name, attribute_value}]

  @type topic_limit_exceeded_exception :: [
    message: binary,
  ]

  @type topics_list :: [topic]

  @type unsubscribe_input :: [
    subscription_arn: subscription_arn,
  ]

  @type account :: binary

  @type action :: binary

  @type attribute_name :: binary

  @type attribute_value :: binary

  @type authenticate_on_unsubscribe :: binary

  @type delegate :: binary

  @type endpoint_name :: binary

  @type label :: binary

  @type message :: binary

  @type message_id :: binary

  @type message_structure :: binary

  @type next_token :: binary

  @type protocol :: binary

  @type subject :: binary

  @type subscription_arn :: binary

  @type token :: binary

  @type topic_arn :: binary

  @type topic_name :: binary




  @doc """
  AddPermission

  Adds a statement to a topic's access control policy, granting access for
  the specified AWS accounts to the specified actions.
  """

  @spec add_permission(client :: ExAws.SNS.t, input :: add_permission_input) :: ExAws.Request.Query.response_t
  def add_permission(client, input) do
    request(client, "/", "AddPermission", input)
  end

  @doc """
  Same as `add_permission/2` but raise on error.
  """
  @spec add_permission!(client :: ExAws.SNS.t, input :: add_permission_input) :: ExAws.Request.Query.success_t | no_return
  def add_permission!(client, input) do
    case add_permission(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ConfirmSubscription

  Verifies an endpoint owner's intent to receive messages by validating the
  token sent to the endpoint by an earlier `Subscribe` action. If the token
  is valid, the action creates a new subscription and returns its Amazon
  Resource Name (ARN). This call requires an AWS signature only when the
  `AuthenticateOnUnsubscribe` flag is set to "true".
  """

  @spec confirm_subscription(client :: ExAws.SNS.t, input :: confirm_subscription_input) :: ExAws.Request.Query.response_t
  def confirm_subscription(client, input) do
    request(client, "/", "ConfirmSubscription", input)
  end

  @doc """
  Same as `confirm_subscription/2` but raise on error.
  """
  @spec confirm_subscription!(client :: ExAws.SNS.t, input :: confirm_subscription_input) :: ExAws.Request.Query.success_t | no_return
  def confirm_subscription!(client, input) do
    case confirm_subscription(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreatePlatformApplication

  Creates a platform application object for one of the supported push
  notification services, such as APNS and GCM, to which devices and mobile
  apps may register. You must specify PlatformPrincipal and
  PlatformCredential attributes when using the `CreatePlatformApplication`
  action. The PlatformPrincipal is received from the notification service.
  For APNS/APNS_SANDBOX, PlatformPrincipal is "SSL certificate". For GCM,
  PlatformPrincipal is not applicable. For ADM, PlatformPrincipal is "client
  id". The PlatformCredential is also received from the notification service.
  For APNS/APNS_SANDBOX, PlatformCredential is "private key". For GCM,
  PlatformCredential is "API key". For ADM, PlatformCredential is "client
  secret". The PlatformApplicationArn that is returned when using
  `CreatePlatformApplication` is then used as an attribute for the
  `CreatePlatformEndpoint` action. For more information, see [Using Amazon
  SNS Mobile Push
  Notifications](http://docs.aws.amazon.com/sns/latest/dg/SNSMobilePush.html).
  """

  @spec create_platform_application(client :: ExAws.SNS.t, input :: create_platform_application_input) :: ExAws.Request.Query.response_t
  def create_platform_application(client, input) do
    request(client, "/", "CreatePlatformApplication", input)
  end

  @doc """
  Same as `create_platform_application/2` but raise on error.
  """
  @spec create_platform_application!(client :: ExAws.SNS.t, input :: create_platform_application_input) :: ExAws.Request.Query.success_t | no_return
  def create_platform_application!(client, input) do
    case create_platform_application(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreatePlatformEndpoint

  Creates an endpoint for a device and mobile app on one of the supported
  push notification services, such as GCM and APNS. `CreatePlatformEndpoint`
  requires the PlatformApplicationArn that is returned from
  `CreatePlatformApplication`. The EndpointArn that is returned when using
  `CreatePlatformEndpoint` can then be used by the `Publish` action to send a
  message to a mobile app or by the `Subscribe` action for subscription to a
  topic. The `CreatePlatformEndpoint` action is idempotent, so if the
  requester already owns an endpoint with the same device token and
  attributes, that endpoint's ARN is returned without creating a new
  endpoint. For more information, see [Using Amazon SNS Mobile Push
  Notifications](http://docs.aws.amazon.com/sns/latest/dg/SNSMobilePush.html).

  When using `CreatePlatformEndpoint` with Baidu, two attributes must be
  provided: ChannelId and UserId. The token field must also contain the
  ChannelId. For more information, see [Creating an Amazon SNS Endpoint for
  Baidu](http://docs.aws.amazon.com/sns/latest/dg/SNSMobilePushBaiduEndpoint.html).
  """

  @spec create_platform_endpoint(client :: ExAws.SNS.t, input :: create_platform_endpoint_input) :: ExAws.Request.Query.response_t
  def create_platform_endpoint(client, input) do
    request(client, "/", "CreatePlatformEndpoint", input)
  end

  @doc """
  Same as `create_platform_endpoint/2` but raise on error.
  """
  @spec create_platform_endpoint!(client :: ExAws.SNS.t, input :: create_platform_endpoint_input) :: ExAws.Request.Query.success_t | no_return
  def create_platform_endpoint!(client, input) do
    case create_platform_endpoint(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateTopic

  Creates a topic to which notifications can be published. Users can create
  at most 3000 topics. For more information, see
  [http://aws.amazon.com/sns](http://aws.amazon.com/sns/). This action is
  idempotent, so if the requester already owns a topic with the specified
  name, that topic's ARN is returned without creating a new topic.
  """

  @spec create_topic(client :: ExAws.SNS.t, input :: create_topic_input) :: ExAws.Request.Query.response_t
  def create_topic(client, input) do
    request(client, "/", "CreateTopic", input)
  end

  @doc """
  Same as `create_topic/2` but raise on error.
  """
  @spec create_topic!(client :: ExAws.SNS.t, input :: create_topic_input) :: ExAws.Request.Query.success_t | no_return
  def create_topic!(client, input) do
    case create_topic(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteEndpoint

  Deletes the endpoint from Amazon SNS. This action is idempotent. For more
  information, see [Using Amazon SNS Mobile Push
  Notifications](http://docs.aws.amazon.com/sns/latest/dg/SNSMobilePush.html).
  """

  @spec delete_endpoint(client :: ExAws.SNS.t, input :: delete_endpoint_input) :: ExAws.Request.Query.response_t
  def delete_endpoint(client, input) do
    request(client, "/", "DeleteEndpoint", input)
  end

  @doc """
  Same as `delete_endpoint/2` but raise on error.
  """
  @spec delete_endpoint!(client :: ExAws.SNS.t, input :: delete_endpoint_input) :: ExAws.Request.Query.success_t | no_return
  def delete_endpoint!(client, input) do
    case delete_endpoint(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeletePlatformApplication

  Deletes a platform application object for one of the supported push
  notification services, such as APNS and GCM. For more information, see
  [Using Amazon SNS Mobile Push
  Notifications](http://docs.aws.amazon.com/sns/latest/dg/SNSMobilePush.html).
  """

  @spec delete_platform_application(client :: ExAws.SNS.t, input :: delete_platform_application_input) :: ExAws.Request.Query.response_t
  def delete_platform_application(client, input) do
    request(client, "/", "DeletePlatformApplication", input)
  end

  @doc """
  Same as `delete_platform_application/2` but raise on error.
  """
  @spec delete_platform_application!(client :: ExAws.SNS.t, input :: delete_platform_application_input) :: ExAws.Request.Query.success_t | no_return
  def delete_platform_application!(client, input) do
    case delete_platform_application(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteTopic

  Deletes a topic and all its subscriptions. Deleting a topic might prevent
  some messages previously sent to the topic from being delivered to
  subscribers. This action is idempotent, so deleting a topic that does not
  exist does not result in an error.
  """

  @spec delete_topic(client :: ExAws.SNS.t, input :: delete_topic_input) :: ExAws.Request.Query.response_t
  def delete_topic(client, input) do
    request(client, "/", "DeleteTopic", input)
  end

  @doc """
  Same as `delete_topic/2` but raise on error.
  """
  @spec delete_topic!(client :: ExAws.SNS.t, input :: delete_topic_input) :: ExAws.Request.Query.success_t | no_return
  def delete_topic!(client, input) do
    case delete_topic(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetEndpointAttributes

  Retrieves the endpoint attributes for a device on one of the supported push
  notification services, such as GCM and APNS. For more information, see
  [Using Amazon SNS Mobile Push
  Notifications](http://docs.aws.amazon.com/sns/latest/dg/SNSMobilePush.html).
  """

  @spec get_endpoint_attributes(client :: ExAws.SNS.t, input :: get_endpoint_attributes_input) :: ExAws.Request.Query.response_t
  def get_endpoint_attributes(client, input) do
    request(client, "/", "GetEndpointAttributes", input)
  end

  @doc """
  Same as `get_endpoint_attributes/2` but raise on error.
  """
  @spec get_endpoint_attributes!(client :: ExAws.SNS.t, input :: get_endpoint_attributes_input) :: ExAws.Request.Query.success_t | no_return
  def get_endpoint_attributes!(client, input) do
    case get_endpoint_attributes(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetPlatformApplicationAttributes

  Retrieves the attributes of the platform application object for the
  supported push notification services, such as APNS and GCM. For more
  information, see [Using Amazon SNS Mobile Push
  Notifications](http://docs.aws.amazon.com/sns/latest/dg/SNSMobilePush.html).
  """

  @spec get_platform_application_attributes(client :: ExAws.SNS.t, input :: get_platform_application_attributes_input) :: ExAws.Request.Query.response_t
  def get_platform_application_attributes(client, input) do
    request(client, "/", "GetPlatformApplicationAttributes", input)
  end

  @doc """
  Same as `get_platform_application_attributes/2` but raise on error.
  """
  @spec get_platform_application_attributes!(client :: ExAws.SNS.t, input :: get_platform_application_attributes_input) :: ExAws.Request.Query.success_t | no_return
  def get_platform_application_attributes!(client, input) do
    case get_platform_application_attributes(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetSubscriptionAttributes

  Returns all of the properties of a subscription.
  """

  @spec get_subscription_attributes(client :: ExAws.SNS.t, input :: get_subscription_attributes_input) :: ExAws.Request.Query.response_t
  def get_subscription_attributes(client, input) do
    request(client, "/", "GetSubscriptionAttributes", input)
  end

  @doc """
  Same as `get_subscription_attributes/2` but raise on error.
  """
  @spec get_subscription_attributes!(client :: ExAws.SNS.t, input :: get_subscription_attributes_input) :: ExAws.Request.Query.success_t | no_return
  def get_subscription_attributes!(client, input) do
    case get_subscription_attributes(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetTopicAttributes

  Returns all of the properties of a topic. Topic properties returned might
  differ based on the authorization of the user.
  """

  @spec get_topic_attributes(client :: ExAws.SNS.t, input :: get_topic_attributes_input) :: ExAws.Request.Query.response_t
  def get_topic_attributes(client, input) do
    request(client, "/", "GetTopicAttributes", input)
  end

  @doc """
  Same as `get_topic_attributes/2` but raise on error.
  """
  @spec get_topic_attributes!(client :: ExAws.SNS.t, input :: get_topic_attributes_input) :: ExAws.Request.Query.success_t | no_return
  def get_topic_attributes!(client, input) do
    case get_topic_attributes(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListEndpointsByPlatformApplication

  Lists the endpoints and endpoint attributes for devices in a supported push
  notification service, such as GCM and APNS. The results for
  `ListEndpointsByPlatformApplication` are paginated and return a limited
  list of endpoints, up to 100. If additional records are available after the
  first page results, then a NextToken string will be returned. To receive
  the next page, you call `ListEndpointsByPlatformApplication` again using
  the NextToken string received from the previous call. When there are no
  more records to return, NextToken will be null. For more information, see
  [Using Amazon SNS Mobile Push
  Notifications](http://docs.aws.amazon.com/sns/latest/dg/SNSMobilePush.html).
  """

  @spec list_endpoints_by_platform_application(client :: ExAws.SNS.t, input :: list_endpoints_by_platform_application_input) :: ExAws.Request.Query.response_t
  def list_endpoints_by_platform_application(client, input) do
    request(client, "/", "ListEndpointsByPlatformApplication", input)
  end

  @doc """
  Same as `list_endpoints_by_platform_application/2` but raise on error.
  """
  @spec list_endpoints_by_platform_application!(client :: ExAws.SNS.t, input :: list_endpoints_by_platform_application_input) :: ExAws.Request.Query.success_t | no_return
  def list_endpoints_by_platform_application!(client, input) do
    case list_endpoints_by_platform_application(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListPlatformApplications

  Lists the platform application objects for the supported push notification
  services, such as APNS and GCM. The results for `ListPlatformApplications`
  are paginated and return a limited list of applications, up to 100. If
  additional records are available after the first page results, then a
  NextToken string will be returned. To receive the next page, you call
  `ListPlatformApplications` using the NextToken string received from the
  previous call. When there are no more records to return, NextToken will be
  null. For more information, see [Using Amazon SNS Mobile Push
  Notifications](http://docs.aws.amazon.com/sns/latest/dg/SNSMobilePush.html).
  """

  @spec list_platform_applications(client :: ExAws.SNS.t, input :: list_platform_applications_input) :: ExAws.Request.Query.response_t
  def list_platform_applications(client, input) do
    request(client, "/", "ListPlatformApplications", input)
  end

  @doc """
  Same as `list_platform_applications/2` but raise on error.
  """
  @spec list_platform_applications!(client :: ExAws.SNS.t, input :: list_platform_applications_input) :: ExAws.Request.Query.success_t | no_return
  def list_platform_applications!(client, input) do
    case list_platform_applications(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListSubscriptions

  Returns a list of the requester's subscriptions. Each call returns a
  limited list of subscriptions, up to 100. If there are more subscriptions,
  a `NextToken` is also returned. Use the `NextToken` parameter in a new
  `ListSubscriptions` call to get further results.
  """

  @spec list_subscriptions(client :: ExAws.SNS.t, input :: list_subscriptions_input) :: ExAws.Request.Query.response_t
  def list_subscriptions(client, input) do
    request(client, "/", "ListSubscriptions", input)
  end

  @doc """
  Same as `list_subscriptions/2` but raise on error.
  """
  @spec list_subscriptions!(client :: ExAws.SNS.t, input :: list_subscriptions_input) :: ExAws.Request.Query.success_t | no_return
  def list_subscriptions!(client, input) do
    case list_subscriptions(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListSubscriptionsByTopic

  Returns a list of the subscriptions to a specific topic. Each call returns
  a limited list of subscriptions, up to 100. If there are more
  subscriptions, a `NextToken` is also returned. Use the `NextToken`
  parameter in a new `ListSubscriptionsByTopic` call to get further results.
  """

  @spec list_subscriptions_by_topic(client :: ExAws.SNS.t, input :: list_subscriptions_by_topic_input) :: ExAws.Request.Query.response_t
  def list_subscriptions_by_topic(client, input) do
    request(client, "/", "ListSubscriptionsByTopic", input)
  end

  @doc """
  Same as `list_subscriptions_by_topic/2` but raise on error.
  """
  @spec list_subscriptions_by_topic!(client :: ExAws.SNS.t, input :: list_subscriptions_by_topic_input) :: ExAws.Request.Query.success_t | no_return
  def list_subscriptions_by_topic!(client, input) do
    case list_subscriptions_by_topic(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListTopics

  Returns a list of the requester's topics. Each call returns a limited list
  of topics, up to 100. If there are more topics, a `NextToken` is also
  returned. Use the `NextToken` parameter in a new `ListTopics` call to get
  further results.
  """

  @spec list_topics(client :: ExAws.SNS.t, input :: list_topics_input) :: ExAws.Request.Query.response_t
  def list_topics(client, input) do
    request(client, "/", "ListTopics", input)
  end

  @doc """
  Same as `list_topics/2` but raise on error.
  """
  @spec list_topics!(client :: ExAws.SNS.t, input :: list_topics_input) :: ExAws.Request.Query.success_t | no_return
  def list_topics!(client, input) do
    case list_topics(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  Publish

  Sends a message to all of a topic's subscribed endpoints. When a
  `messageId` is returned, the message has been saved and Amazon SNS will
  attempt to deliver it to the topic's subscribers shortly. The format of the
  outgoing message to each subscribed endpoint depends on the notification
  protocol selected.

  To use the `Publish` action for sending a message to a mobile endpoint,
  such as an app on a Kindle device or mobile phone, you must specify the
  EndpointArn. The EndpointArn is returned when making a call with the
  `CreatePlatformEndpoint` action. The second example below shows a request
  and response for publishing to a mobile endpoint.
  """

  @spec publish(client :: ExAws.SNS.t, input :: publish_input) :: ExAws.Request.Query.response_t
  def publish(client, input) do
    request(client, "/", "Publish", input)
  end

  @doc """
  Same as `publish/2` but raise on error.
  """
  @spec publish!(client :: ExAws.SNS.t, input :: publish_input) :: ExAws.Request.Query.success_t | no_return
  def publish!(client, input) do
    case publish(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RemovePermission

  Removes a statement from a topic's access control policy.
  """

  @spec remove_permission(client :: ExAws.SNS.t, input :: remove_permission_input) :: ExAws.Request.Query.response_t
  def remove_permission(client, input) do
    request(client, "/", "RemovePermission", input)
  end

  @doc """
  Same as `remove_permission/2` but raise on error.
  """
  @spec remove_permission!(client :: ExAws.SNS.t, input :: remove_permission_input) :: ExAws.Request.Query.success_t | no_return
  def remove_permission!(client, input) do
    case remove_permission(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  SetEndpointAttributes

  Sets the attributes for an endpoint for a device on one of the supported
  push notification services, such as GCM and APNS. For more information, see
  [Using Amazon SNS Mobile Push
  Notifications](http://docs.aws.amazon.com/sns/latest/dg/SNSMobilePush.html).
  """

  @spec set_endpoint_attributes(client :: ExAws.SNS.t, input :: set_endpoint_attributes_input) :: ExAws.Request.Query.response_t
  def set_endpoint_attributes(client, input) do
    request(client, "/", "SetEndpointAttributes", input)
  end

  @doc """
  Same as `set_endpoint_attributes/2` but raise on error.
  """
  @spec set_endpoint_attributes!(client :: ExAws.SNS.t, input :: set_endpoint_attributes_input) :: ExAws.Request.Query.success_t | no_return
  def set_endpoint_attributes!(client, input) do
    case set_endpoint_attributes(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  SetPlatformApplicationAttributes

  Sets the attributes of the platform application object for the supported
  push notification services, such as APNS and GCM. For more information, see
  [Using Amazon SNS Mobile Push
  Notifications](http://docs.aws.amazon.com/sns/latest/dg/SNSMobilePush.html).
  """

  @spec set_platform_application_attributes(client :: ExAws.SNS.t, input :: set_platform_application_attributes_input) :: ExAws.Request.Query.response_t
  def set_platform_application_attributes(client, input) do
    request(client, "/", "SetPlatformApplicationAttributes", input)
  end

  @doc """
  Same as `set_platform_application_attributes/2` but raise on error.
  """
  @spec set_platform_application_attributes!(client :: ExAws.SNS.t, input :: set_platform_application_attributes_input) :: ExAws.Request.Query.success_t | no_return
  def set_platform_application_attributes!(client, input) do
    case set_platform_application_attributes(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  SetSubscriptionAttributes

  Allows a subscription owner to set an attribute of the topic to a new
  value.
  """

  @spec set_subscription_attributes(client :: ExAws.SNS.t, input :: set_subscription_attributes_input) :: ExAws.Request.Query.response_t
  def set_subscription_attributes(client, input) do
    request(client, "/", "SetSubscriptionAttributes", input)
  end

  @doc """
  Same as `set_subscription_attributes/2` but raise on error.
  """
  @spec set_subscription_attributes!(client :: ExAws.SNS.t, input :: set_subscription_attributes_input) :: ExAws.Request.Query.success_t | no_return
  def set_subscription_attributes!(client, input) do
    case set_subscription_attributes(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  SetTopicAttributes

  Allows a topic owner to set an attribute of the topic to a new value.
  """

  @spec set_topic_attributes(client :: ExAws.SNS.t, input :: set_topic_attributes_input) :: ExAws.Request.Query.response_t
  def set_topic_attributes(client, input) do
    request(client, "/", "SetTopicAttributes", input)
  end

  @doc """
  Same as `set_topic_attributes/2` but raise on error.
  """
  @spec set_topic_attributes!(client :: ExAws.SNS.t, input :: set_topic_attributes_input) :: ExAws.Request.Query.success_t | no_return
  def set_topic_attributes!(client, input) do
    case set_topic_attributes(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  Subscribe

  Prepares to subscribe an endpoint by sending the endpoint a confirmation
  message. To actually create a subscription, the endpoint owner must call
  the `ConfirmSubscription` action with the token from the confirmation
  message. Confirmation tokens are valid for three days.
  """

  @spec subscribe(client :: ExAws.SNS.t, input :: subscribe_input) :: ExAws.Request.Query.response_t
  def subscribe(client, input) do
    request(client, "/", "Subscribe", input)
  end

  @doc """
  Same as `subscribe/2` but raise on error.
  """
  @spec subscribe!(client :: ExAws.SNS.t, input :: subscribe_input) :: ExAws.Request.Query.success_t | no_return
  def subscribe!(client, input) do
    case subscribe(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  Unsubscribe

  Deletes a subscription. If the subscription requires authentication for
  deletion, only the owner of the subscription or the topic's owner can
  unsubscribe, and an AWS signature is required. If the `Unsubscribe` call
  does not require authentication and the requester is not the subscription
  owner, a final cancellation message is delivered to the endpoint, so that
  the endpoint owner can easily resubscribe to the topic if the `Unsubscribe`
  request was unintended.
  """

  @spec unsubscribe(client :: ExAws.SNS.t, input :: unsubscribe_input) :: ExAws.Request.Query.response_t
  def unsubscribe(client, input) do
    request(client, "/", "Unsubscribe", input)
  end

  @doc """
  Same as `unsubscribe/2` but raise on error.
  """
  @spec unsubscribe!(client :: ExAws.SNS.t, input :: unsubscribe_input) :: ExAws.Request.Query.success_t | no_return
  def unsubscribe!(client, input) do
    case unsubscribe(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  defp request(%{__struct__: client_module} = client, uri, action, input) do
    apply(client_module, :request, [client, uri, action, input])
  end
end
