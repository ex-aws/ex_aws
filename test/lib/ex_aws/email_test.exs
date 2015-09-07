
defmodule ExAws.Email.Test do
  use ExUnit.Case, async: true

  test "Basic sanity check" do
    client = ExAws.Email.Client.new
    assert apply(ExAws.Email.Core, :get_send_statistics, [client | []])
  end
end
