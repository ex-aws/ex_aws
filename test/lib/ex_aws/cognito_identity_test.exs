
defmodule ExAws.CognitoIdentity.Test do
  use ExUnit.Case, async: true

  test "Basic integration test" do
    assert {:ok, _} = ExAws.CognitoIdentity.new
    |> ExAws.CognitoIdentity.Core.list_identity_pools(%{MaxResults: 1})
  end
end
