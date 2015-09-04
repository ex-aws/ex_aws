
defmodule ExAws.SWF.Test do
  use ExUnit.Case, async: true

  test "Basic integration test" do
    assert {:ok, _} = ExAws.SWF.new
    |> ExAws.SWF.Core.list_domains(%{registrationStatus: "REGISTERED"})
  end
end
