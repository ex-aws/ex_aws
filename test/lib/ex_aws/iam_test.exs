
defmodule ExAws.Iam.Test do
  use ExUnit.Case, async: true

  test "Basic sanity check" do
    client = ExAws.Iam.Client.new
    assert apply(ExAws.Iam.Core, :list_users, [client | [[]]])
  end
end
