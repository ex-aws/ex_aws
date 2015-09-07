defmodule ExAws.ElasticMapReduce.Core do
  import ExAws.Core.JSON, only: [format_input: 1]
  @actions [
    "AddInstanceGroups",
    "AddJobFlowSteps",
    "AddTags",
    "DescribeCluster",
    "DescribeJobFlows",
    "DescribeStep",
    "ListBootstrapActions",
    "ListClusters",
    "ListInstanceGroups",
    "ListInstances",
    "ListSteps",
    "ModifyInstanceGroups",
    "RemoveTags",
    "RunJobFlow",
    "SetTerminationProtection",
    "SetVisibleToAllUsers",
    "TerminateJobFlows"]

  @moduledoc """
  ## Amazon Elastic MapReduce

  Amazon Elastic MapReduce (Amazon EMR) is a web service that makes it easy
  to process large amounts of data efficiently. Amazon EMR uses Hadoop
  processing combined with several AWS products to do tasks such as web
  indexing, data mining, log file analysis, machine learning, scientific
  simulation, and data warehousing.
  """

  @type action_on_failure :: binary

  @type add_instance_groups_input :: [
    instance_groups: instance_group_config_list,
    job_flow_id: xml_string_max_len256,
  ]

  @type add_instance_groups_output :: [
    instance_group_ids: instance_group_ids_list,
    job_flow_id: xml_string_max_len256,
  ]

  @type add_job_flow_steps_input :: [
    job_flow_id: xml_string_max_len256,
    steps: step_config_list,
  ]

  @type add_job_flow_steps_output :: [
    step_ids: step_ids_list,
  ]

  @type add_tags_input :: [
    resource_id: resource_id,
    tags: tag_list,
  ]

  @type add_tags_output :: [
  ]

  @type application :: [
    additional_info: string_map,
    args: string_list,
    name: binary,
    version: binary,
  ]

  @type application_list :: [application]

  @type bootstrap_action_config :: [
    name: xml_string_max_len256,
    script_bootstrap_action: script_bootstrap_action_config,
  ]

  @type bootstrap_action_config_list :: [bootstrap_action_config]

  @type bootstrap_action_detail :: [
    bootstrap_action_config: bootstrap_action_config,
  ]

  @type bootstrap_action_detail_list :: [bootstrap_action_detail]

  @type cluster :: [
    applications: application_list,
    auto_terminate: boolean,
    configurations: configuration_list,
    ec2_instance_attributes: ec2_instance_attributes,
    id: cluster_id,
    log_uri: binary,
    master_public_dns_name: binary,
    name: binary,
    normalized_instance_hours: integer,
    release_label: binary,
    requested_ami_version: binary,
    running_ami_version: binary,
    service_role: binary,
    status: cluster_status,
    tags: tag_list,
    termination_protected: boolean,
    visible_to_all_users: boolean,
  ]

  @type cluster_id :: binary

  @type cluster_state :: binary

  @type cluster_state_change_reason :: [
    code: cluster_state_change_reason_code,
    message: binary,
  ]

  @type cluster_state_change_reason_code :: binary

  @type cluster_state_list :: [cluster_state]

  @type cluster_status :: [
    state: cluster_state,
    state_change_reason: cluster_state_change_reason,
    timeline: cluster_timeline,
  ]

  @type cluster_summary :: [
    id: cluster_id,
    name: binary,
    normalized_instance_hours: integer,
    status: cluster_status,
  ]

  @type cluster_summary_list :: [cluster_summary]

  @type cluster_timeline :: [
    creation_date_time: date,
    end_date_time: date,
    ready_date_time: date,
  ]

  @type command :: [
    args: string_list,
    name: binary,
    script_path: binary,
  ]

  @type command_list :: [command]

  @type configuration :: [
    classification: binary,
    configurations: configuration_list,
    properties: string_map,
  ]

  @type configuration_list :: [configuration]

  @type date :: integer

  @type describe_cluster_input :: [
    cluster_id: cluster_id,
  ]

  @type describe_cluster_output :: [
    cluster: cluster,
  ]

  @type describe_job_flows_input :: [
    created_after: date,
    created_before: date,
    job_flow_ids: xml_string_list,
    job_flow_states: job_flow_execution_state_list,
  ]

  @type describe_job_flows_output :: [
    job_flows: job_flow_detail_list,
  ]

  @type describe_step_input :: [
    cluster_id: cluster_id,
    step_id: step_id,
  ]

  @type describe_step_output :: [
    step: step,
  ]

  @type ec2_instance_ids_to_terminate_list :: [instance_id]

  @type ec2_instance_attributes :: [
    additional_master_security_groups: string_list,
    additional_slave_security_groups: string_list,
    ec2_availability_zone: binary,
    ec2_key_name: binary,
    ec2_subnet_id: binary,
    emr_managed_master_security_group: binary,
    emr_managed_slave_security_group: binary,
    iam_instance_profile: binary,
  ]

  @type error_code :: binary

  @type error_message :: binary

  @type hadoop_jar_step_config :: [
    args: xml_string_list,
    jar: xml_string,
    main_class: xml_string,
    properties: key_value_list,
  ]

  @type hadoop_step_config :: [
    args: string_list,
    jar: binary,
    main_class: binary,
    properties: string_map,
  ]

  @type instance :: [
    ec2_instance_id: instance_id,
    id: instance_id,
    private_dns_name: binary,
    private_ip_address: binary,
    public_dns_name: binary,
    public_ip_address: binary,
    status: instance_status,
  ]

  @type instance_group :: [
    bid_price: binary,
    configurations: configuration_list,
    id: instance_group_id,
    instance_group_type: instance_group_type,
    instance_type: instance_type,
    market: market_type,
    name: binary,
    requested_instance_count: integer,
    running_instance_count: integer,
    status: instance_group_status,
  ]

  @type instance_group_config :: [
    bid_price: xml_string_max_len256,
    configurations: configuration_list,
    instance_count: integer,
    instance_role: instance_role_type,
    instance_type: instance_type,
    market: market_type,
    name: xml_string_max_len256,
  ]

  @type instance_group_config_list :: [instance_group_config]

  @type instance_group_detail :: [
    bid_price: xml_string_max_len256,
    creation_date_time: date,
    end_date_time: date,
    instance_group_id: xml_string_max_len256,
    instance_request_count: integer,
    instance_role: instance_role_type,
    instance_running_count: integer,
    instance_type: instance_type,
    last_state_change_reason: xml_string,
    market: market_type,
    name: xml_string_max_len256,
    ready_date_time: date,
    start_date_time: date,
    state: instance_group_state,
  ]

  @type instance_group_detail_list :: [instance_group_detail]

  @type instance_group_id :: binary

  @type instance_group_ids_list :: [xml_string_max_len256]

  @type instance_group_list :: [instance_group]

  @type instance_group_modify_config :: [
    e_c2_instance_ids_to_terminate: ec2_instance_ids_to_terminate_list,
    instance_count: integer,
    instance_group_id: xml_string_max_len256,
  ]

  @type instance_group_modify_config_list :: [instance_group_modify_config]

  @type instance_group_state :: binary

  @type instance_group_state_change_reason :: [
    code: instance_group_state_change_reason_code,
    message: binary,
  ]

  @type instance_group_state_change_reason_code :: binary

  @type instance_group_status :: [
    state: instance_group_state,
    state_change_reason: instance_group_state_change_reason,
    timeline: instance_group_timeline,
  ]

  @type instance_group_timeline :: [
    creation_date_time: date,
    end_date_time: date,
    ready_date_time: date,
  ]

  @type instance_group_type :: binary

  @type instance_group_type_list :: [instance_group_type]

  @type instance_id :: binary

  @type instance_list :: [instance]

  @type instance_role_type :: binary

  @type instance_state :: binary

  @type instance_state_change_reason :: [
    code: instance_state_change_reason_code,
    message: binary,
  ]

  @type instance_state_change_reason_code :: binary

  @type instance_status :: [
    state: instance_state,
    state_change_reason: instance_state_change_reason,
    timeline: instance_timeline,
  ]

  @type instance_timeline :: [
    creation_date_time: date,
    end_date_time: date,
    ready_date_time: date,
  ]

  @type instance_type :: binary

  @type internal_server_error :: [
  ]

  @type internal_server_exception :: [
    message: error_message,
  ]

  @type invalid_request_exception :: [
    error_code: error_code,
    message: error_message,
  ]

  @type job_flow_detail :: [
    ami_version: xml_string_max_len256,
    bootstrap_actions: bootstrap_action_detail_list,
    execution_status_detail: job_flow_execution_status_detail,
    instances: job_flow_instances_detail,
    job_flow_id: xml_string_max_len256,
    job_flow_role: xml_string,
    log_uri: xml_string,
    name: xml_string_max_len256,
    service_role: xml_string,
    steps: step_detail_list,
    supported_products: supported_products_list,
    visible_to_all_users: boolean,
  ]

  @type job_flow_detail_list :: [job_flow_detail]

  @type job_flow_execution_state :: binary

  @type job_flow_execution_state_list :: [job_flow_execution_state]

  @type job_flow_execution_status_detail :: [
    creation_date_time: date,
    end_date_time: date,
    last_state_change_reason: xml_string,
    ready_date_time: date,
    start_date_time: date,
    state: job_flow_execution_state,
  ]

  @type job_flow_instances_config :: [
    additional_master_security_groups: security_groups_list,
    additional_slave_security_groups: security_groups_list,
    ec2_key_name: xml_string_max_len256,
    ec2_subnet_id: xml_string_max_len256,
    emr_managed_master_security_group: xml_string_max_len256,
    emr_managed_slave_security_group: xml_string_max_len256,
    hadoop_version: xml_string_max_len256,
    instance_count: integer,
    instance_groups: instance_group_config_list,
    keep_job_flow_alive_when_no_steps: boolean,
    master_instance_type: instance_type,
    placement: placement_type,
    slave_instance_type: instance_type,
    termination_protected: boolean,
  ]

  @type job_flow_instances_detail :: [
    ec2_key_name: xml_string_max_len256,
    ec2_subnet_id: xml_string_max_len256,
    hadoop_version: xml_string_max_len256,
    instance_count: integer,
    instance_groups: instance_group_detail_list,
    keep_job_flow_alive_when_no_steps: boolean,
    master_instance_id: xml_string,
    master_instance_type: instance_type,
    master_public_dns_name: xml_string,
    normalized_instance_hours: integer,
    placement: placement_type,
    slave_instance_type: instance_type,
    termination_protected: boolean,
  ]

  @type key_value :: [
    key: xml_string,
    value: xml_string,
  ]

  @type key_value_list :: [key_value]

  @type list_bootstrap_actions_input :: [
    cluster_id: cluster_id,
    marker: marker,
  ]

  @type list_bootstrap_actions_output :: [
    bootstrap_actions: command_list,
    marker: marker,
  ]

  @type list_clusters_input :: [
    cluster_states: cluster_state_list,
    created_after: date,
    created_before: date,
    marker: marker,
  ]

  @type list_clusters_output :: [
    clusters: cluster_summary_list,
    marker: marker,
  ]

  @type list_instance_groups_input :: [
    cluster_id: cluster_id,
    marker: marker,
  ]

  @type list_instance_groups_output :: [
    instance_groups: instance_group_list,
    marker: marker,
  ]

  @type list_instances_input :: [
    cluster_id: cluster_id,
    instance_group_id: instance_group_id,
    instance_group_types: instance_group_type_list,
    marker: marker,
  ]

  @type list_instances_output :: [
    instances: instance_list,
    marker: marker,
  ]

  @type list_steps_input :: [
    cluster_id: cluster_id,
    marker: marker,
    step_ids: xml_string_list,
    step_states: step_state_list,
  ]

  @type list_steps_output :: [
    marker: marker,
    steps: step_summary_list,
  ]

  @type marker :: binary

  @type market_type :: binary

  @type modify_instance_groups_input :: [
    instance_groups: instance_group_modify_config_list,
  ]

  @type new_supported_products_list :: [supported_product_config]

  @type placement_type :: [
    availability_zone: xml_string,
  ]

  @type remove_tags_input :: [
    resource_id: resource_id,
    tag_keys: string_list,
  ]

  @type remove_tags_output :: [
  ]

  @type resource_id :: binary

  @type run_job_flow_input :: [
    additional_info: xml_string,
    ami_version: xml_string_max_len256,
    applications: application_list,
    bootstrap_actions: bootstrap_action_config_list,
    configurations: configuration_list,
    instances: job_flow_instances_config,
    job_flow_role: xml_string,
    log_uri: xml_string,
    name: xml_string_max_len256,
    new_supported_products: new_supported_products_list,
    release_label: xml_string_max_len256,
    service_role: xml_string,
    steps: step_config_list,
    supported_products: supported_products_list,
    tags: tag_list,
    visible_to_all_users: boolean,
  ]

  @type run_job_flow_output :: [
    job_flow_id: xml_string_max_len256,
  ]

  @type script_bootstrap_action_config :: [
    args: xml_string_list,
    path: xml_string,
  ]

  @type security_groups_list :: [xml_string_max_len256]

  @type set_termination_protection_input :: [
    job_flow_ids: xml_string_list,
    termination_protected: boolean,
  ]

  @type set_visible_to_all_users_input :: [
    job_flow_ids: xml_string_list,
    visible_to_all_users: boolean,
  ]

  @type step :: [
    action_on_failure: action_on_failure,
    config: hadoop_step_config,
    id: step_id,
    name: binary,
    status: step_status,
  ]

  @type step_config :: [
    action_on_failure: action_on_failure,
    hadoop_jar_step: hadoop_jar_step_config,
    name: xml_string_max_len256,
  ]

  @type step_config_list :: [step_config]

  @type step_detail :: [
    execution_status_detail: step_execution_status_detail,
    step_config: step_config,
  ]

  @type step_detail_list :: [step_detail]

  @type step_execution_state :: binary

  @type step_execution_status_detail :: [
    creation_date_time: date,
    end_date_time: date,
    last_state_change_reason: xml_string,
    start_date_time: date,
    state: step_execution_state,
  ]

  @type step_id :: binary

  @type step_ids_list :: [xml_string_max_len256]

  @type step_state :: binary

  @type step_state_change_reason :: [
    code: step_state_change_reason_code,
    message: binary,
  ]

  @type step_state_change_reason_code :: binary

  @type step_state_list :: [step_state]

  @type step_status :: [
    state: step_state,
    state_change_reason: step_state_change_reason,
    timeline: step_timeline,
  ]

  @type step_summary :: [
    action_on_failure: action_on_failure,
    config: hadoop_step_config,
    id: step_id,
    name: binary,
    status: step_status,
  ]

  @type step_summary_list :: [step_summary]

  @type step_timeline :: [
    creation_date_time: date,
    end_date_time: date,
    start_date_time: date,
  ]

  @type string_list :: [binary]

  @type string_map :: [{binary, binary}]

  @type supported_product_config :: [
    args: xml_string_list,
    name: xml_string_max_len256,
  ]

  @type supported_products_list :: [xml_string_max_len256]

  @type tag :: [
    key: binary,
    value: binary,
  ]

  @type tag_list :: [tag]

  @type terminate_job_flows_input :: [
    job_flow_ids: xml_string_list,
  ]

  @type xml_string :: binary

  @type xml_string_list :: [xml_string]

  @type xml_string_max_len256 :: binary





  @doc """
  AddInstanceGroups

  AddInstanceGroups adds an instance group to a running cluster.
  """

  @spec add_instance_groups(client :: ExAws.ElasticMapReduce.t, input :: add_instance_groups_input) :: ExAws.Request.JSON.response_t
  def add_instance_groups(client, input) do
    request(client, "AddInstanceGroups", format_input(input))
  end

  @doc """
  Same as `add_instance_groups/2` but raise on error.
  """
  @spec add_instance_groups!(client :: ExAws.ElasticMapReduce.t, input :: add_instance_groups_input) :: ExAws.Request.JSON.success_t | no_return
  def add_instance_groups!(client, input) do
    case add_instance_groups(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  AddJobFlowSteps

  AddJobFlowSteps adds new steps to a running job flow. A maximum of 256
  steps are allowed in each job flow.

  If your job flow is long-running (such as a Hive data warehouse) or
  complex, you may require more than 256 steps to process your data. You can
  bypass the 256-step limitation in various ways, including using the SSH
  shell to connect to the master node and submitting queries directly to the
  software running on the master node, such as Hive and Hadoop. For more
  information on how to do this, go to [Add More than 256 Steps to a Job
  Flow](http://docs.aws.amazon.com/ElasticMapReduce/latest/DeveloperGuide/AddMoreThan256Steps.html)
  in the *Amazon Elastic MapReduce Developer's Guide*.

  A step specifies the location of a JAR file stored either on the master
  node of the job flow or in Amazon S3. Each step is performed by the main
  function of the main class of the JAR file. The main class can be specified
  either in the manifest of the JAR or by using the MainFunction parameter of
  the step.

  Elastic MapReduce executes each step in the order listed. For a step to be
  considered complete, the main function must exit with a zero exit code and
  all Hadoop jobs started while the step was running must have completed and
  run successfully.

  You can only add steps to a job flow that is in one of the following
  states: STARTING, BOOTSTRAPPING, RUNNING, or WAITING.
  """

  @spec add_job_flow_steps(client :: ExAws.ElasticMapReduce.t, input :: add_job_flow_steps_input) :: ExAws.Request.JSON.response_t
  def add_job_flow_steps(client, input) do
    request(client, "AddJobFlowSteps", format_input(input))
  end

  @doc """
  Same as `add_job_flow_steps/2` but raise on error.
  """
  @spec add_job_flow_steps!(client :: ExAws.ElasticMapReduce.t, input :: add_job_flow_steps_input) :: ExAws.Request.JSON.success_t | no_return
  def add_job_flow_steps!(client, input) do
    case add_job_flow_steps(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  AddTags

  Adds tags to an Amazon EMR resource. Tags make it easier to associate
  clusters in various ways, such as grouping clusters to track your Amazon
  EMR resource allocation costs. For more information, see [Tagging Amazon
  EMR
  Resources](http://docs.aws.amazon.com/ElasticMapReduce/latest/DeveloperGuide/emr-plan-tags.html).
  """

  @spec add_tags(client :: ExAws.ElasticMapReduce.t, input :: add_tags_input) :: ExAws.Request.JSON.response_t
  def add_tags(client, input) do
    request(client, "AddTags", format_input(input))
  end

  @doc """
  Same as `add_tags/2` but raise on error.
  """
  @spec add_tags!(client :: ExAws.ElasticMapReduce.t, input :: add_tags_input) :: ExAws.Request.JSON.success_t | no_return
  def add_tags!(client, input) do
    case add_tags(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeCluster

  Provides cluster-level details including status, hardware and software
  configuration, VPC settings, and so on. For information about the cluster
  steps, see `ListSteps`.
  """

  @spec describe_cluster(client :: ExAws.ElasticMapReduce.t, input :: describe_cluster_input) :: ExAws.Request.JSON.response_t
  def describe_cluster(client, input) do
    request(client, "DescribeCluster", format_input(input))
  end

  @doc """
  Same as `describe_cluster/2` but raise on error.
  """
  @spec describe_cluster!(client :: ExAws.ElasticMapReduce.t, input :: describe_cluster_input) :: ExAws.Request.JSON.success_t | no_return
  def describe_cluster!(client, input) do
    case describe_cluster(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeJobFlows

  This API is deprecated and will eventually be removed. We recommend you use
  `ListClusters`, `DescribeCluster`, `ListSteps`, `ListInstanceGroups` and
  `ListBootstrapActions` instead.

  DescribeJobFlows returns a list of job flows that match all of the supplied
  parameters. The parameters can include a list of job flow IDs, job flow
  states, and restrictions on job flow creation date and time.

  Regardless of supplied parameters, only job flows created within the last
  two months are returned.

  If no parameters are supplied, then job flows matching either of the
  following criteria are returned:

  - Job flows created and completed in the last two weeks

  - Job flows created within the last two months that are in one of the
  following states: `RUNNING`, `WAITING`, `SHUTTING_DOWN`, `STARTING`

  Amazon Elastic MapReduce can return a maximum of 512 job flow descriptions.
  """

  @spec describe_job_flows(client :: ExAws.ElasticMapReduce.t, input :: describe_job_flows_input) :: ExAws.Request.JSON.response_t
  def describe_job_flows(client, input) do
    request(client, "DescribeJobFlows", format_input(input))
  end

  @doc """
  Same as `describe_job_flows/2` but raise on error.
  """
  @spec describe_job_flows!(client :: ExAws.ElasticMapReduce.t, input :: describe_job_flows_input) :: ExAws.Request.JSON.success_t | no_return
  def describe_job_flows!(client, input) do
    case describe_job_flows(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeStep

  Provides more detail about the cluster step.
  """

  @spec describe_step(client :: ExAws.ElasticMapReduce.t, input :: describe_step_input) :: ExAws.Request.JSON.response_t
  def describe_step(client, input) do
    request(client, "DescribeStep", format_input(input))
  end

  @doc """
  Same as `describe_step/2` but raise on error.
  """
  @spec describe_step!(client :: ExAws.ElasticMapReduce.t, input :: describe_step_input) :: ExAws.Request.JSON.success_t | no_return
  def describe_step!(client, input) do
    case describe_step(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListBootstrapActions

  Provides information about the bootstrap actions associated with a cluster.
  """

  @spec list_bootstrap_actions(client :: ExAws.ElasticMapReduce.t, input :: list_bootstrap_actions_input) :: ExAws.Request.JSON.response_t
  def list_bootstrap_actions(client, input) do
    request(client, "ListBootstrapActions", format_input(input))
  end

  @doc """
  Same as `list_bootstrap_actions/2` but raise on error.
  """
  @spec list_bootstrap_actions!(client :: ExAws.ElasticMapReduce.t, input :: list_bootstrap_actions_input) :: ExAws.Request.JSON.success_t | no_return
  def list_bootstrap_actions!(client, input) do
    case list_bootstrap_actions(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListClusters

  Provides the status of all clusters visible to this AWS account. Allows you
  to filter the list of clusters based on certain criteria; for example,
  filtering by cluster creation date and time or by status. This call returns
  a maximum of 50 clusters per call, but returns a marker to track the paging
  of the cluster list across multiple ListClusters calls.
  """

  @spec list_clusters(client :: ExAws.ElasticMapReduce.t, input :: list_clusters_input) :: ExAws.Request.JSON.response_t
  def list_clusters(client, input) do
    request(client, "ListClusters", format_input(input))
  end

  @doc """
  Same as `list_clusters/2` but raise on error.
  """
  @spec list_clusters!(client :: ExAws.ElasticMapReduce.t, input :: list_clusters_input) :: ExAws.Request.JSON.success_t | no_return
  def list_clusters!(client, input) do
    case list_clusters(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListInstanceGroups

  Provides all available details about the instance groups in a cluster.
  """

  @spec list_instance_groups(client :: ExAws.ElasticMapReduce.t, input :: list_instance_groups_input) :: ExAws.Request.JSON.response_t
  def list_instance_groups(client, input) do
    request(client, "ListInstanceGroups", format_input(input))
  end

  @doc """
  Same as `list_instance_groups/2` but raise on error.
  """
  @spec list_instance_groups!(client :: ExAws.ElasticMapReduce.t, input :: list_instance_groups_input) :: ExAws.Request.JSON.success_t | no_return
  def list_instance_groups!(client, input) do
    case list_instance_groups(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListInstances

  Provides information about the cluster instances that Amazon EMR provisions
  on behalf of a user when it creates the cluster. For example, this
  operation indicates when the EC2 instances reach the Ready state, when
  instances become available to Amazon EMR to use for jobs, and the IP
  addresses for cluster instances, etc.
  """

  @spec list_instances(client :: ExAws.ElasticMapReduce.t, input :: list_instances_input) :: ExAws.Request.JSON.response_t
  def list_instances(client, input) do
    request(client, "ListInstances", format_input(input))
  end

  @doc """
  Same as `list_instances/2` but raise on error.
  """
  @spec list_instances!(client :: ExAws.ElasticMapReduce.t, input :: list_instances_input) :: ExAws.Request.JSON.success_t | no_return
  def list_instances!(client, input) do
    case list_instances(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListSteps

  Provides a list of steps for the cluster.
  """

  @spec list_steps(client :: ExAws.ElasticMapReduce.t, input :: list_steps_input) :: ExAws.Request.JSON.response_t
  def list_steps(client, input) do
    request(client, "ListSteps", format_input(input))
  end

  @doc """
  Same as `list_steps/2` but raise on error.
  """
  @spec list_steps!(client :: ExAws.ElasticMapReduce.t, input :: list_steps_input) :: ExAws.Request.JSON.success_t | no_return
  def list_steps!(client, input) do
    case list_steps(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ModifyInstanceGroups

  ModifyInstanceGroups modifies the number of nodes and configuration
  settings of an instance group. The input parameters include the new target
  instance count for the group and the instance group ID. The call will
  either succeed or fail atomically.
  """

  @spec modify_instance_groups(client :: ExAws.ElasticMapReduce.t, input :: modify_instance_groups_input) :: ExAws.Request.JSON.response_t
  def modify_instance_groups(client, input) do
    request(client, "ModifyInstanceGroups", format_input(input))
  end

  @doc """
  Same as `modify_instance_groups/2` but raise on error.
  """
  @spec modify_instance_groups!(client :: ExAws.ElasticMapReduce.t, input :: modify_instance_groups_input) :: ExAws.Request.JSON.success_t | no_return
  def modify_instance_groups!(client, input) do
    case modify_instance_groups(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RemoveTags

  Removes tags from an Amazon EMR resource. Tags make it easier to associate
  clusters in various ways, such as grouping clusters to track your Amazon
  EMR resource allocation costs. For more information, see [Tagging Amazon
  EMR
  Resources](http://docs.aws.amazon.com/ElasticMapReduce/latest/DeveloperGuide/emr-plan-tags.html).

  The following example removes the stack tag with value Prod from a cluster:
  """

  @spec remove_tags(client :: ExAws.ElasticMapReduce.t, input :: remove_tags_input) :: ExAws.Request.JSON.response_t
  def remove_tags(client, input) do
    request(client, "RemoveTags", format_input(input))
  end

  @doc """
  Same as `remove_tags/2` but raise on error.
  """
  @spec remove_tags!(client :: ExAws.ElasticMapReduce.t, input :: remove_tags_input) :: ExAws.Request.JSON.success_t | no_return
  def remove_tags!(client, input) do
    case remove_tags(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RunJobFlow

  RunJobFlow creates and starts running a new job flow. The job flow will run
  the steps specified. Once the job flow completes, the cluster is stopped
  and the HDFS partition is lost. To prevent loss of data, configure the last
  step of the job flow to store results in Amazon S3. If the
  `JobFlowInstancesConfig` `KeepJobFlowAliveWhenNoSteps` parameter is set to
  `TRUE`, the job flow will transition to the WAITING state rather than
  shutting down once the steps have completed.

  For additional protection, you can set the `JobFlowInstancesConfig`
  `TerminationProtected` parameter to `TRUE` to lock the job flow and prevent
  it from being terminated by API call, user intervention, or in the event of
  a job flow error.

  A maximum of 256 steps are allowed in each job flow.

  If your job flow is long-running (such as a Hive data warehouse) or
  complex, you may require more than 256 steps to process your data. You can
  bypass the 256-step limitation in various ways, including using the SSH
  shell to connect to the master node and submitting queries directly to the
  software running on the master node, such as Hive and Hadoop. For more
  information on how to do this, go to [Add More than 256 Steps to a Job
  Flow](http://docs.aws.amazon.com/ElasticMapReduce/latest/DeveloperGuide/AddMoreThan256Steps.html)
  in the *Amazon Elastic MapReduce Developer's Guide*.

  For long running job flows, we recommend that you periodically store your
  results.
  """

  @spec run_job_flow(client :: ExAws.ElasticMapReduce.t, input :: run_job_flow_input) :: ExAws.Request.JSON.response_t
  def run_job_flow(client, input) do
    request(client, "RunJobFlow", format_input(input))
  end

  @doc """
  Same as `run_job_flow/2` but raise on error.
  """
  @spec run_job_flow!(client :: ExAws.ElasticMapReduce.t, input :: run_job_flow_input) :: ExAws.Request.JSON.success_t | no_return
  def run_job_flow!(client, input) do
    case run_job_flow(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  SetTerminationProtection

  SetTerminationProtection locks a job flow so the Amazon EC2 instances in
  the cluster cannot be terminated by user intervention, an API call, or in
  the event of a job-flow error. The cluster still terminates upon successful
  completion of the job flow. Calling SetTerminationProtection on a job flow
  is analogous to calling the Amazon EC2 DisableAPITermination API on all of
  the EC2 instances in a cluster.

  SetTerminationProtection is used to prevent accidental termination of a job
  flow and to ensure that in the event of an error, the instances will
  persist so you can recover any data stored in their ephemeral instance
  storage.

  To terminate a job flow that has been locked by setting
  SetTerminationProtection to `true`, you must first unlock the job flow by a
  subsequent call to SetTerminationProtection in which you set the value to
  `false`.

  For more information, go to [Protecting a Job Flow from
  Termination](http://docs.aws.amazon.com/ElasticMapReduce/latest/DeveloperGuide/UsingEMR_TerminationProtection.html)
  in the *Amazon Elastic MapReduce Developer's Guide.*
  """

  @spec set_termination_protection(client :: ExAws.ElasticMapReduce.t, input :: set_termination_protection_input) :: ExAws.Request.JSON.response_t
  def set_termination_protection(client, input) do
    request(client, "SetTerminationProtection", format_input(input))
  end

  @doc """
  Same as `set_termination_protection/2` but raise on error.
  """
  @spec set_termination_protection!(client :: ExAws.ElasticMapReduce.t, input :: set_termination_protection_input) :: ExAws.Request.JSON.success_t | no_return
  def set_termination_protection!(client, input) do
    case set_termination_protection(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  SetVisibleToAllUsers

  Sets whether all AWS Identity and Access Management (IAM) users under your
  account can access the specified job flows. This action works on running
  job flows. You can also set the visibility of a job flow when you launch it
  using the `VisibleToAllUsers` parameter of `RunJobFlow`. The
  SetVisibleToAllUsers action can be called only by an IAM user who created
  the job flow or the AWS account that owns the job flow.
  """

  @spec set_visible_to_all_users(client :: ExAws.ElasticMapReduce.t, input :: set_visible_to_all_users_input) :: ExAws.Request.JSON.response_t
  def set_visible_to_all_users(client, input) do
    request(client, "SetVisibleToAllUsers", format_input(input))
  end

  @doc """
  Same as `set_visible_to_all_users/2` but raise on error.
  """
  @spec set_visible_to_all_users!(client :: ExAws.ElasticMapReduce.t, input :: set_visible_to_all_users_input) :: ExAws.Request.JSON.success_t | no_return
  def set_visible_to_all_users!(client, input) do
    case set_visible_to_all_users(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  TerminateJobFlows

  TerminateJobFlows shuts a list of job flows down. When a job flow is shut
  down, any step not yet completed is canceled and the EC2 instances on which
  the job flow is running are stopped. Any log files not already saved are
  uploaded to Amazon S3 if a LogUri was specified when the job flow was
  created.

  The maximum number of JobFlows allowed is 10. The call to TerminateJobFlows
  is asynchronous. Depending on the configuration of the job flow, it may
  take up to 5-20 minutes for the job flow to completely terminate and
  release allocated resources, such as Amazon EC2 instances.
  """

  @spec terminate_job_flows(client :: ExAws.ElasticMapReduce.t, input :: terminate_job_flows_input) :: ExAws.Request.JSON.response_t
  def terminate_job_flows(client, input) do
    request(client, "TerminateJobFlows", format_input(input))
  end

  @doc """
  Same as `terminate_job_flows/2` but raise on error.
  """
  @spec terminate_job_flows!(client :: ExAws.ElasticMapReduce.t, input :: terminate_job_flows_input) :: ExAws.Request.JSON.success_t | no_return
  def terminate_job_flows!(client, input) do
    case terminate_job_flows(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  defp request(%{__struct__: client_module} = client, action, input) do
    apply(client_module, :request, [client, action, input])
  end
end
