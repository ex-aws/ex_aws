
defmodule ExAws.CloudTrail.Test do
  use ExUnit.Case, async: true

  test "Basic integration test" do
    assert {:ok, _} = ExAws.CloudTrail.new
    |> ExAws.CloudTrail.Core.describe_trails(%{})
  end
end
