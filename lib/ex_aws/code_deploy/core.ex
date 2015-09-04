defmodule ExAws.CodeDeploy.Core do
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


  @doc """
  AddTagsToOnPremisesInstances

  Adds tags to on-premises instances.
  """
  def add_tags_to_on_premises_instances(client, input) do
    request(client, "AddTagsToOnPremisesInstances", input)
  end

  @doc """
  BatchGetApplications

  Gets information about one or more applications.
  """
  def batch_get_applications(client, input) do
    request(client, "BatchGetApplications", input)
  end

  @doc """
  BatchGetDeployments

  Gets information about one or more deployments.
  """
  def batch_get_deployments(client, input) do
    request(client, "BatchGetDeployments", input)
  end

  @doc """
  BatchGetOnPremisesInstances

  Gets information about one or more on-premises instances.
  """
  def batch_get_on_premises_instances(client, input) do
    request(client, "BatchGetOnPremisesInstances", input)
  end

  @doc """
  CreateApplication

  Creates a new application.
  """
  def create_application(client, input) do
    request(client, "CreateApplication", input)
  end

  @doc """
  CreateDeployment

  Deploys an application revision through the specified deployment group.
  """
  def create_deployment(client, input) do
    request(client, "CreateDeployment", input)
  end

  @doc """
  CreateDeploymentConfig

  Creates a new deployment configuration.
  """
  def create_deployment_config(client, input) do
    request(client, "CreateDeploymentConfig", input)
  end

  @doc """
  CreateDeploymentGroup

  Creates a new deployment group for application revisions to be deployed to.
  """
  def create_deployment_group(client, input) do
    request(client, "CreateDeploymentGroup", input)
  end

  @doc """
  DeleteApplication

  Deletes an application.
  """
  def delete_application(client, input) do
    request(client, "DeleteApplication", input)
  end

  @doc """
  DeleteDeploymentConfig

  Deletes a deployment configuration.

  Note:A deployment configuration cannot be deleted if it is currently in
  use. Also, predefined configurations cannot be deleted.
  """
  def delete_deployment_config(client, input) do
    request(client, "DeleteDeploymentConfig", input)
  end

  @doc """
  DeleteDeploymentGroup

  Deletes a deployment group.
  """
  def delete_deployment_group(client, input) do
    request(client, "DeleteDeploymentGroup", input)
  end

  @doc """
  DeregisterOnPremisesInstance

  Deregisters an on-premises instance.
  """
  def deregister_on_premises_instance(client, input) do
    request(client, "DeregisterOnPremisesInstance", input)
  end

  @doc """
  GetApplication

  Gets information about an application.
  """
  def get_application(client, input) do
    request(client, "GetApplication", input)
  end

  @doc """
  GetApplicationRevision

  Gets information about an application revision.
  """
  def get_application_revision(client, input) do
    request(client, "GetApplicationRevision", input)
  end

  @doc """
  GetDeployment

  Gets information about a deployment.
  """
  def get_deployment(client, input) do
    request(client, "GetDeployment", input)
  end

  @doc """
  GetDeploymentConfig

  Gets information about a deployment configuration.
  """
  def get_deployment_config(client, input) do
    request(client, "GetDeploymentConfig", input)
  end

  @doc """
  GetDeploymentGroup

  Gets information about a deployment group.
  """
  def get_deployment_group(client, input) do
    request(client, "GetDeploymentGroup", input)
  end

  @doc """
  GetDeploymentInstance

  Gets information about an instance as part of a deployment.
  """
  def get_deployment_instance(client, input) do
    request(client, "GetDeploymentInstance", input)
  end

  @doc """
  GetOnPremisesInstance

  Gets information about an on-premises instance.
  """
  def get_on_premises_instance(client, input) do
    request(client, "GetOnPremisesInstance", input)
  end

  @doc """
  ListApplicationRevisions

  Lists information about revisions for an application.
  """
  def list_application_revisions(client, input) do
    request(client, "ListApplicationRevisions", input)
  end

  @doc """
  ListApplications

  Lists the applications registered with the applicable IAM user or AWS
  account.
  """
  def list_applications(client, input) do
    request(client, "ListApplications", input)
  end

  @doc """
  ListDeploymentConfigs

  Lists the deployment configurations with the applicable IAM user or AWS
  account.
  """
  def list_deployment_configs(client, input) do
    request(client, "ListDeploymentConfigs", input)
  end

  @doc """
  ListDeploymentGroups

  Lists the deployment groups for an application registered with the
  applicable IAM user or AWS account.
  """
  def list_deployment_groups(client, input) do
    request(client, "ListDeploymentGroups", input)
  end

  @doc """
  ListDeploymentInstances

  Lists the instances for a deployment associated with the applicable IAM
  user or AWS account.
  """
  def list_deployment_instances(client, input) do
    request(client, "ListDeploymentInstances", input)
  end

  @doc """
  ListDeployments

  Lists the deployments within a deployment group for an application
  registered with the applicable IAM user or AWS account.
  """
  def list_deployments(client, input) do
    request(client, "ListDeployments", input)
  end

  @doc """
  ListOnPremisesInstances

  Gets a list of one or more on-premises instance names.

  Unless otherwise specified, both registered and deregistered on-premises
  instance names will be listed. To list only registered or deregistered
  on-premises instance names, use the registration status parameter.
  """
  def list_on_premises_instances(client, input) do
    request(client, "ListOnPremisesInstances", input)
  end

  @doc """
  RegisterApplicationRevision

  Registers with AWS CodeDeploy a revision for the specified application.
  """
  def register_application_revision(client, input) do
    request(client, "RegisterApplicationRevision", input)
  end

  @doc """
  RegisterOnPremisesInstance

  Registers an on-premises instance.
  """
  def register_on_premises_instance(client, input) do
    request(client, "RegisterOnPremisesInstance", input)
  end

  @doc """
  RemoveTagsFromOnPremisesInstances

  Removes one or more tags from one or more on-premises instances.
  """
  def remove_tags_from_on_premises_instances(client, input) do
    request(client, "RemoveTagsFromOnPremisesInstances", input)
  end

  @doc """
  StopDeployment

  Attempts to stop an ongoing deployment.
  """
  def stop_deployment(client, input) do
    request(client, "StopDeployment", input)
  end

  @doc """
  UpdateApplication

  Changes an existing application's name.
  """
  def update_application(client, input) do
    request(client, "UpdateApplication", input)
  end

  @doc """
  UpdateDeploymentGroup

  Changes information about an existing deployment group.
  """
  def update_deployment_group(client, input) do
    request(client, "UpdateDeploymentGroup", input)
  end


  defp request(%{__struct__: client_module} = client, action, input) do
    client_module.request(client, action, input)
  end
end
