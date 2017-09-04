defmodule ExAws.GameLiftTest do
  use ExUnit.Case, async: true
  alias ExAws.GameLift

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
end
