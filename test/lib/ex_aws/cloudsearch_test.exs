
defmodule ExAws.Cloudsearch.Test do
  use ExUnit.Case, async: true

  test "Basic sanity check" do
    client = ExAws.Cloudsearch.Client.new
    assert apply(ExAws.Cloudsearch.Core, :describe_domains, [client | [[]]])
  end
end
