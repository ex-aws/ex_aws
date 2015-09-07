defmodule ExAws.StorageGateway.Core do
  import ExAws.Core.JSON, only: [format_input: 1]
  @actions [
    "ActivateGateway",
    "AddCache",
    "AddUploadBuffer",
    "AddWorkingStorage",
    "CancelArchival",
    "CancelRetrieval",
    "CreateCachediSCSIVolume",
    "CreateSnapshot",
    "CreateSnapshotFromVolumeRecoveryPoint",
    "CreateStorediSCSIVolume",
    "CreateTapes",
    "DeleteBandwidthRateLimit",
    "DeleteChapCredentials",
    "DeleteGateway",
    "DeleteSnapshotSchedule",
    "DeleteTape",
    "DeleteTapeArchive",
    "DeleteVolume",
    "DescribeBandwidthRateLimit",
    "DescribeCache",
    "DescribeCachediSCSIVolumes",
    "DescribeChapCredentials",
    "DescribeGatewayInformation",
    "DescribeMaintenanceStartTime",
    "DescribeSnapshotSchedule",
    "DescribeStorediSCSIVolumes",
    "DescribeTapeArchives",
    "DescribeTapeRecoveryPoints",
    "DescribeTapes",
    "DescribeUploadBuffer",
    "DescribeVTLDevices",
    "DescribeWorkingStorage",
    "DisableGateway",
    "ListGateways",
    "ListLocalDisks",
    "ListVolumeInitiators",
    "ListVolumeRecoveryPoints",
    "ListVolumes",
    "ResetCache",
    "RetrieveTapeArchive",
    "RetrieveTapeRecoveryPoint",
    "ShutdownGateway",
    "StartGateway",
    "UpdateBandwidthRateLimit",
    "UpdateChapCredentials",
    "UpdateGatewayInformation",
    "UpdateGatewaySoftwareNow",
    "UpdateMaintenanceStartTime",
    "UpdateSnapshotSchedule",
    "UpdateVTLDeviceType"]

  @moduledoc """
  ## AWS Storage Gateway

  AWS Storage Gateway Service

  AWS Storage Gateway is the service that connects an on-premises software
  appliance with cloud-based storage to provide seamless and secure
  integration between an organization's on-premises IT environment and AWS's
  storage infrastructure. The service enables you to securely upload data to
  the AWS cloud for cost effective backup and rapid disaster recovery.

  Use the following links to get started using the *AWS Storage Gateway
  Service API Reference*:

  - [AWS Storage Gateway Required Request
  Headers](http://docs.aws.amazon.com/storagegateway/latest/userguide/AWSStorageGatewayHTTPRequestsHeaders.html):
  Describes the required headers that you must send with every POST request
  to AWS Storage Gateway.

  - [Signing
  Requests](http://docs.aws.amazon.com/storagegateway/latest/userguide/AWSStorageGatewaySigningRequests.html):
  AWS Storage Gateway requires that you authenticate every request you send;
  this topic describes how sign such a request.

  - [Error
  Responses](http://docs.aws.amazon.com/storagegateway/latest/userguide/APIErrorResponses.html):
  Provides reference information about AWS Storage Gateway errors.

  - [Operations in AWS Storage
  Gateway](http://docs.aws.amazon.com/storagegateway/latest/userguide/AWSStorageGatewayAPIOperations.html):
  Contains detailed descriptions of all AWS Storage Gateway operations, their
  request parameters, response elements, possible errors, and examples of
  requests and responses.

  - [AWS Storage Gateway Regions and
  Endpoints](http://docs.aws.amazon.com/general/latest/gr/index.html?rande.html):
  Provides a list of each of the regions and endpoints available for use with
  AWS Storage Gateway.
  """

  @type activate_gateway_input :: [
    activation_key: activation_key,
    gateway_name: gateway_name,
    gateway_region: region_id,
    gateway_timezone: gateway_timezone,
    gateway_type: gateway_type,
    medium_changer_type: medium_changer_type,
    tape_drive_type: tape_drive_type,
  ]

  @type activate_gateway_output :: [
    gateway_arn: gateway_arn,
  ]

  @type activation_key :: binary

  @type add_cache_input :: [
    disk_ids: disk_ids,
    gateway_arn: gateway_arn,
  ]

  @type add_cache_output :: [
    gateway_arn: gateway_arn,
  ]

  @type add_upload_buffer_input :: [
    disk_ids: disk_ids,
    gateway_arn: gateway_arn,
  ]

  @type add_upload_buffer_output :: [
    gateway_arn: gateway_arn,
  ]

  @type add_working_storage_input :: [
    disk_ids: disk_ids,
    gateway_arn: gateway_arn,
  ]

  @type add_working_storage_output :: [
    gateway_arn: gateway_arn,
  ]

  @type bandwidth_download_rate_limit :: integer

  @type bandwidth_type :: binary

  @type bandwidth_upload_rate_limit :: integer

  @type cachedi_scsi_volume :: [
    source_snapshot_id: snapshot_id,
    volume_arn: volume_arn,
    volume_id: volume_id,
    volume_progress: double_object,
    volume_size_in_bytes: long,
    volume_status: volume_status,
    volume_type: volume_type,
    volumei_scsi_attributes: volumei_scsi_attributes,
  ]

  @type cachedi_scsi_volumes :: [cachedi_scsi_volume]

  @type cancel_archival_input :: [
    gateway_arn: gateway_arn,
    tape_arn: tape_arn,
  ]

  @type cancel_archival_output :: [
    tape_arn: tape_arn,
  ]

  @type cancel_retrieval_input :: [
    gateway_arn: gateway_arn,
    tape_arn: tape_arn,
  ]

  @type cancel_retrieval_output :: [
    tape_arn: tape_arn,
  ]

  @type chap_credentials :: [chap_info]

  @type chap_info :: [
    initiator_name: iqn_name,
    secret_to_authenticate_initiator: chap_secret,
    secret_to_authenticate_target: chap_secret,
    target_arn: target_arn,
  ]

  @type chap_secret :: binary

  @type client_token :: binary

  @type create_cachedi_scsi_volume_input :: [
    client_token: client_token,
    gateway_arn: gateway_arn,
    network_interface_id: network_interface_id,
    snapshot_id: snapshot_id,
    target_name: target_name,
    volume_size_in_bytes: long,
  ]

  @type create_cachedi_scsi_volume_output :: [
    target_arn: target_arn,
    volume_arn: volume_arn,
  ]

  @type create_snapshot_from_volume_recovery_point_input :: [
    snapshot_description: snapshot_description,
    volume_arn: volume_arn,
  ]

  @type create_snapshot_from_volume_recovery_point_output :: [
    snapshot_id: snapshot_id,
    volume_arn: volume_arn,
    volume_recovery_point_time: binary,
  ]

  @type create_snapshot_input :: [
    snapshot_description: snapshot_description,
    volume_arn: volume_arn,
  ]

  @type create_snapshot_output :: [
    snapshot_id: snapshot_id,
    volume_arn: volume_arn,
  ]

  @type create_storedi_scsi_volume_input :: [
    disk_id: disk_id,
    gateway_arn: gateway_arn,
    network_interface_id: network_interface_id,
    preserve_existing_data: boolean,
    snapshot_id: snapshot_id,
    target_name: target_name,
  ]

  @type create_storedi_scsi_volume_output :: [
    target_arn: target_arn,
    volume_arn: volume_arn,
    volume_size_in_bytes: long,
  ]

  @type create_tapes_input :: [
    client_token: client_token,
    gateway_arn: gateway_arn,
    num_tapes_to_create: num_tapes_to_create,
    tape_barcode_prefix: tape_barcode_prefix,
    tape_size_in_bytes: tape_size,
  ]

  @type create_tapes_output :: [
    tape_ar_ns: tape_ar_ns,
  ]

  @type day_of_week :: integer

  @type delete_bandwidth_rate_limit_input :: [
    bandwidth_type: bandwidth_type,
    gateway_arn: gateway_arn,
  ]

  @type delete_bandwidth_rate_limit_output :: [
    gateway_arn: gateway_arn,
  ]

  @type delete_chap_credentials_input :: [
    initiator_name: iqn_name,
    target_arn: target_arn,
  ]

  @type delete_chap_credentials_output :: [
    initiator_name: iqn_name,
    target_arn: target_arn,
  ]

  @type delete_gateway_input :: [
    gateway_arn: gateway_arn,
  ]

  @type delete_gateway_output :: [
    gateway_arn: gateway_arn,
  ]

  @type delete_snapshot_schedule_input :: [
    volume_arn: volume_arn,
  ]

  @type delete_snapshot_schedule_output :: [
    volume_arn: volume_arn,
  ]

  @type delete_tape_archive_input :: [
    tape_arn: tape_arn,
  ]

  @type delete_tape_archive_output :: [
    tape_arn: tape_arn,
  ]

  @type delete_tape_input :: [
    gateway_arn: gateway_arn,
    tape_arn: tape_arn,
  ]

  @type delete_tape_output :: [
    tape_arn: tape_arn,
  ]

  @type delete_volume_input :: [
    volume_arn: volume_arn,
  ]

  @type delete_volume_output :: [
    volume_arn: volume_arn,
  ]

  @type describe_bandwidth_rate_limit_input :: [
    gateway_arn: gateway_arn,
  ]

  @type describe_bandwidth_rate_limit_output :: [
    average_download_rate_limit_in_bits_per_sec: bandwidth_download_rate_limit,
    average_upload_rate_limit_in_bits_per_sec: bandwidth_upload_rate_limit,
    gateway_arn: gateway_arn,
  ]

  @type describe_cache_input :: [
    gateway_arn: gateway_arn,
  ]

  @type describe_cache_output :: [
    cache_allocated_in_bytes: long,
    cache_dirty_percentage: double,
    cache_hit_percentage: double,
    cache_miss_percentage: double,
    cache_used_percentage: double,
    disk_ids: disk_ids,
    gateway_arn: gateway_arn,
  ]

  @type describe_cachedi_scsi_volumes_input :: [
    volume_ar_ns: volume_ar_ns,
  ]

  @type describe_cachedi_scsi_volumes_output :: [
    cachedi_scsi_volumes: cachedi_scsi_volumes,
  ]

  @type describe_chap_credentials_input :: [
    target_arn: target_arn,
  ]

  @type describe_chap_credentials_output :: [
    chap_credentials: chap_credentials,
  ]

  @type describe_gateway_information_input :: [
    gateway_arn: gateway_arn,
  ]

  @type describe_gateway_information_output :: [
    gateway_arn: gateway_arn,
    gateway_id: gateway_id,
    gateway_network_interfaces: gateway_network_interfaces,
    gateway_state: gateway_state,
    gateway_timezone: gateway_timezone,
    gateway_type: gateway_type,
    last_software_update: last_software_update,
    next_update_availability_date: next_update_availability_date,
  ]

  @type describe_maintenance_start_time_input :: [
    gateway_arn: gateway_arn,
  ]

  @type describe_maintenance_start_time_output :: [
    day_of_week: day_of_week,
    gateway_arn: gateway_arn,
    hour_of_day: hour_of_day,
    minute_of_hour: minute_of_hour,
    timezone: gateway_timezone,
  ]

  @type describe_snapshot_schedule_input :: [
    volume_arn: volume_arn,
  ]

  @type describe_snapshot_schedule_output :: [
    description: description,
    recurrence_in_hours: recurrence_in_hours,
    start_at: hour_of_day,
    timezone: gateway_timezone,
    volume_arn: volume_arn,
  ]

  @type describe_storedi_scsi_volumes_input :: [
    volume_ar_ns: volume_ar_ns,
  ]

  @type describe_storedi_scsi_volumes_output :: [
    storedi_scsi_volumes: storedi_scsi_volumes,
  ]

  @type describe_tape_archives_input :: [
    limit: positive_int_object,
    marker: marker,
    tape_ar_ns: tape_ar_ns,
  ]

  @type describe_tape_archives_output :: [
    marker: marker,
    tape_archives: tape_archives,
  ]

  @type describe_tape_recovery_points_input :: [
    gateway_arn: gateway_arn,
    limit: positive_int_object,
    marker: marker,
  ]

  @type describe_tape_recovery_points_output :: [
    gateway_arn: gateway_arn,
    marker: marker,
    tape_recovery_point_infos: tape_recovery_point_infos,
  ]

  @type describe_tapes_input :: [
    gateway_arn: gateway_arn,
    limit: positive_int_object,
    marker: marker,
    tape_ar_ns: tape_ar_ns,
  ]

  @type describe_tapes_output :: [
    marker: marker,
    tapes: tapes,
  ]

  @type describe_upload_buffer_input :: [
    gateway_arn: gateway_arn,
  ]

  @type describe_upload_buffer_output :: [
    disk_ids: disk_ids,
    gateway_arn: gateway_arn,
    upload_buffer_allocated_in_bytes: long,
    upload_buffer_used_in_bytes: long,
  ]

  @type describe_vtl_devices_input :: [
    gateway_arn: gateway_arn,
    limit: positive_int_object,
    marker: marker,
    vtl_device_ar_ns: vtl_device_ar_ns,
  ]

  @type describe_vtl_devices_output :: [
    gateway_arn: gateway_arn,
    marker: marker,
    vtl_devices: vtl_devices,
  ]

  @type describe_working_storage_input :: [
    gateway_arn: gateway_arn,
  ]

  @type describe_working_storage_output :: [
    disk_ids: disk_ids,
    gateway_arn: gateway_arn,
    working_storage_allocated_in_bytes: long,
    working_storage_used_in_bytes: long,
  ]

  @type description :: binary

  @type device_type :: binary

  @type devicei_scsi_attributes :: [
    chap_enabled: boolean,
    network_interface_id: network_interface_id,
    network_interface_port: integer,
    target_arn: target_arn,
  ]

  @type disable_gateway_input :: [
    gateway_arn: gateway_arn,
  ]

  @type disable_gateway_output :: [
    gateway_arn: gateway_arn,
  ]

  @type disk :: [
    disk_allocation_resource: binary,
    disk_allocation_type: disk_allocation_type,
    disk_id: disk_id,
    disk_node: binary,
    disk_path: binary,
    disk_size_in_bytes: long,
    disk_status: binary,
  ]

  @type disk_allocation_type :: binary

  @type disk_id :: binary

  @type disk_ids :: [disk_id]

  @type disks :: [disk]

  @type double_object :: float

  @type error_code :: binary

  @type gateway_arn :: binary

  @type gateway_id :: binary

  @type gateway_info :: [
    gateway_arn: gateway_arn,
    gateway_operational_state: gateway_operational_state,
    gateway_type: gateway_type,
  ]

  @type gateway_name :: binary

  @type gateway_network_interfaces :: [network_interface]

  @type gateway_operational_state :: binary

  @type gateway_state :: binary

  @type gateway_timezone :: binary

  @type gateway_type :: binary

  @type gateways :: [gateway_info]

  @type hour_of_day :: integer

  @type initiator :: binary

  @type initiators :: [initiator]

  @type internal_server_error :: [
    error: storage_gateway_error,
    message: binary,
  ]

  @type invalid_gateway_request_exception :: [
    error: storage_gateway_error,
    message: binary,
  ]

  @type iqn_name :: binary

  @type last_software_update :: binary

  @type list_gateways_input :: [
    limit: positive_int_object,
    marker: marker,
  ]

  @type list_gateways_output :: [
    gateways: gateways,
    marker: marker,
  ]

  @type list_local_disks_input :: [
    gateway_arn: gateway_arn,
  ]

  @type list_local_disks_output :: [
    disks: disks,
    gateway_arn: gateway_arn,
  ]

  @type list_volume_initiators_input :: [
    volume_arn: volume_arn,
  ]

  @type list_volume_initiators_output :: [
    initiators: initiators,
  ]

  @type list_volume_recovery_points_input :: [
    gateway_arn: gateway_arn,
  ]

  @type list_volume_recovery_points_output :: [
    gateway_arn: gateway_arn,
    volume_recovery_point_infos: volume_recovery_point_infos,
  ]

  @type list_volumes_input :: [
    gateway_arn: gateway_arn,
    limit: positive_int_object,
    marker: marker,
  ]

  @type list_volumes_output :: [
    gateway_arn: gateway_arn,
    marker: marker,
    volume_infos: volume_infos,
  ]

  @type marker :: binary

  @type medium_changer_type :: binary

  @type minute_of_hour :: integer

  @type network_interface :: [
    ipv4_address: binary,
    ipv6_address: binary,
    mac_address: binary,
  ]

  @type network_interface_id :: binary

  @type next_update_availability_date :: binary

  @type num_tapes_to_create :: integer

  @type positive_int_object :: integer

  @type recurrence_in_hours :: integer

  @type region_id :: binary

  @type reset_cache_input :: [
    gateway_arn: gateway_arn,
  ]

  @type reset_cache_output :: [
    gateway_arn: gateway_arn,
  ]

  @type retrieve_tape_archive_input :: [
    gateway_arn: gateway_arn,
    tape_arn: tape_arn,
  ]

  @type retrieve_tape_archive_output :: [
    tape_arn: tape_arn,
  ]

  @type retrieve_tape_recovery_point_input :: [
    gateway_arn: gateway_arn,
    tape_arn: tape_arn,
  ]

  @type retrieve_tape_recovery_point_output :: [
    tape_arn: tape_arn,
  ]

  @type shutdown_gateway_input :: [
    gateway_arn: gateway_arn,
  ]

  @type shutdown_gateway_output :: [
    gateway_arn: gateway_arn,
  ]

  @type snapshot_description :: binary

  @type snapshot_id :: binary

  @type start_gateway_input :: [
    gateway_arn: gateway_arn,
  ]

  @type start_gateway_output :: [
    gateway_arn: gateway_arn,
  ]

  @type storage_gateway_error :: [
    error_code: error_code,
    error_details: error_details,
  ]

  @type storedi_scsi_volume :: [
    preserved_existing_data: boolean,
    source_snapshot_id: snapshot_id,
    volume_arn: volume_arn,
    volume_disk_id: disk_id,
    volume_id: volume_id,
    volume_progress: double_object,
    volume_size_in_bytes: long,
    volume_status: volume_status,
    volume_type: volume_type,
    volumei_scsi_attributes: volumei_scsi_attributes,
  ]

  @type storedi_scsi_volumes :: [storedi_scsi_volume]

  @type tape :: [
    progress: double_object,
    tape_arn: tape_arn,
    tape_barcode: tape_barcode,
    tape_size_in_bytes: tape_size,
    tape_status: tape_status,
    vtl_device: vtl_device_arn,
  ]

  @type tape_arn :: binary

  @type tape_ar_ns :: [tape_arn]

  @type tape_archive :: [
    completion_time: time,
    retrieved_to: gateway_arn,
    tape_arn: tape_arn,
    tape_barcode: tape_barcode,
    tape_size_in_bytes: tape_size,
    tape_status: tape_archive_status,
  ]

  @type tape_archive_status :: binary

  @type tape_archives :: [tape_archive]

  @type tape_barcode :: binary

  @type tape_barcode_prefix :: binary

  @type tape_drive_type :: binary

  @type tape_recovery_point_info :: [
    tape_arn: tape_arn,
    tape_recovery_point_time: time,
    tape_size_in_bytes: tape_size,
    tape_status: tape_recovery_point_status,
  ]

  @type tape_recovery_point_infos :: [tape_recovery_point_info]

  @type tape_recovery_point_status :: binary

  @type tape_size :: integer

  @type tape_status :: binary

  @type tapes :: [tape]

  @type target_arn :: binary

  @type target_name :: binary

  @type time :: integer

  @type update_bandwidth_rate_limit_input :: [
    average_download_rate_limit_in_bits_per_sec: bandwidth_download_rate_limit,
    average_upload_rate_limit_in_bits_per_sec: bandwidth_upload_rate_limit,
    gateway_arn: gateway_arn,
  ]

  @type update_bandwidth_rate_limit_output :: [
    gateway_arn: gateway_arn,
  ]

  @type update_chap_credentials_input :: [
    initiator_name: iqn_name,
    secret_to_authenticate_initiator: chap_secret,
    secret_to_authenticate_target: chap_secret,
    target_arn: target_arn,
  ]

  @type update_chap_credentials_output :: [
    initiator_name: iqn_name,
    target_arn: target_arn,
  ]

  @type update_gateway_information_input :: [
    gateway_arn: gateway_arn,
    gateway_name: gateway_name,
    gateway_timezone: gateway_timezone,
  ]

  @type update_gateway_information_output :: [
    gateway_arn: gateway_arn,
  ]

  @type update_gateway_software_now_input :: [
    gateway_arn: gateway_arn,
  ]

  @type update_gateway_software_now_output :: [
    gateway_arn: gateway_arn,
  ]

  @type update_maintenance_start_time_input :: [
    day_of_week: day_of_week,
    gateway_arn: gateway_arn,
    hour_of_day: hour_of_day,
    minute_of_hour: minute_of_hour,
  ]

  @type update_maintenance_start_time_output :: [
    gateway_arn: gateway_arn,
  ]

  @type update_snapshot_schedule_input :: [
    description: description,
    recurrence_in_hours: recurrence_in_hours,
    start_at: hour_of_day,
    volume_arn: volume_arn,
  ]

  @type update_snapshot_schedule_output :: [
    volume_arn: volume_arn,
  ]

  @type update_vtl_device_type_input :: [
    device_type: device_type,
    vtl_device_arn: vtl_device_arn,
  ]

  @type update_vtl_device_type_output :: [
    vtl_device_arn: vtl_device_arn,
  ]

  @type vtl_device :: [
    devicei_scsi_attributes: devicei_scsi_attributes,
    vtl_device_arn: vtl_device_arn,
    vtl_device_product_identifier: vtl_device_product_identifier,
    vtl_device_type: vtl_device_type,
    vtl_device_vendor: vtl_device_vendor,
  ]

  @type vtl_device_arn :: binary

  @type vtl_device_ar_ns :: [vtl_device_arn]

  @type vtl_device_product_identifier :: binary

  @type vtl_device_type :: binary

  @type vtl_device_vendor :: binary

  @type vtl_devices :: [vtl_device]

  @type volume_arn :: binary

  @type volume_ar_ns :: [volume_arn]

  @type volume_id :: binary

  @type volume_info :: [
    volume_arn: volume_arn,
    volume_type: volume_type,
  ]

  @type volume_infos :: [volume_info]

  @type volume_recovery_point_info :: [
    volume_arn: volume_arn,
    volume_recovery_point_time: binary,
    volume_size_in_bytes: long,
    volume_usage_in_bytes: long,
  ]

  @type volume_recovery_point_infos :: [volume_recovery_point_info]

  @type volume_status :: binary

  @type volume_type :: binary

  @type volumei_scsi_attributes :: [
    chap_enabled: boolean,
    lun_number: positive_int_object,
    network_interface_id: network_interface_id,
    network_interface_port: integer,
    target_arn: target_arn,
  ]

  @type double :: float

  @type error_details :: [{binary, binary}]

  @type long :: integer





  @doc """
  ActivateGateway

  This operation activates the gateway you previously deployed on your host.
  For more information, see [ Activate the AWS Storage
  Gateway](http://docs.aws.amazon.com/storagegateway/latest/userguide/GettingStartedActivateGateway-common.html).
  In the activation process, you specify information such as the region you
  want to use for storing snapshots, the time zone for scheduled snapshots
  the gateway snapshot schedule window, an activation key, and a name for
  your gateway. The activation process also associates your gateway with your
  account; for more information, see `UpdateGatewayInformation`.

  Note:You must turn on the gateway VM before you can activate your gateway.
  """

  @spec activate_gateway(client :: ExAws.StorageGateway.t, input :: activate_gateway_input) :: ExAws.Request.JSON.response_t
  def activate_gateway(client, input) do
    request(client, "ActivateGateway", format_input(input))
  end

  @doc """
  Same as `activate_gateway/2` but raise on error.
  """
  @spec activate_gateway!(client :: ExAws.StorageGateway.t, input :: activate_gateway_input) :: ExAws.Request.JSON.success_t | no_return
  def activate_gateway!(client, input) do
    case activate_gateway(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  AddCache

  This operation configures one or more gateway local disks as cache for a
  cached-volume gateway. This operation is supported only for the
  gateway-cached volume architecture (see [Storage Gateway
  Concepts](http://docs.aws.amazon.com/storagegateway/latest/userguide/StorageGatewayConcepts.html)).

  In the request, you specify the gateway Amazon Resource Name (ARN) to which
  you want to add cache, and one or more disk IDs that you want to configure
  as cache.
  """

  @spec add_cache(client :: ExAws.StorageGateway.t, input :: add_cache_input) :: ExAws.Request.JSON.response_t
  def add_cache(client, input) do
    request(client, "AddCache", format_input(input))
  end

  @doc """
  Same as `add_cache/2` but raise on error.
  """
  @spec add_cache!(client :: ExAws.StorageGateway.t, input :: add_cache_input) :: ExAws.Request.JSON.success_t | no_return
  def add_cache!(client, input) do
    case add_cache(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  AddUploadBuffer

  This operation configures one or more gateway local disks as upload buffer
  for a specified gateway. This operation is supported for both the
  gateway-stored and gateway-cached volume architectures.

  In the request, you specify the gateway Amazon Resource Name (ARN) to which
  you want to add upload buffer, and one or more disk IDs that you want to
  configure as upload buffer.
  """

  @spec add_upload_buffer(client :: ExAws.StorageGateway.t, input :: add_upload_buffer_input) :: ExAws.Request.JSON.response_t
  def add_upload_buffer(client, input) do
    request(client, "AddUploadBuffer", format_input(input))
  end

  @doc """
  Same as `add_upload_buffer/2` but raise on error.
  """
  @spec add_upload_buffer!(client :: ExAws.StorageGateway.t, input :: add_upload_buffer_input) :: ExAws.Request.JSON.success_t | no_return
  def add_upload_buffer!(client, input) do
    case add_upload_buffer(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  AddWorkingStorage

  This operation configures one or more gateway local disks as working
  storage for a gateway. This operation is supported only for the
  gateway-stored volume architecture. This operation is deprecated method in
  cached-volumes API version (20120630). Use AddUploadBuffer instead.

  Note:Working storage is also referred to as upload buffer. You can also use
  the `AddUploadBuffer` operation to add upload buffer to a stored-volume
  gateway.

  In the request, you specify the gateway Amazon Resource Name (ARN) to which
  you want to add working storage, and one or more disk IDs that you want to
  configure as working storage.
  """

  @spec add_working_storage(client :: ExAws.StorageGateway.t, input :: add_working_storage_input) :: ExAws.Request.JSON.response_t
  def add_working_storage(client, input) do
    request(client, "AddWorkingStorage", format_input(input))
  end

  @doc """
  Same as `add_working_storage/2` but raise on error.
  """
  @spec add_working_storage!(client :: ExAws.StorageGateway.t, input :: add_working_storage_input) :: ExAws.Request.JSON.success_t | no_return
  def add_working_storage!(client, input) do
    case add_working_storage(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CancelArchival

  Cancels archiving of a virtual tape to the virtual tape shelf (VTS) after
  the archiving process is initiated.
  """

  @spec cancel_archival(client :: ExAws.StorageGateway.t, input :: cancel_archival_input) :: ExAws.Request.JSON.response_t
  def cancel_archival(client, input) do
    request(client, "CancelArchival", format_input(input))
  end

  @doc """
  Same as `cancel_archival/2` but raise on error.
  """
  @spec cancel_archival!(client :: ExAws.StorageGateway.t, input :: cancel_archival_input) :: ExAws.Request.JSON.success_t | no_return
  def cancel_archival!(client, input) do
    case cancel_archival(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CancelRetrieval

  Cancels retrieval of a virtual tape from the virtual tape shelf (VTS) to a
  gateway after the retrieval process is initiated. The virtual tape is
  returned to the VTS.
  """

  @spec cancel_retrieval(client :: ExAws.StorageGateway.t, input :: cancel_retrieval_input) :: ExAws.Request.JSON.response_t
  def cancel_retrieval(client, input) do
    request(client, "CancelRetrieval", format_input(input))
  end

  @doc """
  Same as `cancel_retrieval/2` but raise on error.
  """
  @spec cancel_retrieval!(client :: ExAws.StorageGateway.t, input :: cancel_retrieval_input) :: ExAws.Request.JSON.success_t | no_return
  def cancel_retrieval!(client, input) do
    case cancel_retrieval(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateCachediSCSIVolume

  This operation creates a cached volume on a specified cached gateway. This
  operation is supported only for the gateway-cached volume architecture.

  Note:Cache storage must be allocated to the gateway before you can create a
  cached volume. Use the `AddCache` operation to add cache storage to a
  gateway. In the request, you must specify the gateway, size of the volume
  in bytes, the iSCSI target name, an IP address on which to expose the
  target, and a unique client token. In response, AWS Storage Gateway creates
  the volume and returns information about it such as the volume Amazon
  Resource Name (ARN), its size, and the iSCSI target ARN that initiators can
  use to connect to the volume target.
  """

  @spec create_cachedi_scsi_volume(client :: ExAws.StorageGateway.t, input :: create_cachedi_scsi_volume_input) :: ExAws.Request.JSON.response_t
  def create_cachedi_scsi_volume(client, input) do
    request(client, "CreateCachediSCSIVolume", format_input(input))
  end

  @doc """
  Same as `create_cachedi_scsi_volume/2` but raise on error.
  """
  @spec create_cachedi_scsi_volume!(client :: ExAws.StorageGateway.t, input :: create_cachedi_scsi_volume_input) :: ExAws.Request.JSON.success_t | no_return
  def create_cachedi_scsi_volume!(client, input) do
    case create_cachedi_scsi_volume(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateSnapshot

  This operation initiates a snapshot of a volume.

  AWS Storage Gateway provides the ability to back up point-in-time snapshots
  of your data to Amazon Simple Storage (S3) for durable off-site recovery,
  as well as import the data to an Amazon Elastic Block Store (EBS) volume in
  Amazon Elastic Compute Cloud (EC2). You can take snapshots of your gateway
  volume on a scheduled or ad-hoc basis. This API enables you to take ad-hoc
  snapshot. For more information, see [Working With Snapshots in the AWS
  Storage Gateway
  Console](http://docs.aws.amazon.com/storagegateway/latest/userguide/WorkingWithSnapshots.html).

  In the CreateSnapshot request you identify the volume by providing its
  Amazon Resource Name (ARN). You must also provide description for the
  snapshot. When AWS Storage Gateway takes the snapshot of specified volume,
  the snapshot and description appears in the AWS Storage Gateway Console. In
  response, AWS Storage Gateway returns you a snapshot ID. You can use this
  snapshot ID to check the snapshot progress or later use it when you want to
  create a volume from a snapshot.

  Note:To list or delete a snapshot, you must use the Amazon EC2 API. For
  more information, see DescribeSnapshots or DeleteSnapshot in the [EC2 API
  reference](http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_Operations.html).
  """

  @spec create_snapshot(client :: ExAws.StorageGateway.t, input :: create_snapshot_input) :: ExAws.Request.JSON.response_t
  def create_snapshot(client, input) do
    request(client, "CreateSnapshot", format_input(input))
  end

  @doc """
  Same as `create_snapshot/2` but raise on error.
  """
  @spec create_snapshot!(client :: ExAws.StorageGateway.t, input :: create_snapshot_input) :: ExAws.Request.JSON.success_t | no_return
  def create_snapshot!(client, input) do
    case create_snapshot(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateSnapshotFromVolumeRecoveryPoint

  This operation initiates a snapshot of a gateway from a volume recovery
  point. This operation is supported only for the gateway-cached volume
  architecture (see ).

  A volume recovery point is a point in time at which all data of the volume
  is consistent and from which you can create a snapshot. To get a list of
  volume recovery point for gateway-cached volumes, use
  `ListVolumeRecoveryPoints`.

  In the `CreateSnapshotFromVolumeRecoveryPoint` request, you identify the
  volume by providing its Amazon Resource Name (ARN). You must also provide a
  description for the snapshot. When AWS Storage Gateway takes a snapshot of
  the specified volume, the snapshot and its description appear in the AWS
  Storage Gateway console. In response, AWS Storage Gateway returns you a
  snapshot ID. You can use this snapshot ID to check the snapshot progress or
  later use it when you want to create a volume from a snapshot.

  Note: To list or delete a snapshot, you must use the Amazon EC2 API. For
  more information, in *Amazon Elastic Compute Cloud API Reference*.
  """

  @spec create_snapshot_from_volume_recovery_point(client :: ExAws.StorageGateway.t, input :: create_snapshot_from_volume_recovery_point_input) :: ExAws.Request.JSON.response_t
  def create_snapshot_from_volume_recovery_point(client, input) do
    request(client, "CreateSnapshotFromVolumeRecoveryPoint", format_input(input))
  end

  @doc """
  Same as `create_snapshot_from_volume_recovery_point/2` but raise on error.
  """
  @spec create_snapshot_from_volume_recovery_point!(client :: ExAws.StorageGateway.t, input :: create_snapshot_from_volume_recovery_point_input) :: ExAws.Request.JSON.success_t | no_return
  def create_snapshot_from_volume_recovery_point!(client, input) do
    case create_snapshot_from_volume_recovery_point(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateStorediSCSIVolume

  This operation creates a volume on a specified gateway. This operation is
  supported only for the gateway-stored volume architecture.

  The size of the volume to create is inferred from the disk size. You can
  choose to preserve existing data on the disk, create volume from an
  existing snapshot, or create an empty volume. If you choose to create an
  empty gateway volume, then any existing data on the disk is erased.

  In the request you must specify the gateway and the disk information on
  which you are creating the volume. In response, AWS Storage Gateway creates
  the volume and returns volume information such as the volume Amazon
  Resource Name (ARN), its size, and the iSCSI target ARN that initiators can
  use to connect to the volume target.
  """

  @spec create_storedi_scsi_volume(client :: ExAws.StorageGateway.t, input :: create_storedi_scsi_volume_input) :: ExAws.Request.JSON.response_t
  def create_storedi_scsi_volume(client, input) do
    request(client, "CreateStorediSCSIVolume", format_input(input))
  end

  @doc """
  Same as `create_storedi_scsi_volume/2` but raise on error.
  """
  @spec create_storedi_scsi_volume!(client :: ExAws.StorageGateway.t, input :: create_storedi_scsi_volume_input) :: ExAws.Request.JSON.success_t | no_return
  def create_storedi_scsi_volume!(client, input) do
    case create_storedi_scsi_volume(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateTapes

  Creates one or more virtual tapes. You write data to the virtual tapes and
  then archive the tapes.

  Note:Cache storage must be allocated to the gateway before you can create
  virtual tapes. Use the `AddCache` operation to add cache storage to a
  gateway.
  """

  @spec create_tapes(client :: ExAws.StorageGateway.t, input :: create_tapes_input) :: ExAws.Request.JSON.response_t
  def create_tapes(client, input) do
    request(client, "CreateTapes", format_input(input))
  end

  @doc """
  Same as `create_tapes/2` but raise on error.
  """
  @spec create_tapes!(client :: ExAws.StorageGateway.t, input :: create_tapes_input) :: ExAws.Request.JSON.success_t | no_return
  def create_tapes!(client, input) do
    case create_tapes(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteBandwidthRateLimit

  This operation deletes the bandwidth rate limits of a gateway. You can
  delete either the upload and download bandwidth rate limit, or you can
  delete both. If you delete only one of the limits, the other limit remains
  unchanged. To specify which gateway to work with, use the Amazon Resource
  Name (ARN) of the gateway in your request.
  """

  @spec delete_bandwidth_rate_limit(client :: ExAws.StorageGateway.t, input :: delete_bandwidth_rate_limit_input) :: ExAws.Request.JSON.response_t
  def delete_bandwidth_rate_limit(client, input) do
    request(client, "DeleteBandwidthRateLimit", format_input(input))
  end

  @doc """
  Same as `delete_bandwidth_rate_limit/2` but raise on error.
  """
  @spec delete_bandwidth_rate_limit!(client :: ExAws.StorageGateway.t, input :: delete_bandwidth_rate_limit_input) :: ExAws.Request.JSON.success_t | no_return
  def delete_bandwidth_rate_limit!(client, input) do
    case delete_bandwidth_rate_limit(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteChapCredentials

  This operation deletes Challenge-Handshake Authentication Protocol (CHAP)
  credentials for a specified iSCSI target and initiator pair.
  """

  @spec delete_chap_credentials(client :: ExAws.StorageGateway.t, input :: delete_chap_credentials_input) :: ExAws.Request.JSON.response_t
  def delete_chap_credentials(client, input) do
    request(client, "DeleteChapCredentials", format_input(input))
  end

  @doc """
  Same as `delete_chap_credentials/2` but raise on error.
  """
  @spec delete_chap_credentials!(client :: ExAws.StorageGateway.t, input :: delete_chap_credentials_input) :: ExAws.Request.JSON.success_t | no_return
  def delete_chap_credentials!(client, input) do
    case delete_chap_credentials(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteGateway

  This operation deletes a gateway. To specify which gateway to delete, use
  the Amazon Resource Name (ARN) of the gateway in your request. The
  operation deletes the gateway; however, it does not delete the gateway
  virtual machine (VM) from your host computer.

  After you delete a gateway, you cannot reactivate it. Completed snapshots
  of the gateway volumes are not deleted upon deleting the gateway, however,
  pending snapshots will not complete. After you delete a gateway, your next
  step is to remove it from your environment.

  ** You no longer pay software charges after the gateway is deleted;
  however, your existing Amazon EBS snapshots persist and you will continue
  to be billed for these snapshots. You can choose to remove all remaining
  Amazon EBS snapshots by canceling your Amazon EC2 subscription.  If you
  prefer not to cancel your Amazon EC2 subscription, you can delete your
  snapshots using the Amazon EC2 console. For more information, see the [ AWS
  Storage Gateway Detail Page](http://aws.amazon.com/storagegateway).

  **
  """

  @spec delete_gateway(client :: ExAws.StorageGateway.t, input :: delete_gateway_input) :: ExAws.Request.JSON.response_t
  def delete_gateway(client, input) do
    request(client, "DeleteGateway", format_input(input))
  end

  @doc """
  Same as `delete_gateway/2` but raise on error.
  """
  @spec delete_gateway!(client :: ExAws.StorageGateway.t, input :: delete_gateway_input) :: ExAws.Request.JSON.success_t | no_return
  def delete_gateway!(client, input) do
    case delete_gateway(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteSnapshotSchedule

  This operation deletes a snapshot of a volume.

  You can take snapshots of your gateway volumes on a scheduled or ad-hoc
  basis. This API enables you to delete a snapshot schedule for a volume. For
  more information, see [Working with
  Snapshots](http://docs.aws.amazon.com/storagegateway/latest/userguide/WorkingWithSnapshots.html).
  In the `DeleteSnapshotSchedule` request, you identify the volume by
  providing its Amazon Resource Name (ARN).

  Note: To list or delete a snapshot, you must use the Amazon EC2 API. in
  *Amazon Elastic Compute Cloud API Reference*.
  """

  @spec delete_snapshot_schedule(client :: ExAws.StorageGateway.t, input :: delete_snapshot_schedule_input) :: ExAws.Request.JSON.response_t
  def delete_snapshot_schedule(client, input) do
    request(client, "DeleteSnapshotSchedule", format_input(input))
  end

  @doc """
  Same as `delete_snapshot_schedule/2` but raise on error.
  """
  @spec delete_snapshot_schedule!(client :: ExAws.StorageGateway.t, input :: delete_snapshot_schedule_input) :: ExAws.Request.JSON.success_t | no_return
  def delete_snapshot_schedule!(client, input) do
    case delete_snapshot_schedule(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteTape

  Deletes the specified virtual tape.
  """

  @spec delete_tape(client :: ExAws.StorageGateway.t, input :: delete_tape_input) :: ExAws.Request.JSON.response_t
  def delete_tape(client, input) do
    request(client, "DeleteTape", format_input(input))
  end

  @doc """
  Same as `delete_tape/2` but raise on error.
  """
  @spec delete_tape!(client :: ExAws.StorageGateway.t, input :: delete_tape_input) :: ExAws.Request.JSON.success_t | no_return
  def delete_tape!(client, input) do
    case delete_tape(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteTapeArchive

  Deletes the specified virtual tape from the virtual tape shelf (VTS).
  """

  @spec delete_tape_archive(client :: ExAws.StorageGateway.t, input :: delete_tape_archive_input) :: ExAws.Request.JSON.response_t
  def delete_tape_archive(client, input) do
    request(client, "DeleteTapeArchive", format_input(input))
  end

  @doc """
  Same as `delete_tape_archive/2` but raise on error.
  """
  @spec delete_tape_archive!(client :: ExAws.StorageGateway.t, input :: delete_tape_archive_input) :: ExAws.Request.JSON.success_t | no_return
  def delete_tape_archive!(client, input) do
    case delete_tape_archive(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteVolume

  This operation delete the specified gateway volume that you previously
  created using the `CreateStorediSCSIVolume` API. For gateway-stored
  volumes, the local disk that was configured as the storage volume is not
  deleted. You can reuse the local disk to create another storage volume.

  Before you delete a gateway volume, make sure there are no iSCSI
  connections to the volume you are deleting. You should also make sure there
  is no snapshot in progress. You can use the Amazon Elastic Compute Cloud
  (Amazon EC2) API to query snapshots on the volume you are deleting and
  check the snapshot status. For more information, go to
  [DescribeSnapshots](http://docs.aws.amazon.com/AWSEC2/latest/APIReference/ApiReference-query-DescribeSnapshots.html)
  in the *Amazon Elastic Compute Cloud API Reference*.

  In the request, you must provide the Amazon Resource Name (ARN) of the
  storage volume you want to delete.
  """

  @spec delete_volume(client :: ExAws.StorageGateway.t, input :: delete_volume_input) :: ExAws.Request.JSON.response_t
  def delete_volume(client, input) do
    request(client, "DeleteVolume", format_input(input))
  end

  @doc """
  Same as `delete_volume/2` but raise on error.
  """
  @spec delete_volume!(client :: ExAws.StorageGateway.t, input :: delete_volume_input) :: ExAws.Request.JSON.success_t | no_return
  def delete_volume!(client, input) do
    case delete_volume(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeBandwidthRateLimit

  This operation returns the bandwidth rate limits of a gateway. By default,
  these limits are not set, which means no bandwidth rate limiting is in
  effect.

  This operation only returns a value for a bandwidth rate limit only if the
  limit is set. If no limits are set for the gateway, then this operation
  returns only the gateway ARN in the response body. To specify which gateway
  to describe, use the Amazon Resource Name (ARN) of the gateway in your
  request.
  """

  @spec describe_bandwidth_rate_limit(client :: ExAws.StorageGateway.t, input :: describe_bandwidth_rate_limit_input) :: ExAws.Request.JSON.response_t
  def describe_bandwidth_rate_limit(client, input) do
    request(client, "DescribeBandwidthRateLimit", format_input(input))
  end

  @doc """
  Same as `describe_bandwidth_rate_limit/2` but raise on error.
  """
  @spec describe_bandwidth_rate_limit!(client :: ExAws.StorageGateway.t, input :: describe_bandwidth_rate_limit_input) :: ExAws.Request.JSON.success_t | no_return
  def describe_bandwidth_rate_limit!(client, input) do
    case describe_bandwidth_rate_limit(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeCache

  This operation returns information about the cache of a gateway. This
  operation is supported only for the gateway-cached volume architecture.

  The response includes disk IDs that are configured as cache, and it
  includes the amount of cache allocated and used.
  """

  @spec describe_cache(client :: ExAws.StorageGateway.t, input :: describe_cache_input) :: ExAws.Request.JSON.response_t
  def describe_cache(client, input) do
    request(client, "DescribeCache", format_input(input))
  end

  @doc """
  Same as `describe_cache/2` but raise on error.
  """
  @spec describe_cache!(client :: ExAws.StorageGateway.t, input :: describe_cache_input) :: ExAws.Request.JSON.success_t | no_return
  def describe_cache!(client, input) do
    case describe_cache(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeCachediSCSIVolumes

  This operation returns a description of the gateway volumes specified in
  the request. This operation is supported only for the gateway-cached volume
  architecture.

  The list of gateway volumes in the request must be from one gateway. In the
  response Amazon Storage Gateway returns volume information sorted by volume
  Amazon Resource Name (ARN).
  """

  @spec describe_cachedi_scsi_volumes(client :: ExAws.StorageGateway.t, input :: describe_cachedi_scsi_volumes_input) :: ExAws.Request.JSON.response_t
  def describe_cachedi_scsi_volumes(client, input) do
    request(client, "DescribeCachediSCSIVolumes", format_input(input))
  end

  @doc """
  Same as `describe_cachedi_scsi_volumes/2` but raise on error.
  """
  @spec describe_cachedi_scsi_volumes!(client :: ExAws.StorageGateway.t, input :: describe_cachedi_scsi_volumes_input) :: ExAws.Request.JSON.success_t | no_return
  def describe_cachedi_scsi_volumes!(client, input) do
    case describe_cachedi_scsi_volumes(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeChapCredentials

  This operation returns an array of Challenge-Handshake Authentication
  Protocol (CHAP) credentials information for a specified iSCSI target, one
  for each target-initiator pair.
  """

  @spec describe_chap_credentials(client :: ExAws.StorageGateway.t, input :: describe_chap_credentials_input) :: ExAws.Request.JSON.response_t
  def describe_chap_credentials(client, input) do
    request(client, "DescribeChapCredentials", format_input(input))
  end

  @doc """
  Same as `describe_chap_credentials/2` but raise on error.
  """
  @spec describe_chap_credentials!(client :: ExAws.StorageGateway.t, input :: describe_chap_credentials_input) :: ExAws.Request.JSON.success_t | no_return
  def describe_chap_credentials!(client, input) do
    case describe_chap_credentials(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeGatewayInformation

  This operation returns metadata about a gateway such as its name, network
  interfaces, configured time zone, and the state (whether the gateway is
  running or not). To specify which gateway to describe, use the Amazon
  Resource Name (ARN) of the gateway in your request.
  """

  @spec describe_gateway_information(client :: ExAws.StorageGateway.t, input :: describe_gateway_information_input) :: ExAws.Request.JSON.response_t
  def describe_gateway_information(client, input) do
    request(client, "DescribeGatewayInformation", format_input(input))
  end

  @doc """
  Same as `describe_gateway_information/2` but raise on error.
  """
  @spec describe_gateway_information!(client :: ExAws.StorageGateway.t, input :: describe_gateway_information_input) :: ExAws.Request.JSON.success_t | no_return
  def describe_gateway_information!(client, input) do
    case describe_gateway_information(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeMaintenanceStartTime

  This operation returns your gateway's weekly maintenance start time
  including the day and time of the week. Note that values are in terms of
  the gateway's time zone.
  """

  @spec describe_maintenance_start_time(client :: ExAws.StorageGateway.t, input :: describe_maintenance_start_time_input) :: ExAws.Request.JSON.response_t
  def describe_maintenance_start_time(client, input) do
    request(client, "DescribeMaintenanceStartTime", format_input(input))
  end

  @doc """
  Same as `describe_maintenance_start_time/2` but raise on error.
  """
  @spec describe_maintenance_start_time!(client :: ExAws.StorageGateway.t, input :: describe_maintenance_start_time_input) :: ExAws.Request.JSON.success_t | no_return
  def describe_maintenance_start_time!(client, input) do
    case describe_maintenance_start_time(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeSnapshotSchedule

  This operation describes the snapshot schedule for the specified gateway
  volume. The snapshot schedule information includes intervals at which
  snapshots are automatically initiated on the volume.
  """

  @spec describe_snapshot_schedule(client :: ExAws.StorageGateway.t, input :: describe_snapshot_schedule_input) :: ExAws.Request.JSON.response_t
  def describe_snapshot_schedule(client, input) do
    request(client, "DescribeSnapshotSchedule", format_input(input))
  end

  @doc """
  Same as `describe_snapshot_schedule/2` but raise on error.
  """
  @spec describe_snapshot_schedule!(client :: ExAws.StorageGateway.t, input :: describe_snapshot_schedule_input) :: ExAws.Request.JSON.success_t | no_return
  def describe_snapshot_schedule!(client, input) do
    case describe_snapshot_schedule(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeStorediSCSIVolumes

  This operation returns the description of the gateway volumes specified in
  the request. The list of gateway volumes in the request must be from one
  gateway. In the response Amazon Storage Gateway returns volume information
  sorted by volume ARNs.
  """

  @spec describe_storedi_scsi_volumes(client :: ExAws.StorageGateway.t, input :: describe_storedi_scsi_volumes_input) :: ExAws.Request.JSON.response_t
  def describe_storedi_scsi_volumes(client, input) do
    request(client, "DescribeStorediSCSIVolumes", format_input(input))
  end

  @doc """
  Same as `describe_storedi_scsi_volumes/2` but raise on error.
  """
  @spec describe_storedi_scsi_volumes!(client :: ExAws.StorageGateway.t, input :: describe_storedi_scsi_volumes_input) :: ExAws.Request.JSON.success_t | no_return
  def describe_storedi_scsi_volumes!(client, input) do
    case describe_storedi_scsi_volumes(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeTapeArchives

  Returns a description of specified virtual tapes in the virtual tape shelf
  (VTS).

  If a specific `TapeARN` is not specified, AWS Storage Gateway returns a
  description of all virtual tapes found in the VTS associated with your
  account.
  """

  @spec describe_tape_archives(client :: ExAws.StorageGateway.t, input :: describe_tape_archives_input) :: ExAws.Request.JSON.response_t
  def describe_tape_archives(client, input) do
    request(client, "DescribeTapeArchives", format_input(input))
  end

  @doc """
  Same as `describe_tape_archives/2` but raise on error.
  """
  @spec describe_tape_archives!(client :: ExAws.StorageGateway.t, input :: describe_tape_archives_input) :: ExAws.Request.JSON.success_t | no_return
  def describe_tape_archives!(client, input) do
    case describe_tape_archives(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeTapeRecoveryPoints

  Returns a list of virtual tape recovery points that are available for the
  specified gateway-VTL.

  A recovery point is a point in time view of a virtual tape at which all the
  data on the virtual tape is consistent. If your gateway crashes, virtual
  tapes that have recovery points can be recovered to a new gateway.
  """

  @spec describe_tape_recovery_points(client :: ExAws.StorageGateway.t, input :: describe_tape_recovery_points_input) :: ExAws.Request.JSON.response_t
  def describe_tape_recovery_points(client, input) do
    request(client, "DescribeTapeRecoveryPoints", format_input(input))
  end

  @doc """
  Same as `describe_tape_recovery_points/2` but raise on error.
  """
  @spec describe_tape_recovery_points!(client :: ExAws.StorageGateway.t, input :: describe_tape_recovery_points_input) :: ExAws.Request.JSON.success_t | no_return
  def describe_tape_recovery_points!(client, input) do
    case describe_tape_recovery_points(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeTapes

  Returns a description of the specified Amazon Resource Name (ARN) of
  virtual tapes. If a `TapeARN` is not specified, returns a description of
  all virtual tapes associated with the specified gateway.
  """

  @spec describe_tapes(client :: ExAws.StorageGateway.t, input :: describe_tapes_input) :: ExAws.Request.JSON.response_t
  def describe_tapes(client, input) do
    request(client, "DescribeTapes", format_input(input))
  end

  @doc """
  Same as `describe_tapes/2` but raise on error.
  """
  @spec describe_tapes!(client :: ExAws.StorageGateway.t, input :: describe_tapes_input) :: ExAws.Request.JSON.success_t | no_return
  def describe_tapes!(client, input) do
    case describe_tapes(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeUploadBuffer

  This operation returns information about the upload buffer of a gateway.
  This operation is supported for both the gateway-stored and gateway-cached
  volume architectures.

  The response includes disk IDs that are configured as upload buffer space,
  and it includes the amount of upload buffer space allocated and used.
  """

  @spec describe_upload_buffer(client :: ExAws.StorageGateway.t, input :: describe_upload_buffer_input) :: ExAws.Request.JSON.response_t
  def describe_upload_buffer(client, input) do
    request(client, "DescribeUploadBuffer", format_input(input))
  end

  @doc """
  Same as `describe_upload_buffer/2` but raise on error.
  """
  @spec describe_upload_buffer!(client :: ExAws.StorageGateway.t, input :: describe_upload_buffer_input) :: ExAws.Request.JSON.success_t | no_return
  def describe_upload_buffer!(client, input) do
    case describe_upload_buffer(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeVTLDevices

  Returns a description of virtual tape library (VTL) devices for the
  specified gateway. In the response, AWS Storage Gateway returns VTL device
  information.

  The list of VTL devices must be from one gateway.
  """

  @spec describe_vtl_devices(client :: ExAws.StorageGateway.t, input :: describe_vtl_devices_input) :: ExAws.Request.JSON.response_t
  def describe_vtl_devices(client, input) do
    request(client, "DescribeVTLDevices", format_input(input))
  end

  @doc """
  Same as `describe_vtl_devices/2` but raise on error.
  """
  @spec describe_vtl_devices!(client :: ExAws.StorageGateway.t, input :: describe_vtl_devices_input) :: ExAws.Request.JSON.success_t | no_return
  def describe_vtl_devices!(client, input) do
    case describe_vtl_devices(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeWorkingStorage

  This operation returns information about the working storage of a gateway.
  This operation is supported only for the gateway-stored volume
  architecture. This operation is deprecated in cached-volumes API version
  (20120630). Use DescribeUploadBuffer instead.

  Note:Working storage is also referred to as upload buffer. You can also use
  the DescribeUploadBuffer operation to add upload buffer to a stored-volume
  gateway.

  The response includes disk IDs that are configured as working storage, and
  it includes the amount of working storage allocated and used.
  """

  @spec describe_working_storage(client :: ExAws.StorageGateway.t, input :: describe_working_storage_input) :: ExAws.Request.JSON.response_t
  def describe_working_storage(client, input) do
    request(client, "DescribeWorkingStorage", format_input(input))
  end

  @doc """
  Same as `describe_working_storage/2` but raise on error.
  """
  @spec describe_working_storage!(client :: ExAws.StorageGateway.t, input :: describe_working_storage_input) :: ExAws.Request.JSON.success_t | no_return
  def describe_working_storage!(client, input) do
    case describe_working_storage(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DisableGateway

  Disables a gateway when the gateway is no longer functioning. For example,
  if your gateway VM is damaged, you can disable the gateway so you can
  recover virtual tapes.

  Use this operation for a gateway-VTL that is not reachable or not
  functioning.

  **Once a gateway is disabled it cannot be enabled.**
  """

  @spec disable_gateway(client :: ExAws.StorageGateway.t, input :: disable_gateway_input) :: ExAws.Request.JSON.response_t
  def disable_gateway(client, input) do
    request(client, "DisableGateway", format_input(input))
  end

  @doc """
  Same as `disable_gateway/2` but raise on error.
  """
  @spec disable_gateway!(client :: ExAws.StorageGateway.t, input :: disable_gateway_input) :: ExAws.Request.JSON.success_t | no_return
  def disable_gateway!(client, input) do
    case disable_gateway(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListGateways

  This operation lists gateways owned by an AWS account in a region specified
  in the request. The returned list is ordered by gateway Amazon Resource
  Name (ARN).

  By default, the operation returns a maximum of 100 gateways. This operation
  supports pagination that allows you to optionally reduce the number of
  gateways returned in a response.

  If you have more gateways than are returned in a response-that is, the
  response returns only a truncated list of your gateways-the response
  contains a marker that you can specify in your next request to fetch the
  next page of gateways.
  """

  @spec list_gateways(client :: ExAws.StorageGateway.t, input :: list_gateways_input) :: ExAws.Request.JSON.response_t
  def list_gateways(client, input) do
    request(client, "ListGateways", format_input(input))
  end

  @doc """
  Same as `list_gateways/2` but raise on error.
  """
  @spec list_gateways!(client :: ExAws.StorageGateway.t, input :: list_gateways_input) :: ExAws.Request.JSON.success_t | no_return
  def list_gateways!(client, input) do
    case list_gateways(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListLocalDisks

  This operation returns a list of the gateway's local disks. To specify
  which gateway to describe, you use the Amazon Resource Name (ARN) of the
  gateway in the body of the request.

  The request returns a list of all disks, specifying which are configured as
  working storage, cache storage, or stored volume or not configured at all.
  The response includes a `DiskStatus` field. This field can have a value of
  present (the disk is available to use), missing (the disk is no longer
  connected to the gateway), or mismatch (the disk node is occupied by a disk
  that has incorrect metadata or the disk content is corrupted).
  """

  @spec list_local_disks(client :: ExAws.StorageGateway.t, input :: list_local_disks_input) :: ExAws.Request.JSON.response_t
  def list_local_disks(client, input) do
    request(client, "ListLocalDisks", format_input(input))
  end

  @doc """
  Same as `list_local_disks/2` but raise on error.
  """
  @spec list_local_disks!(client :: ExAws.StorageGateway.t, input :: list_local_disks_input) :: ExAws.Request.JSON.success_t | no_return
  def list_local_disks!(client, input) do
    case list_local_disks(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListVolumeInitiators

  This operation lists iSCSI initiators that are connected to a volume. You
  can use this operation to determine whether a volume is being used or not.
  """

  @spec list_volume_initiators(client :: ExAws.StorageGateway.t, input :: list_volume_initiators_input) :: ExAws.Request.JSON.response_t
  def list_volume_initiators(client, input) do
    request(client, "ListVolumeInitiators", format_input(input))
  end

  @doc """
  Same as `list_volume_initiators/2` but raise on error.
  """
  @spec list_volume_initiators!(client :: ExAws.StorageGateway.t, input :: list_volume_initiators_input) :: ExAws.Request.JSON.success_t | no_return
  def list_volume_initiators!(client, input) do
    case list_volume_initiators(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListVolumeRecoveryPoints

  This operation lists the recovery points for a specified gateway. This
  operation is supported only for the gateway-cached volume architecture.

  Each gateway-cached volume has one recovery point. A volume recovery point
  is a point in time at which all data of the volume is consistent and from
  which you can create a snapshot. To create a snapshot from a volume
  recovery point use the `CreateSnapshotFromVolumeRecoveryPoint` operation.
  """

  @spec list_volume_recovery_points(client :: ExAws.StorageGateway.t, input :: list_volume_recovery_points_input) :: ExAws.Request.JSON.response_t
  def list_volume_recovery_points(client, input) do
    request(client, "ListVolumeRecoveryPoints", format_input(input))
  end

  @doc """
  Same as `list_volume_recovery_points/2` but raise on error.
  """
  @spec list_volume_recovery_points!(client :: ExAws.StorageGateway.t, input :: list_volume_recovery_points_input) :: ExAws.Request.JSON.success_t | no_return
  def list_volume_recovery_points!(client, input) do
    case list_volume_recovery_points(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListVolumes

  This operation lists the iSCSI stored volumes of a gateway. Results are
  sorted by volume ARN. The response includes only the volume ARNs. If you
  want additional volume information, use the `DescribeStorediSCSIVolumes`
  API.

  The operation supports pagination. By default, the operation returns a
  maximum of up to 100 volumes. You can optionally specify the `Limit` field
  in the body to limit the number of volumes in the response. If the number
  of volumes returned in the response is truncated, the response includes a
  Marker field. You can use this Marker value in your subsequent request to
  retrieve the next set of volumes.
  """

  @spec list_volumes(client :: ExAws.StorageGateway.t, input :: list_volumes_input) :: ExAws.Request.JSON.response_t
  def list_volumes(client, input) do
    request(client, "ListVolumes", format_input(input))
  end

  @doc """
  Same as `list_volumes/2` but raise on error.
  """
  @spec list_volumes!(client :: ExAws.StorageGateway.t, input :: list_volumes_input) :: ExAws.Request.JSON.success_t | no_return
  def list_volumes!(client, input) do
    case list_volumes(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ResetCache

  This operation resets all cache disks that have encountered a error and
  makes the disks available for reconfiguration as cache storage. If your
  cache disk encounters a error, the gateway prevents read and write
  operations on virtual tapes in the gateway. For example, an error can occur
  when a disk is corrupted or removed from the gateway. When a cache is
  reset, the gateway loses its cache storage. At this point you can
  reconfigure the disks as cache disks.

  ** If the cache disk you are resetting contains data that has not been
  uploaded to Amazon S3 yet, that data can be lost. After you reset cache
  disks, there will be no configured cache disks left in the gateway, so you
  must configure at least one new cache disk for your gateway to function
  properly.

  **
  """

  @spec reset_cache(client :: ExAws.StorageGateway.t, input :: reset_cache_input) :: ExAws.Request.JSON.response_t
  def reset_cache(client, input) do
    request(client, "ResetCache", format_input(input))
  end

  @doc """
  Same as `reset_cache/2` but raise on error.
  """
  @spec reset_cache!(client :: ExAws.StorageGateway.t, input :: reset_cache_input) :: ExAws.Request.JSON.success_t | no_return
  def reset_cache!(client, input) do
    case reset_cache(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RetrieveTapeArchive

  Retrieves an archived virtual tape from the virtual tape shelf (VTS) to a
  gateway-VTL. Virtual tapes archived in the VTS are not associated with any
  gateway. However after a tape is retrieved, it is associated with a
  gateway, even though it is also listed in the VTS.

  Once a tape is successfully retrieved to a gateway, it cannot be retrieved
  again to another gateway. You must archive the tape again before you can
  retrieve it to another gateway.
  """

  @spec retrieve_tape_archive(client :: ExAws.StorageGateway.t, input :: retrieve_tape_archive_input) :: ExAws.Request.JSON.response_t
  def retrieve_tape_archive(client, input) do
    request(client, "RetrieveTapeArchive", format_input(input))
  end

  @doc """
  Same as `retrieve_tape_archive/2` but raise on error.
  """
  @spec retrieve_tape_archive!(client :: ExAws.StorageGateway.t, input :: retrieve_tape_archive_input) :: ExAws.Request.JSON.success_t | no_return
  def retrieve_tape_archive!(client, input) do
    case retrieve_tape_archive(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RetrieveTapeRecoveryPoint

  Retrieves the recovery point for the specified virtual tape.

  A recovery point is a point in time view of a virtual tape at which all the
  data on the tape is consistent. If your gateway crashes, virtual tapes that
  have recovery points can be recovered to a new gateway.

  Note:The virtual tape can be retrieved to only one gateway. The retrieved
  tape is read-only. The virtual tape can be retrieved to only a gateway-VTL.
  There is no charge for retrieving recovery points.
  """

  @spec retrieve_tape_recovery_point(client :: ExAws.StorageGateway.t, input :: retrieve_tape_recovery_point_input) :: ExAws.Request.JSON.response_t
  def retrieve_tape_recovery_point(client, input) do
    request(client, "RetrieveTapeRecoveryPoint", format_input(input))
  end

  @doc """
  Same as `retrieve_tape_recovery_point/2` but raise on error.
  """
  @spec retrieve_tape_recovery_point!(client :: ExAws.StorageGateway.t, input :: retrieve_tape_recovery_point_input) :: ExAws.Request.JSON.success_t | no_return
  def retrieve_tape_recovery_point!(client, input) do
    case retrieve_tape_recovery_point(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ShutdownGateway

  This operation shuts down a gateway. To specify which gateway to shut down,
  use the Amazon Resource Name (ARN) of the gateway in the body of your
  request.

  The operation shuts down the gateway service component running in the
  storage gateway's virtual machine (VM) and not the VM.

  Note:If you want to shut down the VM, it is recommended that you first shut
  down the gateway component in the VM to avoid unpredictable conditions.
  After the gateway is shutdown, you cannot call any other API except
  `StartGateway`, `DescribeGatewayInformation`, and `ListGateways`. For more
  information, see `ActivateGateway`. Your applications cannot read from or
  write to the gateway's storage volumes, and there are no snapshots taken.

  Note:When you make a shutdown request, you will get a `200 OK` success
  response immediately. However, it might take some time for the gateway to
  shut down. You can call the `DescribeGatewayInformation` API to check the
  status. For more information, see `ActivateGateway`. If do not intend to
  use the gateway again, you must delete the gateway (using `DeleteGateway`)
  to no longer pay software charges associated with the gateway.
  """

  @spec shutdown_gateway(client :: ExAws.StorageGateway.t, input :: shutdown_gateway_input) :: ExAws.Request.JSON.response_t
  def shutdown_gateway(client, input) do
    request(client, "ShutdownGateway", format_input(input))
  end

  @doc """
  Same as `shutdown_gateway/2` but raise on error.
  """
  @spec shutdown_gateway!(client :: ExAws.StorageGateway.t, input :: shutdown_gateway_input) :: ExAws.Request.JSON.success_t | no_return
  def shutdown_gateway!(client, input) do
    case shutdown_gateway(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  StartGateway

  This operation starts a gateway that you previously shut down (see
  `ShutdownGateway`). After the gateway starts, you can then make other API
  calls, your applications can read from or write to the gateway's storage
  volumes and you will be able to take snapshot backups.

  Note:When you make a request, you will get a 200 OK success response
  immediately. However, it might take some time for the gateway to be ready.
  You should call `DescribeGatewayInformation` and check the status before
  making any additional API calls. For more information, see
  `ActivateGateway`. To specify which gateway to start, use the Amazon
  Resource Name (ARN) of the gateway in your request.
  """

  @spec start_gateway(client :: ExAws.StorageGateway.t, input :: start_gateway_input) :: ExAws.Request.JSON.response_t
  def start_gateway(client, input) do
    request(client, "StartGateway", format_input(input))
  end

  @doc """
  Same as `start_gateway/2` but raise on error.
  """
  @spec start_gateway!(client :: ExAws.StorageGateway.t, input :: start_gateway_input) :: ExAws.Request.JSON.success_t | no_return
  def start_gateway!(client, input) do
    case start_gateway(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateBandwidthRateLimit

  This operation updates the bandwidth rate limits of a gateway. You can
  update both the upload and download bandwidth rate limit or specify only
  one of the two. If you don't set a bandwidth rate limit, the existing rate
  limit remains.

  By default, a gateway's bandwidth rate limits are not set. If you don't set
  any limit, the gateway does not have any limitations on its bandwidth usage
  and could potentially use the maximum available bandwidth.

  To specify which gateway to update, use the Amazon Resource Name (ARN) of
  the gateway in your request.
  """

  @spec update_bandwidth_rate_limit(client :: ExAws.StorageGateway.t, input :: update_bandwidth_rate_limit_input) :: ExAws.Request.JSON.response_t
  def update_bandwidth_rate_limit(client, input) do
    request(client, "UpdateBandwidthRateLimit", format_input(input))
  end

  @doc """
  Same as `update_bandwidth_rate_limit/2` but raise on error.
  """
  @spec update_bandwidth_rate_limit!(client :: ExAws.StorageGateway.t, input :: update_bandwidth_rate_limit_input) :: ExAws.Request.JSON.success_t | no_return
  def update_bandwidth_rate_limit!(client, input) do
    case update_bandwidth_rate_limit(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateChapCredentials

  This operation updates the Challenge-Handshake Authentication Protocol
  (CHAP) credentials for a specified iSCSI target. By default, a gateway does
  not have CHAP enabled; however, for added security, you might use it.

  ** When you update CHAP credentials, all existing connections on the target
  are closed and initiators must reconnect with the new credentials.

  **
  """

  @spec update_chap_credentials(client :: ExAws.StorageGateway.t, input :: update_chap_credentials_input) :: ExAws.Request.JSON.response_t
  def update_chap_credentials(client, input) do
    request(client, "UpdateChapCredentials", format_input(input))
  end

  @doc """
  Same as `update_chap_credentials/2` but raise on error.
  """
  @spec update_chap_credentials!(client :: ExAws.StorageGateway.t, input :: update_chap_credentials_input) :: ExAws.Request.JSON.success_t | no_return
  def update_chap_credentials!(client, input) do
    case update_chap_credentials(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateGatewayInformation

  This operation updates a gateway's metadata, which includes the gateway's
  name and time zone. To specify which gateway to update, use the Amazon
  Resource Name (ARN) of the gateway in your request.
  """

  @spec update_gateway_information(client :: ExAws.StorageGateway.t, input :: update_gateway_information_input) :: ExAws.Request.JSON.response_t
  def update_gateway_information(client, input) do
    request(client, "UpdateGatewayInformation", format_input(input))
  end

  @doc """
  Same as `update_gateway_information/2` but raise on error.
  """
  @spec update_gateway_information!(client :: ExAws.StorageGateway.t, input :: update_gateway_information_input) :: ExAws.Request.JSON.success_t | no_return
  def update_gateway_information!(client, input) do
    case update_gateway_information(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateGatewaySoftwareNow

  This operation updates the gateway virtual machine (VM) software. The
  request immediately triggers the software update.

  Note:When you make this request, you get a `200 OK` success response
  immediately. However, it might take some time for the update to complete.
  You can call `DescribeGatewayInformation` to verify the gateway is in the
  `STATE_RUNNING` state. **A software update forces a system restart of your
  gateway. You can minimize the chance of any disruption to your applications
  by increasing your iSCSI Initiators' timeouts. For more information about
  increasing iSCSI Initiator timeouts for Windows and Linux, see [Customizing
  Your Windows iSCSI
  Settings](http://docs.aws.amazon.com/storagegateway/latest/userguide/ConfiguringiSCSIClientInitiatorWindowsClient.html#CustomizeWindowsiSCSISettings)
  and [Customizing Your Linux iSCSI
  Settings](http://docs.aws.amazon.com/storagegateway/latest/userguide/ConfiguringiSCSIClientInitiatorRedHatClient.html#CustomizeLinuxiSCSISettings),
  respectively.**
  """

  @spec update_gateway_software_now(client :: ExAws.StorageGateway.t, input :: update_gateway_software_now_input) :: ExAws.Request.JSON.response_t
  def update_gateway_software_now(client, input) do
    request(client, "UpdateGatewaySoftwareNow", format_input(input))
  end

  @doc """
  Same as `update_gateway_software_now/2` but raise on error.
  """
  @spec update_gateway_software_now!(client :: ExAws.StorageGateway.t, input :: update_gateway_software_now_input) :: ExAws.Request.JSON.success_t | no_return
  def update_gateway_software_now!(client, input) do
    case update_gateway_software_now(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateMaintenanceStartTime

  This operation updates a gateway's weekly maintenance start time
  information, including day and time of the week. The maintenance time is
  the time in your gateway's time zone.
  """

  @spec update_maintenance_start_time(client :: ExAws.StorageGateway.t, input :: update_maintenance_start_time_input) :: ExAws.Request.JSON.response_t
  def update_maintenance_start_time(client, input) do
    request(client, "UpdateMaintenanceStartTime", format_input(input))
  end

  @doc """
  Same as `update_maintenance_start_time/2` but raise on error.
  """
  @spec update_maintenance_start_time!(client :: ExAws.StorageGateway.t, input :: update_maintenance_start_time_input) :: ExAws.Request.JSON.success_t | no_return
  def update_maintenance_start_time!(client, input) do
    case update_maintenance_start_time(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateSnapshotSchedule

  This operation updates a snapshot schedule configured for a gateway volume.

  The default snapshot schedule for volume is once every 24 hours, starting
  at the creation time of the volume. You can use this API to change the
  snapshot schedule configured for the volume.

  In the request you must identify the gateway volume whose snapshot schedule
  you want to update, and the schedule information, including when you want
  the snapshot to begin on a day and the frequency (in hours) of snapshots.
  """

  @spec update_snapshot_schedule(client :: ExAws.StorageGateway.t, input :: update_snapshot_schedule_input) :: ExAws.Request.JSON.response_t
  def update_snapshot_schedule(client, input) do
    request(client, "UpdateSnapshotSchedule", format_input(input))
  end

  @doc """
  Same as `update_snapshot_schedule/2` but raise on error.
  """
  @spec update_snapshot_schedule!(client :: ExAws.StorageGateway.t, input :: update_snapshot_schedule_input) :: ExAws.Request.JSON.success_t | no_return
  def update_snapshot_schedule!(client, input) do
    case update_snapshot_schedule(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateVTLDeviceType

  This operation updates the type of medium changer in a gateway-VTL. When
  you activate a gateway-VTL, you select a medium changer type for the
  gateway-VTL. This operation enables you to select a different type of
  medium changer after a gateway-VTL is activated.
  """

  @spec update_vtl_device_type(client :: ExAws.StorageGateway.t, input :: update_vtl_device_type_input) :: ExAws.Request.JSON.response_t
  def update_vtl_device_type(client, input) do
    request(client, "UpdateVTLDeviceType", format_input(input))
  end

  @doc """
  Same as `update_vtl_device_type/2` but raise on error.
  """
  @spec update_vtl_device_type!(client :: ExAws.StorageGateway.t, input :: update_vtl_device_type_input) :: ExAws.Request.JSON.success_t | no_return
  def update_vtl_device_type!(client, input) do
    case update_vtl_device_type(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  defp request(%{__struct__: client_module} = client, action, input) do
    apply(client_module, :request, [client, action, input])
  end
end
