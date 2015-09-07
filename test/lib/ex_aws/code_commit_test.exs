
defmodule ExAws.CodeCommit.Test do
  use ExUnit.Case, async: true

  test "Basic sanity check" do
    client = ExAws.CodeCommit.Client.new
    assert apply(ExAws.CodeCommit.Core, :list_repositories, [client | [%{}]])
  end
end
