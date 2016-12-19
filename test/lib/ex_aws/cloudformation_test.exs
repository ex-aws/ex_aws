defmodule ExAws.CloudformationTest do
  use ExUnit.Case, async: true
  alias ExAws.Cloudformation
  alias ExAws.Operation.Query

  @version "2010-05-15"

  test "describe_stack_resource" do
    expected = %Query{
      params: %{"Action"    => "DescribeStackResource",
                "LogicalResourceId" => "MyTestInstance",
                "StackName" => "test_stack",
                "Version"   => @version
               },
      path: "/",
      service: :cloudformation,
      action: :describe_stack_resource,
      parser: &ExAws.Cloudformation.Parsers.parse/2
    }

    assert expected == Cloudformation.describe_stack_resource("test_stack", "MyTestInstance")
  end

  test "list_stack_resources no options" do
    expected = %Query{
      params: %{"Action"    => "ListStackResources",
                "StackName" => "test_stack",
                "Version"   => @version
               },
      path: "/",
      service: :cloudformation,
      action: :list_stack_resources,
      parser: &ExAws.Cloudformation.Parsers.parse/2
    }

    assert expected == Cloudformation.list_stack_resources("test_stack")
  end

  test "list_stack_resources with next_token" do
        expected = %Query{
          params: %{"Action"    => "ListStackResources",
                    "StackName" => "test_stack",
                    "Version"   => @version,
                    "NextToken" => "Next"
                   },
          path: "/",
          service: :cloudformation,
          action: :list_stack_resources,
          parser: &ExAws.Cloudformation.Parsers.parse/2
        }

    assert expected == Cloudformation.list_stack_resources("test_stack", next_token: "Next")
  end

end
