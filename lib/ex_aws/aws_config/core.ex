defmodule ExAws.AWS.Config.Core do
  import ExAws.Core.JSON, only: [format_input: 1]
  @actions [
    "DeleteDeliveryChannel",
    "DeliverConfigSnapshot",
    "DescribeConfigurationRecorderStatus",
    "DescribeConfigurationRecorders",
    "DescribeDeliveryChannelStatus",
    "DescribeDeliveryChannels",
    "GetResourceConfigHistory",
    "ListDiscoveredResources",
    "PutConfigurationRecorder",
    "PutDeliveryChannel",
    "StartConfigurationRecorder",
    "StopConfigurationRecorder"]

  @moduledoc """
  ## AWS Config

  AWS Config

  AWS Config provides a way to keep track of the configurations of all the
  AWS resources associated with your AWS account. You can use AWS Config to
  get the current and historical configurations of each AWS resource and also
  to get information about the relationship between the resources. An AWS
  resource can be an Amazon Compute Cloud (Amazon EC2) instance, an Elastic
  Block Store (EBS) volume, an Elastic network Interface (ENI), or a security
  group. For a complete list of resources currently supported by AWS Config,
  see [Supported AWS
  Resources](http://docs.aws.amazon.com/config/latest/developerguide/resource-config-reference.html#supported-resources).

  You can access and manage AWS Config through the AWS Management Console,
  the AWS Command Line Interface (AWS CLI), the AWS Config API, or the AWS
  SDKs for AWS Config

  This reference guide contains documentation for the AWS Config API and the
  AWS CLI commands that you can use to manage AWS Config.

  The AWS Config API uses the Signature Version 4 protocol for signing
  requests. For more information about how to sign a request with this
  protocol, see [Signature Version 4 Signing
  Process](http://docs.aws.amazon.com/general/latest/gr/signature-version-4.html).

  For detailed information about AWS Config features and their associated
  actions or commands, as well as how to work with AWS Management Console,
  see [What Is AWS
  Config?](http://docs.aws.amazon.com/config/latest/developerguide/WhatIsConfig.html)
  in the *AWS Config Developer Guide*.
  """

  @type arn :: binary

  @type account_id :: binary

  @type all_supported :: boolean

  @type availability_zone :: binary

  @type aws_region :: binary

  @type channel_name :: binary

  @type chronological_order :: binary

  @type config_export_delivery_info :: [
    last_attempt_time: date,
    last_error_code: binary,
    last_error_message: binary,
    last_status: delivery_status,
    last_successful_time: date,
  ]

  @type config_stream_delivery_info :: [
    last_error_code: binary,
    last_error_message: binary,
    last_status: delivery_status,
    last_status_change_time: date,
  ]

  @type configuration :: binary

  @type configuration_item :: [
    account_id: account_id,
    arn: arn,
    availability_zone: availability_zone,
    aws_region: aws_region,
    configuration: configuration,
    configuration_item_capture_time: configuration_item_capture_time,
    configuration_item_m_d5_hash: configuration_item_m_d5_hash,
    configuration_item_status: configuration_item_status,
    configuration_state_id: configuration_state_id,
    related_events: related_event_list,
    relationships: relationship_list,
    resource_creation_time: resource_creation_time,
    resource_id: resource_id,
    resource_name: resource_name,
    resource_type: resource_type,
    tags: tags,
    version: version,
  ]

  @type configuration_item_capture_time :: integer

  @type configuration_item_list :: [configuration_item]

  @type configuration_item_m_d5_hash :: binary

  @type configuration_item_status :: binary

  @type configuration_recorder :: [
    name: recorder_name,
    recording_group: recording_group,
    role_arn: binary,
  ]

  @type configuration_recorder_list :: [configuration_recorder]

  @type configuration_recorder_name_list :: [recorder_name]

  @type configuration_recorder_status :: [
    last_error_code: binary,
    last_error_message: binary,
    last_start_time: date,
    last_status: recorder_status,
    last_status_change_time: date,
    last_stop_time: date,
    name: binary,
    recording: boolean,
  ]

  @type configuration_recorder_status_list :: [configuration_recorder_status]

  @type configuration_state_id :: binary

  @type date :: integer

  @type delete_delivery_channel_request :: [
    delivery_channel_name: channel_name,
  ]

  @type deliver_config_snapshot_request :: [
    delivery_channel_name: channel_name,
  ]

  @type deliver_config_snapshot_response :: [
    config_snapshot_id: binary,
  ]

  @type delivery_channel :: [
    name: channel_name,
    s3_bucket_name: binary,
    s3_key_prefix: binary,
    sns_topic_arn: binary,
  ]

  @type delivery_channel_list :: [delivery_channel]

  @type delivery_channel_name_list :: [channel_name]

  @type delivery_channel_status :: [
    config_history_delivery_info: config_export_delivery_info,
    config_snapshot_delivery_info: config_export_delivery_info,
    config_stream_delivery_info: config_stream_delivery_info,
    name: binary,
  ]

  @type delivery_channel_status_list :: [delivery_channel_status]

  @type delivery_status :: binary

  @type describe_configuration_recorder_status_request :: [
    configuration_recorder_names: configuration_recorder_name_list,
  ]

  @type describe_configuration_recorder_status_response :: [
    configuration_recorders_status: configuration_recorder_status_list,
  ]

  @type describe_configuration_recorders_request :: [
    configuration_recorder_names: configuration_recorder_name_list,
  ]

  @type describe_configuration_recorders_response :: [
    configuration_recorders: configuration_recorder_list,
  ]

  @type describe_delivery_channel_status_request :: [
    delivery_channel_names: delivery_channel_name_list,
  ]

  @type describe_delivery_channel_status_response :: [
    delivery_channels_status: delivery_channel_status_list,
  ]

  @type describe_delivery_channels_request :: [
    delivery_channel_names: delivery_channel_name_list,
  ]

  @type describe_delivery_channels_response :: [
    delivery_channels: delivery_channel_list,
  ]

  @type earlier_time :: integer

  @type get_resource_config_history_request :: [
    chronological_order: chronological_order,
    earlier_time: earlier_time,
    later_time: later_time,
    limit: limit,
    next_token: next_token,
    resource_id: resource_id,
    resource_type: resource_type,
  ]

  @type get_resource_config_history_response :: [
    configuration_items: configuration_item_list,
    next_token: next_token,
  ]

  @type insufficient_delivery_policy_exception :: [
  ]

  @type invalid_configuration_recorder_name_exception :: [
  ]

  @type invalid_delivery_channel_name_exception :: [
  ]

  @type invalid_limit_exception :: [
  ]

  @type invalid_next_token_exception :: [
  ]

  @type invalid_recording_group_exception :: [
  ]

  @type invalid_role_exception :: [
  ]

  @type invalid_s3_key_prefix_exception :: [
  ]

  @type invalid_sns_topic_arn_exception :: [
  ]

  @type invalid_time_range_exception :: [
  ]

  @type last_delivery_channel_delete_failed_exception :: [
  ]

  @type later_time :: integer

  @type limit :: integer

  @type list_discovered_resources_request :: [
    include_deleted_resources: boolean,
    limit: limit,
    next_token: next_token,
    resource_ids: resource_id_list,
    resource_name: resource_name,
    resource_type: resource_type,
  ]

  @type list_discovered_resources_response :: [
    next_token: next_token,
    resource_identifiers: resource_identifier_list,
  ]

  @type max_number_of_configuration_recorders_exceeded_exception :: [
  ]

  @type max_number_of_delivery_channels_exceeded_exception :: [
  ]

  @type name :: binary

  @type next_token :: binary

  @type no_available_configuration_recorder_exception :: [
  ]

  @type no_available_delivery_channel_exception :: [
  ]

  @type no_running_configuration_recorder_exception :: [
  ]

  @type no_such_bucket_exception :: [
  ]

  @type no_such_configuration_recorder_exception :: [
  ]

  @type no_such_delivery_channel_exception :: [
  ]

  @type put_configuration_recorder_request :: [
    configuration_recorder: configuration_recorder,
  ]

  @type put_delivery_channel_request :: [
    delivery_channel: delivery_channel,
  ]

  @type recorder_name :: binary

  @type recorder_status :: binary

  @type recording_group :: [
    all_supported: all_supported,
    resource_types: resource_type_list,
  ]

  @type related_event :: binary

  @type related_event_list :: [related_event]

  @type relationship :: [
    relationship_name: relationship_name,
    resource_id: resource_id,
    resource_name: resource_name,
    resource_type: resource_type,
  ]

  @type relationship_list :: [relationship]

  @type relationship_name :: binary

  @type resource_creation_time :: integer

  @type resource_deletion_time :: integer

  @type resource_id :: binary

  @type resource_id_list :: [resource_id]

  @type resource_identifier :: [
    resource_deletion_time: resource_deletion_time,
    resource_id: resource_id,
    resource_name: resource_name,
    resource_type: resource_type,
  ]

  @type resource_identifier_list :: [resource_identifier]

  @type resource_name :: binary

  @type resource_not_discovered_exception :: [
  ]

  @type resource_type :: binary

  @type resource_type_list :: [resource_type]

  @type start_configuration_recorder_request :: [
    configuration_recorder_name: recorder_name,
  ]

  @type stop_configuration_recorder_request :: [
    configuration_recorder_name: recorder_name,
  ]

  @type tags :: [{name, value}]

  @type validation_exception :: [
  ]

  @type value :: binary

  @type version :: binary





  @doc """
  DeleteDeliveryChannel

  Deletes the specified delivery channel.

  The delivery channel cannot be deleted if it is the only delivery channel
  and the configuration recorder is still running. To delete the delivery
  channel, stop the running configuration recorder using the
  `StopConfigurationRecorder` action.
  """

  @spec delete_delivery_channel(client :: ExAws.AWS.Config.t, input :: delete_delivery_channel_request) :: ExAws.Request.JSON.response_t
  def delete_delivery_channel(client, input) do
    request(client, "DeleteDeliveryChannel", format_input(input))
  end

  @doc """
  Same as `delete_delivery_channel/2` but raise on error.
  """
  @spec delete_delivery_channel!(client :: ExAws.AWS.Config.t, input :: delete_delivery_channel_request) :: ExAws.Request.JSON.success_t | no_return
  def delete_delivery_channel!(client, input) do
    case delete_delivery_channel(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeliverConfigSnapshot

  Schedules delivery of a configuration snapshot to the Amazon S3 bucket in
  the specified delivery channel. After the delivery has started, AWS Config
  sends following notifications using an Amazon SNS topic that you have
  specified.

  - Notification of starting the delivery.

  - Notification of delivery completed, if the delivery was successfully
  completed.

  - Notification of delivery failure, if the delivery failed to complete.
  """

  @spec deliver_config_snapshot(client :: ExAws.AWS.Config.t, input :: deliver_config_snapshot_request) :: ExAws.Request.JSON.response_t
  def deliver_config_snapshot(client, input) do
    request(client, "DeliverConfigSnapshot", format_input(input))
  end

  @doc """
  Same as `deliver_config_snapshot/2` but raise on error.
  """
  @spec deliver_config_snapshot!(client :: ExAws.AWS.Config.t, input :: deliver_config_snapshot_request) :: ExAws.Request.JSON.success_t | no_return
  def deliver_config_snapshot!(client, input) do
    case deliver_config_snapshot(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeConfigurationRecorderStatus

  Returns the current status of the specified configuration recorder. If a
  configuration recorder is not specified, this action returns the status of
  all configuration recorder associated with the account.

  Note:Currently, you can specify only one configuration recorder per
  account.
  """

  @spec describe_configuration_recorder_status(client :: ExAws.AWS.Config.t, input :: describe_configuration_recorder_status_request) :: ExAws.Request.JSON.response_t
  def describe_configuration_recorder_status(client, input) do
    request(client, "DescribeConfigurationRecorderStatus", format_input(input))
  end

  @doc """
  Same as `describe_configuration_recorder_status/2` but raise on error.
  """
  @spec describe_configuration_recorder_status!(client :: ExAws.AWS.Config.t, input :: describe_configuration_recorder_status_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_configuration_recorder_status!(client, input) do
    case describe_configuration_recorder_status(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeConfigurationRecorders

  Returns the name of one or more specified configuration recorders. If the
  recorder name is not specified, this action returns the names of all the
  configuration recorders associated with the account.

  Note: Currently, you can specify only one configuration recorder per
  account.
  """

  @spec describe_configuration_recorders(client :: ExAws.AWS.Config.t, input :: describe_configuration_recorders_request) :: ExAws.Request.JSON.response_t
  def describe_configuration_recorders(client, input) do
    request(client, "DescribeConfigurationRecorders", format_input(input))
  end

  @doc """
  Same as `describe_configuration_recorders/2` but raise on error.
  """
  @spec describe_configuration_recorders!(client :: ExAws.AWS.Config.t, input :: describe_configuration_recorders_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_configuration_recorders!(client, input) do
    case describe_configuration_recorders(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeDeliveryChannelStatus

  Returns the current status of the specified delivery channel. If a delivery
  channel is not specified, this action returns the current status of all
  delivery channels associated with the account.

  Note:Currently, you can specify only one delivery channel per account.
  """

  @spec describe_delivery_channel_status(client :: ExAws.AWS.Config.t, input :: describe_delivery_channel_status_request) :: ExAws.Request.JSON.response_t
  def describe_delivery_channel_status(client, input) do
    request(client, "DescribeDeliveryChannelStatus", format_input(input))
  end

  @doc """
  Same as `describe_delivery_channel_status/2` but raise on error.
  """
  @spec describe_delivery_channel_status!(client :: ExAws.AWS.Config.t, input :: describe_delivery_channel_status_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_delivery_channel_status!(client, input) do
    case describe_delivery_channel_status(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeDeliveryChannels

  Returns details about the specified delivery channel. If a delivery channel
  is not specified, this action returns the details of all delivery channels
  associated with the account.

  Note: Currently, you can specify only one delivery channel per account.
  """

  @spec describe_delivery_channels(client :: ExAws.AWS.Config.t, input :: describe_delivery_channels_request) :: ExAws.Request.JSON.response_t
  def describe_delivery_channels(client, input) do
    request(client, "DescribeDeliveryChannels", format_input(input))
  end

  @doc """
  Same as `describe_delivery_channels/2` but raise on error.
  """
  @spec describe_delivery_channels!(client :: ExAws.AWS.Config.t, input :: describe_delivery_channels_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_delivery_channels!(client, input) do
    case describe_delivery_channels(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetResourceConfigHistory

  Returns a list of configuration items for the specified resource. The list
  contains details about each state of the resource during the specified time
  interval.

  The response is paginated, and by default, AWS Config returns a limit of 10
  configuration items per page. You can customize this number with the
  `limit` parameter. The response includes a `nextToken` string, and to get
  the next page of results, run the request again and enter this string for
  the `nextToken` parameter.

  Note: Each call to the API is limited to span a duration of seven days. It
  is likely that the number of records returned is smaller than the specified
  `limit`. In such cases, you can make another call, using the `nextToken`.
  """

  @spec get_resource_config_history(client :: ExAws.AWS.Config.t, input :: get_resource_config_history_request) :: ExAws.Request.JSON.response_t
  def get_resource_config_history(client, input) do
    request(client, "GetResourceConfigHistory", format_input(input))
  end

  @doc """
  Same as `get_resource_config_history/2` but raise on error.
  """
  @spec get_resource_config_history!(client :: ExAws.AWS.Config.t, input :: get_resource_config_history_request) :: ExAws.Request.JSON.success_t | no_return
  def get_resource_config_history!(client, input) do
    case get_resource_config_history(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListDiscoveredResources

  Accepts a resource type and returns a list of resource identifiers for the
  resources of that type. A resource identifier includes the resource type,
  ID, and (if available) the custom resource name. The results consist of
  resources that AWS Config has discovered, including those that AWS Config
  is not currently recording. You can narrow the results to include only
  resources that have specific resource IDs or a resource name.

  Note:You can specify either resource IDs or a resource name but not both in
  the same request. The response is paginated, and by default AWS Config
  lists 100 resource identifiers on each page. You can customize this number
  with the `limit` parameter. The response includes a `nextToken` string, and
  to get the next page of results, run the request again and enter this
  string for the `nextToken` parameter.
  """

  @spec list_discovered_resources(client :: ExAws.AWS.Config.t, input :: list_discovered_resources_request) :: ExAws.Request.JSON.response_t
  def list_discovered_resources(client, input) do
    request(client, "ListDiscoveredResources", format_input(input))
  end

  @doc """
  Same as `list_discovered_resources/2` but raise on error.
  """
  @spec list_discovered_resources!(client :: ExAws.AWS.Config.t, input :: list_discovered_resources_request) :: ExAws.Request.JSON.success_t | no_return
  def list_discovered_resources!(client, input) do
    case list_discovered_resources(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  PutConfigurationRecorder

  Creates a new configuration recorder to record the selected resource
  configurations.

  You can use this action to change the role `roleARN` and/or the
  `recordingGroup` of an existing recorder. To change the role, call the
  action on the existing configuration recorder and specify a role.

  Note: Currently, you can specify only one configuration recorder per
  account.

  If `ConfigurationRecorder` does not have the **recordingGroup** parameter
  specified, the default is to record all supported resource types.
  """

  @spec put_configuration_recorder(client :: ExAws.AWS.Config.t, input :: put_configuration_recorder_request) :: ExAws.Request.JSON.response_t
  def put_configuration_recorder(client, input) do
    request(client, "PutConfigurationRecorder", format_input(input))
  end

  @doc """
  Same as `put_configuration_recorder/2` but raise on error.
  """
  @spec put_configuration_recorder!(client :: ExAws.AWS.Config.t, input :: put_configuration_recorder_request) :: ExAws.Request.JSON.success_t | no_return
  def put_configuration_recorder!(client, input) do
    case put_configuration_recorder(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  PutDeliveryChannel

  Creates a new delivery channel object to deliver the configuration
  information to an Amazon S3 bucket, and to an Amazon SNS topic.

  You can use this action to change the Amazon S3 bucket or an Amazon SNS
  topic of the existing delivery channel. To change the Amazon S3 bucket or
  an Amazon SNS topic, call this action and specify the changed values for
  the S3 bucket and the SNS topic. If you specify a different value for
  either the S3 bucket or the SNS topic, this action will keep the existing
  value for the parameter that is not changed.

  Note: Currently, you can specify only one delivery channel per account.
  """

  @spec put_delivery_channel(client :: ExAws.AWS.Config.t, input :: put_delivery_channel_request) :: ExAws.Request.JSON.response_t
  def put_delivery_channel(client, input) do
    request(client, "PutDeliveryChannel", format_input(input))
  end

  @doc """
  Same as `put_delivery_channel/2` but raise on error.
  """
  @spec put_delivery_channel!(client :: ExAws.AWS.Config.t, input :: put_delivery_channel_request) :: ExAws.Request.JSON.success_t | no_return
  def put_delivery_channel!(client, input) do
    case put_delivery_channel(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  StartConfigurationRecorder

  Starts recording configurations of the AWS resources you have selected to
  record in your AWS account.

  You must have created at least one delivery channel to successfully start
  the configuration recorder.
  """

  @spec start_configuration_recorder(client :: ExAws.AWS.Config.t, input :: start_configuration_recorder_request) :: ExAws.Request.JSON.response_t
  def start_configuration_recorder(client, input) do
    request(client, "StartConfigurationRecorder", format_input(input))
  end

  @doc """
  Same as `start_configuration_recorder/2` but raise on error.
  """
  @spec start_configuration_recorder!(client :: ExAws.AWS.Config.t, input :: start_configuration_recorder_request) :: ExAws.Request.JSON.success_t | no_return
  def start_configuration_recorder!(client, input) do
    case start_configuration_recorder(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  StopConfigurationRecorder

  Stops recording configurations of the AWS resources you have selected to
  record in your AWS account.
  """

  @spec stop_configuration_recorder(client :: ExAws.AWS.Config.t, input :: stop_configuration_recorder_request) :: ExAws.Request.JSON.response_t
  def stop_configuration_recorder(client, input) do
    request(client, "StopConfigurationRecorder", format_input(input))
  end

  @doc """
  Same as `stop_configuration_recorder/2` but raise on error.
  """
  @spec stop_configuration_recorder!(client :: ExAws.AWS.Config.t, input :: stop_configuration_recorder_request) :: ExAws.Request.JSON.success_t | no_return
  def stop_configuration_recorder!(client, input) do
    case stop_configuration_recorder(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  defp request(%{__struct__: client_module} = client, action, input) do
    apply(client_module, :request, [client, action, input])
  end
end
