defmodule ExAws.Autoscaling.Core do
  @actions [
    "AttachInstances",
    "AttachLoadBalancers",
    "CompleteLifecycleAction",
    "CreateAutoScalingGroup",
    "CreateLaunchConfiguration",
    "CreateOrUpdateTags",
    "DeleteAutoScalingGroup",
    "DeleteLaunchConfiguration",
    "DeleteLifecycleHook",
    "DeleteNotificationConfiguration",
    "DeletePolicy",
    "DeleteScheduledAction",
    "DeleteTags",
    "DescribeAccountLimits",
    "DescribeAdjustmentTypes",
    "DescribeAutoScalingGroups",
    "DescribeAutoScalingInstances",
    "DescribeAutoScalingNotificationTypes",
    "DescribeLaunchConfigurations",
    "DescribeLifecycleHookTypes",
    "DescribeLifecycleHooks",
    "DescribeLoadBalancers",
    "DescribeMetricCollectionTypes",
    "DescribeNotificationConfigurations",
    "DescribePolicies",
    "DescribeScalingActivities",
    "DescribeScalingProcessTypes",
    "DescribeScheduledActions",
    "DescribeTags",
    "DescribeTerminationPolicyTypes",
    "DetachInstances",
    "DetachLoadBalancers",
    "DisableMetricsCollection",
    "EnableMetricsCollection",
    "EnterStandby",
    "ExecutePolicy",
    "ExitStandby",
    "PutLifecycleHook",
    "PutNotificationConfiguration",
    "PutScalingPolicy",
    "PutScheduledUpdateGroupAction",
    "RecordLifecycleActionHeartbeat",
    "ResumeProcesses",
    "SetDesiredCapacity",
    "SetInstanceHealth",
    "SuspendProcesses",
    "TerminateInstanceInAutoScalingGroup",
    "UpdateAutoScalingGroup"]

  @moduledoc """
  ## Auto Scaling

  Auto Scaling

  Auto Scaling is designed to automatically launch or terminate EC2 instances
  based on user-defined policies, schedules, and health checks. Use this
  service in conjunction with the Amazon CloudWatch and Elastic Load
  Balancing services.
  """

  @type activities :: [activity]

  @type activities_type :: [
    activities: activities,
    next_token: xml_string,
  ]

  @type activity :: [
    activity_id: xml_string,
    auto_scaling_group_name: xml_string_max_len255,
    cause: xml_string_max_len1023,
    description: xml_string,
    details: xml_string,
    end_time: timestamp_type,
    progress: progress,
    start_time: timestamp_type,
    status_code: scaling_activity_status_code,
    status_message: xml_string_max_len255,
  ]

  @type activity_ids :: [xml_string]

  @type activity_type :: [
    activity: activity,
  ]

  @type adjustment_type :: [
    adjustment_type: xml_string_max_len255,
  ]

  @type adjustment_types :: [adjustment_type]

  @type alarm :: [
    alarm_arn: resource_name,
    alarm_name: xml_string_max_len255,
  ]

  @type alarms :: [alarm]

  @type already_exists_fault :: [
    message: xml_string_max_len255,
  ]

  @type ascii_string_max_len255 :: binary

  @type associate_public_ip_address :: boolean

  @type attach_instances_query :: [
    auto_scaling_group_name: resource_name,
    instance_ids: instance_ids,
  ]

  @type attach_load_balancers_result_type :: [
  ]

  @type attach_load_balancers_type :: [
    auto_scaling_group_name: resource_name,
    load_balancer_names: load_balancer_names,
  ]

  @type auto_scaling_group :: [
    auto_scaling_group_arn: resource_name,
    auto_scaling_group_name: xml_string_max_len255,
    availability_zones: availability_zones,
    created_time: timestamp_type,
    default_cooldown: cooldown,
    desired_capacity: auto_scaling_group_desired_capacity,
    enabled_metrics: enabled_metrics,
    health_check_grace_period: health_check_grace_period,
    health_check_type: xml_string_max_len32,
    instances: instances,
    launch_configuration_name: xml_string_max_len255,
    load_balancer_names: load_balancer_names,
    max_size: auto_scaling_group_max_size,
    min_size: auto_scaling_group_min_size,
    placement_group: xml_string_max_len255,
    status: xml_string_max_len255,
    suspended_processes: suspended_processes,
    tags: tag_description_list,
    termination_policies: termination_policies,
    vpc_zone_identifier: xml_string_max_len255,
  ]

  @type auto_scaling_group_desired_capacity :: integer

  @type auto_scaling_group_max_size :: integer

  @type auto_scaling_group_min_size :: integer

  @type auto_scaling_group_names :: [resource_name]

  @type auto_scaling_group_names_type :: [
    auto_scaling_group_names: auto_scaling_group_names,
    max_records: max_records,
    next_token: xml_string,
  ]

  @type auto_scaling_groups :: [auto_scaling_group]

  @type auto_scaling_groups_type :: [
    auto_scaling_groups: auto_scaling_groups,
    next_token: xml_string,
  ]

  @type auto_scaling_instance_details :: [
    auto_scaling_group_name: xml_string_max_len255,
    availability_zone: xml_string_max_len255,
    health_status: xml_string_max_len32,
    instance_id: xml_string_max_len16,
    launch_configuration_name: xml_string_max_len255,
    lifecycle_state: xml_string_max_len32,
  ]

  @type auto_scaling_instances :: [auto_scaling_instance_details]

  @type auto_scaling_instances_type :: [
    auto_scaling_instances: auto_scaling_instances,
    next_token: xml_string,
  ]

  @type auto_scaling_notification_types :: [xml_string_max_len255]

  @type availability_zones :: [xml_string_max_len255]

  @type block_device_ebs_delete_on_termination :: boolean

  @type block_device_ebs_iops :: integer

  @type block_device_ebs_volume_size :: integer

  @type block_device_ebs_volume_type :: binary

  @type block_device_mapping :: [
    device_name: xml_string_max_len255,
    ebs: ebs,
    no_device: no_device,
    virtual_name: xml_string_max_len255,
  ]

  @type block_device_mappings :: [block_device_mapping]

  @type classic_link_vpc_security_groups :: [xml_string_max_len255]

  @type complete_lifecycle_action_answer :: [
  ]

  @type complete_lifecycle_action_type :: [
    auto_scaling_group_name: resource_name,
    lifecycle_action_result: lifecycle_action_result,
    lifecycle_action_token: lifecycle_action_token,
    lifecycle_hook_name: ascii_string_max_len255,
  ]

  @type cooldown :: integer

  @type create_auto_scaling_group_type :: [
    auto_scaling_group_name: xml_string_max_len255,
    availability_zones: availability_zones,
    default_cooldown: cooldown,
    desired_capacity: auto_scaling_group_desired_capacity,
    health_check_grace_period: health_check_grace_period,
    health_check_type: xml_string_max_len32,
    instance_id: xml_string_max_len16,
    launch_configuration_name: resource_name,
    load_balancer_names: load_balancer_names,
    max_size: auto_scaling_group_max_size,
    min_size: auto_scaling_group_min_size,
    placement_group: xml_string_max_len255,
    tags: tags,
    termination_policies: termination_policies,
    vpc_zone_identifier: xml_string_max_len255,
  ]

  @type create_launch_configuration_type :: [
    associate_public_ip_address: associate_public_ip_address,
    block_device_mappings: block_device_mappings,
    classic_link_vpc_id: xml_string_max_len255,
    classic_link_vpc_security_groups: classic_link_vpc_security_groups,
    ebs_optimized: ebs_optimized,
    iam_instance_profile: xml_string_max_len1600,
    image_id: xml_string_max_len255,
    instance_id: xml_string_max_len16,
    instance_monitoring: instance_monitoring,
    instance_type: xml_string_max_len255,
    kernel_id: xml_string_max_len255,
    key_name: xml_string_max_len255,
    launch_configuration_name: xml_string_max_len255,
    placement_tenancy: xml_string_max_len64,
    ramdisk_id: xml_string_max_len255,
    security_groups: security_groups,
    spot_price: spot_price,
    user_data: xml_string_user_data,
  ]

  @type create_or_update_tags_type :: [
    tags: tags,
  ]

  @type delete_auto_scaling_group_type :: [
    auto_scaling_group_name: resource_name,
    force_delete: force_delete,
  ]

  @type delete_lifecycle_hook_answer :: [
  ]

  @type delete_lifecycle_hook_type :: [
    auto_scaling_group_name: resource_name,
    lifecycle_hook_name: ascii_string_max_len255,
  ]

  @type delete_notification_configuration_type :: [
    auto_scaling_group_name: resource_name,
    topic_arn: resource_name,
  ]

  @type delete_policy_type :: [
    auto_scaling_group_name: resource_name,
    policy_name: resource_name,
  ]

  @type delete_scheduled_action_type :: [
    auto_scaling_group_name: resource_name,
    scheduled_action_name: resource_name,
  ]

  @type delete_tags_type :: [
    tags: tags,
  ]

  @type describe_account_limits_answer :: [
    max_number_of_auto_scaling_groups: max_number_of_auto_scaling_groups,
    max_number_of_launch_configurations: max_number_of_launch_configurations,
  ]

  @type describe_adjustment_types_answer :: [
    adjustment_types: adjustment_types,
  ]

  @type describe_auto_scaling_instances_type :: [
    instance_ids: instance_ids,
    max_records: max_records,
    next_token: xml_string,
  ]

  @type describe_auto_scaling_notification_types_answer :: [
    auto_scaling_notification_types: auto_scaling_notification_types,
  ]

  @type describe_lifecycle_hook_types_answer :: [
    lifecycle_hook_types: auto_scaling_notification_types,
  ]

  @type describe_lifecycle_hooks_answer :: [
    lifecycle_hooks: lifecycle_hooks,
  ]

  @type describe_lifecycle_hooks_type :: [
    auto_scaling_group_name: resource_name,
    lifecycle_hook_names: lifecycle_hook_names,
  ]

  @type describe_load_balancers_request :: [
    auto_scaling_group_name: resource_name,
    max_records: max_records,
    next_token: xml_string,
  ]

  @type describe_load_balancers_response :: [
    load_balancers: load_balancer_states,
    next_token: xml_string,
  ]

  @type describe_metric_collection_types_answer :: [
    granularities: metric_granularity_types,
    metrics: metric_collection_types,
  ]

  @type describe_notification_configurations_answer :: [
    next_token: xml_string,
    notification_configurations: notification_configurations,
  ]

  @type describe_notification_configurations_type :: [
    auto_scaling_group_names: auto_scaling_group_names,
    max_records: max_records,
    next_token: xml_string,
  ]

  @type describe_policies_type :: [
    auto_scaling_group_name: resource_name,
    max_records: max_records,
    next_token: xml_string,
    policy_names: policy_names,
    policy_types: policy_types,
  ]

  @type describe_scaling_activities_type :: [
    activity_ids: activity_ids,
    auto_scaling_group_name: resource_name,
    max_records: max_records,
    next_token: xml_string,
  ]

  @type describe_scheduled_actions_type :: [
    auto_scaling_group_name: resource_name,
    end_time: timestamp_type,
    max_records: max_records,
    next_token: xml_string,
    scheduled_action_names: scheduled_action_names,
    start_time: timestamp_type,
  ]

  @type describe_tags_type :: [
    filters: filters,
    max_records: max_records,
    next_token: xml_string,
  ]

  @type describe_termination_policy_types_answer :: [
    termination_policy_types: termination_policies,
  ]

  @type detach_instances_answer :: [
    activities: activities,
  ]

  @type detach_instances_query :: [
    auto_scaling_group_name: resource_name,
    instance_ids: instance_ids,
    should_decrement_desired_capacity: should_decrement_desired_capacity,
  ]

  @type detach_load_balancers_result_type :: [
  ]

  @type detach_load_balancers_type :: [
    auto_scaling_group_name: resource_name,
    load_balancer_names: load_balancer_names,
  ]

  @type disable_metrics_collection_query :: [
    auto_scaling_group_name: resource_name,
    metrics: metrics,
  ]

  @type ebs :: [
    delete_on_termination: block_device_ebs_delete_on_termination,
    iops: block_device_ebs_iops,
    snapshot_id: xml_string_max_len255,
    volume_size: block_device_ebs_volume_size,
    volume_type: block_device_ebs_volume_type,
  ]

  @type ebs_optimized :: boolean

  @type enable_metrics_collection_query :: [
    auto_scaling_group_name: resource_name,
    granularity: xml_string_max_len255,
    metrics: metrics,
  ]

  @type enabled_metric :: [
    granularity: xml_string_max_len255,
    metric: xml_string_max_len255,
  ]

  @type enabled_metrics :: [enabled_metric]

  @type enter_standby_answer :: [
    activities: activities,
  ]

  @type enter_standby_query :: [
    auto_scaling_group_name: resource_name,
    instance_ids: instance_ids,
    should_decrement_desired_capacity: should_decrement_desired_capacity,
  ]

  @type estimated_instance_warmup :: integer

  @type execute_policy_type :: [
    auto_scaling_group_name: resource_name,
    breach_threshold: metric_scale,
    honor_cooldown: honor_cooldown,
    metric_value: metric_scale,
    policy_name: resource_name,
  ]

  @type exit_standby_answer :: [
    activities: activities,
  ]

  @type exit_standby_query :: [
    auto_scaling_group_name: resource_name,
    instance_ids: instance_ids,
  ]

  @type filter :: [
    name: xml_string,
    values: values,
  ]

  @type filters :: [filter]

  @type force_delete :: boolean

  @type global_timeout :: integer

  @type health_check_grace_period :: integer

  @type heartbeat_timeout :: integer

  @type honor_cooldown :: boolean

  @type instance :: [
    availability_zone: xml_string_max_len255,
    health_status: xml_string_max_len32,
    instance_id: xml_string_max_len16,
    launch_configuration_name: xml_string_max_len255,
    lifecycle_state: lifecycle_state,
  ]

  @type instance_ids :: [xml_string_max_len16]

  @type instance_monitoring :: [
    enabled: monitoring_enabled,
  ]

  @type instances :: [instance]

  @type invalid_next_token :: [
    message: xml_string_max_len255,
  ]

  @type launch_configuration :: [
    associate_public_ip_address: associate_public_ip_address,
    block_device_mappings: block_device_mappings,
    classic_link_vpc_id: xml_string_max_len255,
    classic_link_vpc_security_groups: classic_link_vpc_security_groups,
    created_time: timestamp_type,
    ebs_optimized: ebs_optimized,
    iam_instance_profile: xml_string_max_len1600,
    image_id: xml_string_max_len255,
    instance_monitoring: instance_monitoring,
    instance_type: xml_string_max_len255,
    kernel_id: xml_string_max_len255,
    key_name: xml_string_max_len255,
    launch_configuration_arn: resource_name,
    launch_configuration_name: xml_string_max_len255,
    placement_tenancy: xml_string_max_len64,
    ramdisk_id: xml_string_max_len255,
    security_groups: security_groups,
    spot_price: spot_price,
    user_data: xml_string_user_data,
  ]

  @type launch_configuration_name_type :: [
    launch_configuration_name: resource_name,
  ]

  @type launch_configuration_names :: [resource_name]

  @type launch_configuration_names_type :: [
    launch_configuration_names: launch_configuration_names,
    max_records: max_records,
    next_token: xml_string,
  ]

  @type launch_configurations :: [launch_configuration]

  @type launch_configurations_type :: [
    launch_configurations: launch_configurations,
    next_token: xml_string,
  ]

  @type lifecycle_action_result :: binary

  @type lifecycle_action_token :: binary

  @type lifecycle_hook :: [
    auto_scaling_group_name: resource_name,
    default_result: lifecycle_action_result,
    global_timeout: global_timeout,
    heartbeat_timeout: heartbeat_timeout,
    lifecycle_hook_name: ascii_string_max_len255,
    lifecycle_transition: lifecycle_transition,
    notification_metadata: xml_string_max_len1023,
    notification_target_arn: resource_name,
    role_arn: resource_name,
  ]

  @type lifecycle_hook_names :: [ascii_string_max_len255]

  @type lifecycle_hooks :: [lifecycle_hook]

  @type lifecycle_state :: binary

  @type lifecycle_transition :: binary

  @type limit_exceeded_fault :: [
    message: xml_string_max_len255,
  ]

  @type load_balancer_names :: [xml_string_max_len255]

  @type load_balancer_state :: [
    load_balancer_name: xml_string_max_len255,
    state: xml_string_max_len255,
  ]

  @type load_balancer_states :: [load_balancer_state]

  @type max_number_of_auto_scaling_groups :: integer

  @type max_number_of_launch_configurations :: integer

  @type max_records :: integer

  @type metric_collection_type :: [
    metric: xml_string_max_len255,
  ]

  @type metric_collection_types :: [metric_collection_type]

  @type metric_granularity_type :: [
    granularity: xml_string_max_len255,
  ]

  @type metric_granularity_types :: [metric_granularity_type]

  @type metric_scale :: float

  @type metrics :: [xml_string_max_len255]

  @type min_adjustment_magnitude :: integer

  @type min_adjustment_step :: integer

  @type monitoring_enabled :: boolean

  @type no_device :: boolean

  @type notification_configuration :: [
    auto_scaling_group_name: resource_name,
    notification_type: xml_string_max_len255,
    topic_arn: resource_name,
  ]

  @type notification_configurations :: [notification_configuration]

  @type policies_type :: [
    next_token: xml_string,
    scaling_policies: scaling_policies,
  ]

  @type policy_arn_type :: [
    policy_arn: resource_name,
  ]

  @type policy_increment :: integer

  @type policy_names :: [resource_name]

  @type policy_types :: [xml_string_max_len64]

  @type process_names :: [xml_string_max_len255]

  @type process_type :: [
    process_name: xml_string_max_len255,
  ]

  @type processes :: [process_type]

  @type processes_type :: [
    processes: processes,
  ]

  @type progress :: integer

  @type propagate_at_launch :: boolean

  @type put_lifecycle_hook_answer :: [
  ]

  @type put_lifecycle_hook_type :: [
    auto_scaling_group_name: resource_name,
    default_result: lifecycle_action_result,
    heartbeat_timeout: heartbeat_timeout,
    lifecycle_hook_name: ascii_string_max_len255,
    lifecycle_transition: lifecycle_transition,
    notification_metadata: xml_string_max_len1023,
    notification_target_arn: resource_name,
    role_arn: resource_name,
  ]

  @type put_notification_configuration_type :: [
    auto_scaling_group_name: resource_name,
    notification_types: auto_scaling_notification_types,
    topic_arn: resource_name,
  ]

  @type put_scaling_policy_type :: [
    adjustment_type: xml_string_max_len255,
    auto_scaling_group_name: resource_name,
    cooldown: cooldown,
    estimated_instance_warmup: estimated_instance_warmup,
    metric_aggregation_type: xml_string_max_len32,
    min_adjustment_magnitude: min_adjustment_magnitude,
    min_adjustment_step: min_adjustment_step,
    policy_name: xml_string_max_len255,
    policy_type: xml_string_max_len64,
    scaling_adjustment: policy_increment,
    step_adjustments: step_adjustments,
  ]

  @type put_scheduled_update_group_action_type :: [
    auto_scaling_group_name: resource_name,
    desired_capacity: auto_scaling_group_desired_capacity,
    end_time: timestamp_type,
    max_size: auto_scaling_group_max_size,
    min_size: auto_scaling_group_min_size,
    recurrence: xml_string_max_len255,
    scheduled_action_name: xml_string_max_len255,
    start_time: timestamp_type,
    time: timestamp_type,
  ]

  @type record_lifecycle_action_heartbeat_answer :: [
  ]

  @type record_lifecycle_action_heartbeat_type :: [
    auto_scaling_group_name: resource_name,
    lifecycle_action_token: lifecycle_action_token,
    lifecycle_hook_name: ascii_string_max_len255,
  ]

  @type resource_contention_fault :: [
    message: xml_string_max_len255,
  ]

  @type resource_in_use_fault :: [
    message: xml_string_max_len255,
  ]

  @type resource_name :: binary

  @type scaling_activity_in_progress_fault :: [
    message: xml_string_max_len255,
  ]

  @type scaling_activity_status_code :: binary

  @type scaling_policies :: [scaling_policy]

  @type scaling_policy :: [
    adjustment_type: xml_string_max_len255,
    alarms: alarms,
    auto_scaling_group_name: xml_string_max_len255,
    cooldown: cooldown,
    estimated_instance_warmup: estimated_instance_warmup,
    metric_aggregation_type: xml_string_max_len32,
    min_adjustment_magnitude: min_adjustment_magnitude,
    min_adjustment_step: min_adjustment_step,
    policy_arn: resource_name,
    policy_name: xml_string_max_len255,
    policy_type: xml_string_max_len64,
    scaling_adjustment: policy_increment,
    step_adjustments: step_adjustments,
  ]

  @type scaling_process_query :: [
    auto_scaling_group_name: resource_name,
    scaling_processes: process_names,
  ]

  @type scheduled_action_names :: [resource_name]

  @type scheduled_actions_type :: [
    next_token: xml_string,
    scheduled_update_group_actions: scheduled_update_group_actions,
  ]

  @type scheduled_update_group_action :: [
    auto_scaling_group_name: xml_string_max_len255,
    desired_capacity: auto_scaling_group_desired_capacity,
    end_time: timestamp_type,
    max_size: auto_scaling_group_max_size,
    min_size: auto_scaling_group_min_size,
    recurrence: xml_string_max_len255,
    scheduled_action_arn: resource_name,
    scheduled_action_name: xml_string_max_len255,
    start_time: timestamp_type,
    time: timestamp_type,
  ]

  @type scheduled_update_group_actions :: [scheduled_update_group_action]

  @type security_groups :: [xml_string]

  @type set_desired_capacity_type :: [
    auto_scaling_group_name: resource_name,
    desired_capacity: auto_scaling_group_desired_capacity,
    honor_cooldown: honor_cooldown,
  ]

  @type set_instance_health_query :: [
    health_status: xml_string_max_len32,
    instance_id: xml_string_max_len16,
    should_respect_grace_period: should_respect_grace_period,
  ]

  @type should_decrement_desired_capacity :: boolean

  @type should_respect_grace_period :: boolean

  @type spot_price :: binary

  @type step_adjustment :: [
    metric_interval_lower_bound: metric_scale,
    metric_interval_upper_bound: metric_scale,
    scaling_adjustment: policy_increment,
  ]

  @type step_adjustments :: [step_adjustment]

  @type suspended_process :: [
    process_name: xml_string_max_len255,
    suspension_reason: xml_string_max_len255,
  ]

  @type suspended_processes :: [suspended_process]

  @type tag :: [
    key: tag_key,
    propagate_at_launch: propagate_at_launch,
    resource_id: xml_string,
    resource_type: xml_string,
    value: tag_value,
  ]

  @type tag_description :: [
    key: tag_key,
    propagate_at_launch: propagate_at_launch,
    resource_id: xml_string,
    resource_type: xml_string,
    value: tag_value,
  ]

  @type tag_description_list :: [tag_description]

  @type tag_key :: binary

  @type tag_value :: binary

  @type tags :: [tag]

  @type tags_type :: [
    next_token: xml_string,
    tags: tag_description_list,
  ]

  @type terminate_instance_in_auto_scaling_group_type :: [
    instance_id: xml_string_max_len16,
    should_decrement_desired_capacity: should_decrement_desired_capacity,
  ]

  @type termination_policies :: [xml_string_max_len1600]

  @type timestamp_type :: integer

  @type update_auto_scaling_group_type :: [
    auto_scaling_group_name: resource_name,
    availability_zones: availability_zones,
    default_cooldown: cooldown,
    desired_capacity: auto_scaling_group_desired_capacity,
    health_check_grace_period: health_check_grace_period,
    health_check_type: xml_string_max_len32,
    launch_configuration_name: resource_name,
    max_size: auto_scaling_group_max_size,
    min_size: auto_scaling_group_min_size,
    placement_group: xml_string_max_len255,
    termination_policies: termination_policies,
    vpc_zone_identifier: xml_string_max_len255,
  ]

  @type values :: [xml_string]

  @type xml_string :: binary

  @type xml_string_max_len1023 :: binary

  @type xml_string_max_len16 :: binary

  @type xml_string_max_len1600 :: binary

  @type xml_string_max_len255 :: binary

  @type xml_string_max_len32 :: binary

  @type xml_string_max_len64 :: binary

  @type xml_string_user_data :: binary




  @doc """
  AttachInstances

  Attaches one or more EC2 instances to the specified Auto Scaling group.

  For more information, see [Attach EC2 Instances to Your Auto Scaling
  Group](http://docs.aws.amazon.com/AutoScaling/latest/DeveloperGuide/attach-instance-asg.html)
  in the *Auto Scaling Developer Guide*.
  """

  @spec attach_instances(client :: ExAws.Autoscaling.t, input :: attach_instances_query) :: ExAws.Request.Query.response_t
  def attach_instances(client, input) do
    request(client, "/", "AttachInstances", input)
  end

  @doc """
  Same as `attach_instances/2` but raise on error.
  """
  @spec attach_instances!(client :: ExAws.Autoscaling.t, input :: attach_instances_query) :: ExAws.Request.Query.success_t | no_return
  def attach_instances!(client, input) do
    case attach_instances(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  AttachLoadBalancers

  Attaches one or more load balancers to the specified Auto Scaling group.

  To describe the load balancers for an Auto Scaling group, use
  `DescribeLoadBalancers`. To detach the load balancer from the Auto Scaling
  group, use `DetachLoadBalancers`.

  For more information, see [Attach a Load Balancer to Your Auto Scaling
  Group](http://docs.aws.amazon.com/AutoScaling/latest/DeveloperGuide/attach-load-balancer-asg.html)
  in the *Auto Scaling Developer Guide*.
  """

  @spec attach_load_balancers(client :: ExAws.Autoscaling.t, input :: attach_load_balancers_type) :: ExAws.Request.Query.response_t
  def attach_load_balancers(client, input) do
    request(client, "/", "AttachLoadBalancers", input)
  end

  @doc """
  Same as `attach_load_balancers/2` but raise on error.
  """
  @spec attach_load_balancers!(client :: ExAws.Autoscaling.t, input :: attach_load_balancers_type) :: ExAws.Request.Query.success_t | no_return
  def attach_load_balancers!(client, input) do
    case attach_load_balancers(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CompleteLifecycleAction

  Completes the lifecycle action for the associated token initiated under the
  given lifecycle hook with the specified result.

  This operation is a part of the basic sequence for adding a lifecycle hook
  to an Auto Scaling group:

  - Create a notification target. A target can be either an Amazon SQS queue
  or an Amazon SNS topic.

  - Create an IAM role. This role allows Auto Scaling to publish lifecycle
  notifications to the designated SQS queue or SNS topic.

  - Create the lifecycle hook. You can create a hook that acts when instances
  launch or when instances terminate.

  - If necessary, record the lifecycle action heartbeat to keep the instance
  in a pending state.

  - **Complete the lifecycle action**.

  For more information, see [Auto Scaling Pending
  State](http://docs.aws.amazon.com/AutoScaling/latest/DeveloperGuide/AutoScalingPendingState.html)
  and [Auto Scaling Terminating
  State](http://docs.aws.amazon.com/AutoScaling/latest/DeveloperGuide/AutoScalingTerminatingState.html)
  in the *Auto Scaling Developer Guide*.
  """

  @spec complete_lifecycle_action(client :: ExAws.Autoscaling.t, input :: complete_lifecycle_action_type) :: ExAws.Request.Query.response_t
  def complete_lifecycle_action(client, input) do
    request(client, "/", "CompleteLifecycleAction", input)
  end

  @doc """
  Same as `complete_lifecycle_action/2` but raise on error.
  """
  @spec complete_lifecycle_action!(client :: ExAws.Autoscaling.t, input :: complete_lifecycle_action_type) :: ExAws.Request.Query.success_t | no_return
  def complete_lifecycle_action!(client, input) do
    case complete_lifecycle_action(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateAutoScalingGroup

  Creates an Auto Scaling group with the specified name and attributes.

  If you exceed your maximum limit of Auto Scaling groups, which by default
  is 20 per region, the call fails. For information about viewing and
  updating this limit, see `DescribeAccountLimits`.

  For more information, see [Auto Scaling
  Groups](http://docs.aws.amazon.com/AutoScaling/latest/DeveloperGuide/AutoScalingGroup.html)
  in the *Auto Scaling Developer Guide*.
  """

  @spec create_auto_scaling_group(client :: ExAws.Autoscaling.t, input :: create_auto_scaling_group_type) :: ExAws.Request.Query.response_t
  def create_auto_scaling_group(client, input) do
    request(client, "/", "CreateAutoScalingGroup", input)
  end

  @doc """
  Same as `create_auto_scaling_group/2` but raise on error.
  """
  @spec create_auto_scaling_group!(client :: ExAws.Autoscaling.t, input :: create_auto_scaling_group_type) :: ExAws.Request.Query.success_t | no_return
  def create_auto_scaling_group!(client, input) do
    case create_auto_scaling_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateLaunchConfiguration

  Creates a launch configuration.

  If you exceed your maximum limit of launch configurations, which by default
  is 100 per region, the call fails. For information about viewing and
  updating this limit, see `DescribeAccountLimits`.

  For more information, see [Launch
  Configurations](http://docs.aws.amazon.com/AutoScaling/latest/DeveloperGuide/LaunchConfiguration.html)
  in the *Auto Scaling Developer Guide*.
  """

  @spec create_launch_configuration(client :: ExAws.Autoscaling.t, input :: create_launch_configuration_type) :: ExAws.Request.Query.response_t
  def create_launch_configuration(client, input) do
    request(client, "/", "CreateLaunchConfiguration", input)
  end

  @doc """
  Same as `create_launch_configuration/2` but raise on error.
  """
  @spec create_launch_configuration!(client :: ExAws.Autoscaling.t, input :: create_launch_configuration_type) :: ExAws.Request.Query.success_t | no_return
  def create_launch_configuration!(client, input) do
    case create_launch_configuration(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateOrUpdateTags

  Creates or updates tags for the specified Auto Scaling group.

  A tag is defined by its resource ID, resource type, key, value, and
  propagate flag. The value and the propagate flag are optional parameters.
  The only supported resource type is `auto-scaling-group`, and the resource
  ID must be the name of the group. The `PropagateAtLaunch` flag determines
  whether the tag is added to instances launched in the group. Valid values
  are `true` or `false`.

  When you specify a tag with a key that already exists, the operation
  overwrites the previous tag definition, and you do not get an error
  message.

  For more information, see [Tagging Auto Scaling Groups and
  Instances](http://docs.aws.amazon.com/AutoScaling/latest/DeveloperGuide/ASTagging.html)
  in the *Auto Scaling Developer Guide*.
  """

  @spec create_or_update_tags(client :: ExAws.Autoscaling.t, input :: create_or_update_tags_type) :: ExAws.Request.Query.response_t
  def create_or_update_tags(client, input) do
    request(client, "/", "CreateOrUpdateTags", input)
  end

  @doc """
  Same as `create_or_update_tags/2` but raise on error.
  """
  @spec create_or_update_tags!(client :: ExAws.Autoscaling.t, input :: create_or_update_tags_type) :: ExAws.Request.Query.success_t | no_return
  def create_or_update_tags!(client, input) do
    case create_or_update_tags(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteAutoScalingGroup

  Deletes the specified Auto Scaling group.

  The group must have no instances and no scaling activities in progress.

  To remove all instances before calling `DeleteAutoScalingGroup`, call
  `UpdateAutoScalingGroup` to set the minimum and maximum size of the Auto
  Scaling group to zero.
  """

  @spec delete_auto_scaling_group(client :: ExAws.Autoscaling.t, input :: delete_auto_scaling_group_type) :: ExAws.Request.Query.response_t
  def delete_auto_scaling_group(client, input) do
    request(client, "/", "DeleteAutoScalingGroup", input)
  end

  @doc """
  Same as `delete_auto_scaling_group/2` but raise on error.
  """
  @spec delete_auto_scaling_group!(client :: ExAws.Autoscaling.t, input :: delete_auto_scaling_group_type) :: ExAws.Request.Query.success_t | no_return
  def delete_auto_scaling_group!(client, input) do
    case delete_auto_scaling_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteLaunchConfiguration

  Deletes the specified launch configuration.

  The launch configuration must not be attached to an Auto Scaling group.
  When this call completes, the launch configuration is no longer available
  for use.
  """

  @spec delete_launch_configuration(client :: ExAws.Autoscaling.t, input :: launch_configuration_name_type) :: ExAws.Request.Query.response_t
  def delete_launch_configuration(client, input) do
    request(client, "/", "DeleteLaunchConfiguration", input)
  end

  @doc """
  Same as `delete_launch_configuration/2` but raise on error.
  """
  @spec delete_launch_configuration!(client :: ExAws.Autoscaling.t, input :: launch_configuration_name_type) :: ExAws.Request.Query.success_t | no_return
  def delete_launch_configuration!(client, input) do
    case delete_launch_configuration(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteLifecycleHook

  Deletes the specified lifecycle hook.

  If there are any outstanding lifecycle actions, they are completed first
  (`ABANDON` for launching instances, `CONTINUE` for terminating instances).
  """

  @spec delete_lifecycle_hook(client :: ExAws.Autoscaling.t, input :: delete_lifecycle_hook_type) :: ExAws.Request.Query.response_t
  def delete_lifecycle_hook(client, input) do
    request(client, "/", "DeleteLifecycleHook", input)
  end

  @doc """
  Same as `delete_lifecycle_hook/2` but raise on error.
  """
  @spec delete_lifecycle_hook!(client :: ExAws.Autoscaling.t, input :: delete_lifecycle_hook_type) :: ExAws.Request.Query.success_t | no_return
  def delete_lifecycle_hook!(client, input) do
    case delete_lifecycle_hook(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteNotificationConfiguration

  Deletes the specified notification.
  """

  @spec delete_notification_configuration(client :: ExAws.Autoscaling.t, input :: delete_notification_configuration_type) :: ExAws.Request.Query.response_t
  def delete_notification_configuration(client, input) do
    request(client, "/", "DeleteNotificationConfiguration", input)
  end

  @doc """
  Same as `delete_notification_configuration/2` but raise on error.
  """
  @spec delete_notification_configuration!(client :: ExAws.Autoscaling.t, input :: delete_notification_configuration_type) :: ExAws.Request.Query.success_t | no_return
  def delete_notification_configuration!(client, input) do
    case delete_notification_configuration(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeletePolicy

  Deletes the specified Auto Scaling policy.
  """

  @spec delete_policy(client :: ExAws.Autoscaling.t, input :: delete_policy_type) :: ExAws.Request.Query.response_t
  def delete_policy(client, input) do
    request(client, "/", "DeletePolicy", input)
  end

  @doc """
  Same as `delete_policy/2` but raise on error.
  """
  @spec delete_policy!(client :: ExAws.Autoscaling.t, input :: delete_policy_type) :: ExAws.Request.Query.success_t | no_return
  def delete_policy!(client, input) do
    case delete_policy(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteScheduledAction

  Deletes the specified scheduled action.
  """

  @spec delete_scheduled_action(client :: ExAws.Autoscaling.t, input :: delete_scheduled_action_type) :: ExAws.Request.Query.response_t
  def delete_scheduled_action(client, input) do
    request(client, "/", "DeleteScheduledAction", input)
  end

  @doc """
  Same as `delete_scheduled_action/2` but raise on error.
  """
  @spec delete_scheduled_action!(client :: ExAws.Autoscaling.t, input :: delete_scheduled_action_type) :: ExAws.Request.Query.success_t | no_return
  def delete_scheduled_action!(client, input) do
    case delete_scheduled_action(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteTags

  Deletes the specified tags.
  """

  @spec delete_tags(client :: ExAws.Autoscaling.t, input :: delete_tags_type) :: ExAws.Request.Query.response_t
  def delete_tags(client, input) do
    request(client, "/", "DeleteTags", input)
  end

  @doc """
  Same as `delete_tags/2` but raise on error.
  """
  @spec delete_tags!(client :: ExAws.Autoscaling.t, input :: delete_tags_type) :: ExAws.Request.Query.success_t | no_return
  def delete_tags!(client, input) do
    case delete_tags(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeAccountLimits

  Describes the current Auto Scaling resource limits for your AWS account.

  For information about requesting an increase in these limits, see [AWS
  Service
  Limits](http://docs.aws.amazon.com/general/latest/gr/aws_service_limits.html)
  in the *Amazon Web Services General Reference*.
  """

  @spec describe_account_limits(client :: ExAws.Autoscaling.t) :: ExAws.Request.Query.response_t
  def describe_account_limits(client) do
    request(client, "/", "DescribeAccountLimits", [])
  end

  @doc """
  Same as `describe_account_limits/2` but raise on error.
  """
  @spec describe_account_limits!(client :: ExAws.Autoscaling.t) :: ExAws.Request.Query.success_t | no_return
  def describe_account_limits!(client) do
    case describe_account_limits(client) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeAdjustmentTypes

  Describes the policy adjustment types for use with `PutScalingPolicy`.
  """

  @spec describe_adjustment_types(client :: ExAws.Autoscaling.t) :: ExAws.Request.Query.response_t
  def describe_adjustment_types(client) do
    request(client, "/", "DescribeAdjustmentTypes", [])
  end

  @doc """
  Same as `describe_adjustment_types/2` but raise on error.
  """
  @spec describe_adjustment_types!(client :: ExAws.Autoscaling.t) :: ExAws.Request.Query.success_t | no_return
  def describe_adjustment_types!(client) do
    case describe_adjustment_types(client) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeAutoScalingGroups

  Describes one or more Auto Scaling groups. If a list of names is not
  provided, the call describes all Auto Scaling groups.
  """

  @spec describe_auto_scaling_groups(client :: ExAws.Autoscaling.t, input :: auto_scaling_group_names_type) :: ExAws.Request.Query.response_t
  def describe_auto_scaling_groups(client, input) do
    request(client, "/", "DescribeAutoScalingGroups", input)
  end

  @doc """
  Same as `describe_auto_scaling_groups/2` but raise on error.
  """
  @spec describe_auto_scaling_groups!(client :: ExAws.Autoscaling.t, input :: auto_scaling_group_names_type) :: ExAws.Request.Query.success_t | no_return
  def describe_auto_scaling_groups!(client, input) do
    case describe_auto_scaling_groups(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeAutoScalingInstances

  Describes one or more Auto Scaling instances. If a list is not provided,
  the call describes all instances.
  """

  @spec describe_auto_scaling_instances(client :: ExAws.Autoscaling.t, input :: describe_auto_scaling_instances_type) :: ExAws.Request.Query.response_t
  def describe_auto_scaling_instances(client, input) do
    request(client, "/", "DescribeAutoScalingInstances", input)
  end

  @doc """
  Same as `describe_auto_scaling_instances/2` but raise on error.
  """
  @spec describe_auto_scaling_instances!(client :: ExAws.Autoscaling.t, input :: describe_auto_scaling_instances_type) :: ExAws.Request.Query.success_t | no_return
  def describe_auto_scaling_instances!(client, input) do
    case describe_auto_scaling_instances(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeAutoScalingNotificationTypes

  Describes the notification types that are supported by Auto Scaling.
  """

  @spec describe_auto_scaling_notification_types(client :: ExAws.Autoscaling.t) :: ExAws.Request.Query.response_t
  def describe_auto_scaling_notification_types(client) do
    request(client, "/", "DescribeAutoScalingNotificationTypes", [])
  end

  @doc """
  Same as `describe_auto_scaling_notification_types/2` but raise on error.
  """
  @spec describe_auto_scaling_notification_types!(client :: ExAws.Autoscaling.t) :: ExAws.Request.Query.success_t | no_return
  def describe_auto_scaling_notification_types!(client) do
    case describe_auto_scaling_notification_types(client) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeLaunchConfigurations

  Describes one or more launch configurations. If you omit the list of names,
  then the call describes all launch configurations.
  """

  @spec describe_launch_configurations(client :: ExAws.Autoscaling.t, input :: launch_configuration_names_type) :: ExAws.Request.Query.response_t
  def describe_launch_configurations(client, input) do
    request(client, "/", "DescribeLaunchConfigurations", input)
  end

  @doc """
  Same as `describe_launch_configurations/2` but raise on error.
  """
  @spec describe_launch_configurations!(client :: ExAws.Autoscaling.t, input :: launch_configuration_names_type) :: ExAws.Request.Query.success_t | no_return
  def describe_launch_configurations!(client, input) do
    case describe_launch_configurations(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeLifecycleHookTypes

  Describes the available types of lifecycle hooks.
  """

  @spec describe_lifecycle_hook_types(client :: ExAws.Autoscaling.t) :: ExAws.Request.Query.response_t
  def describe_lifecycle_hook_types(client) do
    request(client, "/", "DescribeLifecycleHookTypes", [])
  end

  @doc """
  Same as `describe_lifecycle_hook_types/2` but raise on error.
  """
  @spec describe_lifecycle_hook_types!(client :: ExAws.Autoscaling.t) :: ExAws.Request.Query.success_t | no_return
  def describe_lifecycle_hook_types!(client) do
    case describe_lifecycle_hook_types(client) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeLifecycleHooks

  Describes the lifecycle hooks for the specified Auto Scaling group.
  """

  @spec describe_lifecycle_hooks(client :: ExAws.Autoscaling.t, input :: describe_lifecycle_hooks_type) :: ExAws.Request.Query.response_t
  def describe_lifecycle_hooks(client, input) do
    request(client, "/", "DescribeLifecycleHooks", input)
  end

  @doc """
  Same as `describe_lifecycle_hooks/2` but raise on error.
  """
  @spec describe_lifecycle_hooks!(client :: ExAws.Autoscaling.t, input :: describe_lifecycle_hooks_type) :: ExAws.Request.Query.success_t | no_return
  def describe_lifecycle_hooks!(client, input) do
    case describe_lifecycle_hooks(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeLoadBalancers

  Describes the load balancers for the specified Auto Scaling group.
  """

  @spec describe_load_balancers(client :: ExAws.Autoscaling.t, input :: describe_load_balancers_request) :: ExAws.Request.Query.response_t
  def describe_load_balancers(client, input) do
    request(client, "/", "DescribeLoadBalancers", input)
  end

  @doc """
  Same as `describe_load_balancers/2` but raise on error.
  """
  @spec describe_load_balancers!(client :: ExAws.Autoscaling.t, input :: describe_load_balancers_request) :: ExAws.Request.Query.success_t | no_return
  def describe_load_balancers!(client, input) do
    case describe_load_balancers(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeMetricCollectionTypes

  Describes the available CloudWatch metrics for Auto Scaling.

  Note that the `GroupStandbyInstances` metric is not returned by default.
  You must explicitly request this metric when calling
  `EnableMetricsCollection`.
  """

  @spec describe_metric_collection_types(client :: ExAws.Autoscaling.t) :: ExAws.Request.Query.response_t
  def describe_metric_collection_types(client) do
    request(client, "/", "DescribeMetricCollectionTypes", [])
  end

  @doc """
  Same as `describe_metric_collection_types/2` but raise on error.
  """
  @spec describe_metric_collection_types!(client :: ExAws.Autoscaling.t) :: ExAws.Request.Query.success_t | no_return
  def describe_metric_collection_types!(client) do
    case describe_metric_collection_types(client) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeNotificationConfigurations

  Describes the notification actions associated with the specified Auto
  Scaling group.
  """

  @spec describe_notification_configurations(client :: ExAws.Autoscaling.t, input :: describe_notification_configurations_type) :: ExAws.Request.Query.response_t
  def describe_notification_configurations(client, input) do
    request(client, "/", "DescribeNotificationConfigurations", input)
  end

  @doc """
  Same as `describe_notification_configurations/2` but raise on error.
  """
  @spec describe_notification_configurations!(client :: ExAws.Autoscaling.t, input :: describe_notification_configurations_type) :: ExAws.Request.Query.success_t | no_return
  def describe_notification_configurations!(client, input) do
    case describe_notification_configurations(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribePolicies

  Describes the policies for the specified Auto Scaling group.
  """

  @spec describe_policies(client :: ExAws.Autoscaling.t, input :: describe_policies_type) :: ExAws.Request.Query.response_t
  def describe_policies(client, input) do
    request(client, "/", "DescribePolicies", input)
  end

  @doc """
  Same as `describe_policies/2` but raise on error.
  """
  @spec describe_policies!(client :: ExAws.Autoscaling.t, input :: describe_policies_type) :: ExAws.Request.Query.success_t | no_return
  def describe_policies!(client, input) do
    case describe_policies(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeScalingActivities

  Describes one or more scaling activities for the specified Auto Scaling
  group. If you omit the `ActivityIds`, the call returns all activities from
  the past six weeks. Activities are sorted by the start time. Activities
  still in progress appear first on the list.
  """

  @spec describe_scaling_activities(client :: ExAws.Autoscaling.t, input :: describe_scaling_activities_type) :: ExAws.Request.Query.response_t
  def describe_scaling_activities(client, input) do
    request(client, "/", "DescribeScalingActivities", input)
  end

  @doc """
  Same as `describe_scaling_activities/2` but raise on error.
  """
  @spec describe_scaling_activities!(client :: ExAws.Autoscaling.t, input :: describe_scaling_activities_type) :: ExAws.Request.Query.success_t | no_return
  def describe_scaling_activities!(client, input) do
    case describe_scaling_activities(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeScalingProcessTypes

  Describes the scaling process types for use with `ResumeProcesses` and
  `SuspendProcesses`.
  """

  @spec describe_scaling_process_types(client :: ExAws.Autoscaling.t) :: ExAws.Request.Query.response_t
  def describe_scaling_process_types(client) do
    request(client, "/", "DescribeScalingProcessTypes", [])
  end

  @doc """
  Same as `describe_scaling_process_types/2` but raise on error.
  """
  @spec describe_scaling_process_types!(client :: ExAws.Autoscaling.t) :: ExAws.Request.Query.success_t | no_return
  def describe_scaling_process_types!(client) do
    case describe_scaling_process_types(client) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeScheduledActions

  Describes the actions scheduled for your Auto Scaling group that haven't
  run. To describe the actions that have already run, use
  `DescribeScalingActivities`.
  """

  @spec describe_scheduled_actions(client :: ExAws.Autoscaling.t, input :: describe_scheduled_actions_type) :: ExAws.Request.Query.response_t
  def describe_scheduled_actions(client, input) do
    request(client, "/", "DescribeScheduledActions", input)
  end

  @doc """
  Same as `describe_scheduled_actions/2` but raise on error.
  """
  @spec describe_scheduled_actions!(client :: ExAws.Autoscaling.t, input :: describe_scheduled_actions_type) :: ExAws.Request.Query.success_t | no_return
  def describe_scheduled_actions!(client, input) do
    case describe_scheduled_actions(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeTags

  Describes the specified tags.

  You can use filters to limit the results. For example, you can query for
  the tags for a specific Auto Scaling group. You can specify multiple values
  for a filter. A tag must match at least one of the specified values for it
  to be included in the results.

  You can also specify multiple filters. The result includes information for
  a particular tag only if it matches all the filters. If there's no match,
  no special message is returned.
  """

  @spec describe_tags(client :: ExAws.Autoscaling.t, input :: describe_tags_type) :: ExAws.Request.Query.response_t
  def describe_tags(client, input) do
    request(client, "/", "DescribeTags", input)
  end

  @doc """
  Same as `describe_tags/2` but raise on error.
  """
  @spec describe_tags!(client :: ExAws.Autoscaling.t, input :: describe_tags_type) :: ExAws.Request.Query.success_t | no_return
  def describe_tags!(client, input) do
    case describe_tags(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeTerminationPolicyTypes

  Describes the termination policies supported by Auto Scaling.
  """

  @spec describe_termination_policy_types(client :: ExAws.Autoscaling.t) :: ExAws.Request.Query.response_t
  def describe_termination_policy_types(client) do
    request(client, "/", "DescribeTerminationPolicyTypes", [])
  end

  @doc """
  Same as `describe_termination_policy_types/2` but raise on error.
  """
  @spec describe_termination_policy_types!(client :: ExAws.Autoscaling.t) :: ExAws.Request.Query.success_t | no_return
  def describe_termination_policy_types!(client) do
    case describe_termination_policy_types(client) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DetachInstances

  Removes one or more instances from the specified Auto Scaling group. After
  the instances are detached, you can manage them independently from the rest
  of the Auto Scaling group.

  For more information, see [Detach EC2 Instances from Your Auto Scaling
  Group](http://docs.aws.amazon.com/AutoScaling/latest/DeveloperGuide/detach-instance-asg.html)
  in the *Auto Scaling Developer Guide*.
  """

  @spec detach_instances(client :: ExAws.Autoscaling.t, input :: detach_instances_query) :: ExAws.Request.Query.response_t
  def detach_instances(client, input) do
    request(client, "/", "DetachInstances", input)
  end

  @doc """
  Same as `detach_instances/2` but raise on error.
  """
  @spec detach_instances!(client :: ExAws.Autoscaling.t, input :: detach_instances_query) :: ExAws.Request.Query.success_t | no_return
  def detach_instances!(client, input) do
    case detach_instances(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DetachLoadBalancers

  Removes one or more load balancers from the specified Auto Scaling group.

  When you detach a load balancer, it enters the `Removing` state while
  deregistering the instances in the group. When all instances are
  deregistered, then you can no longer describe the load balancer using
  `DescribeLoadBalancers`. Note that the instances remain running.
  """

  @spec detach_load_balancers(client :: ExAws.Autoscaling.t, input :: detach_load_balancers_type) :: ExAws.Request.Query.response_t
  def detach_load_balancers(client, input) do
    request(client, "/", "DetachLoadBalancers", input)
  end

  @doc """
  Same as `detach_load_balancers/2` but raise on error.
  """
  @spec detach_load_balancers!(client :: ExAws.Autoscaling.t, input :: detach_load_balancers_type) :: ExAws.Request.Query.success_t | no_return
  def detach_load_balancers!(client, input) do
    case detach_load_balancers(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DisableMetricsCollection

  Disables monitoring of the specified metrics for the specified Auto Scaling
  group.
  """

  @spec disable_metrics_collection(client :: ExAws.Autoscaling.t, input :: disable_metrics_collection_query) :: ExAws.Request.Query.response_t
  def disable_metrics_collection(client, input) do
    request(client, "/", "DisableMetricsCollection", input)
  end

  @doc """
  Same as `disable_metrics_collection/2` but raise on error.
  """
  @spec disable_metrics_collection!(client :: ExAws.Autoscaling.t, input :: disable_metrics_collection_query) :: ExAws.Request.Query.success_t | no_return
  def disable_metrics_collection!(client, input) do
    case disable_metrics_collection(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  EnableMetricsCollection

  Enables monitoring of the specified metrics for the specified Auto Scaling
  group.

  You can only enable metrics collection if `InstanceMonitoring` in the
  launch configuration for the group is set to `True`.
  """

  @spec enable_metrics_collection(client :: ExAws.Autoscaling.t, input :: enable_metrics_collection_query) :: ExAws.Request.Query.response_t
  def enable_metrics_collection(client, input) do
    request(client, "/", "EnableMetricsCollection", input)
  end

  @doc """
  Same as `enable_metrics_collection/2` but raise on error.
  """
  @spec enable_metrics_collection!(client :: ExAws.Autoscaling.t, input :: enable_metrics_collection_query) :: ExAws.Request.Query.success_t | no_return
  def enable_metrics_collection!(client, input) do
    case enable_metrics_collection(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  EnterStandby

  Moves the specified instances into `Standby` mode.

  For more information, see [Auto Scaling InService
  State](http://docs.aws.amazon.com/AutoScaling/latest/DeveloperGuide/AutoScalingInServiceState.html)
  in the *Auto Scaling Developer Guide*.
  """

  @spec enter_standby(client :: ExAws.Autoscaling.t, input :: enter_standby_query) :: ExAws.Request.Query.response_t
  def enter_standby(client, input) do
    request(client, "/", "EnterStandby", input)
  end

  @doc """
  Same as `enter_standby/2` but raise on error.
  """
  @spec enter_standby!(client :: ExAws.Autoscaling.t, input :: enter_standby_query) :: ExAws.Request.Query.success_t | no_return
  def enter_standby!(client, input) do
    case enter_standby(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ExecutePolicy

  Executes the specified policy.
  """

  @spec execute_policy(client :: ExAws.Autoscaling.t, input :: execute_policy_type) :: ExAws.Request.Query.response_t
  def execute_policy(client, input) do
    request(client, "/", "ExecutePolicy", input)
  end

  @doc """
  Same as `execute_policy/2` but raise on error.
  """
  @spec execute_policy!(client :: ExAws.Autoscaling.t, input :: execute_policy_type) :: ExAws.Request.Query.success_t | no_return
  def execute_policy!(client, input) do
    case execute_policy(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ExitStandby

  Moves the specified instances out of `Standby` mode.

  For more information, see [Auto Scaling InService
  State](http://docs.aws.amazon.com/AutoScaling/latest/DeveloperGuide/AutoScalingInServiceState.html)
  in the *Auto Scaling Developer Guide*.
  """

  @spec exit_standby(client :: ExAws.Autoscaling.t, input :: exit_standby_query) :: ExAws.Request.Query.response_t
  def exit_standby(client, input) do
    request(client, "/", "ExitStandby", input)
  end

  @doc """
  Same as `exit_standby/2` but raise on error.
  """
  @spec exit_standby!(client :: ExAws.Autoscaling.t, input :: exit_standby_query) :: ExAws.Request.Query.success_t | no_return
  def exit_standby!(client, input) do
    case exit_standby(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  PutLifecycleHook

  Creates or updates a lifecycle hook for the specified Auto Scaling Group.

  A lifecycle hook tells Auto Scaling that you want to perform an action on
  an instance that is not actively in service; for example, either when the
  instance launches or before the instance terminates.

  This operation is a part of the basic sequence for adding a lifecycle hook
  to an Auto Scaling group:

  - Create a notification target. A target can be either an Amazon SQS queue
  or an Amazon SNS topic.

  - Create an IAM role. This role allows Auto Scaling to publish lifecycle
  notifications to the designated SQS queue or SNS topic.

  - **Create the lifecycle hook. You can create a hook that acts when
  instances launch or when instances terminate.**

  - If necessary, record the lifecycle action heartbeat to keep the instance
  in a pending state.

  - Complete the lifecycle action.

  For more information, see [Auto Scaling Pending
  State](http://docs.aws.amazon.com/AutoScaling/latest/DeveloperGuide/AutoScalingPendingState.html)
  and [Auto Scaling Terminating
  State](http://docs.aws.amazon.com/AutoScaling/latest/DeveloperGuide/AutoScalingTerminatingState.html)
  in the *Auto Scaling Developer Guide*.

  If you exceed your maximum limit of lifecycle hooks, which by default is 50
  per region, the call fails. For information about updating this limit, see
  [AWS Service
  Limits](http://docs.aws.amazon.com/general/latest/gr/aws_service_limits.html)
  in the *Amazon Web Services General Reference*.
  """

  @spec put_lifecycle_hook(client :: ExAws.Autoscaling.t, input :: put_lifecycle_hook_type) :: ExAws.Request.Query.response_t
  def put_lifecycle_hook(client, input) do
    request(client, "/", "PutLifecycleHook", input)
  end

  @doc """
  Same as `put_lifecycle_hook/2` but raise on error.
  """
  @spec put_lifecycle_hook!(client :: ExAws.Autoscaling.t, input :: put_lifecycle_hook_type) :: ExAws.Request.Query.success_t | no_return
  def put_lifecycle_hook!(client, input) do
    case put_lifecycle_hook(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  PutNotificationConfiguration

  Configures an Auto Scaling group to send notifications when specified
  events take place. Subscribers to this topic can have messages for events
  delivered to an endpoint such as a web server or email address.

  For more information see [Getting Notifications When Your Auto Scaling
  Group
  Changes](http://docs.aws.amazon.com/AutoScaling/latest/DeveloperGuide/ASGettingNotifications.html)
  in the *Auto Scaling Developer Guide*.

  This configuration overwrites an existing configuration.
  """

  @spec put_notification_configuration(client :: ExAws.Autoscaling.t, input :: put_notification_configuration_type) :: ExAws.Request.Query.response_t
  def put_notification_configuration(client, input) do
    request(client, "/", "PutNotificationConfiguration", input)
  end

  @doc """
  Same as `put_notification_configuration/2` but raise on error.
  """
  @spec put_notification_configuration!(client :: ExAws.Autoscaling.t, input :: put_notification_configuration_type) :: ExAws.Request.Query.success_t | no_return
  def put_notification_configuration!(client, input) do
    case put_notification_configuration(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  PutScalingPolicy

  Creates or updates a policy for an Auto Scaling group. To update an
  existing policy, use the existing policy name and set the parameters you
  want to change. Any existing parameter not changed in an update to an
  existing policy is not changed in this update request.

  If you exceed your maximum limit of step adjustments, which by default is
  20 per region, the call fails. For information about updating this limit,
  see [AWS Service
  Limits](http://docs.aws.amazon.com/general/latest/gr/aws_service_limits.html)
  in the *Amazon Web Services General Reference*.
  """

  @spec put_scaling_policy(client :: ExAws.Autoscaling.t, input :: put_scaling_policy_type) :: ExAws.Request.Query.response_t
  def put_scaling_policy(client, input) do
    request(client, "/", "PutScalingPolicy", input)
  end

  @doc """
  Same as `put_scaling_policy/2` but raise on error.
  """
  @spec put_scaling_policy!(client :: ExAws.Autoscaling.t, input :: put_scaling_policy_type) :: ExAws.Request.Query.success_t | no_return
  def put_scaling_policy!(client, input) do
    case put_scaling_policy(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  PutScheduledUpdateGroupAction

  Creates or updates a scheduled scaling action for an Auto Scaling group.
  When updating a scheduled scaling action, if you leave a parameter
  unspecified, the corresponding value remains unchanged in the affected Auto
  Scaling group.

  For more information, see [Scheduled
  Scaling](http://docs.aws.amazon.com/AutoScaling/latest/DeveloperGuide/schedule_time.html)
  in the *Auto Scaling Developer Guide*.
  """

  @spec put_scheduled_update_group_action(client :: ExAws.Autoscaling.t, input :: put_scheduled_update_group_action_type) :: ExAws.Request.Query.response_t
  def put_scheduled_update_group_action(client, input) do
    request(client, "/", "PutScheduledUpdateGroupAction", input)
  end

  @doc """
  Same as `put_scheduled_update_group_action/2` but raise on error.
  """
  @spec put_scheduled_update_group_action!(client :: ExAws.Autoscaling.t, input :: put_scheduled_update_group_action_type) :: ExAws.Request.Query.success_t | no_return
  def put_scheduled_update_group_action!(client, input) do
    case put_scheduled_update_group_action(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RecordLifecycleActionHeartbeat

  Records a heartbeat for the lifecycle action associated with a specific
  token. This extends the timeout by the length of time defined by the
  `HeartbeatTimeout` parameter of `PutLifecycleHook`.

  This operation is a part of the basic sequence for adding a lifecycle hook
  to an Auto Scaling group:

  - Create a notification target. A target can be either an Amazon SQS queue
  or an Amazon SNS topic.

  - Create an IAM role. This role allows Auto Scaling to publish lifecycle
  notifications to the designated SQS queue or SNS topic.

  - Create the lifecycle hook. You can create a hook that acts when instances
  launch or when instances terminate.

  - **If necessary, record the lifecycle action heartbeat to keep the
  instance in a pending state.**

  - Complete the lifecycle action.

  For more information, see [Auto Scaling Pending
  State](http://docs.aws.amazon.com/AutoScaling/latest/DeveloperGuide/AutoScalingPendingState.html)
  and [Auto Scaling Terminating
  State](http://docs.aws.amazon.com/AutoScaling/latest/DeveloperGuide/AutoScalingTerminatingState.html)
  in the *Auto Scaling Developer Guide*.
  """

  @spec record_lifecycle_action_heartbeat(client :: ExAws.Autoscaling.t, input :: record_lifecycle_action_heartbeat_type) :: ExAws.Request.Query.response_t
  def record_lifecycle_action_heartbeat(client, input) do
    request(client, "/", "RecordLifecycleActionHeartbeat", input)
  end

  @doc """
  Same as `record_lifecycle_action_heartbeat/2` but raise on error.
  """
  @spec record_lifecycle_action_heartbeat!(client :: ExAws.Autoscaling.t, input :: record_lifecycle_action_heartbeat_type) :: ExAws.Request.Query.success_t | no_return
  def record_lifecycle_action_heartbeat!(client, input) do
    case record_lifecycle_action_heartbeat(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ResumeProcesses

  Resumes the specified suspended Auto Scaling processes for the specified
  Auto Scaling group. To resume specific processes, use the
  `ScalingProcesses` parameter. To resume all processes, omit the
  `ScalingProcesses` parameter. For more information, see [Suspend and Resume
  Auto Scaling
  Processes](http://docs.aws.amazon.com/AutoScaling/latest/DeveloperGuide/US_SuspendResume.html)
  in the *Auto Scaling Developer Guide*.
  """

  @spec resume_processes(client :: ExAws.Autoscaling.t, input :: scaling_process_query) :: ExAws.Request.Query.response_t
  def resume_processes(client, input) do
    request(client, "/", "ResumeProcesses", input)
  end

  @doc """
  Same as `resume_processes/2` but raise on error.
  """
  @spec resume_processes!(client :: ExAws.Autoscaling.t, input :: scaling_process_query) :: ExAws.Request.Query.success_t | no_return
  def resume_processes!(client, input) do
    case resume_processes(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  SetDesiredCapacity

  Sets the size of the specified Auto Scaling group.

  For more information about desired capacity, see [What Is Auto
  Scaling?](http://docs.aws.amazon.com/AutoScaling/latest/DeveloperGuide/WhatIsAutoScaling.html)
  in the *Auto Scaling Developer Guide*.
  """

  @spec set_desired_capacity(client :: ExAws.Autoscaling.t, input :: set_desired_capacity_type) :: ExAws.Request.Query.response_t
  def set_desired_capacity(client, input) do
    request(client, "/", "SetDesiredCapacity", input)
  end

  @doc """
  Same as `set_desired_capacity/2` but raise on error.
  """
  @spec set_desired_capacity!(client :: ExAws.Autoscaling.t, input :: set_desired_capacity_type) :: ExAws.Request.Query.success_t | no_return
  def set_desired_capacity!(client, input) do
    case set_desired_capacity(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  SetInstanceHealth

  Sets the health status of the specified instance.

  For more information, see [Health
  Checks](http://docs.aws.amazon.com/AutoScaling/latest/DeveloperGuide/healthcheck.html)
  in the *Auto Scaling Developer Guide*.
  """

  @spec set_instance_health(client :: ExAws.Autoscaling.t, input :: set_instance_health_query) :: ExAws.Request.Query.response_t
  def set_instance_health(client, input) do
    request(client, "/", "SetInstanceHealth", input)
  end

  @doc """
  Same as `set_instance_health/2` but raise on error.
  """
  @spec set_instance_health!(client :: ExAws.Autoscaling.t, input :: set_instance_health_query) :: ExAws.Request.Query.success_t | no_return
  def set_instance_health!(client, input) do
    case set_instance_health(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  SuspendProcesses

  Suspends the specified Auto Scaling processes for the specified Auto
  Scaling group. To suspend specific processes, use the `ScalingProcesses`
  parameter. To suspend all processes, omit the `ScalingProcesses` parameter.

  Note that if you suspend either the `Launch` or `Terminate` process types,
  it can prevent other process types from functioning properly.

  To resume processes that have been suspended, use `ResumeProcesses`.

  For more information, see [Suspend and Resume Auto Scaling
  Processes](http://docs.aws.amazon.com/AutoScaling/latest/DeveloperGuide/US_SuspendResume.html)
  in the *Auto Scaling Developer Guide*.
  """

  @spec suspend_processes(client :: ExAws.Autoscaling.t, input :: scaling_process_query) :: ExAws.Request.Query.response_t
  def suspend_processes(client, input) do
    request(client, "/", "SuspendProcesses", input)
  end

  @doc """
  Same as `suspend_processes/2` but raise on error.
  """
  @spec suspend_processes!(client :: ExAws.Autoscaling.t, input :: scaling_process_query) :: ExAws.Request.Query.success_t | no_return
  def suspend_processes!(client, input) do
    case suspend_processes(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  TerminateInstanceInAutoScalingGroup

  Terminates the specified instance and optionally adjusts the desired group
  size.

  This call simply makes a termination request. The instances is not
  terminated immediately.
  """

  @spec terminate_instance_in_auto_scaling_group(client :: ExAws.Autoscaling.t, input :: terminate_instance_in_auto_scaling_group_type) :: ExAws.Request.Query.response_t
  def terminate_instance_in_auto_scaling_group(client, input) do
    request(client, "/", "TerminateInstanceInAutoScalingGroup", input)
  end

  @doc """
  Same as `terminate_instance_in_auto_scaling_group/2` but raise on error.
  """
  @spec terminate_instance_in_auto_scaling_group!(client :: ExAws.Autoscaling.t, input :: terminate_instance_in_auto_scaling_group_type) :: ExAws.Request.Query.success_t | no_return
  def terminate_instance_in_auto_scaling_group!(client, input) do
    case terminate_instance_in_auto_scaling_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateAutoScalingGroup

  Updates the configuration for the specified Auto Scaling group.

  To update an Auto Scaling group with a launch configuration with
  `InstanceMonitoring` set to `False`, you must first disable the collection
  of group metrics. Otherwise, you will get an error. If you have previously
  enabled the collection of group metrics, you can disable it using
  `DisableMetricsCollection`.

  The new settings are registered upon the completion of this call. Any
  launch configuration settings take effect on any triggers after this call
  returns. Scaling activities that are currently in progress aren't affected.

  Note the following:

  - If you specify a new value for `MinSize` without specifying a value for
  `DesiredCapacity`, and the new `MinSize` is larger than the current size of
  the group, we implicitly call `SetDesiredCapacity` to set the size of the
  group to the new value of `MinSize`.

  - If you specify a new value for `MaxSize` without specifying a value for
  `DesiredCapacity`, and the new `MaxSize` is smaller than the current size
  of the group, we implicitly call `SetDesiredCapacity` to set the size of
  the group to the new value of `MaxSize`.

  - All other optional parameters are left unchanged if not specified.
  """

  @spec update_auto_scaling_group(client :: ExAws.Autoscaling.t, input :: update_auto_scaling_group_type) :: ExAws.Request.Query.response_t
  def update_auto_scaling_group(client, input) do
    request(client, "/", "UpdateAutoScalingGroup", input)
  end

  @doc """
  Same as `update_auto_scaling_group/2` but raise on error.
  """
  @spec update_auto_scaling_group!(client :: ExAws.Autoscaling.t, input :: update_auto_scaling_group_type) :: ExAws.Request.Query.success_t | no_return
  def update_auto_scaling_group!(client, input) do
    case update_auto_scaling_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  defp request(%{__struct__: client_module} = client, uri, action, input) do
    apply(client_module, :request, [client, uri, action, input])
  end
end
