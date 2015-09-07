
defmodule ExAws.Autoscaling.Test do
  use ExUnit.Case, async: true

  test "Basic sanity check" do
    client = ExAws.Autoscaling.Client.new
    assert apply(ExAws.Autoscaling.Core, :describe_tags, [client | [[]]])
  end
end
