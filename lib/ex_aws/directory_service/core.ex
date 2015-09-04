defmodule ExAws.DirectoryService.Core do
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


  @doc """
  ConnectDirectory

  Creates an AD Connector to connect an on-premises directory.
  """
  def connect_directory(client, input) do
    request(client, "ConnectDirectory", input)
  end

  @doc """
  CreateAlias

  Creates an alias for a directory and assigns the alias to the directory.
  The alias is used to construct the access URL for the directory, such as
  `http://&#x3C;alias&#x3E;.awsapps.com`.

  <important> After an alias has been created, it cannot be deleted or
  reused, so this operation should only be used when absolutely necessary.

  </important>
  """
  def create_alias(client, input) do
    request(client, "CreateAlias", input)
  end

  @doc """
  CreateComputer

  Creates a computer account in the specified directory, and joins the
  computer to the directory.
  """
  def create_computer(client, input) do
    request(client, "CreateComputer", input)
  end

  @doc """
  CreateDirectory

  Creates a Simple AD directory.
  """
  def create_directory(client, input) do
    request(client, "CreateDirectory", input)
  end

  @doc """
  CreateSnapshot

  Creates a snapshot of an existing directory.

  You cannot take snapshots of extended or connected directories.
  """
  def create_snapshot(client, input) do
    request(client, "CreateSnapshot", input)
  end

  @doc """
  DeleteDirectory

  Deletes an AWS Directory Service directory.
  """
  def delete_directory(client, input) do
    request(client, "DeleteDirectory", input)
  end

  @doc """
  DeleteSnapshot

  Deletes a directory snapshot.
  """
  def delete_snapshot(client, input) do
    request(client, "DeleteSnapshot", input)
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
  def describe_directories(client, input) do
    request(client, "DescribeDirectories", input)
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
  def describe_snapshots(client, input) do
    request(client, "DescribeSnapshots", input)
  end

  @doc """
  DisableRadius

  Disables multi-factor authentication (MFA) with Remote Authentication Dial
  In User Service (RADIUS) for an AD Connector directory.
  """
  def disable_radius(client, input) do
    request(client, "DisableRadius", input)
  end

  @doc """
  DisableSso

  Disables single-sign on for a directory.
  """
  def disable_sso(client, input) do
    request(client, "DisableSso", input)
  end

  @doc """
  EnableRadius

  Enables multi-factor authentication (MFA) with Remote Authentication Dial
  In User Service (RADIUS) for an AD Connector directory.
  """
  def enable_radius(client, input) do
    request(client, "EnableRadius", input)
  end

  @doc """
  EnableSso

  Enables single-sign on for a directory.
  """
  def enable_sso(client, input) do
    request(client, "EnableSso", input)
  end

  @doc """
  GetDirectoryLimits

  Obtains directory limit information for the current region.
  """
  def get_directory_limits(client, input) do
    request(client, "GetDirectoryLimits", input)
  end

  @doc """
  GetSnapshotLimits

  Obtains the manual snapshot limits for a directory.
  """
  def get_snapshot_limits(client, input) do
    request(client, "GetSnapshotLimits", input)
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
  def restore_from_snapshot(client, input) do
    request(client, "RestoreFromSnapshot", input)
  end

  @doc """
  UpdateRadius

  Updates the Remote Authentication Dial In User Service (RADIUS) server
  information for an AD Connector directory.
  """
  def update_radius(client, input) do
    request(client, "UpdateRadius", input)
  end


  defp request(%{__struct__: client_module} = client, action, input) do
    client_module.request(client, action, input)
  end
end
