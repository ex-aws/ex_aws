
defmodule ExAws.MachineLearning.Test do
  use ExUnit.Case, async: true

  test "Basic integration test" do
    assert {:ok, _} = ExAws.MachineLearning.new
    |> ExAws.MachineLearning.Core.describe_data_sources(%{})
  end
end
