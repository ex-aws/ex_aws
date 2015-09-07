
defmodule ExAws.SSM.Test do
  use ExUnit.Case, async: true

  test "Basic sanity check" do
    client = ExAws.SSM.Client.new
    assert apply(ExAws.SSM.Core, :list_documents, [client | [%{}]])
  end
end
