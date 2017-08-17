defmodule ExAws.Cloudformation do
  @moduledoc """
  Operations on Cloudformation

  ## Basic Usage
  ```elixir
  alias ExAws.Cloudformation

  # Create a stack with name with parameters
  Cloudformation.create_stack("name",
  [parameters:
    [
      [parameter_key: "AvailabilityZone", parameter_value: "us-east-1"],
      [parameter_key: "InstanceType", parameter_value: "m1.micro"]
    ]]) |> ExAws.request!

  # Delete a stack
  Cloudformation.delete_stack("name", [role_arn: "aws:iam::blah:role/god"])
  |> ExAws.request(region: "us-east-1")
  ```
  ## General notes
  All options are handled as underscore_atoms instead of camelcased binaries as specified
  in the CloudFormation API, I.E ':role_arn' would be 'RoleARN'.

  http://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_Operations.html
  """

  use ExAws.Utils,
  format_type: :xml,
  non_standard_keys: %{
    stack_name: "StackName",
    role_arn: "RoleARN",
    template_url: "TemplateURL",
    next_token: "NextToken",
    parameters: "Parameters.member",
    resource_types: "ResourceTypes.member",
    retain_resources: "RetainResources.member",
    notification_arns: "NotificationARN.member",
    skip_resources: "ResourcesToSkip.member"
  }

  @version "2010-05-15"

  @type parameter :: [
    parameter_key: binary,
    parameter_value: binary,
    use_previous_value: boolean
  ]

  @type tag ::
    {key :: atom | binary, value :: binary}

  @doc """
  Cancels an update on the specified stack.

  Please read: http://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_CancelUpdateStack.html

  Examples:
  ```
  Cloudformation.cancel_update_stack("Test")
  ```
  """

  @spec cancel_update_stack(stack_name :: binary) :: ExAws.Operation.Query.t
  def cancel_update_stack(stack_name) do
    request([{"StackName", stack_name}], :cancel_update_stack)
  end

  @doc """
  Rollbacks a stack in UPDATE_ROLLBACK_FAILED state until the state changes to
  UPDATE_ROLLBACK_COMPLETE state.

  Please read: http://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_ContinueUpdateRollback.html

  Examples:
  ```
  Cloudformation.continue_update_rollback("Test", [role_arn: "aws:iam:test"])

  Cloudformation.continue_update_rollback("test_stack", [skip_resources: ["test_resource_1", "test_resource_2"]])

  Cloudformation.continue_update_rollback("test_stack", [role_arn: "arn:my:thing", skip_resources: ["test_resource_1", "test_resource_2"]]
  ```
  """
  @type continue_update_rollback_opts :: [
    role_arn: binary,
    skip_resources: [binary, ...]
  ]

  @spec continue_update_rollback(stack_name :: binary, opts :: continue_update_rollback_opts) :: ExAws.Operation.Query.t
  def continue_update_rollback(stack_name, opts \\ []) do
    [{"StackName", stack_name} | opts]
    |> Enum.flat_map(&format_param/1)
    |> request(:continue_update_rollback)
  end

  @doc """
  Creates a stack as specified in a template.

  Please read: http://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_CreateStack.html

  Examples:
  ```
  # Create stack from a template url
  Cloudformation.create_stack("stack_name", [template_url: "https://s3.amazonaws.com/sample.json"])

  # Create stack with parameters
  Cloudformation.create_stack("test_stack",
  [parameters: [[parameter_key: "AvailabilityZone", parameter_value: "us-east-1a"],
  [parameter_key: "InstanceType", parameter_value: "m1.micro"]]])
  ```
  """
  @type create_stack_opts :: [
    capabilities: [binary, ...],
    disable_rollback: boolean,
    notification_arns: [binary, ...],
    on_failure: binary,
    parameters: [parameter, ...],
    resource_types: [binary, ...],
    role_arn: binary,
    stack_policy_body: binary,
    stack_policy_url: binary,
    tags: [tag, ...],
    template_body: binary,
    template_url: binary,
    timeout_in_minutes: integer
  ]

  @spec create_stack(stack_name :: binary, opts :: create_stack_opts) :: ExAws.Operation.Query.t
  def create_stack(stack_name, opts \\ []) do
    [{"StackName", stack_name} | opts]
    |> Enum.flat_map(&format_param/1)
    |> request(:create_stack)
  end


  @doc """
  Deletes a stack

  Please read: http://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_DeleteStack.html

  Examples:
  ```

  # Deletes a stack
  Cloudformation.delete_stack("stack_name")

  # Deletes a stack by stack name with a RoleARN
  Cloudformation.delete_stack("stack_name", [role_arn: "aws:iam:123456:role/test"])

  # Deletes a stack except for a couple of resources
  Cloudformation.delete_stack("stack_name", [retain_resources: ["test_resource_1", "test_resource_2"]])
  ```
  """
  @type delete_stack_opts :: [
    retain_resources: [binary, ...],
    role_arn: binary
  ]
  @spec delete_stack(stack_name :: binary, opts :: delete_stack_opts) :: ExAws.Operation.Query.t
  def delete_stack(stack_name, opts \\ []) do
    [{"StackName", stack_name} | opts]
    |> Enum.flat_map(&format_param/1)
    |> request(:delete_stack)
  end

  @doc """
  Returns the description for the specified stack; if no stack name was specified,
  then it returns the description for all the stacks created.

  Please read: http://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_DescribeStacks.html

  Examples:
  ```
  # Get all stacks
  Cloudformation.describe_stacks

  # Get a stack called "Test"
  Cloudformation.describe_stacks([stack_name: "Test"])
  ```
  """
  @type describe_stacks_opts :: [
    stack_name: binary,
    next_token: binary
  ]
  @spec describe_stacks(opts :: describe_stacks_opts) :: ExAws.Operation.Query.t
  def describe_stacks(opts \\ []) do
    opts |> format |> request(:describe_stacks)
  end

  @doc """
  Describes a specified stack's resource.
  Resource of the stack is specified by a logical record ID.

  Please read: http://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_DescribeStackResource.html

  Examples:
  ```
  Cloudformation.describe_stack_resource("Test", "logical_resource_Id")
  ```
  """
  @spec describe_stack_resource(stack_name :: binary, logical_resource_id :: binary) :: ExAws.Operation.Query.t
  def describe_stack_resource(stack_name, logical_resource_id) do
    [{"StackName", stack_name}, {"LogicalResourceId", logical_resource_id}]
    |> request(:describe_stack_resource)
  end


  @doc """
  Describes specified stack's resources. You either have to specify a stack name
  or a physical resource ID.

  Please read: http://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_DescribeStackResources.html

  Example:
  ```
  # Describe resources by stack name
  Cloudformation.describe_stack_resources([stack_name: "Test"])

  # Describe resources with a logical resource ID
  Cloudformation.describe_stack_resources([stack_name: "Test", logical_resource_id: "test_resource_id"])

  # Describe resources with a physical resource ID
  Cloudformation.describe_stack_resources([physical_resource_id: "test_resource_id"])
  ```
  """
  @type describe_stack_resources_opts :: [
    stack_name: binary,
    logical_resource_id: binary,
    physical_resource_id: binary
  ]
  @spec describe_stack_resources(opts :: describe_stack_resources_opts) :: ExAws.Operation.Query.t
  def describe_stack_resources(opts \\ []) do
    opts |> format |> request(:describe_stack_resources)
  end

  @doc """
  Gets the template body for a specified stack. Can get a template for
  running or deleted stacks.

  Please read: http://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_GetTemplate.html

  Example:
  ```
  # Get a template with stack name and template stage param
  Cloudformation.get_template([stack_name: "Test", template_stage: :processed])
  ```
  """
  @type get_template_opts :: [
    change_set_name: binary,
    stack_name: binary,
    template_stage: [:original | :processed]
  ]
  @spec get_template(opts :: get_template_opts) :: ExAws.Operation.Query.t
  def get_template(opts \\ []) do
    opts
    |> Enum.flat_map(&format_param/1)
    |> request(:get_template)
  end

  @doc """
  Gets information about a new or existing template. Useful for viewing
  parameter information, such as default parameter values and parameter
  types

  Please read: http://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_GetTemplateSummary.html

  Example
  # Get template summary with stack name
  Cloudformation.get_template_summary([stack_name: "Test"])

  """
  @type get_template_summary_opts :: [
    stack_name: binary,
    template_body: binary,
    template_url: binary
  ]
  @spec get_template_summary(opts :: get_template_summary_opts) :: ExAws.Operation.Query.t
  def get_template_summary(opts \\ []) do
    opts
    |> Enum.flat_map(&format_param/1)
    |> request(:get_template_summary)
  end

  @doc """
  Gets the summary information for stacks. If no :stack_status_filters are passed in,
  then all stacks are returned (existing and stacks have have been deleted in the last 90 days)

  Please read: http://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_ListStacks.html

  Examples:
  ```
  # List all stacks
  Cloudformation.list_stacks

  # List stacks with some stack status filters
  Cloudformation.list_stacks([stack_status_filters: [:delete_complete]])
  ```
  """
  @type list_stacks_opts :: [
    next_token: binary,
    stack_status_filters: [ExAws.Cloudformation.Parsers.stack_status, ...]
  ]
  @spec list_stacks(opts :: list_stacks_opts) :: ExAws.Operation.Query.t
  def list_stacks(opts \\ []) do
    opts
    |> Enum.flat_map(&format_param/1)
    |> request(:list_stacks)
  end

  @doc """
  Lists summary of all of the resources for a specified stack

  Please read: http://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_ListStackResources.html

  Examples:
  ```
  Cloudformation.list_stack_resources("test_stack")

  Cloudformation.list_stack_resources("test_stack", [next_token: "token"])
  ```
  """
  @spec list_stack_resources(stack_name :: binary, opts :: [next_token: binary]) :: ExAws.Operation.Query.t
  def list_stack_resources(stack_name, opts \\ []) do
    [{"StackName", stack_name} | opts]
    |> Enum.flat_map(&format_param/1)
    |> request(:list_stack_resources)
  end

  ########################
  ### Helper Functions ###
  ########################

  defp request(params, action) do
    action_string = action |> Atom.to_string |> Macro.camelize

    %ExAws.Operation.Query{
      path: "/",
      params: params |> filter_nil_params |> Map.put("Action", action_string) |> Map.put("Version", @version),
      service: :cloudformation,
      action: action,
      parser: &ExAws.Cloudformation.Parsers.parse/3
    }
  end

  ########################
  ### Format Functions ###
  ########################

  defp format_param({:stack_status_filters, filters}) do
    filters
    |> Enum.map(&upcase/1)
    |> format(prefix: "StackStatusFilter.member")
  end

  # TODO !deprecated! Remove in 1.2
  defp format_param({:status_filter, filters}) do
    IO.warn(
      "(ExAws.Cloudformation) The :status_filter param is DEPRECATED! Please use :stack_status_filters instead
        For example: list_stacks(status_filter: [...]) should be changed to list_stacks(stack_status_filters: [...])"
    )
    format_param({:stack_status_filters, filters})
  end
  # TODO !deprecated! Remove in 1.2


  defp format_param({:capabilities, capabilities}) do
    capabilities
    |> Enum.map(&upcase/1)
    |> format(prefix: "Capabilities.member")
  end

  defp format_param({:tags, tags}) do
    tags
    |> Enum.map(fn {key, value} -> [key: maybe_stringify(key), value: value] end)
    |> format(prefix: "Tags.member")
  end

  defp format_param({:template_stage, template_stage}) do
    [{"TemplateStage", camelize_key(template_stage)}]
  end

  defp format_param({key, parameters}) do
    format([{key, parameters}])
  end

end
