defmodule ExAws.CloudTrail.Core do
  @actions [
    "CreateTrail",
    "DeleteTrail",
    "DescribeTrails",
    "GetTrailStatus",
    "LookupEvents",
    "StartLogging",
    "StopLogging",
    "UpdateTrail"]


  @doc """
  CreateTrail

  From the command line, use `create-subscription`.

  Creates a trail that specifies the settings for delivery of log data to an
  Amazon S3 bucket.
  """
  def create_trail(client, input) do
    request(client, "CreateTrail", input)
  end

  @doc """
  DeleteTrail

  Deletes a trail.
  """
  def delete_trail(client, input) do
    request(client, "DeleteTrail", input)
  end

  @doc """
  DescribeTrails

  Retrieves settings for the trail associated with the current region for
  your account.
  """
  def describe_trails(client, input) do
    request(client, "DescribeTrails", input)
  end

  @doc """
  GetTrailStatus

  Returns a JSON-formatted list of information about the specified trail.
  Fields include information on delivery errors, Amazon SNS and Amazon S3
  errors, and start and stop logging times for each trail.
  """
  def get_trail_status(client, input) do
    request(client, "GetTrailStatus", input)
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

  <important>Events that occurred during the selected time range will not be
  available for lookup if CloudTrail logging was not enabled when the events
  occurred.</important>
  """
  def lookup_events(client, input) do
    request(client, "LookupEvents", input)
  end

  @doc """
  StartLogging

  Starts the recording of AWS API calls and log file delivery for a trail.
  """
  def start_logging(client, input) do
    request(client, "StartLogging", input)
  end

  @doc """
  StopLogging

  Suspends the recording of AWS API calls and log file delivery for the
  specified trail. Under most circumstances, there is no need to use this
  action. You can update a trail without stopping it first. This action is
  the only way to stop recording.
  """
  def stop_logging(client, input) do
    request(client, "StopLogging", input)
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
  def update_trail(client, input) do
    request(client, "UpdateTrail", input)
  end


  defp request(%{__struct__: client_module} = client, action, input) do
    client_module.request(client, action, input)
  end
end
