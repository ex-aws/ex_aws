
defmodule ExAws.ElasticBeanstalk.Test do
  use ExUnit.Case, async: true

  test "Basic sanity check" do
    client = ExAws.ElasticBeanstalk.Client.new
    assert apply(ExAws.ElasticBeanstalk.Core, :describe_applications, [client | [[]]])
  end
end
