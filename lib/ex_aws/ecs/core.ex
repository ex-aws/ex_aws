defmodule ExAws.Ecs.Core do
  import ExAws.Core.JSON, only: [format_input: 1]
  @actions [
    "CreateCluster",
    "CreateService",
    "DeleteCluster",
    "DeleteService",
    "DeregisterContainerInstance",
    "DeregisterTaskDefinition",
    "DescribeClusters",
    "DescribeContainerInstances",
    "DescribeServices",
    "DescribeTaskDefinition",
    "DescribeTasks",
    "DiscoverPollEndpoint",
    "ListClusters",
    "ListContainerInstances",
    "ListServices",
    "ListTaskDefinitionFamilies",
    "ListTaskDefinitions",
    "ListTasks",
    "RegisterContainerInstance",
    "RegisterTaskDefinition",
    "RunTask",
    "StartTask",
    "StopTask",
    "SubmitContainerStateChange",
    "SubmitTaskStateChange",
    "UpdateContainerAgent",
    "UpdateService"]

  @moduledoc """
  ## Amazon EC2 Container Service

  Amazon EC2 Container Service (Amazon ECS) is a highly scalable, fast,
  container management service that makes it easy to run, stop, and manage
  Docker containers on a cluster of Amazon EC2 instances. Amazon ECS lets you
  launch and stop container-enabled applications with simple API calls,
  allows you to get the state of your cluster from a centralized service, and
  gives you access to many familiar Amazon EC2 features like security groups,
  Amazon EBS volumes, and IAM roles.

  You can use Amazon ECS to schedule the placement of containers across your
  cluster based on your resource needs, isolation policies, and availability
  requirements. Amazon EC2 Container Service eliminates the need for you to
  operate your own cluster management and configuration management systems or
  worry about scaling your management infrastructure.
  """

  @type agent_update_status :: binary

  @type boxed_boolean :: boolean

  @type boxed_integer :: integer

  @type client_exception :: [
    message: binary,
  ]

  @type cluster :: [
    active_services_count: integer,
    cluster_arn: binary,
    cluster_name: binary,
    pending_tasks_count: integer,
    registered_container_instances_count: integer,
    running_tasks_count: integer,
    status: binary,
  ]

  @type cluster_contains_container_instances_exception :: [
  ]

  @type cluster_contains_services_exception :: [
  ]

  @type cluster_not_found_exception :: [
  ]

  @type clusters :: [cluster]

  @type container :: [
    container_arn: binary,
    exit_code: boxed_integer,
    last_status: binary,
    name: binary,
    network_bindings: network_bindings,
    reason: binary,
    task_arn: binary,
  ]

  @type container_definition :: [
    command: string_list,
    cpu: integer,
    entry_point: string_list,
    environment: environment_variables,
    essential: boxed_boolean,
    image: binary,
    links: string_list,
    memory: integer,
    mount_points: mount_point_list,
    name: binary,
    port_mappings: port_mapping_list,
    volumes_from: volume_from_list,
  ]

  @type container_definitions :: [container_definition]

  @type container_instance :: [
    agent_connected: boolean,
    agent_update_status: agent_update_status,
    container_instance_arn: binary,
    ec2_instance_id: binary,
    pending_tasks_count: integer,
    registered_resources: resources,
    remaining_resources: resources,
    running_tasks_count: integer,
    status: binary,
    version_info: version_info,
  ]

  @type container_instances :: [container_instance]

  @type container_override :: [
    command: string_list,
    environment: environment_variables,
    name: binary,
  ]

  @type container_overrides :: [container_override]

  @type containers :: [container]

  @type create_cluster_request :: [
    cluster_name: binary,
  ]

  @type create_cluster_response :: [
    cluster: cluster,
  ]

  @type create_service_request :: [
    client_token: binary,
    cluster: binary,
    desired_count: boxed_integer,
    load_balancers: load_balancers,
    role: binary,
    service_name: binary,
    task_definition: binary,
  ]

  @type create_service_response :: [
    service: service,
  ]

  @type delete_cluster_request :: [
    cluster: binary,
  ]

  @type delete_cluster_response :: [
    cluster: cluster,
  ]

  @type delete_service_request :: [
    cluster: binary,
    service: binary,
  ]

  @type delete_service_response :: [
    service: service,
  ]

  @type deployment :: [
    created_at: timestamp,
    desired_count: integer,
    id: binary,
    pending_count: integer,
    running_count: integer,
    status: binary,
    task_definition: binary,
    updated_at: timestamp,
  ]

  @type deployments :: [deployment]

  @type deregister_container_instance_request :: [
    cluster: binary,
    container_instance: binary,
    force: boxed_boolean,
  ]

  @type deregister_container_instance_response :: [
    container_instance: container_instance,
  ]

  @type deregister_task_definition_request :: [
    task_definition: binary,
  ]

  @type deregister_task_definition_response :: [
    task_definition: task_definition,
  ]

  @type describe_clusters_request :: [
    clusters: string_list,
  ]

  @type describe_clusters_response :: [
    clusters: clusters,
    failures: failures,
  ]

  @type describe_container_instances_request :: [
    cluster: binary,
    container_instances: string_list,
  ]

  @type describe_container_instances_response :: [
    container_instances: container_instances,
    failures: failures,
  ]

  @type describe_services_request :: [
    cluster: binary,
    services: string_list,
  ]

  @type describe_services_response :: [
    failures: failures,
    services: services,
  ]

  @type describe_task_definition_request :: [
    task_definition: binary,
  ]

  @type describe_task_definition_response :: [
    task_definition: task_definition,
  ]

  @type describe_tasks_request :: [
    cluster: binary,
    tasks: string_list,
  ]

  @type describe_tasks_response :: [
    failures: failures,
    tasks: tasks,
  ]

  @type desired_status :: binary

  @type discover_poll_endpoint_request :: [
    cluster: binary,
    container_instance: binary,
  ]

  @type discover_poll_endpoint_response :: [
    endpoint: binary,
    telemetry_endpoint: binary,
  ]

  @type double :: float

  @type environment_variables :: [key_value_pair]

  @type failure :: [
    arn: binary,
    reason: binary,
  ]

  @type failures :: [failure]

  @type host_volume_properties :: [
    source_path: binary,
  ]

  @type invalid_parameter_exception :: [
  ]

  @type key_value_pair :: [
    name: binary,
    value: binary,
  ]

  @type list_clusters_request :: [
    max_results: boxed_integer,
    next_token: binary,
  ]

  @type list_clusters_response :: [
    cluster_arns: string_list,
    next_token: binary,
  ]

  @type list_container_instances_request :: [
    cluster: binary,
    max_results: boxed_integer,
    next_token: binary,
  ]

  @type list_container_instances_response :: [
    container_instance_arns: string_list,
    next_token: binary,
  ]

  @type list_services_request :: [
    cluster: binary,
    max_results: boxed_integer,
    next_token: binary,
  ]

  @type list_services_response :: [
    next_token: binary,
    service_arns: string_list,
  ]

  @type list_task_definition_families_request :: [
    family_prefix: binary,
    max_results: boxed_integer,
    next_token: binary,
  ]

  @type list_task_definition_families_response :: [
    families: string_list,
    next_token: binary,
  ]

  @type list_task_definitions_request :: [
    family_prefix: binary,
    max_results: boxed_integer,
    next_token: binary,
    sort: sort_order,
    status: task_definition_status,
  ]

  @type list_task_definitions_response :: [
    next_token: binary,
    task_definition_arns: string_list,
  ]

  @type list_tasks_request :: [
    cluster: binary,
    container_instance: binary,
    desired_status: desired_status,
    family: binary,
    max_results: boxed_integer,
    next_token: binary,
    service_name: binary,
    started_by: binary,
  ]

  @type list_tasks_response :: [
    next_token: binary,
    task_arns: string_list,
  ]

  @type load_balancer :: [
    container_name: binary,
    container_port: boxed_integer,
    load_balancer_name: binary,
  ]

  @type load_balancers :: [load_balancer]

  @type long :: integer

  @type missing_version_exception :: [
  ]

  @type mount_point :: [
    container_path: binary,
    read_only: boxed_boolean,
    source_volume: binary,
  ]

  @type mount_point_list :: [mount_point]

  @type network_binding :: [
    bind_ip: binary,
    container_port: boxed_integer,
    host_port: boxed_integer,
    protocol: transport_protocol,
  ]

  @type network_bindings :: [network_binding]

  @type no_update_available_exception :: [
  ]

  @type port_mapping :: [
    container_port: integer,
    host_port: integer,
    protocol: transport_protocol,
  ]

  @type port_mapping_list :: [port_mapping]

  @type register_container_instance_request :: [
    cluster: binary,
    container_instance_arn: binary,
    instance_identity_document: binary,
    instance_identity_document_signature: binary,
    total_resources: resources,
    version_info: version_info,
  ]

  @type register_container_instance_response :: [
    container_instance: container_instance,
  ]

  @type register_task_definition_request :: [
    container_definitions: container_definitions,
    family: binary,
    volumes: volume_list,
  ]

  @type register_task_definition_response :: [
    task_definition: task_definition,
  ]

  @type resource :: [
    double_value: double,
    integer_value: integer,
    long_value: long,
    name: binary,
    string_set_value: string_list,
    type: binary,
  ]

  @type resources :: [resource]

  @type run_task_request :: [
    cluster: binary,
    count: boxed_integer,
    overrides: task_override,
    started_by: binary,
    task_definition: binary,
  ]

  @type run_task_response :: [
    failures: failures,
    tasks: tasks,
  ]

  @type server_exception :: [
    message: binary,
  ]

  @type service :: [
    cluster_arn: binary,
    deployments: deployments,
    desired_count: integer,
    events: service_events,
    load_balancers: load_balancers,
    pending_count: integer,
    role_arn: binary,
    running_count: integer,
    service_arn: binary,
    service_name: binary,
    status: binary,
    task_definition: binary,
  ]

  @type service_event :: [
    created_at: timestamp,
    id: binary,
    message: binary,
  ]

  @type service_events :: [service_event]

  @type service_not_active_exception :: [
  ]

  @type service_not_found_exception :: [
  ]

  @type services :: [service]

  @type sort_order :: binary

  @type start_task_request :: [
    cluster: binary,
    container_instances: string_list,
    overrides: task_override,
    started_by: binary,
    task_definition: binary,
  ]

  @type start_task_response :: [
    failures: failures,
    tasks: tasks,
  ]

  @type stop_task_request :: [
    cluster: binary,
    task: binary,
  ]

  @type stop_task_response :: [
    task: task,
  ]

  @type string_list :: [binary]

  @type submit_container_state_change_request :: [
    cluster: binary,
    container_name: binary,
    exit_code: boxed_integer,
    network_bindings: network_bindings,
    reason: binary,
    status: binary,
    task: binary,
  ]

  @type submit_container_state_change_response :: [
    acknowledgment: binary,
  ]

  @type submit_task_state_change_request :: [
    cluster: binary,
    reason: binary,
    status: binary,
    task: binary,
  ]

  @type submit_task_state_change_response :: [
    acknowledgment: binary,
  ]

  @type task :: [
    cluster_arn: binary,
    container_instance_arn: binary,
    containers: containers,
    desired_status: binary,
    last_status: binary,
    overrides: task_override,
    started_by: binary,
    task_arn: binary,
    task_definition_arn: binary,
  ]

  @type task_definition :: [
    container_definitions: container_definitions,
    family: binary,
    revision: integer,
    status: task_definition_status,
    task_definition_arn: binary,
    volumes: volume_list,
  ]

  @type task_definition_status :: binary

  @type task_override :: [
    container_overrides: container_overrides,
  ]

  @type tasks :: [task]

  @type timestamp :: integer

  @type transport_protocol :: binary

  @type update_container_agent_request :: [
    cluster: binary,
    container_instance: binary,
  ]

  @type update_container_agent_response :: [
    container_instance: container_instance,
  ]

  @type update_in_progress_exception :: [
  ]

  @type update_service_request :: [
    cluster: binary,
    desired_count: boxed_integer,
    service: binary,
    task_definition: binary,
  ]

  @type update_service_response :: [
    service: service,
  ]

  @type version_info :: [
    agent_hash: binary,
    agent_version: binary,
    docker_version: binary,
  ]

  @type volume :: [
    host: host_volume_properties,
    name: binary,
  ]

  @type volume_from :: [
    read_only: boxed_boolean,
    source_container: binary,
  ]

  @type volume_from_list :: [volume_from]

  @type volume_list :: [volume]





  @doc """
  CreateCluster

  Creates a new Amazon ECS cluster. By default, your account will receive a
  `default` cluster when you launch your first container instance. However,
  you can create your own cluster with a unique name with the `CreateCluster`
  action.
  """

  @spec create_cluster(client :: ExAws.Ecs.t, input :: create_cluster_request) :: ExAws.Request.JSON.response_t
  def create_cluster(client, input) do
    request(client, "CreateCluster", format_input(input))
  end

  @doc """
  Same as `create_cluster/2` but raise on error.
  """
  @spec create_cluster!(client :: ExAws.Ecs.t, input :: create_cluster_request) :: ExAws.Request.JSON.success_t | no_return
  def create_cluster!(client, input) do
    case create_cluster(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateService

  Runs and maintains a desired number of tasks from a specified task
  definition. If the number of tasks running in a service drops below
  `desiredCount`, Amazon ECS will spawn another instantiation of the task in
  the specified cluster.
  """

  @spec create_service(client :: ExAws.Ecs.t, input :: create_service_request) :: ExAws.Request.JSON.response_t
  def create_service(client, input) do
    request(client, "CreateService", format_input(input))
  end

  @doc """
  Same as `create_service/2` but raise on error.
  """
  @spec create_service!(client :: ExAws.Ecs.t, input :: create_service_request) :: ExAws.Request.JSON.success_t | no_return
  def create_service!(client, input) do
    case create_service(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteCluster

  Deletes the specified cluster. You must deregister all container instances
  from this cluster before you may delete it. You can list the container
  instances in a cluster with `ListContainerInstances` and deregister them
  with `DeregisterContainerInstance`.
  """

  @spec delete_cluster(client :: ExAws.Ecs.t, input :: delete_cluster_request) :: ExAws.Request.JSON.response_t
  def delete_cluster(client, input) do
    request(client, "DeleteCluster", format_input(input))
  end

  @doc """
  Same as `delete_cluster/2` but raise on error.
  """
  @spec delete_cluster!(client :: ExAws.Ecs.t, input :: delete_cluster_request) :: ExAws.Request.JSON.success_t | no_return
  def delete_cluster!(client, input) do
    case delete_cluster(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteService

  Deletes a specified service within a cluster.
  """

  @spec delete_service(client :: ExAws.Ecs.t, input :: delete_service_request) :: ExAws.Request.JSON.response_t
  def delete_service(client, input) do
    request(client, "DeleteService", format_input(input))
  end

  @doc """
  Same as `delete_service/2` but raise on error.
  """
  @spec delete_service!(client :: ExAws.Ecs.t, input :: delete_service_request) :: ExAws.Request.JSON.success_t | no_return
  def delete_service!(client, input) do
    case delete_service(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeregisterContainerInstance

  Deregisters an Amazon ECS container instance from the specified cluster.
  This instance will no longer be available to run tasks.

  If you intend to use the container instance for some other purpose after
  deregistration, you should stop all of the tasks running on the container
  instance before deregistration to avoid any orphaned tasks from consuming
  resources.

  Deregistering a container instance removes the instance from a cluster, but
  it does not terminate the EC2 instance; if you are finished using the
  instance, be sure to terminate it in the Amazon EC2 console to stop
  billing.

  Note:When you terminate a container instance, it is automatically
  deregistered from your cluster.
  """

  @spec deregister_container_instance(client :: ExAws.Ecs.t, input :: deregister_container_instance_request) :: ExAws.Request.JSON.response_t
  def deregister_container_instance(client, input) do
    request(client, "DeregisterContainerInstance", format_input(input))
  end

  @doc """
  Same as `deregister_container_instance/2` but raise on error.
  """
  @spec deregister_container_instance!(client :: ExAws.Ecs.t, input :: deregister_container_instance_request) :: ExAws.Request.JSON.success_t | no_return
  def deregister_container_instance!(client, input) do
    case deregister_container_instance(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeregisterTaskDefinition

  Deregisters the specified task definition by family and revision. Upon
  deregistration, the task definition is marked as `INACTIVE`. Existing tasks
  and services that reference an `INACTIVE` task definition continue to run
  without disruption. Existing services that reference an `INACTIVE` task
  definition can still scale up or down by modifying the service's desired
  count.

  You cannot use an `INACTIVE` task definition to run new tasks or create new
  services, and you cannot update an existing service to reference an
  `INACTIVE` task definition (although there may be up to a 10 minute window
  following deregistration where these restrictions have not yet taken
  effect).
  """

  @spec deregister_task_definition(client :: ExAws.Ecs.t, input :: deregister_task_definition_request) :: ExAws.Request.JSON.response_t
  def deregister_task_definition(client, input) do
    request(client, "DeregisterTaskDefinition", format_input(input))
  end

  @doc """
  Same as `deregister_task_definition/2` but raise on error.
  """
  @spec deregister_task_definition!(client :: ExAws.Ecs.t, input :: deregister_task_definition_request) :: ExAws.Request.JSON.success_t | no_return
  def deregister_task_definition!(client, input) do
    case deregister_task_definition(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeClusters

  Describes one or more of your clusters.
  """

  @spec describe_clusters(client :: ExAws.Ecs.t, input :: describe_clusters_request) :: ExAws.Request.JSON.response_t
  def describe_clusters(client, input) do
    request(client, "DescribeClusters", format_input(input))
  end

  @doc """
  Same as `describe_clusters/2` but raise on error.
  """
  @spec describe_clusters!(client :: ExAws.Ecs.t, input :: describe_clusters_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_clusters!(client, input) do
    case describe_clusters(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeContainerInstances

  Describes Amazon EC2 Container Service container instances. Returns
  metadata about registered and remaining resources on each container
  instance requested.
  """

  @spec describe_container_instances(client :: ExAws.Ecs.t, input :: describe_container_instances_request) :: ExAws.Request.JSON.response_t
  def describe_container_instances(client, input) do
    request(client, "DescribeContainerInstances", format_input(input))
  end

  @doc """
  Same as `describe_container_instances/2` but raise on error.
  """
  @spec describe_container_instances!(client :: ExAws.Ecs.t, input :: describe_container_instances_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_container_instances!(client, input) do
    case describe_container_instances(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeServices

  Describes the specified services running in your cluster.
  """

  @spec describe_services(client :: ExAws.Ecs.t, input :: describe_services_request) :: ExAws.Request.JSON.response_t
  def describe_services(client, input) do
    request(client, "DescribeServices", format_input(input))
  end

  @doc """
  Same as `describe_services/2` but raise on error.
  """
  @spec describe_services!(client :: ExAws.Ecs.t, input :: describe_services_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_services!(client, input) do
    case describe_services(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeTaskDefinition

  Describes a task definition. You can specify a `family` and `revision` to
  find information on a specific task definition, or you can simply specify
  the family to find the latest `ACTIVE` revision in that family.

  Note: You can only describe `INACTIVE` task definitions while an active
  task or service references them.
  """

  @spec describe_task_definition(client :: ExAws.Ecs.t, input :: describe_task_definition_request) :: ExAws.Request.JSON.response_t
  def describe_task_definition(client, input) do
    request(client, "DescribeTaskDefinition", format_input(input))
  end

  @doc """
  Same as `describe_task_definition/2` but raise on error.
  """
  @spec describe_task_definition!(client :: ExAws.Ecs.t, input :: describe_task_definition_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_task_definition!(client, input) do
    case describe_task_definition(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeTasks

  Describes a specified task or tasks.
  """

  @spec describe_tasks(client :: ExAws.Ecs.t, input :: describe_tasks_request) :: ExAws.Request.JSON.response_t
  def describe_tasks(client, input) do
    request(client, "DescribeTasks", format_input(input))
  end

  @doc """
  Same as `describe_tasks/2` but raise on error.
  """
  @spec describe_tasks!(client :: ExAws.Ecs.t, input :: describe_tasks_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_tasks!(client, input) do
    case describe_tasks(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DiscoverPollEndpoint

  Note:This action is only used by the Amazon EC2 Container Service agent,
  and it is not intended for use outside of the agent.

  Returns an endpoint for the Amazon EC2 Container Service agent to poll for
  updates.
  """

  @spec discover_poll_endpoint(client :: ExAws.Ecs.t, input :: discover_poll_endpoint_request) :: ExAws.Request.JSON.response_t
  def discover_poll_endpoint(client, input) do
    request(client, "DiscoverPollEndpoint", format_input(input))
  end

  @doc """
  Same as `discover_poll_endpoint/2` but raise on error.
  """
  @spec discover_poll_endpoint!(client :: ExAws.Ecs.t, input :: discover_poll_endpoint_request) :: ExAws.Request.JSON.success_t | no_return
  def discover_poll_endpoint!(client, input) do
    case discover_poll_endpoint(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListClusters

  Returns a list of existing clusters.
  """

  @spec list_clusters(client :: ExAws.Ecs.t, input :: list_clusters_request) :: ExAws.Request.JSON.response_t
  def list_clusters(client, input) do
    request(client, "ListClusters", format_input(input))
  end

  @doc """
  Same as `list_clusters/2` but raise on error.
  """
  @spec list_clusters!(client :: ExAws.Ecs.t, input :: list_clusters_request) :: ExAws.Request.JSON.success_t | no_return
  def list_clusters!(client, input) do
    case list_clusters(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListContainerInstances

  Returns a list of container instances in a specified cluster.
  """

  @spec list_container_instances(client :: ExAws.Ecs.t, input :: list_container_instances_request) :: ExAws.Request.JSON.response_t
  def list_container_instances(client, input) do
    request(client, "ListContainerInstances", format_input(input))
  end

  @doc """
  Same as `list_container_instances/2` but raise on error.
  """
  @spec list_container_instances!(client :: ExAws.Ecs.t, input :: list_container_instances_request) :: ExAws.Request.JSON.success_t | no_return
  def list_container_instances!(client, input) do
    case list_container_instances(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListServices

  Lists the services that are running in a specified cluster.
  """

  @spec list_services(client :: ExAws.Ecs.t, input :: list_services_request) :: ExAws.Request.JSON.response_t
  def list_services(client, input) do
    request(client, "ListServices", format_input(input))
  end

  @doc """
  Same as `list_services/2` but raise on error.
  """
  @spec list_services!(client :: ExAws.Ecs.t, input :: list_services_request) :: ExAws.Request.JSON.success_t | no_return
  def list_services!(client, input) do
    case list_services(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListTaskDefinitionFamilies

  Returns a list of task definition families that are registered to your
  account (which may include task definition families that no longer have any
  `ACTIVE` task definitions). You can filter the results with the
  `familyPrefix` parameter.
  """

  @spec list_task_definition_families(client :: ExAws.Ecs.t, input :: list_task_definition_families_request) :: ExAws.Request.JSON.response_t
  def list_task_definition_families(client, input) do
    request(client, "ListTaskDefinitionFamilies", format_input(input))
  end

  @doc """
  Same as `list_task_definition_families/2` but raise on error.
  """
  @spec list_task_definition_families!(client :: ExAws.Ecs.t, input :: list_task_definition_families_request) :: ExAws.Request.JSON.success_t | no_return
  def list_task_definition_families!(client, input) do
    case list_task_definition_families(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListTaskDefinitions

  Returns a list of task definitions that are registered to your account. You
  can filter the results by family name with the `familyPrefix` parameter or
  by status with the `status` parameter.
  """

  @spec list_task_definitions(client :: ExAws.Ecs.t, input :: list_task_definitions_request) :: ExAws.Request.JSON.response_t
  def list_task_definitions(client, input) do
    request(client, "ListTaskDefinitions", format_input(input))
  end

  @doc """
  Same as `list_task_definitions/2` but raise on error.
  """
  @spec list_task_definitions!(client :: ExAws.Ecs.t, input :: list_task_definitions_request) :: ExAws.Request.JSON.success_t | no_return
  def list_task_definitions!(client, input) do
    case list_task_definitions(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListTasks

  Returns a list of tasks for a specified cluster. You can filter the results
  by family name, by a particular container instance, or by the desired
  status of the task with the `family`, `containerInstance`, and
  `desiredStatus` parameters.
  """

  @spec list_tasks(client :: ExAws.Ecs.t, input :: list_tasks_request) :: ExAws.Request.JSON.response_t
  def list_tasks(client, input) do
    request(client, "ListTasks", format_input(input))
  end

  @doc """
  Same as `list_tasks/2` but raise on error.
  """
  @spec list_tasks!(client :: ExAws.Ecs.t, input :: list_tasks_request) :: ExAws.Request.JSON.success_t | no_return
  def list_tasks!(client, input) do
    case list_tasks(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RegisterContainerInstance

  Note:This action is only used by the Amazon EC2 Container Service agent,
  and it is not intended for use outside of the agent.

  Registers an Amazon EC2 instance into the specified cluster. This instance
  will become available to place containers on.
  """

  @spec register_container_instance(client :: ExAws.Ecs.t, input :: register_container_instance_request) :: ExAws.Request.JSON.response_t
  def register_container_instance(client, input) do
    request(client, "RegisterContainerInstance", format_input(input))
  end

  @doc """
  Same as `register_container_instance/2` but raise on error.
  """
  @spec register_container_instance!(client :: ExAws.Ecs.t, input :: register_container_instance_request) :: ExAws.Request.JSON.success_t | no_return
  def register_container_instance!(client, input) do
    case register_container_instance(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RegisterTaskDefinition

  Registers a new task definition from the supplied `family` and
  `containerDefinitions`. Optionally, you can add data volumes to your
  containers with the `volumes` parameter. For more information on task
  definition parameters and defaults, see [Amazon ECS Task
  Definitions](http://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_defintions.html)
  in the *Amazon EC2 Container Service Developer Guide*.
  """

  @spec register_task_definition(client :: ExAws.Ecs.t, input :: register_task_definition_request) :: ExAws.Request.JSON.response_t
  def register_task_definition(client, input) do
    request(client, "RegisterTaskDefinition", format_input(input))
  end

  @doc """
  Same as `register_task_definition/2` but raise on error.
  """
  @spec register_task_definition!(client :: ExAws.Ecs.t, input :: register_task_definition_request) :: ExAws.Request.JSON.success_t | no_return
  def register_task_definition!(client, input) do
    case register_task_definition(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RunTask

  Start a task using random placement and the default Amazon ECS scheduler.
  If you want to use your own scheduler or place a task on a specific
  container instance, use `StartTask` instead.

  ** The `count` parameter is limited to 10 tasks per call.

  **
  """

  @spec run_task(client :: ExAws.Ecs.t, input :: run_task_request) :: ExAws.Request.JSON.response_t
  def run_task(client, input) do
    request(client, "RunTask", format_input(input))
  end

  @doc """
  Same as `run_task/2` but raise on error.
  """
  @spec run_task!(client :: ExAws.Ecs.t, input :: run_task_request) :: ExAws.Request.JSON.success_t | no_return
  def run_task!(client, input) do
    case run_task(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  StartTask

  Starts a new task from the specified task definition on the specified
  container instance or instances. If you want to use the default Amazon ECS
  scheduler to place your task, use `RunTask` instead.

  ** The list of container instances to start tasks on is limited to 10.

  **
  """

  @spec start_task(client :: ExAws.Ecs.t, input :: start_task_request) :: ExAws.Request.JSON.response_t
  def start_task(client, input) do
    request(client, "StartTask", format_input(input))
  end

  @doc """
  Same as `start_task/2` but raise on error.
  """
  @spec start_task!(client :: ExAws.Ecs.t, input :: start_task_request) :: ExAws.Request.JSON.success_t | no_return
  def start_task!(client, input) do
    case start_task(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  StopTask

  Stops a running task.
  """

  @spec stop_task(client :: ExAws.Ecs.t, input :: stop_task_request) :: ExAws.Request.JSON.response_t
  def stop_task(client, input) do
    request(client, "StopTask", format_input(input))
  end

  @doc """
  Same as `stop_task/2` but raise on error.
  """
  @spec stop_task!(client :: ExAws.Ecs.t, input :: stop_task_request) :: ExAws.Request.JSON.success_t | no_return
  def stop_task!(client, input) do
    case stop_task(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  SubmitContainerStateChange

  Note:This action is only used by the Amazon EC2 Container Service agent,
  and it is not intended for use outside of the agent.

  Sent to acknowledge that a container changed states.
  """

  @spec submit_container_state_change(client :: ExAws.Ecs.t, input :: submit_container_state_change_request) :: ExAws.Request.JSON.response_t
  def submit_container_state_change(client, input) do
    request(client, "SubmitContainerStateChange", format_input(input))
  end

  @doc """
  Same as `submit_container_state_change/2` but raise on error.
  """
  @spec submit_container_state_change!(client :: ExAws.Ecs.t, input :: submit_container_state_change_request) :: ExAws.Request.JSON.success_t | no_return
  def submit_container_state_change!(client, input) do
    case submit_container_state_change(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  SubmitTaskStateChange

  Note:This action is only used by the Amazon EC2 Container Service agent,
  and it is not intended for use outside of the agent.

  Sent to acknowledge that a task changed states.
  """

  @spec submit_task_state_change(client :: ExAws.Ecs.t, input :: submit_task_state_change_request) :: ExAws.Request.JSON.response_t
  def submit_task_state_change(client, input) do
    request(client, "SubmitTaskStateChange", format_input(input))
  end

  @doc """
  Same as `submit_task_state_change/2` but raise on error.
  """
  @spec submit_task_state_change!(client :: ExAws.Ecs.t, input :: submit_task_state_change_request) :: ExAws.Request.JSON.success_t | no_return
  def submit_task_state_change!(client, input) do
    case submit_task_state_change(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateContainerAgent

  Updates the Amazon ECS container agent on a specified container instance.
  Updating the Amazon ECS container agent does not interrupt running tasks or
  services on the container instance. The process for updating the agent
  differs depending on whether your container instance was launched with the
  Amazon ECS-optimized AMI or another operating system.

  `UpdateContainerAgent` requires the Amazon ECS-optimized AMI or Amazon
  Linux with the `ecs-init` service installed and running. For help updating
  the Amazon ECS container agent on other operating systems, see [Manually
  Updating the Amazon ECS Container
  Agent](http://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-agent-update.html#manually_update_agent)
  in the *Amazon EC2 Container Service Developer Guide*.
  """

  @spec update_container_agent(client :: ExAws.Ecs.t, input :: update_container_agent_request) :: ExAws.Request.JSON.response_t
  def update_container_agent(client, input) do
    request(client, "UpdateContainerAgent", format_input(input))
  end

  @doc """
  Same as `update_container_agent/2` but raise on error.
  """
  @spec update_container_agent!(client :: ExAws.Ecs.t, input :: update_container_agent_request) :: ExAws.Request.JSON.success_t | no_return
  def update_container_agent!(client, input) do
    case update_container_agent(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateService

  Modify the desired count or task definition used in a service.

  You can add to or subtract from the number of instantiations of a task
  definition in a service by specifying the cluster that the service is
  running in and a new `desiredCount` parameter.

  You can use `UpdateService` to modify your task definition and deploy a new
  version of your service, one task at a time. If you modify the task
  definition with `UpdateService`, Amazon ECS spawns a task with the new
  version of the task definition and then stops an old task after the new
  version is running. Because `UpdateService` starts a new version of the
  task before stopping an old version, your cluster must have capacity to
  support one more instantiation of the task when `UpdateService` is run. If
  your cluster cannot support another instantiation of the task used in your
  service, you can reduce the desired count of your service by one before
  modifying the task definition.
  """

  @spec update_service(client :: ExAws.Ecs.t, input :: update_service_request) :: ExAws.Request.JSON.response_t
  def update_service(client, input) do
    request(client, "UpdateService", format_input(input))
  end

  @doc """
  Same as `update_service/2` but raise on error.
  """
  @spec update_service!(client :: ExAws.Ecs.t, input :: update_service_request) :: ExAws.Request.JSON.success_t | no_return
  def update_service!(client, input) do
    case update_service(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  defp request(%{__struct__: client_module} = client, action, input) do
    apply(client_module, :request, [client, action, input])
  end
end
