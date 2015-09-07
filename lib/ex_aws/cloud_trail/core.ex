defmodule ExAws.CloudTrail.Core do
  import ExAws.Core.JSON, only: [format_input: 1]
  @actions [
    "CreateTrail",
    "DeleteTrail",
    "DescribeTrails",
    "GetTrailStatus",
    "LookupEvents",
    "StartLogging",
    "StopLogging",
    "UpdateTrail"]

  @moduledoc """
  ## AWS CloudTrail

  AWS CloudTrail

  This is the CloudTrail API Reference. It provides descriptions of actions,
  data types, common parameters, and common errors for CloudTrail.

  CloudTrail is a web service that records AWS API calls for your AWS account
  and delivers log files to an Amazon S3 bucket. The recorded information
  includes the identity of the user, the start time of the AWS API call, the
  source IP address, the request parameters, and the response elements
  returned by the service.

  Note: As an alternative to using the API, you can use one of the AWS SDKs,
  which consist of libraries and sample code for various programming
  languages and platforms (Java, Ruby, .NET, iOS, Android, etc.). The SDKs
  provide a convenient way to create programmatic access to AWSCloudTrail.
  For example, the SDKs take care of cryptographically signing requests,
  managing errors, and retrying requests automatically. For information about
  the AWS SDKs, including how to download and install them, see the [Tools
  for Amazon Web Services page](http://aws.amazon.com/tools/). See the
  CloudTrail User Guide for information about the data that is included with
  each AWS API call listed in the log files.
  """

  @type cloud_watch_logs_delivery_unavailable_exception :: [
  ]

  @type create_trail_request :: [
    cloud_watch_logs_log_group_arn: binary,
    cloud_watch_logs_role_arn: binary,
    include_global_service_events: boolean,
    name: binary,
    s3_bucket_name: binary,
    s3_key_prefix: binary,
    sns_topic_name: binary,
  ]

  @type create_trail_response :: [
    cloud_watch_logs_log_group_arn: binary,
    cloud_watch_logs_role_arn: binary,
    include_global_service_events: boolean,
    name: binary,
    s3_bucket_name: binary,
    s3_key_prefix: binary,
    sns_topic_name: binary,
  ]

  @type date :: integer

  @type delete_trail_request :: [
    name: binary,
  ]

  @type delete_trail_response :: [
  ]

  @type describe_trails_request :: [
    trail_name_list: trail_name_list,
  ]

  @type describe_trails_response :: [
    trail_list: trail_list,
  ]

  @type event :: [
    cloud_trail_event: binary,
    event_id: binary,
    event_name: binary,
    event_time: date,
    resources: resource_list,
    username: binary,
  ]

  @type events_list :: [event]

  @type get_trail_status_request :: [
    name: binary,
  ]

  @type get_trail_status_response :: [
    is_logging: boolean,
    latest_cloud_watch_logs_delivery_error: binary,
    latest_cloud_watch_logs_delivery_time: date,
    latest_delivery_error: binary,
    latest_delivery_time: date,
    latest_notification_error: binary,
    latest_notification_time: date,
    start_logging_time: date,
    stop_logging_time: date,
  ]

  @type insufficient_s3_bucket_policy_exception :: [
  ]

  @type insufficient_sns_topic_policy_exception :: [
  ]

  @type invalid_cloud_watch_logs_log_group_arn_exception :: [
  ]

  @type invalid_cloud_watch_logs_role_arn_exception :: [
  ]

  @type invalid_lookup_attributes_exception :: [
  ]

  @type invalid_max_results_exception :: [
  ]

  @type invalid_next_token_exception :: [
  ]

  @type invalid_s3_bucket_name_exception :: [
  ]

  @type invalid_s3_prefix_exception :: [
  ]

  @type invalid_sns_topic_name_exception :: [
  ]

  @type invalid_time_range_exception :: [
  ]

  @type invalid_trail_name_exception :: [
  ]

  @type lookup_attribute :: [
    attribute_key: lookup_attribute_key,
    attribute_value: binary,
  ]

  @type lookup_attribute_key :: binary

  @type lookup_attributes_list :: [lookup_attribute]

  @type lookup_events_request :: [
    end_time: date,
    lookup_attributes: lookup_attributes_list,
    max_results: max_results,
    next_token: next_token,
    start_time: date,
  ]

  @type lookup_events_response :: [
    events: events_list,
    next_token: next_token,
  ]

  @type max_results :: integer

  @type maximum_number_of_trails_exceeded_exception :: [
  ]

  @type next_token :: binary

  @type resource :: [
    resource_name: binary,
    resource_type: binary,
  ]

  @type resource_list :: [resource]

  @type s3_bucket_does_not_exist_exception :: [
  ]

  @type start_logging_request :: [
    name: binary,
  ]

  @type start_logging_response :: [
  ]

  @type stop_logging_request :: [
    name: binary,
  ]

  @type stop_logging_response :: [
  ]

  @type trail :: [
    cloud_watch_logs_log_group_arn: binary,
    cloud_watch_logs_role_arn: binary,
    include_global_service_events: boolean,
    name: binary,
    s3_bucket_name: binary,
    s3_key_prefix: binary,
    sns_topic_name: binary,
  ]

  @type trail_already_exists_exception :: [
  ]

  @type trail_list :: [trail]

  @type trail_name_list :: [binary]

  @type trail_not_found_exception :: [
  ]

  @type update_trail_request :: [
    cloud_watch_logs_log_group_arn: binary,
    cloud_watch_logs_role_arn: binary,
    include_global_service_events: boolean,
    name: binary,
    s3_bucket_name: binary,
    s3_key_prefix: binary,
    sns_topic_name: binary,
  ]

  @type update_trail_response :: [
    cloud_watch_logs_log_group_arn: binary,
    cloud_watch_logs_role_arn: binary,
    include_global_service_events: boolean,
    name: binary,
    s3_bucket_name: binary,
    s3_key_prefix: binary,
    sns_topic_name: binary,
  ]





  @doc """
  CreateTrail

  From the command line, use `create-subscription`.

  Creates a trail that specifies the settings for delivery of log data to an
  Amazon S3 bucket.
  """

  @spec create_trail(client :: ExAws.CloudTrail.t, input :: create_trail_request) :: ExAws.Request.JSON.response_t
  def create_trail(client, input) do
    request(client, "CreateTrail", format_input(input))
  end

  @doc """
  Same as `create_trail/2` but raise on error.
  """
  @spec create_trail!(client :: ExAws.CloudTrail.t, input :: create_trail_request) :: ExAws.Request.JSON.success_t | no_return
  def create_trail!(client, input) do
    case create_trail(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteTrail

  Deletes a trail.
  """

  @spec delete_trail(client :: ExAws.CloudTrail.t, input :: delete_trail_request) :: ExAws.Request.JSON.response_t
  def delete_trail(client, input) do
    request(client, "DeleteTrail", format_input(input))
  end

  @doc """
  Same as `delete_trail/2` but raise on error.
  """
  @spec delete_trail!(client :: ExAws.CloudTrail.t, input :: delete_trail_request) :: ExAws.Request.JSON.success_t | no_return
  def delete_trail!(client, input) do
    case delete_trail(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeTrails

  Retrieves settings for the trail associated with the current region for
  your account.
  """

  @spec describe_trails(client :: ExAws.CloudTrail.t, input :: describe_trails_request) :: ExAws.Request.JSON.response_t
  def describe_trails(client, input) do
    request(client, "DescribeTrails", format_input(input))
  end

  @doc """
  Same as `describe_trails/2` but raise on error.
  """
  @spec describe_trails!(client :: ExAws.CloudTrail.t, input :: describe_trails_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_trails!(client, input) do
    case describe_trails(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetTrailStatus

  Returns a JSON-formatted list of information about the specified trail.
  Fields include information on delivery errors, Amazon SNS and Amazon S3
  errors, and start and stop logging times for each trail.
  """

  @spec get_trail_status(client :: ExAws.CloudTrail.t, input :: get_trail_status_request) :: ExAws.Request.JSON.response_t
  def get_trail_status(client, input) do
    request(client, "GetTrailStatus", format_input(input))
  end

  @doc """
  Same as `get_trail_status/2` but raise on error.
  """
  @spec get_trail_status!(client :: ExAws.CloudTrail.t, input :: get_trail_status_request) :: ExAws.Request.JSON.success_t | no_return
  def get_trail_status!(client, input) do
    case get_trail_status(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  LookupEvents

  Looks up API activity events captured by CloudTrail that create, update, or
  delete resources in your account. Events for a region can be looked up for
  the times in which you had CloudTrail turned on in that region during the
  last seven days. Lookup supports five different attributes: time range
  (defined by a start time and end time), user name, event name, resource
  type, and resource name. All attributes are optional. The maximum number of
  attributes that can be specified in any one lookup request are time range
  and one other attribute. The default number of results returned is 10, with
  a maximum of 50 possible. The response includes a token that you can use to
  get the next page of results. The rate of lookup requests is limited to one
  per second per account.

  **Events that occurred during the selected time range will not be available
  for lookup if CloudTrail logging was not enabled when the events
  occurred.**
  """

  @spec lookup_events(client :: ExAws.CloudTrail.t, input :: lookup_events_request) :: ExAws.Request.JSON.response_t
  def lookup_events(client, input) do
    request(client, "LookupEvents", format_input(input))
  end

  @doc """
  Same as `lookup_events/2` but raise on error.
  """
  @spec lookup_events!(client :: ExAws.CloudTrail.t, input :: lookup_events_request) :: ExAws.Request.JSON.success_t | no_return
  def lookup_events!(client, input) do
    case lookup_events(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  StartLogging

  Starts the recording of AWS API calls and log file delivery for a trail.
  """

  @spec start_logging(client :: ExAws.CloudTrail.t, input :: start_logging_request) :: ExAws.Request.JSON.response_t
  def start_logging(client, input) do
    request(client, "StartLogging", format_input(input))
  end

  @doc """
  Same as `start_logging/2` but raise on error.
  """
  @spec start_logging!(client :: ExAws.CloudTrail.t, input :: start_logging_request) :: ExAws.Request.JSON.success_t | no_return
  def start_logging!(client, input) do
    case start_logging(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  StopLogging

  Suspends the recording of AWS API calls and log file delivery for the
  specified trail. Under most circumstances, there is no need to use this
  action. You can update a trail without stopping it first. This action is
  the only way to stop recording.
  """

  @spec stop_logging(client :: ExAws.CloudTrail.t, input :: stop_logging_request) :: ExAws.Request.JSON.response_t
  def stop_logging(client, input) do
    request(client, "StopLogging", format_input(input))
  end

  @doc """
  Same as `stop_logging/2` but raise on error.
  """
  @spec stop_logging!(client :: ExAws.CloudTrail.t, input :: stop_logging_request) :: ExAws.Request.JSON.success_t | no_return
  def stop_logging!(client, input) do
    case stop_logging(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateTrail

  From the command line, use `update-subscription`.

  Updates the settings that specify delivery of log files. Changes to a trail
  do not require stopping the CloudTrail service. Use this action to
  designate an existing bucket for log delivery. If the existing bucket has
  previously been a target for CloudTrail log files, an IAM policy exists for
  the bucket.
  """

  @spec update_trail(client :: ExAws.CloudTrail.t, input :: update_trail_request) :: ExAws.Request.JSON.response_t
  def update_trail(client, input) do
    request(client, "UpdateTrail", format_input(input))
  end

  @doc """
  Same as `update_trail/2` but raise on error.
  """
  @spec update_trail!(client :: ExAws.CloudTrail.t, input :: update_trail_request) :: ExAws.Request.JSON.success_t | no_return
  def update_trail!(client, input) do
    case update_trail(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  defp request(%{__struct__: client_module} = client, action, input) do
    apply(client_module, :request, [client, action, input])
  end
end
