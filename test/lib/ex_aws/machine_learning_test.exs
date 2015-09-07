
defmodule ExAws.MachineLearning.Test do
  use ExUnit.Case, async: true

  test "Basic sanity check" do
    client = ExAws.MachineLearning.Client.new
    assert apply(ExAws.MachineLearning.Core, :describe_data_sources, [client | [%{}]])
  end
end
