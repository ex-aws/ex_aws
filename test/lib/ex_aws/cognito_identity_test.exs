
defmodule ExAws.CognitoIdentity.Test do
  use ExUnit.Case, async: true

  test "Basic sanity check" do
    client = ExAws.CognitoIdentity.Client.new
    assert apply(ExAws.CognitoIdentity.Core, :list_identity_pools, [client | [%{max_results: 1}]])
  end
end
