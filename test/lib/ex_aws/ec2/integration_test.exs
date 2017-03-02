defmodule ExAws.EC2.IntegrationTest do
  use ExUnit.Case, async: true

  test "#describe_instances" do
    assert {:ok, %{body: body}} = ExAws.EC2.describe_instances |> ExAws.request
    assert body |> String.contains?("DescribeInstancesResponse")
  end
end
