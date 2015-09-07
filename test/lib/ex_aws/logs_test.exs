
defmodule ExAws.Logs.Test do
  use ExUnit.Case, async: true

  test "Basic sanity check" do
    client = ExAws.Logs.Client.new
    assert apply(ExAws.Logs.Core, :describe_log_groups, [client | [%{}]])
  end
end
