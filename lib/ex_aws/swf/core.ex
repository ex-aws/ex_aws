defmodule ExAws.SWF.Core do
  import ExAws.Core.JSON, only: [format_input: 1]
  @actions [
    "CountClosedWorkflowExecutions",
    "CountOpenWorkflowExecutions",
    "CountPendingActivityTasks",
    "CountPendingDecisionTasks",
    "DeprecateActivityType",
    "DeprecateDomain",
    "DeprecateWorkflowType",
    "DescribeActivityType",
    "DescribeDomain",
    "DescribeWorkflowExecution",
    "DescribeWorkflowType",
    "GetWorkflowExecutionHistory",
    "ListActivityTypes",
    "ListClosedWorkflowExecutions",
    "ListDomains",
    "ListOpenWorkflowExecutions",
    "ListWorkflowTypes",
    "PollForActivityTask",
    "PollForDecisionTask",
    "RecordActivityTaskHeartbeat",
    "RegisterActivityType",
    "RegisterDomain",
    "RegisterWorkflowType",
    "RequestCancelWorkflowExecution",
    "RespondActivityTaskCanceled",
    "RespondActivityTaskCompleted",
    "RespondActivityTaskFailed",
    "RespondDecisionTaskCompleted",
    "SignalWorkflowExecution",
    "StartWorkflowExecution",
    "TerminateWorkflowExecution"]

  @moduledoc """
  ## Amazon Simple Workflow Service

  Amazon Simple Workflow Service

  The Amazon Simple Workflow Service (Amazon SWF) makes it easy to build
  applications that use Amazon's cloud to coordinate work across distributed
  components. In Amazon SWF, a *task* represents a logical unit of work that
  is performed by a component of your workflow. Coordinating tasks in a
  workflow involves managing intertask dependencies, scheduling, and
  concurrency in accordance with the logical flow of the application.

  Amazon SWF gives you full control over implementing tasks and coordinating
  them without worrying about underlying complexities such as tracking their
  progress and maintaining their state.

  This documentation serves as reference only. For a broader overview of the
  Amazon SWF programming model, see the [Amazon SWF Developer
  Guide](http://docs.aws.amazon.com/amazonswf/latest/developerguide/).
  """

  @type activity_id :: binary

  @type activity_task :: [
    activity_id: activity_id,
    activity_type: activity_type,
    input: data,
    started_event_id: event_id,
    task_token: task_token,
    workflow_execution: workflow_execution,
  ]

  @type activity_task_cancel_requested_event_attributes :: [
    activity_id: activity_id,
    decision_task_completed_event_id: event_id,
  ]

  @type activity_task_canceled_event_attributes :: [
    details: data,
    latest_cancel_requested_event_id: event_id,
    scheduled_event_id: event_id,
    started_event_id: event_id,
  ]

  @type activity_task_completed_event_attributes :: [
    result: data,
    scheduled_event_id: event_id,
    started_event_id: event_id,
  ]

  @type activity_task_failed_event_attributes :: [
    details: data,
    reason: failure_reason,
    scheduled_event_id: event_id,
    started_event_id: event_id,
  ]

  @type activity_task_scheduled_event_attributes :: [
    activity_id: activity_id,
    activity_type: activity_type,
    control: data,
    decision_task_completed_event_id: event_id,
    heartbeat_timeout: duration_in_seconds_optional,
    input: data,
    schedule_to_close_timeout: duration_in_seconds_optional,
    schedule_to_start_timeout: duration_in_seconds_optional,
    start_to_close_timeout: duration_in_seconds_optional,
    task_list: task_list,
    task_priority: task_priority,
  ]

  @type activity_task_started_event_attributes :: [
    identity: identity,
    scheduled_event_id: event_id,
  ]

  @type activity_task_status :: [
    cancel_requested: canceled,
  ]

  @type activity_task_timed_out_event_attributes :: [
    details: limited_data,
    scheduled_event_id: event_id,
    started_event_id: event_id,
    timeout_type: activity_task_timeout_type,
  ]

  @type activity_task_timeout_type :: binary

  @type activity_type :: [
    name: name,
    version: version,
  ]

  @type activity_type_configuration :: [
    default_task_heartbeat_timeout: duration_in_seconds_optional,
    default_task_list: task_list,
    default_task_priority: task_priority,
    default_task_schedule_to_close_timeout: duration_in_seconds_optional,
    default_task_schedule_to_start_timeout: duration_in_seconds_optional,
    default_task_start_to_close_timeout: duration_in_seconds_optional,
  ]

  @type activity_type_detail :: [
    configuration: activity_type_configuration,
    type_info: activity_type_info,
  ]

  @type activity_type_info :: [
    activity_type: activity_type,
    creation_date: timestamp,
    deprecation_date: timestamp,
    description: description,
    status: registration_status,
  ]

  @type activity_type_info_list :: [activity_type_info]

  @type activity_type_infos :: [
    next_page_token: page_token,
    type_infos: activity_type_info_list,
  ]

  @type arn :: binary

  @type cancel_timer_decision_attributes :: [
    timer_id: timer_id,
  ]

  @type cancel_timer_failed_cause :: binary

  @type cancel_timer_failed_event_attributes :: [
    cause: cancel_timer_failed_cause,
    decision_task_completed_event_id: event_id,
    timer_id: timer_id,
  ]

  @type cancel_workflow_execution_decision_attributes :: [
    details: data,
  ]

  @type cancel_workflow_execution_failed_cause :: binary

  @type cancel_workflow_execution_failed_event_attributes :: [
    cause: cancel_workflow_execution_failed_cause,
    decision_task_completed_event_id: event_id,
  ]

  @type canceled :: boolean

  @type cause_message :: binary

  @type child_policy :: binary

  @type child_workflow_execution_canceled_event_attributes :: [
    details: data,
    initiated_event_id: event_id,
    started_event_id: event_id,
    workflow_execution: workflow_execution,
    workflow_type: workflow_type,
  ]

  @type child_workflow_execution_completed_event_attributes :: [
    initiated_event_id: event_id,
    result: data,
    started_event_id: event_id,
    workflow_execution: workflow_execution,
    workflow_type: workflow_type,
  ]

  @type child_workflow_execution_failed_event_attributes :: [
    details: data,
    initiated_event_id: event_id,
    reason: failure_reason,
    started_event_id: event_id,
    workflow_execution: workflow_execution,
    workflow_type: workflow_type,
  ]

  @type child_workflow_execution_started_event_attributes :: [
    initiated_event_id: event_id,
    workflow_execution: workflow_execution,
    workflow_type: workflow_type,
  ]

  @type child_workflow_execution_terminated_event_attributes :: [
    initiated_event_id: event_id,
    started_event_id: event_id,
    workflow_execution: workflow_execution,
    workflow_type: workflow_type,
  ]

  @type child_workflow_execution_timed_out_event_attributes :: [
    initiated_event_id: event_id,
    started_event_id: event_id,
    timeout_type: workflow_execution_timeout_type,
    workflow_execution: workflow_execution,
    workflow_type: workflow_type,
  ]

  @type close_status :: binary

  @type close_status_filter :: [
    status: close_status,
  ]

  @type complete_workflow_execution_decision_attributes :: [
    result: data,
  ]

  @type complete_workflow_execution_failed_cause :: binary

  @type complete_workflow_execution_failed_event_attributes :: [
    cause: complete_workflow_execution_failed_cause,
    decision_task_completed_event_id: event_id,
  ]

  @type continue_as_new_workflow_execution_decision_attributes :: [
    child_policy: child_policy,
    execution_start_to_close_timeout: duration_in_seconds_optional,
    input: data,
    lambda_role: arn,
    tag_list: tag_list,
    task_list: task_list,
    task_priority: task_priority,
    task_start_to_close_timeout: duration_in_seconds_optional,
    workflow_type_version: version,
  ]

  @type continue_as_new_workflow_execution_failed_cause :: binary

  @type continue_as_new_workflow_execution_failed_event_attributes :: [
    cause: continue_as_new_workflow_execution_failed_cause,
    decision_task_completed_event_id: event_id,
  ]

  @type count :: integer

  @type count_closed_workflow_executions_input :: [
    close_status_filter: close_status_filter,
    close_time_filter: execution_time_filter,
    domain: domain_name,
    execution_filter: workflow_execution_filter,
    start_time_filter: execution_time_filter,
    tag_filter: tag_filter,
    type_filter: workflow_type_filter,
  ]

  @type count_open_workflow_executions_input :: [
    domain: domain_name,
    execution_filter: workflow_execution_filter,
    start_time_filter: execution_time_filter,
    tag_filter: tag_filter,
    type_filter: workflow_type_filter,
  ]

  @type count_pending_activity_tasks_input :: [
    domain: domain_name,
    task_list: task_list,
  ]

  @type count_pending_decision_tasks_input :: [
    domain: domain_name,
    task_list: task_list,
  ]

  @type data :: binary

  @type decision :: [
    cancel_timer_decision_attributes: cancel_timer_decision_attributes,
    cancel_workflow_execution_decision_attributes: cancel_workflow_execution_decision_attributes,
    complete_workflow_execution_decision_attributes: complete_workflow_execution_decision_attributes,
    continue_as_new_workflow_execution_decision_attributes: continue_as_new_workflow_execution_decision_attributes,
    decision_type: decision_type,
    fail_workflow_execution_decision_attributes: fail_workflow_execution_decision_attributes,
    record_marker_decision_attributes: record_marker_decision_attributes,
    request_cancel_activity_task_decision_attributes: request_cancel_activity_task_decision_attributes,
    request_cancel_external_workflow_execution_decision_attributes: request_cancel_external_workflow_execution_decision_attributes,
    schedule_activity_task_decision_attributes: schedule_activity_task_decision_attributes,
    schedule_lambda_function_decision_attributes: schedule_lambda_function_decision_attributes,
    signal_external_workflow_execution_decision_attributes: signal_external_workflow_execution_decision_attributes,
    start_child_workflow_execution_decision_attributes: start_child_workflow_execution_decision_attributes,
    start_timer_decision_attributes: start_timer_decision_attributes,
  ]

  @type decision_list :: [decision]

  @type decision_task :: [
    events: history_event_list,
    next_page_token: page_token,
    previous_started_event_id: event_id,
    started_event_id: event_id,
    task_token: task_token,
    workflow_execution: workflow_execution,
    workflow_type: workflow_type,
  ]

  @type decision_task_completed_event_attributes :: [
    execution_context: data,
    scheduled_event_id: event_id,
    started_event_id: event_id,
  ]

  @type decision_task_scheduled_event_attributes :: [
    start_to_close_timeout: duration_in_seconds_optional,
    task_list: task_list,
    task_priority: task_priority,
  ]

  @type decision_task_started_event_attributes :: [
    identity: identity,
    scheduled_event_id: event_id,
  ]

  @type decision_task_timed_out_event_attributes :: [
    scheduled_event_id: event_id,
    started_event_id: event_id,
    timeout_type: decision_task_timeout_type,
  ]

  @type decision_task_timeout_type :: binary

  @type decision_type :: binary

  @type default_undefined_fault :: [
    message: error_message,
  ]

  @type deprecate_activity_type_input :: [
    activity_type: activity_type,
    domain: domain_name,
  ]

  @type deprecate_domain_input :: [
    name: domain_name,
  ]

  @type deprecate_workflow_type_input :: [
    domain: domain_name,
    workflow_type: workflow_type,
  ]

  @type describe_activity_type_input :: [
    activity_type: activity_type,
    domain: domain_name,
  ]

  @type describe_domain_input :: [
    name: domain_name,
  ]

  @type describe_workflow_execution_input :: [
    domain: domain_name,
    execution: workflow_execution,
  ]

  @type describe_workflow_type_input :: [
    domain: domain_name,
    workflow_type: workflow_type,
  ]

  @type description :: binary

  @type domain_already_exists_fault :: [
    message: error_message,
  ]

  @type domain_configuration :: [
    workflow_execution_retention_period_in_days: duration_in_days,
  ]

  @type domain_deprecated_fault :: [
    message: error_message,
  ]

  @type domain_detail :: [
    configuration: domain_configuration,
    domain_info: domain_info,
  ]

  @type domain_info :: [
    description: description,
    name: domain_name,
    status: registration_status,
  ]

  @type domain_info_list :: [domain_info]

  @type domain_infos :: [
    domain_infos: domain_info_list,
    next_page_token: page_token,
  ]

  @type domain_name :: binary

  @type duration_in_days :: binary

  @type duration_in_seconds :: binary

  @type duration_in_seconds_optional :: binary

  @type error_message :: binary

  @type event_id :: integer

  @type event_type :: binary

  @type execution_status :: binary

  @type execution_time_filter :: [
    latest_date: timestamp,
    oldest_date: timestamp,
  ]

  @type external_workflow_execution_cancel_requested_event_attributes :: [
    initiated_event_id: event_id,
    workflow_execution: workflow_execution,
  ]

  @type external_workflow_execution_signaled_event_attributes :: [
    initiated_event_id: event_id,
    workflow_execution: workflow_execution,
  ]

  @type fail_workflow_execution_decision_attributes :: [
    details: data,
    reason: failure_reason,
  ]

  @type fail_workflow_execution_failed_cause :: binary

  @type fail_workflow_execution_failed_event_attributes :: [
    cause: fail_workflow_execution_failed_cause,
    decision_task_completed_event_id: event_id,
  ]

  @type failure_reason :: binary

  @type function_id :: binary

  @type function_input :: binary

  @type function_name :: binary

  @type get_workflow_execution_history_input :: [
    domain: domain_name,
    execution: workflow_execution,
    maximum_page_size: page_size,
    next_page_token: page_token,
    reverse_order: reverse_order,
  ]

  @type history :: [
    events: history_event_list,
    next_page_token: page_token,
  ]

  @type history_event :: [
    activity_task_cancel_requested_event_attributes: activity_task_cancel_requested_event_attributes,
    activity_task_canceled_event_attributes: activity_task_canceled_event_attributes,
    activity_task_completed_event_attributes: activity_task_completed_event_attributes,
    activity_task_failed_event_attributes: activity_task_failed_event_attributes,
    activity_task_scheduled_event_attributes: activity_task_scheduled_event_attributes,
    activity_task_started_event_attributes: activity_task_started_event_attributes,
    activity_task_timed_out_event_attributes: activity_task_timed_out_event_attributes,
    cancel_timer_failed_event_attributes: cancel_timer_failed_event_attributes,
    cancel_workflow_execution_failed_event_attributes: cancel_workflow_execution_failed_event_attributes,
    child_workflow_execution_canceled_event_attributes: child_workflow_execution_canceled_event_attributes,
    child_workflow_execution_completed_event_attributes: child_workflow_execution_completed_event_attributes,
    child_workflow_execution_failed_event_attributes: child_workflow_execution_failed_event_attributes,
    child_workflow_execution_started_event_attributes: child_workflow_execution_started_event_attributes,
    child_workflow_execution_terminated_event_attributes: child_workflow_execution_terminated_event_attributes,
    child_workflow_execution_timed_out_event_attributes: child_workflow_execution_timed_out_event_attributes,
    complete_workflow_execution_failed_event_attributes: complete_workflow_execution_failed_event_attributes,
    continue_as_new_workflow_execution_failed_event_attributes: continue_as_new_workflow_execution_failed_event_attributes,
    decision_task_completed_event_attributes: decision_task_completed_event_attributes,
    decision_task_scheduled_event_attributes: decision_task_scheduled_event_attributes,
    decision_task_started_event_attributes: decision_task_started_event_attributes,
    decision_task_timed_out_event_attributes: decision_task_timed_out_event_attributes,
    event_id: event_id,
    event_timestamp: timestamp,
    event_type: event_type,
    external_workflow_execution_cancel_requested_event_attributes: external_workflow_execution_cancel_requested_event_attributes,
    external_workflow_execution_signaled_event_attributes: external_workflow_execution_signaled_event_attributes,
    fail_workflow_execution_failed_event_attributes: fail_workflow_execution_failed_event_attributes,
    lambda_function_completed_event_attributes: lambda_function_completed_event_attributes,
    lambda_function_failed_event_attributes: lambda_function_failed_event_attributes,
    lambda_function_scheduled_event_attributes: lambda_function_scheduled_event_attributes,
    lambda_function_started_event_attributes: lambda_function_started_event_attributes,
    lambda_function_timed_out_event_attributes: lambda_function_timed_out_event_attributes,
    marker_recorded_event_attributes: marker_recorded_event_attributes,
    record_marker_failed_event_attributes: record_marker_failed_event_attributes,
    request_cancel_activity_task_failed_event_attributes: request_cancel_activity_task_failed_event_attributes,
    request_cancel_external_workflow_execution_failed_event_attributes: request_cancel_external_workflow_execution_failed_event_attributes,
    request_cancel_external_workflow_execution_initiated_event_attributes: request_cancel_external_workflow_execution_initiated_event_attributes,
    schedule_activity_task_failed_event_attributes: schedule_activity_task_failed_event_attributes,
    schedule_lambda_function_failed_event_attributes: schedule_lambda_function_failed_event_attributes,
    signal_external_workflow_execution_failed_event_attributes: signal_external_workflow_execution_failed_event_attributes,
    signal_external_workflow_execution_initiated_event_attributes: signal_external_workflow_execution_initiated_event_attributes,
    start_child_workflow_execution_failed_event_attributes: start_child_workflow_execution_failed_event_attributes,
    start_child_workflow_execution_initiated_event_attributes: start_child_workflow_execution_initiated_event_attributes,
    start_lambda_function_failed_event_attributes: start_lambda_function_failed_event_attributes,
    start_timer_failed_event_attributes: start_timer_failed_event_attributes,
    timer_canceled_event_attributes: timer_canceled_event_attributes,
    timer_fired_event_attributes: timer_fired_event_attributes,
    timer_started_event_attributes: timer_started_event_attributes,
    workflow_execution_cancel_requested_event_attributes: workflow_execution_cancel_requested_event_attributes,
    workflow_execution_canceled_event_attributes: workflow_execution_canceled_event_attributes,
    workflow_execution_completed_event_attributes: workflow_execution_completed_event_attributes,
    workflow_execution_continued_as_new_event_attributes: workflow_execution_continued_as_new_event_attributes,
    workflow_execution_failed_event_attributes: workflow_execution_failed_event_attributes,
    workflow_execution_signaled_event_attributes: workflow_execution_signaled_event_attributes,
    workflow_execution_started_event_attributes: workflow_execution_started_event_attributes,
    workflow_execution_terminated_event_attributes: workflow_execution_terminated_event_attributes,
    workflow_execution_timed_out_event_attributes: workflow_execution_timed_out_event_attributes,
  ]

  @type history_event_list :: [history_event]

  @type identity :: binary

  @type lambda_function_completed_event_attributes :: [
    result: data,
    scheduled_event_id: event_id,
    started_event_id: event_id,
  ]

  @type lambda_function_failed_event_attributes :: [
    details: data,
    reason: failure_reason,
    scheduled_event_id: event_id,
    started_event_id: event_id,
  ]

  @type lambda_function_scheduled_event_attributes :: [
    decision_task_completed_event_id: event_id,
    id: function_id,
    input: function_input,
    name: function_name,
    start_to_close_timeout: duration_in_seconds_optional,
  ]

  @type lambda_function_started_event_attributes :: [
    scheduled_event_id: event_id,
  ]

  @type lambda_function_timed_out_event_attributes :: [
    scheduled_event_id: event_id,
    started_event_id: event_id,
    timeout_type: lambda_function_timeout_type,
  ]

  @type lambda_function_timeout_type :: binary

  @type limit_exceeded_fault :: [
    message: error_message,
  ]

  @type limited_data :: binary

  @type list_activity_types_input :: [
    domain: domain_name,
    maximum_page_size: page_size,
    name: name,
    next_page_token: page_token,
    registration_status: registration_status,
    reverse_order: reverse_order,
  ]

  @type list_closed_workflow_executions_input :: [
    close_status_filter: close_status_filter,
    close_time_filter: execution_time_filter,
    domain: domain_name,
    execution_filter: workflow_execution_filter,
    maximum_page_size: page_size,
    next_page_token: page_token,
    reverse_order: reverse_order,
    start_time_filter: execution_time_filter,
    tag_filter: tag_filter,
    type_filter: workflow_type_filter,
  ]

  @type list_domains_input :: [
    maximum_page_size: page_size,
    next_page_token: page_token,
    registration_status: registration_status,
    reverse_order: reverse_order,
  ]

  @type list_open_workflow_executions_input :: [
    domain: domain_name,
    execution_filter: workflow_execution_filter,
    maximum_page_size: page_size,
    next_page_token: page_token,
    reverse_order: reverse_order,
    start_time_filter: execution_time_filter,
    tag_filter: tag_filter,
    type_filter: workflow_type_filter,
  ]

  @type list_workflow_types_input :: [
    domain: domain_name,
    maximum_page_size: page_size,
    name: name,
    next_page_token: page_token,
    registration_status: registration_status,
    reverse_order: reverse_order,
  ]

  @type marker_name :: binary

  @type marker_recorded_event_attributes :: [
    decision_task_completed_event_id: event_id,
    details: data,
    marker_name: marker_name,
  ]

  @type name :: binary

  @type open_decision_tasks_count :: integer

  @type operation_not_permitted_fault :: [
    message: error_message,
  ]

  @type page_size :: integer

  @type page_token :: binary

  @type pending_task_count :: [
    count: count,
    truncated: truncated,
  ]

  @type poll_for_activity_task_input :: [
    domain: domain_name,
    identity: identity,
    task_list: task_list,
  ]

  @type poll_for_decision_task_input :: [
    domain: domain_name,
    identity: identity,
    maximum_page_size: page_size,
    next_page_token: page_token,
    reverse_order: reverse_order,
    task_list: task_list,
  ]

  @type record_activity_task_heartbeat_input :: [
    details: limited_data,
    task_token: task_token,
  ]

  @type record_marker_decision_attributes :: [
    details: data,
    marker_name: marker_name,
  ]

  @type record_marker_failed_cause :: binary

  @type record_marker_failed_event_attributes :: [
    cause: record_marker_failed_cause,
    decision_task_completed_event_id: event_id,
    marker_name: marker_name,
  ]

  @type register_activity_type_input :: [
    default_task_heartbeat_timeout: duration_in_seconds_optional,
    default_task_list: task_list,
    default_task_priority: task_priority,
    default_task_schedule_to_close_timeout: duration_in_seconds_optional,
    default_task_schedule_to_start_timeout: duration_in_seconds_optional,
    default_task_start_to_close_timeout: duration_in_seconds_optional,
    description: description,
    domain: domain_name,
    name: name,
    version: version,
  ]

  @type register_domain_input :: [
    description: description,
    name: domain_name,
    workflow_execution_retention_period_in_days: duration_in_days,
  ]

  @type register_workflow_type_input :: [
    default_child_policy: child_policy,
    default_execution_start_to_close_timeout: duration_in_seconds_optional,
    default_lambda_role: arn,
    default_task_list: task_list,
    default_task_priority: task_priority,
    default_task_start_to_close_timeout: duration_in_seconds_optional,
    description: description,
    domain: domain_name,
    name: name,
    version: version,
  ]

  @type registration_status :: binary

  @type request_cancel_activity_task_decision_attributes :: [
    activity_id: activity_id,
  ]

  @type request_cancel_activity_task_failed_cause :: binary

  @type request_cancel_activity_task_failed_event_attributes :: [
    activity_id: activity_id,
    cause: request_cancel_activity_task_failed_cause,
    decision_task_completed_event_id: event_id,
  ]

  @type request_cancel_external_workflow_execution_decision_attributes :: [
    control: data,
    run_id: run_id_optional,
    workflow_id: workflow_id,
  ]

  @type request_cancel_external_workflow_execution_failed_cause :: binary

  @type request_cancel_external_workflow_execution_failed_event_attributes :: [
    cause: request_cancel_external_workflow_execution_failed_cause,
    control: data,
    decision_task_completed_event_id: event_id,
    initiated_event_id: event_id,
    run_id: run_id_optional,
    workflow_id: workflow_id,
  ]

  @type request_cancel_external_workflow_execution_initiated_event_attributes :: [
    control: data,
    decision_task_completed_event_id: event_id,
    run_id: run_id_optional,
    workflow_id: workflow_id,
  ]

  @type request_cancel_workflow_execution_input :: [
    domain: domain_name,
    run_id: run_id_optional,
    workflow_id: workflow_id,
  ]

  @type respond_activity_task_canceled_input :: [
    details: data,
    task_token: task_token,
  ]

  @type respond_activity_task_completed_input :: [
    result: data,
    task_token: task_token,
  ]

  @type respond_activity_task_failed_input :: [
    details: data,
    reason: failure_reason,
    task_token: task_token,
  ]

  @type respond_decision_task_completed_input :: [
    decisions: decision_list,
    execution_context: data,
    task_token: task_token,
  ]

  @type reverse_order :: boolean

  @type run :: [
    run_id: run_id,
  ]

  @type run_id :: binary

  @type run_id_optional :: binary

  @type schedule_activity_task_decision_attributes :: [
    activity_id: activity_id,
    activity_type: activity_type,
    control: data,
    heartbeat_timeout: duration_in_seconds_optional,
    input: data,
    schedule_to_close_timeout: duration_in_seconds_optional,
    schedule_to_start_timeout: duration_in_seconds_optional,
    start_to_close_timeout: duration_in_seconds_optional,
    task_list: task_list,
    task_priority: task_priority,
  ]

  @type schedule_activity_task_failed_cause :: binary

  @type schedule_activity_task_failed_event_attributes :: [
    activity_id: activity_id,
    activity_type: activity_type,
    cause: schedule_activity_task_failed_cause,
    decision_task_completed_event_id: event_id,
  ]

  @type schedule_lambda_function_decision_attributes :: [
    id: function_id,
    input: function_input,
    name: function_name,
    start_to_close_timeout: duration_in_seconds_optional,
  ]

  @type schedule_lambda_function_failed_cause :: binary

  @type schedule_lambda_function_failed_event_attributes :: [
    cause: schedule_lambda_function_failed_cause,
    decision_task_completed_event_id: event_id,
    id: function_id,
    name: function_name,
  ]

  @type signal_external_workflow_execution_decision_attributes :: [
    control: data,
    input: data,
    run_id: run_id_optional,
    signal_name: signal_name,
    workflow_id: workflow_id,
  ]

  @type signal_external_workflow_execution_failed_cause :: binary

  @type signal_external_workflow_execution_failed_event_attributes :: [
    cause: signal_external_workflow_execution_failed_cause,
    control: data,
    decision_task_completed_event_id: event_id,
    initiated_event_id: event_id,
    run_id: run_id_optional,
    workflow_id: workflow_id,
  ]

  @type signal_external_workflow_execution_initiated_event_attributes :: [
    control: data,
    decision_task_completed_event_id: event_id,
    input: data,
    run_id: run_id_optional,
    signal_name: signal_name,
    workflow_id: workflow_id,
  ]

  @type signal_name :: binary

  @type signal_workflow_execution_input :: [
    domain: domain_name,
    input: data,
    run_id: run_id_optional,
    signal_name: signal_name,
    workflow_id: workflow_id,
  ]

  @type start_child_workflow_execution_decision_attributes :: [
    child_policy: child_policy,
    control: data,
    execution_start_to_close_timeout: duration_in_seconds_optional,
    input: data,
    lambda_role: arn,
    tag_list: tag_list,
    task_list: task_list,
    task_priority: task_priority,
    task_start_to_close_timeout: duration_in_seconds_optional,
    workflow_id: workflow_id,
    workflow_type: workflow_type,
  ]

  @type start_child_workflow_execution_failed_cause :: binary

  @type start_child_workflow_execution_failed_event_attributes :: [
    cause: start_child_workflow_execution_failed_cause,
    control: data,
    decision_task_completed_event_id: event_id,
    initiated_event_id: event_id,
    workflow_id: workflow_id,
    workflow_type: workflow_type,
  ]

  @type start_child_workflow_execution_initiated_event_attributes :: [
    child_policy: child_policy,
    control: data,
    decision_task_completed_event_id: event_id,
    execution_start_to_close_timeout: duration_in_seconds_optional,
    input: data,
    lambda_role: arn,
    tag_list: tag_list,
    task_list: task_list,
    task_priority: task_priority,
    task_start_to_close_timeout: duration_in_seconds_optional,
    workflow_id: workflow_id,
    workflow_type: workflow_type,
  ]

  @type start_lambda_function_failed_cause :: binary

  @type start_lambda_function_failed_event_attributes :: [
    cause: start_lambda_function_failed_cause,
    message: cause_message,
    scheduled_event_id: event_id,
  ]

  @type start_timer_decision_attributes :: [
    control: data,
    start_to_fire_timeout: duration_in_seconds,
    timer_id: timer_id,
  ]

  @type start_timer_failed_cause :: binary

  @type start_timer_failed_event_attributes :: [
    cause: start_timer_failed_cause,
    decision_task_completed_event_id: event_id,
    timer_id: timer_id,
  ]

  @type start_workflow_execution_input :: [
    child_policy: child_policy,
    domain: domain_name,
    execution_start_to_close_timeout: duration_in_seconds_optional,
    input: data,
    lambda_role: arn,
    tag_list: tag_list,
    task_list: task_list,
    task_priority: task_priority,
    task_start_to_close_timeout: duration_in_seconds_optional,
    workflow_id: workflow_id,
    workflow_type: workflow_type,
  ]

  @type tag :: binary

  @type tag_filter :: [
    tag: tag,
  ]

  @type tag_list :: [tag]

  @type task_list :: [
    name: name,
  ]

  @type task_priority :: binary

  @type task_token :: binary

  @type terminate_reason :: binary

  @type terminate_workflow_execution_input :: [
    child_policy: child_policy,
    details: data,
    domain: domain_name,
    reason: terminate_reason,
    run_id: run_id_optional,
    workflow_id: workflow_id,
  ]

  @type timer_canceled_event_attributes :: [
    decision_task_completed_event_id: event_id,
    started_event_id: event_id,
    timer_id: timer_id,
  ]

  @type timer_fired_event_attributes :: [
    started_event_id: event_id,
    timer_id: timer_id,
  ]

  @type timer_id :: binary

  @type timer_started_event_attributes :: [
    control: data,
    decision_task_completed_event_id: event_id,
    start_to_fire_timeout: duration_in_seconds,
    timer_id: timer_id,
  ]

  @type timestamp :: integer

  @type truncated :: boolean

  @type type_already_exists_fault :: [
    message: error_message,
  ]

  @type type_deprecated_fault :: [
    message: error_message,
  ]

  @type unknown_resource_fault :: [
    message: error_message,
  ]

  @type version :: binary

  @type version_optional :: binary

  @type workflow_execution :: [
    run_id: run_id,
    workflow_id: workflow_id,
  ]

  @type workflow_execution_already_started_fault :: [
    message: error_message,
  ]

  @type workflow_execution_cancel_requested_cause :: binary

  @type workflow_execution_cancel_requested_event_attributes :: [
    cause: workflow_execution_cancel_requested_cause,
    external_initiated_event_id: event_id,
    external_workflow_execution: workflow_execution,
  ]

  @type workflow_execution_canceled_event_attributes :: [
    decision_task_completed_event_id: event_id,
    details: data,
  ]

  @type workflow_execution_completed_event_attributes :: [
    decision_task_completed_event_id: event_id,
    result: data,
  ]

  @type workflow_execution_configuration :: [
    child_policy: child_policy,
    execution_start_to_close_timeout: duration_in_seconds,
    lambda_role: arn,
    task_list: task_list,
    task_priority: task_priority,
    task_start_to_close_timeout: duration_in_seconds,
  ]

  @type workflow_execution_continued_as_new_event_attributes :: [
    child_policy: child_policy,
    decision_task_completed_event_id: event_id,
    execution_start_to_close_timeout: duration_in_seconds_optional,
    input: data,
    lambda_role: arn,
    new_execution_run_id: run_id,
    tag_list: tag_list,
    task_list: task_list,
    task_priority: task_priority,
    task_start_to_close_timeout: duration_in_seconds_optional,
    workflow_type: workflow_type,
  ]

  @type workflow_execution_count :: [
    count: count,
    truncated: truncated,
  ]

  @type workflow_execution_detail :: [
    execution_configuration: workflow_execution_configuration,
    execution_info: workflow_execution_info,
    latest_activity_task_timestamp: timestamp,
    latest_execution_context: data,
    open_counts: workflow_execution_open_counts,
  ]

  @type workflow_execution_failed_event_attributes :: [
    decision_task_completed_event_id: event_id,
    details: data,
    reason: failure_reason,
  ]

  @type workflow_execution_filter :: [
    workflow_id: workflow_id,
  ]

  @type workflow_execution_info :: [
    cancel_requested: canceled,
    close_status: close_status,
    close_timestamp: timestamp,
    execution: workflow_execution,
    execution_status: execution_status,
    parent: workflow_execution,
    start_timestamp: timestamp,
    tag_list: tag_list,
    workflow_type: workflow_type,
  ]

  @type workflow_execution_info_list :: [workflow_execution_info]

  @type workflow_execution_infos :: [
    execution_infos: workflow_execution_info_list,
    next_page_token: page_token,
  ]

  @type workflow_execution_open_counts :: [
    open_activity_tasks: count,
    open_child_workflow_executions: count,
    open_decision_tasks: open_decision_tasks_count,
    open_lambda_functions: count,
    open_timers: count,
  ]

  @type workflow_execution_signaled_event_attributes :: [
    external_initiated_event_id: event_id,
    external_workflow_execution: workflow_execution,
    input: data,
    signal_name: signal_name,
  ]

  @type workflow_execution_started_event_attributes :: [
    child_policy: child_policy,
    continued_execution_run_id: run_id_optional,
    execution_start_to_close_timeout: duration_in_seconds_optional,
    input: data,
    lambda_role: arn,
    parent_initiated_event_id: event_id,
    parent_workflow_execution: workflow_execution,
    tag_list: tag_list,
    task_list: task_list,
    task_priority: task_priority,
    task_start_to_close_timeout: duration_in_seconds_optional,
    workflow_type: workflow_type,
  ]

  @type workflow_execution_terminated_cause :: binary

  @type workflow_execution_terminated_event_attributes :: [
    cause: workflow_execution_terminated_cause,
    child_policy: child_policy,
    details: data,
    reason: terminate_reason,
  ]

  @type workflow_execution_timed_out_event_attributes :: [
    child_policy: child_policy,
    timeout_type: workflow_execution_timeout_type,
  ]

  @type workflow_execution_timeout_type :: binary

  @type workflow_id :: binary

  @type workflow_type :: [
    name: name,
    version: version,
  ]

  @type workflow_type_configuration :: [
    default_child_policy: child_policy,
    default_execution_start_to_close_timeout: duration_in_seconds_optional,
    default_lambda_role: arn,
    default_task_list: task_list,
    default_task_priority: task_priority,
    default_task_start_to_close_timeout: duration_in_seconds_optional,
  ]

  @type workflow_type_detail :: [
    configuration: workflow_type_configuration,
    type_info: workflow_type_info,
  ]

  @type workflow_type_filter :: [
    name: name,
    version: version_optional,
  ]

  @type workflow_type_info :: [
    creation_date: timestamp,
    deprecation_date: timestamp,
    description: description,
    status: registration_status,
    workflow_type: workflow_type,
  ]

  @type workflow_type_info_list :: [workflow_type_info]

  @type workflow_type_infos :: [
    next_page_token: page_token,
    type_infos: workflow_type_info_list,
  ]





  @doc """
  CountClosedWorkflowExecutions

  Returns the number of closed workflow executions within the given domain
  that meet the specified filtering criteria.

  Note:This operation is eventually consistent. The results are best effort
  and may not exactly reflect recent updates and changes. **Access Control**

  You can use IAM policies to control this action's access to Amazon SWF
  resources as follows:

  - Use a `Resource` element with the domain name to limit the action to only
  specified domains.

  - Use an `Action` element to allow or deny permission to call this action.

  - Constrain the following parameters by using a `Condition` element with
  the appropriate keys.

  - `tagFilter.tag`: String constraint. The key is `swf:tagFilter.tag`.

  - `typeFilter.name`: String constraint. The key is `swf:typeFilter.name`.

  - `typeFilter.version`: String constraint. The key is
  `swf:typeFilter.version`.

  If the caller does not have sufficient permissions to invoke the action, or
  the parameter values fall outside the specified constraints, the action
  fails. The associated event attribute's **cause** parameter will be set to
  OPERATION_NOT_PERMITTED. For details and example IAM policies, see [Using
  IAM to Manage Access to Amazon SWF
  Workflows](http://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html).
  """

  @spec count_closed_workflow_executions(client :: ExAws.SWF.t, input :: count_closed_workflow_executions_input) :: ExAws.Request.JSON.response_t
  def count_closed_workflow_executions(client, input) do
    request(client, "CountClosedWorkflowExecutions", format_input(input))
  end

  @doc """
  Same as `count_closed_workflow_executions/2` but raise on error.
  """
  @spec count_closed_workflow_executions!(client :: ExAws.SWF.t, input :: count_closed_workflow_executions_input) :: ExAws.Request.JSON.success_t | no_return
  def count_closed_workflow_executions!(client, input) do
    case count_closed_workflow_executions(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CountOpenWorkflowExecutions

  Returns the number of open workflow executions within the given domain that
  meet the specified filtering criteria.

  Note:This operation is eventually consistent. The results are best effort
  and may not exactly reflect recent updates and changes. **Access Control**

  You can use IAM policies to control this action's access to Amazon SWF
  resources as follows:

  - Use a `Resource` element with the domain name to limit the action to only
  specified domains.

  - Use an `Action` element to allow or deny permission to call this action.

  - Constrain the following parameters by using a `Condition` element with
  the appropriate keys.

  - `tagFilter.tag`: String constraint. The key is `swf:tagFilter.tag`.

  - `typeFilter.name`: String constraint. The key is `swf:typeFilter.name`.

  - `typeFilter.version`: String constraint. The key is
  `swf:typeFilter.version`.

  If the caller does not have sufficient permissions to invoke the action, or
  the parameter values fall outside the specified constraints, the action
  fails. The associated event attribute's **cause** parameter will be set to
  OPERATION_NOT_PERMITTED. For details and example IAM policies, see [Using
  IAM to Manage Access to Amazon SWF
  Workflows](http://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html).
  """

  @spec count_open_workflow_executions(client :: ExAws.SWF.t, input :: count_open_workflow_executions_input) :: ExAws.Request.JSON.response_t
  def count_open_workflow_executions(client, input) do
    request(client, "CountOpenWorkflowExecutions", format_input(input))
  end

  @doc """
  Same as `count_open_workflow_executions/2` but raise on error.
  """
  @spec count_open_workflow_executions!(client :: ExAws.SWF.t, input :: count_open_workflow_executions_input) :: ExAws.Request.JSON.success_t | no_return
  def count_open_workflow_executions!(client, input) do
    case count_open_workflow_executions(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CountPendingActivityTasks

  Returns the estimated number of activity tasks in the specified task list.
  The count returned is an approximation and is not guaranteed to be exact.
  If you specify a task list that no activity task was ever scheduled in then
  0 will be returned.

  **Access Control**

  You can use IAM policies to control this action's access to Amazon SWF
  resources as follows:

  - Use a `Resource` element with the domain name to limit the action to only
  specified domains.

  - Use an `Action` element to allow or deny permission to call this action.

  - Constrain the `taskList.name` parameter by using a **Condition** element
  with the `swf:taskList.name` key to allow the action to access only certain
  task lists.

  If the caller does not have sufficient permissions to invoke the action, or
  the parameter values fall outside the specified constraints, the action
  fails. The associated event attribute's **cause** parameter will be set to
  OPERATION_NOT_PERMITTED. For details and example IAM policies, see [Using
  IAM to Manage Access to Amazon SWF
  Workflows](http://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html).
  """

  @spec count_pending_activity_tasks(client :: ExAws.SWF.t, input :: count_pending_activity_tasks_input) :: ExAws.Request.JSON.response_t
  def count_pending_activity_tasks(client, input) do
    request(client, "CountPendingActivityTasks", format_input(input))
  end

  @doc """
  Same as `count_pending_activity_tasks/2` but raise on error.
  """
  @spec count_pending_activity_tasks!(client :: ExAws.SWF.t, input :: count_pending_activity_tasks_input) :: ExAws.Request.JSON.success_t | no_return
  def count_pending_activity_tasks!(client, input) do
    case count_pending_activity_tasks(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CountPendingDecisionTasks

  Returns the estimated number of decision tasks in the specified task list.
  The count returned is an approximation and is not guaranteed to be exact.
  If you specify a task list that no decision task was ever scheduled in then
  0 will be returned.

  **Access Control**

  You can use IAM policies to control this action's access to Amazon SWF
  resources as follows:

  - Use a `Resource` element with the domain name to limit the action to only
  specified domains.

  - Use an `Action` element to allow or deny permission to call this action.

  - Constrain the `taskList.name` parameter by using a **Condition** element
  with the `swf:taskList.name` key to allow the action to access only certain
  task lists.

  If the caller does not have sufficient permissions to invoke the action, or
  the parameter values fall outside the specified constraints, the action
  fails. The associated event attribute's **cause** parameter will be set to
  OPERATION_NOT_PERMITTED. For details and example IAM policies, see [Using
  IAM to Manage Access to Amazon SWF
  Workflows](http://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html).
  """

  @spec count_pending_decision_tasks(client :: ExAws.SWF.t, input :: count_pending_decision_tasks_input) :: ExAws.Request.JSON.response_t
  def count_pending_decision_tasks(client, input) do
    request(client, "CountPendingDecisionTasks", format_input(input))
  end

  @doc """
  Same as `count_pending_decision_tasks/2` but raise on error.
  """
  @spec count_pending_decision_tasks!(client :: ExAws.SWF.t, input :: count_pending_decision_tasks_input) :: ExAws.Request.JSON.success_t | no_return
  def count_pending_decision_tasks!(client, input) do
    case count_pending_decision_tasks(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeprecateActivityType

  Deprecates the specified *activity type*. After an activity type has been
  deprecated, you cannot create new tasks of that activity type. Tasks of
  this type that were scheduled before the type was deprecated will continue
  to run.

  Note:This operation is eventually consistent. The results are best effort
  and may not exactly reflect recent updates and changes. **Access Control**

  You can use IAM policies to control this action's access to Amazon SWF
  resources as follows:

  - Use a `Resource` element with the domain name to limit the action to only
  specified domains.

  - Use an `Action` element to allow or deny permission to call this action.

  - Constrain the following parameters by using a `Condition` element with
  the appropriate keys.

  - `activityType.name`: String constraint. The key is
  `swf:activityType.name`.

  - `activityType.version`: String constraint. The key is
  `swf:activityType.version`.

  If the caller does not have sufficient permissions to invoke the action, or
  the parameter values fall outside the specified constraints, the action
  fails. The associated event attribute's **cause** parameter will be set to
  OPERATION_NOT_PERMITTED. For details and example IAM policies, see [Using
  IAM to Manage Access to Amazon SWF
  Workflows](http://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html).
  """

  @spec deprecate_activity_type(client :: ExAws.SWF.t, input :: deprecate_activity_type_input) :: ExAws.Request.JSON.response_t
  def deprecate_activity_type(client, input) do
    request(client, "DeprecateActivityType", format_input(input))
  end

  @doc """
  Same as `deprecate_activity_type/2` but raise on error.
  """
  @spec deprecate_activity_type!(client :: ExAws.SWF.t, input :: deprecate_activity_type_input) :: ExAws.Request.JSON.success_t | no_return
  def deprecate_activity_type!(client, input) do
    case deprecate_activity_type(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeprecateDomain

  Deprecates the specified domain. After a domain has been deprecated it
  cannot be used to create new workflow executions or register new types.
  However, you can still use visibility actions on this domain. Deprecating a
  domain also deprecates all activity and workflow types registered in the
  domain. Executions that were started before the domain was deprecated will
  continue to run.

  Note:This operation is eventually consistent. The results are best effort
  and may not exactly reflect recent updates and changes. **Access Control**

  You can use IAM policies to control this action's access to Amazon SWF
  resources as follows:

  - Use a `Resource` element with the domain name to limit the action to only
  specified domains.

  - Use an `Action` element to allow or deny permission to call this action.

  - You cannot use an IAM policy to constrain this action's parameters.

  If the caller does not have sufficient permissions to invoke the action, or
  the parameter values fall outside the specified constraints, the action
  fails. The associated event attribute's **cause** parameter will be set to
  OPERATION_NOT_PERMITTED. For details and example IAM policies, see [Using
  IAM to Manage Access to Amazon SWF
  Workflows](http://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html).
  """

  @spec deprecate_domain(client :: ExAws.SWF.t, input :: deprecate_domain_input) :: ExAws.Request.JSON.response_t
  def deprecate_domain(client, input) do
    request(client, "DeprecateDomain", format_input(input))
  end

  @doc """
  Same as `deprecate_domain/2` but raise on error.
  """
  @spec deprecate_domain!(client :: ExAws.SWF.t, input :: deprecate_domain_input) :: ExAws.Request.JSON.success_t | no_return
  def deprecate_domain!(client, input) do
    case deprecate_domain(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeprecateWorkflowType

  Deprecates the specified *workflow type*. After a workflow type has been
  deprecated, you cannot create new executions of that type. Executions that
  were started before the type was deprecated will continue to run. A
  deprecated workflow type may still be used when calling visibility actions.

  Note:This operation is eventually consistent. The results are best effort
  and may not exactly reflect recent updates and changes. **Access Control**

  You can use IAM policies to control this action's access to Amazon SWF
  resources as follows:

  - Use a `Resource` element with the domain name to limit the action to only
  specified domains.

  - Use an `Action` element to allow or deny permission to call this action.

  - Constrain the following parameters by using a `Condition` element with
  the appropriate keys.

  - `workflowType.name`: String constraint. The key is
  `swf:workflowType.name`.

  - `workflowType.version`: String constraint. The key is
  `swf:workflowType.version`.

  If the caller does not have sufficient permissions to invoke the action, or
  the parameter values fall outside the specified constraints, the action
  fails. The associated event attribute's **cause** parameter will be set to
  OPERATION_NOT_PERMITTED. For details and example IAM policies, see [Using
  IAM to Manage Access to Amazon SWF
  Workflows](http://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html).
  """

  @spec deprecate_workflow_type(client :: ExAws.SWF.t, input :: deprecate_workflow_type_input) :: ExAws.Request.JSON.response_t
  def deprecate_workflow_type(client, input) do
    request(client, "DeprecateWorkflowType", format_input(input))
  end

  @doc """
  Same as `deprecate_workflow_type/2` but raise on error.
  """
  @spec deprecate_workflow_type!(client :: ExAws.SWF.t, input :: deprecate_workflow_type_input) :: ExAws.Request.JSON.success_t | no_return
  def deprecate_workflow_type!(client, input) do
    case deprecate_workflow_type(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeActivityType

  Returns information about the specified activity type. This includes
  configuration settings provided when the type was registered and other
  general information about the type.

  **Access Control**

  You can use IAM policies to control this action's access to Amazon SWF
  resources as follows:

  - Use a `Resource` element with the domain name to limit the action to only
  specified domains.

  - Use an `Action` element to allow or deny permission to call this action.

  - Constrain the following parameters by using a `Condition` element with
  the appropriate keys.

  - `activityType.name`: String constraint. The key is
  `swf:activityType.name`.

  - `activityType.version`: String constraint. The key is
  `swf:activityType.version`.

  If the caller does not have sufficient permissions to invoke the action, or
  the parameter values fall outside the specified constraints, the action
  fails. The associated event attribute's **cause** parameter will be set to
  OPERATION_NOT_PERMITTED. For details and example IAM policies, see [Using
  IAM to Manage Access to Amazon SWF
  Workflows](http://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html).
  """

  @spec describe_activity_type(client :: ExAws.SWF.t, input :: describe_activity_type_input) :: ExAws.Request.JSON.response_t
  def describe_activity_type(client, input) do
    request(client, "DescribeActivityType", format_input(input))
  end

  @doc """
  Same as `describe_activity_type/2` but raise on error.
  """
  @spec describe_activity_type!(client :: ExAws.SWF.t, input :: describe_activity_type_input) :: ExAws.Request.JSON.success_t | no_return
  def describe_activity_type!(client, input) do
    case describe_activity_type(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeDomain

  Returns information about the specified domain, including description and
  status.

  **Access Control**

  You can use IAM policies to control this action's access to Amazon SWF
  resources as follows:

  - Use a `Resource` element with the domain name to limit the action to only
  specified domains.

  - Use an `Action` element to allow or deny permission to call this action.

  - You cannot use an IAM policy to constrain this action's parameters.

  If the caller does not have sufficient permissions to invoke the action, or
  the parameter values fall outside the specified constraints, the action
  fails. The associated event attribute's **cause** parameter will be set to
  OPERATION_NOT_PERMITTED. For details and example IAM policies, see [Using
  IAM to Manage Access to Amazon SWF
  Workflows](http://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html).
  """

  @spec describe_domain(client :: ExAws.SWF.t, input :: describe_domain_input) :: ExAws.Request.JSON.response_t
  def describe_domain(client, input) do
    request(client, "DescribeDomain", format_input(input))
  end

  @doc """
  Same as `describe_domain/2` but raise on error.
  """
  @spec describe_domain!(client :: ExAws.SWF.t, input :: describe_domain_input) :: ExAws.Request.JSON.success_t | no_return
  def describe_domain!(client, input) do
    case describe_domain(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeWorkflowExecution

  Returns information about the specified workflow execution including its
  type and some statistics.

  Note:This operation is eventually consistent. The results are best effort
  and may not exactly reflect recent updates and changes. **Access Control**

  You can use IAM policies to control this action's access to Amazon SWF
  resources as follows:

  - Use a `Resource` element with the domain name to limit the action to only
  specified domains.

  - Use an `Action` element to allow or deny permission to call this action.

  - You cannot use an IAM policy to constrain this action's parameters.

  If the caller does not have sufficient permissions to invoke the action, or
  the parameter values fall outside the specified constraints, the action
  fails. The associated event attribute's **cause** parameter will be set to
  OPERATION_NOT_PERMITTED. For details and example IAM policies, see [Using
  IAM to Manage Access to Amazon SWF
  Workflows](http://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html).
  """

  @spec describe_workflow_execution(client :: ExAws.SWF.t, input :: describe_workflow_execution_input) :: ExAws.Request.JSON.response_t
  def describe_workflow_execution(client, input) do
    request(client, "DescribeWorkflowExecution", format_input(input))
  end

  @doc """
  Same as `describe_workflow_execution/2` but raise on error.
  """
  @spec describe_workflow_execution!(client :: ExAws.SWF.t, input :: describe_workflow_execution_input) :: ExAws.Request.JSON.success_t | no_return
  def describe_workflow_execution!(client, input) do
    case describe_workflow_execution(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeWorkflowType

  Returns information about the specified *workflow type*. This includes
  configuration settings specified when the type was registered and other
  information such as creation date, current status, and so on.

  **Access Control**

  You can use IAM policies to control this action's access to Amazon SWF
  resources as follows:

  - Use a `Resource` element with the domain name to limit the action to only
  specified domains.

  - Use an `Action` element to allow or deny permission to call this action.

  - Constrain the following parameters by using a `Condition` element with
  the appropriate keys.

  - `workflowType.name`: String constraint. The key is
  `swf:workflowType.name`.

  - `workflowType.version`: String constraint. The key is
  `swf:workflowType.version`.

  If the caller does not have sufficient permissions to invoke the action, or
  the parameter values fall outside the specified constraints, the action
  fails. The associated event attribute's **cause** parameter will be set to
  OPERATION_NOT_PERMITTED. For details and example IAM policies, see [Using
  IAM to Manage Access to Amazon SWF
  Workflows](http://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html).
  """

  @spec describe_workflow_type(client :: ExAws.SWF.t, input :: describe_workflow_type_input) :: ExAws.Request.JSON.response_t
  def describe_workflow_type(client, input) do
    request(client, "DescribeWorkflowType", format_input(input))
  end

  @doc """
  Same as `describe_workflow_type/2` but raise on error.
  """
  @spec describe_workflow_type!(client :: ExAws.SWF.t, input :: describe_workflow_type_input) :: ExAws.Request.JSON.success_t | no_return
  def describe_workflow_type!(client, input) do
    case describe_workflow_type(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetWorkflowExecutionHistory

  Returns the history of the specified workflow execution. The results may be
  split into multiple pages. To retrieve subsequent pages, make the call
  again using the `nextPageToken` returned by the initial call.

  Note:This operation is eventually consistent. The results are best effort
  and may not exactly reflect recent updates and changes. **Access Control**

  You can use IAM policies to control this action's access to Amazon SWF
  resources as follows:

  - Use a `Resource` element with the domain name to limit the action to only
  specified domains.

  - Use an `Action` element to allow or deny permission to call this action.

  - You cannot use an IAM policy to constrain this action's parameters.

  If the caller does not have sufficient permissions to invoke the action, or
  the parameter values fall outside the specified constraints, the action
  fails. The associated event attribute's **cause** parameter will be set to
  OPERATION_NOT_PERMITTED. For details and example IAM policies, see [Using
  IAM to Manage Access to Amazon SWF
  Workflows](http://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html).
  """

  @spec get_workflow_execution_history(client :: ExAws.SWF.t, input :: get_workflow_execution_history_input) :: ExAws.Request.JSON.response_t
  def get_workflow_execution_history(client, input) do
    request(client, "GetWorkflowExecutionHistory", format_input(input))
  end

  @doc """
  Same as `get_workflow_execution_history/2` but raise on error.
  """
  @spec get_workflow_execution_history!(client :: ExAws.SWF.t, input :: get_workflow_execution_history_input) :: ExAws.Request.JSON.success_t | no_return
  def get_workflow_execution_history!(client, input) do
    case get_workflow_execution_history(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListActivityTypes

  Returns information about all activities registered in the specified domain
  that match the specified name and registration status. The result includes
  information like creation date, current status of the activity, etc. The
  results may be split into multiple pages. To retrieve subsequent pages,
  make the call again using the `nextPageToken` returned by the initial call.

  **Access Control**

  You can use IAM policies to control this action's access to Amazon SWF
  resources as follows:

  - Use a `Resource` element with the domain name to limit the action to only
  specified domains.

  - Use an `Action` element to allow or deny permission to call this action.

  - You cannot use an IAM policy to constrain this action's parameters.

  If the caller does not have sufficient permissions to invoke the action, or
  the parameter values fall outside the specified constraints, the action
  fails. The associated event attribute's **cause** parameter will be set to
  OPERATION_NOT_PERMITTED. For details and example IAM policies, see [Using
  IAM to Manage Access to Amazon SWF
  Workflows](http://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html).
  """

  @spec list_activity_types(client :: ExAws.SWF.t, input :: list_activity_types_input) :: ExAws.Request.JSON.response_t
  def list_activity_types(client, input) do
    request(client, "ListActivityTypes", format_input(input))
  end

  @doc """
  Same as `list_activity_types/2` but raise on error.
  """
  @spec list_activity_types!(client :: ExAws.SWF.t, input :: list_activity_types_input) :: ExAws.Request.JSON.success_t | no_return
  def list_activity_types!(client, input) do
    case list_activity_types(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListClosedWorkflowExecutions

  Returns a list of closed workflow executions in the specified domain that
  meet the filtering criteria. The results may be split into multiple pages.
  To retrieve subsequent pages, make the call again using the nextPageToken
  returned by the initial call.

  Note:This operation is eventually consistent. The results are best effort
  and may not exactly reflect recent updates and changes. **Access Control**

  You can use IAM policies to control this action's access to Amazon SWF
  resources as follows:

  - Use a `Resource` element with the domain name to limit the action to only
  specified domains.

  - Use an `Action` element to allow or deny permission to call this action.

  - Constrain the following parameters by using a `Condition` element with
  the appropriate keys.

  - `tagFilter.tag`: String constraint. The key is `swf:tagFilter.tag`.

  - `typeFilter.name`: String constraint. The key is `swf:typeFilter.name`.

  - `typeFilter.version`: String constraint. The key is
  `swf:typeFilter.version`.

  If the caller does not have sufficient permissions to invoke the action, or
  the parameter values fall outside the specified constraints, the action
  fails. The associated event attribute's **cause** parameter will be set to
  OPERATION_NOT_PERMITTED. For details and example IAM policies, see [Using
  IAM to Manage Access to Amazon SWF
  Workflows](http://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html).
  """

  @spec list_closed_workflow_executions(client :: ExAws.SWF.t, input :: list_closed_workflow_executions_input) :: ExAws.Request.JSON.response_t
  def list_closed_workflow_executions(client, input) do
    request(client, "ListClosedWorkflowExecutions", format_input(input))
  end

  @doc """
  Same as `list_closed_workflow_executions/2` but raise on error.
  """
  @spec list_closed_workflow_executions!(client :: ExAws.SWF.t, input :: list_closed_workflow_executions_input) :: ExAws.Request.JSON.success_t | no_return
  def list_closed_workflow_executions!(client, input) do
    case list_closed_workflow_executions(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListDomains

  Returns the list of domains registered in the account. The results may be
  split into multiple pages. To retrieve subsequent pages, make the call
  again using the nextPageToken returned by the initial call.

  Note: This operation is eventually consistent. The results are best effort
  and may not exactly reflect recent updates and changes. **Access Control**

  You can use IAM policies to control this action's access to Amazon SWF
  resources as follows:

  - Use a `Resource` element with the domain name to limit the action to only
  specified domains. The element must be set to
  `arn:aws:swf::AccountID:domain/*`, where *AccountID* is the account ID,
  with no dashes.

  - Use an `Action` element to allow or deny permission to call this action.

  - You cannot use an IAM policy to constrain this action's parameters.

  If the caller does not have sufficient permissions to invoke the action, or
  the parameter values fall outside the specified constraints, the action
  fails. The associated event attribute's **cause** parameter will be set to
  OPERATION_NOT_PERMITTED. For details and example IAM policies, see [Using
  IAM to Manage Access to Amazon SWF
  Workflows](http://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html).
  """

  @spec list_domains(client :: ExAws.SWF.t, input :: list_domains_input) :: ExAws.Request.JSON.response_t
  def list_domains(client, input) do
    request(client, "ListDomains", format_input(input))
  end

  @doc """
  Same as `list_domains/2` but raise on error.
  """
  @spec list_domains!(client :: ExAws.SWF.t, input :: list_domains_input) :: ExAws.Request.JSON.success_t | no_return
  def list_domains!(client, input) do
    case list_domains(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListOpenWorkflowExecutions

  Returns a list of open workflow executions in the specified domain that
  meet the filtering criteria. The results may be split into multiple pages.
  To retrieve subsequent pages, make the call again using the nextPageToken
  returned by the initial call.

  Note: This operation is eventually consistent. The results are best effort
  and may not exactly reflect recent updates and changes. **Access Control**

  You can use IAM policies to control this action's access to Amazon SWF
  resources as follows:

  - Use a `Resource` element with the domain name to limit the action to only
  specified domains.

  - Use an `Action` element to allow or deny permission to call this action.

  - Constrain the following parameters by using a `Condition` element with
  the appropriate keys.

  - `tagFilter.tag`: String constraint. The key is `swf:tagFilter.tag`.

  - `typeFilter.name`: String constraint. The key is `swf:typeFilter.name`.

  - `typeFilter.version`: String constraint. The key is
  `swf:typeFilter.version`.

  If the caller does not have sufficient permissions to invoke the action, or
  the parameter values fall outside the specified constraints, the action
  fails. The associated event attribute's **cause** parameter will be set to
  OPERATION_NOT_PERMITTED. For details and example IAM policies, see [Using
  IAM to Manage Access to Amazon SWF
  Workflows](http://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html).
  """

  @spec list_open_workflow_executions(client :: ExAws.SWF.t, input :: list_open_workflow_executions_input) :: ExAws.Request.JSON.response_t
  def list_open_workflow_executions(client, input) do
    request(client, "ListOpenWorkflowExecutions", format_input(input))
  end

  @doc """
  Same as `list_open_workflow_executions/2` but raise on error.
  """
  @spec list_open_workflow_executions!(client :: ExAws.SWF.t, input :: list_open_workflow_executions_input) :: ExAws.Request.JSON.success_t | no_return
  def list_open_workflow_executions!(client, input) do
    case list_open_workflow_executions(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListWorkflowTypes

  Returns information about workflow types in the specified domain. The
  results may be split into multiple pages that can be retrieved by making
  the call repeatedly.

  **Access Control**

  You can use IAM policies to control this action's access to Amazon SWF
  resources as follows:

  - Use a `Resource` element with the domain name to limit the action to only
  specified domains.

  - Use an `Action` element to allow or deny permission to call this action.

  - You cannot use an IAM policy to constrain this action's parameters.

  If the caller does not have sufficient permissions to invoke the action, or
  the parameter values fall outside the specified constraints, the action
  fails. The associated event attribute's **cause** parameter will be set to
  OPERATION_NOT_PERMITTED. For details and example IAM policies, see [Using
  IAM to Manage Access to Amazon SWF
  Workflows](http://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html).
  """

  @spec list_workflow_types(client :: ExAws.SWF.t, input :: list_workflow_types_input) :: ExAws.Request.JSON.response_t
  def list_workflow_types(client, input) do
    request(client, "ListWorkflowTypes", format_input(input))
  end

  @doc """
  Same as `list_workflow_types/2` but raise on error.
  """
  @spec list_workflow_types!(client :: ExAws.SWF.t, input :: list_workflow_types_input) :: ExAws.Request.JSON.success_t | no_return
  def list_workflow_types!(client, input) do
    case list_workflow_types(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  PollForActivityTask

  Used by workers to get an `ActivityTask` from the specified activity
  `taskList`. This initiates a long poll, where the service holds the HTTP
  connection open and responds as soon as a task becomes available. The
  maximum time the service holds on to the request before responding is 60
  seconds. If no task is available within 60 seconds, the poll will return an
  empty result. An empty result, in this context, means that an ActivityTask
  is returned, but that the value of taskToken is an empty string. If a task
  is returned, the worker should use its type to identify and process it
  correctly.

  **Workers should set their client side socket timeout to at least 70
  seconds (10 seconds higher than the maximum time service may hold the poll
  request).** **Access Control**

  You can use IAM policies to control this action's access to Amazon SWF
  resources as follows:

  - Use a `Resource` element with the domain name to limit the action to only
  specified domains.

  - Use an `Action` element to allow or deny permission to call this action.

  - Constrain the `taskList.name` parameter by using a **Condition** element
  with the `swf:taskList.name` key to allow the action to access only certain
  task lists.

  If the caller does not have sufficient permissions to invoke the action, or
  the parameter values fall outside the specified constraints, the action
  fails. The associated event attribute's **cause** parameter will be set to
  OPERATION_NOT_PERMITTED. For details and example IAM policies, see [Using
  IAM to Manage Access to Amazon SWF
  Workflows](http://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html).
  """

  @spec poll_for_activity_task(client :: ExAws.SWF.t, input :: poll_for_activity_task_input) :: ExAws.Request.JSON.response_t
  def poll_for_activity_task(client, input) do
    request(client, "PollForActivityTask", format_input(input))
  end

  @doc """
  Same as `poll_for_activity_task/2` but raise on error.
  """
  @spec poll_for_activity_task!(client :: ExAws.SWF.t, input :: poll_for_activity_task_input) :: ExAws.Request.JSON.success_t | no_return
  def poll_for_activity_task!(client, input) do
    case poll_for_activity_task(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  PollForDecisionTask

  Used by deciders to get a `DecisionTask` from the specified decision
  `taskList`. A decision task may be returned for any open workflow execution
  that is using the specified task list. The task includes a paginated view
  of the history of the workflow execution. The decider should use the
  workflow type and the history to determine how to properly handle the task.

  This action initiates a long poll, where the service holds the HTTP
  connection open and responds as soon a task becomes available. If no
  decision task is available in the specified task list before the timeout of
  60 seconds expires, an empty result is returned. An empty result, in this
  context, means that a DecisionTask is returned, but that the value of
  `taskToken` is an empty string.

  **Deciders should set their client-side socket timeout to at least 70
  seconds (10 seconds higher than the timeout).** **Because the number of
  workflow history events for a single workflow execution might be very
  large, the result returned might be split up across a number of pages. To
  retrieve subsequent pages, make additional calls to `PollForDecisionTask`
  using the `nextPageToken` returned by the initial call. Note that you do
  **not** call `GetWorkflowExecutionHistory` with this `nextPageToken`.
  Instead, call `PollForDecisionTask` again.** **Access Control**

  You can use IAM policies to control this action's access to Amazon SWF
  resources as follows:

  - Use a `Resource` element with the domain name to limit the action to only
  specified domains.

  - Use an `Action` element to allow or deny permission to call this action.

  - Constrain the `taskList.name` parameter by using a **Condition** element
  with the `swf:taskList.name` key to allow the action to access only certain
  task lists.

  If the caller does not have sufficient permissions to invoke the action, or
  the parameter values fall outside the specified constraints, the action
  fails. The associated event attribute's **cause** parameter will be set to
  OPERATION_NOT_PERMITTED. For details and example IAM policies, see [Using
  IAM to Manage Access to Amazon SWF
  Workflows](http://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html).
  """

  @spec poll_for_decision_task(client :: ExAws.SWF.t, input :: poll_for_decision_task_input) :: ExAws.Request.JSON.response_t
  def poll_for_decision_task(client, input) do
    request(client, "PollForDecisionTask", format_input(input))
  end

  @doc """
  Same as `poll_for_decision_task/2` but raise on error.
  """
  @spec poll_for_decision_task!(client :: ExAws.SWF.t, input :: poll_for_decision_task_input) :: ExAws.Request.JSON.success_t | no_return
  def poll_for_decision_task!(client, input) do
    case poll_for_decision_task(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RecordActivityTaskHeartbeat

  Used by activity workers to report to the service that the `ActivityTask`
  represented by the specified `taskToken` is still making progress. The
  worker can also (optionally) specify details of the progress, for example
  percent complete, using the `details` parameter. This action can also be
  used by the worker as a mechanism to check if cancellation is being
  requested for the activity task. If a cancellation is being attempted for
  the specified task, then the boolean `cancelRequested` flag returned by the
  service is set to `true`.

  This action resets the `taskHeartbeatTimeout` clock. The
  `taskHeartbeatTimeout` is specified in `RegisterActivityType`.

  This action does not in itself create an event in the workflow execution
  history. However, if the task times out, the workflow execution history
  will contain a `ActivityTaskTimedOut` event that contains the information
  from the last heartbeat generated by the activity worker.

  Note:The `taskStartToCloseTimeout` of an activity type is the maximum
  duration of an activity task, regardless of the number of
  `RecordActivityTaskHeartbeat` requests received. The
  `taskStartToCloseTimeout` is also specified in `RegisterActivityType`.
  Note:This operation is only useful for long-lived activities to report
  liveliness of the task and to determine if a cancellation is being
  attempted. **If the `cancelRequested` flag returns `true`, a cancellation
  is being attempted. If the worker can cancel the activity, it should
  respond with `RespondActivityTaskCanceled`. Otherwise, it should ignore the
  cancellation request.** **Access Control**

  You can use IAM policies to control this action's access to Amazon SWF
  resources as follows:

  - Use a `Resource` element with the domain name to limit the action to only
  specified domains.

  - Use an `Action` element to allow or deny permission to call this action.

  - You cannot use an IAM policy to constrain this action's parameters.

  If the caller does not have sufficient permissions to invoke the action, or
  the parameter values fall outside the specified constraints, the action
  fails. The associated event attribute's **cause** parameter will be set to
  OPERATION_NOT_PERMITTED. For details and example IAM policies, see [Using
  IAM to Manage Access to Amazon SWF
  Workflows](http://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html).
  """

  @spec record_activity_task_heartbeat(client :: ExAws.SWF.t, input :: record_activity_task_heartbeat_input) :: ExAws.Request.JSON.response_t
  def record_activity_task_heartbeat(client, input) do
    request(client, "RecordActivityTaskHeartbeat", format_input(input))
  end

  @doc """
  Same as `record_activity_task_heartbeat/2` but raise on error.
  """
  @spec record_activity_task_heartbeat!(client :: ExAws.SWF.t, input :: record_activity_task_heartbeat_input) :: ExAws.Request.JSON.success_t | no_return
  def record_activity_task_heartbeat!(client, input) do
    case record_activity_task_heartbeat(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RegisterActivityType

  Registers a new *activity type* along with its configuration settings in
  the specified domain.

  **A `TypeAlreadyExists` fault is returned if the type already exists in the
  domain. You cannot change any configuration settings of the type after its
  registration, and it must be registered as a new version.** **Access
  Control**

  You can use IAM policies to control this action's access to Amazon SWF
  resources as follows:

  - Use a `Resource` element with the domain name to limit the action to only
  specified domains.

  - Use an `Action` element to allow or deny permission to call this action.

  - Constrain the following parameters by using a `Condition` element with
  the appropriate keys.

  - `defaultTaskList.name`: String constraint. The key is
  `swf:defaultTaskList.name`.

  - `name`: String constraint. The key is `swf:name`.

  - `version`: String constraint. The key is `swf:version`.

  If the caller does not have sufficient permissions to invoke the action, or
  the parameter values fall outside the specified constraints, the action
  fails. The associated event attribute's **cause** parameter will be set to
  OPERATION_NOT_PERMITTED. For details and example IAM policies, see [Using
  IAM to Manage Access to Amazon SWF
  Workflows](http://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html).
  """

  @spec register_activity_type(client :: ExAws.SWF.t, input :: register_activity_type_input) :: ExAws.Request.JSON.response_t
  def register_activity_type(client, input) do
    request(client, "RegisterActivityType", format_input(input))
  end

  @doc """
  Same as `register_activity_type/2` but raise on error.
  """
  @spec register_activity_type!(client :: ExAws.SWF.t, input :: register_activity_type_input) :: ExAws.Request.JSON.success_t | no_return
  def register_activity_type!(client, input) do
    case register_activity_type(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RegisterDomain

  Registers a new domain.

  **Access Control**

  You can use IAM policies to control this action's access to Amazon SWF
  resources as follows:

  - You cannot use an IAM policy to control domain access for this action.
  The name of the domain being registered is available as the resource of
  this action.

  - Use an `Action` element to allow or deny permission to call this action.

  - You cannot use an IAM policy to constrain this action's parameters.

  If the caller does not have sufficient permissions to invoke the action, or
  the parameter values fall outside the specified constraints, the action
  fails. The associated event attribute's **cause** parameter will be set to
  OPERATION_NOT_PERMITTED. For details and example IAM policies, see [Using
  IAM to Manage Access to Amazon SWF
  Workflows](http://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html).
  """

  @spec register_domain(client :: ExAws.SWF.t, input :: register_domain_input) :: ExAws.Request.JSON.response_t
  def register_domain(client, input) do
    request(client, "RegisterDomain", format_input(input))
  end

  @doc """
  Same as `register_domain/2` but raise on error.
  """
  @spec register_domain!(client :: ExAws.SWF.t, input :: register_domain_input) :: ExAws.Request.JSON.success_t | no_return
  def register_domain!(client, input) do
    case register_domain(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RegisterWorkflowType

  Registers a new *workflow type* and its configuration settings in the
  specified domain.

  The retention period for the workflow history is set by the
  `RegisterDomain` action.

  **If the type already exists, then a `TypeAlreadyExists` fault is returned.
  You cannot change the configuration settings of a workflow type once it is
  registered and it must be registered as a new version.** **Access Control**

  You can use IAM policies to control this action's access to Amazon SWF
  resources as follows:

  - Use a `Resource` element with the domain name to limit the action to only
  specified domains.

  - Use an `Action` element to allow or deny permission to call this action.

  - Constrain the following parameters by using a `Condition` element with
  the appropriate keys.

  - `defaultTaskList.name`: String constraint. The key is
  `swf:defaultTaskList.name`.

  - `name`: String constraint. The key is `swf:name`.

  - `version`: String constraint. The key is `swf:version`.

  If the caller does not have sufficient permissions to invoke the action, or
  the parameter values fall outside the specified constraints, the action
  fails. The associated event attribute's **cause** parameter will be set to
  OPERATION_NOT_PERMITTED. For details and example IAM policies, see [Using
  IAM to Manage Access to Amazon SWF
  Workflows](http://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html).
  """

  @spec register_workflow_type(client :: ExAws.SWF.t, input :: register_workflow_type_input) :: ExAws.Request.JSON.response_t
  def register_workflow_type(client, input) do
    request(client, "RegisterWorkflowType", format_input(input))
  end

  @doc """
  Same as `register_workflow_type/2` but raise on error.
  """
  @spec register_workflow_type!(client :: ExAws.SWF.t, input :: register_workflow_type_input) :: ExAws.Request.JSON.success_t | no_return
  def register_workflow_type!(client, input) do
    case register_workflow_type(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RequestCancelWorkflowExecution

  Records a `WorkflowExecutionCancelRequested` event in the currently running
  workflow execution identified by the given domain, workflowId, and runId.
  This logically requests the cancellation of the workflow execution as a
  whole. It is up to the decider to take appropriate actions when it receives
  an execution history with this event.

  Note:If the runId is not specified, the `WorkflowExecutionCancelRequested`
  event is recorded in the history of the current open workflow execution
  with the specified workflowId in the domain. Note:Because this action
  allows the workflow to properly clean up and gracefully close, it should be
  used instead of `TerminateWorkflowExecution` when possible. **Access
  Control**

  You can use IAM policies to control this action's access to Amazon SWF
  resources as follows:

  - Use a `Resource` element with the domain name to limit the action to only
  specified domains.

  - Use an `Action` element to allow or deny permission to call this action.

  - You cannot use an IAM policy to constrain this action's parameters.

  If the caller does not have sufficient permissions to invoke the action, or
  the parameter values fall outside the specified constraints, the action
  fails. The associated event attribute's **cause** parameter will be set to
  OPERATION_NOT_PERMITTED. For details and example IAM policies, see [Using
  IAM to Manage Access to Amazon SWF
  Workflows](http://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html).
  """

  @spec request_cancel_workflow_execution(client :: ExAws.SWF.t, input :: request_cancel_workflow_execution_input) :: ExAws.Request.JSON.response_t
  def request_cancel_workflow_execution(client, input) do
    request(client, "RequestCancelWorkflowExecution", format_input(input))
  end

  @doc """
  Same as `request_cancel_workflow_execution/2` but raise on error.
  """
  @spec request_cancel_workflow_execution!(client :: ExAws.SWF.t, input :: request_cancel_workflow_execution_input) :: ExAws.Request.JSON.success_t | no_return
  def request_cancel_workflow_execution!(client, input) do
    case request_cancel_workflow_execution(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RespondActivityTaskCanceled

  Used by workers to tell the service that the `ActivityTask` identified by
  the `taskToken` was successfully canceled. Additional `details` can be
  optionally provided using the `details` argument.

  These `details` (if provided) appear in the `ActivityTaskCanceled` event
  added to the workflow history.

  **Only use this operation if the `canceled` flag of a
  `RecordActivityTaskHeartbeat` request returns `true` and if the activity
  can be safely undone or abandoned.** A task is considered open from the
  time that it is scheduled until it is closed. Therefore a task is reported
  as open while a worker is processing it. A task is closed after it has been
  specified in a call to `RespondActivityTaskCompleted`,
  RespondActivityTaskCanceled, `RespondActivityTaskFailed`, or the task has
  [timed
  out](http://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dg-basic.html#swf-dev-timeout-types).

  **Access Control**

  You can use IAM policies to control this action's access to Amazon SWF
  resources as follows:

  - Use a `Resource` element with the domain name to limit the action to only
  specified domains.

  - Use an `Action` element to allow or deny permission to call this action.

  - You cannot use an IAM policy to constrain this action's parameters.

  If the caller does not have sufficient permissions to invoke the action, or
  the parameter values fall outside the specified constraints, the action
  fails. The associated event attribute's **cause** parameter will be set to
  OPERATION_NOT_PERMITTED. For details and example IAM policies, see [Using
  IAM to Manage Access to Amazon SWF
  Workflows](http://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html).
  """

  @spec respond_activity_task_canceled(client :: ExAws.SWF.t, input :: respond_activity_task_canceled_input) :: ExAws.Request.JSON.response_t
  def respond_activity_task_canceled(client, input) do
    request(client, "RespondActivityTaskCanceled", format_input(input))
  end

  @doc """
  Same as `respond_activity_task_canceled/2` but raise on error.
  """
  @spec respond_activity_task_canceled!(client :: ExAws.SWF.t, input :: respond_activity_task_canceled_input) :: ExAws.Request.JSON.success_t | no_return
  def respond_activity_task_canceled!(client, input) do
    case respond_activity_task_canceled(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RespondActivityTaskCompleted

  Used by workers to tell the service that the `ActivityTask` identified by
  the `taskToken` completed successfully with a `result` (if provided). The
  `result` appears in the `ActivityTaskCompleted` event in the workflow
  history.

  ** If the requested task does not complete successfully, use
  `RespondActivityTaskFailed` instead. If the worker finds that the task is
  canceled through the `canceled` flag returned by
  `RecordActivityTaskHeartbeat`, it should cancel the task, clean up and then
  call `RespondActivityTaskCanceled`.** A task is considered open from the
  time that it is scheduled until it is closed. Therefore a task is reported
  as open while a worker is processing it. A task is closed after it has been
  specified in a call to RespondActivityTaskCompleted,
  `RespondActivityTaskCanceled`, `RespondActivityTaskFailed`, or the task has
  [timed
  out](http://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dg-basic.html#swf-dev-timeout-types).

  **Access Control**

  You can use IAM policies to control this action's access to Amazon SWF
  resources as follows:

  - Use a `Resource` element with the domain name to limit the action to only
  specified domains.

  - Use an `Action` element to allow or deny permission to call this action.

  - You cannot use an IAM policy to constrain this action's parameters.

  If the caller does not have sufficient permissions to invoke the action, or
  the parameter values fall outside the specified constraints, the action
  fails. The associated event attribute's **cause** parameter will be set to
  OPERATION_NOT_PERMITTED. For details and example IAM policies, see [Using
  IAM to Manage Access to Amazon SWF
  Workflows](http://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html).
  """

  @spec respond_activity_task_completed(client :: ExAws.SWF.t, input :: respond_activity_task_completed_input) :: ExAws.Request.JSON.response_t
  def respond_activity_task_completed(client, input) do
    request(client, "RespondActivityTaskCompleted", format_input(input))
  end

  @doc """
  Same as `respond_activity_task_completed/2` but raise on error.
  """
  @spec respond_activity_task_completed!(client :: ExAws.SWF.t, input :: respond_activity_task_completed_input) :: ExAws.Request.JSON.success_t | no_return
  def respond_activity_task_completed!(client, input) do
    case respond_activity_task_completed(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RespondActivityTaskFailed

  Used by workers to tell the service that the `ActivityTask` identified by
  the `taskToken` has failed with `reason` (if specified). The `reason` and
  `details` appear in the `ActivityTaskFailed` event added to the workflow
  history.

  A task is considered open from the time that it is scheduled until it is
  closed. Therefore a task is reported as open while a worker is processing
  it. A task is closed after it has been specified in a call to
  `RespondActivityTaskCompleted`, `RespondActivityTaskCanceled`,
  RespondActivityTaskFailed, or the task has [timed
  out](http://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dg-basic.html#swf-dev-timeout-types).

  **Access Control**

  You can use IAM policies to control this action's access to Amazon SWF
  resources as follows:

  - Use a `Resource` element with the domain name to limit the action to only
  specified domains.

  - Use an `Action` element to allow or deny permission to call this action.

  - You cannot use an IAM policy to constrain this action's parameters.

  If the caller does not have sufficient permissions to invoke the action, or
  the parameter values fall outside the specified constraints, the action
  fails. The associated event attribute's **cause** parameter will be set to
  OPERATION_NOT_PERMITTED. For details and example IAM policies, see [Using
  IAM to Manage Access to Amazon SWF
  Workflows](http://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html).
  """

  @spec respond_activity_task_failed(client :: ExAws.SWF.t, input :: respond_activity_task_failed_input) :: ExAws.Request.JSON.response_t
  def respond_activity_task_failed(client, input) do
    request(client, "RespondActivityTaskFailed", format_input(input))
  end

  @doc """
  Same as `respond_activity_task_failed/2` but raise on error.
  """
  @spec respond_activity_task_failed!(client :: ExAws.SWF.t, input :: respond_activity_task_failed_input) :: ExAws.Request.JSON.success_t | no_return
  def respond_activity_task_failed!(client, input) do
    case respond_activity_task_failed(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RespondDecisionTaskCompleted

  Used by deciders to tell the service that the `DecisionTask` identified by
  the `taskToken` has successfully completed. The `decisions` argument
  specifies the list of decisions made while processing the task.

  A `DecisionTaskCompleted` event is added to the workflow history. The
  `executionContext` specified is attached to the event in the workflow
  execution history.

  **Access Control**

  If an IAM policy grants permission to use `RespondDecisionTaskCompleted`,
  it can express permissions for the list of decisions in the `decisions`
  parameter. Each of the decisions has one or more parameters, much like a
  regular API call. To allow for policies to be as readable as possible, you
  can express permissions on decisions as if they were actual API calls,
  including applying conditions to some parameters. For more information, see
  [Using IAM to Manage Access to Amazon SWF
  Workflows](http://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html).
  """

  @spec respond_decision_task_completed(client :: ExAws.SWF.t, input :: respond_decision_task_completed_input) :: ExAws.Request.JSON.response_t
  def respond_decision_task_completed(client, input) do
    request(client, "RespondDecisionTaskCompleted", format_input(input))
  end

  @doc """
  Same as `respond_decision_task_completed/2` but raise on error.
  """
  @spec respond_decision_task_completed!(client :: ExAws.SWF.t, input :: respond_decision_task_completed_input) :: ExAws.Request.JSON.success_t | no_return
  def respond_decision_task_completed!(client, input) do
    case respond_decision_task_completed(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  SignalWorkflowExecution

  Records a `WorkflowExecutionSignaled` event in the workflow execution
  history and creates a decision task for the workflow execution identified
  by the given domain, workflowId and runId. The event is recorded with the
  specified user defined signalName and input (if provided).

  Note: If a runId is not specified, then the `WorkflowExecutionSignaled`
  event is recorded in the history of the current open workflow with the
  matching workflowId in the domain. Note: If the specified workflow
  execution is not open, this method fails with `UnknownResource`. **Access
  Control**

  You can use IAM policies to control this action's access to Amazon SWF
  resources as follows:

  - Use a `Resource` element with the domain name to limit the action to only
  specified domains.

  - Use an `Action` element to allow or deny permission to call this action.

  - You cannot use an IAM policy to constrain this action's parameters.

  If the caller does not have sufficient permissions to invoke the action, or
  the parameter values fall outside the specified constraints, the action
  fails. The associated event attribute's **cause** parameter will be set to
  OPERATION_NOT_PERMITTED. For details and example IAM policies, see [Using
  IAM to Manage Access to Amazon SWF
  Workflows](http://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html).
  """

  @spec signal_workflow_execution(client :: ExAws.SWF.t, input :: signal_workflow_execution_input) :: ExAws.Request.JSON.response_t
  def signal_workflow_execution(client, input) do
    request(client, "SignalWorkflowExecution", format_input(input))
  end

  @doc """
  Same as `signal_workflow_execution/2` but raise on error.
  """
  @spec signal_workflow_execution!(client :: ExAws.SWF.t, input :: signal_workflow_execution_input) :: ExAws.Request.JSON.success_t | no_return
  def signal_workflow_execution!(client, input) do
    case signal_workflow_execution(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  StartWorkflowExecution

  Starts an execution of the workflow type in the specified domain using the
  provided `workflowId` and input data.

  This action returns the newly started workflow execution.

  **Access Control**

  You can use IAM policies to control this action's access to Amazon SWF
  resources as follows:

  - Use a `Resource` element with the domain name to limit the action to only
  specified domains.

  - Use an `Action` element to allow or deny permission to call this action.

  - Constrain the following parameters by using a `Condition` element with
  the appropriate keys.

  - `tagList.member.0`: The key is `swf:tagList.member.0`.

  - `tagList.member.1`: The key is `swf:tagList.member.1`.

  - `tagList.member.2`: The key is `swf:tagList.member.2`.

  - `tagList.member.3`: The key is `swf:tagList.member.3`.

  - `tagList.member.4`: The key is `swf:tagList.member.4`.

  - `taskList`: String constraint. The key is `swf:taskList.name`.

  - `workflowType.name`: String constraint. The key is
  `swf:workflowType.name`.

  - `workflowType.version`: String constraint. The key is
  `swf:workflowType.version`.

  If the caller does not have sufficient permissions to invoke the action, or
  the parameter values fall outside the specified constraints, the action
  fails. The associated event attribute's **cause** parameter will be set to
  OPERATION_NOT_PERMITTED. For details and example IAM policies, see [Using
  IAM to Manage Access to Amazon SWF
  Workflows](http://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html).
  """

  @spec start_workflow_execution(client :: ExAws.SWF.t, input :: start_workflow_execution_input) :: ExAws.Request.JSON.response_t
  def start_workflow_execution(client, input) do
    request(client, "StartWorkflowExecution", format_input(input))
  end

  @doc """
  Same as `start_workflow_execution/2` but raise on error.
  """
  @spec start_workflow_execution!(client :: ExAws.SWF.t, input :: start_workflow_execution_input) :: ExAws.Request.JSON.success_t | no_return
  def start_workflow_execution!(client, input) do
    case start_workflow_execution(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  TerminateWorkflowExecution

  Records a `WorkflowExecutionTerminated` event and forces closure of the
  workflow execution identified by the given domain, runId, and workflowId.
  The child policy, registered with the workflow type or specified when
  starting this execution, is applied to any open child workflow executions
  of this workflow execution.

  ** If the identified workflow execution was in progress, it is terminated
  immediately.** Note: If a runId is not specified, then the
  `WorkflowExecutionTerminated` event is recorded in the history of the
  current open workflow with the matching workflowId in the domain. Note: You
  should consider using `RequestCancelWorkflowExecution` action instead
  because it allows the workflow to gracefully close while
  `TerminateWorkflowExecution` does not. **Access Control**

  You can use IAM policies to control this action's access to Amazon SWF
  resources as follows:

  - Use a `Resource` element with the domain name to limit the action to only
  specified domains.

  - Use an `Action` element to allow or deny permission to call this action.

  - You cannot use an IAM policy to constrain this action's parameters.

  If the caller does not have sufficient permissions to invoke the action, or
  the parameter values fall outside the specified constraints, the action
  fails. The associated event attribute's **cause** parameter will be set to
  OPERATION_NOT_PERMITTED. For details and example IAM policies, see [Using
  IAM to Manage Access to Amazon SWF
  Workflows](http://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html).
  """

  @spec terminate_workflow_execution(client :: ExAws.SWF.t, input :: terminate_workflow_execution_input) :: ExAws.Request.JSON.response_t
  def terminate_workflow_execution(client, input) do
    request(client, "TerminateWorkflowExecution", format_input(input))
  end

  @doc """
  Same as `terminate_workflow_execution/2` but raise on error.
  """
  @spec terminate_workflow_execution!(client :: ExAws.SWF.t, input :: terminate_workflow_execution_input) :: ExAws.Request.JSON.success_t | no_return
  def terminate_workflow_execution!(client, input) do
    case terminate_workflow_execution(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  defp request(%{__struct__: client_module} = client, action, input) do
    apply(client_module, :request, [client, action, input])
  end
end
