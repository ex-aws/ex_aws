
defmodule ExAws.SDB.Test do
  use ExUnit.Case, async: true

  test "Basic sanity check" do
    client = ExAws.SDB.Client.new
    assert apply(ExAws.SDB.Core, :list_domains, [client | [[]]])
  end
end
