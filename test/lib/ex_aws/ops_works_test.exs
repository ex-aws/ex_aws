
defmodule ExAws.OpsWorks.Test do
  use ExUnit.Case, async: true

  test "Basic sanity check" do
    client = ExAws.OpsWorks.Client.new
    assert apply(ExAws.OpsWorks.Core, :describe_stacks, [client | [%{}]])
  end
end
