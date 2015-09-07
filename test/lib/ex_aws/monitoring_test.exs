
defmodule ExAws.Monitoring.Test do
  use ExUnit.Case, async: true

  test "Basic sanity check" do
    client = ExAws.Monitoring.Client.new
    assert apply(ExAws.Monitoring.Core, :describe_alarms, [client | [[]]])
  end
end
