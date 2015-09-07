
defmodule ExAws.CloudTrail.Test do
  use ExUnit.Case, async: true

  test "Basic sanity check" do
    client = ExAws.CloudTrail.Client.new
    assert apply(ExAws.CloudTrail.Core, :describe_trails, [client | [%{}]])
  end
end
