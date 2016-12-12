defmodule ExAws.ECS do
  require Logger

  @namespace "AmazonEC2ContainerServiceV20141113"

  @moduledoc """
  Amazon EC2 Container Service (Amazon ECS) is a highly scalable, fast,
  container management service that makes it easy to run, stop, and manage
  Docker containers on a cluster of EC2 instances. Amazon ECS lets you launch
  and stop container-enabled applications with simple API calls, allows you
  to get the state of your cluster from a centralized service, and gives you
  access to many familiar Amazon EC2 features like security groups, Amazon
  EBS volumes, and IAM roles.

  You can use Amazon ECS to schedule the placement of containers across your
  cluster based on your resource needs, isolation policies, and availability
  requirements. Amazon EC2 Container Service eliminates the need for you to
  operate your own cluster management and configuration management systems or
  worry about scaling your management infrastructure.
  """

  @doc """
  Creates a new Amazon ECS cluster. By default, your account receives a
  `default` cluster when you launch your first container instance. However,
  you can create your own cluster with a unique name with the `CreateCluster`
  action.
  """
  @spec create_cluster(cluster_name :: binary) :: ExAws.Operation.JSON.t
  def create_cluster(cluster_name) do
    request(:create_cluster, %{"clusterName" => cluster_name})
  end
  @spec create_cluster() :: ExAws.Operation.JSON.t
  def create_cluster() do
    request(:create_cluster)
  end

  @doc """
  Runs and maintains a desired number of tasks from a specified task
  definition. If the number of tasks running in a service drops below
  `desiredCount`, Amazon ECS spawns another instantiation of the task in the
  specified cluster. To update an existing service, see `UpdateService`.

  In addition to maintaining the desired count of tasks in your service, you
  can optionally run your service behind a load balancer. The load balancer
  distributes traffic across the tasks that are associated with the service.

  You can optionally specify a deployment configuration for your service.
  During a deployment (which is triggered by changing the task definition of
  a service with an `UpdateService` operation), the service scheduler uses
  the `minimumHealthyPercent` and `maximumPercent` parameters to determine
  the deployment strategy.

  If the `minimumHealthyPercent` is below 100%, the scheduler can ignore the
  `desiredCount` temporarily during a deployment. For example, if your
  service has a `desiredCount` of four tasks, a `minimumHealthyPercent` of
  50% allows the scheduler to stop two existing tasks before starting two new
  tasks. Tasks for services that *do not* use a load balancer are considered
  healthy if they are in the `RUNNING` state; tasks for services that *do*
  use a load balancer are considered healthy if they are in the `RUNNING`
  state and the container instance it is hosted on is reported as healthy by
  the load balancer. The default value for `minimumHealthyPercent` is 50% in
  the console and 100% for the AWS CLI, the AWS SDKs, and the APIs.

  The `maximumPercent` parameter represents an upper limit on the number of
  running tasks during a deployment, which enables you to define the
  deployment batch size. For example, if your service has a `desiredCount` of
  four tasks, a `maximumPercent` value of 200% starts four new tasks before
  stopping the four older tasks (provided that the cluster resources required
  to do this are available). The default value for `maximumPercent` is 200%.

  When the service scheduler launches new tasks, it attempts to balance them
  across the Availability Zones in your cluster with the following logic:

  <ul> <li> Determine which of the container instances in your cluster can
  support your service's task definition (for example, they have the required
  CPU, memory, ports, and container instance attributes).

  </li> <li> Sort the valid container instances by the fewest number of
  running tasks for this service in the same Availability Zone as the
  instance. For example, if zone A has one running service task and zones B
  and C each have zero, valid container instances in either zone B or C are
  considered optimal for placement.

  </li> <li> Place the new service task on a valid container instance in an
  optimal Availability Zone (based on the previous steps), favoring container
  instances with the fewest number of running tasks for this service.

  </li> </ul>
  """
  @spec create_service(service_name :: binary, task_definition :: binary, desired_count :: pos_integer) :: ExAws.Operation.JSON.t
  @spec create_service(service_name :: binary, task_definition :: binary, desired_count :: pos_integer, opts :: Keyword.t) :: ExAws.Operation.JSON.t
  def create_service(service_name, task_definition, desired_count, opts \\ []) do
    data = opts
    |> normalize_opts
    |> Map.merge(%{"serviceName" => service_name, "taskDefinition" => task_definition, "desiredCount" => desired_count})

    request(:create_service, data)
  end

  @doc """
  Deletes the specified cluster. You must deregister all container instances
  from this cluster before you may delete it. You can list the container
  instances in a cluster with `ListContainerInstances` and deregister them
  with `DeregisterContainerInstance`.
  """
  @spec delete_cluster(cluster_name :: binary) :: ExAws.Operation.JSON.t
  def delete_cluster(cluster_name) do
    data = %{"cluster" => cluster_name}
    request(:delete_cluster, data)
  end

  @doc """
  Deletes a specified service within a cluster. You can delete a service if
  you have no running tasks in it and the desired task count is zero. If the
  service is actively maintaining tasks, you cannot delete it, and you must
  update the service to a desired task count of zero. For more information,
  see `UpdateService`.

  <note> When you delete a service, if there are still running tasks that
  require cleanup, the service status moves from `ACTIVE` to `DRAINING`, and
  the service is no longer visible in the console or in `ListServices` API
  operations. After the tasks have stopped, then the service status moves
  from `DRAINING` to `INACTIVE`. Services in the `DRAINING` or `INACTIVE`
  status can still be viewed with `DescribeServices` API operations; however,
  in the future, `INACTIVE` services may be cleaned up and purged from Amazon
  ECS record keeping, and `DescribeServices` API operations on those services
  will return a `ServiceNotFoundException` error.

  </note>
  """
  @spec delete_service(service :: binary) :: ExAws.Operation.JSON.t
  def delete_service(service) do
    request(:delete_service, %{"service" => service})
  end
  @spec delete_service(service :: binary, cluster :: binary) :: ExAws.Operation.JSON.t
  def delete_service(service, cluster) do
    request(:delete_service, %{"service" => service, "cluster" => cluster})
  end

  @type deregister_container_instance_opts :: [
    {:cluster, binary} |
    {:force, boolean}
  ]
  @doc """
  Deregisters an Amazon ECS container instance from the specified cluster.
  This instance is no longer available to run tasks.

  If you intend to use the container instance for some other purpose after
  deregistration, you should stop all of the tasks running on the container
  instance before deregistration to avoid any orphaned tasks from consuming
  resources.

  Deregistering a container instance removes the instance from a cluster, but
  it does not terminate the EC2 instance; if you are finished using the
  instance, be sure to terminate it in the Amazon EC2 console to stop
  billing.

  <note> If you terminate a running container instance with a connected
  Amazon ECS container agent, the agent automatically deregisters the
  instance from your cluster (stopped container instances or instances with
  disconnected agents are not automatically deregistered when terminated).

  </note>
  """
  @spec deregister_container_instance(container_instance :: binary) :: ExAws.Operation.JSON.t
  @spec deregister_container_instance(container_instance :: binary, opts :: deregister_container_instance_opts) :: ExAws.Operation.JSON.t
  def deregister_container_instance(container_instance, opts \\ []) do
    data = opts
    |> normalize_opts
    |> Map.merge(%{"containerInstance" => container_instance})

    request(:deregister_container_instance, data)
  end

  @doc """
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
  @spec deregister_task_definition(task_definition :: binary) :: ExAws.Operation.JSON.t
  def deregister_task_definition(task_definition) do
    data = %{"taskDefinition" => task_definition}

    request(:deregister_task_definition, data)
  end

  @doc """
  Describes one or more of your clusters.
  """
  @spec describe_clusters() :: ExAws.Operation.JSON.t
  def describe_clusters() do
    request(:describe_clusters)
  end
  @spec describe_clusters(clusters :: list(binary)) :: ExAws.Operation.JSON.t
  def describe_clusters(clusters) do
    request(:describe_clusters , %{"clusters" => clusters})
  end

  @doc """
  Describes Amazon EC2 Container Service container instances. Returns
  metadata about registered and remaining resources on each container
  instance requested.
  """
  @spec describe_container_instances(container_instances :: list(binary)) :: ExAws.Operation.JSON.t
  def describe_container_instances(container_instances) do
    request(:describe_container_instances, %{"containerInstances" => container_instances})
  end
  @spec describe_container_instances(container_instances :: list(binary), cluster :: binary) :: ExAws.Operation.JSON.t
  def describe_container_instances(container_instances, cluster) do
    request(:describe_container_instances, %{"containerInstances" => container_instances, "cluster" => cluster})
  end

  @doc """
  Describes the specified services running in your cluster.
  """
  @spec describe_services(services :: list(binary)) :: ExAws.Operation.JSON.t
  def describe_services(services) do
    request(:describe_services, %{"services" => services})
  end
  @spec describe_services(services :: list(binary), cluster :: binary) :: ExAws.Operation.JSON.t
  def describe_services(services, cluster) do
    request(:describe_services, %{"services" => services, "cluster" => cluster})
  end


  @doc """
  Describes a task definition. You can specify a `family` and `revision` to
  find information about a specific task definition, or you can simply
  specify the family to find the latest `ACTIVE` revision in that family.

  <note> You can only describe `INACTIVE` task definitions while an active
  task or service references them.

  </note>
  """
  @spec describe_task_definition(task_definition :: binary) :: ExAws.Operation.JSON.t
  def describe_task_definition(task_definition) do
    request(:describe_task_definition, %{"taskDefinition" => task_definition})
  end

  @doc """
  Describes a specified task or tasks.
  """
  @spec describe_tasks(tasks :: list(binary)) :: ExAws.Operation.JSON.t
  def describe_tasks(tasks) do
    request(:describe_tasks, %{"tasks" => tasks})
  end
  @spec describe_tasks(tasks :: list(binary), cluster :: binary) :: ExAws.Operation.JSON.t
  def describe_tasks(tasks, cluster) do
    request(:describe_tasks, %{"tasks" => tasks, "cluster" => cluster})
  end

  @type discover_poll_endpoint_opts :: [
    {:cluster, binary} |
    {:container_instance, binary}
  ]
  @doc """
  <note> This action is only used by the Amazon EC2 Container Service agent,
  and it is not intended for use outside of the agent.

  </note> Returns an endpoint for the Amazon EC2 Container Service agent to
  poll for updates.
  """
  @spec discover_poll_endpoint() :: ExAws.Operation.JSON.t
  @spec discover_poll_endpoint(opts :: discover_poll_endpoint_opts) :: ExAws.Operation.JSON.t
  def discover_poll_endpoint(opts \\ []) do
    data = opts
    |> normalize_opts
    request(:discover_poll_endpoint_opts, data)
  end

  @type list_clusters_opts :: [
    {:max_results, 1..100} |
    {:next_token, binary}
  ]

  @doc """
  Returns a list of existing clusters.
  """
  @spec list_clusters() :: ExAws.Operation.JSON.t
  @spec list_clusters(opts :: list_clusters_opts) :: ExAws.Operation.JSON.t
  def list_clusters(opts \\ []) do
    data = opts
    |> normalize_opts
    request(:list_clusters, data)
  end

  @type list_container_instances_opts :: [
    {:cluster, binary} |
    {:max_results, 1..100} |
    {:next_token, binary}
  ]

  @doc """
  Returns a list of container instances in a specified cluster.
  """
  @spec list_container_instances() :: ExAws.Operation.JSON.t
  @spec list_container_instances(opts :: list_container_instances_opts) :: ExAws.Operation.JSON.t
  def list_container_instances(opts \\ []) do
    data = opts
    |> normalize_opts
    request(:list_container_instances, data)
  end

  @type list_services_opts :: [
    {:cluster, binary} |
    {:max_results, 1..10} |
    {:next_token, binary}
  ]
  @doc """
  Lists the services that are running in a specified cluster.
  """
  @spec list_services() :: ExAws.Operation.JSON.t
  @spec list_services(opts :: list_services_opts) :: ExAws.Operation.JSON.t
  def list_services(opts \\ []) do
    data = opts
    |> normalize_opts
    request(:list_services, data)
  end

  @type list_task_definition_families_opts :: [
    {:family_prefix, binary} |
    {:max_results, 1..100} |
    {:next_token, binary} |
    {:status, binary}
  ]
  @doc """
  Returns a list of task definition families that are registered to your
  account (which may include task definition families that no longer have any
  `ACTIVE` task definition revisions).

  You can filter out task definition families that do not contain any
  `ACTIVE` task definition revisions by setting the `status` parameter to
  `ACTIVE`. You can also filter the results with the `familyPrefix`
  parameter.
  """
  @spec list_task_definition_families() :: ExAws.Operation.JSON.t
  @spec list_task_definition_families(opts :: list_task_definition_families_opts) :: ExAws.Operation.JSON.t
  def list_task_definition_families(opts \\ []) do
    data = opts
    |> normalize_opts
    request(:list_task_definition_families, data)
  end

  @type list_task_definitions_opts :: [
    {:family_prefix, binary} |
    {:max_results, 1..100} |
    {:next_token, binary} |
    {:sort, binary} |
    {:status, binary}
  ]
  @doc """
  Returns a list of task definitions that are registered to your account. You
  can filter the results by family name with the `familyPrefix` parameter or
  by status with the `status` parameter.
  """
  @spec list_task_definitions() :: ExAws.Operation.JSON.t
  @spec list_task_definitions(opts :: list_task_definitions_opts) :: ExAws.Operation.JSON.t
  def list_task_definitions(opts \\ []) do
    data = opts
    |> normalize_opts
    request(:list_task_definitions, data)
  end

  @type list_tasks_opts :: [
    {:cluster, binary} |
    {:container_instance, binary} |
    {:desired_status, binary} |
    {:family, binary} |
    {:max_results, 1..100} |
    {:next_token, binary} |
    {:service_name, binary} |
    {:started_by, binary}
  ]
  @doc """
  Returns a list of tasks for a specified cluster. You can filter the results
  by family name, by a particular container instance, or by the desired
  status of the task with the `family`, `containerInstance`, and
  `desiredStatus` parameters.

  Recently-stopped tasks might appear in the returned results. Currently,
  stopped tasks appear in the returned results for at least one hour.
  """
  @spec list_tasks() :: ExAws.Operation.JSON.t
  @spec list_tasks(opts :: list_tasks_opts) :: ExAws.Operation.JSON.t
  def list_tasks(opts \\ []) do
    data = opts
    |> normalize_opts
    request(:list_tasks, data)
  end

  @doc """
  <note> This action is only used by the Amazon EC2 Container Service agent,
  and it is not intended for use outside of the agent.

  </note> Registers an EC2 instance into the specified cluster. This instance
  becomes available to place containers on.
  """
  @spec register_container_instance() :: ExAws.Operation.JSON.t
  @spec register_container_instance(opts :: Keyword.t) :: ExAws.Operation.JSON.t
  def register_container_instance(opts \\ []) do
    data = opts
    |> normalize_opts

    request(:register_container_instance, data)
  end

  # http://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_KeyValuePair.html
  @type key_value_pair :: [
    {:name, binary} |
    {:value, binary}
  ]

  # http://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_HostEntry.html
  @type host_entry :: [
    {:hostname, binary} |
    {:ip_address, binary}
  ]
  # http://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_RegisterTaskDefinition.html
  @type log_drivers :: [
    :"json-file" |
    :syslog |
    :journald |
    :gelf |
    :fluentd |
    :awslogs |
    :splunk
  ]
  @type log_configuration :: [
    {:log_driver, log_drivers} |
    {:options, map}
  ]

  # http://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_MountPoint.html
  @type mount_point :: [
    {:container_path, binary} |
    {:read_only, boolean} |
    {:source_volume, binary}
  ]

  # http://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_PortMapping.html
  @type protocols :: [
    :tcp |
    :udp
  ]
  @type port_mapping :: [
    {:container_port, 1..65535} |
    {:host_port, 0..65535} |
    {:protocol, protocols}
  ]

  # http://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_Ulimit.html
  @type ulimit :: [
    {:hard_limit, pos_integer} |
    {:name, binary} |
    {:soft_limit, pos_integer}
  ]

  # http://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_VolumeFrom.html
  @type volume_from :: [
    {:read_only, boolean} |
    {:source_container, binary}
  ]

  # http://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ContainerDefinition.html
  @type container_definition :: [
    {:command, list(binary)} |
    {:cpu, pos_integer} |
    {:disable_networking, boolean} |
    {:dns_search_domains, list(binary)} |
    {:dns_servers, list(binary)} |
    {:docker_labels, map} |
    {:docker_security_options, list(binary)} |
    {:entry_point, list(binary)} |
    {:environment, list(key_value_pair)} |
    {:essential, boolean} |
    {:extra_hosts, list(host_entry)} |
    {:hostname, binary} |
    {:image, binary} |
    {:links, list(binary)} |
    {:log_configuration, log_configuration} |
    {:memory, pos_integer} |
    {:memory_reservation, pos_integer} |
    {:mount_points, list(mount_point)} |
    {:name, binary} |
    {:port_mappings, list(port_mapping)} |
    {:privileged, boolean} |
    {:readonly_root_filesystem, boolean} |
    {:ulimits, list(ulimit)} |
    {:user, binary} |
    {:volumes_from, list(volume_from)} |
    {:working_directory, binary}
  ]

  # http://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_HostVolumeProperties.html
  @type host_volume_properties :: [
    {:source_path, binary}
  ]

  @type network_modes :: [
    :bridge |
    :host |
    :none
  ]

  # http://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_Volume.html
  @type volume :: [
    {:host, host_volume_properties} |
    {:name, binary}
  ]

  @type register_task_definition_opts :: [
    {:network_mode, network_modes} |
    {:task_role_arn, binary} |
    {:volumes, list(volume)}
  ]
  @doc """
  Registers a new task definition from the supplied `family` and
  `containerDefinitions`. Optionally, you can add data volumes to your
  containers with the `volumes` parameter. For more information about task
  definition parameters and defaults, see [Amazon ECS Task
  Definitions](http://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_defintions.html)
  in the *Amazon EC2 Container Service Developer Guide*.

  You may also specify an IAM role for your task with the `taskRoleArn`
  parameter. When you specify an IAM role for a task, its containers can then
  use the latest versions of the AWS CLI or SDKs to make API requests to the
  AWS services that are specified in the IAM policy associated with the role.
  For more information, see [IAM Roles for
  Tasks](http://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-iam-roles.html)
  in the *Amazon EC2 Container Service Developer Guide*.
  """
  @spec register_task_definition(container_definitions :: list(container_definition), family :: binary, opts :: register_task_definition_opts) :: ExAws.Operation.JSON.t
  def register_task_definition(container_definitions, family, opts \\ []) do
    required = %{
      "containerDefinitions" => pascalize_keys(container_definitions),
      "family" => family}
    data = opts
    |> normalize_opts
    |> Map.merge(required)

    request(:register_task_definition, data)
  end

  # http://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ContainerOverride.html
  @type container_override :: [
    {:command, list(binary)} |
    {:environment, list(key_value_pair)} |
    {:name, binary}
  ]
  #http://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_TaskOverride.html
  @type task_override :: [
    {:container_overrides, list(container_override)} |
    {:task_role_arn, binary}
  ]
  # http://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_RunTask.html
  @type run_task_opts :: [
    {:cluster, binary} |
    {:count, 1..10} |
    {:overrides, task_override} |
    {:started_by, binary}
  ]
  @doc """
  Start a task using random placement and the default Amazon ECS scheduler.
  To use your own scheduler or place a task on a specific container instance,
  use `StartTask` instead.

  <important> The `count` parameter is limited to 10 tasks per call.

  </important>
  """
  @spec run_task(task_definition :: binary) :: ExAws.Operation.JSON.t
  @spec run_task(task_definition :: binary, opts :: run_task_opts) :: ExAws.Operation.JSON.t
  def run_task(task_definition, opts \\ []) do
    data = opts
    |> normalize_opts
    |> Map.merge(%{"taskDefinition" => task_definition})
    request(:run_task, data)
  end

  # http://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_StartTask.html
  @type start_task_opts :: [
    {:cluster, binary} |
    {:overrides, task_override} |
    {:started_by, binary}
  ]

  @doc """
  Starts a new task from the specified task definition on the specified
  container instance or instances. To use the default Amazon ECS scheduler to
  place your task, use `RunTask` instead.

  <important> The list of container instances to start tasks on is limited to
  10.

  </important>
  """
  @spec start_task(task_definition :: binary, container_instances :: nonempty_list(binary)) :: ExAws.Operation.JSON.t
  @spec start_task(task_definition :: binary, container_instances :: nonempty_list(binary), opts :: start_task_opts) :: ExAws.Operation.JSON.t
  def start_task(task_definition, container_instances, opts \\ []) do
    data = opts
    |> normalize_opts
    |> Map.merge(%{"taskDefinition" => task_definition, "containerInstances" => container_instances})
    request(:start_task, data)
  end

  # http://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_StopTask.html
  @type stop_task_opts :: [
    {:cluster, binary} |
    {:reason, binary}
  ]
  @doc """
  Stops a running task.

  When `StopTask` is called on a task, the equivalent of `docker stop` is
  issued to the containers running in the task. This results in a `SIGTERM`
  and a 30-second timeout, after which `SIGKILL` is sent and the containers
  are forcibly stopped. If the container handles the `SIGTERM` gracefully and
  exits within 30 seconds from receiving it, no `SIGKILL` is sent.
  """
  @spec stop_task(task :: binary) :: ExAws.Operation.JSON.t
  @spec stop_task(task :: binary, opts :: stop_task_opts) :: ExAws.Operation.JSON.t
  def stop_task(task, opts \\ []) do
    data = opts
    |> normalize_opts
    |> Map.merge(%{"task" => task})
    request(:stop_task, data)
  end

  @doc """
  <note> This action is only used by the Amazon EC2 Container Service agent,
  and it is not intended for use outside of the agent.

  </note> Sent to acknowledge that a container changed states.
  """
  @spec submit_container_state_change() :: ExAws.Operation.JSON.t
  @spec submit_container_state_change(opts :: Keyword.t) :: ExAws.Operation.JSON.t
  def submit_container_state_change(opts \\ []) do
    data = opts
    |> normalize_opts
    request(:submit_container_state_change, data)
  end

  @doc """
  <note> This action is only used by the Amazon EC2 Container Service agent,
  and it is not intended for use outside of the agent.

  </note> Sent to acknowledge that a task changed states.
  """
  @spec submit_task_state_change() :: ExAws.Operation.JSON.t
  @spec submit_task_state_change(opts :: Keyword.t) :: ExAws.Operation.JSON.t
  def submit_task_state_change(opts \\ []) do
    data = opts
    |> normalize_opts
    request(:submit_task_state_change, data)
  end

  @doc """
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
  @spec update_container_agent(container_instance :: binary) :: ExAws.Operation.JSON.t
  def update_container_agent(container_instance) do
    data = %{"containerInstance" => container_instance}
    request(:update_container_agent, data)
  end
  @spec update_container_agent(container_instance :: binary, cluster :: binary) :: ExAws.Operation.JSON.t
  def update_container_agent(container_instance, cluster) do
    data = %{"containerInstance" => container_instance, "cluster" => cluster}
    request(:update_container_agent, data)
  end

  @type deployment_conf :: [
    {:maximum_percent, pos_integer} |
    {:minimum_healthy_percent, pos_integer}
  ]

  @type update_service_opts :: [
    {:cluster, binary} |
    {:deployment_configuration, deployment_conf} |
    {:desired_count, pos_integer} |
    {:task_definition, binary}
  ]
  @doc """
  Modifies the desired count, deployment configuration, or task definition
  used in a service.

  You can add to or subtract from the number of instantiations of a task
  definition in a service by specifying the cluster that the service is
  running in and a new `desiredCount` parameter.

  You can use `UpdateService` to modify your task definition and deploy a new
  version of your service.

  You can also update the deployment configuration of a service. When a
  deployment is triggered by updating the task definition of a service, the
  service scheduler uses the deployment configuration parameters,
  `minimumHealthyPercent` and `maximumPercent`, to determine the deployment
  strategy.

  If the `minimumHealthyPercent` is below 100%, the scheduler can ignore the
  `desiredCount` temporarily during a deployment. For example, if your
  service has a `desiredCount` of four tasks, a `minimumHealthyPercent` of
  50% allows the scheduler to stop two existing tasks before starting two new
  tasks. Tasks for services that *do not* use a load balancer are considered
  healthy if they are in the `RUNNING` state; tasks for services that *do*
  use a load balancer are considered healthy if they are in the `RUNNING`
  state and the container instance it is hosted on is reported as healthy by
  the load balancer.

  The `maximumPercent` parameter represents an upper limit on the number of
  running tasks during a deployment, which enables you to define the
  deployment batch size. For example, if your service has a `desiredCount` of
  four tasks, a `maximumPercent` value of 200% starts four new tasks before
  stopping the four older tasks (provided that the cluster resources required
  to do this are available).

  When `UpdateService` stops a task during a deployment, the equivalent of
  `docker stop` is issued to the containers running in the task. This results
  in a `SIGTERM` and a 30-second timeout, after which `SIGKILL` is sent and
  the containers are forcibly stopped. If the container handles the `SIGTERM`
  gracefully and exits within 30 seconds from receiving it, no `SIGKILL` is
  sent.

  When the service scheduler launches new tasks, it attempts to balance them
  across the Availability Zones in your cluster with the following logic:

  <ul> <li> Determine which of the container instances in your cluster can
  support your service's task definition (for example, they have the required
  CPU, memory, ports, and container instance attributes).

  </li> <li> Sort the valid container instances by the fewest number of
  running tasks for this service in the same Availability Zone as the
  instance. For example, if zone A has one running service task and zones B
  and C each have zero, valid container instances in either zone B or C are
  considered optimal for placement.

  </li> <li> Place the new service task on a valid container instance in an
  optimal Availability Zone (based on the previous steps), favoring container
  instances with the fewest number of running tasks for this service.

  </li> </ul>
  """
  @spec update_service(service :: binary, opts :: update_service_opts) :: ExAws.Operation.JSON.t
  def update_service(service, opts \\ []) do
    data = opts
    |> normalize_opts
    |> Map.merge(%{"service" => service})
    request(:update_service, data)
  end


  ## Private parts

  # Pascalize has room for improvements.. but it seems to work

  defp pascalize_keys(opts) when is_map(opts) do
    opts
    |> Enum.map(&pascalize_single_key/1)
    |> Enum.into(%{})
  end
  defp pascalize_keys([]), do: []
  defp pascalize_keys([head | tail]) do
    [pascalize_keys(head)] ++ pascalize_keys(tail)
  end
  defp pascalize_keys(bool) when is_boolean(bool), do: bool
  defp pascalize_keys(atom) when is_atom(atom), do: Atom.to_string(atom)
  defp pascalize_keys(other), do: other

  defp pascalize_single_key({k, v}) when is_binary(k) do
    value = pascalize_keys(v)
    {k, value}
  end
  defp pascalize_single_key({k, v}) when is_atom(k) do
    key = k |> Atom.to_string |> pascalize_word
    value = pascalize_keys(v)
    {key, value}
  end

  # Many thanks to https://github.com/nurugger07/inflex
  # https://github.com/nurugger07/inflex/blob/v1.4.1/lib/inflex/camelize.ex
  defp pascalize_word(word) do
    case Regex.split(~r/(?:^|[-_])|(?=[A-Z])/, to_string(word)) do
      words -> words |> pascalize_list(:lower)
                     |> Enum.join
    end
  end

  defp pascalize_list([], :upper), do: []
  defp pascalize_list([h|tail], :lower) do
    [lowercase(h)] ++ pascalize_list(tail, :upper)
  end
  defp pascalize_list([h|tail], :upper) do
    [capitalize(h)] ++ pascalize_list(tail, :upper)
  end

  defp capitalize(word), do: String.capitalize(word)
  defp lowercase(word), do: String.downcase(word)

  defp normalize_opts(opts) do
    opts
    |> Enum.into(%{})
    |> pascalize_keys
  end

  defp request(action), do: request(action, %{})
  defp request(action, data, opts \\ %{}) do
    operation =
      action
      |> Atom.to_string
      |> Macro.camelize

    ExAws.Operation.JSON.new(:ecs, %{
      data: data,
      headers: [
        {"x-amz-target", "#{@namespace}.#{operation}"},
        {"content-type", "application/x-amz-json-1.1"}
      ]
    } |> Map.merge(opts))
  end

end
