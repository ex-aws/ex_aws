
defmodule ExAws.Sts.Test do
  use ExUnit.Case, async: true

  test "Basic sanity check" do
    client = ExAws.Sts.Client.new
    assert apply(ExAws.Sts.Core, :get_session_token, [client | [[]]])
  end
end
