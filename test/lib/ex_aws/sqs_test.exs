
defmodule ExAws.SQS.Test do
  use ExUnit.Case, async: true

  test "Basic sanity check" do
    client = ExAws.SQS.Client.new
    assert apply(ExAws.SQS.Core, :list_queues, [client | [[]]])
  end
end
