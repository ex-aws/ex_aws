defmodule ExAws.SSM.Core do
  @actions [
    "CreateAssociation",
    "CreateAssociationBatch",
    "CreateDocument",
    "DeleteAssociation",
    "DeleteDocument",
    "DescribeAssociation",
    "DescribeDocument",
    "GetDocument",
    "ListAssociations",
    "ListDocuments",
    "UpdateAssociationStatus"]

  @moduledoc """
  ## Amazon Simple Systems Management Service

  Amazon EC2 Simple Systems Manager (SSM) enables you to configure and manage
  your EC2 instances. You can create a configuration document and then
  associate it with one or more running instances.

  You can use a configuration document to automate the following tasks for
  your Windows instances:

  <ul> <li>Join an AWS Directory

  </li> <li>Install, repair, or uninstall software using an MSI package

  </li> <li>Run PowerShell scripts

  </li> <li>Configure CloudWatch Logs to monitor applications and systems

  </li> </ul> Note that configuration documents are not supported on Linux
  instances.
  """


  @doc """
  CreateAssociation

  Associates the specified configuration document with the specified
  instance.

  When you associate a configuration document with an instance, the
  configuration agent on the instance processes the configuration document
  and configures the instance as specified.

  If you associate a configuration document with an instance that already has
  an associated configuration document, we replace the current configuration
  document with the new configuration document.
  """
  def create_association(client, input) do
    request(client, "CreateAssociation", input)
  end

  @doc """
  CreateAssociationBatch

  Associates the specified configuration documents with the specified
  instances.

  When you associate a configuration document with an instance, the
  configuration agent on the instance processes the configuration document
  and configures the instance as specified.

  If you associate a configuration document with an instance that already has
  an associated configuration document, we replace the current configuration
  document with the new configuration document.
  """
  def create_association_batch(client, input) do
    request(client, "CreateAssociationBatch", input)
  end

  @doc """
  CreateDocument

  Creates a configuration document.

  After you create a configuration document, you can use `CreateAssociation`
  to associate it with one or more running instances.
  """
  def create_document(client, input) do
    request(client, "CreateDocument", input)
  end

  @doc """
  DeleteAssociation

  Disassociates the specified configuration document from the specified
  instance.

  When you disassociate a configuration document from an instance, it does
  not change the configuration of the instance. To change the configuration
  state of an instance after you disassociate a configuration document, you
  must create a new configuration document with the desired configuration and
  associate it with the instance.
  """
  def delete_association(client, input) do
    request(client, "DeleteAssociation", input)
  end

  @doc """
  DeleteDocument

  Deletes the specified configuration document.

  You must use `DeleteAssociation` to disassociate all instances that are
  associated with the configuration document before you can delete it.
  """
  def delete_document(client, input) do
    request(client, "DeleteDocument", input)
  end

  @doc """
  DescribeAssociation

  Describes the associations for the specified configuration document or
  instance.
  """
  def describe_association(client, input) do
    request(client, "DescribeAssociation", input)
  end

  @doc """
  DescribeDocument

  Describes the specified configuration document.
  """
  def describe_document(client, input) do
    request(client, "DescribeDocument", input)
  end

  @doc """
  GetDocument

  Gets the contents of the specified configuration document.
  """
  def get_document(client, input) do
    request(client, "GetDocument", input)
  end

  @doc """
  ListAssociations

  Lists the associations for the specified configuration document or
  instance.
  """
  def list_associations(client, input) do
    request(client, "ListAssociations", input)
  end

  @doc """
  ListDocuments

  Describes one or more of your configuration documents.
  """
  def list_documents(client, input) do
    request(client, "ListDocuments", input)
  end

  @doc """
  UpdateAssociationStatus

  Updates the status of the configuration document associated with the
  specified instance.
  """
  def update_association_status(client, input) do
    request(client, "UpdateAssociationStatus", input)
  end


  defp request(%{__struct__: client_module} = client, action, input) do
    client_module.request(client, action, input)
  end
end
