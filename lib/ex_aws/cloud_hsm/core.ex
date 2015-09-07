defmodule ExAws.CloudHSM.Core do
  import ExAws.Core.JSON, only: [format_input: 1]
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

  @moduledoc """
  ## Amazon CloudHSM

  AWS CloudHSM Service
  """

  @type az :: binary

  @type az_list :: [az]

  @type certificate :: binary

  @type certificate_fingerprint :: binary

  @type client_arn :: binary

  @type client_label :: binary

  @type client_list :: [client_arn]

  @type client_token :: binary

  @type client_version :: binary

  @type cloud_hsm_internal_exception :: [
  ]

  @type cloud_hsm_object_state :: binary

  @type cloud_hsm_service_exception :: [
    message: binary,
    retryable: boolean,
  ]

  @type create_hapg_request :: [
    label: label,
  ]

  @type create_hapg_response :: [
    hapg_arn: hapg_arn,
  ]

  @type create_hsm_request :: [
    client_token: client_token,
    eni_ip: ip_address,
    external_id: external_id,
    iam_role_arn: iam_role_arn,
    ssh_key: ssh_key,
    subnet_id: subnet_id,
    subscription_type: subscription_type,
    syslog_ip: ip_address,
  ]

  @type create_hsm_response :: [
    hsm_arn: hsm_arn,
  ]

  @type create_luna_client_request :: [
    certificate: certificate,
    label: client_label,
  ]

  @type create_luna_client_response :: [
    client_arn: client_arn,
  ]

  @type delete_hapg_request :: [
    hapg_arn: hapg_arn,
  ]

  @type delete_hapg_response :: [
    status: binary,
  ]

  @type delete_hsm_request :: [
    hsm_arn: hsm_arn,
  ]

  @type delete_hsm_response :: [
    status: binary,
  ]

  @type delete_luna_client_request :: [
    client_arn: client_arn,
  ]

  @type delete_luna_client_response :: [
    status: binary,
  ]

  @type describe_hapg_request :: [
    hapg_arn: hapg_arn,
  ]

  @type describe_hapg_response :: [
    hapg_arn: hapg_arn,
    hapg_serial: binary,
    hsms_last_action_failed: hsm_list,
    hsms_pending_deletion: hsm_list,
    hsms_pending_registration: hsm_list,
    label: label,
    last_modified_timestamp: timestamp,
    partition_serial_list: partition_serial_list,
    state: cloud_hsm_object_state,
  ]

  @type describe_hsm_request :: [
    hsm_arn: hsm_arn,
    hsm_serial_number: hsm_serial_number,
  ]

  @type describe_hsm_response :: [
    availability_zone: az,
    eni_id: eni_id,
    eni_ip: ip_address,
    hsm_arn: hsm_arn,
    hsm_type: binary,
    iam_role_arn: iam_role_arn,
    partitions: partition_list,
    serial_number: hsm_serial_number,
    server_cert_last_updated: timestamp,
    server_cert_uri: binary,
    software_version: binary,
    ssh_key_last_updated: timestamp,
    ssh_public_key: ssh_key,
    status: hsm_status,
    status_details: binary,
    subnet_id: subnet_id,
    subscription_end_date: timestamp,
    subscription_start_date: timestamp,
    subscription_type: subscription_type,
    vendor_name: binary,
    vpc_id: vpc_id,
  ]

  @type describe_luna_client_request :: [
    certificate_fingerprint: certificate_fingerprint,
    client_arn: client_arn,
  ]

  @type describe_luna_client_response :: [
    certificate: certificate,
    certificate_fingerprint: certificate_fingerprint,
    client_arn: client_arn,
    label: label,
    last_modified_timestamp: timestamp,
  ]

  @type eni_id :: binary

  @type external_id :: binary

  @type get_config_request :: [
    client_arn: client_arn,
    client_version: client_version,
    hapg_list: hapg_list,
  ]

  @type get_config_response :: [
    config_cred: binary,
    config_file: binary,
    config_type: binary,
  ]

  @type hapg_arn :: binary

  @type hapg_list :: [hapg_arn]

  @type hsm_arn :: binary

  @type hsm_list :: [hsm_arn]

  @type hsm_serial_number :: binary

  @type hsm_status :: binary

  @type iam_role_arn :: binary

  @type invalid_request_exception :: [
  ]

  @type ip_address :: binary

  @type label :: binary

  @type list_available_zones_request :: [
  ]

  @type list_available_zones_response :: [
    az_list: az_list,
  ]

  @type list_hapgs_request :: [
    next_token: pagination_token,
  ]

  @type list_hapgs_response :: [
    hapg_list: hapg_list,
    next_token: pagination_token,
  ]

  @type list_hsms_request :: [
    next_token: pagination_token,
  ]

  @type list_hsms_response :: [
    hsm_list: hsm_list,
    next_token: pagination_token,
  ]

  @type list_luna_clients_request :: [
    next_token: pagination_token,
  ]

  @type list_luna_clients_response :: [
    client_list: client_list,
    next_token: pagination_token,
  ]

  @type modify_hapg_request :: [
    hapg_arn: hapg_arn,
    label: label,
    partition_serial_list: partition_serial_list,
  ]

  @type modify_hapg_response :: [
    hapg_arn: hapg_arn,
  ]

  @type modify_hsm_request :: [
    eni_ip: ip_address,
    external_id: external_id,
    hsm_arn: hsm_arn,
    iam_role_arn: iam_role_arn,
    subnet_id: subnet_id,
    syslog_ip: ip_address,
  ]

  @type modify_hsm_response :: [
    hsm_arn: hsm_arn,
  ]

  @type modify_luna_client_request :: [
    certificate: certificate,
    client_arn: client_arn,
  ]

  @type modify_luna_client_response :: [
    client_arn: client_arn,
  ]

  @type pagination_token :: binary

  @type partition_arn :: binary

  @type partition_list :: [partition_arn]

  @type partition_serial :: binary

  @type partition_serial_list :: [partition_serial]

  @type ssh_key :: binary

  @type subnet_id :: binary

  @type subscription_type :: binary

  @type timestamp :: binary

  @type vpc_id :: binary





  @doc """
  CreateHapg

  Creates a high-availability partition group. A high-availability partition
  group is a group of partitions that spans multiple physical HSMs.
  """

  @spec create_hapg(client :: ExAws.CloudHSM.t, input :: create_hapg_request) :: ExAws.Request.JSON.response_t
  def create_hapg(client, input) do
    request(client, "CreateHapg", format_input(input))
  end

  @doc """
  Same as `create_hapg/2` but raise on error.
  """
  @spec create_hapg!(client :: ExAws.CloudHSM.t, input :: create_hapg_request) :: ExAws.Request.JSON.success_t | no_return
  def create_hapg!(client, input) do
    case create_hapg(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateHsm

  Creates an uninitialized HSM instance.

  There is an upfront fee charged for each HSM instance that you create with
  the `CreateHsm` operation. If you accidentally provision an HSM and want to
  request a refund, delete the instance using the `DeleteHsm` operation, go
  to the [AWS Support Center](https://console.aws.amazon.com/support/home#/),
  create a new case, and select **Account and Billing Support**.

  ** It can take up to 20 minutes to create and provision an HSM. You can
  monitor the status of the HSM with the `DescribeHsm` operation. The HSM is
  ready to be initialized when the status changes to `RUNNING`.

  **
  """

  @spec create_hsm(client :: ExAws.CloudHSM.t, input :: create_hsm_request) :: ExAws.Request.JSON.response_t
  def create_hsm(client, input) do
    request(client, "CreateHsm", format_input(input))
  end

  @doc """
  Same as `create_hsm/2` but raise on error.
  """
  @spec create_hsm!(client :: ExAws.CloudHSM.t, input :: create_hsm_request) :: ExAws.Request.JSON.success_t | no_return
  def create_hsm!(client, input) do
    case create_hsm(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateLunaClient

  Creates an HSM client.
  """

  @spec create_luna_client(client :: ExAws.CloudHSM.t, input :: create_luna_client_request) :: ExAws.Request.JSON.response_t
  def create_luna_client(client, input) do
    request(client, "CreateLunaClient", format_input(input))
  end

  @doc """
  Same as `create_luna_client/2` but raise on error.
  """
  @spec create_luna_client!(client :: ExAws.CloudHSM.t, input :: create_luna_client_request) :: ExAws.Request.JSON.success_t | no_return
  def create_luna_client!(client, input) do
    case create_luna_client(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteHapg

  Deletes a high-availability partition group.
  """

  @spec delete_hapg(client :: ExAws.CloudHSM.t, input :: delete_hapg_request) :: ExAws.Request.JSON.response_t
  def delete_hapg(client, input) do
    request(client, "DeleteHapg", format_input(input))
  end

  @doc """
  Same as `delete_hapg/2` but raise on error.
  """
  @spec delete_hapg!(client :: ExAws.CloudHSM.t, input :: delete_hapg_request) :: ExAws.Request.JSON.success_t | no_return
  def delete_hapg!(client, input) do
    case delete_hapg(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteHsm

  Deletes an HSM. After completion, this operation cannot be undone and your
  key material cannot be recovered.
  """

  @spec delete_hsm(client :: ExAws.CloudHSM.t, input :: delete_hsm_request) :: ExAws.Request.JSON.response_t
  def delete_hsm(client, input) do
    request(client, "DeleteHsm", format_input(input))
  end

  @doc """
  Same as `delete_hsm/2` but raise on error.
  """
  @spec delete_hsm!(client :: ExAws.CloudHSM.t, input :: delete_hsm_request) :: ExAws.Request.JSON.success_t | no_return
  def delete_hsm!(client, input) do
    case delete_hsm(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteLunaClient

  Deletes a client.
  """

  @spec delete_luna_client(client :: ExAws.CloudHSM.t, input :: delete_luna_client_request) :: ExAws.Request.JSON.response_t
  def delete_luna_client(client, input) do
    request(client, "DeleteLunaClient", format_input(input))
  end

  @doc """
  Same as `delete_luna_client/2` but raise on error.
  """
  @spec delete_luna_client!(client :: ExAws.CloudHSM.t, input :: delete_luna_client_request) :: ExAws.Request.JSON.success_t | no_return
  def delete_luna_client!(client, input) do
    case delete_luna_client(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeHapg

  Retrieves information about a high-availability partition group.
  """

  @spec describe_hapg(client :: ExAws.CloudHSM.t, input :: describe_hapg_request) :: ExAws.Request.JSON.response_t
  def describe_hapg(client, input) do
    request(client, "DescribeHapg", format_input(input))
  end

  @doc """
  Same as `describe_hapg/2` but raise on error.
  """
  @spec describe_hapg!(client :: ExAws.CloudHSM.t, input :: describe_hapg_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_hapg!(client, input) do
    case describe_hapg(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeHsm

  Retrieves information about an HSM. You can identify the HSM by its ARN or
  its serial number.
  """

  @spec describe_hsm(client :: ExAws.CloudHSM.t, input :: describe_hsm_request) :: ExAws.Request.JSON.response_t
  def describe_hsm(client, input) do
    request(client, "DescribeHsm", format_input(input))
  end

  @doc """
  Same as `describe_hsm/2` but raise on error.
  """
  @spec describe_hsm!(client :: ExAws.CloudHSM.t, input :: describe_hsm_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_hsm!(client, input) do
    case describe_hsm(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeLunaClient

  Retrieves information about an HSM client.
  """

  @spec describe_luna_client(client :: ExAws.CloudHSM.t, input :: describe_luna_client_request) :: ExAws.Request.JSON.response_t
  def describe_luna_client(client, input) do
    request(client, "DescribeLunaClient", format_input(input))
  end

  @doc """
  Same as `describe_luna_client/2` but raise on error.
  """
  @spec describe_luna_client!(client :: ExAws.CloudHSM.t, input :: describe_luna_client_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_luna_client!(client, input) do
    case describe_luna_client(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetConfig

  Gets the configuration files necessary to connect to all high availability
  partition groups the client is associated with.
  """

  @spec get_config(client :: ExAws.CloudHSM.t, input :: get_config_request) :: ExAws.Request.JSON.response_t
  def get_config(client, input) do
    request(client, "GetConfig", format_input(input))
  end

  @doc """
  Same as `get_config/2` but raise on error.
  """
  @spec get_config!(client :: ExAws.CloudHSM.t, input :: get_config_request) :: ExAws.Request.JSON.success_t | no_return
  def get_config!(client, input) do
    case get_config(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListAvailableZones

  Lists the Availability Zones that have available AWS CloudHSM capacity.
  """

  @spec list_available_zones(client :: ExAws.CloudHSM.t, input :: list_available_zones_request) :: ExAws.Request.JSON.response_t
  def list_available_zones(client, input) do
    request(client, "ListAvailableZones", format_input(input))
  end

  @doc """
  Same as `list_available_zones/2` but raise on error.
  """
  @spec list_available_zones!(client :: ExAws.CloudHSM.t, input :: list_available_zones_request) :: ExAws.Request.JSON.success_t | no_return
  def list_available_zones!(client, input) do
    case list_available_zones(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListHapgs

  Lists the high-availability partition groups for the account.

  This operation supports pagination with the use of the *NextToken* member.
  If more results are available, the *NextToken* member of the response
  contains a token that you pass in the next call to `ListHapgs` to retrieve
  the next set of items.
  """

  @spec list_hapgs(client :: ExAws.CloudHSM.t, input :: list_hapgs_request) :: ExAws.Request.JSON.response_t
  def list_hapgs(client, input) do
    request(client, "ListHapgs", format_input(input))
  end

  @doc """
  Same as `list_hapgs/2` but raise on error.
  """
  @spec list_hapgs!(client :: ExAws.CloudHSM.t, input :: list_hapgs_request) :: ExAws.Request.JSON.success_t | no_return
  def list_hapgs!(client, input) do
    case list_hapgs(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
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

  @spec list_hsms(client :: ExAws.CloudHSM.t, input :: list_hsms_request) :: ExAws.Request.JSON.response_t
  def list_hsms(client, input) do
    request(client, "ListHsms", format_input(input))
  end

  @doc """
  Same as `list_hsms/2` but raise on error.
  """
  @spec list_hsms!(client :: ExAws.CloudHSM.t, input :: list_hsms_request) :: ExAws.Request.JSON.success_t | no_return
  def list_hsms!(client, input) do
    case list_hsms(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListLunaClients

  Lists all of the clients.

  This operation supports pagination with the use of the *NextToken* member.
  If more results are available, the *NextToken* member of the response
  contains a token that you pass in the next call to `ListLunaClients` to
  retrieve the next set of items.
  """

  @spec list_luna_clients(client :: ExAws.CloudHSM.t, input :: list_luna_clients_request) :: ExAws.Request.JSON.response_t
  def list_luna_clients(client, input) do
    request(client, "ListLunaClients", format_input(input))
  end

  @doc """
  Same as `list_luna_clients/2` but raise on error.
  """
  @spec list_luna_clients!(client :: ExAws.CloudHSM.t, input :: list_luna_clients_request) :: ExAws.Request.JSON.success_t | no_return
  def list_luna_clients!(client, input) do
    case list_luna_clients(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ModifyHapg

  Modifies an existing high-availability partition group.
  """

  @spec modify_hapg(client :: ExAws.CloudHSM.t, input :: modify_hapg_request) :: ExAws.Request.JSON.response_t
  def modify_hapg(client, input) do
    request(client, "ModifyHapg", format_input(input))
  end

  @doc """
  Same as `modify_hapg/2` but raise on error.
  """
  @spec modify_hapg!(client :: ExAws.CloudHSM.t, input :: modify_hapg_request) :: ExAws.Request.JSON.success_t | no_return
  def modify_hapg!(client, input) do
    case modify_hapg(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ModifyHsm

  Modifies an HSM.

  ** This operation can result in the HSM being offline for up to 15 minutes
  while the AWS CloudHSM service is reconfigured. If you are modifying a
  production HSM, you should ensure that your AWS CloudHSM service is
  configured for high availability, and consider executing this operation
  during a maintenance window.

  **
  """

  @spec modify_hsm(client :: ExAws.CloudHSM.t, input :: modify_hsm_request) :: ExAws.Request.JSON.response_t
  def modify_hsm(client, input) do
    request(client, "ModifyHsm", format_input(input))
  end

  @doc """
  Same as `modify_hsm/2` but raise on error.
  """
  @spec modify_hsm!(client :: ExAws.CloudHSM.t, input :: modify_hsm_request) :: ExAws.Request.JSON.success_t | no_return
  def modify_hsm!(client, input) do
    case modify_hsm(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ModifyLunaClient

  Modifies the certificate used by the client.

  This action can potentially start a workflow to install the new certificate
  on the client's HSMs.
  """

  @spec modify_luna_client(client :: ExAws.CloudHSM.t, input :: modify_luna_client_request) :: ExAws.Request.JSON.response_t
  def modify_luna_client(client, input) do
    request(client, "ModifyLunaClient", format_input(input))
  end

  @doc """
  Same as `modify_luna_client/2` but raise on error.
  """
  @spec modify_luna_client!(client :: ExAws.CloudHSM.t, input :: modify_luna_client_request) :: ExAws.Request.JSON.success_t | no_return
  def modify_luna_client!(client, input) do
    case modify_luna_client(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  defp request(%{__struct__: client_module} = client, action, input) do
    apply(client_module, :request, [client, action, input])
  end
end
