
defmodule ExAws.KMS.Test do
  use ExUnit.Case, async: true

  test "Basic integration test" do
    assert {:ok, _} = ExAws.KMS.new
    |> ExAws.KMS.Core.list_keys(%{})
  end
end
