
defmodule ExAws.DataPipeline.Test do
  use ExUnit.Case, async: true

  test "Basic sanity check" do
    client = ExAws.DataPipeline.Client.new
    assert apply(ExAws.DataPipeline.Core, :list_pipelines, [client | [%{}]])
  end
end
