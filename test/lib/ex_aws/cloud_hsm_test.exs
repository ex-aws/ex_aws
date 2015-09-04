
defmodule ExAws.CloudHSM.Test do
  use ExUnit.Case, async: true

  test "Basic integration test" do
    assert {:ok, _} = ExAws.CloudHSM.new
    |> ExAws.CloudHSM.Core.list_hsms(%{})
  end
end
