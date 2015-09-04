defmodule ExAws.StorageGateway.Core do
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
  def activate_gateway(client, input) do
    request(client, "ActivateGateway", input)
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
  def add_cache(client, input) do
    request(client, "AddCache", input)
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
  def add_upload_buffer(client, input) do
    request(client, "AddUploadBuffer", input)
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
  def add_working_storage(client, input) do
    request(client, "AddWorkingStorage", input)
  end

  @doc """
  CancelArchival

  Cancels archiving of a virtual tape to the virtual tape shelf (VTS) after
  the archiving process is initiated.
  """
  def cancel_archival(client, input) do
    request(client, "CancelArchival", input)
  end

  @doc """
  CancelRetrieval

  Cancels retrieval of a virtual tape from the virtual tape shelf (VTS) to a
  gateway after the retrieval process is initiated. The virtual tape is
  returned to the VTS.
  """
  def cancel_retrieval(client, input) do
    request(client, "CancelRetrieval", input)
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
  def create_cachedi_scsi_volume(client, input) do
    request(client, "CreateCachediSCSIVolume", input)
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
  def create_snapshot(client, input) do
    request(client, "CreateSnapshot", input)
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
  def create_snapshot_from_volume_recovery_point(client, input) do
    request(client, "CreateSnapshotFromVolumeRecoveryPoint", input)
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
  def create_storedi_scsi_volume(client, input) do
    request(client, "CreateStorediSCSIVolume", input)
  end

  @doc """
  CreateTapes

  Creates one or more virtual tapes. You write data to the virtual tapes and
  then archive the tapes.

  Note:Cache storage must be allocated to the gateway before you can create
  virtual tapes. Use the `AddCache` operation to add cache storage to a
  gateway.
  """
  def create_tapes(client, input) do
    request(client, "CreateTapes", input)
  end

  @doc """
  DeleteBandwidthRateLimit

  This operation deletes the bandwidth rate limits of a gateway. You can
  delete either the upload and download bandwidth rate limit, or you can
  delete both. If you delete only one of the limits, the other limit remains
  unchanged. To specify which gateway to work with, use the Amazon Resource
  Name (ARN) of the gateway in your request.
  """
  def delete_bandwidth_rate_limit(client, input) do
    request(client, "DeleteBandwidthRateLimit", input)
  end

  @doc """
  DeleteChapCredentials

  This operation deletes Challenge-Handshake Authentication Protocol (CHAP)
  credentials for a specified iSCSI target and initiator pair.
  """
  def delete_chap_credentials(client, input) do
    request(client, "DeleteChapCredentials", input)
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

  <important> You no longer pay software charges after the gateway is
  deleted; however, your existing Amazon EBS snapshots persist and you will
  continue to be billed for these snapshots. You can choose to remove all
  remaining Amazon EBS snapshots by canceling your Amazon EC2 subscription. 
  If you prefer not to cancel your Amazon EC2 subscription, you can delete
  your snapshots using the Amazon EC2 console. For more information, see the
  [ AWS Storage Gateway Detail Page](http://aws.amazon.com/storagegateway).

  </important>
  """
  def delete_gateway(client, input) do
    request(client, "DeleteGateway", input)
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
  def delete_snapshot_schedule(client, input) do
    request(client, "DeleteSnapshotSchedule", input)
  end

  @doc """
  DeleteTape

  Deletes the specified virtual tape.
  """
  def delete_tape(client, input) do
    request(client, "DeleteTape", input)
  end

  @doc """
  DeleteTapeArchive

  Deletes the specified virtual tape from the virtual tape shelf (VTS).
  """
  def delete_tape_archive(client, input) do
    request(client, "DeleteTapeArchive", input)
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
  def delete_volume(client, input) do
    request(client, "DeleteVolume", input)
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
  def describe_bandwidth_rate_limit(client, input) do
    request(client, "DescribeBandwidthRateLimit", input)
  end

  @doc """
  DescribeCache

  This operation returns information about the cache of a gateway. This
  operation is supported only for the gateway-cached volume architecture.

  The response includes disk IDs that are configured as cache, and it
  includes the amount of cache allocated and used.
  """
  def describe_cache(client, input) do
    request(client, "DescribeCache", input)
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
  def describe_cachedi_scsi_volumes(client, input) do
    request(client, "DescribeCachediSCSIVolumes", input)
  end

  @doc """
  DescribeChapCredentials

  This operation returns an array of Challenge-Handshake Authentication
  Protocol (CHAP) credentials information for a specified iSCSI target, one
  for each target-initiator pair.
  """
  def describe_chap_credentials(client, input) do
    request(client, "DescribeChapCredentials", input)
  end

  @doc """
  DescribeGatewayInformation

  This operation returns metadata about a gateway such as its name, network
  interfaces, configured time zone, and the state (whether the gateway is
  running or not). To specify which gateway to describe, use the Amazon
  Resource Name (ARN) of the gateway in your request.
  """
  def describe_gateway_information(client, input) do
    request(client, "DescribeGatewayInformation", input)
  end

  @doc """
  DescribeMaintenanceStartTime

  This operation returns your gateway's weekly maintenance start time
  including the day and time of the week. Note that values are in terms of
  the gateway's time zone.
  """
  def describe_maintenance_start_time(client, input) do
    request(client, "DescribeMaintenanceStartTime", input)
  end

  @doc """
  DescribeSnapshotSchedule

  This operation describes the snapshot schedule for the specified gateway
  volume. The snapshot schedule information includes intervals at which
  snapshots are automatically initiated on the volume.
  """
  def describe_snapshot_schedule(client, input) do
    request(client, "DescribeSnapshotSchedule", input)
  end

  @doc """
  DescribeStorediSCSIVolumes

  This operation returns the description of the gateway volumes specified in
  the request. The list of gateway volumes in the request must be from one
  gateway. In the response Amazon Storage Gateway returns volume information
  sorted by volume ARNs.
  """
  def describe_storedi_scsi_volumes(client, input) do
    request(client, "DescribeStorediSCSIVolumes", input)
  end

  @doc """
  DescribeTapeArchives

  Returns a description of specified virtual tapes in the virtual tape shelf
  (VTS).

  If a specific `TapeARN` is not specified, AWS Storage Gateway returns a
  description of all virtual tapes found in the VTS associated with your
  account.
  """
  def describe_tape_archives(client, input) do
    request(client, "DescribeTapeArchives", input)
  end

  @doc """
  DescribeTapeRecoveryPoints

  Returns a list of virtual tape recovery points that are available for the
  specified gateway-VTL.

  A recovery point is a point in time view of a virtual tape at which all the
  data on the virtual tape is consistent. If your gateway crashes, virtual
  tapes that have recovery points can be recovered to a new gateway.
  """
  def describe_tape_recovery_points(client, input) do
    request(client, "DescribeTapeRecoveryPoints", input)
  end

  @doc """
  DescribeTapes

  Returns a description of the specified Amazon Resource Name (ARN) of
  virtual tapes. If a `TapeARN` is not specified, returns a description of
  all virtual tapes associated with the specified gateway.
  """
  def describe_tapes(client, input) do
    request(client, "DescribeTapes", input)
  end

  @doc """
  DescribeUploadBuffer

  This operation returns information about the upload buffer of a gateway.
  This operation is supported for both the gateway-stored and gateway-cached
  volume architectures.

  The response includes disk IDs that are configured as upload buffer space,
  and it includes the amount of upload buffer space allocated and used.
  """
  def describe_upload_buffer(client, input) do
    request(client, "DescribeUploadBuffer", input)
  end

  @doc """
  DescribeVTLDevices

  Returns a description of virtual tape library (VTL) devices for the
  specified gateway. In the response, AWS Storage Gateway returns VTL device
  information.

  The list of VTL devices must be from one gateway.
  """
  def describe_vtl_devices(client, input) do
    request(client, "DescribeVTLDevices", input)
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
  def describe_working_storage(client, input) do
    request(client, "DescribeWorkingStorage", input)
  end

  @doc """
  DisableGateway

  Disables a gateway when the gateway is no longer functioning. For example,
  if your gateway VM is damaged, you can disable the gateway so you can
  recover virtual tapes.

  Use this operation for a gateway-VTL that is not reachable or not
  functioning.

  <important>Once a gateway is disabled it cannot be enabled.</important>
  """
  def disable_gateway(client, input) do
    request(client, "DisableGateway", input)
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
  def list_gateways(client, input) do
    request(client, "ListGateways", input)
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
  def list_local_disks(client, input) do
    request(client, "ListLocalDisks", input)
  end

  @doc """
  ListVolumeInitiators

  This operation lists iSCSI initiators that are connected to a volume. You
  can use this operation to determine whether a volume is being used or not.
  """
  def list_volume_initiators(client, input) do
    request(client, "ListVolumeInitiators", input)
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
  def list_volume_recovery_points(client, input) do
    request(client, "ListVolumeRecoveryPoints", input)
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
  def list_volumes(client, input) do
    request(client, "ListVolumes", input)
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

  <important> If the cache disk you are resetting contains data that has not
  been uploaded to Amazon S3 yet, that data can be lost. After you reset
  cache disks, there will be no configured cache disks left in the gateway,
  so you must configure at least one new cache disk for your gateway to
  function properly.

  </important>
  """
  def reset_cache(client, input) do
    request(client, "ResetCache", input)
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
  def retrieve_tape_archive(client, input) do
    request(client, "RetrieveTapeArchive", input)
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
  def retrieve_tape_recovery_point(client, input) do
    request(client, "RetrieveTapeRecoveryPoint", input)
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
  def shutdown_gateway(client, input) do
    request(client, "ShutdownGateway", input)
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
  def start_gateway(client, input) do
    request(client, "StartGateway", input)
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
  def update_bandwidth_rate_limit(client, input) do
    request(client, "UpdateBandwidthRateLimit", input)
  end

  @doc """
  UpdateChapCredentials

  This operation updates the Challenge-Handshake Authentication Protocol
  (CHAP) credentials for a specified iSCSI target. By default, a gateway does
  not have CHAP enabled; however, for added security, you might use it.

  <important> When you update CHAP credentials, all existing connections on
  the target are closed and initiators must reconnect with the new
  credentials.

  </important>
  """
  def update_chap_credentials(client, input) do
    request(client, "UpdateChapCredentials", input)
  end

  @doc """
  UpdateGatewayInformation

  This operation updates a gateway's metadata, which includes the gateway's
  name and time zone. To specify which gateway to update, use the Amazon
  Resource Name (ARN) of the gateway in your request.
  """
  def update_gateway_information(client, input) do
    request(client, "UpdateGatewayInformation", input)
  end

  @doc """
  UpdateGatewaySoftwareNow

  This operation updates the gateway virtual machine (VM) software. The
  request immediately triggers the software update.

  Note:When you make this request, you get a `200 OK` success response
  immediately. However, it might take some time for the update to complete.
  You can call `DescribeGatewayInformation` to verify the gateway is in the
  `STATE_RUNNING` state. <important>A software update forces a system restart
  of your gateway. You can minimize the chance of any disruption to your
  applications by increasing your iSCSI Initiators' timeouts. For more
  information about increasing iSCSI Initiator timeouts for Windows and
  Linux, see [Customizing Your Windows iSCSI
  Settings](http://docs.aws.amazon.com/storagegateway/latest/userguide/ConfiguringiSCSIClientInitiatorWindowsClient.html#CustomizeWindowsiSCSISettings)
  and [Customizing Your Linux iSCSI
  Settings](http://docs.aws.amazon.com/storagegateway/latest/userguide/ConfiguringiSCSIClientInitiatorRedHatClient.html#CustomizeLinuxiSCSISettings),
  respectively.</important>
  """
  def update_gateway_software_now(client, input) do
    request(client, "UpdateGatewaySoftwareNow", input)
  end

  @doc """
  UpdateMaintenanceStartTime

  This operation updates a gateway's weekly maintenance start time
  information, including day and time of the week. The maintenance time is
  the time in your gateway's time zone.
  """
  def update_maintenance_start_time(client, input) do
    request(client, "UpdateMaintenanceStartTime", input)
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
  def update_snapshot_schedule(client, input) do
    request(client, "UpdateSnapshotSchedule", input)
  end

  @doc """
  UpdateVTLDeviceType

  This operation updates the type of medium changer in a gateway-VTL. When
  you activate a gateway-VTL, you select a medium changer type for the
  gateway-VTL. This operation enables you to select a different type of
  medium changer after a gateway-VTL is activated.
  """
  def update_vtl_device_type(client, input) do
    request(client, "UpdateVTLDeviceType", input)
  end


  defp request(%{__struct__: client_module} = client, action, input) do
    client_module.request(client, action, input)
  end
end
