defmodule ExAws.CloudformationIntegrationTest do
  use ExUnit.Case, async: true

  test "list_stacks works" do
    assert {:ok, %{body: %{stacks: _}}} = ExAws.Cloudformation.list_stacks(status_filter: [:update_complete, :create_complete]) |> ExAws.request
  end
end
