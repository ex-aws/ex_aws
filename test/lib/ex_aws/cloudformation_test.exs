defmodule ExAws.CloudformationTest do
  use ExUnit.Case, async: true
  alias ExAws.Cloudformation
  alias ExAws.Operation.Query

  @version "2010-05-15"

  test "cancel_update_stack" do
    expected = query(:cancel_update_stack, %{"StackName" => "test_stack"})
    assert expected == Cloudformation.cancel_update_stack("test_stack")
  end

  test "continue_update_rollback no options" do
    expected = query(:continue_update_rollback, %{"StackName" => "test_stack"})
    assert expected == Cloudformation.continue_update_rollback("test_stack")
  end

  test "continue_update_rollback with skip resources" do
    expected = query(:continue_update_rollback, %{
      "ResourcesToSkip.member.1" => "TestResource",
      "ResourcesToSkip.member.2" => "TestResource2",
      "StackName" => "test_stack"
    })
    assert expected == Cloudformation.continue_update_rollback("test_stack",
                         [skip_resources: ["TestResource", "TestResource2"]])
  end

  test "continue_update_rollback with role arn" do
    expected = query(:continue_update_rollback, %{
      "RoleArn" => "arn:my:thing",
      "StackName" => "test_stack"
    })
    assert expected == Cloudformation.continue_update_rollback("test_stack",
                                                  [role_arn: "arn:my:thing"])
  end

  test "describe_stack_resource" do
    expected = query(:describe_stack_resource,
      %{ "LogicalResourceId" => "MyTestInstance",
         "StackName" => "test_stack" })

    assert expected == Cloudformation.describe_stack_resource("test_stack", "MyTestInstance")
  end

  test "describe_stack_resources" do
    expected = query(:describe_stack_resources,
      %{ "StackName" => "test_stack", "PhysicalResourceId" => "MyTestResource" })

    assert expected == Cloudformation.describe_stack_resources("test_stack",
                                          [physical_resource_id: "MyTestResource"])
  end

  test "list_stacks no options" do
    expected = query(:list_stacks)
    assert expected == Cloudformation.list_stacks
  end

  test "list_stacks with status filters" do
    expected = query(:list_stacks, %{"StackStatusFilter.member.1" => "ROLLBACK_IN_PROGRESS",
                                     "StackStatusFilter.member.2" => "ROLLBACK_COMPLETE"})
    assert expected == Cloudformation.list_stacks(status_filter: [:rollback_in_progress, :rollback_complete])
  end

  test "list_stack_resources no options" do
    expected = query(:list_stack_resources, %{"StackName" => "test_stack"})
    assert expected == Cloudformation.list_stack_resources("test_stack")
  end

  test "list_stack_resources with next_token" do
    expected = query(:list_stack_resources, %{"StackName" => "test_stack",
                                              "NextToken" => "Next"})
    assert expected == Cloudformation.list_stack_resources("test_stack", next_token: "Next")
  end

  test "describe_stacks with stack name" do
    expected = query(:describe_stacks, %{"StackName" => "test_stack"})
    assert expected == Cloudformation.describe_stacks("test_stack")
  end

  test "describe_stacks with blank name" do
    expected = query(:describe_stacks, %{})
    assert expected == Cloudformation.describe_stacks("")
  end

  test "describe_stacks with no name" do
    expected = query(:describe_stacks, %{})
    assert expected == Cloudformation.describe_stacks()
  end

  defp query(action, params \\ %{}) do
    action_param = action |> Atom.to_string |> Macro.camelize
    %Query{
      params: params |> Map.merge(%{"Version" => @version, "Action" => action_param}),
      path: "/",
      service: :cloudformation,
      action: action,
      parser: &ExAws.Cloudformation.Parsers.parse/3
    }
  end

end
