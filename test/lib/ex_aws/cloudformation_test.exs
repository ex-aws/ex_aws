
defmodule ExAws.Cloudformation.Test do
  use ExUnit.Case, async: true

  test "Basic sanity check" do
    client = ExAws.Cloudformation.Client.new
    assert apply(ExAws.Cloudformation.Core, :list_stacks, [client | [[]]])
  end
end
