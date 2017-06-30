defmodule ExAws.CloudformationIntegrationTest do
  use ExUnit.Case, async: true

  test "list_stacks works" do
    assert {:ok, %{body: %{stacks: _}}} = ExAws.Cloudformation.list_stacks(stack_status_filters: [:update_complete, :create_complete]) |> ExAws.request
  end

  test "describe_stacks works" do
    assert {:ok, %{body: %{stacks: _}}} = ExAws.Cloudformation.describe_stacks(nil) |> ExAws.request
  end
end
