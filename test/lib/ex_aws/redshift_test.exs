
defmodule ExAws.Redshift.Test do
  use ExUnit.Case, async: true

  test "Basic sanity check" do
    client = ExAws.Redshift.Client.new
    assert apply(ExAws.Redshift.Core, :describe_clusters, [client | [[]]])
  end
end
