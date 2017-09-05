defmodule ExAws.GameLift do
  @moduledoc """
  Operations on the AWS GameLift service.

  http://docs.aws.amazon.com/LINK_MUST_BE_HERE
  """

  alias ExAws.GameLift.Encodable
  alias ExAws.GameLift.Player

  @namespace "GameLift"

  defp request(action, data) do
    operation = action
    |> Atom.to_string
    |> Macro.camelize

    ExAws.Operation.JSON.new(:gamelift, %{
      data: data,
      headers: [
        {"x-amz-target", "#{@namespace}.#{operation}"},
        {"content-type", "application/x-amz-json-1.1"},
      ]
    })
  end

  defp camelize_opts(opts) do
    opts
    |> Map.new
    |> ExAws.Utils.camelize_keys
  end

  @spec get_aliases(Map.t) :: Map.t
  def get_aliases(opts \\ []) do
    request(:list_aliases, camelize_opts(opts))
  end

  @spec start_matchmaking(
    configuration_name :: String.t,
    players :: [Player.t],
    ticket_id :: String.t | nil) :: ExAws.Operation.JSON.t
  def start_matchmaking(configuration_name, players, ticket_id \\ nil) do
    data = %{
      "ConfigurationName" => configuration_name,
      "Players" => Enum.map(players, &encode_player/1),
      "TicketId" => ticket_id,
    }
    request(:start_matchmaking, data)
  end

  defp encode_player(player) do
    player
    |> Map.from_struct
    |> Stream.map(&encode_player_param/1)
    |> Enum.into(%{})
  end

  defp encode_player_param({:player_id, player_id}) do
    {"PlayerId", player_id}
  end
  defp encode_player_param({:player_attributes, nil}) do
    {"PlayerAttributes", nil}
  end
  defp encode_player_param({:player_attributes, player_attributes}) do
    encoded_player_attributes = player_attributes
    |> Stream.map(fn {k, v} -> {to_string(k), Encodable.encode(v)} end)
    |> Enum.into(%{})

    {"PlayerAttributes", encoded_player_attributes}
  end
  defp encode_player_param({:latency_in_ms, latency_in_ms}) do
    {"LatencyInMs", latency_in_ms}
  end
  defp encode_player_param({:team, team}) do
    encoded_team = if is_nil(team), do: nil, else: to_string(team)
    {"Team", encoded_team}
  end

  @spec stop_matchmaking(ticket_id :: String.t) :: ExAws.Operation.JSON.t
  def stop_matchmaking(ticket_id) do
    request(:stop_matchmaking, %{"TicketId" => ticket_id})
  end

  @spec accept_match(
    ticket_id :: String.t,
    player_ids :: [String.t],
    :accept | :reject) :: ExAws.Operation.JSON.t
  def accept_match(ticket_id, player_ids, acceptance_type \\ :accept) do
    data = %{
      "TicketId" => ticket_id,
      "PlayerIds" => player_ids,
      "AcceptanceType" => acceptance_type |> Atom.to_string |> String.upcase,
    }
    request(:accept_match, data)
  end
end
