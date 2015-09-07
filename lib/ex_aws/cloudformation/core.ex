defmodule ExAws.Cloudformation.Core do
  @actions [
    "CancelUpdateStack",
    "CreateStack",
    "DeleteStack",
    "DescribeStackEvents",
    "DescribeStackResource",
    "DescribeStackResources",
    "DescribeStacks",
    "EstimateTemplateCost",
    "GetStackPolicy",
    "GetTemplate",
    "GetTemplateSummary",
    "ListStackResources",
    "ListStacks",
    "SetStackPolicy",
    "SignalResource",
    "UpdateStack",
    "ValidateTemplate"]

  @moduledoc """
  ## AWS CloudFormation

  AWS CloudFormation

  AWS CloudFormation enables you to create and manage AWS infrastructure
  deployments predictably and repeatedly. AWS CloudFormation helps you
  leverage AWS products such as Amazon EC2, EBS, Amazon SNS, ELB, and Auto
  Scaling to build highly-reliable, highly scalable, cost effective
  applications without worrying about creating and configuring the underlying
  AWS infrastructure.

  With AWS CloudFormation, you declare all of your resources and dependencies
  in a template file. The template defines a collection of resources as a
  single unit called a stack. AWS CloudFormation creates and deletes all
  member resources of the stack together and manages all dependencies between
  the resources for you.

  For more information about this product, go to the [CloudFormation Product
  Page](http://aws.amazon.com/cloudformation/).

  Amazon CloudFormation makes use of other AWS products. If you need
  additional technical information about a specific AWS product, you can find
  the product's technical documentation at
  [http://aws.amazon.com/documentation/](http://aws.amazon.com/documentation/).
  """

  @type allowed_value :: binary

  @type allowed_values :: [allowed_value]

  @type already_exists_exception :: [
  ]

  @type cancel_update_stack_input :: [
    stack_name: stack_name,
  ]

  @type capabilities :: [capability]

  @type capabilities_reason :: binary

  @type capability :: binary

  @type create_stack_input :: [
    capabilities: capabilities,
    disable_rollback: disable_rollback,
    notification_ar_ns: notification_ar_ns,
    on_failure: on_failure,
    parameters: parameters,
    stack_name: stack_name,
    stack_policy_body: stack_policy_body,
    stack_policy_url: stack_policy_url,
    tags: tags,
    template_body: template_body,
    template_url: template_url,
    timeout_in_minutes: timeout_minutes,
  ]

  @type create_stack_output :: [
    stack_id: stack_id,
  ]

  @type creation_time :: integer

  @type delete_stack_input :: [
    stack_name: stack_name,
  ]

  @type deletion_time :: integer

  @type describe_stack_events_input :: [
    next_token: next_token,
    stack_name: stack_name,
  ]

  @type describe_stack_events_output :: [
    next_token: next_token,
    stack_events: stack_events,
  ]

  @type describe_stack_resource_input :: [
    logical_resource_id: logical_resource_id,
    stack_name: stack_name,
  ]

  @type describe_stack_resource_output :: [
    stack_resource_detail: stack_resource_detail,
  ]

  @type describe_stack_resources_input :: [
    logical_resource_id: logical_resource_id,
    physical_resource_id: physical_resource_id,
    stack_name: stack_name,
  ]

  @type describe_stack_resources_output :: [
    stack_resources: stack_resources,
  ]

  @type describe_stacks_input :: [
    next_token: next_token,
    stack_name: stack_name,
  ]

  @type describe_stacks_output :: [
    next_token: next_token,
    stacks: stacks,
  ]

  @type description :: binary

  @type disable_rollback :: boolean

  @type estimate_template_cost_input :: [
    parameters: parameters,
    template_body: template_body,
    template_url: template_url,
  ]

  @type estimate_template_cost_output :: [
    url: url,
  ]

  @type event_id :: binary

  @type get_stack_policy_input :: [
    stack_name: stack_name,
  ]

  @type get_stack_policy_output :: [
    stack_policy_body: stack_policy_body,
  ]

  @type get_template_input :: [
    stack_name: stack_name,
  ]

  @type get_template_output :: [
    template_body: template_body,
  ]

  @type get_template_summary_input :: [
    stack_name: stack_name_or_id,
    template_body: template_body,
    template_url: template_url,
  ]

  @type get_template_summary_output :: [
    capabilities: capabilities,
    capabilities_reason: capabilities_reason,
    description: description,
    metadata: metadata,
    parameters: parameter_declarations,
    version: version,
  ]

  @type insufficient_capabilities_exception :: [
  ]

  @type last_updated_time :: integer

  @type limit_exceeded_exception :: [
  ]

  @type list_stack_resources_input :: [
    next_token: next_token,
    stack_name: stack_name,
  ]

  @type list_stack_resources_output :: [
    next_token: next_token,
    stack_resource_summaries: stack_resource_summaries,
  ]

  @type list_stacks_input :: [
    next_token: next_token,
    stack_status_filter: stack_status_filter,
  ]

  @type list_stacks_output :: [
    next_token: next_token,
    stack_summaries: stack_summaries,
  ]

  @type logical_resource_id :: binary

  @type metadata :: binary

  @type next_token :: binary

  @type no_echo :: boolean

  @type notification_arn :: binary

  @type notification_ar_ns :: [notification_arn]

  @type on_failure :: binary

  @type output :: [
    description: description,
    output_key: output_key,
    output_value: output_value,
  ]

  @type output_key :: binary

  @type output_value :: binary

  @type outputs :: [output]

  @type parameter :: [
    parameter_key: parameter_key,
    parameter_value: parameter_value,
    use_previous_value: use_previous_value,
  ]

  @type parameter_constraints :: [
    allowed_values: allowed_values,
  ]

  @type parameter_declaration :: [
    default_value: parameter_value,
    description: description,
    no_echo: no_echo,
    parameter_constraints: parameter_constraints,
    parameter_key: parameter_key,
    parameter_type: parameter_type,
  ]

  @type parameter_declarations :: [parameter_declaration]

  @type parameter_key :: binary

  @type parameter_type :: binary

  @type parameter_value :: binary

  @type parameters :: [parameter]

  @type physical_resource_id :: binary

  @type resource_properties :: binary

  @type resource_signal_status :: binary

  @type resource_signal_unique_id :: binary

  @type resource_status :: binary

  @type resource_status_reason :: binary

  @type resource_type :: binary

  @type set_stack_policy_input :: [
    stack_name: stack_name,
    stack_policy_body: stack_policy_body,
    stack_policy_url: stack_policy_url,
  ]

  @type signal_resource_input :: [
    logical_resource_id: logical_resource_id,
    stack_name: stack_name_or_id,
    status: resource_signal_status,
    unique_id: resource_signal_unique_id,
  ]

  @type stack :: [
    capabilities: capabilities,
    creation_time: creation_time,
    description: description,
    disable_rollback: disable_rollback,
    last_updated_time: last_updated_time,
    notification_ar_ns: notification_ar_ns,
    outputs: outputs,
    parameters: parameters,
    stack_id: stack_id,
    stack_name: stack_name,
    stack_status: stack_status,
    stack_status_reason: stack_status_reason,
    tags: tags,
    timeout_in_minutes: timeout_minutes,
  ]

  @type stack_event :: [
    event_id: event_id,
    logical_resource_id: logical_resource_id,
    physical_resource_id: physical_resource_id,
    resource_properties: resource_properties,
    resource_status: resource_status,
    resource_status_reason: resource_status_reason,
    resource_type: resource_type,
    stack_id: stack_id,
    stack_name: stack_name,
    timestamp: timestamp,
  ]

  @type stack_events :: [stack_event]

  @type stack_id :: binary

  @type stack_name :: binary

  @type stack_name_or_id :: binary

  @type stack_policy_body :: binary

  @type stack_policy_during_update_body :: binary

  @type stack_policy_during_update_url :: binary

  @type stack_policy_url :: binary

  @type stack_resource :: [
    description: description,
    logical_resource_id: logical_resource_id,
    physical_resource_id: physical_resource_id,
    resource_status: resource_status,
    resource_status_reason: resource_status_reason,
    resource_type: resource_type,
    stack_id: stack_id,
    stack_name: stack_name,
    timestamp: timestamp,
  ]

  @type stack_resource_detail :: [
    description: description,
    last_updated_timestamp: timestamp,
    logical_resource_id: logical_resource_id,
    metadata: metadata,
    physical_resource_id: physical_resource_id,
    resource_status: resource_status,
    resource_status_reason: resource_status_reason,
    resource_type: resource_type,
    stack_id: stack_id,
    stack_name: stack_name,
  ]

  @type stack_resource_summaries :: [stack_resource_summary]

  @type stack_resource_summary :: [
    last_updated_timestamp: timestamp,
    logical_resource_id: logical_resource_id,
    physical_resource_id: physical_resource_id,
    resource_status: resource_status,
    resource_status_reason: resource_status_reason,
    resource_type: resource_type,
  ]

  @type stack_resources :: [stack_resource]

  @type stack_status :: binary

  @type stack_status_filter :: [stack_status]

  @type stack_status_reason :: binary

  @type stack_summaries :: [stack_summary]

  @type stack_summary :: [
    creation_time: creation_time,
    deletion_time: deletion_time,
    last_updated_time: last_updated_time,
    stack_id: stack_id,
    stack_name: stack_name,
    stack_status: stack_status,
    stack_status_reason: stack_status_reason,
    template_description: template_description,
  ]

  @type stacks :: [stack]

  @type tag :: [
    key: tag_key,
    value: tag_value,
  ]

  @type tag_key :: binary

  @type tag_value :: binary

  @type tags :: [tag]

  @type template_body :: binary

  @type template_description :: binary

  @type template_parameter :: [
    default_value: parameter_value,
    description: description,
    no_echo: no_echo,
    parameter_key: parameter_key,
  ]

  @type template_parameters :: [template_parameter]

  @type template_url :: binary

  @type timeout_minutes :: integer

  @type timestamp :: integer

  @type update_stack_input :: [
    capabilities: capabilities,
    notification_ar_ns: notification_ar_ns,
    parameters: parameters,
    stack_name: stack_name,
    stack_policy_body: stack_policy_body,
    stack_policy_during_update_body: stack_policy_during_update_body,
    stack_policy_during_update_url: stack_policy_during_update_url,
    stack_policy_url: stack_policy_url,
    template_body: template_body,
    template_url: template_url,
    use_previous_template: use_previous_template,
  ]

  @type update_stack_output :: [
    stack_id: stack_id,
  ]

  @type url :: binary

  @type use_previous_template :: boolean

  @type use_previous_value :: boolean

  @type validate_template_input :: [
    template_body: template_body,
    template_url: template_url,
  ]

  @type validate_template_output :: [
    capabilities: capabilities,
    capabilities_reason: capabilities_reason,
    description: description,
    parameters: template_parameters,
  ]

  @type version :: binary




  @doc """
  CancelUpdateStack

  Cancels an update on the specified stack. If the call completes
  successfully, the stack will roll back the update and revert to the
  previous stack configuration.

  Note:Only stacks that are in the UPDATE_IN_PROGRESS state can be canceled.
  """

  @spec cancel_update_stack(client :: ExAws.Cloudformation.t, input :: cancel_update_stack_input) :: ExAws.Request.Query.response_t
  def cancel_update_stack(client, input) do
    request(client, "/", "CancelUpdateStack", input)
  end

  @doc """
  Same as `cancel_update_stack/2` but raise on error.
  """
  @spec cancel_update_stack!(client :: ExAws.Cloudformation.t, input :: cancel_update_stack_input) :: ExAws.Request.Query.success_t | no_return
  def cancel_update_stack!(client, input) do
    case cancel_update_stack(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateStack

  Creates a stack as specified in the template. After the call completes
  successfully, the stack creation starts. You can check the status of the
  stack via the `DescribeStacks` API.
  """

  @spec create_stack(client :: ExAws.Cloudformation.t, input :: create_stack_input) :: ExAws.Request.Query.response_t
  def create_stack(client, input) do
    request(client, "/", "CreateStack", input)
  end

  @doc """
  Same as `create_stack/2` but raise on error.
  """
  @spec create_stack!(client :: ExAws.Cloudformation.t, input :: create_stack_input) :: ExAws.Request.Query.success_t | no_return
  def create_stack!(client, input) do
    case create_stack(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteStack

  Deletes a specified stack. Once the call completes successfully, stack
  deletion starts. Deleted stacks do not show up in the `DescribeStacks` API
  if the deletion has been completed successfully.
  """

  @spec delete_stack(client :: ExAws.Cloudformation.t, input :: delete_stack_input) :: ExAws.Request.Query.response_t
  def delete_stack(client, input) do
    request(client, "/", "DeleteStack", input)
  end

  @doc """
  Same as `delete_stack/2` but raise on error.
  """
  @spec delete_stack!(client :: ExAws.Cloudformation.t, input :: delete_stack_input) :: ExAws.Request.Query.success_t | no_return
  def delete_stack!(client, input) do
    case delete_stack(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeStackEvents

  Returns all stack related events for a specified stack. For more
  information about a stack's event history, go to
  [Stacks](http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/concept-stack.html)
  in the AWS CloudFormation User Guide.

  Note:You can list events for stacks that have failed to create or have been
  deleted by specifying the unique stack identifier (stack ID).
  """

  @spec describe_stack_events(client :: ExAws.Cloudformation.t, input :: describe_stack_events_input) :: ExAws.Request.Query.response_t
  def describe_stack_events(client, input) do
    request(client, "/", "DescribeStackEvents", input)
  end

  @doc """
  Same as `describe_stack_events/2` but raise on error.
  """
  @spec describe_stack_events!(client :: ExAws.Cloudformation.t, input :: describe_stack_events_input) :: ExAws.Request.Query.success_t | no_return
  def describe_stack_events!(client, input) do
    case describe_stack_events(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeStackResource

  Returns a description of the specified resource in the specified stack.

  For deleted stacks, DescribeStackResource returns resource information for
  up to 90 days after the stack has been deleted.
  """

  @spec describe_stack_resource(client :: ExAws.Cloudformation.t, input :: describe_stack_resource_input) :: ExAws.Request.Query.response_t
  def describe_stack_resource(client, input) do
    request(client, "/", "DescribeStackResource", input)
  end

  @doc """
  Same as `describe_stack_resource/2` but raise on error.
  """
  @spec describe_stack_resource!(client :: ExAws.Cloudformation.t, input :: describe_stack_resource_input) :: ExAws.Request.Query.success_t | no_return
  def describe_stack_resource!(client, input) do
    case describe_stack_resource(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeStackResources

  Returns AWS resource descriptions for running and deleted stacks. If
  `StackName` is specified, all the associated resources that are part of the
  stack are returned. If `PhysicalResourceId` is specified, the associated
  resources of the stack that the resource belongs to are returned.

  Note:Only the first 100 resources will be returned. If your stack has more
  resources than this, you should use `ListStackResources` instead. For
  deleted stacks, `DescribeStackResources` returns resource information for
  up to 90 days after the stack has been deleted.

  You must specify either `StackName` or `PhysicalResourceId`, but not both.
  In addition, you can specify `LogicalResourceId` to filter the returned
  result. For more information about resources, the `LogicalResourceId` and
  `PhysicalResourceId`, go to the [AWS CloudFormation User
  Guide](http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide).

  Note:A `ValidationError` is returned if you specify both `StackName` and
  `PhysicalResourceId` in the same request.
  """

  @spec describe_stack_resources(client :: ExAws.Cloudformation.t, input :: describe_stack_resources_input) :: ExAws.Request.Query.response_t
  def describe_stack_resources(client, input) do
    request(client, "/", "DescribeStackResources", input)
  end

  @doc """
  Same as `describe_stack_resources/2` but raise on error.
  """
  @spec describe_stack_resources!(client :: ExAws.Cloudformation.t, input :: describe_stack_resources_input) :: ExAws.Request.Query.success_t | no_return
  def describe_stack_resources!(client, input) do
    case describe_stack_resources(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeStacks

  Returns the description for the specified stack; if no stack name was
  specified, then it returns the description for all the stacks created.
  """

  @spec describe_stacks(client :: ExAws.Cloudformation.t, input :: describe_stacks_input) :: ExAws.Request.Query.response_t
  def describe_stacks(client, input) do
    request(client, "/", "DescribeStacks", input)
  end

  @doc """
  Same as `describe_stacks/2` but raise on error.
  """
  @spec describe_stacks!(client :: ExAws.Cloudformation.t, input :: describe_stacks_input) :: ExAws.Request.Query.success_t | no_return
  def describe_stacks!(client, input) do
    case describe_stacks(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  EstimateTemplateCost

  Returns the estimated monthly cost of a template. The return value is an
  AWS Simple Monthly Calculator URL with a query string that describes the
  resources required to run the template.
  """

  @spec estimate_template_cost(client :: ExAws.Cloudformation.t, input :: estimate_template_cost_input) :: ExAws.Request.Query.response_t
  def estimate_template_cost(client, input) do
    request(client, "/", "EstimateTemplateCost", input)
  end

  @doc """
  Same as `estimate_template_cost/2` but raise on error.
  """
  @spec estimate_template_cost!(client :: ExAws.Cloudformation.t, input :: estimate_template_cost_input) :: ExAws.Request.Query.success_t | no_return
  def estimate_template_cost!(client, input) do
    case estimate_template_cost(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetStackPolicy

  Returns the stack policy for a specified stack. If a stack doesn't have a
  policy, a null value is returned.
  """

  @spec get_stack_policy(client :: ExAws.Cloudformation.t, input :: get_stack_policy_input) :: ExAws.Request.Query.response_t
  def get_stack_policy(client, input) do
    request(client, "/", "GetStackPolicy", input)
  end

  @doc """
  Same as `get_stack_policy/2` but raise on error.
  """
  @spec get_stack_policy!(client :: ExAws.Cloudformation.t, input :: get_stack_policy_input) :: ExAws.Request.Query.success_t | no_return
  def get_stack_policy!(client, input) do
    case get_stack_policy(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetTemplate

  Returns the template body for a specified stack. You can get the template
  for running or deleted stacks.

  For deleted stacks, GetTemplate returns the template for up to 90 days
  after the stack has been deleted.

  Note: If the template does not exist, a `ValidationError` is returned.
  """

  @spec get_template(client :: ExAws.Cloudformation.t, input :: get_template_input) :: ExAws.Request.Query.response_t
  def get_template(client, input) do
    request(client, "/", "GetTemplate", input)
  end

  @doc """
  Same as `get_template/2` but raise on error.
  """
  @spec get_template!(client :: ExAws.Cloudformation.t, input :: get_template_input) :: ExAws.Request.Query.success_t | no_return
  def get_template!(client, input) do
    case get_template(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetTemplateSummary

  Returns information about a new or existing template. The
  `GetTemplateSummary` action is useful for viewing parameter information,
  such as default parameter values and parameter types, before you create or
  update a stack.

  You can use the `GetTemplateSummary` action when you submit a template, or
  you can get template information for a running or deleted stack.

  For deleted stacks, `GetTemplateSummary` returns the template information
  for up to 90 days after the stack has been deleted. If the template does
  not exist, a `ValidationError` is returned.
  """

  @spec get_template_summary(client :: ExAws.Cloudformation.t, input :: get_template_summary_input) :: ExAws.Request.Query.response_t
  def get_template_summary(client, input) do
    request(client, "/", "GetTemplateSummary", input)
  end

  @doc """
  Same as `get_template_summary/2` but raise on error.
  """
  @spec get_template_summary!(client :: ExAws.Cloudformation.t, input :: get_template_summary_input) :: ExAws.Request.Query.success_t | no_return
  def get_template_summary!(client, input) do
    case get_template_summary(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListStackResources

  Returns descriptions of all resources of the specified stack.

  For deleted stacks, ListStackResources returns resource information for up
  to 90 days after the stack has been deleted.
  """

  @spec list_stack_resources(client :: ExAws.Cloudformation.t, input :: list_stack_resources_input) :: ExAws.Request.Query.response_t
  def list_stack_resources(client, input) do
    request(client, "/", "ListStackResources", input)
  end

  @doc """
  Same as `list_stack_resources/2` but raise on error.
  """
  @spec list_stack_resources!(client :: ExAws.Cloudformation.t, input :: list_stack_resources_input) :: ExAws.Request.Query.success_t | no_return
  def list_stack_resources!(client, input) do
    case list_stack_resources(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListStacks

  Returns the summary information for stacks whose status matches the
  specified StackStatusFilter. Summary information for stacks that have been
  deleted is kept for 90 days after the stack is deleted. If no
  StackStatusFilter is specified, summary information for all stacks is
  returned (including existing stacks and stacks that have been deleted).
  """

  @spec list_stacks(client :: ExAws.Cloudformation.t, input :: list_stacks_input) :: ExAws.Request.Query.response_t
  def list_stacks(client, input) do
    request(client, "/", "ListStacks", input)
  end

  @doc """
  Same as `list_stacks/2` but raise on error.
  """
  @spec list_stacks!(client :: ExAws.Cloudformation.t, input :: list_stacks_input) :: ExAws.Request.Query.success_t | no_return
  def list_stacks!(client, input) do
    case list_stacks(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  SetStackPolicy

  Sets a stack policy for a specified stack.
  """

  @spec set_stack_policy(client :: ExAws.Cloudformation.t, input :: set_stack_policy_input) :: ExAws.Request.Query.response_t
  def set_stack_policy(client, input) do
    request(client, "/", "SetStackPolicy", input)
  end

  @doc """
  Same as `set_stack_policy/2` but raise on error.
  """
  @spec set_stack_policy!(client :: ExAws.Cloudformation.t, input :: set_stack_policy_input) :: ExAws.Request.Query.success_t | no_return
  def set_stack_policy!(client, input) do
    case set_stack_policy(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  SignalResource

  Sends a signal to the specified resource with a success or failure status.
  You can use the SignalResource API in conjunction with a creation policy or
  update policy. AWS CloudFormation doesn't proceed with a stack creation or
  update until resources receive the required number of signals or the
  timeout period is exceeded. The SignalResource API is useful in cases where
  you want to send signals from anywhere other than an Amazon EC2 instance.
  """

  @spec signal_resource(client :: ExAws.Cloudformation.t, input :: signal_resource_input) :: ExAws.Request.Query.response_t
  def signal_resource(client, input) do
    request(client, "/", "SignalResource", input)
  end

  @doc """
  Same as `signal_resource/2` but raise on error.
  """
  @spec signal_resource!(client :: ExAws.Cloudformation.t, input :: signal_resource_input) :: ExAws.Request.Query.success_t | no_return
  def signal_resource!(client, input) do
    case signal_resource(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateStack

  Updates a stack as specified in the template. After the call completes
  successfully, the stack update starts. You can check the status of the
  stack via the `DescribeStacks` action.

  To get a copy of the template for an existing stack, you can use the
  `GetTemplate` action.

  Tags that were associated with this stack during creation time will still
  be associated with the stack after an `UpdateStack` operation.

  For more information about creating an update template, updating a stack,
  and monitoring the progress of the update, see [Updating a
  Stack](http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-updating-stacks.html).
  """

  @spec update_stack(client :: ExAws.Cloudformation.t, input :: update_stack_input) :: ExAws.Request.Query.response_t
  def update_stack(client, input) do
    request(client, "/", "UpdateStack", input)
  end

  @doc """
  Same as `update_stack/2` but raise on error.
  """
  @spec update_stack!(client :: ExAws.Cloudformation.t, input :: update_stack_input) :: ExAws.Request.Query.success_t | no_return
  def update_stack!(client, input) do
    case update_stack(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ValidateTemplate

  Validates a specified template.
  """

  @spec validate_template(client :: ExAws.Cloudformation.t, input :: validate_template_input) :: ExAws.Request.Query.response_t
  def validate_template(client, input) do
    request(client, "/", "ValidateTemplate", input)
  end

  @doc """
  Same as `validate_template/2` but raise on error.
  """
  @spec validate_template!(client :: ExAws.Cloudformation.t, input :: validate_template_input) :: ExAws.Request.Query.success_t | no_return
  def validate_template!(client, input) do
    case validate_template(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  defp request(%{__struct__: client_module} = client, uri, action, input) do
    apply(client_module, :request, [client, uri, action, input])
  end
end
