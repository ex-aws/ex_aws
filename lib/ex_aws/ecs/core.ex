defmodule ExAws.Ecs.Core do
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


  @doc """
  CreateCluster

  Creates a new Amazon ECS cluster. By default, your account will receive a
  `default` cluster when you launch your first container instance. However,
  you can create your own cluster with a unique name with the `CreateCluster`
  action.
  """
  def create_cluster(client, input) do
    request(client, "CreateCluster", input)
  end

  @doc """
  CreateService

  Runs and maintains a desired number of tasks from a specified task
  definition. If the number of tasks running in a service drops below
  `desiredCount`, Amazon ECS will spawn another instantiation of the task in
  the specified cluster.
  """
  def create_service(client, input) do
    request(client, "CreateService", input)
  end

  @doc """
  DeleteCluster

  Deletes the specified cluster. You must deregister all container instances
  from this cluster before you may delete it. You can list the container
  instances in a cluster with `ListContainerInstances` and deregister them
  with `DeregisterContainerInstance`.
  """
  def delete_cluster(client, input) do
    request(client, "DeleteCluster", input)
  end

  @doc """
  DeleteService

  Deletes a specified service within a cluster.
  """
  def delete_service(client, input) do
    request(client, "DeleteService", input)
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
  def deregister_container_instance(client, input) do
    request(client, "DeregisterContainerInstance", input)
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
  def deregister_task_definition(client, input) do
    request(client, "DeregisterTaskDefinition", input)
  end

  @doc """
  DescribeClusters

  Describes one or more of your clusters.
  """
  def describe_clusters(client, input) do
    request(client, "DescribeClusters", input)
  end

  @doc """
  DescribeContainerInstances

  Describes Amazon EC2 Container Service container instances. Returns
  metadata about registered and remaining resources on each container
  instance requested.
  """
  def describe_container_instances(client, input) do
    request(client, "DescribeContainerInstances", input)
  end

  @doc """
  DescribeServices

  Describes the specified services running in your cluster.
  """
  def describe_services(client, input) do
    request(client, "DescribeServices", input)
  end

  @doc """
  DescribeTaskDefinition

  Describes a task definition. You can specify a `family` and `revision` to
  find information on a specific task definition, or you can simply specify
  the family to find the latest `ACTIVE` revision in that family.

  Note: You can only describe `INACTIVE` task definitions while an active
  task or service references them.
  """
  def describe_task_definition(client, input) do
    request(client, "DescribeTaskDefinition", input)
  end

  @doc """
  DescribeTasks

  Describes a specified task or tasks.
  """
  def describe_tasks(client, input) do
    request(client, "DescribeTasks", input)
  end

  @doc """
  DiscoverPollEndpoint

  Note:This action is only used by the Amazon EC2 Container Service agent,
  and it is not intended for use outside of the agent.

  Returns an endpoint for the Amazon EC2 Container Service agent to poll for
  updates.
  """
  def discover_poll_endpoint(client, input) do
    request(client, "DiscoverPollEndpoint", input)
  end

  @doc """
  ListClusters

  Returns a list of existing clusters.
  """
  def list_clusters(client, input) do
    request(client, "ListClusters", input)
  end

  @doc """
  ListContainerInstances

  Returns a list of container instances in a specified cluster.
  """
  def list_container_instances(client, input) do
    request(client, "ListContainerInstances", input)
  end

  @doc """
  ListServices

  Lists the services that are running in a specified cluster.
  """
  def list_services(client, input) do
    request(client, "ListServices", input)
  end

  @doc """
  ListTaskDefinitionFamilies

  Returns a list of task definition families that are registered to your
  account (which may include task definition families that no longer have any
  `ACTIVE` task definitions). You can filter the results with the
  `familyPrefix` parameter.
  """
  def list_task_definition_families(client, input) do
    request(client, "ListTaskDefinitionFamilies", input)
  end

  @doc """
  ListTaskDefinitions

  Returns a list of task definitions that are registered to your account. You
  can filter the results by family name with the `familyPrefix` parameter or
  by status with the `status` parameter.
  """
  def list_task_definitions(client, input) do
    request(client, "ListTaskDefinitions", input)
  end

  @doc """
  ListTasks

  Returns a list of tasks for a specified cluster. You can filter the results
  by family name, by a particular container instance, or by the desired
  status of the task with the `family`, `containerInstance`, and
  `desiredStatus` parameters.
  """
  def list_tasks(client, input) do
    request(client, "ListTasks", input)
  end

  @doc """
  RegisterContainerInstance

  Note:This action is only used by the Amazon EC2 Container Service agent,
  and it is not intended for use outside of the agent.

  Registers an Amazon EC2 instance into the specified cluster. This instance
  will become available to place containers on.
  """
  def register_container_instance(client, input) do
    request(client, "RegisterContainerInstance", input)
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
  def register_task_definition(client, input) do
    request(client, "RegisterTaskDefinition", input)
  end

  @doc """
  RunTask

  Start a task using random placement and the default Amazon ECS scheduler.
  If you want to use your own scheduler or place a task on a specific
  container instance, use `StartTask` instead.

  <important> The `count` parameter is limited to 10 tasks per call.

  </important>
  """
  def run_task(client, input) do
    request(client, "RunTask", input)
  end

  @doc """
  StartTask

  Starts a new task from the specified task definition on the specified
  container instance or instances. If you want to use the default Amazon ECS
  scheduler to place your task, use `RunTask` instead.

  <important> The list of container instances to start tasks on is limited to
  10.

  </important>
  """
  def start_task(client, input) do
    request(client, "StartTask", input)
  end

  @doc """
  StopTask

  Stops a running task.
  """
  def stop_task(client, input) do
    request(client, "StopTask", input)
  end

  @doc """
  SubmitContainerStateChange

  Note:This action is only used by the Amazon EC2 Container Service agent,
  and it is not intended for use outside of the agent.

  Sent to acknowledge that a container changed states.
  """
  def submit_container_state_change(client, input) do
    request(client, "SubmitContainerStateChange", input)
  end

  @doc """
  SubmitTaskStateChange

  Note:This action is only used by the Amazon EC2 Container Service agent,
  and it is not intended for use outside of the agent.

  Sent to acknowledge that a task changed states.
  """
  def submit_task_state_change(client, input) do
    request(client, "SubmitTaskStateChange", input)
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
  def update_container_agent(client, input) do
    request(client, "UpdateContainerAgent", input)
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
  def update_service(client, input) do
    request(client, "UpdateService", input)
  end


  defp request(%{__struct__: client_module} = client, action, input) do
    client_module.request(client, action, input)
  end
end
