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

  @type datetime :: {
    calendar    :: term, 
    day         :: term, 
    hour        :: term, 
    millisecond :: term, 
    minute      :: term, 
    month       :: term, 
    second      :: term, 
    timezone    :: term, 
    year        :: term}

  @type run_instances_monitoring_enabled :: enabled :: boolean

  @type filter :: {name :: binary, value :: [binary]}

  @type placement :: {
    affinity          :: binary, 
    availability_zone :: binary,
    group_name        :: binary,
    host_id           :: binary,
    tenancy           :: :default | :dedicated | :host
  } 

  @type iam_instance_profile :: {arn :: binary, name :: binary}

  @type s3_storage :: {
    aws_access_key_id       :: binary, 
    bucket                  :: binary, 
    prefix                  :: binary,
    upload_policy           :: binary,
    upload_policy_signature :: Base.url_encode64(binary)
  }

  @type prefix_list_id :: prefix_list_id :: binary

  @type ip_range :: cidr_ip :: binary

  @type user_id_group_pair :: {
    group_id                  :: binary,
    group_name                :: binary, 
    peering_status            :: binary,
    user_id                   :: binary, 
    vpc_id                    :: binary, 
    vpc_peering_connection_id :: binary
  }

  @type ip_permission :: {
    from_port       :: pos_integer, 
    ip_protocol     :: (:tcp | :udp | :icmp | integer),
    ip_ranges       :: ip_range, 
    prefix_list_ids :: [prefix_list_id], 
    to_port         :: pos_integer, 
    groups          :: [user_id_group_pair]
  }

  @type attributes :: [
    :instance_type | :kernel | :ramdisk | :user_data | :disable_api_termination |
    :instance_initiated_shutdown_behavior | :root_device_name | :block_device_mapping |
    :product_codes | :source_dest_check | :group_set | :ebs_optimized | :sriov_net_support
  ]

  @type attribute_boolean_value :: value :: boolean

  @type attribute_value :: value :: binary
 
  @type tag :: {key :: binary, value :: binary}

  @type launch_permission :: {group :: binary, user_id :: binary}

  @type launch_permission_list :: [launch_permission]

  @type launch_permission_modifications :: {add :: launch_permission_list, remove :: launch_permission_list}

  @type io1_volume_iops_range :: 100..20000
  @type gp2_volume_iops_range :: 100..10000

  @type io1_size_range      :: 4..16384
  @type gp2_size_range      :: 1..16384
  @type st1_size_range      :: 500..16384
  @type sc1_size_range      :: 500..16384
  @type standard_size_range :: 1..1024

  @type available_size_ranges :: io1_size_range | gp2_size_range | st1_size_range | sc1_size_range | standard_size_range

  @type private_ip_address_specification :: {private_ip_address :: boolean, private_ip_address :: binary}

  @type instance_network_interface_specification :: {
    associate_public_ip_address        :: boolean,
    delete_on_termination              :: boolean,
    description                        :: binary,
    device_index                       :: integer,
    security_group_id                  :: [binary],
    network_interface_id               :: binary,
    private_ip_address                 :: binary,
    private_ip_address_set             :: [private_ip_address_specification],
    secondary_private_ip_address_count :: integer,
    subnet_id                          :: binary
  }

  @type ebs_instance_block_device_specification :: {delete_on_termination :: boolean, volume_id :: binary}

  @type instance_block_device_mapping_specification :: {
    device_name :: binary,
    ebs :: ebs_instance_block_device_specification,
    no_device :: binary,
    virtual_name :: binary
  }

  @type ebs_block_device :: {
    delete_on_termination :: boolean,
    encrypted             :: boolean,
    iops                  :: io1_volume_iops_range | gp2_volume_iops_range,
    snapshot_id           :: binary,
    volume_size           :: integer,
    volume_type           :: :standard | :io1 | :gp2 | :sc1 | :st1
  }

  @type block_device_mapping :: {
    device_name  :: binary,
    ebs          :: ebs_block_device, 
    no_device    :: binary,
    virtual_name :: binary
  }

  @type block_device_mapping_list :: [block_device_mapping]

  @type create_volume_permission :: {group :: binary, user_id :: binary}

  @type create_volume_permission_modifications :: {add :: [create_volume_permission], remove :: [create_volume_permission]}

  @type describe_instances_opts :: [
    {:dry_run, boolean}            | 
    [{:filter_1, filter}, ...]     | 
    [{:instance_1, [binary]}, ...] | 
    {:max_results, integer}        | 
    {:next_token, binary}
  ]
  @doc """
  Describes one or more of your instances.
  """
  defcallback describe_instances() :: ExAws.Request.response_t
  defcallback describe_instances(opts :: describe_instances_opts) :: ExAws.Request.response_t

  @type describe_instance_status_opts :: [
    {:dry_run, boolean}               | 
    [{:filter_1, filter}, ...]        |
    [{:instance_1, [binary]}, ...]    |
    {:include_all_instances, boolean} | 
    {:max_results, integer}           | 
    {:next_token, binary}
  ]
  @doc """
  Describes the status of one or more instances. By default, only running
  instances are described, unless specified otherwise.
  """
  defcallback describe_instance_status() :: ExAws.Request.response_t
  defcallback describe_instance_status(opts :: describe_instance_status_opts) :: ExAws.Request.response_t

  @type run_instances_opts :: [
    {:additional_info, binary}                                                | 
    [{:block_device_mapping_1, block_device_mapping_list}, ...]               |
    {:client_token, binary}                                                   | 
    {:disable_api_termination, boolean}                                       | 
    {:dry_run, boolean}                                                       | 
    {:ebs_optimized, boolean}                                                 | 
    {:iam_instance_profile, iam_instance_profile}                             | 
    {:instance_initiated_shutdown_behavior, :stop | :terminate}               | 
    {:instance_type, instance_types}                                          | 
    {:kernel_id, binary}                                                      | 
    {:key_name, binary}                                                       | 
    {:monitoring, run_instances_monitoring_enabled}                           | 
    [{:network_interface_1, [instance_network_interface_specification]}, ...] | 
    {:placement, placement}                                                   | 
    {:private_ip_address, binary}                                             | 
    {:ram_disk_id, binary}                                                    | 
    [{:security_group_id_1, [binary]}, ...]                                   | 
    [{:security_group_1, [binary]}, ...]                                      | 
    {:user_data, binary}
  ]
  @doc """
  Launches the speficied number of instance using an AMI.
  """
  defcallback run_instances(image_id :: binary, max :: pos_integer, min :: pos_integer) :: ExAws.Request.response_t
  defcallback run_instances(image_id :: binary, max :: pos_integer, min :: pos_integer, opts :: run_instances_opts) :: ExAws.Request.response_t

  @type start_instances_opts :: [
    {:additional_info, binary} | 
    {:dry_run, boolean}        |
    [{:instance_id_1, [binary]}, ...]
  ]
  @doc """
  Starts an Amazon EBS-backed AMI that was previously stopped.
  """
  defcallback start_instances(instance_ids :: list(binary)) :: ExAws.Request.response_t  
  defcallback start_instances(instance_ids :: list(binary), opts :: start_instances_opts) :: ExAws.Request.response_t  

  @type stop_instances_opts :: [
    {:dry_run, boolean} | 
    {:force, boolean}   |
    [{:instance_id_1, [binary]}, ...]
  ]
  @doc """
  Stops an Amazon EBS-backed AMI that was previously started.
  """
  defcallback stop_instances(instance_ids :: list(binary)) :: ExAws.Request.response_t
  defcallback stop_instances(instance_ids :: list(binary), opts :: stop_instances_opts) :: ExAws.Request.response_t  

  @type terminate_instances_opts :: [
    {:dry_run, boolean} |
    [{:instance_id_1, [binary]}, ...]
  ]
  @doc """
  Shuts down one or more instances. Terminated instances remain visible after 
  termination (for approximately one hour).
  """
  defcallback terminate_instances(instance_ids :: list(binary)) :: ExAws.Request.response_t
  defcallback terminate_instances(instance_ids :: list(binary), opts :: terminate_instances_opts) :: ExAws.Request.response_t    

  @type reboot_instances_opts :: [
    {:dry_run, boolean} |
    [{:instance_id_1, [binary]}, ...]
  ]
  @doc """
  Requests a reboot of one or more instances. This operation is asynchronous; it
  only queues a request to reboot the specified instances.
  """
  defcallback reboot_instances(instance_ids :: list(binary)) :: ExAws.Request.response_t
  defcallback reboot_instances(instance_ids :: list(binary), opts :: reboot_instances_opts) :: ExAws.Request.response_t

  @type reason_code :: :instance_stuck_in_state | :unresponsive | :not_accepting_credentials | :password_not_available | :performance_network | :performance_instance_store | :perforamce_ebs_volume | :performance_other | :other

  @type report_instance_status_opts :: [
    {:description, binary}               | 
    {:dry_run, boolean}                  | 
    {:end_time, datetime}                | 
    [{:instance_id_1, [binary]}, ...]    |  
    [{:reason_code_1, reason_code}, ...] | 
    {:start_time, datetime}              | 
    {:status, :ok | :impaired}
  ]
  @doc """
  Submits feedback about the status of an instance. The instance must be in the 
  running state.
  """
  defcallback report_instance_status(instance_ids :: list(binary), status :: binary) :: ExAws.Request.response_t
  defcallback report_instance_status(instance_ids :: list(binary), status :: binary, opts :: report_instance_status_opts) :: ExAws.Request.response_t  

  @type monitor_instances_opts :: [
    {:dry_run, boolean} | 
    [{:instance_id_1, [binary]}, ...]
  ]
  @doc """
  Enables monitoring for a running instance.
  """
  defcallback monitor_instances(instance_ids :: list(binary)) :: ExAws.Request.response_t
  defcallback monitor_instances(instance_ids :: list(binary), opts :: monitor_instances_opts) :: ExAws.Request.response_t

  @type unmonitor_instances_opts :: [
    {:dry_run, boolean} |
    [{:instance_id_1, [binary]}, ...]
  ]
  @doc """
  Disables monitoring for a running instance. 
  """
  defcallback unmonitor_instances(instance_ids :: list(binary)) :: ExAws.Request.response_t
  defcallback unmonitor_instances(instance_ids :: list(binary), opts :: unmonitor_instances_opts) :: ExAws.Request.response_t    

  @type describe_instance_attribute_opts :: [
    {:attribte, attributes} | 
    {:dry_run, boolean}     | 
    {:intance_id, boolean}
  ]
  @doc """
  Describes the specified attribute of the specified instance. You can specify 
  only one attribute at a time.
  """
  defcallback describe_instance_attribute(instace_id :: binary, attribute :: binary) :: ExAws.Request.response_t
  defcallback describe_instance_attribute(instace_id :: binary, attribute :: binary, opts :: describe_instance_attribute_opts) :: ExAws.Request.response_t  

  @type modify_instance_attribute_opts :: [
    {:attribute, attributes}                                                        | 
    [{:block_device_mapping_1, [instance_block_device_mapping_specification]}, ...] |
    {:disable_api_termination, attribute_boolean_value}                             | 
    {:dry_run, boolean}                                                             | 
    {:ebs_optimized, attribute_boolean_value}                                       | 
    [{:group_id_1, [binary]}, ...]                                                  | 
    {:instance_initiated_shutdown_behavior, attribute_value}                        |
    {:kernel, attribute_value}                                                      | 
    {:ramdisk, attribute_value}                                                     | 
    {:source_dest_check, attribute_boolean_value}                                   | 
    {:sriov_net_support, attribute_value}                                           | 
    {:user_data, attribute_value}                                                   | 
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

  @type describe_availability_zones_filters :: message :: binary | region_name :: binary | state :: (:available | :information | :impaired | :unavailable) | zone_name :: binary

  @type describe_availability_zones_opts :: [
    {:dry_run, boolean}                                     | 
    [{:filter_1, describe_availability_zones_filters}, ...] | 
    [{:zone_name_1, [binary]}, ...]
  ]
  @doc """
  Describes one or more of the Availability Zones that are available to you. 
  The results include zones only for the region you're currently using.
  """
  defcallback describe_availability_zones() :: ExAws.Request.response_t
  defcallback describe_availability_zones(opts :: describe_availability_zones_opts) :: ExAws.Request.response_t  

  @type describe_regions_filters :: endpoint :: binary | region_name :: binary

  @type describe_regions_opts :: [
    {:dry_run, boolean}                          | 
    [{:filter_1, describe_regions_filters}, ...] |
    [{:region_name_1, [binary]}, ...]
  ]
  @doc """
  Describes one or more regions that are currently available to you.
  """
  defcallback describe_regions() :: ExAws.Request.response_t
  defcallback describe_regions(opts :: describe_regions_opts) :: ExAws.Request.response_t  

  @type create_image_opts :: [
    [{:block_device_mapping_1, block_device_mapping_list}, ...] | 
    {:description, binary}                                      | 
    {:dry_run, boolean}                                         | 
    {:no_reboot, boolean}
  ]
  @doc """
  Creates an Amazon EBS-backed AMI from an Amazon EBS-backed instance 
  that is either running or stopped.
  """
  defcallback create_image(instace_id :: binary, name :: binary) :: ExAws.Request.response_t
  defcallback create_image(instace_id :: binary, name :: binary, opts :: create_image_opts) :: ExAws.Request.response_t  

  @type copy_image_opts :: [
    {:client_token, binary} | 
    {:description, binary}  | 
    {:dry_run, boolean}     | 
    {:encrypted, boolean}   | 
    {:kms_key_id, binary}
  ]
  @doc """
  Initiates the copy of an AMI from the specified source region to the current 
  region. You specify the destination region by using its endpoint when 
  making the request.
  """
  defcallback copy_image(name :: binary, source_image_id :: binary, source_region :: binary) :: ExAws.Request.response_t  
  defcallback copy_image(name :: binary, source_image_id :: binary, source_region :: binary, opts :: copy_image_opts) :: ExAws.Request.response_t

  @type describe_images_filters :: 
    architecture :: (:i386 | :x86_64)                                           |
    block_device_mapping_delete_on_termination :: boolean                       | 
    block_device_mapping_device_name :: binary                                  | 
    block_device_mapping_snapshot_id :: binary                                  | 
    block_device_mapping_volume_size :: integer                                 | 
    block_device_mapping_volume_type :: (:gp2 | :io1 | :st1 | :sc1 | :standard) | 
    description :: binary                                                       | 
    hypervisor :: (:ovm | :xen)                                                 |
    image_id :: binary                                                          |
    image_type :: (:machine | :kernel | :ramdisk)                               | 
    is_public :: boolean                                                        | 
    kernel_id :: binary                                                         | 
    manifest_location :: binary                                                 | 
    name :: binary                                                              | 
    owner_alias :: binary                                                       | 
    platform :: (binary | :windows)                                             |
    product_code :: binary                                                      | 
    product_code_type :: (:devpay | :marketplace)                               | 
    ramdisk_id :: binary                                                        | 
    root_device_name :: binary                                                  | 
    root_device_type :: (:ebs | :instance_store)                                | 
    state :: (:available | :pending | :failed)                                  | 
    state_reason_code :: binary                                                 | 
    state_reason_message :: binary                                              | 
    tag :: tag_key <> tag_value                                                 | 
    tag_key :: binary                                                           | 
    tag_value :: binary                                                         |
    virtualization_type :: (:paravirtual | :hvm)

  @type describe_images_opts :: [
    {:dry_run, boolean}                         | 
    [{:executable_by_1, [binary]}, ...]         | 
    [{:filter_1, describe_images_filters}, ...] | 
    [{:image_id_1, [binary]}, ...]              |
    [{:owner_1, [binary]}, ...]
  ]
  @doc """
  Describes one or more of the images (AMIs, AKIs, and ARIs) available to you.
  """
  defcallback describe_images() :: ExAws.Request.response_t
  defcallback describe_images(opts :: describe_images_opts) :: ExAws.Request.response_t

  @type describe_image_attribute_opts :: [
    {:dry_run, boolean}
  ]
  @doc """
  Describes the specified attribute of the specified AMI. You can specify 
  only one attribute at a time.
  """
  defcallback describe_image_attribute(image_id :: binary, attribute :: binary) :: ExAws.Request.response_t
  defcallback describe_image_attribute(image_id :: binary, attribute :: binary, opts :: describe_image_attribute_opts) :: ExAws.Request.response_t

  @type modify_image_attribute_opts :: [
    {:attribute, binary}                                  | 
    {:description, attribute_value}                       | 
    {:dry_run, boolean}                                   | 
    {:launch_permission, launch_permission_modifications} | 
    {:operation_type, :add | :remove}                     |
    [{:product_code_1, :add | :remove}, ...]              |
    [{:user_group_1, [binary]}, ...]                      | 
    {:value, binary}
  ]
  @doc """
  Modifies the specified attribute of the specified AMI. You can specify only 
  one attribute at a time.
  """
  defcallback modify_image_attribute(image_id :: binary) :: ExAws.Request.response_t
  defcallback modify_image_attribute(image_id :: binary, opts :: modify_image_attribute_opts) :: ExAws.Request.response_t

  @type reset_image_attribute_opts :: [
    {:dry_run, boolean}
  ]
  @doc """
  Resets an attribute of an AMI to its default value.
  """
  defcallback reset_image_attribute(image_id :: binary, attribute :: binary) :: ExAws.Request.response_t
  defcallback reset_image_attribute(image_id :: binary, attribute :: binary, opts :: reset_image_attribute_opts) :: ExAws.Request.response_t  

  @type register_image_opts :: [
    {:architecture, :i386 | :x86_64}                            | 
    [{:block_device_mapping_1, block_device_mapping_list}, ...] | 
    {:description, binary}                                      | 
    {:dry_run, boolean}                                         | 
    {:image_location, binary}                                   | 
    {:kernel_id, binary}                                        | 
    {:ram_disk_id, binary}                                      | 
    {:root_device_name, binary}                                 | 
    {:sriov_net_support, binary}                                | 
    {:virtualization_type, binary}
  ]
  @doc """
  Registers an AMI. When you're creating an AMI, this is the final step you 
  must complete before you can launch an instance from the AMI.
  """
  defcallback register_image(name :: binary) :: ExAws.Request.response_t
  defcallback register_image(name :: binary, opts :: register_image_opts) :: ExAws.Request.response_t

  @type deregister_image_opts :: [
    {:dry_run, boolean}
  ]
  @doc """
  Deregisters the specified AMI. After you deregister an AMI, it can't be used 
  to launch new instances.
  """
  defcallback deregister_image(image_id :: binary) :: ExAws.Request.response_t
  defcallback deregister_image(image_id :: binary, opts :: deregister_image_opts) :: ExAws.Request.response_t

  @type describe_key_pairs_filters :: fingerprint :: binary | key_name :: binary

  @type describe_key_pairs_opts :: [
    {:dry_run, boolean}                            | 
    [{:filter_1, describe_key_pairs_filters}, ...] | 
    [{:key_name_1, [binary]}, ...]
  ]
  @doc """
  Describes one or more of your key pairs.
  """
  defcallback describe_key_pairs() :: ExAws.Request.response_t
  defcallback describe_key_pairs(opts :: describe_key_pairs_opts) :: ExAws.Request.response_t

  @type create_key_pair_opts :: [
    {:dry_run, boolean}
  ]
  @doc """
  Creates a 2048-bit RSA key pair with the specified name. Amazon EC2 stores 
  the public key and displays the private key for you to save to a file. 
  The private key is returned as an unencrypted PEM encoded PKCS#8 private key.
  """
  defcallback create_key_pair(key_name :: binary) :: ExAws.Request.response_t
  defcallback create_key_pair(key_name :: binary, opts :: create_key_pair_opts) :: ExAws.Request.response_t

  @type delete_key_pair_opts :: [
    {:dry_run, boolean}
  ]
  @doc """
  Deletes the specified key pair, by removing the public key from Amazon EC2.
  """
  defcallback delete_key_pair(key_name :: binary) :: ExAws.Request.response_t
  defcallback delete_key_pair(key_name :: binary, opts :: delete_key_pair_opts) :: ExAws.Request.response_t

  @type import_key_pair_opts :: [
    {:dry_run, boolean}
  ]  
  @doc """
  Imports the public key from an RSA key pair that you created with a 
  third-party tool. 
  """
  defcallback import_key_pair(key_name :: binary, public_key_material :: binary) :: ExAws.Request.response_t
  defcallback import_key_pair(key_name :: binary, public_key_material :: binary, opts :: import_key_pair_opts) :: ExAws.Request.response_t

  @type describe_id_format_opts :: [
    {:resource, binary}
  ]
  @doc """
  Describes the ID format settings for your resources on a per-region basis, 
  for example, to view which resource types are enabled for longer IDs.
  """
  defcallback describe_id_format() :: ExAws.Request.response_t
  defcallback describe_id_format(opts :: describe_id_format_opts) :: ExAws.Request.response_t

  @doc """
  Modifies the ID format for the specified resource on a per-region basis.
  """
  defcallback modify_id_format(resource :: binary, use_long_ids :: boolean) :: ExAws.Request.response_t

  @type describe_security_groups_filters :: 
    description :: binary                                     | 
    egress_ip_permission_prefix_list_id :: binary             | 
    group_id :: binary                                        | 
    group_name :: binary                                      | 
    ip_permission_cidr :: binary                              | 
    ip_permission_from_port :: pos_integer                    |
    ip_permission_group_id :: binary                          | 
    ip_permission_protocol :: (:tcp | :udp | :icmp | integer) | 
    ip_permission_to_port :: pos_integer                      | 
    ip_permission_user_id :: binary                           | 
    owner_id :: binary                                        | 
    tag_key :: binary                                         | 
    tag_value :: binary                                       | 
    vpc_id :: binary

  @type describe_security_groups_opts :: [
    {:dry_run, boolean}                                  |
    [{:filter_1, describe_security_groups_filters}, ...] | 
    [{:group_id_1, [binary]}, ...]                       |
    [{:group_name_1, [binary]}, ...]                      
  ]
  @doc """
  Describes one or more of your security groups.
  """
  defcallback describe_security_groups() :: ExAws.Request.response_t
  defcallback describe_security_groups(opts :: describe_security_groups_opts) :: ExAws.Request.response_t

  @type create_security_group_opts :: [
    {:dry_run, boolean} | 
    {:vpc_id, binary}
  ]
  @doc """
  Creates a security group.
  """
  defcallback create_security_group(group_name :: binary, group_description :: binary) :: ExAws.Request.response_t
  defcallback create_security_group(group_name :: binary, group_description :: binary, opts :: create_security_group_opts) :: ExAws.Request.response_t

  @type authorize_security_group_ingress_opts :: [
    {:cidr_ip, binary}                          | 
    {:dry_run, boolean}                         |  
    {:from_port, integer}                       |  
    {:group_id, binary}                         | 
    {:group_name, binary}                       | 
    [{:ip_permissions_1, [ip_permission]}, ...] | 
    {:ip_protocol, binary}                      | 
    {:source_security_group_name, binary}       | 
    {:source_security_group_owner_id, binary}   | 
    {:to_port, integer}
  ]
  @doc """
  Adds one or more ingress rules to a security group.
  """
  defcallback authorize_security_group_ingress() :: ExAws.Request.response_t
  defcallback authorize_security_group_ingress(opts :: authorize_security_group_ingress_opts) :: ExAws.Request.response_t

  @type authorize_security_group_egress_opts :: [
    {:cidr_ip, binary}                          | 
    {:dry_run, boolean}                         |  
    {:from_port, integer}                       |  
    {:group_id, binary}                         | 
    {:group_name, binary}                       | 
    [{:ip_permissions_1, [ip_permission]}, ...] | 
    {:ip_protocol, binary}                      | 
    {:source_security_group_name, binary}       | 
    {:source_security_group_owner_id, binary}   | 
    {:to_port, integer}
  ]
  @doc """
  Adds one or more egress rules to a security group for use with a VPC. 
  """
  defcallback authorize_security_group_egress(group_id :: binary) :: ExAws.Request.response_t
  defcallback authorize_security_group_egress(group_id :: binary, opts :: authorize_security_group_egress_opts) :: ExAws.Request.response_t

  @type revoke_security_group_ingress_opts :: [
    {:cidr_ip, binary}                          | 
    {:dry_run, boolean}                         |  
    {:from_port, integer}                       |  
    {:group_id, binary}                         | 
    {:group_name, binary}                       | 
    [{:ip_permissions_1, [ip_permission]}, ...] | 
    {:ip_protocol, binary}                      | 
    {:source_security_group_name, binary}       | 
    {:source_security_group_owner_id, binary}   | 
    {:to_port, integer}
  ]  
  @doc """
  Removes one or more ingress rules from a security group. The values that 
  you specify in the revoke request (for example, ports) must match 
  the existing rule's values for the rule to be removed.
  """
  defcallback revoke_security_group_ingress() :: ExAws.Request.response_t
  defcallback revoke_security_group_ingress(opts :: revoke_security_group_ingress_opts) :: ExAws.Request.response_t

  @type revoke_security_group_egress_opts :: [
    {:cidr_ip, binary}                          | 
    {:dry_run, boolean}                         |  
    {:from_port, integer}                       |  
    {:group_id, binary}                         | 
    {:group_name, binary}                       | 
    [{:ip_permissions_1, [ip_permission]}, ...] | 
    {:ip_protocol, binary}                      | 
    {:source_security_group_name, binary}       | 
    {:source_security_group_owner_id, binary}   | 
    {:to_port, integer}
  ]    
  @doc """
  Removes one or more egress rules from a security group for EC2-VPC.
  """
  defcallback revoke_security_group_egress(group_id :: binary) :: ExAws.Request.response_t
  defcallback revoke_security_group_egress(group_id :: binary, opts :: revoke_security_group_egress_opts) :: ExAws.Request.response_t

  @type describe_vpcs_filters :: 
    cidr            :: binary                  | 
    dhcp_options_id :: binary                  | 
    is_default      :: binary                  | 
    state           :: (:pending | :available) | 
    tag             :: tag_key <> tag_value    | 
    tag_key         :: binary                  |
    tag_value       :: binary                  | 
    vpc_id          :: binary

  @type describe_vpcs_opts :: [
    {:dry_run, boolean}                       | 
    [{:filter_1, describe_vpcs_filters}, ...] | 
    [{:vpc_id_1, [binary]}, ...]
  ]
  @doc """
  Describes one or more of your VPCs.
  """
  defcallback describe_vpcs() :: ExAws.Request.response_t
  defcallback describe_vpcs(opts :: describe_vpcs_opts) :: ExAws.Request.response_t

  @type create_vpc_opts :: [
    {:dry_run, boolean} | 
    {:instance_tenancy, :default | :dedicated | :host}
  ]
  @doc """
  Creates a VPC with the specified CIDR block.
  """
  defcallback create_vpc(cidr_block :: binary) :: ExAws.Request.response_t
  defcallback create_vpc(cidr_block :: binary, opts :: create_vpc_opts) :: ExAws.Request.response_t

  @type delete_vpc_opts :: [
    {:dry_run, boolean}
  ]
  @doc """
  Deletes the specified VPC.
  """
  defcallback delete_vpc(vpc_id :: binary) :: ExAws.Request.response_t
  defcallback delete_vpc(vpc_id :: binary, opts :: delete_vpc_opts) :: ExAws.Request.response_t

  @type describe_vpc_attribute_opts :: [
    {:dry_run, boolean}
  ]
  @doc """
  Describes the specified attribute of the specified VPC. You can specify only one attribute at a time.
  """
  defcallback describe_vpc_attribute(vpc_id :: binary, attribute :: binary) :: ExAws.Request.response_t
  defcallback describe_vpc_attribute(vpc_id :: binary, attribute :: binary, opts :: describe_vpc_attribute_opts) :: ExAws.Request.response_t

  @type modify_vpc_attribute_opts :: [
    {:enable_dns_hostnames, attribute_boolean_value} | 
    {:enable_dns_support, attribute_boolean_value}
  ]
  @doc """
  Modifies the specified attribute of the specified VPC.
  """
  defcallback modify_vpc_attribute(vpc_id :: binary) :: ExAws.Request.response_t
  defcallback modify_vpc_attribute(vpc_id :: binary, opts :: modify_vpc_attribute_opts) :: ExAws.Request.response_t

  @type describe_subnets_filters :: 
    availability_zone          :: binary                  | 
    available_ip_address_count :: integer                 | 
    cidr_block                 :: binary                  | 
    default_for_az             :: boolean                 | 
    state                      :: (:pending | :available) | 
    subnet_id                  :: binary                  | 
    tag                        :: tag_key <> tag_value    | 
    tag_key                    :: binary                  | 
    tag_value                  :: binary                  |    
    vpc_id                     :: binary

  @type describe_subnets_opts :: [
    {:dry_run, boolean}                          | 
    [{:filter_1, describe_subnets_filters}, ...] |
    [{:subnet_id_1, [binary]}, ...]
  ]
  @doc """
  Describes one or more of your subnets.
  """
  defcallback describe_subnets() :: ExAws.Request.response_t
  defcallback describe_subnets(opts :: describe_subnets_opts) :: ExAws.Request.response_t
 
  @type create_subnet_opts :: [
    {:availability_zone, binary} | 
    {:dry_run, boolean}
  ]
  @doc """
  Creates a subnet in an existing VPC.
  """
  defcallback create_subnet(vpc_id :: binary, cidr_block :: binary) :: ExAws.Request.response_t
  defcallback create_subnet(vpc_id :: binary, cidr_block :: binary, opts :: create_subnet_opts) :: ExAws.Request.response_t

  @type delete_subnet_opts :: [
    {:dry_run, boolean}
  ]
  @doc """
  Deletes the specified subnet.
  """
  defcallback delete_subnet(subnet_id :: binary) :: ExAws.Request.response_t
  defcallback delete_subnet(subnet_id :: binary, opts :: delete_subnet_opts) :: ExAws.Request.response_t

  @type modify_subnet_attribute_opts :: [
    {:map_public_ip_on_launch, attribute_boolean_value}
  ]
  @doc """
  Modifies a subnet attribute.
  """
  defcallback modify_subnet_attribute(subnet_id :: binary) :: ExAws.Request.response_t
  defcallback modify_subnet_attribute(subnet_id :: binary, opts :: modify_subnet_attribute_opts) :: ExAws.Request.response_t

  @type resource_types :: 
    :customer_gateway      | 
    :dhcp_options          | 
    :image                 | 
    :instance              |
    :internet_gateway      | 
    :network_acl           |
    :network_interface     | 
    :reserved_instance     |
    :route_table           | 
    :security_group        | 
    :snapshot              | 
    :spot_instance_request | 
    :subnet                |
    :volume                | 
    :vpc                   | 
    :vpn_connection        | 
    :vpn_gateway

  @type describe_tags_filters :: 
    key           :: binary         | 
    resource_id   :: binary         | 
    resource_type :: resource_types | 
    value         :: binary

  @type describe_tags_opts :: [
    {:dry_run, boolean}                       | 
    [{:filter_1, describe_tags_filters}, ...] | 
    {:max_results, integer}                   |  
    {:next_token, binary}
  ]
  @doc """
  Describes one or more of the tags for your EC2 resources.
  """
  defcallback describe_tags() :: ExAws.Request.response_t
  defcallback describe_tags(opts :: describe_tags_opts) :: ExAws.Request.response_t

  @type create_tags_opts :: [
    {:dry_run, boolean}
  ]
  @doc """
  Adds or overwrites one or more tags for the specified Amazon EC2 resource or 
  resources. Each resource can have a maximum of 10 tags. Each tag consists of 
  a key and optional value. Tag keys must be unique per resource.
  """
  defcallback create_tags(resource_ids :: list(binary), tags :: tag) :: ExAws.Request.response_t
  defcallback create_tags(resource_ids :: list(binary), tags :: tag, opts :: create_tags_opts) :: ExAws.Request.response_t

  @type delete_tags_opts :: [
    {:dry_run, boolean} | 
    {:tags, [{:tag_1, tag}, ...]}
  ]
  @doc """
  Deletes the specified set of tags from the specified set of resources.
  """
  defcallback delete_tags(resource_ids :: list(binary)) :: ExAws.Request.response_t
  defcallback delete_tags(resource_ids :: list(binary), opts :: delete_tags_opts) :: ExAws.Request.response_t

  @type describe_volumes_filters ::
    attachment_attach_time           :: binary                                                            | 
    attachment_delete_on_termination :: boolean                                                           | 
    attachment_device                :: binary                                                            | 
    attacment_instance_id            :: binary                                                            | 
    attacment_status                 :: (:attaching | :attached | :detaching | :detached)                 | 
    availability_zone                :: binary                                                            | 
    create_time                      :: binary                                                            | 
    encrypted                        :: boolean                                                           | 
    size                             :: pos_integer                                                       | 
    snapshot_id                      :: binary                                                            |
    status                           :: (:created | :available | :in_use | :deleting | :deleted | :error) | 
    tag                              :: tag_key <> tag_value                                              | 
    tag_key                          :: binary                                                            |
    tag_value                        :: binary                                                            | 
    volume_id                        :: binary                                                            |
    volume_type                      :: (:gp2 | :io1 | :st1 | :sc1 | :standard)

  @type describe_volumes_opts :: [
    {:dry_run, boolean}                          | 
    [{:filter_1, describe_volumes_filters}, ...] | 
    {:max_results, integer}                      | 
    {:next_token, binary}                        | 
    [{:volume_id_1, [binary]}, ...]  
  ]
  @doc """
  Describes the specified EBS volumes.
  """
  defcallback describe_volumes() :: ExAws.Request.response_t
  defcallback describe_volumes(opts :: describe_volumes_opts) :: ExAws.Request.response_t

  @type create_volume_opts :: [
    {:dry_run, boolean}    | 
    {:encrypted, boolean}  | 
    {:iops, 100..20000}    | 
    {:kms_key_id, binary}  | 
    {:snapshot_id, binary} | 
    {:volume_type, :standard | :op1 | :gp2 | :sc1 | :st1}
  ]
  @doc """
  Creates an EBS volume that can be attached to an instance in the same 
  Availability Zone. The volume is created in the regional endpoint that you 
  send the HTTP request to. 
  """
  defcallback create_volume(availability_zone :: binary, size :: available_size_ranges) :: ExAws.Request.response_t
  defcallback create_volume(availability_zone :: binary, size :: available_size_ranges, opts :: create_volume_opts) :: ExAws.Request.response_t

  @type delete_volume_opts :: [
    {:dry_run, boolean}
  ]
  @doc """
  Deletes the specified EBS volume. The volume must be in the available state 
  (not attached to an instance).
  """
  defcallback delete_volume(volume_id :: binary) :: ExAws.Request.response_t
  defcallback delete_volume(volume_id :: binary, opts :: delete_volume_opts) :: ExAws.Request.response_t

  @type attach_volume_opts :: [
    {:dry_run, boolean}
  ]
  @doc """
  Attaches an EBS volume to a running or stopped instance and exposes it to 
  the instance with the specified device name.
  """
  defcallback attach_volume(instace_id :: binary, volume_id :: binary, device :: binary) :: ExAws.Request.response_t
  defcallback attach_volume(instace_id :: binary, volume_id :: binary, device :: binary, opts :: attach_volume_opts) :: ExAws.Request.response_t

  @type detach_volume_opts :: [
    {:dry_run, boolean} | 
    {:device, binary}   | 
    {:force, boolean}   | 
    {:instance_id, binary}
  ]
  @doc """
  Detaches an EBS volume from an instance. 
  """
  defcallback detach_volume(volume_id :: binary) :: ExAws.Request.response_t
  defcallback detach_volume(volume_id :: binary, opts :: detach_volume_opts) :: ExAws.Request.response_t

  @type describe_volume_attribute_opts :: [
    {:attribute, :auto_enable_io | :product_codes} | 
    {:dry_run, boolean}
  ]
  @doc """
  Describes the specified attribute of the specified volume. You can specify 
  only one attribute at a time.
  """
  defcallback describe_volume_attribute(volume_id :: binary) :: ExAws.Request.response_t
  defcallback describe_volume_attribute(volume_id :: binary, opts :: describe_volume_attribute_opts) :: ExAws.Request.response_t

  @type modify_volume_attribute_opts :: [
    {:auto_enable_io, attribute_boolean_value} | 
    {:dry_run, boolean}
  ]
  @doc """
  Modifies a volume attribute.
  """
  defcallback modify_volume_attribute(volume_id :: binary) :: ExAws.Request.response_t
  defcallback modify_volume_attribute(volume_id :: binary, opts :: modify_volume_attribute_opts) :: ExAws.Request.response_t

  @type enable_volume_io_opts :: [
    {:dry_run, boolean}
  ]
  @doc """
  Enables I/O operations for a volume that had I/O operations disabled because 
  the data on the volume was potentially inconsistent.
  """
  defcallback enable_volume_io(volume_id :: binary) :: ExAws.Request.response_t
  defcallback enable_volume_io(volume_id :: binary, opts :: enable_volume_io_opts) :: ExAws.Request.response_t

  @type describe_volume_status_filters ::
    action_code                  :: binary | 
    action_description           :: binary |
    action_event_id              :: binary | 
    availability_zone            :: binary | 
    event_description            :: binary | 
    event_event_id               :: binary | 
    event_event_type             :: binary | 
    event_not_after              :: binary | 
    event_not_before             :: binary | 
    volume_status_details_name   :: binary |
    volume_status_details_status :: binary |
    volume_status_status         :: binary

  @type describe_volume_status_opts :: [
    {:dry_run, boolean}                                 | 
    [{:filter_1, describe_volume_status_filters}, ...] | 
    {:max_results, integer}                             | 
    {:next_token, binary}                               | 
    [{:volume_id_1, [binary]}, ...]
  ]
  @doc """
  Describes the status of the specified volumes.
  """
  defcallback describe_volume_status() :: ExAws.Request.response_t
  defcallback describe_volume_status(opts :: describe_volume_status_opts) :: ExAws.Request.response_t

  @type describe_snapshots_filters ::
    description :: binary                           | 
    owner_alias :: binary                           |   
    owner_id    :: binary                           | 
    progress    :: binary                           | 
    snapshot_id :: binary                           |
    start_time  :: binary                           | 
    status      :: (:pending | :completed | :error) | 
    tag         :: tag_key <> tag_value             | 
    tag_key     :: binary                           | 
    tag_value   :: binary                           | 
    volume_id   :: binary                           | 
    volume_size :: pos_integer

  @type describe_snapshots_opts :: [
    {:dry_run, boolean}                            | 
    [{:filter_1, describe_snapshots_filters}, ...] |
    {:max_results, integer}                        | 
    {:next_token, binary}                          | 
    [{:owner_1, [binary]}, ...]                    | 
    [{:restorable_by_1, [binary]}, ...]            |
    [{:snapshot_id_1, [binary]}, ...]
  ]
  @doc """
  Describes one or more of the EBS snapshots available to you.
  """
  defcallback describe_snapshots() :: ExAws.Request.response_t
  defcallback describe_snapshots(opts :: describe_snapshots_opts) :: ExAws.Request.response_t

  @type create_snapshot_opts :: [
    {:description, binary} | 
    {:dry_run, boolean}
  ]
  @doc """
  Creates a snapshot of an EBS volume and stores it in Amazon S3. 
  You can use snapshots for backups, to make copies of EBS volumes, and to 
  save data before shutting down an instance.
  """
  defcallback create_snapshot(volume_id :: binary) :: ExAws.Request.response_t
  defcallback create_snapshot(volume_id :: binary, opts :: create_snapshot_opts) :: ExAws.Request.response_t

  @type copy_snapshot_opts :: [
    {:description, :binary}       | 
    {:destination_region, binary} | 
    {:dry_run, boolean}           | 
    {:encrypted, boolean}         | 
    {:kms_key_id, binary}         | 
    {:presigned_url, binary}
  ]
  @doc """
  Copies a point-in-time snapshot of an EBS volume and stores it in Amazon S3. 
  You can copy the snapshot within the same region or from one region to 
  another.
  """
  defcallback copy_snapshot(source_snapshot_id :: binary, source_region :: binary) :: ExAws.Request.response_t
  defcallback copy_snapshot(source_snapshot_id :: binary, source_region :: binary, opts :: copy_snapshot_opts) :: ExAws.Request.response_t

  @type delete_snapshot_opts :: [
    {:dry_run, boolean} | 
    {:snapshot_id}
  ]
  @doc """
  Deletes the specified snapshot.
  """
  defcallback delete_snapshot(snapshot_id :: binary) :: ExAws.Request.response_t
  defcallback delete_snapshot(snapshot_id :: binary, opts :: delete_snapshot_opts) :: ExAws.Request.response_t

  @type describe_snapshot_attribute_opts :: [
    {:dry_run, boolean}
  ]
  @doc """
  Describes the specified attribute of the specified snapshot. You can specify 
  only one attribute at a time.
  """
  defcallback describe_snapshot_attribute(snapshot_id :: binary, attribute :: binary) :: ExAws.Request.response_t
  defcallback describe_snapshot_attribute(snapshot_id :: binary, attribute :: binary, opts :: describe_snapshot_attribute_opts) :: ExAws.Request.response_t

  @type modify_snapshot_attribute_opts :: [
    {:attribute, :product_codes | :create_volume_permission}            | 
    {:create_volume_permission, create_volume_permission_modifications} | 
    {:dry_run, boolean}                                                 | 
    [{:user_group_1, [binary]}, ...]                                    | 
    {:operation_type, :add | :remove}                                   |
    [{:user_id_1, [binary]}, ...]
  ]
  @doc """
  Adds or removes permission settings for the specified snapshot.
  """
  defcallback modify_snapshot_attribute(snapshot_id :: binary) :: ExAws.Request.response_t
  defcallback modify_snapshot_attribute(snapshot_id :: binary, opts :: modify_snapshot_attribute_opts) :: ExAws.Request.response_t

  @type reset_snapshot_attribute_opts :: [
    {:dry_run, boolean}
  ]
  @doc """
  Resets permission settings for the specified snapshot.
  """
  defcallback reset_snapshot_attribute(snapshot_id :: binary, attribute :: binary) :: ExAws.Request.response_t
  defcallback reset_snapshot_attribute(snapshot_id :: binary, attribute :: binary, opts :: reset_snapshot_attribute_opts) :: ExAws.Request.response_t

  @type describe_account_attributes_opts :: [
    [{:attributes_name_1, [(:supported_platforms | :default_vpc)]}, ...] |
    {:dry_run, boolean}
  ]
  @doc """
  Describes attributes of your AWS account.
  """
  defcallback describe_account_attributes() :: ExAws.Request.response_t
  defcallback describe_account_attributes(opts :: describe_account_attributes_opts) :: ExAws.Request.response_t

  @type bundle_instance_opts :: [
    {:dry_run, boolean}
  ]
  @doc """
  Bundles an Amazon instance store-backed Windows instance.
  During bundling, only the root device volume (C:\) is bundled. Data on other 
  instance store volumes is not preserved.
  """
  defcallback bundle_instance(instance_id :: binary, s3_storage) :: ExAws.Request.response_t
  defcallback bundle_instance(instance_id :: binary, s3_storage, opts :: bundle_instance_opts) :: ExAws.Request.response_t

  @type cancel_bundle_task_opts :: [
    {:dry_run, boolean}
  ]
  @doc """
  Cancels a bundling operation for an instance store-backed Windows instance.
  """
  defcallback cancel_bundle_task(bundle_id :: binary) :: ExAws.Request.response_t
  defcallback cancel_bundle_task(bundle_id :: binary, opts :: cancel_bundle_task_opts) :: ExAws.Request.response_t

  @type describe_bundle_tasks_opts :: [
    #{:bundle_id_n, } |
    {:dry_run, boolean}# |
    #{:filter_n}
  ]
  @doc """
  Describes one or more of your bundling tasks.
  """
  defcallback describe_bundle_tasks() :: ExAws.Request.response_t
  defcallback describe_bundle_tasks(opts :: describe_bundle_tasks_opts) :: ExAws.Request.response_t

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