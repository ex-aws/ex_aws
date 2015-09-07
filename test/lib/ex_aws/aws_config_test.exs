
defmodule ExAws.AWS.Config.Test do
  use ExUnit.Case, async: true

  test "Basic sanity check" do
    client = ExAws.AWS.Config.Client.new
    assert apply(ExAws.AWS.Config.Core, :describe_delivery_channels, [client | [%{}]])
  end
end
