
defmodule ExAws.ImportExport.Test do
  use ExUnit.Case, async: true

  test "Basic sanity check" do
    client = ExAws.ImportExport.Client.new
    assert apply(ExAws.ImportExport.Core, :list_jobs, [client | [[]]])
  end
end
