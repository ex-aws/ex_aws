
defmodule ExAws.CloudHSM.Test do
  use ExUnit.Case, async: true

  test "Basic sanity check" do
    client = ExAws.CloudHSM.Client.new
    assert apply(ExAws.CloudHSM.Core, :list_hsms, [client | [%{}]])
  end
end
