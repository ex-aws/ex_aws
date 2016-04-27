defmodule ExAws.EC2.Client do
  use Behaviour

  @moduledoc """
  
  """

  @type instance_types :: [
    :t1_micro    | :m1_small    | :m1_medium  | :m1_large    | :m1_xlarge   | :m3_medium   | 
    :m3_large    | :m3_xlarge   | :m3_2xlarge | :m4_large    | :m4_xlarge   | :m4_2xlarge  | 
    :m4_4xlarge  | :m4_10xlarge | :t2_nano    | :t2_micro    | :t2_small    | :t2_medium   | 
    :t2_large    | :m2_xlarge   | :m2_2xlarge | :m2_4xlarge  | :cr1_8xlarge | :i2_xlarge   | 
    :i2_2xlarge  | :i2_4xlarge  | :i2_8xlarge | :hi1_4xlarge | :hs1_8xlarge | :c1_medium   | 
    :c1_xlarge   | :c3_large    | :c3_xlarge  | :c3_2xlarge  | :c3_4xlarge  | :c3_8xlarge  | 
    :c4_large    | :c4_xlarge   | :c4_2xlarge | :c4_4xlarge  | :c4_8xlarge  | :cc1_4xlarge | 
    :cc2_8xlarge | :g2_2xlarge  | :g2_8xlarge | :cg1_4xlarge | :r3_large    | :r3_xlarge   | 
    :r3_2xlarge  | :r3_4xlarge  | :r3_8xlarge | :d2_xlarge   | :d2_2xlarge  | :d2_4xlarge  | 
    :d2_8xlarge
  ]

  @type run_instances_monitoring_enabled :: [
    {:enabled, boolean}
  ]

  @type filter :: [
    {:name, binary} | 
    {:value, [binary]}
  ]

  @type placement :: [
    {:affinity, binary} | 
    {:availability_zone, binary} | 
    {:group_name, binary} | 
    {:host_id, binary} | 
    {:tenancy, :default | :dedicated | :host}
  ]

  @type iam_instance_profile :: [
    {:arn, binary} | 
    {:name, binary}
  ]

  @type attributes :: [
    :instance_type | :kernel | :ramdisk | :user_data | :disable_api_termination |
    :instance_initiated_shutdown_behavior | :root_device_name | :block_device_mapping |
    :product_codes | :source_dest_check | :group_set | :ebs_optimized | :sriov_net_support
  ]

  @type attribute_boolean_value :: [
    {:value, boolean}
  ]

  @type attribute_value :: [
    {:value, binary}
  ]

  @type io1_volume_iops_range :: 100..20000

  @type gp2_volume_iops_range :: 100..10000

  @type ebs_block_device :: [
    {:delete_on_termination, boolean} | 
    {:encrypted, boolean} | 
    {:iops, io1_volume_iops_range | gp2_volume_iops_range} | 
    {:snapshot_id, binary} | 
    {:volume_size, integer} | 
    {:volume_type, :standard | :io1 | :gp2 | :sc1 | :st1}
  ]

  @type block_device_mapping_list :: [
    {:device_name, binary} | 
    {:ebs, ebs_block_device} |
    {:no_device, binary} | 
    {:virtual_name, binary}
  ]

  @type describe_instances_opts :: [
    {:dry_run, boolean} | 
    #{:filter_n}
    #{:instance_id_n}
    {:max_results, integer} | 
    {:next_token, binary}
  ]
  defcallback describe_instances() :: ExAws.Request.response_t
  defcallback describe_instances(opts :: describe_instances_opts) :: ExAws.Request.response_t

  @type describe_instance_status_opts :: [
    {:dry_run, boolean} | 
    #{:filter_n}
    #{:instance_id_n}
    {:include_all_instances, boolean} | 
    {:max_results, integer} | 
    {:next_token, binary}
  ]
  @doc """
  Describes the status of one or more instances. By default, only running
  instances are described, unless specified otherwise.
  """
  defcallback describe_instance_status() :: ExAws.Request.response_t
  defcallback describe_instance_status(opts :: describe_instance_status_opts) :: ExAws.Request.response_t

  @type run_instances_opts :: [
    {:additional_info, binary} | 
    #{:block_device_mapping.n}
    {:client_token, binary} | 
    {:disable_api_termination, boolean} | 
    {:dry_run, boolean} | 
    {:ebs_optimized, boolean} | 
    {:iam_instance_profile, iam_instance_profile} | 
    {:instance_initiated_shutdown_behavior, :stop | :terminate} | 
    {:instance_type, instance_types} | 
    {:kernel_id, binary} | 
    {:key_name, binary} | 
    {:monitoring, run_instances_monitoring_enabled} | 
    #{:network_interface_n}
    {:placement, placement} | 
    {:private_ip_address, binary} | 
    {:ram_disk_id, binary} | 
    #{:security_group_id_n} | 
    #{:security_group_n} | 
    {:user_data, binary}
  ]
  @doc """
  Launches the speficied number of instance using an AMI.
  """
  defcallback run_instances(image_id :: binary, max :: pos_integer, min :: pos_integer) :: ExAws.Request.response_t
  defcallback run_instances(image_id :: binary, max :: pos_integer, min :: pos_integer, opts :: run_instances_opts) :: ExAws.Request.response_t

  @type start_instances_opts :: [
    {:additional_info, binary} | 
    {:dry_run, boolean}
    #{:instance_id_n}
  ]
  @doc """
  Starts an Amazon EBS-backed AMI that was previously stopped.
  """
  defcallback start_instances(instance_ids :: list(binary)) :: ExAws.Request.response_t  
  defcallback start_instances(instance_ids :: list(binary), opts :: start_instances_opts) :: ExAws.Request.response_t  

  @type stop_instances_opts :: [
    {:dry_run, boolean} | 
    {:force, boolean}
    #{:instance_id_n, }
  ]
  @doc """
  Stops an Amazon EBS-backed AMI that was previously started.
  """
  defcallback stop_instances(instance_ids :: list(binary)) :: ExAws.Request.response_t
  defcallback stop_instances(instance_ids :: list(binary), opts :: stop_instances_opts) :: ExAws.Request.response_t  

  @type terminate_instances_opts :: [
    {:dry_run, boolean}  
    #{:instance_id_n}
  ]
  @doc """
  Shuts down one or more instances. Terminated instances remain visible after 
  termination (for approximately one hour).
  """
  defcallback terminate_instances(instance_ids :: list(binary)) :: ExAws.Request.response_t
  defcallback terminate_instances(instance_ids :: list(binary), opts :: terminate_instances_opts) :: ExAws.Request.response_t    

  @type reboot_instances_opts :: [
    {:dry_run, boolean}  
    #{:instance_id_n}
  ]
  @doc """
  Requests a reboot of one or more instances. This operation is asynchronous; it
  only queues a request to reboot the specified instances.
  """
  defcallback reboot_instances(instance_ids :: list(binary)) :: ExAws.Request.response_t
  defcallback reboot_instances(instance_ids :: list(binary), opts :: reboot_instances_opts) :: ExAws.Request.response_t

  @type report_instance_status_opts :: [
    {:description, binary} | 
    {:dry_run, boolean} | 
    #{:end_time, } | 
    #{:instance_id_n} | 
    #{:reason_code_n} | 
    #{:start_time, } | 
    {:status, :ok | :impaired}
  ]
  @doc """
  Submits feedback about the status of an instance. The instance must be in the 
  running state.
  """
  defcallback report_instance_status(instance_ids :: list(binary), status :: binary) :: ExAws.Request.response_t
  defcallback report_instance_status(instance_ids :: list(binary), status :: binary, opts :: report_instance_status_opts) :: ExAws.Request.response_t  

  @type monitor_instances_opts :: [
    {:dry_run, boolean} 
    #{:instance_id_n, }
  ]
  @doc """
  Enables monitoring for a running instance.
  """
  defcallback monitor_instances(instance_ids :: list(binary)) :: ExAws.Request.response_t
  defcallback monitor_instances(instance_ids :: list(binary), opts :: monitor_instances_opts) :: ExAws.Request.response_t

  @type unmonitor_instances_opts :: [
    {:dry_run, boolean} 
    #{:instance_id_n}
  ]
  @doc """
  Disables monitoring for a running instance. 
  """
  defcallback unmonitor_instances(instance_ids :: list(binary)) :: ExAws.Request.response_t
  defcallback unmonitor_instances(instance_ids :: list(binary), opts :: unmonitor_instances_opts) :: ExAws.Request.response_t    

  @type describe_instance_attribute_opts :: [
    {:attribte, attributes} | 
    {:dry_run, boolean} | 
    {:intance_id, boolean}
  ]
  @doc """
  Describes the specified attribute of the specified instance. You can specify 
  only one attribute at a time.
  """
  defcallback describe_instance_attribute(instace_id :: binary, attribute :: binary) :: ExAws.Request.response_t
  defcallback describe_instance_attribute(instace_id :: binary, attribute :: binary, opts :: describe_instance_attribute_opts) :: ExAws.Request.response_t  

  @type modify_instance_attribute_opts :: [
    {:attribute, attributes} | 
    #{:block_device_mapping} |
    {:disable_api_termination, attribute_boolean_value} | 
    {:dry_run, boolean} | 
    {:ebs_optimized, attribute_boolean_value} | 
    #{:group_id_n} | 
    {:instance_initiated_shutdown_behavior, attribute_value} |
    {:kernel, attribute_value} | 
    {:ramdisk, attribute_value} | 
    {:source_dest_check, attribute_boolean_value} | 
    {:sriov_net_support, attribute_value} | 
    {:user_data, attribute_value} | 
    {:value, binary}
  ]
  @doc """
  Modifies the specified attribute of the specified instance. You can 
  specify only one attribute at a time.
  """
  defcallback modify_instance_attribute(instace_id :: binary) :: ExAws.Request.response_t
  defcallback modify_instance_attribute(instace_id :: binary, opts :: modify_instance_attribute_opts) :: ExAws.Request.response_t  

  @type reset_instance_attribute_opts :: [
    {:dry_run, boolean}
  ]
  @doc """
  Resets an attribute of an instance to its default value. To reset the kernel 
  or ramdisk, the instance must be in a stopped state. To reset the 
  SourceDestCheck, the instance can be either running or stopped.
  """
  defcallback reset_instance_attribute(instace_id :: binary, attribute :: binary) :: ExAws.Request.response_t
  defcallback reset_instance_attribute(instace_id :: binary, attribute :: binary, opts :: reset_instance_attribute_opts) :: ExAws.Request.response_t  

  @type get_console_output_opts :: [
    {:dry_run, boolean} | 
    {:instance_id, binary}
  ]
  @doc """
  Gets the console output for the specified instance.
  """
  defcallback get_console_output(instace_id :: binary) :: ExAws.Request.response_t
  defcallback get_console_output(instace_id :: binary, opts :: get_console_output_opts) :: ExAws.Request.response_t  

  @type get_password_data_opts :: [
    {:dry_run, boolean} | 
    {:instance_id, binary}
  ]
  @doc """
  Retrieves the encrypted administrator password for an instance running 
  Windows.
  """
  defcallback get_password_data(instace_id :: binary) :: ExAws.Request.response_t
  defcallback get_password_data(instace_id :: binary, opts :: get_password_data_opts) :: ExAws.Request.response_t  

  @type describe_availability_zones_opts :: [
    {:dry_run, boolean}# | 
    #{:filter_n} | 
    #{:zone_name_n}
  ]
  @doc """
  Describes one or more of the Availability Zones that are available to you. 
  The results include zones only for the region you're currently using.
  """
  defcallback describe_availability_zones() :: ExAws.Request.response_t
  defcallback describe_availability_zones(opts :: describe_availability_zones_opts) :: ExAws.Request.response_t  

  @type describe_regions_opts :: [
    {:dry_run, boolean} #| 
    #{:filter_nl} |
    #{:region_name_n}
  ]
  @doc """
  Describes one or more regions that are currently available to you.
  """
  defcallback describe_regions() :: ExAws.Request.response_t
  defcallback describe_regions(opts :: describe_regions_opts) :: ExAws.Request.response_t  

  @type create_image_opts :: [
    #{:block_device_mapping_n} | 
    {:description, binary} | 
    {:dry_run, boolean} | 
    {:no_reboot, boolean}
  ]
  @doc """
  Creates an Amazon EBS-backed AMI from an Amazon EBS-backed instance 
  that is either running or stopped.
  """
  defcallback create_image(instace_id :: binary, name :: binary) :: ExAws.Request.response_t
  defcallback create_image(instace_id :: binary, name :: binary, opts :: create_image_opts) :: ExAws.Request.response_t  

  @doc """
  Initiates the copy of an AMI from the specified source region to the current 
  region. You specify the destination region by using its endpoint when 
  making the request.
  """
  defcallback copy_image(name :: binary, source_image_id :: binary, source_region :: binary) :: ExAws.Request.response_t  
  defcallback copy_image(name :: binary, source_image_id :: binary, source_region :: binary, opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Describes one or more of the images (AMIs, AKIs, and ARIs) available to you.
  """
  defcallback describe_images() :: ExAws.Request.response_t
  defcallback describe_images(opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Describes the specified attribute of the specified AMI. You can specify 
  only one attribute at a time.
  """
  defcallback describe_image_attribute(image_id :: binary, attribute :: binary) :: ExAws.Request.response_t
  defcallback describe_image_attribute(image_id :: binary, attribute :: binary, opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Modifies the specified attribute of the specified AMI. You can specify only 
  one attribute at a time.
  """
  defcallback modify_image_attribute(image_id :: binary) :: ExAws.Request.response_t
  defcallback modify_image_attribute(image_id :: binary, opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Resets an attribute of an AMI to its default value.
  """
  defcallback reset_image_attribute(image_id :: binary, attribute :: binary) :: ExAws.Request.response_t
  defcallback reset_image_attribute(image_id :: binary, attribute :: binary, opts :: Map.t) :: ExAws.Request.response_t  

  @doc """
  Registers an AMI. When you're creating an AMI, this is the final step you 
  must complete before you can launch an instance from the AMI.
  """
  defcallback register_image(name :: binary, parameter_value :: binary, parameter_type :: :root_device_name | :image_location) :: ExAws.Request.response_t
  defcallback register_image(name :: binary, parameter_value :: binary, parameter_type :: :root_device_name | :image_location, opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Deregisters the specified AMI. After you deregister an AMI, it can't be used 
  to launch new instances.
  """
  defcallback deregister_image(image_id :: binary) :: ExAws.Request.response_t
  defcallback deregister_image(image_id :: binary, opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Describes one or more of your key pairs.
  """
  defcallback describe_key_pairs() :: ExAws.Request.response_t
  defcallback describe_key_pairs(opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Creates a 2048-bit RSA key pair with the specified name. Amazon EC2 stores 
  the public key and displays the private key for you to save to a file. 
  The private key is returned as an unencrypted PEM encoded PKCS#8 private key.
  """
  defcallback create_key_pair(key_name :: binary) :: ExAws.Request.response_t
  defcallback create_key_pair(key_name :: binary, opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Deletes the specified key pair, by removing the public key from Amazon EC2.
  """
  defcallback delete_key_pair(key_name :: binary) :: ExAws.Request.response_t
  defcallback delete_key_pair(key_name :: binary, opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Imports the public key from an RSA key pair that you created with a 
  third-party tool. 
  """
  defcallback import_key_pair(key_name :: binary, public_key_material :: binary) :: ExAws.Request.response_t
  defcallback import_key_pair(key_name :: binary, public_key_material :: binary, opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Describes the ID format settings for your resources on a per-region basis, 
  for example, to view which resource types are enabled for longer IDs.
  """
  defcallback describe_id_format() :: ExAws.Request.response_t
  defcallback describe_id_format(opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Modifies the ID format for the specified resource on a per-region basis.
  """
  defcallback modify_id_format(resource :: binary, use_long_ids :: boolean) :: ExAws.Request.response_t
  defcallback modify_id_format(resource :: binary, use_long_ids :: boolean, opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Describes one or more of your security groups.
  """
  defcallback describe_security_groups() :: ExAws.Request.response_t
  defcallback describe_security_groups(opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Creates a security group.
  """
  defcallback create_security_group(group_name :: binary, group_description :: binary) :: ExAws.Request.response_t
  defcallback create_security_group(group_name :: binary, group_description :: binary, opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Adds one or more ingress rules to a security group.
  """
  defcallback authorize_security_group_ingress() :: ExAws.Request.response_t
  defcallback authorize_security_group_ingress(opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Adds one or more egress rules to a security group for use with a VPC. 
  """
  defcallback authorize_security_group_egress(group_id :: binary) :: ExAws.Request.response_t
  defcallback authorize_security_group_egress(group_id :: binary, opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Removes one or more ingress rules from a security group. The values that 
  you specify in the revoke request (for example, ports) must match 
  the existing rule's values for the rule to be removed.
  """
  defcallback revoke_security_group_ingress() :: ExAws.Request.response_t
  defcallback revoke_security_group_ingress(opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Removes one or more egress rules from a security group for EC2-VPC.
  """
  defcallback revoke_security_group_egress(group_id :: binary) :: ExAws.Request.response_t
  defcallback revoke_security_group_egress(group_id :: binary, opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Describes one or more of your VPCs.
  """
  defcallback describe_vpcs() :: ExAws.Request.response_t
  defcallback describe_vpcs(opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Creates a VPC with the specified CIDR block.
  """
  defcallback create_vpc(cidr_block :: binary) :: ExAws.Request.response_t
  defcallback create_vpc(cidr_block :: binary, opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Deletes the specified VPC.
  """
  defcallback delete_vpc(vpc_id :: binary) :: ExAws.Request.response_t
  defcallback delete_vpc(vpc_id :: binary, opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Describes the specified attribute of the specified VPC. You can specify only one attribute at a time.
  """
  defcallback describe_vpc_attribute(vpc_id :: binary, attribute :: binary) :: ExAws.Request.response_t
  defcallback describe_vpc_attribute(vpc_id :: binary, attribute :: binary, opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Modifies the specified attribute of the specified VPC.
  """
  defcallback modify_vpc_attribute(vpc_id :: binary, attribute :: atom, value :: binary | boolean) :: ExAws.Request.response_t
  defcallback modify_vpc_attribute(vpc_id :: binary, attribute :: atom, value :: binary | boolean, opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Describes one or more of your subnets.
  """
  defcallback describe_subnets() :: ExAws.Request.response_t
  defcallback describe_subnets(opts :: Map.t) :: ExAws.Request.response_t
 
  @doc """
  Creates a subnet in an existing VPC.
  """
  defcallback create_subnet(vpc_id :: binary, cidr_block :: binary) :: ExAws.Request.response_t
  defcallback create_subnet(vpc_id :: binary, cidr_block :: binary, opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Deletes the specified subnet.
  """
  defcallback delete_subnet(subnet_id :: binary) :: ExAws.Request.response_t
  defcallback delete_subnet(subnet_id :: binary, opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Modifies a subnet attribute.
  """
  defcallback modify_subnet_attribute(subnet_id :: binary) :: ExAws.Request.response_t
  defcallback modify_subnet_attribute(subnet_id :: binary, opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Describes one or more of the tags for your EC2 resources.
  """
  defcallback describe_tags() :: ExAws.Request.response_t
  defcallback describe_tags(opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Adds or overwrites one or more tags for the specified Amazon EC2 resource or 
  resources. Each resource can have a maximum of 10 tags. Each tag consists of 
  a key and optional value. Tag keys must be unique per resource.
  """
  defcallback create_tags(resource_ids :: list(binary), tags :: list({binary, binary})) :: ExAws.Request.response_t
  defcallback create_tags(resource_ids :: list(binary), tags :: list({binary, binary}), opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Deletes the specified set of tags from the specified set of resources.
  """
  defcallback delete_tags(resource_ids :: list(binary)) :: ExAws.Request.response_t
  defcallback delete_tags(resource_ids :: list(binary), opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Describes the specified EBS volumes.
  """
  defcallback describe_volumes() :: ExAws.Request.response_t
  defcallback describe_volumes(opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Creates an EBS volume that can be attached to an instance in the same 
  Availability Zone. The volume is created in the regional endpoint that you 
  send the HTTP request to. 
  """
  defcallback create_volume(availability_zone :: binary, size :: integer) :: ExAws.Request.response_t
  defcallback create_volume(availability_zone :: binary, size :: integer, opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Deletes the specified EBS volume. The volume must be in the available state 
  (not attached to an instance).
  """
  defcallback delete_volume(volume_id :: binary) :: ExAws.Request.response_t
  defcallback delete_volume(volume_id :: binary, opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Attaches an EBS volume to a running or stopped instance and exposes it to 
  the instance with the specified device name.
  """
  defcallback attach_volume(instace_id :: binary, volume_id :: binary, device :: binary) :: ExAws.Request.response_t
  defcallback attach_volume(instace_id :: binary, volume_id :: binary, device :: binary, opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Detaches an EBS volume from an instance. 
  """
  defcallback detach_volume(volume_id :: binary) :: ExAws.Request.response_t
  defcallback detach_volume(volume_id :: binary, opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Describes the specified attribute of the specified volume. You can specify 
  only one attribute at a time.
  """
  defcallback describe_volume_attribute(volume_id :: binary, attribute :: binary) :: ExAws.Request.response_t
  defcallback describe_volume_attribute(volume_id :: binary, attribute :: binary, opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Enables I/O operations for a volume that had I/O operations disabled because 
  the data on the volume was potentially inconsistent.
  """
  defcallback enable_volume_io(volume_id :: binary) :: ExAws.Request.response_t
  defcallback enable_volume_io(volume_id :: binary, opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Modifies a volume attribute.
  """
  defcallback modify_volume_attribute(volume_id :: binary) :: ExAws.Request.response_t
  defcallback modify_volume_attribute(volume_id :: binary, opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Describes the status of the specified volumes.
  """
  defcallback describe_volume_status() :: ExAws.Request.response_t
  defcallback describe_volume_status(opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Describes one or more of the EBS snapshots available to you.
  """
  defcallback describe_snapshots() :: ExAws.Request.response_t
  defcallback describe_snapshots(opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Creates a snapshot of an EBS volume and stores it in Amazon S3. 
  You can use snapshots for backups, to make copies of EBS volumes, and to 
  save data before shutting down an instance.
  """
  defcallback create_snapshot(volume_id :: binary) :: ExAws.Request.response_t
  defcallback create_snapshot(volume_id :: binary, opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Copies a point-in-time snapshot of an EBS volume and stores it in Amazon S3. 
  You can copy the snapshot within the same region or from one region to 
  another.
  """
  defcallback copy_snapshot(source_snapshot_id :: binary, source_region :: binary) :: ExAws.Request.response_t
  defcallback copy_snapshot(source_snapshot_id :: binary, source_region :: binary, opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Deletes the specified snapshot.
  """
  defcallback delete_snapshot(snapshot_id :: binary) :: ExAws.Request.response_t
  defcallback delete_snapshot(snapshot_id :: binary, opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Describes the specified attribute of the specified snapshot. You can specify 
  only one attribute at a time.
  """
  defcallback describe_snapshot_attribute(snapshot_id :: binary, attribute :: binary) :: ExAws.Request.response_t
  defcallback describe_snapshot_attribute(snapshot_id :: binary, attribute :: binary, opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Adds or removes permission settings for the specified snapshot.
  """
  defcallback modify_snapshot_attribute(snapshot_id :: binary) :: ExAws.Request.response_t
  defcallback modify_snapshot_attribute(snapshot_id :: binary, opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Resets permission settings for the specified snapshot.
  """
  defcallback reset_snapshot_attribute(snapshot_id :: binary, attribute :: binary) :: ExAws.Request.response_t
  defcallback reset_snapshot_attribute(snapshot_id :: binary, attribute :: binary, opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Describes attributes of your AWS account.
  """
  defcallback describe_account_attributes() :: ExAws.Request.response_t
  defcallback describe_account_attributes(opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Bundles an Amazon instance store-backed Windows instance.
  During bundling, only the root device volume (C:\) is bundled. Data on other 
  instance store volumes is not preserved.
  """
  defcallback bundle_instance(instance_id :: binary, {s3_aws_access_key_id :: binary, s3_bucket :: binary, s3_prefix :: binary, s3_upload_policy :: binary, s3_upload_policy_sig :: binary}) :: ExAws.Request.response_t
  defcallback bundle_instance(instance_id :: binary, {s3_aws_access_key_id :: binary, s3_bucket :: binary, s3_prefix :: binary, s3_upload_policy :: binary, s3_upload_policy_sig :: binary}, opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Cancels a bundling operation for an instance store-backed Windows instance.
  """
  defcallback cancel_bundle_task(bundle_id :: binary) :: ExAws.Request.response_t
  defcallback cancel_bundle_task(bundle_id :: binary, opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Describes one or more of your bundling tasks.
  """
  defcallback describe_bundle_tasks() :: ExAws.Request.response_t
  defcallback describe_bundle_tasks(opts :: Map.t) :: ExAws.Request.response_t

  defmacro __using__(opts) do 

    boilerplate = __MODULE__
    |> ExAws.Client.generate_boilerplate(opts)
     quote do 
      defstruct config: nil, service: :ec2
      unquote(boilerplate)

      @doc false
      def request(client, http_method, path, data \\ []) do
        ExAws.EC2.Request.request(client, http_method, path, data)
      end

      defoverridable config_root: 0, request: 3, request: 4
     end
  end
end