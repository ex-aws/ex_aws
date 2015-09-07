
defmodule ExAws.KMS.Test do
  use ExUnit.Case, async: true

  test "Basic sanity check" do
    client = ExAws.KMS.Client.new
    assert apply(ExAws.KMS.Core, :list_keys, [client | [%{}]])
  end
end
