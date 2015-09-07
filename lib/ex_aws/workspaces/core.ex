defmodule ExAws.Workspaces.Core do
  import ExAws.Core.JSON, only: [format_input: 1]
  @actions [
    "CreateWorkspaces",
    "DescribeWorkspaceBundles",
    "DescribeWorkspaceDirectories",
    "DescribeWorkspaces",
    "RebootWorkspaces",
    "RebuildWorkspaces",
    "TerminateWorkspaces"]

  @moduledoc """
  ## Amazon WorkSpaces

  Amazon WorkSpaces Service

  This is the *Amazon WorkSpaces API Reference*. This guide provides detailed
  information about Amazon WorkSpaces operations, data types, parameters, and
  errors.
  """

  @type arn :: binary

  @type alias :: binary

  @type boolean_object :: boolean

  @type bundle_id :: binary

  @type bundle_id_list :: [bundle_id]

  @type bundle_list :: [workspace_bundle]

  @type bundle_owner :: binary

  @type compute :: binary

  @type compute_type :: [
    name: compute,
  ]

  @type create_workspaces_request :: [
    workspaces: workspace_request_list,
  ]

  @type create_workspaces_result :: [
    failed_requests: failed_create_workspace_requests,
    pending_requests: workspace_list,
  ]

  @type default_ou :: binary

  @type default_workspace_creation_properties :: [
    custom_security_group_id: security_group_id,
    default_ou: default_ou,
    enable_internet_access: boolean_object,
    enable_work_docs: boolean_object,
    user_enabled_as_local_administrator: boolean_object,
  ]

  @type describe_workspace_bundles_request :: [
    bundle_ids: bundle_id_list,
    next_token: pagination_token,
    owner: bundle_owner,
  ]

  @type describe_workspace_bundles_result :: [
    bundles: bundle_list,
    next_token: pagination_token,
  ]

  @type describe_workspace_directories_request :: [
    directory_ids: directory_id_list,
    next_token: pagination_token,
  ]

  @type describe_workspace_directories_result :: [
    directories: directory_list,
    next_token: pagination_token,
  ]

  @type describe_workspaces_request :: [
    bundle_id: bundle_id,
    directory_id: directory_id,
    limit: limit,
    next_token: pagination_token,
    user_name: user_name,
    workspace_ids: workspace_id_list,
  ]

  @type describe_workspaces_result :: [
    next_token: pagination_token,
    workspaces: workspace_list,
  ]

  @type description :: binary

  @type directory_id :: binary

  @type directory_id_list :: [directory_id]

  @type directory_list :: [workspace_directory]

  @type directory_name :: binary

  @type dns_ip_addresses :: [ip_address]

  @type error_type :: binary

  @type exception_message :: binary

  @type failed_create_workspace_request :: [
    error_code: error_type,
    error_message: description,
    workspace_request: workspace_request,
  ]

  @type failed_create_workspace_requests :: [failed_create_workspace_request]

  @type failed_reboot_workspace_requests :: [failed_workspace_change_request]

  @type failed_rebuild_workspace_requests :: [failed_workspace_change_request]

  @type failed_terminate_workspace_requests :: [failed_workspace_change_request]

  @type failed_workspace_change_request :: [
    error_code: error_type,
    error_message: description,
    workspace_id: workspace_id,
  ]

  @type invalid_parameter_values_exception :: [
    message: exception_message,
  ]

  @type ip_address :: binary

  @type limit :: integer

  @type non_empty_string :: binary

  @type pagination_token :: binary

  @type reboot_request :: [
    workspace_id: workspace_id,
  ]

  @type reboot_workspace_requests :: [reboot_request]

  @type reboot_workspaces_request :: [
    reboot_workspace_requests: reboot_workspace_requests,
  ]

  @type reboot_workspaces_result :: [
    failed_requests: failed_reboot_workspace_requests,
  ]

  @type rebuild_request :: [
    workspace_id: workspace_id,
  ]

  @type rebuild_workspace_requests :: [rebuild_request]

  @type rebuild_workspaces_request :: [
    rebuild_workspace_requests: rebuild_workspace_requests,
  ]

  @type rebuild_workspaces_result :: [
    failed_requests: failed_rebuild_workspace_requests,
  ]

  @type registration_code :: binary

  @type resource_limit_exceeded_exception :: [
    message: exception_message,
  ]

  @type resource_unavailable_exception :: [
    resource_id: non_empty_string,
    message: exception_message,
  ]

  @type security_group_id :: binary

  @type subnet_id :: binary

  @type subnet_ids :: [subnet_id]

  @type terminate_request :: [
    workspace_id: workspace_id,
  ]

  @type terminate_workspace_requests :: [terminate_request]

  @type terminate_workspaces_request :: [
    terminate_workspace_requests: terminate_workspace_requests,
  ]

  @type terminate_workspaces_result :: [
    failed_requests: failed_terminate_workspace_requests,
  ]

  @type user_name :: binary

  @type user_storage :: [
    capacity: non_empty_string,
  ]

  @type workspace :: [
    bundle_id: bundle_id,
    directory_id: directory_id,
    error_code: workspace_error_code,
    error_message: description,
    ip_address: ip_address,
    state: workspace_state,
    subnet_id: subnet_id,
    user_name: user_name,
    workspace_id: workspace_id,
  ]

  @type workspace_bundle :: [
    bundle_id: bundle_id,
    compute_type: compute_type,
    description: description,
    name: non_empty_string,
    owner: bundle_owner,
    user_storage: user_storage,
  ]

  @type workspace_directory :: [
    alias: alias,
    customer_user_name: user_name,
    directory_id: directory_id,
    directory_name: directory_name,
    directory_type: workspace_directory_type,
    dns_ip_addresses: dns_ip_addresses,
    iam_role_id: arn,
    registration_code: registration_code,
    state: workspace_directory_state,
    subnet_ids: subnet_ids,
    workspace_creation_properties: default_workspace_creation_properties,
    workspace_security_group_id: security_group_id,
  ]

  @type workspace_directory_state :: binary

  @type workspace_directory_type :: binary

  @type workspace_error_code :: binary

  @type workspace_id :: binary

  @type workspace_id_list :: [workspace_id]

  @type workspace_list :: [workspace]

  @type workspace_request :: [
    bundle_id: bundle_id,
    directory_id: directory_id,
    user_name: user_name,
  ]

  @type workspace_request_list :: [workspace_request]

  @type workspace_state :: binary





  @doc """
  CreateWorkspaces

  Creates one or more WorkSpaces.

  Note: This operation is asynchronous and returns before the WorkSpaces are
  created.
  """

  @spec create_workspaces(client :: ExAws.Workspaces.t, input :: create_workspaces_request) :: ExAws.Request.JSON.response_t
  def create_workspaces(client, input) do
    request(client, "CreateWorkspaces", format_input(input))
  end

  @doc """
  Same as `create_workspaces/2` but raise on error.
  """
  @spec create_workspaces!(client :: ExAws.Workspaces.t, input :: create_workspaces_request) :: ExAws.Request.JSON.success_t | no_return
  def create_workspaces!(client, input) do
    case create_workspaces(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeWorkspaceBundles

  Obtains information about the WorkSpace bundles that are available to your
  account in the specified region.

  You can filter the results with either the `BundleIds` parameter, or the
  `Owner` parameter, but not both.

  This operation supports pagination with the use of the `NextToken` request
  and response parameters. If more results are available, the `NextToken`
  response member contains a token that you pass in the next call to this
  operation to retrieve the next set of items.
  """

  @spec describe_workspace_bundles(client :: ExAws.Workspaces.t, input :: describe_workspace_bundles_request) :: ExAws.Request.JSON.response_t
  def describe_workspace_bundles(client, input) do
    request(client, "DescribeWorkspaceBundles", format_input(input))
  end

  @doc """
  Same as `describe_workspace_bundles/2` but raise on error.
  """
  @spec describe_workspace_bundles!(client :: ExAws.Workspaces.t, input :: describe_workspace_bundles_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_workspace_bundles!(client, input) do
    case describe_workspace_bundles(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeWorkspaceDirectories

  Retrieves information about the AWS Directory Service directories in the
  region that are registered with Amazon WorkSpaces and are available to your
  account.

  This operation supports pagination with the use of the `NextToken` request
  and response parameters. If more results are available, the `NextToken`
  response member contains a token that you pass in the next call to this
  operation to retrieve the next set of items.
  """

  @spec describe_workspace_directories(client :: ExAws.Workspaces.t, input :: describe_workspace_directories_request) :: ExAws.Request.JSON.response_t
  def describe_workspace_directories(client, input) do
    request(client, "DescribeWorkspaceDirectories", format_input(input))
  end

  @doc """
  Same as `describe_workspace_directories/2` but raise on error.
  """
  @spec describe_workspace_directories!(client :: ExAws.Workspaces.t, input :: describe_workspace_directories_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_workspace_directories!(client, input) do
    case describe_workspace_directories(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeWorkspaces

  Obtains information about the specified WorkSpaces.

  Only one of the filter parameters, such as `BundleId`, `DirectoryId`, or
  `WorkspaceIds`, can be specified at a time.

  This operation supports pagination with the use of the `NextToken` request
  and response parameters. If more results are available, the `NextToken`
  response member contains a token that you pass in the next call to this
  operation to retrieve the next set of items.
  """

  @spec describe_workspaces(client :: ExAws.Workspaces.t, input :: describe_workspaces_request) :: ExAws.Request.JSON.response_t
  def describe_workspaces(client, input) do
    request(client, "DescribeWorkspaces", format_input(input))
  end

  @doc """
  Same as `describe_workspaces/2` but raise on error.
  """
  @spec describe_workspaces!(client :: ExAws.Workspaces.t, input :: describe_workspaces_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_workspaces!(client, input) do
    case describe_workspaces(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RebootWorkspaces

  Reboots the specified WorkSpaces.

  To be able to reboot a WorkSpace, the WorkSpace must have a **State** of
  `AVAILABLE`, `IMPAIRED`, or `INOPERABLE`.

  Note: This operation is asynchronous and will return before the WorkSpaces
  have rebooted.
  """

  @spec reboot_workspaces(client :: ExAws.Workspaces.t, input :: reboot_workspaces_request) :: ExAws.Request.JSON.response_t
  def reboot_workspaces(client, input) do
    request(client, "RebootWorkspaces", format_input(input))
  end

  @doc """
  Same as `reboot_workspaces/2` but raise on error.
  """
  @spec reboot_workspaces!(client :: ExAws.Workspaces.t, input :: reboot_workspaces_request) :: ExAws.Request.JSON.success_t | no_return
  def reboot_workspaces!(client, input) do
    case reboot_workspaces(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RebuildWorkspaces

  Rebuilds the specified WorkSpaces.

  Rebuilding a WorkSpace is a potentially destructive action that can result
  in the loss of data. Rebuilding a WorkSpace causes the following to occur:

  - The system is restored to the image of the bundle that the WorkSpace is
  created from. Any applications that have been installed, or system settings
  that have been made since the WorkSpace was created will be lost.

  - The data drive (D drive) is re-created from the last automatic snapshot
  taken of the data drive. The current contents of the data drive are
  overwritten. Automatic snapshots of the data drive are taken every 12
  hours, so the snapshot can be as much as 12 hours old.

  To be able to rebuild a WorkSpace, the WorkSpace must have a **State** of
  `AVAILABLE` or `ERROR`.

  Note: This operation is asynchronous and will return before the WorkSpaces
  have been completely rebuilt.
  """

  @spec rebuild_workspaces(client :: ExAws.Workspaces.t, input :: rebuild_workspaces_request) :: ExAws.Request.JSON.response_t
  def rebuild_workspaces(client, input) do
    request(client, "RebuildWorkspaces", format_input(input))
  end

  @doc """
  Same as `rebuild_workspaces/2` but raise on error.
  """
  @spec rebuild_workspaces!(client :: ExAws.Workspaces.t, input :: rebuild_workspaces_request) :: ExAws.Request.JSON.success_t | no_return
  def rebuild_workspaces!(client, input) do
    case rebuild_workspaces(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  TerminateWorkspaces

  Terminates the specified WorkSpaces.

  Terminating a WorkSpace is a permanent action and cannot be undone. The
  user's data is not maintained and will be destroyed. If you need to archive
  any user data, contact Amazon Web Services before terminating the
  WorkSpace.

  You can terminate a WorkSpace that is in any state except `SUSPENDED`.

  Note: This operation is asynchronous and will return before the WorkSpaces
  have been completely terminated.
  """

  @spec terminate_workspaces(client :: ExAws.Workspaces.t, input :: terminate_workspaces_request) :: ExAws.Request.JSON.response_t
  def terminate_workspaces(client, input) do
    request(client, "TerminateWorkspaces", format_input(input))
  end

  @doc """
  Same as `terminate_workspaces/2` but raise on error.
  """
  @spec terminate_workspaces!(client :: ExAws.Workspaces.t, input :: terminate_workspaces_request) :: ExAws.Request.JSON.success_t | no_return
  def terminate_workspaces!(client, input) do
    case terminate_workspaces(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  defp request(%{__struct__: client_module} = client, action, input) do
    apply(client_module, :request, [client, action, input])
  end
end
