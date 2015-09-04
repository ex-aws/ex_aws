defmodule ExAws.AWS.Config.Core do
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


  @doc """
  DeleteDeliveryChannel

  Deletes the specified delivery channel.

  The delivery channel cannot be deleted if it is the only delivery channel
  and the configuration recorder is still running. To delete the delivery
  channel, stop the running configuration recorder using the
  `StopConfigurationRecorder` action.
  """
  def delete_delivery_channel(client, input) do
    request(client, "DeleteDeliveryChannel", input)
  end

  @doc """
  DeliverConfigSnapshot

  Schedules delivery of a configuration snapshot to the Amazon S3 bucket in
  the specified delivery channel. After the delivery has started, AWS Config
  sends following notifications using an Amazon SNS topic that you have
  specified.

  <ul> <li>Notification of starting the delivery.</li> <li>Notification of
  delivery completed, if the delivery was successfully completed.</li>
  <li>Notification of delivery failure, if the delivery failed to
  complete.</li> </ul>
  """
  def deliver_config_snapshot(client, input) do
    request(client, "DeliverConfigSnapshot", input)
  end

  @doc """
  DescribeConfigurationRecorderStatus

  Returns the current status of the specified configuration recorder. If a
  configuration recorder is not specified, this action returns the status of
  all configuration recorder associated with the account.

  Note:Currently, you can specify only one configuration recorder per
  account.
  """
  def describe_configuration_recorder_status(client, input) do
    request(client, "DescribeConfigurationRecorderStatus", input)
  end

  @doc """
  DescribeConfigurationRecorders

  Returns the name of one or more specified configuration recorders. If the
  recorder name is not specified, this action returns the names of all the
  configuration recorders associated with the account.

  Note: Currently, you can specify only one configuration recorder per
  account.
  """
  def describe_configuration_recorders(client, input) do
    request(client, "DescribeConfigurationRecorders", input)
  end

  @doc """
  DescribeDeliveryChannelStatus

  Returns the current status of the specified delivery channel. If a delivery
  channel is not specified, this action returns the current status of all
  delivery channels associated with the account.

  Note:Currently, you can specify only one delivery channel per account.
  """
  def describe_delivery_channel_status(client, input) do
    request(client, "DescribeDeliveryChannelStatus", input)
  end

  @doc """
  DescribeDeliveryChannels

  Returns details about the specified delivery channel. If a delivery channel
  is not specified, this action returns the details of all delivery channels
  associated with the account.

  Note: Currently, you can specify only one delivery channel per account.
  """
  def describe_delivery_channels(client, input) do
    request(client, "DescribeDeliveryChannels", input)
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
  def get_resource_config_history(client, input) do
    request(client, "GetResourceConfigHistory", input)
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
  def list_discovered_resources(client, input) do
    request(client, "ListDiscoveredResources", input)
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
  def put_configuration_recorder(client, input) do
    request(client, "PutConfigurationRecorder", input)
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
  def put_delivery_channel(client, input) do
    request(client, "PutDeliveryChannel", input)
  end

  @doc """
  StartConfigurationRecorder

  Starts recording configurations of the AWS resources you have selected to
  record in your AWS account.

  You must have created at least one delivery channel to successfully start
  the configuration recorder.
  """
  def start_configuration_recorder(client, input) do
    request(client, "StartConfigurationRecorder", input)
  end

  @doc """
  StopConfigurationRecorder

  Stops recording configurations of the AWS resources you have selected to
  record in your AWS account.
  """
  def stop_configuration_recorder(client, input) do
    request(client, "StopConfigurationRecorder", input)
  end


  defp request(%{__struct__: client_module} = client, action, input) do
    client_module.request(client, action, input)
  end
end
