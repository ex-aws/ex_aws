
defmodule ExAws.CodeDeploy.Test do
  use ExUnit.Case, async: true

  test "Basic sanity check" do
    client = ExAws.CodeDeploy.Client.new
    assert apply(ExAws.CodeDeploy.Core, :list_applications, [client | [%{}]])
  end
end
