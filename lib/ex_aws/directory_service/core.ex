defmodule ExAws.DirectoryService.Core do
  import ExAws.Core.JSON, only: [format_input: 1]
  @actions [
    "ConnectDirectory",
    "CreateAlias",
    "CreateComputer",
    "CreateDirectory",
    "CreateSnapshot",
    "DeleteDirectory",
    "DeleteSnapshot",
    "DescribeDirectories",
    "DescribeSnapshots",
    "DisableRadius",
    "DisableSso",
    "EnableRadius",
    "EnableSso",
    "GetDirectoryLimits",
    "GetSnapshotLimits",
    "RestoreFromSnapshot",
    "UpdateRadius"]

  @moduledoc """
  ## AWS Directory Service

  AWS Directory Service

  This is the *AWS Directory Service API Reference*. This guide provides
  detailed information about AWS Directory Service operations, data types,
  parameters, and errors.
  """

  @type access_url :: binary

  @type alias_name :: binary

  @type attribute :: [
    name: attribute_name,
    value: attribute_value,
  ]

  @type attribute_name :: binary

  @type attribute_value :: binary

  @type attributes :: [attribute]

  @type authentication_failed_exception :: [
    message: exception_message,
    request_id: request_id,
  ]

  @type availability_zone :: binary

  @type availability_zones :: [availability_zone]

  @type client_exception :: [
    message: exception_message,
    request_id: request_id,
  ]

  @type cloud_only_directories_limit_reached :: boolean

  @type computer :: [
    computer_attributes: attributes,
    computer_id: sid,
    computer_name: computer_name,
  ]

  @type computer_name :: binary

  @type computer_password :: binary

  @type connect_directory_request :: [
    connect_settings: directory_connect_settings,
    description: description,
    name: directory_name,
    password: connect_password,
    short_name: directory_short_name,
    size: directory_size,
  ]

  @type connect_directory_result :: [
    directory_id: directory_id,
  ]

  @type connect_password :: binary

  @type connected_directories_limit_reached :: boolean

  @type create_alias_request :: [
    alias: alias_name,
    directory_id: directory_id,
  ]

  @type create_alias_result :: [
    alias: alias_name,
    directory_id: directory_id,
  ]

  @type create_computer_request :: [
    computer_attributes: attributes,
    computer_name: computer_name,
    directory_id: directory_id,
    organizational_unit_distinguished_name: organizational_unit_dn,
    password: computer_password,
  ]

  @type create_computer_result :: [
    computer: computer,
  ]

  @type create_directory_request :: [
    description: description,
    name: directory_name,
    password: password,
    short_name: directory_short_name,
    size: directory_size,
    vpc_settings: directory_vpc_settings,
  ]

  @type create_directory_result :: [
    directory_id: directory_id,
  ]

  @type create_snapshot_request :: [
    directory_id: directory_id,
    name: snapshot_name,
  ]

  @type create_snapshot_result :: [
    snapshot_id: snapshot_id,
  ]

  @type delete_directory_request :: [
    directory_id: directory_id,
  ]

  @type delete_directory_result :: [
    directory_id: directory_id,
  ]

  @type delete_snapshot_request :: [
    snapshot_id: snapshot_id,
  ]

  @type delete_snapshot_result :: [
    snapshot_id: snapshot_id,
  ]

  @type describe_directories_request :: [
    directory_ids: directory_ids,
    limit: limit,
    next_token: next_token,
  ]

  @type describe_directories_result :: [
    directory_descriptions: directory_descriptions,
    next_token: next_token,
  ]

  @type describe_snapshots_request :: [
    directory_id: directory_id,
    limit: limit,
    next_token: next_token,
    snapshot_ids: snapshot_ids,
  ]

  @type describe_snapshots_result :: [
    next_token: next_token,
    snapshots: snapshots,
  ]

  @type description :: binary

  @type directory_connect_settings :: [
    customer_dns_ips: dns_ip_addrs,
    customer_user_name: user_name,
    subnet_ids: subnet_ids,
    vpc_id: vpc_id,
  ]

  @type directory_connect_settings_description :: [
    availability_zones: availability_zones,
    connect_ips: ip_addrs,
    customer_user_name: user_name,
    security_group_id: security_group_id,
    subnet_ids: subnet_ids,
    vpc_id: vpc_id,
  ]

  @type directory_description :: [
    access_url: access_url,
    alias: alias_name,
    connect_settings: directory_connect_settings_description,
    description: description,
    directory_id: directory_id,
    dns_ip_addrs: dns_ip_addrs,
    launch_time: launch_time,
    name: directory_name,
    radius_settings: radius_settings,
    radius_status: radius_status,
    short_name: directory_short_name,
    size: directory_size,
    sso_enabled: sso_enabled,
    stage: directory_stage,
    stage_last_updated_date_time: last_updated_date_time,
    stage_reason: stage_reason,
    type: directory_type,
    vpc_settings: directory_vpc_settings_description,
  ]

  @type directory_descriptions :: [directory_description]

  @type directory_id :: binary

  @type directory_ids :: [directory_id]

  @type directory_limit_exceeded_exception :: [
    message: exception_message,
    request_id: request_id,
  ]

  @type directory_limits :: [
    cloud_only_directories_current_count: limit,
    cloud_only_directories_limit: limit,
    cloud_only_directories_limit_reached: cloud_only_directories_limit_reached,
    connected_directories_current_count: limit,
    connected_directories_limit: limit,
    connected_directories_limit_reached: connected_directories_limit_reached,
  ]

  @type directory_name :: binary

  @type directory_short_name :: binary

  @type directory_size :: binary

  @type directory_stage :: binary

  @type directory_type :: binary

  @type directory_unavailable_exception :: [
    message: exception_message,
    request_id: request_id,
  ]

  @type directory_vpc_settings :: [
    subnet_ids: subnet_ids,
    vpc_id: vpc_id,
  ]

  @type directory_vpc_settings_description :: [
    availability_zones: availability_zones,
    security_group_id: security_group_id,
    subnet_ids: subnet_ids,
    vpc_id: vpc_id,
  ]

  @type disable_radius_request :: [
    directory_id: directory_id,
  ]

  @type disable_radius_result :: [
  ]

  @type disable_sso_request :: [
    directory_id: directory_id,
    password: connect_password,
    user_name: user_name,
  ]

  @type disable_sso_result :: [
  ]

  @type dns_ip_addrs :: [ip_addr]

  @type enable_radius_request :: [
    directory_id: directory_id,
    radius_settings: radius_settings,
  ]

  @type enable_radius_result :: [
  ]

  @type enable_sso_request :: [
    directory_id: directory_id,
    password: connect_password,
    user_name: user_name,
  ]

  @type enable_sso_result :: [
  ]

  @type entity_already_exists_exception :: [
    message: exception_message,
    request_id: request_id,
  ]

  @type entity_does_not_exist_exception :: [
    message: exception_message,
    request_id: request_id,
  ]

  @type exception_message :: binary

  @type get_directory_limits_request :: [
  ]

  @type get_directory_limits_result :: [
    directory_limits: directory_limits,
  ]

  @type get_snapshot_limits_request :: [
    directory_id: directory_id,
  ]

  @type get_snapshot_limits_result :: [
    snapshot_limits: snapshot_limits,
  ]

  @type insufficient_permissions_exception :: [
    message: exception_message,
    request_id: request_id,
  ]

  @type invalid_next_token_exception :: [
    message: exception_message,
    request_id: request_id,
  ]

  @type invalid_parameter_exception :: [
    message: exception_message,
    request_id: request_id,
  ]

  @type ip_addr :: binary

  @type ip_addrs :: [ip_addr]

  @type last_updated_date_time :: integer

  @type launch_time :: integer

  @type limit :: integer

  @type manual_snapshots_limit_reached :: boolean

  @type next_token :: binary

  @type organizational_unit_dn :: binary

  @type password :: binary

  @type port_number :: integer

  @type radius_authentication_protocol :: binary

  @type radius_display_label :: binary

  @type radius_retries :: integer

  @type radius_settings :: [
    authentication_protocol: radius_authentication_protocol,
    display_label: radius_display_label,
    radius_port: port_number,
    radius_retries: radius_retries,
    radius_servers: servers,
    radius_timeout: radius_timeout,
    shared_secret: radius_shared_secret,
    use_same_username: use_same_username,
  ]

  @type radius_shared_secret :: binary

  @type radius_status :: binary

  @type radius_timeout :: integer

  @type request_id :: binary

  @type restore_from_snapshot_request :: [
    snapshot_id: snapshot_id,
  ]

  @type restore_from_snapshot_result :: [
  ]

  @type sid :: binary

  @type security_group_id :: binary

  @type server :: binary

  @type servers :: [server]

  @type service_exception :: [
    message: exception_message,
    request_id: request_id,
  ]

  @type snapshot :: [
    directory_id: directory_id,
    name: snapshot_name,
    snapshot_id: snapshot_id,
    start_time: start_time,
    status: snapshot_status,
    type: snapshot_type,
  ]

  @type snapshot_id :: binary

  @type snapshot_ids :: [snapshot_id]

  @type snapshot_limit_exceeded_exception :: [
    message: exception_message,
    request_id: request_id,
  ]

  @type snapshot_limits :: [
    manual_snapshots_current_count: limit,
    manual_snapshots_limit: limit,
    manual_snapshots_limit_reached: manual_snapshots_limit_reached,
  ]

  @type snapshot_name :: binary

  @type snapshot_status :: binary

  @type snapshot_type :: binary

  @type snapshots :: [snapshot]

  @type sso_enabled :: boolean

  @type stage_reason :: binary

  @type start_time :: integer

  @type subnet_id :: binary

  @type subnet_ids :: [subnet_id]

  @type unsupported_operation_exception :: [
    message: exception_message,
    request_id: request_id,
  ]

  @type update_radius_request :: [
    directory_id: directory_id,
    radius_settings: radius_settings,
  ]

  @type update_radius_result :: [
  ]

  @type use_same_username :: boolean

  @type user_name :: binary

  @type vpc_id :: binary





  @doc """
  ConnectDirectory

  Creates an AD Connector to connect an on-premises directory.
  """

  @spec connect_directory(client :: ExAws.DirectoryService.t, input :: connect_directory_request) :: ExAws.Request.JSON.response_t
  def connect_directory(client, input) do
    request(client, "ConnectDirectory", format_input(input))
  end

  @doc """
  Same as `connect_directory/2` but raise on error.
  """
  @spec connect_directory!(client :: ExAws.DirectoryService.t, input :: connect_directory_request) :: ExAws.Request.JSON.success_t | no_return
  def connect_directory!(client, input) do
    case connect_directory(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateAlias

  Creates an alias for a directory and assigns the alias to the directory.
  The alias is used to construct the access URL for the directory, such as
  `http://&#x3C;alias&#x3E;.awsapps.com`.

  ** After an alias has been created, it cannot be deleted or reused, so this
  operation should only be used when absolutely necessary.

  **
  """

  @spec create_alias(client :: ExAws.DirectoryService.t, input :: create_alias_request) :: ExAws.Request.JSON.response_t
  def create_alias(client, input) do
    request(client, "CreateAlias", format_input(input))
  end

  @doc """
  Same as `create_alias/2` but raise on error.
  """
  @spec create_alias!(client :: ExAws.DirectoryService.t, input :: create_alias_request) :: ExAws.Request.JSON.success_t | no_return
  def create_alias!(client, input) do
    case create_alias(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateComputer

  Creates a computer account in the specified directory, and joins the
  computer to the directory.
  """

  @spec create_computer(client :: ExAws.DirectoryService.t, input :: create_computer_request) :: ExAws.Request.JSON.response_t
  def create_computer(client, input) do
    request(client, "CreateComputer", format_input(input))
  end

  @doc """
  Same as `create_computer/2` but raise on error.
  """
  @spec create_computer!(client :: ExAws.DirectoryService.t, input :: create_computer_request) :: ExAws.Request.JSON.success_t | no_return
  def create_computer!(client, input) do
    case create_computer(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateDirectory

  Creates a Simple AD directory.
  """

  @spec create_directory(client :: ExAws.DirectoryService.t, input :: create_directory_request) :: ExAws.Request.JSON.response_t
  def create_directory(client, input) do
    request(client, "CreateDirectory", format_input(input))
  end

  @doc """
  Same as `create_directory/2` but raise on error.
  """
  @spec create_directory!(client :: ExAws.DirectoryService.t, input :: create_directory_request) :: ExAws.Request.JSON.success_t | no_return
  def create_directory!(client, input) do
    case create_directory(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateSnapshot

  Creates a snapshot of an existing directory.

  You cannot take snapshots of extended or connected directories.
  """

  @spec create_snapshot(client :: ExAws.DirectoryService.t, input :: create_snapshot_request) :: ExAws.Request.JSON.response_t
  def create_snapshot(client, input) do
    request(client, "CreateSnapshot", format_input(input))
  end

  @doc """
  Same as `create_snapshot/2` but raise on error.
  """
  @spec create_snapshot!(client :: ExAws.DirectoryService.t, input :: create_snapshot_request) :: ExAws.Request.JSON.success_t | no_return
  def create_snapshot!(client, input) do
    case create_snapshot(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteDirectory

  Deletes an AWS Directory Service directory.
  """

  @spec delete_directory(client :: ExAws.DirectoryService.t, input :: delete_directory_request) :: ExAws.Request.JSON.response_t
  def delete_directory(client, input) do
    request(client, "DeleteDirectory", format_input(input))
  end

  @doc """
  Same as `delete_directory/2` but raise on error.
  """
  @spec delete_directory!(client :: ExAws.DirectoryService.t, input :: delete_directory_request) :: ExAws.Request.JSON.success_t | no_return
  def delete_directory!(client, input) do
    case delete_directory(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteSnapshot

  Deletes a directory snapshot.
  """

  @spec delete_snapshot(client :: ExAws.DirectoryService.t, input :: delete_snapshot_request) :: ExAws.Request.JSON.response_t
  def delete_snapshot(client, input) do
    request(client, "DeleteSnapshot", format_input(input))
  end

  @doc """
  Same as `delete_snapshot/2` but raise on error.
  """
  @spec delete_snapshot!(client :: ExAws.DirectoryService.t, input :: delete_snapshot_request) :: ExAws.Request.JSON.success_t | no_return
  def delete_snapshot!(client, input) do
    case delete_snapshot(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeDirectories

  Obtains information about the directories that belong to this account.

  You can retrieve information about specific directories by passing the
  directory identifiers in the *DirectoryIds* parameter. Otherwise, all
  directories that belong to the current account are returned.

  This operation supports pagination with the use of the *NextToken* request
  and response parameters. If more results are available, the
  *DescribeDirectoriesResult.NextToken* member contains a token that you pass
  in the next call to `DescribeDirectories` to retrieve the next set of
  items.

  You can also specify a maximum number of return results with the *Limit*
  parameter.
  """

  @spec describe_directories(client :: ExAws.DirectoryService.t, input :: describe_directories_request) :: ExAws.Request.JSON.response_t
  def describe_directories(client, input) do
    request(client, "DescribeDirectories", format_input(input))
  end

  @doc """
  Same as `describe_directories/2` but raise on error.
  """
  @spec describe_directories!(client :: ExAws.DirectoryService.t, input :: describe_directories_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_directories!(client, input) do
    case describe_directories(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeSnapshots

  Obtains information about the directory snapshots that belong to this
  account.

  This operation supports pagination with the use of the *NextToken* request
  and response parameters. If more results are available, the
  *DescribeSnapshots.NextToken* member contains a token that you pass in the
  next call to `DescribeSnapshots` to retrieve the next set of items.

  You can also specify a maximum number of return results with the *Limit*
  parameter.
  """

  @spec describe_snapshots(client :: ExAws.DirectoryService.t, input :: describe_snapshots_request) :: ExAws.Request.JSON.response_t
  def describe_snapshots(client, input) do
    request(client, "DescribeSnapshots", format_input(input))
  end

  @doc """
  Same as `describe_snapshots/2` but raise on error.
  """
  @spec describe_snapshots!(client :: ExAws.DirectoryService.t, input :: describe_snapshots_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_snapshots!(client, input) do
    case describe_snapshots(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DisableRadius

  Disables multi-factor authentication (MFA) with Remote Authentication Dial
  In User Service (RADIUS) for an AD Connector directory.
  """

  @spec disable_radius(client :: ExAws.DirectoryService.t, input :: disable_radius_request) :: ExAws.Request.JSON.response_t
  def disable_radius(client, input) do
    request(client, "DisableRadius", format_input(input))
  end

  @doc """
  Same as `disable_radius/2` but raise on error.
  """
  @spec disable_radius!(client :: ExAws.DirectoryService.t, input :: disable_radius_request) :: ExAws.Request.JSON.success_t | no_return
  def disable_radius!(client, input) do
    case disable_radius(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DisableSso

  Disables single-sign on for a directory.
  """

  @spec disable_sso(client :: ExAws.DirectoryService.t, input :: disable_sso_request) :: ExAws.Request.JSON.response_t
  def disable_sso(client, input) do
    request(client, "DisableSso", format_input(input))
  end

  @doc """
  Same as `disable_sso/2` but raise on error.
  """
  @spec disable_sso!(client :: ExAws.DirectoryService.t, input :: disable_sso_request) :: ExAws.Request.JSON.success_t | no_return
  def disable_sso!(client, input) do
    case disable_sso(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  EnableRadius

  Enables multi-factor authentication (MFA) with Remote Authentication Dial
  In User Service (RADIUS) for an AD Connector directory.
  """

  @spec enable_radius(client :: ExAws.DirectoryService.t, input :: enable_radius_request) :: ExAws.Request.JSON.response_t
  def enable_radius(client, input) do
    request(client, "EnableRadius", format_input(input))
  end

  @doc """
  Same as `enable_radius/2` but raise on error.
  """
  @spec enable_radius!(client :: ExAws.DirectoryService.t, input :: enable_radius_request) :: ExAws.Request.JSON.success_t | no_return
  def enable_radius!(client, input) do
    case enable_radius(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  EnableSso

  Enables single-sign on for a directory.
  """

  @spec enable_sso(client :: ExAws.DirectoryService.t, input :: enable_sso_request) :: ExAws.Request.JSON.response_t
  def enable_sso(client, input) do
    request(client, "EnableSso", format_input(input))
  end

  @doc """
  Same as `enable_sso/2` but raise on error.
  """
  @spec enable_sso!(client :: ExAws.DirectoryService.t, input :: enable_sso_request) :: ExAws.Request.JSON.success_t | no_return
  def enable_sso!(client, input) do
    case enable_sso(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetDirectoryLimits

  Obtains directory limit information for the current region.
  """

  @spec get_directory_limits(client :: ExAws.DirectoryService.t, input :: get_directory_limits_request) :: ExAws.Request.JSON.response_t
  def get_directory_limits(client, input) do
    request(client, "GetDirectoryLimits", format_input(input))
  end

  @doc """
  Same as `get_directory_limits/2` but raise on error.
  """
  @spec get_directory_limits!(client :: ExAws.DirectoryService.t, input :: get_directory_limits_request) :: ExAws.Request.JSON.success_t | no_return
  def get_directory_limits!(client, input) do
    case get_directory_limits(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetSnapshotLimits

  Obtains the manual snapshot limits for a directory.
  """

  @spec get_snapshot_limits(client :: ExAws.DirectoryService.t, input :: get_snapshot_limits_request) :: ExAws.Request.JSON.response_t
  def get_snapshot_limits(client, input) do
    request(client, "GetSnapshotLimits", format_input(input))
  end

  @doc """
  Same as `get_snapshot_limits/2` but raise on error.
  """
  @spec get_snapshot_limits!(client :: ExAws.DirectoryService.t, input :: get_snapshot_limits_request) :: ExAws.Request.JSON.success_t | no_return
  def get_snapshot_limits!(client, input) do
    case get_snapshot_limits(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RestoreFromSnapshot

  Restores a directory using an existing directory snapshot.

  When you restore a directory from a snapshot, any changes made to the
  directory after the snapshot date are overwritten.

  This action returns as soon as the restore operation is initiated. You can
  monitor the progress of the restore operation by calling the
  `DescribeDirectories` operation with the directory identifier. When the
  **DirectoryDescription.Stage** value changes to `Active`, the restore
  operation is complete.
  """

  @spec restore_from_snapshot(client :: ExAws.DirectoryService.t, input :: restore_from_snapshot_request) :: ExAws.Request.JSON.response_t
  def restore_from_snapshot(client, input) do
    request(client, "RestoreFromSnapshot", format_input(input))
  end

  @doc """
  Same as `restore_from_snapshot/2` but raise on error.
  """
  @spec restore_from_snapshot!(client :: ExAws.DirectoryService.t, input :: restore_from_snapshot_request) :: ExAws.Request.JSON.success_t | no_return
  def restore_from_snapshot!(client, input) do
    case restore_from_snapshot(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateRadius

  Updates the Remote Authentication Dial In User Service (RADIUS) server
  information for an AD Connector directory.
  """

  @spec update_radius(client :: ExAws.DirectoryService.t, input :: update_radius_request) :: ExAws.Request.JSON.response_t
  def update_radius(client, input) do
    request(client, "UpdateRadius", format_input(input))
  end

  @doc """
  Same as `update_radius/2` but raise on error.
  """
  @spec update_radius!(client :: ExAws.DirectoryService.t, input :: update_radius_request) :: ExAws.Request.JSON.success_t | no_return
  def update_radius!(client, input) do
    case update_radius(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  defp request(%{__struct__: client_module} = client, action, input) do
    apply(client_module, :request, [client, action, input])
  end
end
