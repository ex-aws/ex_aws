
defmodule ExAws.AWS.Config.Test do
  use ExUnit.Case, async: true

  test "Basic integration test" do
    assert {:ok, _} = ExAws.AWS.Config.new
    |> ExAws.AWS.Config.Core.describe_delivery_channels(%{})
  end
end
