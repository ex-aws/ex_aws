defmodule ExAws.OpsWorks.Core do
  @actions [
    "AssignInstance",
    "AssignVolume",
    "AssociateElasticIp",
    "AttachElasticLoadBalancer",
    "CloneStack",
    "CreateApp",
    "CreateDeployment",
    "CreateInstance",
    "CreateLayer",
    "CreateStack",
    "CreateUserProfile",
    "DeleteApp",
    "DeleteInstance",
    "DeleteLayer",
    "DeleteStack",
    "DeleteUserProfile",
    "DeregisterEcsCluster",
    "DeregisterElasticIp",
    "DeregisterInstance",
    "DeregisterRdsDbInstance",
    "DeregisterVolume",
    "DescribeAgentVersions",
    "DescribeApps",
    "DescribeCommands",
    "DescribeDeployments",
    "DescribeEcsClusters",
    "DescribeElasticIps",
    "DescribeElasticLoadBalancers",
    "DescribeInstances",
    "DescribeLayers",
    "DescribeLoadBasedAutoScaling",
    "DescribeMyUserProfile",
    "DescribePermissions",
    "DescribeRaidArrays",
    "DescribeRdsDbInstances",
    "DescribeServiceErrors",
    "DescribeStackProvisioningParameters",
    "DescribeStackSummary",
    "DescribeStacks",
    "DescribeTimeBasedAutoScaling",
    "DescribeUserProfiles",
    "DescribeVolumes",
    "DetachElasticLoadBalancer",
    "DisassociateElasticIp",
    "GetHostnameSuggestion",
    "GrantAccess",
    "RebootInstance",
    "RegisterEcsCluster",
    "RegisterElasticIp",
    "RegisterInstance",
    "RegisterRdsDbInstance",
    "RegisterVolume",
    "SetLoadBasedAutoScaling",
    "SetPermission",
    "SetTimeBasedAutoScaling",
    "StartInstance",
    "StartStack",
    "StopInstance",
    "StopStack",
    "UnassignInstance",
    "UnassignVolume",
    "UpdateApp",
    "UpdateElasticIp",
    "UpdateInstance",
    "UpdateLayer",
    "UpdateMyUserProfile",
    "UpdateRdsDbInstance",
    "UpdateStack",
    "UpdateUserProfile",
    "UpdateVolume"]

  @moduledoc """
  ## AWS OpsWorks

  AWS OpsWorks

  Welcome to the *AWS OpsWorks API Reference*. This guide provides
  descriptions, syntax, and usage examples about AWS OpsWorks actions and
  data types, including common parameters and error codes.

  AWS OpsWorks is an application management service that provides an
  integrated experience for overseeing the complete application lifecycle.
  For information about this product, go to the [AWS
  OpsWorks](http://aws.amazon.com/opsworks/) details page.

  **SDKs and CLI**

  The most common way to use the AWS OpsWorks API is by using the AWS Command
  Line Interface (CLI) or by using one of the AWS SDKs to implement
  applications in your preferred language. For more information, see:

  <ul> <li> [AWS
  CLI](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html)
  </li> <li> [AWS SDK for
  Java](http://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/services/opsworks/AWSOpsWorksClient.html)
  </li> <li> [AWS SDK for
  .NET](http://docs.aws.amazon.com/sdkfornet/latest/apidocs/html/N_Amazon_OpsWorks.htm)
  </li> <li> [AWS SDK for PHP
  2](http://docs.aws.amazon.com/aws-sdk-php-2/latest/class-Aws.OpsWorks.OpsWorksClient.html)
  </li> <li> [AWS SDK for
  Ruby](http://docs.aws.amazon.com/AWSRubySDK/latest/AWS/OpsWorks/Client.html)
  </li> <li> [AWS SDK for
  Node.js](http://aws.amazon.com/documentation/sdkforjavascript/) </li> <li>
  [AWS SDK for
  Python(Boto)](http://docs.pythonboto.org/en/latest/ref/opsworks.html) </li>
  </ul> **Endpoints**

  AWS OpsWorks supports only one endpoint, opsworks.us-east-1.amazonaws.com
  (HTTPS), so you must connect to that endpoint. You can then use the API to
  direct AWS OpsWorks to create stacks in any AWS Region.

  **Chef Versions**

  When you call `CreateStack`, `CloneStack`, or `UpdateStack` we recommend
  you use the `ConfigurationManager` parameter to specify the Chef version.
  The recommended value for Linux stacks, which is also the default value, is
  currently 11.10. Windows stacks use Chef 12.2. For more information, see
  [Chef
  Versions](http://docs.aws.amazon.com/opsworks/latest/userguide/workingcookbook-chef11.html).

  Note:You can also specify Chef 11.4 or Chef 0.9 for your Linux stack.
  However, Chef 0.9 has been deprecated. We do not recommend using Chef 0.9
  for new stacks, and we recommend migrating your existing Chef 0.9 stacks to
  Chef 11.10 as soon as possible.
  """


  @doc """
  AssignInstance

  Assign a registered instance to a layer.

  <ul> <li>You can assign registered on-premises instances to any layer
  type.</li> <li>You can assign registered Amazon EC2 instances only to
  custom layers.</li> <li>You cannot use this action with instances that were
  created with AWS OpsWorks.</li> </ul> **Required Permissions**: To use this
  action, an AWS Identity and Access Management (IAM) user must have a Manage
  permissions level for the stack or an attached policy that explicitly
  grants permissions. For more information on user permissions, see [Managing
  User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def assign_instance(client, input) do
    request(client, "AssignInstance", input)
  end

  @doc """
  AssignVolume

  Assigns one of the stack's registered Amazon EBS volumes to a specified
  instance. The volume must first be registered with the stack by calling
  `RegisterVolume`. After you register the volume, you must call
  `UpdateVolume` to specify a mount point before calling `AssignVolume`. For
  more information, see [Resource
  Management](http://docs.aws.amazon.com/opsworks/latest/userguide/resources.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def assign_volume(client, input) do
    request(client, "AssignVolume", input)
  end

  @doc """
  AssociateElasticIp

  Associates one of the stack's registered Elastic IP addresses with a
  specified instance. The address must first be registered with the stack by
  calling `RegisterElasticIp`. For more information, see [Resource
  Management](http://docs.aws.amazon.com/opsworks/latest/userguide/resources.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def associate_elastic_ip(client, input) do
    request(client, "AssociateElasticIp", input)
  end

  @doc """
  AttachElasticLoadBalancer

  Attaches an Elastic Load Balancing load balancer to a specified layer. For
  more information, see [Elastic Load
  Balancing](http://docs.aws.amazon.com/opsworks/latest/userguide/load-balancer-elb.html).

  Note: You must create the Elastic Load Balancing instance separately, by
  using the Elastic Load Balancing console, API, or CLI. For more
  information, see [ Elastic Load Balancing Developer
  Guide](http://docs.aws.amazon.com/ElasticLoadBalancing/latest/DeveloperGuide/Welcome.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def attach_elastic_load_balancer(client, input) do
    request(client, "AttachElasticLoadBalancer", input)
  end

  @doc """
  CloneStack

  Creates a clone of a specified stack. For more information, see [Clone a
  Stack](http://docs.aws.amazon.com/opsworks/latest/userguide/workingstacks-cloning.html).
  By default, all parameters are set to the values used by the parent stack.

  **Required Permissions**: To use this action, an IAM user must have an
  attached policy that explicitly grants permissions. For more information on
  user permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def clone_stack(client, input) do
    request(client, "CloneStack", input)
  end

  @doc """
  CreateApp

  Creates an app for a specified stack. For more information, see [Creating
  Apps](http://docs.aws.amazon.com/opsworks/latest/userguide/workingapps-creating.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def create_app(client, input) do
    request(client, "CreateApp", input)
  end

  @doc """
  CreateDeployment

  Runs deployment or stack commands. For more information, see [Deploying
  Apps](http://docs.aws.amazon.com/opsworks/latest/userguide/workingapps-deploying.html)
  and [Run Stack
  Commands](http://docs.aws.amazon.com/opsworks/latest/userguide/workingstacks-commands.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Deploy or Manage permissions level for the stack, or an attached policy
  that explicitly grants permissions. For more information on user
  permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def create_deployment(client, input) do
    request(client, "CreateDeployment", input)
  end

  @doc """
  CreateInstance

  Creates an instance in a specified stack. For more information, see [Adding
  an Instance to a
  Layer](http://docs.aws.amazon.com/opsworks/latest/userguide/workinginstances-add.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def create_instance(client, input) do
    request(client, "CreateInstance", input)
  end

  @doc """
  CreateLayer

  Creates a layer. For more information, see [How to Create a
  Layer](http://docs.aws.amazon.com/opsworks/latest/userguide/workinglayers-basics-create.html).

  Note: You should use **CreateLayer** for noncustom layer types such as PHP
  App Server only if the stack does not have an existing layer of that type.
  A stack can have at most one instance of each noncustom layer; if you
  attempt to create a second instance, **CreateLayer** fails. A stack can
  have an arbitrary number of custom layers, so you can call **CreateLayer**
  as many times as you like for that layer type.

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def create_layer(client, input) do
    request(client, "CreateLayer", input)
  end

  @doc """
  CreateStack

  Creates a new stack. For more information, see [Create a New
  Stack](http://docs.aws.amazon.com/opsworks/latest/userguide/workingstacks-edit.html).

  **Required Permissions**: To use this action, an IAM user must have an
  attached policy that explicitly grants permissions. For more information on
  user permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def create_stack(client, input) do
    request(client, "CreateStack", input)
  end

  @doc """
  CreateUserProfile

  Creates a new user profile.

  **Required Permissions**: To use this action, an IAM user must have an
  attached policy that explicitly grants permissions. For more information on
  user permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def create_user_profile(client, input) do
    request(client, "CreateUserProfile", input)
  end

  @doc """
  DeleteApp

  Deletes a specified app.

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def delete_app(client, input) do
    request(client, "DeleteApp", input)
  end

  @doc """
  DeleteInstance

  Deletes a specified instance, which terminates the associated Amazon EC2
  instance. You must stop an instance before you can delete it.

  For more information, see [Deleting
  Instances](http://docs.aws.amazon.com/opsworks/latest/userguide/workinginstances-delete.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def delete_instance(client, input) do
    request(client, "DeleteInstance", input)
  end

  @doc """
  DeleteLayer

  Deletes a specified layer. You must first stop and then delete all
  associated instances or unassign registered instances. For more
  information, see [How to Delete a
  Layer](http://docs.aws.amazon.com/opsworks/latest/userguide/workinglayers-basics-delete.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def delete_layer(client, input) do
    request(client, "DeleteLayer", input)
  end

  @doc """
  DeleteStack

  Deletes a specified stack. You must first delete all instances, layers, and
  apps or deregister registered instances. For more information, see [Shut
  Down a
  Stack](http://docs.aws.amazon.com/opsworks/latest/userguide/workingstacks-shutting.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def delete_stack(client, input) do
    request(client, "DeleteStack", input)
  end

  @doc """
  DeleteUserProfile

  Deletes a user profile.

  **Required Permissions**: To use this action, an IAM user must have an
  attached policy that explicitly grants permissions. For more information on
  user permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def delete_user_profile(client, input) do
    request(client, "DeleteUserProfile", input)
  end

  @doc """
  DeregisterEcsCluster

  Deregisters a specified Amazon ECS cluster from a stack. For more
  information, see [ Resource
  Management](http://docs.aws.amazon.com/opsworks/latest/userguide/workinglayers-ecscluster.html#workinglayers-ecscluster-delete).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see <a
  href="http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html">`.
  """
  def deregister_ecs_cluster(client, input) do
    request(client, "DeregisterEcsCluster", input)
  end

  @doc """
  DeregisterElasticIp

  Deregisters a specified Elastic IP address. The address can then be
  registered by another stack. For more information, see [Resource
  Management](http://docs.aws.amazon.com/opsworks/latest/userguide/resources.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def deregister_elastic_ip(client, input) do
    request(client, "DeregisterElasticIp", input)
  end

  @doc """
  DeregisterInstance

  Deregister a registered Amazon EC2 or on-premises instance. This action
  removes the instance from the stack and returns it to your control. This
  action can not be used with instances that were created with AWS OpsWorks.

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def deregister_instance(client, input) do
    request(client, "DeregisterInstance", input)
  end

  @doc """
  DeregisterRdsDbInstance

  Deregisters an Amazon RDS instance.

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def deregister_rds_db_instance(client, input) do
    request(client, "DeregisterRdsDbInstance", input)
  end

  @doc """
  DeregisterVolume

  Deregisters an Amazon EBS volume. The volume can then be registered by
  another stack. For more information, see [Resource
  Management](http://docs.aws.amazon.com/opsworks/latest/userguide/resources.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def deregister_volume(client, input) do
    request(client, "DeregisterVolume", input)
  end

  @doc """
  DescribeAgentVersions

  Describes the available AWS OpsWorks agent versions. You must specify a
  stack ID or a configuration manager. `DescribeAgentVersions` returns a list
  of available agent versions for the specified stack or configuration
  manager.
  """
  def describe_agent_versions(client, input) do
    request(client, "DescribeAgentVersions", input)
  end

  @doc """
  DescribeApps

  Requests a description of a specified set of apps.

  Note: You must specify at least one of the parameters.

  **Required Permissions**: To use this action, an IAM user must have a Show,
  Deploy, or Manage permissions level for the stack, or an attached policy
  that explicitly grants permissions. For more information on user
  permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def describe_apps(client, input) do
    request(client, "DescribeApps", input)
  end

  @doc """
  DescribeCommands

  Describes the results of specified commands.

  Note: You must specify at least one of the parameters.

  **Required Permissions**: To use this action, an IAM user must have a Show,
  Deploy, or Manage permissions level for the stack, or an attached policy
  that explicitly grants permissions. For more information on user
  permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def describe_commands(client, input) do
    request(client, "DescribeCommands", input)
  end

  @doc """
  DescribeDeployments

  Requests a description of a specified set of deployments.

  Note: You must specify at least one of the parameters.

  **Required Permissions**: To use this action, an IAM user must have a Show,
  Deploy, or Manage permissions level for the stack, or an attached policy
  that explicitly grants permissions. For more information on user
  permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def describe_deployments(client, input) do
    request(client, "DescribeDeployments", input)
  end

  @doc """
  DescribeEcsClusters

  Describes Amazon ECS clusters that are registered with a stack. If you
  specify only a stack ID, you can use the `MaxResults` and `NextToken`
  parameters to paginate the response. However, AWS OpsWorks currently
  supports only one cluster per layer, so the result set has a maximum of one
  element.

  **Required Permissions**: To use this action, an IAM user must have a Show,
  Deploy, or Manage permissions level for the stack or an attached policy
  that explicitly grants permission. For more information on user
  permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def describe_ecs_clusters(client, input) do
    request(client, "DescribeEcsClusters", input)
  end

  @doc """
  DescribeElasticIps

  Describes [Elastic IP
  addresses](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html).

  Note: You must specify at least one of the parameters.

  **Required Permissions**: To use this action, an IAM user must have a Show,
  Deploy, or Manage permissions level for the stack, or an attached policy
  that explicitly grants permissions. For more information on user
  permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def describe_elastic_ips(client, input) do
    request(client, "DescribeElasticIps", input)
  end

  @doc """
  DescribeElasticLoadBalancers

  Describes a stack's Elastic Load Balancing instances.

  Note: You must specify at least one of the parameters.

  **Required Permissions**: To use this action, an IAM user must have a Show,
  Deploy, or Manage permissions level for the stack, or an attached policy
  that explicitly grants permissions. For more information on user
  permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def describe_elastic_load_balancers(client, input) do
    request(client, "DescribeElasticLoadBalancers", input)
  end

  @doc """
  DescribeInstances

  Requests a description of a set of instances.

  Note: You must specify at least one of the parameters.

  **Required Permissions**: To use this action, an IAM user must have a Show,
  Deploy, or Manage permissions level for the stack, or an attached policy
  that explicitly grants permissions. For more information on user
  permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def describe_instances(client, input) do
    request(client, "DescribeInstances", input)
  end

  @doc """
  DescribeLayers

  Requests a description of one or more layers in a specified stack.

  Note: You must specify at least one of the parameters.

  **Required Permissions**: To use this action, an IAM user must have a Show,
  Deploy, or Manage permissions level for the stack, or an attached policy
  that explicitly grants permissions. For more information on user
  permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def describe_layers(client, input) do
    request(client, "DescribeLayers", input)
  end

  @doc """
  DescribeLoadBasedAutoScaling

  Describes load-based auto scaling configurations for specified layers.

  Note: You must specify at least one of the parameters.

  **Required Permissions**: To use this action, an IAM user must have a Show,
  Deploy, or Manage permissions level for the stack, or an attached policy
  that explicitly grants permissions. For more information on user
  permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def describe_load_based_auto_scaling(client, input) do
    request(client, "DescribeLoadBasedAutoScaling", input)
  end

  @doc """
  DescribeMyUserProfile

  Describes a user's SSH information.

  **Required Permissions**: To use this action, an IAM user must have
  self-management enabled or an attached policy that explicitly grants
  permissions. For more information on user permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def describe_my_user_profile(client, input) do
    request(client, "DescribeMyUserProfile", input)
  end

  @doc """
  DescribePermissions

  Describes the permissions for a specified stack.

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def describe_permissions(client, input) do
    request(client, "DescribePermissions", input)
  end

  @doc """
  DescribeRaidArrays

  Describe an instance's RAID arrays.

  Note: You must specify at least one of the parameters.

  **Required Permissions**: To use this action, an IAM user must have a Show,
  Deploy, or Manage permissions level for the stack, or an attached policy
  that explicitly grants permissions. For more information on user
  permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def describe_raid_arrays(client, input) do
    request(client, "DescribeRaidArrays", input)
  end

  @doc """
  DescribeRdsDbInstances

  Describes Amazon RDS instances.

  **Required Permissions**: To use this action, an IAM user must have a Show,
  Deploy, or Manage permissions level for the stack, or an attached policy
  that explicitly grants permissions. For more information on user
  permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def describe_rds_db_instances(client, input) do
    request(client, "DescribeRdsDbInstances", input)
  end

  @doc """
  DescribeServiceErrors

  Describes AWS OpsWorks service errors.

  **Required Permissions**: To use this action, an IAM user must have a Show,
  Deploy, or Manage permissions level for the stack, or an attached policy
  that explicitly grants permissions. For more information on user
  permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def describe_service_errors(client, input) do
    request(client, "DescribeServiceErrors", input)
  end

  @doc """
  DescribeStackProvisioningParameters

  Requests a description of a stack's provisioning parameters.

  **Required Permissions**: To use this action, an IAM user must have a Show,
  Deploy, or Manage permissions level for the stack or an attached policy
  that explicitly grants permissions. For more information on user
  permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def describe_stack_provisioning_parameters(client, input) do
    request(client, "DescribeStackProvisioningParameters", input)
  end

  @doc """
  DescribeStackSummary

  Describes the number of layers and apps in a specified stack, and the
  number of instances in each state, such as `running_setup` or `online`.

  **Required Permissions**: To use this action, an IAM user must have a Show,
  Deploy, or Manage permissions level for the stack, or an attached policy
  that explicitly grants permissions. For more information on user
  permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def describe_stack_summary(client, input) do
    request(client, "DescribeStackSummary", input)
  end

  @doc """
  DescribeStacks

  Requests a description of one or more stacks.

  **Required Permissions**: To use this action, an IAM user must have a Show,
  Deploy, or Manage permissions level for the stack, or an attached policy
  that explicitly grants permissions. For more information on user
  permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def describe_stacks(client, input) do
    request(client, "DescribeStacks", input)
  end

  @doc """
  DescribeTimeBasedAutoScaling

  Describes time-based auto scaling configurations for specified instances.

  Note: You must specify at least one of the parameters.

  **Required Permissions**: To use this action, an IAM user must have a Show,
  Deploy, or Manage permissions level for the stack, or an attached policy
  that explicitly grants permissions. For more information on user
  permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def describe_time_based_auto_scaling(client, input) do
    request(client, "DescribeTimeBasedAutoScaling", input)
  end

  @doc """
  DescribeUserProfiles

  Describe specified users.

  **Required Permissions**: To use this action, an IAM user must have an
  attached policy that explicitly grants permissions. For more information on
  user permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def describe_user_profiles(client, input) do
    request(client, "DescribeUserProfiles", input)
  end

  @doc """
  DescribeVolumes

  Describes an instance's Amazon EBS volumes.

  Note: You must specify at least one of the parameters.

  **Required Permissions**: To use this action, an IAM user must have a Show,
  Deploy, or Manage permissions level for the stack, or an attached policy
  that explicitly grants permissions. For more information on user
  permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def describe_volumes(client, input) do
    request(client, "DescribeVolumes", input)
  end

  @doc """
  DetachElasticLoadBalancer

  Detaches a specified Elastic Load Balancing instance from its layer.

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def detach_elastic_load_balancer(client, input) do
    request(client, "DetachElasticLoadBalancer", input)
  end

  @doc """
  DisassociateElasticIp

  Disassociates an Elastic IP address from its instance. The address remains
  registered with the stack. For more information, see [Resource
  Management](http://docs.aws.amazon.com/opsworks/latest/userguide/resources.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def disassociate_elastic_ip(client, input) do
    request(client, "DisassociateElasticIp", input)
  end

  @doc """
  GetHostnameSuggestion

  Gets a generated host name for the specified layer, based on the current
  host name theme.

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def get_hostname_suggestion(client, input) do
    request(client, "GetHostnameSuggestion", input)
  end

  @doc """
  GrantAccess

  Note:This action can be used only with Windows stacks. Grants RDP access to
  a Windows instance for a specified time period.
  """
  def grant_access(client, input) do
    request(client, "GrantAccess", input)
  end

  @doc """
  RebootInstance

  Reboots a specified instance. For more information, see [Starting,
  Stopping, and Rebooting
  Instances](http://docs.aws.amazon.com/opsworks/latest/userguide/workinginstances-starting.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def reboot_instance(client, input) do
    request(client, "RebootInstance", input)
  end

  @doc """
  RegisterEcsCluster

  Registers a specified Amazon ECS cluster with a stack. You can register
  only one cluster with a stack. A cluster can be registered with only one
  stack. For more information, see [ Resource
  Management](http://docs.aws.amazon.com/opsworks/latest/userguide/workinglayers-ecscluster.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [ Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def register_ecs_cluster(client, input) do
    request(client, "RegisterEcsCluster", input)
  end

  @doc """
  RegisterElasticIp

  Registers an Elastic IP address with a specified stack. An address can be
  registered with only one stack at a time. If the address is already
  registered, you must first deregister it by calling `DeregisterElasticIp`.
  For more information, see [Resource
  Management](http://docs.aws.amazon.com/opsworks/latest/userguide/resources.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def register_elastic_ip(client, input) do
    request(client, "RegisterElasticIp", input)
  end

  @doc """
  RegisterInstance

  Registers instances with a specified stack that were created outside of AWS
  OpsWorks.

  Note:We do not recommend using this action to register instances. The
  complete registration operation has two primary steps, installing the AWS
  OpsWorks agent on the instance and registering the instance with the stack.
  `RegisterInstance` handles only the second step. You should instead use the
  AWS CLI `register` command, which performs the entire registration
  operation. For more information, see [ Registering an Instance with an AWS
  OpsWorks
  Stack](http://docs.aws.amazon.com/opsworks/latest/userguide/registered-instances-register.html).
  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def register_instance(client, input) do
    request(client, "RegisterInstance", input)
  end

  @doc """
  RegisterRdsDbInstance

  Registers an Amazon RDS instance with a stack.

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def register_rds_db_instance(client, input) do
    request(client, "RegisterRdsDbInstance", input)
  end

  @doc """
  RegisterVolume

  Registers an Amazon EBS volume with a specified stack. A volume can be
  registered with only one stack at a time. If the volume is already
  registered, you must first deregister it by calling `DeregisterVolume`. For
  more information, see [Resource
  Management](http://docs.aws.amazon.com/opsworks/latest/userguide/resources.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def register_volume(client, input) do
    request(client, "RegisterVolume", input)
  end

  @doc """
  SetLoadBasedAutoScaling

  Specify the load-based auto scaling configuration for a specified layer.
  For more information, see [Managing Load with Time-based and Load-based
  Instances](http://docs.aws.amazon.com/opsworks/latest/userguide/workinginstances-autoscaling.html).

  Note: To use load-based auto scaling, you must create a set of load-based
  auto scaling instances. Load-based auto scaling operates only on the
  instances from that set, so you must ensure that you have created enough
  instances to handle the maximum anticipated load.

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def set_load_based_auto_scaling(client, input) do
    request(client, "SetLoadBasedAutoScaling", input)
  end

  @doc """
  SetPermission

  Specifies a user's permissions. For more information, see [Security and
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/workingsecurity.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def set_permission(client, input) do
    request(client, "SetPermission", input)
  end

  @doc """
  SetTimeBasedAutoScaling

  Specify the time-based auto scaling configuration for a specified instance.
  For more information, see [Managing Load with Time-based and Load-based
  Instances](http://docs.aws.amazon.com/opsworks/latest/userguide/workinginstances-autoscaling.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def set_time_based_auto_scaling(client, input) do
    request(client, "SetTimeBasedAutoScaling", input)
  end

  @doc """
  StartInstance

  Starts a specified instance. For more information, see [Starting, Stopping,
  and Rebooting
  Instances](http://docs.aws.amazon.com/opsworks/latest/userguide/workinginstances-starting.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def start_instance(client, input) do
    request(client, "StartInstance", input)
  end

  @doc """
  StartStack

  Starts a stack's instances.

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def start_stack(client, input) do
    request(client, "StartStack", input)
  end

  @doc """
  StopInstance

  Stops a specified instance. When you stop a standard instance, the data
  disappears and must be reinstalled when you restart the instance. You can
  stop an Amazon EBS-backed instance without losing data. For more
  information, see [Starting, Stopping, and Rebooting
  Instances](http://docs.aws.amazon.com/opsworks/latest/userguide/workinginstances-starting.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def stop_instance(client, input) do
    request(client, "StopInstance", input)
  end

  @doc """
  StopStack

  Stops a specified stack.

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def stop_stack(client, input) do
    request(client, "StopStack", input)
  end

  @doc """
  UnassignInstance

  Unassigns a registered instance from all of it's layers. The instance
  remains in the stack as an unassigned instance and can be assigned to
  another layer, as needed. You cannot use this action with instances that
  were created with AWS OpsWorks.

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def unassign_instance(client, input) do
    request(client, "UnassignInstance", input)
  end

  @doc """
  UnassignVolume

  Unassigns an assigned Amazon EBS volume. The volume remains registered with
  the stack. For more information, see [Resource
  Management](http://docs.aws.amazon.com/opsworks/latest/userguide/resources.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def unassign_volume(client, input) do
    request(client, "UnassignVolume", input)
  end

  @doc """
  UpdateApp

  Updates a specified app.

  **Required Permissions**: To use this action, an IAM user must have a
  Deploy or Manage permissions level for the stack, or an attached policy
  that explicitly grants permissions. For more information on user
  permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def update_app(client, input) do
    request(client, "UpdateApp", input)
  end

  @doc """
  UpdateElasticIp

  Updates a registered Elastic IP address's name. For more information, see
  [Resource
  Management](http://docs.aws.amazon.com/opsworks/latest/userguide/resources.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def update_elastic_ip(client, input) do
    request(client, "UpdateElasticIp", input)
  end

  @doc """
  UpdateInstance

  Updates a specified instance.

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def update_instance(client, input) do
    request(client, "UpdateInstance", input)
  end

  @doc """
  UpdateLayer

  Updates a specified layer.

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def update_layer(client, input) do
    request(client, "UpdateLayer", input)
  end

  @doc """
  UpdateMyUserProfile

  Updates a user's SSH public key.

  **Required Permissions**: To use this action, an IAM user must have
  self-management enabled or an attached policy that explicitly grants
  permissions. For more information on user permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def update_my_user_profile(client, input) do
    request(client, "UpdateMyUserProfile", input)
  end

  @doc """
  UpdateRdsDbInstance

  Updates an Amazon RDS instance.

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def update_rds_db_instance(client, input) do
    request(client, "UpdateRdsDbInstance", input)
  end

  @doc """
  UpdateStack

  Updates a specified stack.

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def update_stack(client, input) do
    request(client, "UpdateStack", input)
  end

  @doc """
  UpdateUserProfile

  Updates a specified user profile.

  **Required Permissions**: To use this action, an IAM user must have an
  attached policy that explicitly grants permissions. For more information on
  user permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def update_user_profile(client, input) do
    request(client, "UpdateUserProfile", input)
  end

  @doc """
  UpdateVolume

  Updates an Amazon EBS volume's name or mount point. For more information,
  see [Resource
  Management](http://docs.aws.amazon.com/opsworks/latest/userguide/resources.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """
  def update_volume(client, input) do
    request(client, "UpdateVolume", input)
  end


  defp request(%{__struct__: client_module} = client, action, input) do
    client_module.request(client, action, input)
  end
end
