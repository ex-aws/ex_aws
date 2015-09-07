
defmodule ExAws.SWF.Test do
  use ExUnit.Case, async: true

  test "Basic sanity check" do
    client = ExAws.SWF.Client.new
    assert apply(ExAws.SWF.Core, :list_domains, [client | [%{registration_status: "REGISTERED"}]])
  end
end
