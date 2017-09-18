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
  
  @doc "Start a metric request"
  @spec start_metric_data(namespace :: binary,
    name :: binary,
    value :: (binary | integer | float),
    unit :: binary,
    dimensions :: [ { dimension_name :: binary, dimension_value :: binary } ]
  ) :: put_metric_t
  
  def start_metric_data(namespace, name, value, unit, dimensions \\ []) do
    add_metric_data( { 1, [namespace: namespace] }, name, value, unit, dimensions)
  end

  @doc "Add a metric"
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
      dn = key <> "Dimensions.member.#{idx}."
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

  @doc "Finalize metrics_data into a request"
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
