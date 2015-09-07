defmodule ExAws.Monitoring.Core do
  @actions [
    "DeleteAlarms",
    "DescribeAlarmHistory",
    "DescribeAlarms",
    "DescribeAlarmsForMetric",
    "DisableAlarmActions",
    "EnableAlarmActions",
    "GetMetricStatistics",
    "ListMetrics",
    "PutMetricAlarm",
    "PutMetricData",
    "SetAlarmState"]

  @moduledoc """
  ## Amazon CloudWatch

  This is the *Amazon CloudWatch API Reference*. This guide provides detailed
  information about Amazon CloudWatch actions, data types, parameters, and
  errors. For detailed information about Amazon CloudWatch features and their
  associated API calls, go to the [Amazon CloudWatch Developer
  Guide](http://docs.aws.amazon.com/AmazonCloudWatch/latest/DeveloperGuide).

  Amazon CloudWatch is a web service that enables you to publish, monitor,
  and manage various metrics, as well as configure alarm actions based on
  data from metrics. For more information about this product go to
  [http://aws.amazon.com/cloudwatch](http://aws.amazon.com/cloudwatch).

  For information about the namespace, metric names, and dimensions that
  other Amazon Web Services products use to send metrics to Cloudwatch, go to
  [Amazon CloudWatch Metrics, Namespaces, and Dimensions
  Reference](http://docs.aws.amazon.com/AmazonCloudWatch/latest/DeveloperGuide/CW_Support_For_AWS.html)
  in the *Amazon CloudWatch Developer Guide*.

  Use the following links to get started using the *Amazon CloudWatch API
  Reference*:

  -
  [Actions](http://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_Operations.html):
  An alphabetical list of all Amazon CloudWatch actions.

  - [Data
  Types](http://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_Types.html):
  An alphabetical list of all Amazon CloudWatch data types.

  - [Common
  Parameters](http://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/CommonParameters.html):
  Parameters that all Query actions can use.

  - [Common
  Errors](http://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/CommonErrors.html):
  Client and server errors that all actions can return.

  - [Regions and
  Endpoints](http://docs.aws.amazon.com/general/latest/gr/index.html?rande.html):
  Itemized regions and endpoints for all AWS products.

  - [WSDL
  Location](http://monitoring.amazonaws.com/doc/2010-08-01/CloudWatch.wsdl):
  http://monitoring.amazonaws.com/doc/2010-08-01/CloudWatch.wsdl

  In addition to using the Amazon CloudWatch API, you can also use the
  following SDKs and third-party libraries to access Amazon CloudWatch
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

  @type action_prefix :: binary

  @type actions_enabled :: boolean

  @type alarm_arn :: binary

  @type alarm_description :: binary

  @type alarm_history_item :: [
    alarm_name: alarm_name,
    history_data: history_data,
    history_item_type: history_item_type,
    history_summary: history_summary,
    timestamp: timestamp,
  ]

  @type alarm_history_items :: [alarm_history_item]

  @type alarm_name :: binary

  @type alarm_name_prefix :: binary

  @type alarm_names :: [alarm_name]

  @type aws_query_error_message :: binary

  @type comparison_operator :: binary

  @type datapoint :: [
    average: datapoint_value,
    maximum: datapoint_value,
    minimum: datapoint_value,
    sample_count: datapoint_value,
    sum: datapoint_value,
    timestamp: timestamp,
    unit: standard_unit,
  ]

  @type datapoint_value :: float

  @type datapoints :: [datapoint]

  @type delete_alarms_input :: [
    alarm_names: alarm_names,
  ]

  @type describe_alarm_history_input :: [
    alarm_name: alarm_name,
    end_date: timestamp,
    history_item_type: history_item_type,
    max_records: max_records,
    next_token: next_token,
    start_date: timestamp,
  ]

  @type describe_alarm_history_output :: [
    alarm_history_items: alarm_history_items,
    next_token: next_token,
  ]

  @type describe_alarms_for_metric_input :: [
    dimensions: dimensions,
    metric_name: metric_name,
    namespace: namespace,
    period: period,
    statistic: statistic,
    unit: standard_unit,
  ]

  @type describe_alarms_for_metric_output :: [
    metric_alarms: metric_alarms,
  ]

  @type describe_alarms_input :: [
    action_prefix: action_prefix,
    alarm_name_prefix: alarm_name_prefix,
    alarm_names: alarm_names,
    max_records: max_records,
    next_token: next_token,
    state_value: state_value,
  ]

  @type describe_alarms_output :: [
    metric_alarms: metric_alarms,
    next_token: next_token,
  ]

  @type dimension :: [
    name: dimension_name,
    value: dimension_value,
  ]

  @type dimension_filter :: [
    name: dimension_name,
    value: dimension_value,
  ]

  @type dimension_filters :: [dimension_filter]

  @type dimension_name :: binary

  @type dimension_value :: binary

  @type dimensions :: [dimension]

  @type disable_alarm_actions_input :: [
    alarm_names: alarm_names,
  ]

  @type enable_alarm_actions_input :: [
    alarm_names: alarm_names,
  ]

  @type error_message :: binary

  @type evaluation_periods :: integer

  @type fault_description :: binary

  @type get_metric_statistics_input :: [
    dimensions: dimensions,
    end_time: timestamp,
    metric_name: metric_name,
    namespace: namespace,
    period: period,
    start_time: timestamp,
    statistics: statistics,
    unit: standard_unit,
  ]

  @type get_metric_statistics_output :: [
    datapoints: datapoints,
    label: metric_label,
  ]

  @type history_data :: binary

  @type history_item_type :: binary

  @type history_summary :: binary

  @type internal_service_fault :: [
    message: fault_description,
  ]

  @type invalid_format_fault :: [
    message: error_message,
  ]

  @type invalid_next_token :: [
    message: error_message,
  ]

  @type invalid_parameter_combination_exception :: [
    message: aws_query_error_message,
  ]

  @type invalid_parameter_value_exception :: [
    message: aws_query_error_message,
  ]

  @type limit_exceeded_fault :: [
    message: error_message,
  ]

  @type list_metrics_input :: [
    dimensions: dimension_filters,
    metric_name: metric_name,
    namespace: namespace,
    next_token: next_token,
  ]

  @type list_metrics_output :: [
    metrics: metrics,
    next_token: next_token,
  ]

  @type max_records :: integer

  @type metric :: [
    dimensions: dimensions,
    metric_name: metric_name,
    namespace: namespace,
  ]

  @type metric_alarm :: [
    actions_enabled: actions_enabled,
    alarm_actions: resource_list,
    alarm_arn: alarm_arn,
    alarm_configuration_updated_timestamp: timestamp,
    alarm_description: alarm_description,
    alarm_name: alarm_name,
    comparison_operator: comparison_operator,
    dimensions: dimensions,
    evaluation_periods: evaluation_periods,
    insufficient_data_actions: resource_list,
    metric_name: metric_name,
    namespace: namespace,
    ok_actions: resource_list,
    period: period,
    state_reason: state_reason,
    state_reason_data: state_reason_data,
    state_updated_timestamp: timestamp,
    state_value: state_value,
    statistic: statistic,
    threshold: threshold,
    unit: standard_unit,
  ]

  @type metric_alarms :: [metric_alarm]

  @type metric_data :: [metric_datum]

  @type metric_datum :: [
    dimensions: dimensions,
    metric_name: metric_name,
    statistic_values: statistic_set,
    timestamp: timestamp,
    unit: standard_unit,
    value: datapoint_value,
  ]

  @type metric_label :: binary

  @type metric_name :: binary

  @type metrics :: [metric]

  @type missing_required_parameter_exception :: [
    message: aws_query_error_message,
  ]

  @type namespace :: binary

  @type next_token :: binary

  @type period :: integer

  @type put_metric_alarm_input :: [
    actions_enabled: actions_enabled,
    alarm_actions: resource_list,
    alarm_description: alarm_description,
    alarm_name: alarm_name,
    comparison_operator: comparison_operator,
    dimensions: dimensions,
    evaluation_periods: evaluation_periods,
    insufficient_data_actions: resource_list,
    metric_name: metric_name,
    namespace: namespace,
    ok_actions: resource_list,
    period: period,
    statistic: statistic,
    threshold: threshold,
    unit: standard_unit,
  ]

  @type put_metric_data_input :: [
    metric_data: metric_data,
    namespace: namespace,
  ]

  @type resource_list :: [resource_name]

  @type resource_name :: binary

  @type resource_not_found :: [
    message: error_message,
  ]

  @type set_alarm_state_input :: [
    alarm_name: alarm_name,
    state_reason: state_reason,
    state_reason_data: state_reason_data,
    state_value: state_value,
  ]

  @type standard_unit :: binary

  @type state_reason :: binary

  @type state_reason_data :: binary

  @type state_value :: binary

  @type statistic :: binary

  @type statistic_set :: [
    maximum: datapoint_value,
    minimum: datapoint_value,
    sample_count: datapoint_value,
    sum: datapoint_value,
  ]

  @type statistics :: [statistic]

  @type threshold :: float

  @type timestamp :: integer




  @doc """
  DeleteAlarms

  Deletes all specified alarms. In the event of an error, no alarms are
  deleted.
  """

  @spec delete_alarms(client :: ExAws.Monitoring.t, input :: delete_alarms_input) :: ExAws.Request.Query.response_t
  def delete_alarms(client, input) do
    request(client, "/", "DeleteAlarms", input)
  end

  @doc """
  Same as `delete_alarms/2` but raise on error.
  """
  @spec delete_alarms!(client :: ExAws.Monitoring.t, input :: delete_alarms_input) :: ExAws.Request.Query.success_t | no_return
  def delete_alarms!(client, input) do
    case delete_alarms(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeAlarmHistory

  Retrieves history for the specified alarm. Filter alarms by date range or
  item type. If an alarm name is not specified, Amazon CloudWatch returns
  histories for all of the owner's alarms.
  """

  @spec describe_alarm_history(client :: ExAws.Monitoring.t, input :: describe_alarm_history_input) :: ExAws.Request.Query.response_t
  def describe_alarm_history(client, input) do
    request(client, "/", "DescribeAlarmHistory", input)
  end

  @doc """
  Same as `describe_alarm_history/2` but raise on error.
  """
  @spec describe_alarm_history!(client :: ExAws.Monitoring.t, input :: describe_alarm_history_input) :: ExAws.Request.Query.success_t | no_return
  def describe_alarm_history!(client, input) do
    case describe_alarm_history(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeAlarms

  Retrieves alarms with the specified names. If no name is specified, all
  alarms for the user are returned. Alarms can be retrieved by using only a
  prefix for the alarm name, the alarm state, or a prefix for any action.
  """

  @spec describe_alarms(client :: ExAws.Monitoring.t, input :: describe_alarms_input) :: ExAws.Request.Query.response_t
  def describe_alarms(client, input) do
    request(client, "/", "DescribeAlarms", input)
  end

  @doc """
  Same as `describe_alarms/2` but raise on error.
  """
  @spec describe_alarms!(client :: ExAws.Monitoring.t, input :: describe_alarms_input) :: ExAws.Request.Query.success_t | no_return
  def describe_alarms!(client, input) do
    case describe_alarms(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeAlarmsForMetric

  Retrieves all alarms for a single metric. Specify a statistic, period, or
  unit to filter the set of alarms further.
  """

  @spec describe_alarms_for_metric(client :: ExAws.Monitoring.t, input :: describe_alarms_for_metric_input) :: ExAws.Request.Query.response_t
  def describe_alarms_for_metric(client, input) do
    request(client, "/", "DescribeAlarmsForMetric", input)
  end

  @doc """
  Same as `describe_alarms_for_metric/2` but raise on error.
  """
  @spec describe_alarms_for_metric!(client :: ExAws.Monitoring.t, input :: describe_alarms_for_metric_input) :: ExAws.Request.Query.success_t | no_return
  def describe_alarms_for_metric!(client, input) do
    case describe_alarms_for_metric(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DisableAlarmActions

  Disables actions for the specified alarms. When an alarm's actions are
  disabled the alarm's state may change, but none of the alarm's actions will
  execute.
  """

  @spec disable_alarm_actions(client :: ExAws.Monitoring.t, input :: disable_alarm_actions_input) :: ExAws.Request.Query.response_t
  def disable_alarm_actions(client, input) do
    request(client, "/", "DisableAlarmActions", input)
  end

  @doc """
  Same as `disable_alarm_actions/2` but raise on error.
  """
  @spec disable_alarm_actions!(client :: ExAws.Monitoring.t, input :: disable_alarm_actions_input) :: ExAws.Request.Query.success_t | no_return
  def disable_alarm_actions!(client, input) do
    case disable_alarm_actions(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  EnableAlarmActions

  Enables actions for the specified alarms.
  """

  @spec enable_alarm_actions(client :: ExAws.Monitoring.t, input :: enable_alarm_actions_input) :: ExAws.Request.Query.response_t
  def enable_alarm_actions(client, input) do
    request(client, "/", "EnableAlarmActions", input)
  end

  @doc """
  Same as `enable_alarm_actions/2` but raise on error.
  """
  @spec enable_alarm_actions!(client :: ExAws.Monitoring.t, input :: enable_alarm_actions_input) :: ExAws.Request.Query.success_t | no_return
  def enable_alarm_actions!(client, input) do
    case enable_alarm_actions(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetMetricStatistics

  Gets statistics for the specified metric.

  The maximum number of data points returned from a single
  `GetMetricStatistics` request is 1,440, wereas the maximum number of data
  points that can be queried is 50,850. If you make a request that generates
  more than 1,440 data points, Amazon CloudWatch returns an error. In such a
  case, you can alter the request by narrowing the specified time range or
  increasing the specified period. Alternatively, you can make multiple
  requests across adjacent time ranges.

  Amazon CloudWatch aggregates data points based on the length of the
  `period` that you specify. For example, if you request statistics with a
  one-minute granularity, Amazon CloudWatch aggregates data points with time
  stamps that fall within the same one-minute period. In such a case, the
  data points queried can greatly outnumber the data points returned.

  The following examples show various statistics allowed by the data point
  query maximum of 50,850 when you call `GetMetricStatistics` on Amazon EC2
  instances with detailed (one-minute) monitoring enabled:

  - Statistics for up to 400 instances for a span of one hour

  - Statistics for up to 35 instances over a span of 24 hours

  - Statistics for up to 2 instances over a span of 2 weeks

  For information about the namespace, metric names, and dimensions that
  other Amazon Web Services products use to send metrics to Cloudwatch, go to
  [Amazon CloudWatch Metrics, Namespaces, and Dimensions
  Reference](http://docs.aws.amazon.com/AmazonCloudWatch/latest/DeveloperGuide/CW_Support_For_AWS.html)
  in the *Amazon CloudWatch Developer Guide*.
  """

  @spec get_metric_statistics(client :: ExAws.Monitoring.t, input :: get_metric_statistics_input) :: ExAws.Request.Query.response_t
  def get_metric_statistics(client, input) do
    request(client, "/", "GetMetricStatistics", input)
  end

  @doc """
  Same as `get_metric_statistics/2` but raise on error.
  """
  @spec get_metric_statistics!(client :: ExAws.Monitoring.t, input :: get_metric_statistics_input) :: ExAws.Request.Query.success_t | no_return
  def get_metric_statistics!(client, input) do
    case get_metric_statistics(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListMetrics

  Returns a list of valid metrics stored for the AWS account owner. Returned
  metrics can be used with `GetMetricStatistics` to obtain statistical data
  for a given metric.
  """

  @spec list_metrics(client :: ExAws.Monitoring.t, input :: list_metrics_input) :: ExAws.Request.Query.response_t
  def list_metrics(client, input) do
    request(client, "/", "ListMetrics", input)
  end

  @doc """
  Same as `list_metrics/2` but raise on error.
  """
  @spec list_metrics!(client :: ExAws.Monitoring.t, input :: list_metrics_input) :: ExAws.Request.Query.success_t | no_return
  def list_metrics!(client, input) do
    case list_metrics(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  PutMetricAlarm

  Creates or updates an alarm and associates it with the specified Amazon
  CloudWatch metric. Optionally, this operation can associate one or more
  Amazon Simple Notification Service resources with the alarm.

  When this operation creates an alarm, the alarm state is immediately set to
  `INSUFFICIENT_DATA`. The alarm is evaluated and its `StateValue` is set
  appropriately. Any actions associated with the `StateValue` is then
  executed.
  """

  @spec put_metric_alarm(client :: ExAws.Monitoring.t, input :: put_metric_alarm_input) :: ExAws.Request.Query.response_t
  def put_metric_alarm(client, input) do
    request(client, "/", "PutMetricAlarm", input)
  end

  @doc """
  Same as `put_metric_alarm/2` but raise on error.
  """
  @spec put_metric_alarm!(client :: ExAws.Monitoring.t, input :: put_metric_alarm_input) :: ExAws.Request.Query.success_t | no_return
  def put_metric_alarm!(client, input) do
    case put_metric_alarm(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  PutMetricData

  Publishes metric data points to Amazon CloudWatch. Amazon Cloudwatch
  associates the data points with the specified metric. If the specified
  metric does not exist, Amazon CloudWatch creates the metric. It can take up
  to fifteen minutes for a new metric to appear in calls to the `ListMetrics`
  action.

  The size of a <function>PutMetricData</function> request is limited to 8 KB
  for HTTP GET requests and 40 KB for HTTP POST requests.

  ** Although the `Value` parameter accepts numbers of type `Double`, Amazon
  CloudWatch truncates values with very large exponents. Values with base-10
  exponents greater than 126 (1 x 10^126) are truncated. Likewise, values
  with base-10 exponents less than -130 (1 x 10^-130) are also truncated. **
  Data that is timestamped 24 hours or more in the past may take in excess of
  48 hours to become available from submission time using
  `GetMetricStatistics`.
  """

  @spec put_metric_data(client :: ExAws.Monitoring.t, input :: put_metric_data_input) :: ExAws.Request.Query.response_t
  def put_metric_data(client, input) do
    request(client, "/", "PutMetricData", input)
  end

  @doc """
  Same as `put_metric_data/2` but raise on error.
  """
  @spec put_metric_data!(client :: ExAws.Monitoring.t, input :: put_metric_data_input) :: ExAws.Request.Query.success_t | no_return
  def put_metric_data!(client, input) do
    case put_metric_data(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  SetAlarmState

  Temporarily sets the state of an alarm. When the updated `StateValue`
  differs from the previous value, the action configured for the appropriate
  state is invoked. This is not a permanent change. The next periodic alarm
  check (in about a minute) will set the alarm to its actual state.
  """

  @spec set_alarm_state(client :: ExAws.Monitoring.t, input :: set_alarm_state_input) :: ExAws.Request.Query.response_t
  def set_alarm_state(client, input) do
    request(client, "/", "SetAlarmState", input)
  end

  @doc """
  Same as `set_alarm_state/2` but raise on error.
  """
  @spec set_alarm_state!(client :: ExAws.Monitoring.t, input :: set_alarm_state_input) :: ExAws.Request.Query.success_t | no_return
  def set_alarm_state!(client, input) do
    case set_alarm_state(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  defp request(%{__struct__: client_module} = client, uri, action, input) do
    apply(client_module, :request, [client, uri, action, input])
  end
end
