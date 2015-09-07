
defmodule ExAws.RDS.Test do
  use ExUnit.Case, async: true

  test "Basic sanity check" do
    client = ExAws.RDS.Client.new
    assert apply(ExAws.RDS.Core, :describe_db_clusters, [client | [[]]])
  end
end
