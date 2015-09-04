defmodule ExAws.ElasticMapReduce.Core do
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


  @doc """
  AddInstanceGroups

  AddInstanceGroups adds an instance group to a running cluster.
  """
  def add_instance_groups(client, input) do
    request(client, "AddInstanceGroups", input)
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
  def add_job_flow_steps(client, input) do
    request(client, "AddJobFlowSteps", input)
  end

  @doc """
  AddTags

  Adds tags to an Amazon EMR resource. Tags make it easier to associate
  clusters in various ways, such as grouping clusters to track your Amazon
  EMR resource allocation costs. For more information, see [Tagging Amazon
  EMR
  Resources](http://docs.aws.amazon.com/ElasticMapReduce/latest/DeveloperGuide/emr-plan-tags.html).
  """
  def add_tags(client, input) do
    request(client, "AddTags", input)
  end

  @doc """
  DescribeCluster

  Provides cluster-level details including status, hardware and software
  configuration, VPC settings, and so on. For information about the cluster
  steps, see `ListSteps`.
  """
  def describe_cluster(client, input) do
    request(client, "DescribeCluster", input)
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

  <ul> <li>Job flows created and completed in the last two weeks</li> <li>
  Job flows created within the last two months that are in one of the
  following states: `RUNNING`, `WAITING`, `SHUTTING_DOWN`, `STARTING` </li>
  </ul> Amazon Elastic MapReduce can return a maximum of 512 job flow
  descriptions.
  """
  def describe_job_flows(client, input) do
    request(client, "DescribeJobFlows", input)
  end

  @doc """
  DescribeStep

  Provides more detail about the cluster step.
  """
  def describe_step(client, input) do
    request(client, "DescribeStep", input)
  end

  @doc """
  ListBootstrapActions

  Provides information about the bootstrap actions associated with a cluster.
  """
  def list_bootstrap_actions(client, input) do
    request(client, "ListBootstrapActions", input)
  end

  @doc """
  ListClusters

  Provides the status of all clusters visible to this AWS account. Allows you
  to filter the list of clusters based on certain criteria; for example,
  filtering by cluster creation date and time or by status. This call returns
  a maximum of 50 clusters per call, but returns a marker to track the paging
  of the cluster list across multiple ListClusters calls.
  """
  def list_clusters(client, input) do
    request(client, "ListClusters", input)
  end

  @doc """
  ListInstanceGroups

  Provides all available details about the instance groups in a cluster.
  """
  def list_instance_groups(client, input) do
    request(client, "ListInstanceGroups", input)
  end

  @doc """
  ListInstances

  Provides information about the cluster instances that Amazon EMR provisions
  on behalf of a user when it creates the cluster. For example, this
  operation indicates when the EC2 instances reach the Ready state, when
  instances become available to Amazon EMR to use for jobs, and the IP
  addresses for cluster instances, etc.
  """
  def list_instances(client, input) do
    request(client, "ListInstances", input)
  end

  @doc """
  ListSteps

  Provides a list of steps for the cluster.
  """
  def list_steps(client, input) do
    request(client, "ListSteps", input)
  end

  @doc """
  ModifyInstanceGroups

  ModifyInstanceGroups modifies the number of nodes and configuration
  settings of an instance group. The input parameters include the new target
  instance count for the group and the instance group ID. The call will
  either succeed or fail atomically.
  """
  def modify_instance_groups(client, input) do
    request(client, "ModifyInstanceGroups", input)
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
  def remove_tags(client, input) do
    request(client, "RemoveTags", input)
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
  def run_job_flow(client, input) do
    request(client, "RunJobFlow", input)
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
  def set_termination_protection(client, input) do
    request(client, "SetTerminationProtection", input)
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
  def set_visible_to_all_users(client, input) do
    request(client, "SetVisibleToAllUsers", input)
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
  def terminate_job_flows(client, input) do
    request(client, "TerminateJobFlows", input)
  end


  defp request(%{__struct__: client_module} = client, action, input) do
    client_module.request(client, action, input)
  end
end
