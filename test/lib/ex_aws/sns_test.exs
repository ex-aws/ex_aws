
defmodule ExAws.SNS.Test do
  use ExUnit.Case, async: true

  test "Basic sanity check" do
    client = ExAws.SNS.Client.new
    assert apply(ExAws.SNS.Core, :list_topics, [client | [[]]])
  end
end
