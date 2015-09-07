defmodule ExAws.CodeDeploy.Core do
  import ExAws.Core.JSON, only: [format_input: 1]
  @actions [
    "AddTagsToOnPremisesInstances",
    "BatchGetApplications",
    "BatchGetDeployments",
    "BatchGetOnPremisesInstances",
    "CreateApplication",
    "CreateDeployment",
    "CreateDeploymentConfig",
    "CreateDeploymentGroup",
    "DeleteApplication",
    "DeleteDeploymentConfig",
    "DeleteDeploymentGroup",
    "DeregisterOnPremisesInstance",
    "GetApplication",
    "GetApplicationRevision",
    "GetDeployment",
    "GetDeploymentConfig",
    "GetDeploymentGroup",
    "GetDeploymentInstance",
    "GetOnPremisesInstance",
    "ListApplicationRevisions",
    "ListApplications",
    "ListDeploymentConfigs",
    "ListDeploymentGroups",
    "ListDeploymentInstances",
    "ListDeployments",
    "ListOnPremisesInstances",
    "RegisterApplicationRevision",
    "RegisterOnPremisesInstance",
    "RemoveTagsFromOnPremisesInstances",
    "StopDeployment",
    "UpdateApplication",
    "UpdateDeploymentGroup"]

  @moduledoc """
  ## AWS CodeDeploy

  AWS CodeDeploy

  **Overview** This is the AWS CodeDeploy API Reference. This guide provides
  descriptions of the AWS CodeDeploy APIs. For additional information, see
  the [AWS CodeDeploy User
  Guide](http://docs.aws.amazon.com/codedeploy/latest/userguide).

  **Using the APIs** You can use the AWS CodeDeploy APIs to work with the
  following items:

  - Applications are unique identifiers that AWS CodeDeploy uses to ensure
  that the correct combinations of revisions, deployment configurations, and
  deployment groups are being referenced during deployments.

  You can use the AWS CodeDeploy APIs to create, delete, get, list, and
  update applications.

  - Deployment configurations are sets of deployment rules and deployment
  success and failure conditions that AWS CodeDeploy uses during deployments.

  You can use the AWS CodeDeploy APIs to create, delete, get, and list
  deployment configurations.

  - Deployment groups are groups of instances to which application revisions
  can be deployed.

  You can use the AWS CodeDeploy APIs to create, delete, get, list, and
  update deployment groups.

  - Instances represent Amazon EC2 instances to which application revisions
  are deployed. Instances are identified by their Amazon EC2 tags or Auto
  Scaling group names. Instances belong to deployment groups.

  You can use the AWS CodeDeploy APIs to get and list instances.

  - Deployments represent the process of deploying revisions to instances.

  You can use the AWS CodeDeploy APIs to create, get, list, and stop
  deployments.

  - Application revisions are archive files that are stored in Amazon S3
  buckets or GitHub repositories. These revisions contain source content
  (such as source code, web pages, executable files, any deployment scripts,
  and similar) along with an Application Specification file (AppSpec file).
  (The AppSpec file is unique to AWS CodeDeploy; it defines a series of
  deployment actions that you want AWS CodeDeploy to execute.) An application
  revision is uniquely identified by its Amazon S3 object key and its ETag,
  version, or both (for application revisions that are stored in Amazon S3
  buckets) or by its repository name and commit ID (for applications
  revisions that are stored in GitHub repositories). Application revisions
  are deployed through deployment groups.

  You can use the AWS CodeDeploy APIs to get, list, and register application
  revisions.
  """

  @type add_tags_to_on_premises_instances_input :: [
    instance_names: instance_name_list,
    tags: tag_list,
  ]

  @type application_already_exists_exception :: [
  ]

  @type application_does_not_exist_exception :: [
  ]

  @type application_id :: binary

  @type application_info :: [
    application_id: application_id,
    application_name: application_name,
    create_time: timestamp,
    linked_to_git_hub: boolean,
  ]

  @type application_limit_exceeded_exception :: [
  ]

  @type application_name :: binary

  @type application_name_required_exception :: [
  ]

  @type application_revision_sort_by :: binary

  @type applications_info_list :: [application_info]

  @type applications_list :: [application_name]

  @type auto_scaling_group :: [
    hook: auto_scaling_group_hook,
    name: auto_scaling_group_name,
  ]

  @type auto_scaling_group_hook :: binary

  @type auto_scaling_group_list :: [auto_scaling_group]

  @type auto_scaling_group_name :: binary

  @type auto_scaling_group_name_list :: [auto_scaling_group_name]

  @type batch_get_applications_input :: [
    application_names: applications_list,
  ]

  @type batch_get_applications_output :: [
    applications_info: applications_info_list,
  ]

  @type batch_get_deployments_input :: [
    deployment_ids: deployments_list,
  ]

  @type batch_get_deployments_output :: [
    deployments_info: deployments_info_list,
  ]

  @type batch_get_on_premises_instances_input :: [
    instance_names: instance_name_list,
  ]

  @type batch_get_on_premises_instances_output :: [
    instance_infos: instance_info_list,
  ]

  @type bucket_name_filter_required_exception :: [
  ]

  @type bundle_type :: binary

  @type commit_id :: binary

  @type create_application_input :: [
    application_name: application_name,
  ]

  @type create_application_output :: [
    application_id: application_id,
  ]

  @type create_deployment_config_input :: [
    deployment_config_name: deployment_config_name,
    minimum_healthy_hosts: minimum_healthy_hosts,
  ]

  @type create_deployment_config_output :: [
    deployment_config_id: deployment_config_id,
  ]

  @type create_deployment_group_input :: [
    application_name: application_name,
    auto_scaling_groups: auto_scaling_group_name_list,
    deployment_config_name: deployment_config_name,
    deployment_group_name: deployment_group_name,
    ec2_tag_filters: ec2_tag_filter_list,
    on_premises_instance_tag_filters: tag_filter_list,
    service_role_arn: role,
  ]

  @type create_deployment_group_output :: [
    deployment_group_id: deployment_group_id,
  ]

  @type create_deployment_input :: [
    application_name: application_name,
    deployment_config_name: deployment_config_name,
    deployment_group_name: deployment_group_name,
    description: description,
    ignore_application_stop_failures: boolean,
    revision: revision_location,
  ]

  @type create_deployment_output :: [
    deployment_id: deployment_id,
  ]

  @type delete_application_input :: [
    application_name: application_name,
  ]

  @type delete_deployment_config_input :: [
    deployment_config_name: deployment_config_name,
  ]

  @type delete_deployment_group_input :: [
    application_name: application_name,
    deployment_group_name: deployment_group_name,
  ]

  @type delete_deployment_group_output :: [
    hooks_not_cleaned_up: auto_scaling_group_list,
  ]

  @type deployment_already_completed_exception :: [
  ]

  @type deployment_config_already_exists_exception :: [
  ]

  @type deployment_config_does_not_exist_exception :: [
  ]

  @type deployment_config_id :: binary

  @type deployment_config_in_use_exception :: [
  ]

  @type deployment_config_info :: [
    create_time: timestamp,
    deployment_config_id: deployment_config_id,
    deployment_config_name: deployment_config_name,
    minimum_healthy_hosts: minimum_healthy_hosts,
  ]

  @type deployment_config_limit_exceeded_exception :: [
  ]

  @type deployment_config_name :: binary

  @type deployment_config_name_required_exception :: [
  ]

  @type deployment_configs_list :: [deployment_config_name]

  @type deployment_creator :: binary

  @type deployment_does_not_exist_exception :: [
  ]

  @type deployment_group_already_exists_exception :: [
  ]

  @type deployment_group_does_not_exist_exception :: [
  ]

  @type deployment_group_id :: binary

  @type deployment_group_info :: [
    application_name: application_name,
    auto_scaling_groups: auto_scaling_group_list,
    deployment_config_name: deployment_config_name,
    deployment_group_id: deployment_group_id,
    deployment_group_name: deployment_group_name,
    ec2_tag_filters: ec2_tag_filter_list,
    on_premises_instance_tag_filters: tag_filter_list,
    service_role_arn: role,
    target_revision: revision_location,
  ]

  @type deployment_group_limit_exceeded_exception :: [
  ]

  @type deployment_group_name :: binary

  @type deployment_group_name_required_exception :: [
  ]

  @type deployment_groups_list :: [deployment_group_name]

  @type deployment_id :: binary

  @type deployment_id_required_exception :: [
  ]

  @type deployment_info :: [
    application_name: application_name,
    complete_time: timestamp,
    create_time: timestamp,
    creator: deployment_creator,
    deployment_config_name: deployment_config_name,
    deployment_group_name: deployment_group_name,
    deployment_id: deployment_id,
    deployment_overview: deployment_overview,
    description: description,
    error_information: error_information,
    ignore_application_stop_failures: boolean,
    revision: revision_location,
    start_time: timestamp,
    status: deployment_status,
  ]

  @type deployment_limit_exceeded_exception :: [
  ]

  @type deployment_not_started_exception :: [
  ]

  @type deployment_overview :: [
    failed: instance_count,
    in_progress: instance_count,
    pending: instance_count,
    skipped: instance_count,
    succeeded: instance_count,
  ]

  @type deployment_status :: binary

  @type deployment_status_list :: [deployment_status]

  @type deployments_info_list :: [deployment_info]

  @type deployments_list :: [deployment_id]

  @type deregister_on_premises_instance_input :: [
    instance_name: instance_name,
  ]

  @type description :: binary

  @type description_too_long_exception :: [
  ]

  @type diagnostics :: [
    error_code: lifecycle_error_code,
    log_tail: log_tail,
    message: lifecycle_message,
    script_name: script_name,
  ]

  @type ec2_tag_filter :: [
    key: key,
    type: ec2_tag_filter_type,
    value: value,
  ]

  @type ec2_tag_filter_list :: [ec2_tag_filter]

  @type ec2_tag_filter_type :: binary

  @type e_tag :: binary

  @type error_code :: binary

  @type error_information :: [
    code: error_code,
    message: error_message,
  ]

  @type error_message :: binary

  @type generic_revision_info :: [
    deployment_groups: deployment_groups_list,
    description: description,
    first_used_time: timestamp,
    last_used_time: timestamp,
    register_time: timestamp,
  ]

  @type get_application_input :: [
    application_name: application_name,
  ]

  @type get_application_output :: [
    application: application_info,
  ]

  @type get_application_revision_input :: [
    application_name: application_name,
    revision: revision_location,
  ]

  @type get_application_revision_output :: [
    application_name: application_name,
    revision: revision_location,
    revision_info: generic_revision_info,
  ]

  @type get_deployment_config_input :: [
    deployment_config_name: deployment_config_name,
  ]

  @type get_deployment_config_output :: [
    deployment_config_info: deployment_config_info,
  ]

  @type get_deployment_group_input :: [
    application_name: application_name,
    deployment_group_name: deployment_group_name,
  ]

  @type get_deployment_group_output :: [
    deployment_group_info: deployment_group_info,
  ]

  @type get_deployment_input :: [
    deployment_id: deployment_id,
  ]

  @type get_deployment_instance_input :: [
    deployment_id: deployment_id,
    instance_id: instance_id,
  ]

  @type get_deployment_instance_output :: [
    instance_summary: instance_summary,
  ]

  @type get_deployment_output :: [
    deployment_info: deployment_info,
  ]

  @type get_on_premises_instance_input :: [
    instance_name: instance_name,
  ]

  @type get_on_premises_instance_output :: [
    instance_info: instance_info,
  ]

  @type git_hub_location :: [
    commit_id: commit_id,
    repository: repository,
  ]

  @type iam_user_arn :: binary

  @type iam_user_arn_already_registered_exception :: [
  ]

  @type iam_user_arn_required_exception :: [
  ]

  @type instance_arn :: binary

  @type instance_count :: integer

  @type instance_does_not_exist_exception :: [
  ]

  @type instance_id :: binary

  @type instance_id_required_exception :: [
  ]

  @type instance_info :: [
    deregister_time: timestamp,
    iam_user_arn: iam_user_arn,
    instance_arn: instance_arn,
    instance_name: instance_name,
    register_time: timestamp,
    tags: tag_list,
  ]

  @type instance_info_list :: [instance_info]

  @type instance_limit_exceeded_exception :: [
  ]

  @type instance_name :: binary

  @type instance_name_already_registered_exception :: [
  ]

  @type instance_name_list :: [instance_name]

  @type instance_name_required_exception :: [
  ]

  @type instance_not_registered_exception :: [
  ]

  @type instance_status :: binary

  @type instance_status_list :: [instance_status]

  @type instance_summary :: [
    deployment_id: deployment_id,
    instance_id: instance_id,
    last_updated_at: timestamp,
    lifecycle_events: lifecycle_event_list,
    status: instance_status,
  ]

  @type instances_list :: [instance_id]

  @type invalid_application_name_exception :: [
  ]

  @type invalid_auto_scaling_group_exception :: [
  ]

  @type invalid_bucket_name_filter_exception :: [
  ]

  @type invalid_deployed_state_filter_exception :: [
  ]

  @type invalid_deployment_config_name_exception :: [
  ]

  @type invalid_deployment_group_name_exception :: [
  ]

  @type invalid_deployment_id_exception :: [
  ]

  @type invalid_deployment_status_exception :: [
  ]

  @type invalid_e_c2_tag_exception :: [
  ]

  @type invalid_iam_user_arn_exception :: [
  ]

  @type invalid_instance_name_exception :: [
  ]

  @type invalid_instance_status_exception :: [
  ]

  @type invalid_key_prefix_filter_exception :: [
  ]

  @type invalid_minimum_healthy_host_value_exception :: [
  ]

  @type invalid_next_token_exception :: [
  ]

  @type invalid_operation_exception :: [
  ]

  @type invalid_registration_status_exception :: [
  ]

  @type invalid_revision_exception :: [
  ]

  @type invalid_role_exception :: [
  ]

  @type invalid_sort_by_exception :: [
  ]

  @type invalid_sort_order_exception :: [
  ]

  @type invalid_tag_exception :: [
  ]

  @type invalid_tag_filter_exception :: [
  ]

  @type invalid_time_range_exception :: [
  ]

  @type key :: binary

  @type lifecycle_error_code :: binary

  @type lifecycle_event :: [
    diagnostics: diagnostics,
    end_time: timestamp,
    lifecycle_event_name: lifecycle_event_name,
    start_time: timestamp,
    status: lifecycle_event_status,
  ]

  @type lifecycle_event_list :: [lifecycle_event]

  @type lifecycle_event_name :: binary

  @type lifecycle_event_status :: binary

  @type lifecycle_message :: binary

  @type list_application_revisions_input :: [
    application_name: application_name,
    deployed: list_state_filter_action,
    next_token: next_token,
    s3_bucket: s3_bucket,
    s3_key_prefix: s3_key,
    sort_by: application_revision_sort_by,
    sort_order: sort_order,
  ]

  @type list_application_revisions_output :: [
    next_token: next_token,
    revisions: revision_location_list,
  ]

  @type list_applications_input :: [
    next_token: next_token,
  ]

  @type list_applications_output :: [
    applications: applications_list,
    next_token: next_token,
  ]

  @type list_deployment_configs_input :: [
    next_token: next_token,
  ]

  @type list_deployment_configs_output :: [
    deployment_configs_list: deployment_configs_list,
    next_token: next_token,
  ]

  @type list_deployment_groups_input :: [
    application_name: application_name,
    next_token: next_token,
  ]

  @type list_deployment_groups_output :: [
    application_name: application_name,
    deployment_groups: deployment_groups_list,
    next_token: next_token,
  ]

  @type list_deployment_instances_input :: [
    deployment_id: deployment_id,
    instance_status_filter: instance_status_list,
    next_token: next_token,
  ]

  @type list_deployment_instances_output :: [
    instances_list: instances_list,
    next_token: next_token,
  ]

  @type list_deployments_input :: [
    application_name: application_name,
    create_time_range: time_range,
    deployment_group_name: deployment_group_name,
    include_only_statuses: deployment_status_list,
    next_token: next_token,
  ]

  @type list_deployments_output :: [
    deployments: deployments_list,
    next_token: next_token,
  ]

  @type list_on_premises_instances_input :: [
    next_token: next_token,
    registration_status: registration_status,
    tag_filters: tag_filter_list,
  ]

  @type list_on_premises_instances_output :: [
    instance_names: instance_name_list,
    next_token: next_token,
  ]

  @type list_state_filter_action :: binary

  @type log_tail :: binary

  @type message :: binary

  @type minimum_healthy_hosts :: [
    type: minimum_healthy_hosts_type,
    value: minimum_healthy_hosts_value,
  ]

  @type minimum_healthy_hosts_type :: binary

  @type minimum_healthy_hosts_value :: integer

  @type next_token :: binary

  @type register_application_revision_input :: [
    application_name: application_name,
    description: description,
    revision: revision_location,
  ]

  @type register_on_premises_instance_input :: [
    iam_user_arn: iam_user_arn,
    instance_name: instance_name,
  ]

  @type registration_status :: binary

  @type remove_tags_from_on_premises_instances_input :: [
    instance_names: instance_name_list,
    tags: tag_list,
  ]

  @type repository :: binary

  @type revision_does_not_exist_exception :: [
  ]

  @type revision_location :: [
    git_hub_location: git_hub_location,
    revision_type: revision_location_type,
    s3_location: s3_location,
  ]

  @type revision_location_list :: [revision_location]

  @type revision_location_type :: binary

  @type revision_required_exception :: [
  ]

  @type role :: binary

  @type role_required_exception :: [
  ]

  @type s3_bucket :: binary

  @type s3_key :: binary

  @type s3_location :: [
    bucket: s3_bucket,
    bundle_type: bundle_type,
    e_tag: e_tag,
    key: s3_key,
    version: version_id,
  ]

  @type script_name :: binary

  @type sort_order :: binary

  @type stop_deployment_input :: [
    deployment_id: deployment_id,
  ]

  @type stop_deployment_output :: [
    status: stop_status,
    status_message: message,
  ]

  @type stop_status :: binary

  @type tag :: [
    key: key,
    value: value,
  ]

  @type tag_filter :: [
    key: key,
    type: tag_filter_type,
    value: value,
  ]

  @type tag_filter_list :: [tag_filter]

  @type tag_filter_type :: binary

  @type tag_limit_exceeded_exception :: [
  ]

  @type tag_list :: [tag]

  @type tag_required_exception :: [
  ]

  @type time_range :: [
    end: timestamp,
    start: timestamp,
  ]

  @type timestamp :: integer

  @type update_application_input :: [
    application_name: application_name,
    new_application_name: application_name,
  ]

  @type update_deployment_group_input :: [
    application_name: application_name,
    auto_scaling_groups: auto_scaling_group_name_list,
    current_deployment_group_name: deployment_group_name,
    deployment_config_name: deployment_config_name,
    ec2_tag_filters: ec2_tag_filter_list,
    new_deployment_group_name: deployment_group_name,
    on_premises_instance_tag_filters: tag_filter_list,
    service_role_arn: role,
  ]

  @type update_deployment_group_output :: [
    hooks_not_cleaned_up: auto_scaling_group_list,
  ]

  @type value :: binary

  @type version_id :: binary





  @doc """
  AddTagsToOnPremisesInstances

  Adds tags to on-premises instances.
  """

  @spec add_tags_to_on_premises_instances(client :: ExAws.CodeDeploy.t, input :: add_tags_to_on_premises_instances_input) :: ExAws.Request.JSON.response_t
  def add_tags_to_on_premises_instances(client, input) do
    request(client, "AddTagsToOnPremisesInstances", format_input(input))
  end

  @doc """
  Same as `add_tags_to_on_premises_instances/2` but raise on error.
  """
  @spec add_tags_to_on_premises_instances!(client :: ExAws.CodeDeploy.t, input :: add_tags_to_on_premises_instances_input) :: ExAws.Request.JSON.success_t | no_return
  def add_tags_to_on_premises_instances!(client, input) do
    case add_tags_to_on_premises_instances(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  BatchGetApplications

  Gets information about one or more applications.
  """

  @spec batch_get_applications(client :: ExAws.CodeDeploy.t, input :: batch_get_applications_input) :: ExAws.Request.JSON.response_t
  def batch_get_applications(client, input) do
    request(client, "BatchGetApplications", format_input(input))
  end

  @doc """
  Same as `batch_get_applications/2` but raise on error.
  """
  @spec batch_get_applications!(client :: ExAws.CodeDeploy.t, input :: batch_get_applications_input) :: ExAws.Request.JSON.success_t | no_return
  def batch_get_applications!(client, input) do
    case batch_get_applications(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  BatchGetDeployments

  Gets information about one or more deployments.
  """

  @spec batch_get_deployments(client :: ExAws.CodeDeploy.t, input :: batch_get_deployments_input) :: ExAws.Request.JSON.response_t
  def batch_get_deployments(client, input) do
    request(client, "BatchGetDeployments", format_input(input))
  end

  @doc """
  Same as `batch_get_deployments/2` but raise on error.
  """
  @spec batch_get_deployments!(client :: ExAws.CodeDeploy.t, input :: batch_get_deployments_input) :: ExAws.Request.JSON.success_t | no_return
  def batch_get_deployments!(client, input) do
    case batch_get_deployments(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  BatchGetOnPremisesInstances

  Gets information about one or more on-premises instances.
  """

  @spec batch_get_on_premises_instances(client :: ExAws.CodeDeploy.t, input :: batch_get_on_premises_instances_input) :: ExAws.Request.JSON.response_t
  def batch_get_on_premises_instances(client, input) do
    request(client, "BatchGetOnPremisesInstances", format_input(input))
  end

  @doc """
  Same as `batch_get_on_premises_instances/2` but raise on error.
  """
  @spec batch_get_on_premises_instances!(client :: ExAws.CodeDeploy.t, input :: batch_get_on_premises_instances_input) :: ExAws.Request.JSON.success_t | no_return
  def batch_get_on_premises_instances!(client, input) do
    case batch_get_on_premises_instances(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateApplication

  Creates a new application.
  """

  @spec create_application(client :: ExAws.CodeDeploy.t, input :: create_application_input) :: ExAws.Request.JSON.response_t
  def create_application(client, input) do
    request(client, "CreateApplication", format_input(input))
  end

  @doc """
  Same as `create_application/2` but raise on error.
  """
  @spec create_application!(client :: ExAws.CodeDeploy.t, input :: create_application_input) :: ExAws.Request.JSON.success_t | no_return
  def create_application!(client, input) do
    case create_application(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateDeployment

  Deploys an application revision through the specified deployment group.
  """

  @spec create_deployment(client :: ExAws.CodeDeploy.t, input :: create_deployment_input) :: ExAws.Request.JSON.response_t
  def create_deployment(client, input) do
    request(client, "CreateDeployment", format_input(input))
  end

  @doc """
  Same as `create_deployment/2` but raise on error.
  """
  @spec create_deployment!(client :: ExAws.CodeDeploy.t, input :: create_deployment_input) :: ExAws.Request.JSON.success_t | no_return
  def create_deployment!(client, input) do
    case create_deployment(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateDeploymentConfig

  Creates a new deployment configuration.
  """

  @spec create_deployment_config(client :: ExAws.CodeDeploy.t, input :: create_deployment_config_input) :: ExAws.Request.JSON.response_t
  def create_deployment_config(client, input) do
    request(client, "CreateDeploymentConfig", format_input(input))
  end

  @doc """
  Same as `create_deployment_config/2` but raise on error.
  """
  @spec create_deployment_config!(client :: ExAws.CodeDeploy.t, input :: create_deployment_config_input) :: ExAws.Request.JSON.success_t | no_return
  def create_deployment_config!(client, input) do
    case create_deployment_config(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateDeploymentGroup

  Creates a new deployment group for application revisions to be deployed to.
  """

  @spec create_deployment_group(client :: ExAws.CodeDeploy.t, input :: create_deployment_group_input) :: ExAws.Request.JSON.response_t
  def create_deployment_group(client, input) do
    request(client, "CreateDeploymentGroup", format_input(input))
  end

  @doc """
  Same as `create_deployment_group/2` but raise on error.
  """
  @spec create_deployment_group!(client :: ExAws.CodeDeploy.t, input :: create_deployment_group_input) :: ExAws.Request.JSON.success_t | no_return
  def create_deployment_group!(client, input) do
    case create_deployment_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteApplication

  Deletes an application.
  """

  @spec delete_application(client :: ExAws.CodeDeploy.t, input :: delete_application_input) :: ExAws.Request.JSON.response_t
  def delete_application(client, input) do
    request(client, "DeleteApplication", format_input(input))
  end

  @doc """
  Same as `delete_application/2` but raise on error.
  """
  @spec delete_application!(client :: ExAws.CodeDeploy.t, input :: delete_application_input) :: ExAws.Request.JSON.success_t | no_return
  def delete_application!(client, input) do
    case delete_application(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteDeploymentConfig

  Deletes a deployment configuration.

  Note:A deployment configuration cannot be deleted if it is currently in
  use. Also, predefined configurations cannot be deleted.
  """

  @spec delete_deployment_config(client :: ExAws.CodeDeploy.t, input :: delete_deployment_config_input) :: ExAws.Request.JSON.response_t
  def delete_deployment_config(client, input) do
    request(client, "DeleteDeploymentConfig", format_input(input))
  end

  @doc """
  Same as `delete_deployment_config/2` but raise on error.
  """
  @spec delete_deployment_config!(client :: ExAws.CodeDeploy.t, input :: delete_deployment_config_input) :: ExAws.Request.JSON.success_t | no_return
  def delete_deployment_config!(client, input) do
    case delete_deployment_config(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteDeploymentGroup

  Deletes a deployment group.
  """

  @spec delete_deployment_group(client :: ExAws.CodeDeploy.t, input :: delete_deployment_group_input) :: ExAws.Request.JSON.response_t
  def delete_deployment_group(client, input) do
    request(client, "DeleteDeploymentGroup", format_input(input))
  end

  @doc """
  Same as `delete_deployment_group/2` but raise on error.
  """
  @spec delete_deployment_group!(client :: ExAws.CodeDeploy.t, input :: delete_deployment_group_input) :: ExAws.Request.JSON.success_t | no_return
  def delete_deployment_group!(client, input) do
    case delete_deployment_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeregisterOnPremisesInstance

  Deregisters an on-premises instance.
  """

  @spec deregister_on_premises_instance(client :: ExAws.CodeDeploy.t, input :: deregister_on_premises_instance_input) :: ExAws.Request.JSON.response_t
  def deregister_on_premises_instance(client, input) do
    request(client, "DeregisterOnPremisesInstance", format_input(input))
  end

  @doc """
  Same as `deregister_on_premises_instance/2` but raise on error.
  """
  @spec deregister_on_premises_instance!(client :: ExAws.CodeDeploy.t, input :: deregister_on_premises_instance_input) :: ExAws.Request.JSON.success_t | no_return
  def deregister_on_premises_instance!(client, input) do
    case deregister_on_premises_instance(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetApplication

  Gets information about an application.
  """

  @spec get_application(client :: ExAws.CodeDeploy.t, input :: get_application_input) :: ExAws.Request.JSON.response_t
  def get_application(client, input) do
    request(client, "GetApplication", format_input(input))
  end

  @doc """
  Same as `get_application/2` but raise on error.
  """
  @spec get_application!(client :: ExAws.CodeDeploy.t, input :: get_application_input) :: ExAws.Request.JSON.success_t | no_return
  def get_application!(client, input) do
    case get_application(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetApplicationRevision

  Gets information about an application revision.
  """

  @spec get_application_revision(client :: ExAws.CodeDeploy.t, input :: get_application_revision_input) :: ExAws.Request.JSON.response_t
  def get_application_revision(client, input) do
    request(client, "GetApplicationRevision", format_input(input))
  end

  @doc """
  Same as `get_application_revision/2` but raise on error.
  """
  @spec get_application_revision!(client :: ExAws.CodeDeploy.t, input :: get_application_revision_input) :: ExAws.Request.JSON.success_t | no_return
  def get_application_revision!(client, input) do
    case get_application_revision(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetDeployment

  Gets information about a deployment.
  """

  @spec get_deployment(client :: ExAws.CodeDeploy.t, input :: get_deployment_input) :: ExAws.Request.JSON.response_t
  def get_deployment(client, input) do
    request(client, "GetDeployment", format_input(input))
  end

  @doc """
  Same as `get_deployment/2` but raise on error.
  """
  @spec get_deployment!(client :: ExAws.CodeDeploy.t, input :: get_deployment_input) :: ExAws.Request.JSON.success_t | no_return
  def get_deployment!(client, input) do
    case get_deployment(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetDeploymentConfig

  Gets information about a deployment configuration.
  """

  @spec get_deployment_config(client :: ExAws.CodeDeploy.t, input :: get_deployment_config_input) :: ExAws.Request.JSON.response_t
  def get_deployment_config(client, input) do
    request(client, "GetDeploymentConfig", format_input(input))
  end

  @doc """
  Same as `get_deployment_config/2` but raise on error.
  """
  @spec get_deployment_config!(client :: ExAws.CodeDeploy.t, input :: get_deployment_config_input) :: ExAws.Request.JSON.success_t | no_return
  def get_deployment_config!(client, input) do
    case get_deployment_config(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetDeploymentGroup

  Gets information about a deployment group.
  """

  @spec get_deployment_group(client :: ExAws.CodeDeploy.t, input :: get_deployment_group_input) :: ExAws.Request.JSON.response_t
  def get_deployment_group(client, input) do
    request(client, "GetDeploymentGroup", format_input(input))
  end

  @doc """
  Same as `get_deployment_group/2` but raise on error.
  """
  @spec get_deployment_group!(client :: ExAws.CodeDeploy.t, input :: get_deployment_group_input) :: ExAws.Request.JSON.success_t | no_return
  def get_deployment_group!(client, input) do
    case get_deployment_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetDeploymentInstance

  Gets information about an instance as part of a deployment.
  """

  @spec get_deployment_instance(client :: ExAws.CodeDeploy.t, input :: get_deployment_instance_input) :: ExAws.Request.JSON.response_t
  def get_deployment_instance(client, input) do
    request(client, "GetDeploymentInstance", format_input(input))
  end

  @doc """
  Same as `get_deployment_instance/2` but raise on error.
  """
  @spec get_deployment_instance!(client :: ExAws.CodeDeploy.t, input :: get_deployment_instance_input) :: ExAws.Request.JSON.success_t | no_return
  def get_deployment_instance!(client, input) do
    case get_deployment_instance(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetOnPremisesInstance

  Gets information about an on-premises instance.
  """

  @spec get_on_premises_instance(client :: ExAws.CodeDeploy.t, input :: get_on_premises_instance_input) :: ExAws.Request.JSON.response_t
  def get_on_premises_instance(client, input) do
    request(client, "GetOnPremisesInstance", format_input(input))
  end

  @doc """
  Same as `get_on_premises_instance/2` but raise on error.
  """
  @spec get_on_premises_instance!(client :: ExAws.CodeDeploy.t, input :: get_on_premises_instance_input) :: ExAws.Request.JSON.success_t | no_return
  def get_on_premises_instance!(client, input) do
    case get_on_premises_instance(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListApplicationRevisions

  Lists information about revisions for an application.
  """

  @spec list_application_revisions(client :: ExAws.CodeDeploy.t, input :: list_application_revisions_input) :: ExAws.Request.JSON.response_t
  def list_application_revisions(client, input) do
    request(client, "ListApplicationRevisions", format_input(input))
  end

  @doc """
  Same as `list_application_revisions/2` but raise on error.
  """
  @spec list_application_revisions!(client :: ExAws.CodeDeploy.t, input :: list_application_revisions_input) :: ExAws.Request.JSON.success_t | no_return
  def list_application_revisions!(client, input) do
    case list_application_revisions(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListApplications

  Lists the applications registered with the applicable IAM user or AWS
  account.
  """

  @spec list_applications(client :: ExAws.CodeDeploy.t, input :: list_applications_input) :: ExAws.Request.JSON.response_t
  def list_applications(client, input) do
    request(client, "ListApplications", format_input(input))
  end

  @doc """
  Same as `list_applications/2` but raise on error.
  """
  @spec list_applications!(client :: ExAws.CodeDeploy.t, input :: list_applications_input) :: ExAws.Request.JSON.success_t | no_return
  def list_applications!(client, input) do
    case list_applications(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListDeploymentConfigs

  Lists the deployment configurations with the applicable IAM user or AWS
  account.
  """

  @spec list_deployment_configs(client :: ExAws.CodeDeploy.t, input :: list_deployment_configs_input) :: ExAws.Request.JSON.response_t
  def list_deployment_configs(client, input) do
    request(client, "ListDeploymentConfigs", format_input(input))
  end

  @doc """
  Same as `list_deployment_configs/2` but raise on error.
  """
  @spec list_deployment_configs!(client :: ExAws.CodeDeploy.t, input :: list_deployment_configs_input) :: ExAws.Request.JSON.success_t | no_return
  def list_deployment_configs!(client, input) do
    case list_deployment_configs(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListDeploymentGroups

  Lists the deployment groups for an application registered with the
  applicable IAM user or AWS account.
  """

  @spec list_deployment_groups(client :: ExAws.CodeDeploy.t, input :: list_deployment_groups_input) :: ExAws.Request.JSON.response_t
  def list_deployment_groups(client, input) do
    request(client, "ListDeploymentGroups", format_input(input))
  end

  @doc """
  Same as `list_deployment_groups/2` but raise on error.
  """
  @spec list_deployment_groups!(client :: ExAws.CodeDeploy.t, input :: list_deployment_groups_input) :: ExAws.Request.JSON.success_t | no_return
  def list_deployment_groups!(client, input) do
    case list_deployment_groups(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListDeploymentInstances

  Lists the instances for a deployment associated with the applicable IAM
  user or AWS account.
  """

  @spec list_deployment_instances(client :: ExAws.CodeDeploy.t, input :: list_deployment_instances_input) :: ExAws.Request.JSON.response_t
  def list_deployment_instances(client, input) do
    request(client, "ListDeploymentInstances", format_input(input))
  end

  @doc """
  Same as `list_deployment_instances/2` but raise on error.
  """
  @spec list_deployment_instances!(client :: ExAws.CodeDeploy.t, input :: list_deployment_instances_input) :: ExAws.Request.JSON.success_t | no_return
  def list_deployment_instances!(client, input) do
    case list_deployment_instances(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListDeployments

  Lists the deployments within a deployment group for an application
  registered with the applicable IAM user or AWS account.
  """

  @spec list_deployments(client :: ExAws.CodeDeploy.t, input :: list_deployments_input) :: ExAws.Request.JSON.response_t
  def list_deployments(client, input) do
    request(client, "ListDeployments", format_input(input))
  end

  @doc """
  Same as `list_deployments/2` but raise on error.
  """
  @spec list_deployments!(client :: ExAws.CodeDeploy.t, input :: list_deployments_input) :: ExAws.Request.JSON.success_t | no_return
  def list_deployments!(client, input) do
    case list_deployments(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListOnPremisesInstances

  Gets a list of one or more on-premises instance names.

  Unless otherwise specified, both registered and deregistered on-premises
  instance names will be listed. To list only registered or deregistered
  on-premises instance names, use the registration status parameter.
  """

  @spec list_on_premises_instances(client :: ExAws.CodeDeploy.t, input :: list_on_premises_instances_input) :: ExAws.Request.JSON.response_t
  def list_on_premises_instances(client, input) do
    request(client, "ListOnPremisesInstances", format_input(input))
  end

  @doc """
  Same as `list_on_premises_instances/2` but raise on error.
  """
  @spec list_on_premises_instances!(client :: ExAws.CodeDeploy.t, input :: list_on_premises_instances_input) :: ExAws.Request.JSON.success_t | no_return
  def list_on_premises_instances!(client, input) do
    case list_on_premises_instances(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RegisterApplicationRevision

  Registers with AWS CodeDeploy a revision for the specified application.
  """

  @spec register_application_revision(client :: ExAws.CodeDeploy.t, input :: register_application_revision_input) :: ExAws.Request.JSON.response_t
  def register_application_revision(client, input) do
    request(client, "RegisterApplicationRevision", format_input(input))
  end

  @doc """
  Same as `register_application_revision/2` but raise on error.
  """
  @spec register_application_revision!(client :: ExAws.CodeDeploy.t, input :: register_application_revision_input) :: ExAws.Request.JSON.success_t | no_return
  def register_application_revision!(client, input) do
    case register_application_revision(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RegisterOnPremisesInstance

  Registers an on-premises instance.
  """

  @spec register_on_premises_instance(client :: ExAws.CodeDeploy.t, input :: register_on_premises_instance_input) :: ExAws.Request.JSON.response_t
  def register_on_premises_instance(client, input) do
    request(client, "RegisterOnPremisesInstance", format_input(input))
  end

  @doc """
  Same as `register_on_premises_instance/2` but raise on error.
  """
  @spec register_on_premises_instance!(client :: ExAws.CodeDeploy.t, input :: register_on_premises_instance_input) :: ExAws.Request.JSON.success_t | no_return
  def register_on_premises_instance!(client, input) do
    case register_on_premises_instance(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RemoveTagsFromOnPremisesInstances

  Removes one or more tags from one or more on-premises instances.
  """

  @spec remove_tags_from_on_premises_instances(client :: ExAws.CodeDeploy.t, input :: remove_tags_from_on_premises_instances_input) :: ExAws.Request.JSON.response_t
  def remove_tags_from_on_premises_instances(client, input) do
    request(client, "RemoveTagsFromOnPremisesInstances", format_input(input))
  end

  @doc """
  Same as `remove_tags_from_on_premises_instances/2` but raise on error.
  """
  @spec remove_tags_from_on_premises_instances!(client :: ExAws.CodeDeploy.t, input :: remove_tags_from_on_premises_instances_input) :: ExAws.Request.JSON.success_t | no_return
  def remove_tags_from_on_premises_instances!(client, input) do
    case remove_tags_from_on_premises_instances(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  StopDeployment

  Attempts to stop an ongoing deployment.
  """

  @spec stop_deployment(client :: ExAws.CodeDeploy.t, input :: stop_deployment_input) :: ExAws.Request.JSON.response_t
  def stop_deployment(client, input) do
    request(client, "StopDeployment", format_input(input))
  end

  @doc """
  Same as `stop_deployment/2` but raise on error.
  """
  @spec stop_deployment!(client :: ExAws.CodeDeploy.t, input :: stop_deployment_input) :: ExAws.Request.JSON.success_t | no_return
  def stop_deployment!(client, input) do
    case stop_deployment(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateApplication

  Changes an existing application's name.
  """

  @spec update_application(client :: ExAws.CodeDeploy.t, input :: update_application_input) :: ExAws.Request.JSON.response_t
  def update_application(client, input) do
    request(client, "UpdateApplication", format_input(input))
  end

  @doc """
  Same as `update_application/2` but raise on error.
  """
  @spec update_application!(client :: ExAws.CodeDeploy.t, input :: update_application_input) :: ExAws.Request.JSON.success_t | no_return
  def update_application!(client, input) do
    case update_application(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateDeploymentGroup

  Changes information about an existing deployment group.
  """

  @spec update_deployment_group(client :: ExAws.CodeDeploy.t, input :: update_deployment_group_input) :: ExAws.Request.JSON.response_t
  def update_deployment_group(client, input) do
    request(client, "UpdateDeploymentGroup", format_input(input))
  end

  @doc """
  Same as `update_deployment_group/2` but raise on error.
  """
  @spec update_deployment_group!(client :: ExAws.CodeDeploy.t, input :: update_deployment_group_input) :: ExAws.Request.JSON.success_t | no_return
  def update_deployment_group!(client, input) do
    case update_deployment_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  defp request(%{__struct__: client_module} = client, action, input) do
    apply(client_module, :request, [client, action, input])
  end
end
