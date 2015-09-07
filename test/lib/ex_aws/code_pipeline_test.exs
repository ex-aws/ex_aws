
defmodule ExAws.CodePipeline.Test do
  use ExUnit.Case, async: true

  test "Basic sanity check" do
    client = ExAws.CodePipeline.Client.new
    assert apply(ExAws.CodePipeline.Core, :list_pipelines, [client | [%{}]])
  end
end
