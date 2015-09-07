
defmodule ExAws.StorageGateway.Test do
  use ExUnit.Case, async: true

  test "Basic sanity check" do
    client = ExAws.StorageGateway.Client.new
    assert apply(ExAws.StorageGateway.Core, :list_gateways, [client | [%{}]])
  end
end
