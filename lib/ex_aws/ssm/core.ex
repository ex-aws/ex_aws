defmodule ExAws.SSM.Core do
  import ExAws.Core.JSON, only: [format_input: 1]
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

  - Join an AWS Directory

  - Install, repair, or uninstall software using an MSI package

  - Run PowerShell scripts

  - Configure CloudWatch Logs to monitor applications and systems

  Note that configuration documents are not supported on Linux instances.
  """

  @type associated_instances :: [
  ]

  @type association :: [
    instance_id: instance_id,
    name: document_name,
  ]

  @type association_already_exists :: [
  ]

  @type association_description :: [
    date: date_time,
    instance_id: instance_id,
    name: document_name,
    status: association_status,
  ]

  @type association_description_list :: [association_description]

  @type association_does_not_exist :: [
  ]

  @type association_filter :: [
    key: association_filter_key,
    value: association_filter_value,
  ]

  @type association_filter_key :: binary

  @type association_filter_list :: [association_filter]

  @type association_filter_value :: binary

  @type association_limit_exceeded :: [
  ]

  @type association_list :: [association]

  @type association_status :: [
    additional_info: status_additional_info,
    date: date_time,
    message: status_message,
    name: association_status_name,
  ]

  @type association_status_name :: binary

  @type batch_error_message :: binary

  @type create_association_batch_request :: [
    entries: create_association_batch_request_entries,
  ]

  @type create_association_batch_request_entries :: [create_association_batch_request_entry]

  @type create_association_batch_request_entry :: [
    instance_id: instance_id,
    name: document_name,
  ]

  @type create_association_batch_result :: [
    failed: failed_create_association_list,
    successful: association_description_list,
  ]

  @type create_association_request :: [
    instance_id: instance_id,
    name: document_name,
  ]

  @type create_association_result :: [
    association_description: association_description,
  ]

  @type create_document_request :: [
    content: document_content,
    name: document_name,
  ]

  @type create_document_result :: [
    document_description: document_description,
  ]

  @type date_time :: integer

  @type delete_association_request :: [
    instance_id: instance_id,
    name: document_name,
  ]

  @type delete_association_result :: [
  ]

  @type delete_document_request :: [
    name: document_name,
  ]

  @type delete_document_result :: [
  ]

  @type describe_association_request :: [
    instance_id: instance_id,
    name: document_name,
  ]

  @type describe_association_result :: [
    association_description: association_description,
  ]

  @type describe_document_request :: [
    name: document_name,
  ]

  @type describe_document_result :: [
    document: document_description,
  ]

  @type document_already_exists :: [
  ]

  @type document_content :: binary

  @type document_description :: [
    created_date: date_time,
    name: document_name,
    sha1: document_sha1,
    status: document_status,
  ]

  @type document_filter :: [
    key: document_filter_key,
    value: document_filter_value,
  ]

  @type document_filter_key :: binary

  @type document_filter_list :: [document_filter]

  @type document_filter_value :: binary

  @type document_identifier :: [
    name: document_name,
  ]

  @type document_identifier_list :: [document_identifier]

  @type document_limit_exceeded :: [
  ]

  @type document_name :: binary

  @type document_sha1 :: binary

  @type document_status :: binary

  @type duplicate_instance_id :: [
  ]

  @type failed_create_association :: [
    entry: create_association_batch_request_entry,
    fault: fault,
    message: batch_error_message,
  ]

  @type failed_create_association_list :: [failed_create_association]

  @type fault :: binary

  @type get_document_request :: [
    name: document_name,
  ]

  @type get_document_result :: [
    content: document_content,
    name: document_name,
  ]

  @type instance_id :: binary

  @type internal_server_error :: [
  ]

  @type invalid_document :: [
  ]

  @type invalid_document_content :: [
    message: binary,
  ]

  @type invalid_instance_id :: [
  ]

  @type invalid_next_token :: [
  ]

  @type list_associations_request :: [
    association_filter_list: association_filter_list,
    max_results: max_results,
    next_token: next_token,
  ]

  @type list_associations_result :: [
    associations: association_list,
    next_token: next_token,
  ]

  @type list_documents_request :: [
    document_filter_list: document_filter_list,
    max_results: max_results,
    next_token: next_token,
  ]

  @type list_documents_result :: [
    document_identifiers: document_identifier_list,
    next_token: next_token,
  ]

  @type max_document_size_exceeded :: [
  ]

  @type max_results :: integer

  @type next_token :: binary

  @type status_additional_info :: binary

  @type status_message :: binary

  @type status_unchanged :: [
  ]

  @type too_many_updates :: [
  ]

  @type update_association_status_request :: [
    association_status: association_status,
    instance_id: instance_id,
    name: document_name,
  ]

  @type update_association_status_result :: [
    association_description: association_description,
  ]





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

  @spec create_association(client :: ExAws.SSM.t, input :: create_association_request) :: ExAws.Request.JSON.response_t
  def create_association(client, input) do
    request(client, "CreateAssociation", format_input(input))
  end

  @doc """
  Same as `create_association/2` but raise on error.
  """
  @spec create_association!(client :: ExAws.SSM.t, input :: create_association_request) :: ExAws.Request.JSON.success_t | no_return
  def create_association!(client, input) do
    case create_association(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
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

  @spec create_association_batch(client :: ExAws.SSM.t, input :: create_association_batch_request) :: ExAws.Request.JSON.response_t
  def create_association_batch(client, input) do
    request(client, "CreateAssociationBatch", format_input(input))
  end

  @doc """
  Same as `create_association_batch/2` but raise on error.
  """
  @spec create_association_batch!(client :: ExAws.SSM.t, input :: create_association_batch_request) :: ExAws.Request.JSON.success_t | no_return
  def create_association_batch!(client, input) do
    case create_association_batch(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateDocument

  Creates a configuration document.

  After you create a configuration document, you can use `CreateAssociation`
  to associate it with one or more running instances.
  """

  @spec create_document(client :: ExAws.SSM.t, input :: create_document_request) :: ExAws.Request.JSON.response_t
  def create_document(client, input) do
    request(client, "CreateDocument", format_input(input))
  end

  @doc """
  Same as `create_document/2` but raise on error.
  """
  @spec create_document!(client :: ExAws.SSM.t, input :: create_document_request) :: ExAws.Request.JSON.success_t | no_return
  def create_document!(client, input) do
    case create_document(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
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

  @spec delete_association(client :: ExAws.SSM.t, input :: delete_association_request) :: ExAws.Request.JSON.response_t
  def delete_association(client, input) do
    request(client, "DeleteAssociation", format_input(input))
  end

  @doc """
  Same as `delete_association/2` but raise on error.
  """
  @spec delete_association!(client :: ExAws.SSM.t, input :: delete_association_request) :: ExAws.Request.JSON.success_t | no_return
  def delete_association!(client, input) do
    case delete_association(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteDocument

  Deletes the specified configuration document.

  You must use `DeleteAssociation` to disassociate all instances that are
  associated with the configuration document before you can delete it.
  """

  @spec delete_document(client :: ExAws.SSM.t, input :: delete_document_request) :: ExAws.Request.JSON.response_t
  def delete_document(client, input) do
    request(client, "DeleteDocument", format_input(input))
  end

  @doc """
  Same as `delete_document/2` but raise on error.
  """
  @spec delete_document!(client :: ExAws.SSM.t, input :: delete_document_request) :: ExAws.Request.JSON.success_t | no_return
  def delete_document!(client, input) do
    case delete_document(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeAssociation

  Describes the associations for the specified configuration document or
  instance.
  """

  @spec describe_association(client :: ExAws.SSM.t, input :: describe_association_request) :: ExAws.Request.JSON.response_t
  def describe_association(client, input) do
    request(client, "DescribeAssociation", format_input(input))
  end

  @doc """
  Same as `describe_association/2` but raise on error.
  """
  @spec describe_association!(client :: ExAws.SSM.t, input :: describe_association_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_association!(client, input) do
    case describe_association(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeDocument

  Describes the specified configuration document.
  """

  @spec describe_document(client :: ExAws.SSM.t, input :: describe_document_request) :: ExAws.Request.JSON.response_t
  def describe_document(client, input) do
    request(client, "DescribeDocument", format_input(input))
  end

  @doc """
  Same as `describe_document/2` but raise on error.
  """
  @spec describe_document!(client :: ExAws.SSM.t, input :: describe_document_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_document!(client, input) do
    case describe_document(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetDocument

  Gets the contents of the specified configuration document.
  """

  @spec get_document(client :: ExAws.SSM.t, input :: get_document_request) :: ExAws.Request.JSON.response_t
  def get_document(client, input) do
    request(client, "GetDocument", format_input(input))
  end

  @doc """
  Same as `get_document/2` but raise on error.
  """
  @spec get_document!(client :: ExAws.SSM.t, input :: get_document_request) :: ExAws.Request.JSON.success_t | no_return
  def get_document!(client, input) do
    case get_document(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListAssociations

  Lists the associations for the specified configuration document or
  instance.
  """

  @spec list_associations(client :: ExAws.SSM.t, input :: list_associations_request) :: ExAws.Request.JSON.response_t
  def list_associations(client, input) do
    request(client, "ListAssociations", format_input(input))
  end

  @doc """
  Same as `list_associations/2` but raise on error.
  """
  @spec list_associations!(client :: ExAws.SSM.t, input :: list_associations_request) :: ExAws.Request.JSON.success_t | no_return
  def list_associations!(client, input) do
    case list_associations(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListDocuments

  Describes one or more of your configuration documents.
  """

  @spec list_documents(client :: ExAws.SSM.t, input :: list_documents_request) :: ExAws.Request.JSON.response_t
  def list_documents(client, input) do
    request(client, "ListDocuments", format_input(input))
  end

  @doc """
  Same as `list_documents/2` but raise on error.
  """
  @spec list_documents!(client :: ExAws.SSM.t, input :: list_documents_request) :: ExAws.Request.JSON.success_t | no_return
  def list_documents!(client, input) do
    case list_documents(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateAssociationStatus

  Updates the status of the configuration document associated with the
  specified instance.
  """

  @spec update_association_status(client :: ExAws.SSM.t, input :: update_association_status_request) :: ExAws.Request.JSON.response_t
  def update_association_status(client, input) do
    request(client, "UpdateAssociationStatus", format_input(input))
  end

  @doc """
  Same as `update_association_status/2` but raise on error.
  """
  @spec update_association_status!(client :: ExAws.SSM.t, input :: update_association_status_request) :: ExAws.Request.JSON.success_t | no_return
  def update_association_status!(client, input) do
    case update_association_status(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  defp request(%{__struct__: client_module} = client, action, input) do
    apply(client_module, :request, [client, action, input])
  end
end
