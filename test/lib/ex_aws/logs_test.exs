
defmodule ExAws.Logs.Test do
  use ExUnit.Case, async: true

  test "Basic integration test" do
    assert {:ok, _} = ExAws.Logs.new
    |> ExAws.Logs.Core.describe_log_groups(%{})
  end
end
