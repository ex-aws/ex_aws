defmodule ExAws.Cloudwatch do
  import ExAws.Utils, only: [camelize_keys: 1]

  @moduledoc """
  Operations on AWS Cloudwatch
  """
  @type state_value ::
  :OK |
  :ALARM |
  :INSUFFICIENT_DATA

  ## Alarms
  ######################

  @doc "Describe alarms"
  @spec describe_alarms(opts :: [
    next_token: binary,
    action_prefix: binary,
    alarm_name_prefix: binary,
    max_records: integer,
    state_value: state_value
  ]) :: ExAws.Operation.Query.t

  def describe_alarms(opts \\ []) do
    opts = opts
            |> Map.new
            |> camelize_keys
    request(:describe_alarms, opts)
  end

  @type put_metric_t :: { metric_counter :: integer, metrics :: list() }
  
  @doc ~S"""
  Start a metric request

  iex> ExAws.Cloudwatch.start_metric_data("Support")
  { 1, [namespace: "Support"] }

  """
  @spec start_metric_data(namespace :: binary) :: put_metric_t
  
  def start_metric_data(namespace) do
    { 1, [namespace: namespace] }
  end

  @doc ~S"""
  Add a metric

  iex> ExAws.Cloudwatch.start_metric_data("Support") |> ExAws.Cloudwatch.add_metric_data("network", 1, "Count")
{2,
 [{"MetricData.member.1.MetricName", "network"},
  {"MetricData.member.1.Value", 1}, {"MetricData.member.1.Unit", "Count"},
  {:namespace, "Support"}]}

  """
  @spec add_metric_data( metric_data :: put_metric_t,
    name :: binary,
    value :: (binary | integer | float),
    unit :: binary,
    dimensions :: [ { dimension_name :: binary, dimension_value :: binary } ]
  ) :: put_metric_t
    
  def add_metric_data({metric_n, metrics}, name, value, unit, dimensions \\ []) do
    key = "MetricData.member.#{metric_n}."

    dimensions = Enum.with_index(dimensions)
    |> Enum.flat_map(fn { {d_name, d_value}, idx} ->
      dn = key <> "Dimensions.member.#{idx+1}."
      [
	{ dn <> "Name", d_name}, 
	{ dn <> "Value", d_value}
      ]
    end)

    metric = [ {key <> "MetricName", name},
	       {key <> "Value", value},
	       {key <> "Unit", unit} | dimensions ]

    {metric_n+1, metric ++ metrics }
  end

  @doc ~S"""
  Finalize metrics_data into a request

  iex> ExAws.Cloudwatch.start_metric_data("Support") |> ExAws.Cloudwatch.add_metric_data("network", 1, "Count") |> ExAws.Cloudwatch.put_metric_data
%ExAws.Operation.Query{action: :put_metric_data,
 params: %{"Action" => "PutMetricData",
   "MetricData.member.1.MetricName" => "network",
   "MetricData.member.1.Unit" => "Count", "MetricData.member.1.Value" => 1,
   "Namespace" => "Support", "Version" => "2010-08-01"},
 parser: &ExAws.Cloudwatch.Parsers.parse/2, path: "/", service: :monitoring}

  """
  
  @spec put_metric_data( metric_data :: put_metric_t ) :: ExAws.Operation.Query.t
  def put_metric_data( { _metric_n, metrics } ) do
    put_metric_data(metrics)
  end

  @doc "Finalize metrics list into a request"
  @spec put_metric_data( metrics :: list() ) :: ExAws.Operation.Query.t
  def put_metric_data(metrics) do
    opts = metrics
    |> Map.new
    |> camelize_keys
    
    request(:put_metric_data,opts)
  end
  
  defp request(action, params) do
    action_string = action |> Atom.to_string |> Macro.camelize

    %ExAws.Operation.Query{
      path: "/",
      params: params |> Map.merge(%{"Action" => action_string, "Version" => "2010-08-01"}),
      service: :monitoring,
      action: action,
      parser: &ExAws.Cloudwatch.Parsers.parse/2
    }
  end
end
