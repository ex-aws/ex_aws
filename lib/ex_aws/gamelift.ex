defmodule ExAws.GameLift do
  @moduledoc """
  Operations on the AWS GameLift service.

  http://docs.aws.amazon.com/LINK_MUST_BE_HERE
  """

  import ExAws.Utils, only: [camelize_keys: 1]
  alias __MODULE__

  alias ExAws.Dynamo.Encoder
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

  @doc """
  Amazon GameLift StartMatchmaking request
  """
  @spec start_matchmaking(Map.t) :: Map.t
  def start_matchmaking(opts \\ []) do
    opts = opts
    |> Map.new
    |> Map.merge(%{ "Players" => Enum.map(opts["Players"], 
      fn 
        player -> [latency_in_ms: player["latency_in_ms"], player_attributes: Encoder.encode_root(player["player_attributes"])] 
      end)})
    |> camelize_keys
    request(:start_matchmaking, opts)
  end

  defp request(action, opts) do
    operation = action
    |> Atom.to_string
    |> Macro.camelize

    ExAws.Operation.JSON.new(:gamelift, %{
      headers: [
        {"x-amz-target", "#{@namespace}.#{operation}"},
        {"content-type", "application/x-amz-json-1.1"},
      ]
    }
    |> Map.merge(opts))
  end
end
