defmodule ExAws.Logs.Core do
  @actions [
    "CreateLogGroup",
    "CreateLogStream",
    "DeleteDestination",
    "DeleteLogGroup",
    "DeleteLogStream",
    "DeleteMetricFilter",
    "DeleteRetentionPolicy",
    "DeleteSubscriptionFilter",
    "DescribeDestinations",
    "DescribeLogGroups",
    "DescribeLogStreams",
    "DescribeMetricFilters",
    "DescribeSubscriptionFilters",
    "FilterLogEvents",
    "GetLogEvents",
    "PutDestination",
    "PutDestinationPolicy",
    "PutLogEvents",
    "PutMetricFilter",
    "PutRetentionPolicy",
    "PutSubscriptionFilter",
    "TestMetricFilter"]

  @moduledoc """
  ## Amazon CloudWatch Logs

  Amazon CloudWatch Logs API Reference

  This is the *Amazon CloudWatch Logs API Reference*. Amazon CloudWatch Logs
  enables you to monitor, store, and access your system, application, and
  custom log files. This guide provides detailed information about Amazon
  CloudWatch Logs actions, data types, parameters, and errors. For detailed
  information about Amazon CloudWatch Logs features and their associated API
  calls, go to the [Amazon CloudWatch Developer
  Guide](http://docs.aws.amazon.com/AmazonCloudWatch/latest/DeveloperGuide).

  Use the following links to get started using the *Amazon CloudWatch Logs
  API Reference*:

  <ul> <li>
  [Actions](http://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_Operations.html):
  An alphabetical list of all Amazon CloudWatch Logs actions.</li> <li> [Data
  Types](http://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_Types.html):
  An alphabetical list of all Amazon CloudWatch Logs data types.</li> <li>
  [Common
  Parameters](http://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/CommonParameters.html):
  Parameters that all Query actions can use.</li> <li> [Common
  Errors](http://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/CommonErrors.html):
  Client and server errors that all actions can return.</li> <li> [Regions
  and
  Endpoints](http://docs.aws.amazon.com/general/latest/gr/index.html?rande.html):
  Itemized regions and endpoints for all AWS products.</li> </ul> In addition
  to using the Amazon CloudWatch Logs API, you can also use the following
  SDKs and third-party libraries to access Amazon CloudWatch Logs
  programmatically.

  <ul> <li>[AWS SDK for Java
  Documentation](http://aws.amazon.com/documentation/sdkforjava/)</li>
  <li>[AWS SDK for .NET
  Documentation](http://aws.amazon.com/documentation/sdkfornet/)</li>
  <li>[AWS SDK for PHP
  Documentation](http://aws.amazon.com/documentation/sdkforphp/)</li>
  <li>[AWS SDK for Ruby
  Documentation](http://aws.amazon.com/documentation/sdkforruby/)</li> </ul>
  Developers in the AWS developer community also provide their own libraries,
  which you can find at the following AWS developer centers:

  <ul> <li>[AWS Java Developer Center](http://aws.amazon.com/java/)</li>
  <li>[AWS PHP Developer Center](http://aws.amazon.com/php/)</li> <li>[AWS
  Python Developer Center](http://aws.amazon.com/python/)</li> <li>[AWS Ruby
  Developer Center](http://aws.amazon.com/ruby/)</li> <li>[AWS Windows and
  .NET Developer Center](http://aws.amazon.com/net/)</li> </ul>
  """


  @doc """
  CreateLogGroup

  Creates a new log group with the specified name. The name of the log group
  must be unique within a region for an AWS account. You can create up to 500
  log groups per account.

  You must use the following guidelines when naming a log group: <ul> <li>Log
  group names can be between 1 and 512 characters long.</li> <li>Allowed
  characters are a-z, A-Z, 0-9, '_' (underscore), '-' (hyphen), '/' (forward
  slash), and '.' (period).</li> </ul>
  """
  def create_log_group(client, input) do
    request(client, "CreateLogGroup", input)
  end

  @doc """
  CreateLogStream

  Creates a new log stream in the specified log group. The name of the log
  stream must be unique within the log group. There is no limit on the number
  of log streams that can exist in a log group.

  You must use the following guidelines when naming a log stream: <ul>
  <li>Log stream names can be between 1 and 512 characters long.</li> <li>The
  ':' colon character is not allowed.</li> </ul>
  """
  def create_log_stream(client, input) do
    request(client, "CreateLogStream", input)
  end

  @doc """
  DeleteDestination

  Deletes the destination with the specified name and eventually disables all
  the subscription filters that publish to it. This will not delete the
  physical resource encapsulated by the destination.
  """
  def delete_destination(client, input) do
    request(client, "DeleteDestination", input)
  end

  @doc """
  DeleteLogGroup

  Deletes the log group with the specified name and permanently deletes all
  the archived log events associated with it.
  """
  def delete_log_group(client, input) do
    request(client, "DeleteLogGroup", input)
  end

  @doc """
  DeleteLogStream

  Deletes a log stream and permanently deletes all the archived log events
  associated with it.
  """
  def delete_log_stream(client, input) do
    request(client, "DeleteLogStream", input)
  end

  @doc """
  DeleteMetricFilter

  Deletes a metric filter associated with the specified log group.
  """
  def delete_metric_filter(client, input) do
    request(client, "DeleteMetricFilter", input)
  end

  @doc """
  DeleteRetentionPolicy

  Deletes the retention policy of the specified log group. Log events would
  not expire if they belong to log groups without a retention policy.
  """
  def delete_retention_policy(client, input) do
    request(client, "DeleteRetentionPolicy", input)
  end

  @doc """
  DeleteSubscriptionFilter

  Deletes a subscription filter associated with the specified log group.
  """
  def delete_subscription_filter(client, input) do
    request(client, "DeleteSubscriptionFilter", input)
  end

  @doc """
  DescribeDestinations

  Returns all the destinations that are associated with the AWS account
  making the request. The list returned in the response is ASCII-sorted by
  destination name.

  By default, this operation returns up to 50 destinations. If there are more
  destinations to list, the response would contain a <code
  class="code">nextToken` value in the response body. You can also limit the
  number of destinations returned in the response by specifying the <code
  class="code">limit` parameter in the request.
  """
  def describe_destinations(client, input) do
    request(client, "DescribeDestinations", input)
  end

  @doc """
  DescribeLogGroups

  Returns all the log groups that are associated with the AWS account making
  the request. The list returned in the response is ASCII-sorted by log group
  name.

  By default, this operation returns up to 50 log groups. If there are more
  log groups to list, the response would contain a <code
  class="code">nextToken` value in the response body. You can also limit the
  number of log groups returned in the response by specifying the <code
  class="code">limit` parameter in the request.
  """
  def describe_log_groups(client, input) do
    request(client, "DescribeLogGroups", input)
  end

  @doc """
  DescribeLogStreams

  Returns all the log streams that are associated with the specified log
  group. The list returned in the response is ASCII-sorted by log stream
  name.

  By default, this operation returns up to 50 log streams. If there are more
  log streams to list, the response would contain a <code
  class="code">nextToken` value in the response body. You can also limit the
  number of log streams returned in the response by specifying the <code
  class="code">limit` parameter in the request. This operation has a limit of
  five transactions per second, after which transactions are throttled.
  """
  def describe_log_streams(client, input) do
    request(client, "DescribeLogStreams", input)
  end

  @doc """
  DescribeMetricFilters

  Returns all the metrics filters associated with the specified log group.
  The list returned in the response is ASCII-sorted by filter name.

  By default, this operation returns up to 50 metric filters. If there are
  more metric filters to list, the response would contain a <code
  class="code">nextToken` value in the response body. You can also limit the
  number of metric filters returned in the response by specifying the <code
  class="code">limit` parameter in the request.
  """
  def describe_metric_filters(client, input) do
    request(client, "DescribeMetricFilters", input)
  end

  @doc """
  DescribeSubscriptionFilters

  Returns all the subscription filters associated with the specified log
  group. The list returned in the response is ASCII-sorted by filter name.

  By default, this operation returns up to 50 subscription filters. If there
  are more subscription filters to list, the response would contain a <code
  class="code">nextToken` value in the response body. You can also limit the
  number of subscription filters returned in the response by specifying the
  <code class="code">limit` parameter in the request.
  """
  def describe_subscription_filters(client, input) do
    request(client, "DescribeSubscriptionFilters", input)
  end

  @doc """
  FilterLogEvents

  Retrieves log events, optionally filtered by a filter pattern from the
  specified log group. You can provide an optional time range to filter the
  results on the event <code class="code">timestamp`. You can limit the
  streams searched to an explicit list of <code class="code">logStreamNames`.

  By default, this operation returns as much matching log events as can fit
  in a response size of 1MB, up to 10,000 log events, or all the events found
  within a time-bounded scan window. If the response includes a <code
  class="code">nextToken`, then there is more data to search, and the search
  can be resumed with a new request providing the nextToken. The response
  will contain a list of <code class="code">searchedLogStreams` that contains
  information about which streams were searched in the request and whether
  they have been searched completely or require further pagination. The <code
  class="code">limit` parameter in the request. can be used to specify the
  maximum number of events to return in a page.
  """
  def filter_log_events(client, input) do
    request(client, "FilterLogEvents", input)
  end

  @doc """
  GetLogEvents

  Retrieves log events from the specified log stream. You can provide an
  optional time range to filter the results on the event <code
  class="code">timestamp`.

  By default, this operation returns as much log events as can fit in a
  response size of 1MB, up to 10,000 log events. The response will always
  include a <code class="code">nextForwardToken` and a <code
  class="code">nextBackwardToken` in the response body. You can use any of
  these tokens in subsequent <code class="code">GetLogEvents` requests to
  paginate through events in either forward or backward direction. You can
  also limit the number of log events returned in the response by specifying
  the <code class="code">limit` parameter in the request.
  """
  def get_log_events(client, input) do
    request(client, "GetLogEvents", input)
  end

  @doc """
  PutDestination

  Creates or updates a `Destination`. A destination encapsulates a physical
  resource (such as a Kinesis stream) and allows you to subscribe to a
  real-time stream of log events of a different account, ingested through
  <code class="code">PutLogEvents` requests. Currently, the only supported
  physical resource is a Amazon Kinesis stream belonging to the same account
  as the destination.

  A destination controls what is written to its Amazon Kinesis stream through
  an access policy. By default, PutDestination does not set any access policy
  with the destination, which means a cross-account user will not be able to
  call `PutSubscriptionFilter` against this destination. To enable that, the
  destination owner must call `PutDestinationPolicy` after PutDestination.
  """
  def put_destination(client, input) do
    request(client, "PutDestination", input)
  end

  @doc """
  PutDestinationPolicy

  Creates or updates an access policy associated with an existing
  `Destination`. An access policy is an [IAM policy
  document](http://docs.aws.amazon.com/IAM/latest/UserGuide/policies_overview.html)
  that is used to authorize claims to register a subscription filter against
  a given destination.
  """
  def put_destination_policy(client, input) do
    request(client, "PutDestinationPolicy", input)
  end

  @doc """
  PutLogEvents

  Uploads a batch of log events to the specified log stream.

  Every PutLogEvents request must include the <code
  class="code">sequenceToken` obtained from the response of the previous
  request. An upload in a newly created log stream does not require a <code
  class="code">sequenceToken`.

  The batch of events must satisfy the following constraints: <ul> <li>The
  maximum batch size is 1,048,576 bytes, and this size is calculated as the
  sum of all event messages in UTF-8, plus 26 bytes for each log event.</li>
  <li>None of the log events in the batch can be more than 2 hours in the
  future.</li> <li>None of the log events in the batch can be older than 14
  days or the retention period of the log group.</li> <li>The log events in
  the batch must be in chronological ordered by their <code
  class="code">timestamp`.</li> <li>The maximum number of log events in a
  batch is 10,000.</li> </ul>
  """
  def put_log_events(client, input) do
    request(client, "PutLogEvents", input)
  end

  @doc """
  PutMetricFilter

  Creates or updates a metric filter and associates it with the specified log
  group. Metric filters allow you to configure rules to extract metric data
  from log events ingested through <code class="code">PutLogEvents` requests.

  The maximum number of metric filters that can be associated with a log
  group is 100.
  """
  def put_metric_filter(client, input) do
    request(client, "PutMetricFilter", input)
  end

  @doc """
  PutRetentionPolicy

  Sets the retention of the specified log group. A retention policy allows
  you to configure the number of days you want to retain log events in the
  specified log group.
  """
  def put_retention_policy(client, input) do
    request(client, "PutRetentionPolicy", input)
  end

  @doc """
  PutSubscriptionFilter

  Creates or updates a subscription filter and associates it with the
  specified log group. Subscription filters allow you to subscribe to a
  real-time stream of log events ingested through <code
  class="code">PutLogEvents` requests and have them delivered to a specific
  destination. Currently, the supported destinations are: <ul> <li> A Amazon
  Kinesis stream belonging to the same account as the subscription filter,
  for same-account delivery. </li> <li> A logical destination (used via an
  ARN of `Destination`) belonging to a different account, for cross-account
  delivery. </li> </ul>

  Currently there can only be one subscription filter associated with a log
  group.
  """
  def put_subscription_filter(client, input) do
    request(client, "PutSubscriptionFilter", input)
  end

  @doc """
  TestMetricFilter

  Tests the filter pattern of a metric filter against a sample of log event
  messages. You can use this operation to validate the correctness of a
  metric filter pattern.
  """
  def test_metric_filter(client, input) do
    request(client, "TestMetricFilter", input)
  end


  defp request(%{__struct__: client_module} = client, action, input) do
    client_module.request(client, action, input)
  end
end
