defmodule ExAws.Logs.Core do
  import ExAws.Core.JSON, only: [format_input: 1]
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

  -
  [Actions](http://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_Operations.html):
  An alphabetical list of all Amazon CloudWatch Logs actions.

  - [Data
  Types](http://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_Types.html):
  An alphabetical list of all Amazon CloudWatch Logs data types.

  - [Common
  Parameters](http://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/CommonParameters.html):
  Parameters that all Query actions can use.

  - [Common
  Errors](http://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/CommonErrors.html):
  Client and server errors that all actions can return.

  - [Regions and
  Endpoints](http://docs.aws.amazon.com/general/latest/gr/index.html?rande.html):
  Itemized regions and endpoints for all AWS products.

  In addition to using the Amazon CloudWatch Logs API, you can also use the
  following SDKs and third-party libraries to access Amazon CloudWatch Logs
  programmatically.

  - [AWS SDK for Java
  Documentation](http://aws.amazon.com/documentation/sdkforjava/)

  - [AWS SDK for .NET
  Documentation](http://aws.amazon.com/documentation/sdkfornet/)

  - [AWS SDK for PHP
  Documentation](http://aws.amazon.com/documentation/sdkforphp/)

  - [AWS SDK for Ruby
  Documentation](http://aws.amazon.com/documentation/sdkforruby/)

  Developers in the AWS developer community also provide their own libraries,
  which you can find at the following AWS developer centers:

  - [AWS Java Developer Center](http://aws.amazon.com/java/)

  - [AWS PHP Developer Center](http://aws.amazon.com/php/)

  - [AWS Python Developer Center](http://aws.amazon.com/python/)

  - [AWS Ruby Developer Center](http://aws.amazon.com/ruby/)

  - [AWS Windows and .NET Developer Center](http://aws.amazon.com/net/)
  """

  @type access_policy :: binary

  @type arn :: binary

  @type create_log_group_request :: [
    log_group_name: log_group_name,
  ]

  @type create_log_stream_request :: [
    log_group_name: log_group_name,
    log_stream_name: log_stream_name,
  ]

  @type data_already_accepted_exception :: [
    expected_sequence_token: sequence_token,
  ]

  @type days :: integer

  @type delete_destination_request :: [
    destination_name: destination_name,
  ]

  @type delete_log_group_request :: [
    log_group_name: log_group_name,
  ]

  @type delete_log_stream_request :: [
    log_group_name: log_group_name,
    log_stream_name: log_stream_name,
  ]

  @type delete_metric_filter_request :: [
    filter_name: filter_name,
    log_group_name: log_group_name,
  ]

  @type delete_retention_policy_request :: [
    log_group_name: log_group_name,
  ]

  @type delete_subscription_filter_request :: [
    filter_name: filter_name,
    log_group_name: log_group_name,
  ]

  @type descending :: boolean

  @type describe_destinations_request :: [
    destination_name_prefix: destination_name,
    limit: describe_limit,
    next_token: next_token,
  ]

  @type describe_destinations_response :: [
    destinations: destinations,
    next_token: next_token,
  ]

  @type describe_limit :: integer

  @type describe_log_groups_request :: [
    limit: describe_limit,
    log_group_name_prefix: log_group_name,
    next_token: next_token,
  ]

  @type describe_log_groups_response :: [
    log_groups: log_groups,
    next_token: next_token,
  ]

  @type describe_log_streams_request :: [
    descending: descending,
    limit: describe_limit,
    log_group_name: log_group_name,
    log_stream_name_prefix: log_stream_name,
    next_token: next_token,
    order_by: order_by,
  ]

  @type describe_log_streams_response :: [
    log_streams: log_streams,
    next_token: next_token,
  ]

  @type describe_metric_filters_request :: [
    filter_name_prefix: filter_name,
    limit: describe_limit,
    log_group_name: log_group_name,
    next_token: next_token,
  ]

  @type describe_metric_filters_response :: [
    metric_filters: metric_filters,
    next_token: next_token,
  ]

  @type describe_subscription_filters_request :: [
    filter_name_prefix: filter_name,
    limit: describe_limit,
    log_group_name: log_group_name,
    next_token: next_token,
  ]

  @type describe_subscription_filters_response :: [
    next_token: next_token,
    subscription_filters: subscription_filters,
  ]

  @type destination :: [
    access_policy: access_policy,
    arn: arn,
    creation_time: timestamp,
    destination_name: destination_name,
    role_arn: role_arn,
    target_arn: target_arn,
  ]

  @type destination_arn :: binary

  @type destination_name :: binary

  @type destinations :: [destination]

  @type event_id :: binary

  @type event_message :: binary

  @type event_number :: integer

  @type events_limit :: integer

  @type extracted_values :: [{token, value}]

  @type filter_count :: integer

  @type filter_log_events_request :: [
    end_time: timestamp,
    filter_pattern: filter_pattern,
    interleaved: interleaved,
    limit: events_limit,
    log_group_name: log_group_name,
    log_stream_names: input_log_stream_names,
    next_token: next_token,
    start_time: timestamp,
  ]

  @type filter_log_events_response :: [
    events: filtered_log_events,
    next_token: next_token,
    searched_log_streams: searched_log_streams,
  ]

  @type filter_name :: binary

  @type filter_pattern :: binary

  @type filtered_log_event :: [
    event_id: event_id,
    ingestion_time: timestamp,
    log_stream_name: log_stream_name,
    message: event_message,
    timestamp: timestamp,
  ]

  @type filtered_log_events :: [filtered_log_event]

  @type get_log_events_request :: [
    end_time: timestamp,
    limit: events_limit,
    log_group_name: log_group_name,
    log_stream_name: log_stream_name,
    next_token: next_token,
    start_from_head: start_from_head,
    start_time: timestamp,
  ]

  @type get_log_events_response :: [
    events: output_log_events,
    next_backward_token: next_token,
    next_forward_token: next_token,
  ]

  @type input_log_event :: [
    message: event_message,
    timestamp: timestamp,
  ]

  @type input_log_events :: [input_log_event]

  @type input_log_stream_names :: [log_stream_name]

  @type interleaved :: boolean

  @type invalid_parameter_exception :: [
  ]

  @type invalid_sequence_token_exception :: [
    expected_sequence_token: sequence_token,
  ]

  @type limit_exceeded_exception :: [
  ]

  @type log_event_index :: integer

  @type log_group :: [
    arn: arn,
    creation_time: timestamp,
    log_group_name: log_group_name,
    metric_filter_count: filter_count,
    retention_in_days: days,
    stored_bytes: stored_bytes,
  ]

  @type log_group_name :: binary

  @type log_groups :: [log_group]

  @type log_stream :: [
    arn: arn,
    creation_time: timestamp,
    first_event_timestamp: timestamp,
    last_event_timestamp: timestamp,
    last_ingestion_time: timestamp,
    log_stream_name: log_stream_name,
    stored_bytes: stored_bytes,
    upload_sequence_token: sequence_token,
  ]

  @type log_stream_name :: binary

  @type log_stream_searched_completely :: boolean

  @type log_streams :: [log_stream]

  @type metric_filter :: [
    creation_time: timestamp,
    filter_name: filter_name,
    filter_pattern: filter_pattern,
    metric_transformations: metric_transformations,
  ]

  @type metric_filter_match_record :: [
    event_message: event_message,
    event_number: event_number,
    extracted_values: extracted_values,
  ]

  @type metric_filter_matches :: [metric_filter_match_record]

  @type metric_filters :: [metric_filter]

  @type metric_name :: binary

  @type metric_namespace :: binary

  @type metric_transformation :: [
    metric_name: metric_name,
    metric_namespace: metric_namespace,
    metric_value: metric_value,
  ]

  @type metric_transformations :: [metric_transformation]

  @type metric_value :: binary

  @type next_token :: binary

  @type operation_aborted_exception :: [
  ]

  @type order_by :: binary

  @type output_log_event :: [
    ingestion_time: timestamp,
    message: event_message,
    timestamp: timestamp,
  ]

  @type output_log_events :: [output_log_event]

  @type put_destination_policy_request :: [
    access_policy: access_policy,
    destination_name: destination_name,
  ]

  @type put_destination_request :: [
    destination_name: destination_name,
    role_arn: role_arn,
    target_arn: target_arn,
  ]

  @type put_destination_response :: [
    destination: destination,
  ]

  @type put_log_events_request :: [
    log_events: input_log_events,
    log_group_name: log_group_name,
    log_stream_name: log_stream_name,
    sequence_token: sequence_token,
  ]

  @type put_log_events_response :: [
    next_sequence_token: sequence_token,
    rejected_log_events_info: rejected_log_events_info,
  ]

  @type put_metric_filter_request :: [
    filter_name: filter_name,
    filter_pattern: filter_pattern,
    log_group_name: log_group_name,
    metric_transformations: metric_transformations,
  ]

  @type put_retention_policy_request :: [
    log_group_name: log_group_name,
    retention_in_days: days,
  ]

  @type put_subscription_filter_request :: [
    destination_arn: destination_arn,
    filter_name: filter_name,
    filter_pattern: filter_pattern,
    log_group_name: log_group_name,
    role_arn: role_arn,
  ]

  @type rejected_log_events_info :: [
    expired_log_event_end_index: log_event_index,
    too_new_log_event_start_index: log_event_index,
    too_old_log_event_end_index: log_event_index,
  ]

  @type resource_already_exists_exception :: [
  ]

  @type resource_not_found_exception :: [
  ]

  @type role_arn :: binary

  @type searched_log_stream :: [
    log_stream_name: log_stream_name,
    searched_completely: log_stream_searched_completely,
  ]

  @type searched_log_streams :: [searched_log_stream]

  @type sequence_token :: binary

  @type service_unavailable_exception :: [
  ]

  @type start_from_head :: boolean

  @type stored_bytes :: integer

  @type subscription_filter :: [
    creation_time: timestamp,
    destination_arn: destination_arn,
    filter_name: filter_name,
    filter_pattern: filter_pattern,
    log_group_name: log_group_name,
    role_arn: role_arn,
  ]

  @type subscription_filters :: [subscription_filter]

  @type target_arn :: binary

  @type test_event_messages :: [event_message]

  @type test_metric_filter_request :: [
    filter_pattern: filter_pattern,
    log_event_messages: test_event_messages,
  ]

  @type test_metric_filter_response :: [
    matches: metric_filter_matches,
  ]

  @type timestamp :: integer

  @type token :: binary

  @type value :: binary





  @doc """
  CreateLogGroup

  Creates a new log group with the specified name. The name of the log group
  must be unique within a region for an AWS account. You can create up to 500
  log groups per account.

  You must use the following guidelines when naming a log group:

  - Log group names can be between 1 and 512 characters long.

  - Allowed characters are a-z, A-Z, 0-9, '_' (underscore), '-' (hyphen), '/'
  (forward slash), and '.' (period).
  """

  @spec create_log_group(client :: ExAws.Logs.t, input :: create_log_group_request) :: ExAws.Request.JSON.response_t
  def create_log_group(client, input) do
    request(client, "CreateLogGroup", format_input(input))
  end

  @doc """
  Same as `create_log_group/2` but raise on error.
  """
  @spec create_log_group!(client :: ExAws.Logs.t, input :: create_log_group_request) :: ExAws.Request.JSON.success_t | no_return
  def create_log_group!(client, input) do
    case create_log_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateLogStream

  Creates a new log stream in the specified log group. The name of the log
  stream must be unique within the log group. There is no limit on the number
  of log streams that can exist in a log group.

  You must use the following guidelines when naming a log stream:

  - Log stream names can be between 1 and 512 characters long.

  - The ':' colon character is not allowed.
  """

  @spec create_log_stream(client :: ExAws.Logs.t, input :: create_log_stream_request) :: ExAws.Request.JSON.response_t
  def create_log_stream(client, input) do
    request(client, "CreateLogStream", format_input(input))
  end

  @doc """
  Same as `create_log_stream/2` but raise on error.
  """
  @spec create_log_stream!(client :: ExAws.Logs.t, input :: create_log_stream_request) :: ExAws.Request.JSON.success_t | no_return
  def create_log_stream!(client, input) do
    case create_log_stream(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteDestination

  Deletes the destination with the specified name and eventually disables all
  the subscription filters that publish to it. This will not delete the
  physical resource encapsulated by the destination.
  """

  @spec delete_destination(client :: ExAws.Logs.t, input :: delete_destination_request) :: ExAws.Request.JSON.response_t
  def delete_destination(client, input) do
    request(client, "DeleteDestination", format_input(input))
  end

  @doc """
  Same as `delete_destination/2` but raise on error.
  """
  @spec delete_destination!(client :: ExAws.Logs.t, input :: delete_destination_request) :: ExAws.Request.JSON.success_t | no_return
  def delete_destination!(client, input) do
    case delete_destination(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteLogGroup

  Deletes the log group with the specified name and permanently deletes all
  the archived log events associated with it.
  """

  @spec delete_log_group(client :: ExAws.Logs.t, input :: delete_log_group_request) :: ExAws.Request.JSON.response_t
  def delete_log_group(client, input) do
    request(client, "DeleteLogGroup", format_input(input))
  end

  @doc """
  Same as `delete_log_group/2` but raise on error.
  """
  @spec delete_log_group!(client :: ExAws.Logs.t, input :: delete_log_group_request) :: ExAws.Request.JSON.success_t | no_return
  def delete_log_group!(client, input) do
    case delete_log_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteLogStream

  Deletes a log stream and permanently deletes all the archived log events
  associated with it.
  """

  @spec delete_log_stream(client :: ExAws.Logs.t, input :: delete_log_stream_request) :: ExAws.Request.JSON.response_t
  def delete_log_stream(client, input) do
    request(client, "DeleteLogStream", format_input(input))
  end

  @doc """
  Same as `delete_log_stream/2` but raise on error.
  """
  @spec delete_log_stream!(client :: ExAws.Logs.t, input :: delete_log_stream_request) :: ExAws.Request.JSON.success_t | no_return
  def delete_log_stream!(client, input) do
    case delete_log_stream(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteMetricFilter

  Deletes a metric filter associated with the specified log group.
  """

  @spec delete_metric_filter(client :: ExAws.Logs.t, input :: delete_metric_filter_request) :: ExAws.Request.JSON.response_t
  def delete_metric_filter(client, input) do
    request(client, "DeleteMetricFilter", format_input(input))
  end

  @doc """
  Same as `delete_metric_filter/2` but raise on error.
  """
  @spec delete_metric_filter!(client :: ExAws.Logs.t, input :: delete_metric_filter_request) :: ExAws.Request.JSON.success_t | no_return
  def delete_metric_filter!(client, input) do
    case delete_metric_filter(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteRetentionPolicy

  Deletes the retention policy of the specified log group. Log events would
  not expire if they belong to log groups without a retention policy.
  """

  @spec delete_retention_policy(client :: ExAws.Logs.t, input :: delete_retention_policy_request) :: ExAws.Request.JSON.response_t
  def delete_retention_policy(client, input) do
    request(client, "DeleteRetentionPolicy", format_input(input))
  end

  @doc """
  Same as `delete_retention_policy/2` but raise on error.
  """
  @spec delete_retention_policy!(client :: ExAws.Logs.t, input :: delete_retention_policy_request) :: ExAws.Request.JSON.success_t | no_return
  def delete_retention_policy!(client, input) do
    case delete_retention_policy(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteSubscriptionFilter

  Deletes a subscription filter associated with the specified log group.
  """

  @spec delete_subscription_filter(client :: ExAws.Logs.t, input :: delete_subscription_filter_request) :: ExAws.Request.JSON.response_t
  def delete_subscription_filter(client, input) do
    request(client, "DeleteSubscriptionFilter", format_input(input))
  end

  @doc """
  Same as `delete_subscription_filter/2` but raise on error.
  """
  @spec delete_subscription_filter!(client :: ExAws.Logs.t, input :: delete_subscription_filter_request) :: ExAws.Request.JSON.success_t | no_return
  def delete_subscription_filter!(client, input) do
    case delete_subscription_filter(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeDestinations

  Returns all the destinations that are associated with the AWS account
  making the request. The list returned in the response is ASCII-sorted by
  destination name.

  By default, this operation returns up to 50 destinations. If there are more
  destinations to list, the response would contain a `

  nextToken` value in the response body. You can also limit the number of
  destinations returned in the response by specifying the `

  limit` parameter in the request.
  """

  @spec describe_destinations(client :: ExAws.Logs.t, input :: describe_destinations_request) :: ExAws.Request.JSON.response_t
  def describe_destinations(client, input) do
    request(client, "DescribeDestinations", format_input(input))
  end

  @doc """
  Same as `describe_destinations/2` but raise on error.
  """
  @spec describe_destinations!(client :: ExAws.Logs.t, input :: describe_destinations_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_destinations!(client, input) do
    case describe_destinations(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeLogGroups

  Returns all the log groups that are associated with the AWS account making
  the request. The list returned in the response is ASCII-sorted by log group
  name.

  By default, this operation returns up to 50 log groups. If there are more
  log groups to list, the response would contain a `

  nextToken` value in the response body. You can also limit the number of log
  groups returned in the response by specifying the `

  limit` parameter in the request.
  """

  @spec describe_log_groups(client :: ExAws.Logs.t, input :: describe_log_groups_request) :: ExAws.Request.JSON.response_t
  def describe_log_groups(client, input) do
    request(client, "DescribeLogGroups", format_input(input))
  end

  @doc """
  Same as `describe_log_groups/2` but raise on error.
  """
  @spec describe_log_groups!(client :: ExAws.Logs.t, input :: describe_log_groups_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_log_groups!(client, input) do
    case describe_log_groups(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeLogStreams

  Returns all the log streams that are associated with the specified log
  group. The list returned in the response is ASCII-sorted by log stream
  name.

  By default, this operation returns up to 50 log streams. If there are more
  log streams to list, the response would contain a `

  nextToken` value in the response body. You can also limit the number of log
  streams returned in the response by specifying the `

  limit` parameter in the request. This operation has a limit of five
  transactions per second, after which transactions are throttled.
  """

  @spec describe_log_streams(client :: ExAws.Logs.t, input :: describe_log_streams_request) :: ExAws.Request.JSON.response_t
  def describe_log_streams(client, input) do
    request(client, "DescribeLogStreams", format_input(input))
  end

  @doc """
  Same as `describe_log_streams/2` but raise on error.
  """
  @spec describe_log_streams!(client :: ExAws.Logs.t, input :: describe_log_streams_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_log_streams!(client, input) do
    case describe_log_streams(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeMetricFilters

  Returns all the metrics filters associated with the specified log group.
  The list returned in the response is ASCII-sorted by filter name.

  By default, this operation returns up to 50 metric filters. If there are
  more metric filters to list, the response would contain a `

  nextToken` value in the response body. You can also limit the number of
  metric filters returned in the response by specifying the `

  limit` parameter in the request.
  """

  @spec describe_metric_filters(client :: ExAws.Logs.t, input :: describe_metric_filters_request) :: ExAws.Request.JSON.response_t
  def describe_metric_filters(client, input) do
    request(client, "DescribeMetricFilters", format_input(input))
  end

  @doc """
  Same as `describe_metric_filters/2` but raise on error.
  """
  @spec describe_metric_filters!(client :: ExAws.Logs.t, input :: describe_metric_filters_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_metric_filters!(client, input) do
    case describe_metric_filters(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeSubscriptionFilters

  Returns all the subscription filters associated with the specified log
  group. The list returned in the response is ASCII-sorted by filter name.

  By default, this operation returns up to 50 subscription filters. If there
  are more subscription filters to list, the response would contain a `

  nextToken` value in the response body. You can also limit the number of
  subscription filters returned in the response by specifying the `

  limit` parameter in the request.
  """

  @spec describe_subscription_filters(client :: ExAws.Logs.t, input :: describe_subscription_filters_request) :: ExAws.Request.JSON.response_t
  def describe_subscription_filters(client, input) do
    request(client, "DescribeSubscriptionFilters", format_input(input))
  end

  @doc """
  Same as `describe_subscription_filters/2` but raise on error.
  """
  @spec describe_subscription_filters!(client :: ExAws.Logs.t, input :: describe_subscription_filters_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_subscription_filters!(client, input) do
    case describe_subscription_filters(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  FilterLogEvents

  Retrieves log events, optionally filtered by a filter pattern from the
  specified log group. You can provide an optional time range to filter the
  results on the event `

  timestamp`. You can limit the streams searched to an explicit list of `

  logStreamNames`.

  By default, this operation returns as much matching log events as can fit
  in a response size of 1MB, up to 10,000 log events, or all the events found
  within a time-bounded scan window. If the response includes a `

  nextToken`, then there is more data to search, and the search can be
  resumed with a new request providing the nextToken. The response will
  contain a list of `

  searchedLogStreams` that contains information about which streams were
  searched in the request and whether they have been searched completely or
  require further pagination. The `

  limit` parameter in the request. can be used to specify the maximum number
  of events to return in a page.
  """

  @spec filter_log_events(client :: ExAws.Logs.t, input :: filter_log_events_request) :: ExAws.Request.JSON.response_t
  def filter_log_events(client, input) do
    request(client, "FilterLogEvents", format_input(input))
  end

  @doc """
  Same as `filter_log_events/2` but raise on error.
  """
  @spec filter_log_events!(client :: ExAws.Logs.t, input :: filter_log_events_request) :: ExAws.Request.JSON.success_t | no_return
  def filter_log_events!(client, input) do
    case filter_log_events(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetLogEvents

  Retrieves log events from the specified log stream. You can provide an
  optional time range to filter the results on the event `

  timestamp`.

  By default, this operation returns as much log events as can fit in a
  response size of 1MB, up to 10,000 log events. The response will always
  include a `

  nextForwardToken` and a `

  nextBackwardToken` in the response body. You can use any of these tokens in
  subsequent `

  GetLogEvents` requests to paginate through events in either forward or
  backward direction. You can also limit the number of log events returned in
  the response by specifying the `

  limit` parameter in the request.
  """

  @spec get_log_events(client :: ExAws.Logs.t, input :: get_log_events_request) :: ExAws.Request.JSON.response_t
  def get_log_events(client, input) do
    request(client, "GetLogEvents", format_input(input))
  end

  @doc """
  Same as `get_log_events/2` but raise on error.
  """
  @spec get_log_events!(client :: ExAws.Logs.t, input :: get_log_events_request) :: ExAws.Request.JSON.success_t | no_return
  def get_log_events!(client, input) do
    case get_log_events(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  PutDestination

  Creates or updates a `Destination`. A destination encapsulates a physical
  resource (such as a Kinesis stream) and allows you to subscribe to a
  real-time stream of log events of a different account, ingested through `

  PutLogEvents` requests. Currently, the only supported physical resource is
  a Amazon Kinesis stream belonging to the same account as the destination.

  A destination controls what is written to its Amazon Kinesis stream through
  an access policy. By default, PutDestination does not set any access policy
  with the destination, which means a cross-account user will not be able to
  call `PutSubscriptionFilter` against this destination. To enable that, the
  destination owner must call `PutDestinationPolicy` after PutDestination.
  """

  @spec put_destination(client :: ExAws.Logs.t, input :: put_destination_request) :: ExAws.Request.JSON.response_t
  def put_destination(client, input) do
    request(client, "PutDestination", format_input(input))
  end

  @doc """
  Same as `put_destination/2` but raise on error.
  """
  @spec put_destination!(client :: ExAws.Logs.t, input :: put_destination_request) :: ExAws.Request.JSON.success_t | no_return
  def put_destination!(client, input) do
    case put_destination(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  PutDestinationPolicy

  Creates or updates an access policy associated with an existing
  `Destination`. An access policy is an [IAM policy
  document](http://docs.aws.amazon.com/IAM/latest/UserGuide/policies_overview.html)
  that is used to authorize claims to register a subscription filter against
  a given destination.
  """

  @spec put_destination_policy(client :: ExAws.Logs.t, input :: put_destination_policy_request) :: ExAws.Request.JSON.response_t
  def put_destination_policy(client, input) do
    request(client, "PutDestinationPolicy", format_input(input))
  end

  @doc """
  Same as `put_destination_policy/2` but raise on error.
  """
  @spec put_destination_policy!(client :: ExAws.Logs.t, input :: put_destination_policy_request) :: ExAws.Request.JSON.success_t | no_return
  def put_destination_policy!(client, input) do
    case put_destination_policy(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  PutLogEvents

  Uploads a batch of log events to the specified log stream.

  Every PutLogEvents request must include the `

  sequenceToken` obtained from the response of the previous request. An
  upload in a newly created log stream does not require a `

  sequenceToken`.

  The batch of events must satisfy the following constraints:

  - The maximum batch size is 1,048,576 bytes, and this size is calculated as
  the sum of all event messages in UTF-8, plus 26 bytes for each log event.

  - None of the log events in the batch can be more than 2 hours in the
  future.

  - None of the log events in the batch can be older than 14 days or the
  retention period of the log group.

  - The log events in the batch must be in chronological ordered by their `

  timestamp`.

  - The maximum number of log events in a batch is 10,000.
  """

  @spec put_log_events(client :: ExAws.Logs.t, input :: put_log_events_request) :: ExAws.Request.JSON.response_t
  def put_log_events(client, input) do
    request(client, "PutLogEvents", format_input(input))
  end

  @doc """
  Same as `put_log_events/2` but raise on error.
  """
  @spec put_log_events!(client :: ExAws.Logs.t, input :: put_log_events_request) :: ExAws.Request.JSON.success_t | no_return
  def put_log_events!(client, input) do
    case put_log_events(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  PutMetricFilter

  Creates or updates a metric filter and associates it with the specified log
  group. Metric filters allow you to configure rules to extract metric data
  from log events ingested through `

  PutLogEvents` requests.

  The maximum number of metric filters that can be associated with a log
  group is 100.
  """

  @spec put_metric_filter(client :: ExAws.Logs.t, input :: put_metric_filter_request) :: ExAws.Request.JSON.response_t
  def put_metric_filter(client, input) do
    request(client, "PutMetricFilter", format_input(input))
  end

  @doc """
  Same as `put_metric_filter/2` but raise on error.
  """
  @spec put_metric_filter!(client :: ExAws.Logs.t, input :: put_metric_filter_request) :: ExAws.Request.JSON.success_t | no_return
  def put_metric_filter!(client, input) do
    case put_metric_filter(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  PutRetentionPolicy

  Sets the retention of the specified log group. A retention policy allows
  you to configure the number of days you want to retain log events in the
  specified log group.
  """

  @spec put_retention_policy(client :: ExAws.Logs.t, input :: put_retention_policy_request) :: ExAws.Request.JSON.response_t
  def put_retention_policy(client, input) do
    request(client, "PutRetentionPolicy", format_input(input))
  end

  @doc """
  Same as `put_retention_policy/2` but raise on error.
  """
  @spec put_retention_policy!(client :: ExAws.Logs.t, input :: put_retention_policy_request) :: ExAws.Request.JSON.success_t | no_return
  def put_retention_policy!(client, input) do
    case put_retention_policy(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  PutSubscriptionFilter

  Creates or updates a subscription filter and associates it with the
  specified log group. Subscription filters allow you to subscribe to a
  real-time stream of log events ingested through `

  PutLogEvents` requests and have them delivered to a specific destination.
  Currently, the supported destinations are:

  - A Amazon Kinesis stream belonging to the same account as the subscription
  filter, for same-account delivery.

  - A logical destination (used via an ARN of `Destination`) belonging to a
  different account, for cross-account delivery.

  Currently there can only be one subscription filter associated with a log
  group.
  """

  @spec put_subscription_filter(client :: ExAws.Logs.t, input :: put_subscription_filter_request) :: ExAws.Request.JSON.response_t
  def put_subscription_filter(client, input) do
    request(client, "PutSubscriptionFilter", format_input(input))
  end

  @doc """
  Same as `put_subscription_filter/2` but raise on error.
  """
  @spec put_subscription_filter!(client :: ExAws.Logs.t, input :: put_subscription_filter_request) :: ExAws.Request.JSON.success_t | no_return
  def put_subscription_filter!(client, input) do
    case put_subscription_filter(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  TestMetricFilter

  Tests the filter pattern of a metric filter against a sample of log event
  messages. You can use this operation to validate the correctness of a
  metric filter pattern.
  """

  @spec test_metric_filter(client :: ExAws.Logs.t, input :: test_metric_filter_request) :: ExAws.Request.JSON.response_t
  def test_metric_filter(client, input) do
    request(client, "TestMetricFilter", format_input(input))
  end

  @doc """
  Same as `test_metric_filter/2` but raise on error.
  """
  @spec test_metric_filter!(client :: ExAws.Logs.t, input :: test_metric_filter_request) :: ExAws.Request.JSON.success_t | no_return
  def test_metric_filter!(client, input) do
    case test_metric_filter(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  defp request(%{__struct__: client_module} = client, action, input) do
    apply(client_module, :request, [client, action, input])
  end
end
