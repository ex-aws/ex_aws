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
      "ResourcesToSkip.member.1" => "test_resource_1",
      "ResourcesToSkip.member.2" => "test_resource_2",
      "StackName" => "test_stack"
    })
    assert expected == Cloudformation.continue_update_rollback(
      "test_stack", [skip_resources: ["test_resource_1", "test_resource_2"]]
    )
  end

  test "continue_update_rollback with role arn" do
    expected = query(:continue_update_rollback, %{
      "RoleARN" => "arn:my:thing",
      "StackName" => "test_stack"
    })
    assert expected == Cloudformation.continue_update_rollback("test_stack",
                                                  [role_arn: "arn:my:thing"])
  end

  test "continue_update_rollback with skip_resources and role arn" do
    expected = query(:continue_update_rollback, %{
      "ResourcesToSkip.member.1" => "test_resource_1",
      "ResourcesToSkip.member.2" => "test_resource_2",
      "RoleARN" => "arn:my:thing",
      "StackName" => "test_stack"
      })

    assert expected ==
      Cloudformation.continue_update_rollback("test_stack",
      [role_arn: "arn:my:thing", skip_resources: ["test_resource_1", "test_resource_2"]])
  end

  test "create_stack no options" do
    expected = query(:create_stack, %{"StackName" => "test_stack"})
    assert expected == Cloudformation.create_stack("test_stack")
  end

  test "create_stack with template url" do
    expected = query(:create_stack,
    %{"StackName" => "test_stack",
      "TemplateURL" => "https://s3.amazonaws.com/sample.json"
    })

    assert expected == Cloudformation.create_stack("test_stack", [template_url: "https://s3.amazonaws.com/sample.json"])
  end

  test "create_stack with multiple parameters" do
    expected = query(:create_stack,
    %{"StackName" => "test_stack",
      "Parameters.member.1.ParameterKey" => "AvailabilityZone",
      "Parameters.member.1.ParameterValue" => "us-east-1a",
      "Parameters.member.2.ParameterKey" => "InstanceType",
      "Parameters.member.2.ParameterValue" => "m1.micro"
      })

    result = Cloudformation.create_stack(
      "test_stack",
      [parameters:
        [ %{parameter_key: "AvailabilityZone", parameter_value: "us-east-1a"},
          %{parameter_key: "InstanceType", parameter_value: "m1.micro"} ]
      ])

    assert expected == result
  end

  test "create_stack with tags" do
    expected = query(:create_stack,
    %{"StackName" => "test_stack",
      "Tags.member.1.Key" => "key",
      "Tags.member.1.Value" => "value"})

    assert expected == Cloudformation.create_stack("test_stack",
    [tags: [key: "value"]])
    assert expected == Cloudformation.create_stack("test_stack",
    [tags: [ {"key", "value"} ]])
  end

  test "create_stack with capabilities" do
    expected = query(:create_stack,
      %{"StackName" => "test_stack",
      "Capabilities.member.1" => "CAPABILITY_IAM"
      })

    assert expected == Cloudformation.create_stack("test_stack",
    [capabilities: ["CAPABILITY_IAM"]])
  end

  test "create_stack with resource_types" do
    expected = query(:create_stack,
      %{"StackName" => "test_stack",
        "ResourceTypes.member.1" => "AWS::EC2::Instance",
        "ResourceTypes.member.2" => "AWS::EC2::Volume"
      })

    assert expected == Cloudformation.create_stack("test_stack",
      [resource_types: ["AWS::EC2::Instance", "AWS::EC2::Volume"]])
  end

  test "delete_stack" do
    expected = query(:delete_stack, %{"StackName" => "test_stack"})
    assert expected == Cloudformation.delete_stack("test_stack")
  end

  test "delete_stack with role arn" do
    expected = query(:delete_stack,
    %{"StackName" => "test_stack",
      "RoleARN" => "arn:aws:iam::1234567:role/god"})
    assert expected ==
      Cloudformation.delete_stack("test_stack",
        [role_arn: "arn:aws:iam::1234567:role/god"])
  end

  test "delete_stack with with retain resources" do
    expected = query(:delete_stack,
      %{"StackName" => "test_stack",
        "RetainResources.member.1" => "test_resource_1",
        "RetainResources.member.2" => "test_resource_2",
        "RetainResources.member.3" => "test_resource_3"})

    assert expected ==
      Cloudformation.delete_stack("test_stack",
        [retain_resources: ["test_resource_1", "test_resource_2", "test_resource_3"]])
  end

  test "describe_stack_resource with logical resource Id" do
    expected = query(:describe_stack_resource,
      %{"LogicalResourceId" => "MyTestInstance",
        "StackName" => "test_stack"})

    assert expected == Cloudformation.describe_stack_resource("test_stack", "MyTestInstance")
  end

  test "describe_stack_resources with physical resource Id" do
    expected = query(:describe_stack_resources,
      %{"PhysicalResourceId" => "MyTestResource"})

    assert expected == Cloudformation.describe_stack_resources([physical_resource_id: "MyTestResource"])
  end

  test "describe_stack_resources with stack name" do
    expected = query(:describe_stack_resources,
    %{"StackName" => "MyTestResource"})

    assert expected == Cloudformation.describe_stack_resources([stack_name: "MyTestResource"])
  end

  test "get_template with stack_name" do
    expected = query(:get_template, %{"StackName" => "Test"})

    assert expected == Cloudformation.get_template([stack_name: "Test"])
  end

  test "get_template with stack_name, template_stage, and change_set_name" do
    expected = query(:get_template, %{"StackName" => "Test",
                                      "ChangeSetName" => "test_changeset",
                                      "TemplateStage" => "Original"})
    assert expected == Cloudformation.get_template([stack_name: "Test", change_set_name: "test_changeset", template_stage: :original])
  end

  test "get_template_summary with stack_name" do
    expected = query(:get_template_summary, %{"StackName" => "Test"})

    assert expected == Cloudformation.get_template_summary([stack_name: "Test"])
  end

  test "get_template_summary with template_url" do
    expected = query(:get_template_summary, %{"TemplateURL" => "TestUrl"})

    assert expected == Cloudformation.get_template_summary([template_url: "TestUrl"])
  end

  test "get_template_summary with template_body" do
    expected = query(:get_template_summary, %{"TemplateBody" => "TestTemplateBody"})

    assert expected == Cloudformation.get_template_summary([template_body: "TestTemplateBody"])
  end

  test "list_stacks no options" do
    expected = query(:list_stacks)
    assert expected == Cloudformation.list_stacks
  end

  test "list_stacks with status filters" do
    expected = query(:list_stacks,
      %{"StackStatusFilter.member.1" => "ROLLBACK_IN_PROGRESS",
        "StackStatusFilter.member.2" => "ROLLBACK_COMPLETE"})
    assert expected == Cloudformation.list_stacks(stack_status_filters: [:rollback_in_progress, :rollback_complete])
  end

  test "list_stack_resources no options" do
    expected = query(:list_stack_resources, %{"StackName" => "test_stack"})
    assert expected == Cloudformation.list_stack_resources("test_stack")
  end

  test "list_stack_resources with next_token" do
    expected = query(:list_stack_resources,
      %{"StackName" => "test_stack",
        "NextToken" => "Next"})
    assert expected == Cloudformation.list_stack_resources("test_stack", next_token: "Next")
  end

  test "describe_stacks with stack name" do
    expected = query(:describe_stacks, %{"StackName" => "test_stack"})
    assert expected == Cloudformation.describe_stacks([stack_name: "test_stack"])
  end

  test "describe_stacks with no name" do
    expected = query(:describe_stacks, %{})
    assert expected == Cloudformation.describe_stacks
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
