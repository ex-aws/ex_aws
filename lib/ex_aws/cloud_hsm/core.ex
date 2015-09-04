defmodule ExAws.CloudHSM.Core do
  @actions [
    "CreateHapg",
    "CreateHsm",
    "CreateLunaClient",
    "DeleteHapg",
    "DeleteHsm",
    "DeleteLunaClient",
    "DescribeHapg",
    "DescribeHsm",
    "DescribeLunaClient",
    "GetConfig",
    "ListAvailableZones",
    "ListHapgs",
    "ListHsms",
    "ListLunaClients",
    "ModifyHapg",
    "ModifyHsm",
    "ModifyLunaClient"]


  @doc """
  CreateHapg

  Creates a high-availability partition group. A high-availability partition
  group is a group of partitions that spans multiple physical HSMs.
  """
  def create_hapg(client, input) do
    request(client, "CreateHapg", input)
  end

  @doc """
  CreateHsm

  Creates an uninitialized HSM instance.

  There is an upfront fee charged for each HSM instance that you create with
  the `CreateHsm` operation. If you accidentally provision an HSM and want to
  request a refund, delete the instance using the `DeleteHsm` operation, go
  to the [AWS Support Center](https://console.aws.amazon.com/support/home#/),
  create a new case, and select **Account and Billing Support**.

  <important> It can take up to 20 minutes to create and provision an HSM.
  You can monitor the status of the HSM with the `DescribeHsm` operation. The
  HSM is ready to be initialized when the status changes to `RUNNING`.

  </important>
  """
  def create_hsm(client, input) do
    request(client, "CreateHsm", input)
  end

  @doc """
  CreateLunaClient

  Creates an HSM client.
  """
  def create_luna_client(client, input) do
    request(client, "CreateLunaClient", input)
  end

  @doc """
  DeleteHapg

  Deletes a high-availability partition group.
  """
  def delete_hapg(client, input) do
    request(client, "DeleteHapg", input)
  end

  @doc """
  DeleteHsm

  Deletes an HSM. After completion, this operation cannot be undone and your
  key material cannot be recovered.
  """
  def delete_hsm(client, input) do
    request(client, "DeleteHsm", input)
  end

  @doc """
  DeleteLunaClient

  Deletes a client.
  """
  def delete_luna_client(client, input) do
    request(client, "DeleteLunaClient", input)
  end

  @doc """
  DescribeHapg

  Retrieves information about a high-availability partition group.
  """
  def describe_hapg(client, input) do
    request(client, "DescribeHapg", input)
  end

  @doc """
  DescribeHsm

  Retrieves information about an HSM. You can identify the HSM by its ARN or
  its serial number.
  """
  def describe_hsm(client, input) do
    request(client, "DescribeHsm", input)
  end

  @doc """
  DescribeLunaClient

  Retrieves information about an HSM client.
  """
  def describe_luna_client(client, input) do
    request(client, "DescribeLunaClient", input)
  end

  @doc """
  GetConfig

  Gets the configuration files necessary to connect to all high availability
  partition groups the client is associated with.
  """
  def get_config(client, input) do
    request(client, "GetConfig", input)
  end

  @doc """
  ListAvailableZones

  Lists the Availability Zones that have available AWS CloudHSM capacity.
  """
  def list_available_zones(client, input) do
    request(client, "ListAvailableZones", input)
  end

  @doc """
  ListHapgs

  Lists the high-availability partition groups for the account.

  This operation supports pagination with the use of the *NextToken* member.
  If more results are available, the *NextToken* member of the response
  contains a token that you pass in the next call to `ListHapgs` to retrieve
  the next set of items.
  """
  def list_hapgs(client, input) do
    request(client, "ListHapgs", input)
  end

  @doc """
  ListHsms

  Retrieves the identifiers of all of the HSMs provisioned for the current
  customer.

  This operation supports pagination with the use of the *NextToken* member.
  If more results are available, the *NextToken* member of the response
  contains a token that you pass in the next call to `ListHsms` to retrieve
  the next set of items.
  """
  def list_hsms(client, input) do
    request(client, "ListHsms", input)
  end

  @doc """
  ListLunaClients

  Lists all of the clients.

  This operation supports pagination with the use of the *NextToken* member.
  If more results are available, the *NextToken* member of the response
  contains a token that you pass in the next call to `ListLunaClients` to
  retrieve the next set of items.
  """
  def list_luna_clients(client, input) do
    request(client, "ListLunaClients", input)
  end

  @doc """
  ModifyHapg

  Modifies an existing high-availability partition group.
  """
  def modify_hapg(client, input) do
    request(client, "ModifyHapg", input)
  end

  @doc """
  ModifyHsm

  Modifies an HSM.

  <important> This operation can result in the HSM being offline for up to 15
  minutes while the AWS CloudHSM service is reconfigured. If you are
  modifying a production HSM, you should ensure that your AWS CloudHSM
  service is configured for high availability, and consider executing this
  operation during a maintenance window.

  </important>
  """
  def modify_hsm(client, input) do
    request(client, "ModifyHsm", input)
  end

  @doc """
  ModifyLunaClient

  Modifies the certificate used by the client.

  This action can potentially start a workflow to install the new certificate
  on the client's HSMs.
  """
  def modify_luna_client(client, input) do
    request(client, "ModifyLunaClient", input)
  end


  defp request(%{__struct__: client_module} = client, action, input) do
    client_module.request(client, action, input)
  end
end
