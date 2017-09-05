defmodule ExAws.GameLiftTest do
  use ExUnit.Case, async: true

  alias ExAws.GameLift
  alias ExAws.GameLift.Player

  test "#accept match" do
    expected = %{
      "AcceptanceType" => "ACCEPT",
      "PlayerIds" => ["player-1", "player-2"],
      "TicketId" => "ticket-1"
    }
    assert GameLift.accept_match("ticket-1", ["player-1", "player-2"]).data == expected
  end

  test "#reject match" do
    expected = %{
      "AcceptanceType" => "REJECT",
      "PlayerIds" => ["player-1"],
      "TicketId" => "ticket-1"
    }
    assert GameLift.accept_match("ticket-1", ["player-1"], :reject).data == expected
  end

  test "#start matchmaking" do
    players = [
      %Player{
        player_id: "player-1",
        player_attributes: %{
          :rating => 42,
          "game_mode" => "deathmatch",
          "stats" => %{:win_rate => 0.8, "win_count" => 88},
          :levels => ["Q3DM0", "Q3DM19"],
        },
        team: :blue,
        latency_in_ms: %{"us-west-1" => 42, "us-west-2" => 88},
      },
      %Player{
        team: "red",
      },
      %Player{},
    ]
    expected = %{
      "ConfigurationName" => "sample",
      "Players" => [
        %{
          "PlayerId" => "player-1",
          "PlayerAttributes" => %{
            "rating" => %{"N" => 42},
            "game_mode" => %{"S" => "deathmatch"},
            "levels" => %{"SL" => ["Q3DM0", "Q3DM19"]},
            "stats" => %{"SDM" => %{"win_rate" => 0.8, "win_count" => 88}}
          },
          "LatencyInMs" => %{"us-west-1" => 42, "us-west-2" => 88},
          "Team" => "blue",
        },
        %{
          "Team" => "red",
          "LatencyInMs" => nil,
          "PlayerId" => nil,
          "PlayerAttributes" => nil,
        },
        %{
          "Team" => nil,
          "LatencyInMs" => nil,
          "PlayerId" => nil,
          "PlayerAttributes" => nil,
        },
      ],
      "TicketId" => "ticket-1"
    }
    assert GameLift.start_matchmaking("sample", players, "ticket-1").data == expected
  end

  test "#describe matchmaking (one ticket)" do
    expected = %{"TicketIds" => ["ticket-1"]}
    assert GameLift.describe_matchmaking("ticket-1").data == expected
  end

  test "#describe matchmaking (many tickets)" do
    tickets = ["ticket-1", "ticket-2", "ticket-3"]
    expected = %{"TicketIds" => tickets}
    assert GameLift.describe_matchmaking(tickets).data == expected
  end

  test "#stop matchmaking" do
    expected = %{"TicketId" => "ticket-1"}
    assert GameLift.stop_matchmaking("ticket-1").data == expected
  end
end
