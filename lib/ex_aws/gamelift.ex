defmodule ExAws.GameLift do
  @moduledoc """
  Operations on the AWS GameLift service.

  http://docs.aws.amazon.com/LINK_MUST_BE_HERE
  """

  import ExAws.Utils, only: [camelize_keys: 1]
  alias __MODULE__

  @namespace "GameLift"

  @type routing_strategy_type ::
  :SIMPLE |
  :TERMINAL

  ## Tables
  ######################

  #@spec get_item(table_name :: table_name, primary_key :: primary_key) :: ExAws.Operation.JSON.t
  #@spec get_item(table_name :: table_name, primary_key :: primary_key, opts :: get_item_opts) :: ExAws.Operation.JSON.t
  def get_aliases(opts \\ []) do
    opts = opts
    |> Map.new
    |> camelize_keys
    request(:list_aliases, opts)
  end

  defp request(action, params) do
    operation = action
    |> Atom.to_string
    |> Macro.camelize

    ExAws.Operation.JSON.new(:gamelift, %{
      data: params,
      headers: [
        {"x-amz-target", "#{@namespace}.#{operation}"},
        {"content-type", "application/x-amz-json-1.1"},
      ]
    }
    |> Map.merge(opts))
  end
end
