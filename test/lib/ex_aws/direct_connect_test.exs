
defmodule ExAws.DirectConnect.Test do
  use ExUnit.Case, async: true

  test "Basic sanity check" do
    client = ExAws.DirectConnect.Client.new
    assert apply(ExAws.DirectConnect.Core, :describe_connections, [client | [%{}]])
  end
end
