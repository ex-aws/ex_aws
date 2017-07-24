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
