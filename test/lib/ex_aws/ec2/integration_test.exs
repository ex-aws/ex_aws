defmodule ExAws.EC2.IntegrationTest do
  use ExUnit.Case, async: true

  test "#describe_instances" do
    assert {:ok, %{body: body}} = ExAws.EC2.describe_instances |> ExAws.request
    assert body |> String.contains?("DescribeInstancesResponse")
  end

  test "#describe_tags" do
    assert {:ok, %{body: body}} = ExAws.EC2.describe_tags |> ExAws.request
    assert body |> String.contains?("DescribeTagsResponse")
  end
  
  test "#describe_tags with basic filters" do
    params = [filters: [{:key, ["a-key", "b-key"]}, {:value, "a-value"}]]
    assert {:ok, %{body: body}} = ExAws.EC2.describe_tags(params) |> ExAws.request
    assert body |> String.contains?("DescribeTagsResponse")
  end

  test "#describe_tags with resource_type filter" do
    params = [filters: [{:resource_type, [:customer_gateway]}]]
    assert {:ok, %{body: body}} = ExAws.EC2.describe_tags(params) |> ExAws.request
    assert body |> String.contains?("DescribeTagsResponse")
  end
end
