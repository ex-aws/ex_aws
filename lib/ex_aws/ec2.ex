defmodule ExAws.EC2 do
  @moduledoc """
  Operations on AWS EC2

  ## Basic Operations

  A selection of the most common operations from the EC2 API are implemented here.
  http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_Operations.html

  ### Filters

  Many of the `Describe` endpoints allow you to filter based on a number of attributes.
  Refer to the AWS documentation for the specified method for the acceptable filter values.

  When supplying atoms, underscores will be converted to a dash for compatibility
  with the API parameters.

  ### Examples
  ```elixir
  ExAws.EC2.create_vpc("10.0.0.0/16")
  ExAws.EC2.describe_instances(filters: [image_id: "ami-1ecae776"])
  ExAws.EC2.describe_instances(filters: ["network-interface.availability-zone": "us-east-1a"])
  ExAws.EC2.describe_instances(filters: ["tag:elasticbeanstalk:environment-name": "demo"])
  ExAws.EC2.describe_instance_status(instance_id: ["i-e5974f4c"])
  ```
  """

  import ExAws.Utils

  @version "2015-10-01"

  ########################
  ### Instance Actions ###
  ########################

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

  @type filter :: {name :: binary | atom, value :: [binary | atom] | binary | atom}

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
    device_name  :: binary,
    ebs          :: ebs_instance_block_device_specification,
    no_device    :: binary,
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
    {:dry_run, boolean}                        |
    {:filters, [filter]}                       |
    {:instance_id, [binary]}                     |
    {:max_results, integer}                    |
    {:next_token, binary}
  ]
  @doc """
  Describes one or more of your instances.
  """
  @spec describe_instances() :: ExAws.Operation.RestQuery.t
  @spec describe_instances(opts :: describe_instances_opts) :: ExAws.Operation.RestQuery.t
  def describe_instances(opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeInstances",
      "Version" => @version
      })

    request(:get, "/", query_params)
  end

  @type event_codes :: :instance_reboot | :system_reboot | :system_maintenance | :instance_retirement | :instance_stop

  @type instance_state_names :: :pending | :running | :shutting_down | :terminated | :stopping | :stopped

  @type describe_instance_status_opts :: [
    {:dry_run, boolean}                                  |
    {:filters, [filter]}                                 |
    {:instance_id, [binary]}                               |
    {:include_all_instances, boolean}                    |
    {:max_results, integer}                              |
    {:next_token, binary}
  ]
  @doc """
  Describes the status of one or more instances. By default, only running
  instances are described, unless specified otherwise.
  """
  @spec describe_instance_status() :: ExAws.Operation.RestQuery.t
  @spec describe_instance_status(opts :: describe_instance_status_opts) :: ExAws.Operation.RestQuery.t
  def describe_instance_status(opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeInstanceStatus",
      "Version" => @version
      })

    request(:get, "/", query_params)
  end

  @type run_instances_opts :: [
    {:additional_info, binary}                                                |
    {:block_device_mapping, block_device_mapping_list}                        |
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
    {:network_interface, [instance_network_interface_specification]}          |
    {:placement, placement}                                                   |
    {:private_ip_address, binary}                                             |
    {:ram_disk_id, binary}                                                    |
    {:security_group_id, [binary]}                                            |
    {:security_group, [binary]}                                               |
    {:user_data, binary}
  ]
  @doc """
  Launches the speficied number of instance using an AMI.
  """
  @spec run_instances(image_id :: binary, max :: pos_integer, min :: pos_integer) :: ExAws.Operation.RestQuery.t
  @spec run_instances(image_id :: binary, max :: pos_integer, min :: pos_integer, opts :: run_instances_opts) :: ExAws.Operation.RestQuery.t
  def run_instances(image_id, max, min, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"   => "RunInstances",
      "Version"  => @version,
      "ImageId"  => image_id,
      "MaxCount" => max,
      "MinCount" => min
      })

    request(:post, "/", query_params)
  end

  @type start_instances_opts :: [
    {:additional_info, binary} |
    {:dry_run, boolean}
  ]
  @doc """
  Starts an Amazon EBS-backed AMI that was previously stopped.
  """
  @spec start_instances(instance_ids :: list(binary)) :: ExAws.Operation.RestQuery.t
  @spec start_instances(instance_ids :: list(binary), opts :: start_instances_opts) :: ExAws.Operation.RestQuery.t
  def start_instances(instance_ids, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "StartInstances",
      "Version" => @version,
      })
    |> Map.merge(list_builder(instance_ids, "InstanceId", 1, %{}))

    request(:post, "/", query_params)
  end

  @type stop_instances_opts :: [
    {:dry_run, boolean} |
    {:force, boolean}
  ]
  @doc """
  Stops an Amazon EBS-backed AMI that was previously started.
  """
  @spec stop_instances(instance_ids :: list(binary)) :: ExAws.Operation.RestQuery.t
  @spec stop_instances(instance_ids :: list(binary), opts :: stop_instances_opts) :: ExAws.Operation.RestQuery.t
  def stop_instances(instance_ids, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "StopInstances",
      "Version" => @version
      })
    |> Map.merge(list_builder(instance_ids, "InstanceId", 1, %{}))

    request(:post, "/", query_params)
  end

  @type terminate_instances_opts :: [
    {:dry_run, boolean}
  ]
  @doc """
  Shuts down one or more instances. Terminated instances remain visible after
  termination (for approximately one hour).
  """
  @spec terminate_instances(instance_ids :: list(binary)) :: ExAws.Operation.RestQuery.t
  @spec terminate_instances(instance_ids :: list(binary), opts :: terminate_instances_opts) :: ExAws.Operation.RestQuery.t
  def terminate_instances(instance_ids, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "TerminateInstances",
      "Version" => @version
      })
    |> Map.merge(list_builder(instance_ids, "InstanceId", 1, %{}))

    request(:post, "/", query_params)
  end

  @type reboot_instances_opts :: [
    {:dry_run, boolean}
  ]
  @doc """
  Requests a reboot of one or more instances. This operation is asynchronous; it
  only queues a request to reboot the specified instances.
  """
  @spec reboot_instances(instance_ids :: list(binary)) :: ExAws.Operation.RestQuery.t
  @spec reboot_instances(instance_ids :: list(binary), opts :: reboot_instances_opts) :: ExAws.Operation.RestQuery.t
  def reboot_instances(instance_ids, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "RebootInstances",
      "Version" => @version
      })
    |> Map.merge(list_builder(instance_ids, "InstanceId", 1, %{}))

    request(:post, "/", query_params)
  end

  @type reason_code :: :instance_stuck_in_state | :unresponsive | :not_accepting_credentials | :password_not_available | :performance_network | :performance_instance_store | :perforamce_ebs_volume | :performance_other | :other

  @type report_instance_status_opts :: [
    {:description, binary}               |
    {:dry_run, boolean}                  |
    {:end_time, datetime}                |
    {:reason_code, reason_code}          |
    {:start_time, datetime}              |
    {:status, :ok | :impaired}
  ]
  @doc """
  Submits feedback about the status of an instance. The instance must be in the
  running state.
  """
  @spec report_instance_status(instance_ids :: list(binary), status :: binary) :: ExAws.Operation.RestQuery.t
  @spec report_instance_status(instance_ids :: list(binary), status :: binary, opts :: report_instance_status_opts) :: ExAws.Operation.RestQuery.t
  def report_instance_status(instance_ids, status, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "ReportInstanceStatus",
      "Version" => @version,
      "Status"  => status
      })
    |> Map.merge(list_builder(instance_ids, "InstanceId", 1, %{}))

    request(:get, "/", query_params)
  end

  @type monitor_instances_opts :: [
    {:dry_run, boolean}
  ]
  @doc """
  Enables monitoring for a running instance.
  """
  @spec monitor_instances(instance_ids :: list(binary)) :: ExAws.Operation.RestQuery.t
  @spec monitor_instances(instance_ids :: list(binary), opts :: monitor_instances_opts) :: ExAws.Operation.RestQuery.t
  def monitor_instances(instance_ids, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "MonitorInstances",
      "Version" => @version
      })
    |> Map.merge(list_builder(instance_ids, "InstanceId", 1, %{}))

    request(:post, "/", query_params)
  end

  @type unmonitor_instances_opts :: [
    {:dry_run, boolean}
  ]
  @doc """
  Disables monitoring for a running instance.
  """
  @spec unmonitor_instances(instance_ids :: list(binary)) :: ExAws.Operation.RestQuery.t
  @spec unmonitor_instances(instance_ids :: list(binary), opts :: unmonitor_instances_opts) :: ExAws.Operation.RestQuery.t
  def unmonitor_instances(instance_ids, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "UnmonitorInstances",
      "Version" => @version
      })
    |> Map.merge(list_builder(instance_ids, "InstanceId", 1, %{}))

    request(:post, "/", query_params)
  end

  @type describe_instance_attribute_opts :: [
    {:attribte, attributes} |
    {:dry_run, boolean}     |
    {:intance_id, boolean}
  ]
  @doc """
  Describes the specified attribute of the specified instance. You can specify
  only one attribute at a time.
  """
  @spec describe_instance_attribute(instance_id :: binary, attribute :: binary) :: ExAws.Operation.RestQuery.t
  @spec describe_instance_attribute(instance_id :: binary, attribute :: binary, opts :: describe_instance_attribute_opts) :: ExAws.Operation.RestQuery.t
  def describe_instance_attribute(instance_id, attribute, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"     => "DescribeInstanceAttribute",
      "Version"    => @version,
      "InstanceId" => instance_id,
      "Attribute"  => attribute
      })

    request(:get, "/", query_params)
  end

  @type modify_instance_attribute_opts :: [
    {:attribute, attributes}                                                        |
    {:block_device_mapping, [instance_block_device_mapping_specification]}          |
    {:disable_api_termination, attribute_boolean_value}                             |
    {:dry_run, boolean}                                                             |
    {:ebs_optimized, attribute_boolean_value}                                       |
    {:group_id, [binary]}                                                           |
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
  @spec modify_instance_attribute(instance_id :: binary) :: ExAws.Operation.RestQuery.t
  @spec modify_instance_attribute(instance_id :: binary, opts :: modify_instance_attribute_opts) :: ExAws.Operation.RestQuery.t
  def modify_instance_attribute(instance_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"     => "ModifyInstanceAttribute",
      "Version"    => @version,
      "InstanceId" => instance_id,
      })

    request(:post, "/", query_params)
  end

  @type reset_instance_attribute_opts :: [
    {:dry_run, boolean}
  ]
  @doc """
  Resets an attribute of an instance to its default value. To reset the kernel
  or ramdisk, the instance must be in a stopped state. To reset the
  SourceDestCheck, the instance can be either running or stopped.
  """
  @spec reset_instance_attribute(instance_id :: binary, attribute :: binary) :: ExAws.Operation.RestQuery.t
  @spec reset_instance_attribute(instance_id :: binary, attribute :: binary, opts :: reset_instance_attribute_opts) :: ExAws.Operation.RestQuery.t
  def reset_instance_attribute(instance_id, attribute, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"     => "ResetInstanceAttribute",
      "Version"    => @version,
      "InstanceId" => instance_id,
      "Attribute"  => attribute
      })

    request(:post, "/", query_params)
  end

  @type get_console_output_opts :: [
    {:dry_run, boolean}
  ]
  @doc """
  Gets the console output for the specified instance.
  """
  @spec get_console_output(instance_id :: binary) :: ExAws.Operation.RestQuery.t
  @spec get_console_output(instance_id :: binary, opts :: get_console_output_opts) :: ExAws.Operation.RestQuery.t
  def get_console_output(instance_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"     => "GetConsoleOutput",
      "Version"    => @version,
      "InstanceId" => instance_id
      })

    request(:get, "/", query_params)
  end

  @type get_password_data_opts :: [
    {:dry_run, boolean}
  ]
  @doc """
  Retrieves the encrypted administrator password for an instance running
  Windows.
  """
  @spec get_password_data(instance_id :: binary) :: ExAws.Operation.RestQuery.t
  @spec get_password_data(instance_id :: binary, opts :: get_password_data_opts) :: ExAws.Operation.RestQuery.t
  def get_password_data(instance_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"     => "GetPasswordData",
      "Version"    => @version,
      "InstanceId" => instance_id
      })

    request(:get, "/", query_params)
  end

  ##############################################
  ### Regions and Availability Zones Actions ###
  ##############################################

  @type availability_zone_states :: :available | :information | :impaired | :unavailable

  @type describe_availability_zones_opts :: [
    {:dry_run, boolean}           |
    {:filters, [filter]}          |
    {:zone_name, [binary]}
  ]
  @doc """
  Describes one or more of the Availability Zones that are available to you.
  The results include zones only for the region you're currently using.
  """
  @spec describe_availability_zones() :: ExAws.Operation.RestQuery.t
  @spec describe_availability_zones(opts :: describe_availability_zones_opts) :: ExAws.Operation.RestQuery.t
  def describe_availability_zones(opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeAvailabilityZones",
      "Version" => @version
      })

    request(:get, "/", query_params)
  end

  @type describe_regions_opts :: [
    {:dry_run, boolean}           |
    {:filters, [filter]}          |
    {:region_name, [binary]}
  ]
  @doc """
  Describes one or more regions that are currently available to you.
  """
  @spec describe_regions() :: ExAws.Operation.RestQuery.t
  @spec describe_regions(opts :: describe_regions_opts) :: ExAws.Operation.RestQuery.t
  def describe_regions(opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeRegions",
      "Version" => @version
      })

    request(:get, "/", query_params)
  end

  ###################
  ### AMI Actions ###
  ###################

  @type create_image_opts :: [
    {:block_device_mapping, block_device_mapping_list}          |
    {:description, binary}                                      |
    {:dry_run, boolean}                                         |
    {:no_reboot, boolean}
  ]
  @doc """
  Creates an Amazon EBS-backed AMI from an Amazon EBS-backed instance
  that is either running or stopped.
  """
  @spec create_image(instance_id :: binary, name :: binary) :: ExAws.Operation.RestQuery.t
  @spec create_image(instance_id :: binary, name :: binary, opts :: create_image_opts) :: ExAws.Operation.RestQuery.t
  def create_image(instance_id, name, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"     => "CreateImage",
      "Version"    => @version,
      "InstanceId" => instance_id,
      "Name"       => name
      })

    request(:post, "/", query_params)
  end

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
  @spec copy_image(name :: binary, source_image_id :: binary, source_region :: binary) :: ExAws.Operation.RestQuery.t
  @spec copy_image(name :: binary, source_image_id :: binary, source_region :: binary, opts :: copy_image_opts) :: ExAws.Operation.RestQuery.t
  def copy_image(name, source_image_id, source_region, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"        => "CopyImage",
      "Version"       => @version,
      "Name"          => name,
      "SourceImageId" => source_image_id,
      "SourceRegion"  => source_region
      })

    request(:post, "/", query_params)
  end

  @type describe_images_opts :: [
    {:dry_run, boolean}                |
    {:executable_by, [binary]}         |
    {:filters, [filter]}               |
    {:image_id, [binary]}              |
    {:owner, [binary]}
  ]
  @doc """
  Describes one or more of the images (AMIs, AKIs, and ARIs) available to you.
  """
  @spec describe_images() :: ExAws.Operation.RestQuery.t
  @spec describe_images(opts :: describe_images_opts) :: ExAws.Operation.RestQuery.t
  def describe_images(opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeImages",
      "Version" => @version
      })

    request(:get, "/", query_params)
  end

  @type describe_image_attribute_opts :: [
    {:dry_run, boolean}
  ]
  @doc """
  Describes the specified attribute of the specified AMI. You can specify
  only one attribute at a time.
  """
  @spec describe_image_attribute(image_id :: binary, attribute :: binary) :: ExAws.Operation.RestQuery.t
  @spec describe_image_attribute(image_id :: binary, attribute :: binary, opts :: describe_image_attribute_opts) :: ExAws.Operation.RestQuery.t
  def describe_image_attribute(image_id, attribute, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"    => "DescribeImageAttribute",
      "Version"   => @version,
      "ImageId"   => image_id,
      "Attribute" => attribute
      })

    request(:get, "/", query_params)
  end

  @type modify_image_attribute_opts :: [
    {:attribute, binary}                                  |
    {:description, attribute_value}                       |
    {:dry_run, boolean}                                   |
    {:launch_permission, launch_permission_modifications} |
    {:operation_type, :add | :remove}                     |
    {:product_code, :add | :remove}                       |
    {:user_group, [binary]}                               |
    {:value, binary}
  ]
  @doc """
  Modifies the specified attribute of the specified AMI. You can specify only
  one attribute at a time.
  """
  @spec modify_image_attribute(image_id :: binary) :: ExAws.Operation.RestQuery.t
  @spec modify_image_attribute(image_id :: binary, opts :: modify_image_attribute_opts) :: ExAws.Operation.RestQuery.t
  def modify_image_attribute(image_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "ModifyImageAttribute",
      "Version" => @version,
      "ImageId" => image_id
      })

    request(:post, "/", query_params)
  end

  @type reset_image_attribute_opts :: [
    {:dry_run, boolean}
  ]
  @doc """
  Resets an attribute of an AMI to its default value.
  """
  @spec reset_image_attribute(image_id :: binary, attribute :: binary) :: ExAws.Operation.RestQuery.t
  @spec reset_image_attribute(image_id :: binary, attribute :: binary, opts :: reset_image_attribute_opts) :: ExAws.Operation.RestQuery.t
  def reset_image_attribute(image_id, attribute, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"    => "ResetImageAttribute",
      "Version"   => @version,
      "ImageId"   => image_id,
      "Attribute" => attribute
      })

    request(:post, "/", query_params)
  end

  @type register_image_opts :: [
    {:architecture, :i386 | :x86_64}                            |
    {:block_device_mapping, block_device_mapping_list}          |
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
  @spec register_image(name :: binary) :: ExAws.Operation.RestQuery.t
  @spec register_image(name :: binary, opts :: register_image_opts) :: ExAws.Operation.RestQuery.t
  def register_image(name, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "RegisterImage",
      "Version" => @version,
      "Name"    => name
      })

    request(:post, "/", query_params)
  end

  @type deregister_image_opts :: [
    {:dry_run, boolean}
  ]
  @doc """
  Deregisters the specified AMI. After you deregister an AMI, it can't be used
  to launch new instances.
  """
  @spec deregister_image(image_id :: binary) :: ExAws.Operation.RestQuery.t
  @spec deregister_image(image_id :: binary, opts :: deregister_image_opts) :: ExAws.Operation.RestQuery.t
  def deregister_image(image_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DeregisterImage",
      "Version" => @version,
      "ImageId" => image_id
      })

    request(:post, "/", query_params)
  end

  #########################
  ### Key Pairs Actions ###
  #########################

  @type describe_key_pairs_opts :: [
    {:dry_run, boolean}           |
    {:filters, [filter]}          |
    {:key_name, [binary]}
  ]
  @doc """
  Describes one or more of your key pairs.
  """
  @spec describe_key_pairs() :: ExAws.Operation.RestQuery.t
  @spec describe_key_pairs(opts :: describe_key_pairs_opts) :: ExAws.Operation.RestQuery.t
  def describe_key_pairs(opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeKeyPairs",
      "Version" => @version,
      })

    request(:get, "/", query_params)
  end

  @type create_key_pair_opts :: [
    {:dry_run, boolean}
  ]
  @doc """
  Creates a 2048-bit RSA key pair with the specified name. Amazon EC2 stores
  the public key and displays the private key for you to save to a file.
  The private key is returned as an unencrypted PEM encoded PKCS#8 private key.
  """
  @spec create_key_pair(key_name :: binary) :: ExAws.Operation.RestQuery.t
  @spec create_key_pair(key_name :: binary, opts :: create_key_pair_opts) :: ExAws.Operation.RestQuery.t
  def create_key_pair(key_name, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "CreateKeyPair",
      "Version" => @version,
      "KeyName" => key_name,
    })

    request(:post, "/", query_params)
  end

  @type delete_key_pair_opts :: [
    {:dry_run, boolean}
  ]
  @doc """
  Deletes the specified key pair, by removing the public key from Amazon EC2.
  """
  @spec delete_key_pair(key_name :: binary) :: ExAws.Operation.RestQuery.t
  @spec delete_key_pair(key_name :: binary, opts :: delete_key_pair_opts) :: ExAws.Operation.RestQuery.t
  def delete_key_pair(key_name, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DeleteKeyPair",
      "Version" => @version,
      "KeyName" => key_name
      })

    request(:post, "/", query_params)
  end

  @type import_key_pair_opts :: [
    {:dry_run, boolean}
  ]
  @doc """
  Imports the public key from an RSA key pair that you created with a
  third-party tool.
  """
  @spec import_key_pair(key_name :: binary, public_key_material :: binary) :: ExAws.Operation.RestQuery.t
  @spec import_key_pair(key_name :: binary, public_key_material :: binary, opts :: import_key_pair_opts) :: ExAws.Operation.RestQuery.t
  def import_key_pair(key_name, public_key_material, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"            => "ImportKeyPair",
      "Version"           => @version,
      "KeyName"           => key_name,
      "PublicKeyMaterial" => Base.url_encode64(public_key_material)
      })

    request(:post, "/", query_params)
  end

  ###########################
  ### Resource ID Actions ###
  ###########################

  @type describe_id_format_opts :: [
    {:resource, binary}
  ]
  @doc """
  Describes the ID format settings for your resources on a per-region basis,
  for example, to view which resource types are enabled for longer IDs.
  """
  @spec describe_id_format() :: ExAws.Operation.RestQuery.t
  @spec describe_id_format(opts :: describe_id_format_opts) :: ExAws.Operation.RestQuery.t
  def describe_id_format(opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeIdFormat",
      "Version" => @version
      })

    request(:get, "/", query_params)
  end


  @doc """
  Modifies the ID format for the specified resource on a per-region basis.
  """
  @spec modify_id_format(resource :: binary, use_long_ids :: boolean) :: ExAws.Operation.RestQuery.t
  def modify_id_format(resource, use_long_ids) do
    query_params = %{
      "Action"     => "ModifyIdFormat",
      "Version"    => @version,
      "Resource"   => resource,
      "UseLongIds" => use_long_ids
    }

    request(:post, "/", query_params)
  end

  ###############################
  ### Security Groups Actions ###
  ###############################

  @type describe_security_groups_opts :: [
    {:dry_run, boolean}           |
    {:filters, [filter]}          |
    {:group_id, [binary]}         |
    {:group_name, [binary]}
  ]
  @doc """
  Describes one or more of your security groups.
  """
  @spec describe_security_groups() :: ExAws.Operation.RestQuery.t
  @spec describe_security_groups(opts :: describe_security_groups_opts) :: ExAws.Operation.RestQuery.t
  def describe_security_groups(opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeSecurityGroups",
      "Version" => @version
      })

    request(:get, "/", query_params)
  end

  @type create_security_group_opts :: [
    {:dry_run, boolean} |
    {:vpc_id, binary}
  ]
  @doc """
  Creates a security group.
  """
  @spec create_security_group(group_name :: binary, group_description :: binary) :: ExAws.Operation.RestQuery.t
  @spec create_security_group(group_name :: binary, group_description :: binary, opts :: create_security_group_opts) :: ExAws.Operation.RestQuery.t
  def create_security_group(group_name, group_description, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"           => "CreateSecurityGroup",
      "Version"          => @version,
      "GroupName"        => group_name,
      "GroupDescription" => group_description
      })

    request(:post, "/", query_params)
  end

  @type authorize_security_group_ingress_opts :: [
    {:cidr_ip, binary}                          |
    {:dry_run, boolean}                         |
    {:from_port, integer}                       |
    {:group_id, binary}                         |
    {:group_name, binary}                       |
    {:ip_permissions, [ip_permission]}          |
    {:ip_protocol, binary}                      |
    {:source_security_group_name, binary}       |
    {:source_security_group_owner_id, binary}   |
    {:to_port, integer}
  ]
  @doc """
  Adds one or more ingress rules to a security group.
  """
  @spec authorize_security_group_ingress() :: ExAws.Operation.RestQuery.t
  @spec authorize_security_group_ingress(opts :: authorize_security_group_ingress_opts) :: ExAws.Operation.RestQuery.t
  def authorize_security_group_ingress(opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "AuthorizeSecurityGroupIngress",
      "Version" => @version
      })

    request(:post, "/", query_params)
  end

  @type authorize_security_group_egress_opts :: [
    {:cidr_ip, binary}                          |
    {:dry_run, boolean}                         |
    {:from_port, integer}                       |
    {:group_name, binary}                       |
    {:ip_permissions, [ip_permission]}          |
    {:ip_protocol, binary}                      |
    {:source_security_group_name, binary}       |
    {:source_security_group_owner_id, binary}   |
    {:to_port, integer}
  ]
  @doc """
  Adds one or more egress rules to a security group for use with a VPC.
  """
  @spec authorize_security_group_egress(group_id :: binary) :: ExAws.Operation.RestQuery.t
  @spec authorize_security_group_egress(group_id :: binary, opts :: authorize_security_group_egress_opts) :: ExAws.Operation.RestQuery.t
  def authorize_security_group_egress(group_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "AuthorizeSecurityGroupEgress",
      "Version" => @version,
      "GroupId" => group_id
      })

    request(:post, "/", query_params)
  end

  @type revoke_security_group_ingress_opts :: [
    {:cidr_ip, binary}                          |
    {:dry_run, boolean}                         |
    {:from_port, integer}                       |
    {:group_id, binary}                         |
    {:group_name, binary}                       |
    {:ip_permissions, [ip_permission]}          |
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
  @spec revoke_security_group_ingress() :: ExAws.Operation.RestQuery.t
  @spec revoke_security_group_ingress(opts :: revoke_security_group_ingress_opts) :: ExAws.Operation.RestQuery.t
  def revoke_security_group_ingress(opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "RevokeSecurityGroupIngress",
      "Version" => @version
      })

    request(:post, "/", query_params)
  end

  @type revoke_security_group_egress_opts :: [
    {:cidr_ip, binary}                          |
    {:dry_run, boolean}                         |
    {:from_port, integer}                       |
    {:group_name, binary}                       |
    {:ip_permissions, [ip_permission]}          |
    {:ip_protocol, binary}                      |
    {:source_security_group_name, binary}       |
    {:source_security_group_owner_id, binary}   |
    {:to_port, integer}
  ]
  @doc """
  Removes one or more egress rules from a security group for EC2-VPC.
  """
  @spec revoke_security_group_egress(group_id :: binary) :: ExAws.Operation.RestQuery.t
  @spec revoke_security_group_egress(group_id :: binary, opts :: revoke_security_group_egress_opts) :: ExAws.Operation.RestQuery.t
  def revoke_security_group_egress(group_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "RevokeSecurityGroupEgress",
      "Version" => @version,
      "GroupId" => group_id
      })

    request(:post, "/", query_params)
  end

  ####################
  ### VPCs Actions ###
  ####################

  @type describe_vpcs_opts :: [
    {:dry_run, boolean}           |
    {:filters, [filter]}          |
    {:vpc_id, [binary]}
  ]
  @doc """
  Describes one or more of your VPCs.
  """
  @spec describe_vpcs() :: ExAws.Operation.RestQuery.t
  @spec describe_vpcs(opts :: describe_vpcs_opts) :: ExAws.Operation.RestQuery.t
  def describe_vpcs(opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeVpcs",
      "Version" => @version
      })

    request(:get, "/", query_params)
  end

  @type create_vpc_opts :: [
    {:dry_run, boolean} |
    {:instance_tenancy, :default | :dedicated | :host}
  ]
  @doc """
  Creates a VPC with the specified CIDR block.
  """
  @spec create_vpc(cidr_block :: binary) :: ExAws.Operation.RestQuery.t
  @spec create_vpc(cidr_block :: binary, opts :: create_vpc_opts) :: ExAws.Operation.RestQuery.t
  def create_vpc(cidr_block, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"    => "CreateVpc",
      "Version"   => @version,
      "CidrBlock" => cidr_block
      })

    request(:post, "/", query_params)
  end

  @type delete_vpc_opts :: [
    {:dry_run, boolean}
  ]
  @doc """
  Deletes the specified VPC.
  """
  @spec delete_vpc(vpc_id :: binary) :: ExAws.Operation.RestQuery.t
  @spec delete_vpc(vpc_id :: binary, opts :: delete_vpc_opts) :: ExAws.Operation.RestQuery.t
  def delete_vpc(vpc_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DeleteVpc",
      "Version" => @version,
      "VpcId"   => vpc_id
      })

    request(:post, "/", query_params)
  end

  @type describe_vpc_attribute_opts :: [
    {:dry_run, boolean}
  ]
  @doc """
  Describes the specified attribute of the specified VPC. You can specify only one attribute at a time.
  """
  @spec describe_vpc_attribute(vpc_id :: binary, attribute :: binary) :: ExAws.Operation.RestQuery.t
  @spec describe_vpc_attribute(vpc_id :: binary, attribute :: binary, opts :: describe_vpc_attribute_opts) :: ExAws.Operation.RestQuery.t
  def describe_vpc_attribute(vpc_id, attribute, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"    => "DescribeVpcAttribute",
      "Version"   => @version,
      "VpcId"     => vpc_id,
      "Attribute" => attribute
      })

    request(:get, "/", query_params)
  end

  @type modify_vpc_attribute_opts :: [
    {:enable_dns_hostnames, attribute_boolean_value} |
    {:enable_dns_support, attribute_boolean_value}
  ]
  @doc """
  Modifies the specified attribute of the specified VPC.
  """
  @spec modify_vpc_attribute(vpc_id :: binary) :: ExAws.Operation.RestQuery.t
  @spec modify_vpc_attribute(vpc_id :: binary, opts :: modify_vpc_attribute_opts) :: ExAws.Operation.RestQuery.t
  def modify_vpc_attribute(vpc_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "ModifyVpcAttribute",
      "Version" => @version,
      "VpcId"   => vpc_id
      })

    request(:post, "/", query_params)
  end

  #######################
  ### Subnets Actions ###
  #######################

  @type describe_subnets_opts :: [
    {:dry_run, boolean}                        |
    {:filters, [filter]}                       |
    {:subnet_id, [binary]}
  ]
  @doc """
  Describes one or more of your subnets.
  """
  @spec describe_subnets() :: ExAws.Operation.RestQuery.t
  @spec describe_subnets(opts :: describe_subnets_opts) :: ExAws.Operation.RestQuery.t
  def describe_subnets(opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeSubnets",
      "Version" => @version
      })

    request(:get, "/", query_params)
  end

  @type create_subnet_opts :: [
    {:availability_zone, binary} |
    {:dry_run, boolean}
  ]
  @doc """
  Creates a subnet in an existing VPC.
  """
  @spec create_subnet(vpc_id :: binary, cidr_block :: binary) :: ExAws.Operation.RestQuery.t
  @spec create_subnet(vpc_id :: binary, cidr_block :: binary, opts :: create_subnet_opts) :: ExAws.Operation.RestQuery.t
  def create_subnet(vpc_id, cidr_block, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"    => "CreateSubnet",
      "Version"   => @version,
      "VpcId"     => vpc_id,
      "CidrBlock" => cidr_block
      })

    request(:post, "/", query_params)
  end

  @type delete_subnet_opts :: [
    {:dry_run, boolean}
  ]
  @doc """
  Deletes the specified subnet.
  """
  @spec delete_subnet(subnet_id :: binary) :: ExAws.Operation.RestQuery.t
  @spec delete_subnet(subnet_id :: binary, opts :: delete_subnet_opts) :: ExAws.Operation.RestQuery.t
  def delete_subnet(subnet_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"   => "DeleteSubnet",
      "Version"  => @version,
      "SubnetId" => subnet_id
      })

    request(:post, "/", query_params)
  end

  @type modify_subnet_attribute_opts :: [
    {:map_public_ip_on_launch, attribute_boolean_value}
  ]
  @doc """
  Modifies a subnet attribute.
  """
  @spec modify_subnet_attribute(subnet_id :: binary) :: ExAws.Operation.RestQuery.t
  @spec modify_subnet_attribute(subnet_id :: binary, opts :: modify_subnet_attribute_opts) :: ExAws.Operation.RestQuery.t
  def modify_subnet_attribute(subnet_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"   => "ModifySubnetAttribute",
      "Version"  => @version,
      "SubnetId" => subnet_id
      })

    request(:post, "/", query_params)
  end

  ####################
  ### Tags Actions ###
  ####################

  @type resource_type ::
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

  @type describe_tags_filter ::
    {:key, (binary | [binary])}                            |
    {:resource_type, (resource_type | [resource_type])}    |
    {:resource_id, (binary | [binary])}                    |
    {:value, (binary | [binary])}

  @type describe_tags_opts :: [
    {:dry_run, boolean}                       |
    {:filters, [describe_tags_filter]}        |
    {:max_results, integer}                   |
    {:next_token, binary}
  ]
  @doc """
  Describes one or more of the tags for your EC2 resources.
  """
  @spec describe_tags() :: ExAws.Operation.RestQuery.t
  @spec describe_tags(opts :: describe_tags_opts) :: ExAws.Operation.RestQuery.t
  def describe_tags(opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeTags",
      "Version" => @version
      })

    request(:get, "/", query_params)
  end

  @type create_tags_opts :: [
    {:dry_run, boolean}
  ]
  @doc """
  Adds or overwrites one or more tags for the specified Amazon EC2 resource or
  resources. Each resource can have a maximum of 10 tags. Each tag consists of
  a key and optional value. Tag keys must be unique per resource.
  """
  @spec create_tags(resource_ids :: list(binary), tags :: [tag]) :: ExAws.Operation.RestQuery.t
  @spec create_tags(resource_ids :: list(binary), tags :: [tag], opts :: create_tags_opts) :: ExAws.Operation.RestQuery.t
  def create_tags(resource_ids, tags, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "CreateTags",
      "Version" => @version
      })
    |> Map.merge(list_builder(resource_ids, "ResourceId", 1, %{}))
    |> Map.merge(list_builder_key_val(tags, "Tag", 1, %{}))

    request(:post, "/", query_params)
  end

  @type delete_tags_opts :: [
    {:dry_run, boolean} |
    {:tag, [{:tag, tag}, ...]}
  ]
  @doc """
  Deletes the specified set of tags from the specified set of resources.
  """
  @spec delete_tags(resource_ids :: list(binary)) :: ExAws.Operation.RestQuery.t
  @spec delete_tags(resource_ids :: list(binary), opts :: delete_tags_opts) :: ExAws.Operation.RestQuery.t
  def delete_tags(resource_ids, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DeleteTags",
      "Version" => @version
      })
    |> Map.merge(list_builder(resource_ids, "ResourceId", 1, %{}))

    request(:post, "/", query_params)
  end

  ####################################
  ### Elastic Block Stores Actions ###
  ####################################

  @type describe_volumes_opts :: [
    {:dry_run, boolean}                          |
    {:filters, [filter]}                         |
    {:max_results, integer}                      |
    {:next_token, binary}                        |
    {:volume_id, [binary]}
  ]
  @doc """
  Describes the specified EBS volumes.
  """
  @spec describe_volumes() :: ExAws.Operation.RestQuery.t
  @spec describe_volumes(opts :: describe_volumes_opts) :: ExAws.Operation.RestQuery.t
  def describe_volumes(opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeVolumes",
      "Version" => @version
      })

    request(:get, "/", query_params)
  end

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
  @spec create_volume(availability_zone :: binary, size :: available_size_ranges) :: ExAws.Operation.RestQuery.t
  @spec create_volume(availability_zone :: binary, size :: available_size_ranges, opts :: create_volume_opts) :: ExAws.Operation.RestQuery.t
  def create_volume(availability_zone, size, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"           => "CreateVolume",
      "Version"          => @version,
      "AvailabilityZone" => availability_zone,
      "Size"             => size
      })

    request(:post, "/", query_params)
  end

  @type delete_volume_opts :: [
    {:dry_run, boolean}
  ]
  @doc """
  Deletes the specified EBS volume. The volume must be in the available state
  (not attached to an instance).
  """
  @spec delete_volume(volume_id :: binary) :: ExAws.Operation.RestQuery.t
  @spec delete_volume(volume_id :: binary, opts :: delete_volume_opts) :: ExAws.Operation.RestQuery.t
  def delete_volume(volume_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"   => "DeleteVolume",
      "Version"  => @version,
      "VolumeId" => volume_id
      })

    request(:post, "/", query_params)
  end

  @type attach_volume_opts :: [
    {:dry_run, boolean}
  ]
  @doc """
  Attaches an EBS volume to a running or stopped instance and exposes it to
  the instance with the specified device name.
  """
  @spec attach_volume(instance_id :: binary, volume_id :: binary, device :: binary) :: ExAws.Operation.RestQuery.t
  @spec attach_volume(instance_id :: binary, volume_id :: binary, device :: binary, opts :: attach_volume_opts) :: ExAws.Operation.RestQuery.t
  def attach_volume(instance_id, volume_id, device, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"     => "AttachVolume",
      "Version"    => @version,
      "InstanceId" => instance_id,
      "VolumeId"   => volume_id,
      "Device"     => device
      })

    request(:post, "/", query_params)
  end

  @type detach_volume_opts :: [
    {:dry_run, boolean} |
    {:device, binary}   |
    {:force, boolean}   |
    {:instance_id, binary}
  ]
  @doc """
  Detaches an EBS volume from an instance.
  """
  @spec detach_volume(volume_id :: binary) :: ExAws.Operation.RestQuery.t
  @spec detach_volume(volume_id :: binary, opts :: detach_volume_opts) :: ExAws.Operation.RestQuery.t
  def detach_volume(volume_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"   => "DetachVolume",
      "Version"  => @version,
      "VolumeId" => volume_id,
      })

    request(:post, "/", query_params)
  end

  @type describe_volume_attribute_opts :: [
    {:attribute, :auto_enable_io | :product_codes} |
    {:dry_run, boolean}
  ]
  @doc """
  Describes the specified attribute of the specified volume. You can specify
  only one attribute at a time.
  """
  @spec describe_volume_attribute(volume_id :: binary) :: ExAws.Operation.RestQuery.t
  @spec describe_volume_attribute(volume_id :: binary, opts :: describe_volume_attribute_opts) :: ExAws.Operation.RestQuery.t
  def describe_volume_attribute(volume_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"    => "DescribeVolumeAttribute",
      "Version"   => @version,
      "VolumeId"  => volume_id
      })

    request(:get, "/", query_params)
  end

  @type modify_volume_attribute_opts :: [
    {:auto_enable_io, attribute_boolean_value} |
    {:dry_run, boolean}
  ]
  @doc """
  Modifies a volume attribute.
  """
  @spec modify_volume_attribute(volume_id :: binary) :: ExAws.Operation.RestQuery.t
  @spec modify_volume_attribute(volume_id :: binary, opts :: modify_volume_attribute_opts) :: ExAws.Operation.RestQuery.t
  def modify_volume_attribute(volume_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"   => "ModifyVolumeAttribute",
      "Version"  => @version,
      "VolumeId" => volume_id
      })

    request(:post, "/", query_params)
  end

  @type enable_volume_io_opts :: [
    {:dry_run, boolean}
  ]
  @doc """
  Enables I/O operations for a volume that had I/O operations disabled because
  the data on the volume was potentially inconsistent.
  """
  @spec enable_volume_io(volume_id :: binary) :: ExAws.Operation.RestQuery.t
  @spec enable_volume_io(volume_id :: binary, opts :: enable_volume_io_opts) :: ExAws.Operation.RestQuery.t
  def enable_volume_io(volume_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"   => "EnableVolumeIO",
      "Version"  => @version,
      "VolumeId" => volume_id
      })

    request(:post, "/", query_params)
  end

  @type describe_volume_status_opts :: [
    {:dry_run, boolean}                        |
    {:filters, [filter]}                       |
    {:max_results, integer}                    |
    {:next_token, binary}                      |
    {:volume_id, [binary]}
  ]
  @doc """
  Describes the status of the specified volumes.
  """
  @spec describe_volume_status() :: ExAws.Operation.RestQuery.t
  @spec describe_volume_status(opts :: describe_volume_status_opts) :: ExAws.Operation.RestQuery.t
  def describe_volume_status(opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeVolumeStatus",
      "Version" => @version
      })

    request(:get, "/", query_params)
  end

  @type describe_snapshots_opts :: [
    {:dry_run, boolean}                            |
    {:filters, [filter]}                           |
    {:max_results, integer}                        |
    {:next_token, binary}                          |
    {:owner, [binary]}                             |
    {:restorable_by, [binary]}                     |
    {:snapshot_id, [binary]}
  ]
  @doc """
  Describes one or more of the EBS snapshots available to you.
  """
  @spec describe_snapshots() :: ExAws.Operation.RestQuery.t
  @spec describe_snapshots(opts :: describe_snapshots_opts) :: ExAws.Operation.RestQuery.t
  def describe_snapshots(opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeSnapshots",
      "Version" => @version
      })

    request(:get, "/", query_params)
  end

  @type create_snapshot_opts :: [
    {:description, binary} |
    {:dry_run, boolean}
  ]
  @doc """
  Creates a snapshot of an EBS volume and stores it in Amazon S3.
  You can use snapshots for backups, to make copies of EBS volumes, and to
  save data before shutting down an instance.
  """
  @spec create_snapshot(volume_id :: binary) :: ExAws.Operation.RestQuery.t
  @spec create_snapshot(volume_id :: binary, opts :: create_snapshot_opts) :: ExAws.Operation.RestQuery.t
  def create_snapshot(volume_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"   => "CreateSnapshot",
      "Version"  => @version,
      "VolumeId" => volume_id
      })

    request(:post, "/", query_params)
  end

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
  @spec copy_snapshot(source_snapshot_id :: binary, source_region :: binary) :: ExAws.Operation.RestQuery.t
  @spec copy_snapshot(source_snapshot_id :: binary, source_region :: binary, opts :: copy_snapshot_opts) :: ExAws.Operation.RestQuery.t
  def copy_snapshot(source_snapshot_id, source_region, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"           => "CopySnapshot",
      "Version"          => @version,
      "SourceSnapshotId" => source_snapshot_id,
      "SourceRegion"     => source_region
      })

    request(:post, "/", query_params)
  end

  @type delete_snapshot_opts :: [
    {:dry_run, boolean} |
    {:snapshot_id}
  ]
  @doc """
  Deletes the specified snapshot.
  """
  @spec delete_snapshot(snapshot_id :: binary) :: ExAws.Operation.RestQuery.t
  @spec delete_snapshot(snapshot_id :: binary, opts :: delete_snapshot_opts) :: ExAws.Operation.RestQuery.t
  def delete_snapshot(snapshot_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"     => "DeleteSnapshot",
      "Version"    => @version,
      "SnapshotId" => snapshot_id
      })

    request(:post, "/", query_params)
  end

  @type describe_snapshot_attribute_opts :: [
    {:dry_run, boolean}
  ]
  @doc """
  Describes the specified attribute of the specified snapshot. You can specify
  only one attribute at a time.
  """
  @spec describe_snapshot_attribute(snapshot_id :: binary, attribute :: binary) :: ExAws.Operation.RestQuery.t
  @spec describe_snapshot_attribute(snapshot_id :: binary, attribute :: binary, opts :: describe_snapshot_attribute_opts) :: ExAws.Operation.RestQuery.t
  def describe_snapshot_attribute(snapshot_id, attribute, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"     => "DescribeSnapshotAttribute",
      "Version"    => @version,
      "SnapshotId" => snapshot_id,
      "Attribute"  => attribute
      })

    request(:get, "/", query_params)
  end

  @type modify_snapshot_attribute_opts :: [
    {:attribute, :product_codes | :create_volume_permission}            |
    {:create_volume_permission, create_volume_permission_modifications} |
    {:dry_run, boolean}                                                 |
    {:user_group, [binary]}                                             |
    {:operation_type, :add | :remove}                                   |
    {:user_id, [binary]}
  ]
  @doc """
  Adds or removes permission settings for the specified snapshot.
  """
  @spec modify_snapshot_attribute(snapshot_id :: binary) :: ExAws.Operation.RestQuery.t
  @spec modify_snapshot_attribute(snapshot_id :: binary, opts :: modify_snapshot_attribute_opts) :: ExAws.Operation.RestQuery.t
  def modify_snapshot_attribute(snapshot_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"     => "ModifySnapshotAttribute",
      "Version"    => @version,
      "SnapshotId" => snapshot_id
      })

    request(:post, "/", query_params)
  end

  @type reset_snapshot_attribute_opts :: [
    {:dry_run, boolean}
  ]
  @doc """
  Resets permission settings for the specified snapshot.
  """
  @spec reset_snapshot_attribute(snapshot_id :: binary, attribute :: binary) :: ExAws.Operation.RestQuery.t
  @spec reset_snapshot_attribute(snapshot_id :: binary, attribute :: binary, opts :: reset_snapshot_attribute_opts) :: ExAws.Operation.RestQuery.t
  def reset_snapshot_attribute(snapshot_id, attribute, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"     => "ResetSnapshotAttribute",
      "Version"    => @version,
      "SnapshotId" => snapshot_id,
      "Attribute"  => attribute
      })

    request(:post, "/", query_params)
  end

  ##################################
  ### Account Attributes Actions ###
  ##################################

  @type describe_account_attributes_opts :: [
    {:attribute_name, [(:supported_platforms | :default_vpc)]}   |
    {:dry_run, boolean}
  ]
  @doc """
  Describes attributes of your AWS account.
  """
  @spec describe_account_attributes() :: ExAws.Operation.RestQuery.t
  @spec describe_account_attributes(opts :: describe_account_attributes_opts) :: ExAws.Operation.RestQuery.t
  def describe_account_attributes(opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeAccountAttributes",
      "Version" => @version
      })

    request(:get, "/", query_params)
  end

  ############################
  ### Bundle Tasks Actions ###
  ############################

  @type bundle_instance_opts :: [
    {:dry_run, boolean}
  ]
  @doc """
  Bundles an Amazon instance store-backed Windows instance.
  During bundling, only the root device volume (C:\) is bundled. Data on other
  instance store volumes is not preserved.
  """
  @spec bundle_instance(instance_id :: binary, s3_storage) :: ExAws.Operation.RestQuery.t
  @spec bundle_instance(instance_id :: binary, s3_storage, opts :: bundle_instance_opts) :: ExAws.Operation.RestQuery.t
  def bundle_instance(instance_id, {s3_aws_access_key_id, s3_bucket, s3_prefix, s3_upload_policy, s3_upload_policy_sig}, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"                           => "BundleInstance",
      "Version"                          => @version,
      "InstanceId"                       => instance_id,
      "Storage.S3.AWSAccessKeyId"        => s3_aws_access_key_id,
      "Storage.S3.Bucket"                => s3_bucket,
      "Storage.S3.Prefix"                => s3_prefix,
      "Storage.S3.UploadPolicy"          => s3_upload_policy,
      "Storage.S3.UploadPolicySignature" => s3_upload_policy_sig
      })

    request(:post, "/", query_params)
  end

  @type cancel_bundle_task_opts :: [
    {:dry_run, boolean}
  ]
  @doc """
  Cancels a bundling operation for an instance store-backed Windows instance.
  """
  @spec cancel_bundle_task(bundle_id :: binary) :: ExAws.Operation.RestQuery.t
  @spec cancel_bundle_task(bundle_id :: binary, opts :: cancel_bundle_task_opts) :: ExAws.Operation.RestQuery.t
  def cancel_bundle_task(bundle_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"   => "CancelBundleTask",
      "Version"  => @version,
      "BundleId" => bundle_id
      })

    request(:post, "/", query_params)
  end

  @type bundle_instance_states :: :pending | :waiting_for_shutdown | :bundling | :storing | :cancelling | :complete | :failed

  @type describe_bundle_tasks_opts :: [
    {:bundle_id, [binary]}          |
    {:dry_run, boolean}             |
    {:filters, [filter]}
  ]
  @doc """
  Describes one or more of your bundling tasks.
  """
  @spec describe_bundle_tasks() :: ExAws.Operation.RestQuery.t
  @spec describe_bundle_tasks(opts :: describe_bundle_tasks_opts) :: ExAws.Operation.RestQuery.t
  def describe_bundle_tasks(opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeBundleTasks",
      "Version" => @version
      })

    request(:get, "/", query_params)
  end

  ########################
  ### Helper Functions ###
  ########################

  defp request(http_method, path, data) do
    %ExAws.Operation.RestQuery{
      http_method: http_method,
      path: path,
      params: data,
      service: :ec2
    }
  end

  defp normalize_opts(opts) do
    opts
    |> Enum.reduce(%{}, &reduce_list_params/2)
    |> camelize_keys
  end

  defp reduce_list_params({:filters, filters}, acc), do: Map.merge(acc, filter_list_builder(filters, "Filter", 1, %{}))
  defp reduce_list_params({key, val}, acc) when is_list(val), do: Map.merge(acc, list_builder(val, key, 1, %{}))
  defp reduce_list_params({key, val}, acc), do: Map.put(acc, key, val)

  defp list_builder([], _key, _count, _state), do: %{}
  defp list_builder([h | []], key, count, state) do
    Map.put(state, "#{key}.#{count}", h)
  end

  defp list_builder([h | t], key, count, state) do
    list_builder t, key, count + 1, Map.put(state, "#{key}.#{count}", h)
  end

  defp list_builder_key_val([{f, s} | []], key, count, state) do
    new_map = Map.new
    |> Map.put("#{key}.#{count}.Key", f)
    |> Map.put("#{key}.#{count}.Value", s)

    Map.merge(state, new_map)
  end

  defp list_builder_key_val([_h = {f, s} | t], key, count, state) do
    new_map = Map.new
    |> Map.put("#{key}.#{count}.Key", f)
    |> Map.put("#{key}.#{count}.Value", s)

    list_builder_key_val t, key, count + 1, Map.merge(state, new_map)
  end


  defp filter_list_builder([], _param, _count, _state), do: %{}
  defp filter_list_builder([{f, s} | []], param, count, state) do
    new_map = Map.new
    |> Map.put("#{param}.#{count}.Name", filter_atom_to_string(f))
    |> put_values("#{param}.#{count}.Value", s)

    Map.merge(state, new_map)
  end

  defp filter_list_builder([{f, s} | t], param, count, state) do
    new_map = Map.new
    |> Map.put("#{param}.#{count}.Name", filter_atom_to_string(f))
    |> put_values("#{param}.#{count}.Value", s)

    filter_list_builder t, param, count + 1, Map.merge(state, new_map)
  end

  defp filter_atom_to_string(v) when is_binary(v), do: v
  defp filter_atom_to_string(v) when is_atom(v), do: Atom.to_string(v) |> String.replace("_","-")

  defp put_values(map = %{}, prefix, v) when is_list(v) do
    v
    |> Enum.map(&filter_atom_to_string/1)
    |> list_builder(prefix, 1, map)
  end
  defp put_values(map = %{}, prefix, v) when is_atom(v), do: Map.put(map, prefix, filter_atom_to_string(v))
  defp put_values(map = %{}, prefix, v), do: Map.put(map, prefix, v)
end
