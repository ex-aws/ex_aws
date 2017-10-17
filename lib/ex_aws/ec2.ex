defmodule ExAws.EC2 do
  @moduledoc """
  Operations on AWS EC2

  A selection of the most common operations from the EC2 API are implemented here.
  http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_Operations.html


  Examples of how to use this:
  ```elixir
  alias ExAws.EC2

  EC2.terminate_instances(["i-123456", "i-987654"], [dry_run: true])
  EC2.register_image("Test", [block_device_mappings: [
    [device_name: "/dev/sda1", ebs: [snapshot_id: "snap-1234567890abcdef0"]],
    [device_name: "/dev/sdb",  ebs: [snapshot_id: "snap-1234567890abcdef1"]],
    [device_name: "/dev/sdc",  ebs: [volume_size: 100]]
  ]])
  ```
  """
  use ExAws.Utils,
  format_type: :xml,
  non_standard_keys: %{
    assign_ipv6_address_on_creation: "AssignIpv6AddressOnCreation.Value",
    enable_dns_support: "EnableDnsSupport.Value",
    enable_dns_hostnames: "EnableDnsHostnames.Value",
    map_public_ip_on_launch: "MapPublicIpOnLaunch.Value"
  }

  @version "2016-11-15"

  @type filter :: {name :: binary | atom, value :: [binary,...]}

  @type ebs :: [
    delete_on_termination: boolean,
    encrypted: boolean,
    iops: integer,
    snapshot_id: binary,
    volume_size: integer,
    volume_type: binary
  ]
  @type block_device_mapping :: [
    device_name: binary,
    ebs: ebs,
    no_device: binary,
    virtual_name: binary
  ]

  @type permission :: [
    group: binary,
    user_id: binary
  ]
  @type permission_modifications :: [
    add: [permission, ...],
    remove: [permission, ...]
  ]

  @type attribute_boolean_value :: [
    value: boolean
  ]

  @type attribute_value :: [
    value: binary
  ]

  @type tag :: {key :: atom, value :: binary}

  @type tag_specification :: {
    resource_type :: atom,
    tags :: [tag, ...]
  }

  @type ipv6_address :: [
    ipv6_address: binary
  ]
  @type private_ip_address_spec :: [
    primary: boolean,
    private_ip_address: binary
  ]
  @type network_interface_spec :: [
    associate_public_ip_address: boolean,
    delete_on_termination: boolean,
    description: binary,
    device_index: integer,
    ipv6_address_count: integer,
    ipv6_addresses: [ipv6_address, ...],
    network_interface_id: binary,
    private_ip_address: binary,
    private_ip_addresses: [private_ip_address_spec, ...],
    secondary_ip_address_count: integer,
    groups: [binary, ...],
    subnet_id: binary
  ]
  @type iam_instance_profile_spec :: [
    arn: binary,
    name: binary
  ]
  @type monitoring_enabled :: [
    enabled: boolean
  ]
  @type placement :: [
    affinity: binary,
    availability_zone: binary,
    group_name: binary,
    host_id: binary,
    spread_domain: binary,
    tenancy: binary
  ]

  #######################
  # Instance Operations #
  #######################

  @doc """
  Describes one or more instances.
  If you specify the instance IDs or filters, Amazon EC2 returns information for those instances.
  If you do not specify an instance ID or filters, then it'll all the relevant instances

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeInstances.html

  ## Examples:

      iex> ExAws.EC2.describe_instances
      %ExAws.Operation.Query{action: :describe_instances,
      params: %{
        "Action" => "DescribeInstances",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

      iex> ExAws.EC2.describe_instances([filters: ["instance-type": ["m1.small", "m3.medium"]]])
      %ExAws.Operation.Query{action: :describe_instances,
      params: %{
        "Action" => "DescribeInstances",
        "Filter.1.Name" => "instance-type",
        "Filter.1.Value.1" => "m1.small",
        "Filter.1.Value.2" => "m3.medium",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type describe_instances_opts :: [
    dry_run: boolean,
    filters: [filter, ...],
    include_all_instances: boolean,
    instance_ids: [binary, ...],
    max_results: integer,
    next_token: binary
  ]
  @spec describe_instances() :: ExAws.Operation.Query.t
  @spec describe_instances(opts :: describe_instances_opts) :: ExAws.Operation.Query.t
  def describe_instances(opts \\ []) do
    opts |> build_request(:describe_instances)
  end


  @doc """
  Describes the status of one or more instances. By default, only running
  instances are described, unless specified otherwise.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeInstanceStatus.html

  ## Examples:

      iex> ExAws.EC2.describe_instance_status
      %ExAws.Operation.Query{action: :describe_instance_status,
      params: %{
        "Action" => "DescribeInstanceStatus",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

      iex> ExAws.EC2.describe_instance_status([instance_ids: ["i-123456", "i-1a2b3c"]])
      %ExAws.Operation.Query{action: :describe_instance_status,
      params: %{
        "Action" => "DescribeInstanceStatus",
        "InstanceId.1" => "i-123456",
        "InstanceId.2" => "i-1a2b3c",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type describe_instance_status_opts :: [
    dry_run: boolean,
    filters: [filter, ...],
    include_all_instances: boolean,
    instance_ids: [binary, ...],
    max_results: integer,
    next_token: binary
  ]
  @spec describe_instance_status() :: ExAws.Operation.Query.t
  @spec describe_instance_status(opts :: describe_instance_status_opts) :: ExAws.Operation.Query.t
  def describe_instance_status(opts \\ []) do
    opts |> build_request(:describe_instance_status)
  end


  @doc """
  Shuts down one or more instances. Terminated instances remain visible after
  termination (for approximately one hour).

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_TerminateInstances.html

  ## Examples:

      iex> ExAws.EC2.terminate_instances(["i-123456", "i-987654"])
      %ExAws.Operation.Query{action: :terminate_instances,
      params: %{
        "Action" => "TerminateInstances",
        "InstanceId.1" => "i-123456",
        "InstanceId.2" => "i-987654",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

      iex> ExAws.EC2.terminate_instances(["i-123456"], [dry_run: true])
      %ExAws.Operation.Query{action: :terminate_instances,
      params: %{
        "Action" => "TerminateInstances",
        "InstanceId.1" => "i-123456",
        "DryRun" => true,
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type terminate_instances_opts :: [
    dry_run: boolean
  ]
  @spec terminate_instances(instance_ids :: [binary, ...]) :: ExAws.Operation.Query.t
  @spec terminate_instances(instance_ids :: [binary, ...], opts :: terminate_instances_opts) :: ExAws.Operation.Query.t
  def terminate_instances(instance_ids, opts \\ []) do
    [ {"InstanceId", instance_ids} | opts ]
      |> build_request(:terminate_instances)
  end


  @doc """
  Requests a reboot of one or more instances. This operation is asynchronous; it
  only queues a request to reboot the specified instances.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_RebootInstances.html

  ## Examples:

      iex> ExAws.EC2.reboot_instances(["i-123456"])
      %ExAws.Operation.Query{action: :reboot_instances,
      params: %{
        "Action" => "RebootInstances",
        "InstanceId.1" => "i-123456",
        "Version" => "2016-11-15"},
      parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type reboot_instances_opts :: [
    dry_run: boolean
  ]
  @spec reboot_instances(instance_ids :: [binary, ...]) :: ExAws.Operation.Query.t
  @spec reboot_instances(instance_ids :: [binary, ...], opts :: reboot_instances_opts) :: ExAws.Operation.Query.t
  def reboot_instances(instance_ids, opts \\ []) do
    [ {"InstanceId", instance_ids} | opts ]
      |> build_request(:reboot_instances)
  end


  @doc """
  Starts an Amazon EBS-backed AMI that was previously stopped.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_StartInstances.html

  ## Examples:

      iex> ExAws.EC2.start_instances(["i-123456"])
      %ExAws.Operation.Query{action: :start_instances,
      params: %{
        "Action" => "StartInstances",
        "InstanceId.1" => "i-123456",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type start_instances_opts :: [
    additional_info: binary,
    dry_run: boolean,
  ]
  @spec start_instances(instance_ids :: [binary, ...]) :: ExAws.Operation.Query.t
  @spec start_instances(instance_ids :: [binary, ...], opts :: start_instances_opts) :: ExAws.Operation.Query.t
  def start_instances(instance_ids, opts \\ []) do
    [ {"InstanceId", instance_ids} | opts ]
      |> build_request(:start_instances)
  end

  @doc """
  Stops an Amazon EBS-backed AMI that was previously started.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_StopInstances.html

  ## Examples:

      iex> ExAws.EC2.stop_instances(["i-123456"], [force: true])
      %ExAws.Operation.Query{action: :stop_instances,
      params: %{
        "Action" => "StopInstances",
        "InstanceId.1" => "i-123456",
        "Force" => true,
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type stop_instances_opts :: [
    dry_run: boolean,
    force: boolean
  ]
  @spec stop_instances(instance_ids :: [binary, ...]) :: ExAws.Operation.Query.t
  @spec stop_instances(instance_ids :: [binary, ...], opts :: stop_instances_opts) :: ExAws.Operation.Query.t
  def stop_instances(instance_ids, opts \\ []) do
    [ {"InstanceId", instance_ids} | opts ]
      |> build_request(:stop_instances)
  end

  @doc """
  Launches the specified number of instances using an AMI for which you have permissions.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_RunInstances.html

  ## Examples:

      iex> ExAws.EC2.run_instances("ami-123456", 3, 3,
      ...> [block_device_mappings: [
      ...>  [device_name: "/dev/sdc", virtual_name: "ephemeral10"],
      ...>  [device_name: "/dev/sdd", virtual_name: "ephemeral11"],
      ...>  [device_name: "/dev/sdf", ebs: [delete_on_termination: true, volume_size: 100]]
      ...> ]])
      %ExAws.Operation.Query{action: :run_instances,
      params: %{
        "Action" => "RunInstances",
        "ImageId" => "ami-123456",
        "MinCount" => 3,
        "MaxCount" => 3,
        "BlockDeviceMapping.1.DeviceName" => "/dev/sdc",
        "BlockDeviceMapping.1.VirtualName" => "ephemeral10",
        "BlockDeviceMapping.2.DeviceName" => "/dev/sdd",
        "BlockDeviceMapping.2.VirtualName" => "ephemeral11",
        "BlockDeviceMapping.3.DeviceName" => "/dev/sdf",
        "BlockDeviceMapping.3.Ebs.DeleteOnTermination" => true,
        "BlockDeviceMapping.3.Ebs.VolumeSize" => 100,
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type run_instances_opts :: [
    additional_info: binary,
    block_device_mappings: [block_device_mapping, ...],
    client_token: binary,
    disable_api_termination: boolean,
    dry_run: boolean,
    ebs_optimized: boolean,
    iam_instance_profile: iam_instance_profile_spec,
    image_id: binary,
    instance_initiated_shutdown_behavior: binary,
    instance_type: binary,
    ipv6_addresses: [ipv6_address, ...],
    ipv6_address_count: integer,
    kernel_id: binary,
    key_name: binary,
    max_count: integer,
    min_count: integer,
    monitoring: monitoring_enabled,
    network_interfaces: [network_interface_spec, ...],
    placement: placement,
    private_ip_address: binary,
    ramdisk_id: binary,
    security_groups: [binary, ...],
    security_group_ids: [binary, ...],
    subnet_id: binary,
    tag_specifications: [tag_specification, ...],
    user_data: binary
  ]
  @spec run_instances(image_id :: binary, min_count :: integer, max_count :: integer) :: ExAws.Operation.Query.t
  @spec run_instances(image_id :: binary, min_count :: integer, max_count :: integer, opts :: run_instances_opts) :: ExAws.Operation.Query.t
  def run_instances(image_id, min_count, max_count, opts \\ []) do
    [ {"ImageId", image_id},
      {"MinCount", min_count},
      {"MaxCount", max_count} |
      opts ]
      |> build_request(:run_instances)
  end


  @doc """
  Submits feedback about the status of an instance. The instance must be in the
  running state.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ReportInstanceStatus.html

  ## Examples:

      iex> ExAws.EC2.report_instance_status(["i-a1b2c3"], "ok")
      %ExAws.Operation.Query{action: :report_instance_status,
      params: %{
        "Action" => "ReportInstanceStatus",
        "InstanceId.1" => "i-a1b2c3",
        "Status" => "ok",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type report_instance_status_opts :: [
    description: binary,
    dry_run: boolean,
    end_time: %DateTime{},
    reason_codes: [binary, ...],
    start_time: %DateTime{}
  ]
  @spec report_instance_status(instance_ids :: [binary, ...], status :: binary) :: ExAws.Operation.Query.t
  @spec report_instance_status(instance_ids :: [binary, ...], status :: binary, opts :: report_instance_status_opts) :: ExAws.Operation.Query.t
  def report_instance_status(instance_ids, status, opts \\ []) do
    [ {"InstanceId", instance_ids},
      {"Status", status} |
      opts ]
      |> build_request(:report_instance_status)
  end

  @doc """
  Enables detailed monitoring for a running instance.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_MonitorInstances.html

  ## Examples:

      iex> ExAws.EC2.monitor_instances(["i-a1b2c3"])
      %ExAws.Operation.Query{action: :monitor_instances,
      params: %{
        "Action" => "MonitorInstances",
        "InstanceId.1" => "i-a1b2c3",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type monitor_instances_opts :: [
    dry_run: boolean
  ]
  @spec monitor_instances(instance_ids :: [binary, ...]) :: ExAws.Operation.Query.t
  @spec monitor_instances(instance_ids :: [binary, ...], opts :: monitor_instances_opts) :: ExAws.Operation.Query.t
  def monitor_instances(instance_ids, opts \\ []) do
    [ {"InstanceId", instance_ids} | opts ]
      |> build_request(:monitor_instances)
  end


  @doc """
  Disables detailed monitoring for a running instance.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_UnmonitorInstances.html

  ## Examples:

      iex> ExAws.EC2.unmonitor_instances(["i-a1b2c3"])
      %ExAws.Operation.Query{action: :unmonitor_instances,
      params: %{
        "Action" => "UnmonitorInstances",
        "InstanceId.1" => "i-a1b2c3",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type unmonitor_instances_opts :: [
    dry_run: boolean
  ]
  @spec unmonitor_instances(instance_ids :: [binary, ...]) :: ExAws.Operation.Query.t
  @spec unmonitor_instances(instance_ids :: [binary, ...], opts :: unmonitor_instances_opts) :: ExAws.Operation.Query.t
  def unmonitor_instances(instance_ids, opts \\ []) do
    [ {"InstanceId", instance_ids} | opts ]
      |> build_request(:unmonitor_instances)
  end


  @doc """
  Describes the specified attribute of the specified instance. You can specify
  only one attribute at a time.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeInstanceAttribute.html

  ## Examples:

      iex> ExAws.EC2.describe_instance_attribute("i-123456", "description")
      %ExAws.Operation.Query{action: :describe_instance_attribute,
      params: %{
        "Action" => "DescribeInstanceAttribute",
        "InstanceId" => "i-123456",
        "Attribute" => "description",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type describe_instance_attribute_opts :: [
    dry_run: boolean
  ]
  @spec describe_instance_attribute(instance_id :: binary, attribute :: binary) :: ExAws.Operation.Query.t
  @spec describe_instance_attribute(instance_id :: binary, attribute :: binary, opts :: describe_instance_attribute_opts) :: ExAws.Operation.Query.t
  def describe_instance_attribute(instance_id, attribute, opts \\ []) do
    [ {"InstanceId", instance_id},
      {"Attribute", attribute} |
      opts ]
      |> build_request(:describe_instance_attribute)
  end


  @doc """
  Modifies the specified attribute of the specified instance. You can
  specify only one attribute at a time.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ModifyInstanceAttribute.html

  ## Examples:

      iex> ExAws.EC2.modify_instance_attribute("i-123456", [instance_type: [value: "m1.small"]])
      %ExAws.Operation.Query{action: :modify_instance_attribute,
      params: %{
        "Action" => "ModifyInstanceAttribute",
        "InstanceId" => "i-123456",
        "InstanceType.Value" => "m1.small",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type modify_instance_attribute_opts :: [
    attribute: binary,
    block_device_mappings: [block_device_mapping, ...],
    disable_api_termination: attribute_boolean_value,
    dry_run: boolean,
    ebs_optimized: attribute_boolean_value,
    ena_support: attribute_boolean_value,
    group_ids: [binary, ...],
    instance_initiated_shutdown_behavior: attribute_value,
    instance_type: attribute_value,
    kernel: attribute_value,
    ramdisk: attribute_value,
    source_dest_check: attribute_boolean_value,
    sriov_net_support: binary,
    user_data: attribute_value,
    value: binary
  ]
  @spec modify_instance_attribute(instance_id :: binary) :: ExAws.Operation.Query.t
  @spec modify_instance_attribute(instance_id :: binary, opts :: modify_instance_attribute_opts) :: ExAws.Operation.Query.t
  def modify_instance_attribute(instance_id, opts \\ []) do
    [ {"InstanceId", instance_id} | opts ]
      |> build_request(:modify_instance_attribute)
  end


  @doc """
  Resets an attribute of an instance to its default value. To reset the kernel
  or ramdisk, the instance must be in a stopped state. To reset the
  SourceDestCheck, the instance can be either running or stopped.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ResetInstanceAttribute.html

  ## Examples:

      iex> ExAws.EC2.reset_instance_attribute("i-123456", "description")
      %ExAws.Operation.Query{action: :reset_instance_attribute,
      params: %{
        "Action" => "ResetInstanceAttribute",
        "InstanceId" => "i-123456",
        "Attribute" => "description",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type reset_instance_attribute_opts :: [
    dry_run: boolean
  ]
  @spec reset_instance_attribute(instance_id :: binary, attribute :: binary) :: ExAws.Operation.Query.t
  @spec reset_instance_attribute(instance_id :: binary, attribute :: binary, opts :: reset_instance_attribute_opts) :: ExAws.Operation.Query.t
  def reset_instance_attribute(instance_id, attribute, opts \\ []) do
    [ {"InstanceId", instance_id},
      {"Attribute", attribute} | opts ]
      |> build_request(:reset_instance_attribute)
  end


  @doc """
  Gets the console output for the specified instance.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_GetConsoleOutput.html

  ## Examples:

      iex> ExAws.EC2.get_console_output("i-123456")
      %ExAws.Operation.Query{action: :get_console_output,
      params: %{
        "Action" => "GetConsoleOutput",
        "InstanceId" => "i-123456",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type get_console_output_opts :: [
    dry_run: boolean
  ]
  @spec get_console_output(instance_id :: binary) :: ExAws.Operation.Query.t
  @spec get_console_output(instance_id :: binary, opts :: get_console_output_opts) :: ExAws.Operation.Query.t
  def get_console_output(instance_id, opts \\ []) do
    [ {"InstanceId", instance_id} | opts ]
      |> build_request(:get_console_output)
  end


  @doc """
  Retrieves the encrypted administrator password for an instance running
  Windows.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_GetPasswordData.html

  ## Examples:

      iex> ExAws.EC2.get_password_data("i-123456")
      %ExAws.Operation.Query{action: :get_password_data,
      params: %{
        "Action" => "GetPasswordData",
        "InstanceId" => "i-123456",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type get_password_data_opts :: [
    dry_run: boolean
  ]
  @spec get_password_data(instance_id :: binary) :: ExAws.Operation.Query.t
  @spec get_password_data(instance_id :: binary, opts :: get_password_data_opts) :: ExAws.Operation.Query.t
  def get_password_data(instance_id, opts \\ []) do
    [ {"InstanceId", instance_id} | opts ]
      |> build_request(:get_password_data)
  end

  ##################
  # AMI Operations #
  ##################

  @doc """
  Creates an Amazon EBS-backed AMI from an Amazon EBS-backed instance
  that is either running or stopped.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateImage.html

  ## Examples:

      iex> ExAws.EC2.create_image("i-123456", "Test")
      %ExAws.Operation.Query{action: :create_image,
      params: %{
        "Action" => "CreateImage",
        "InstanceId" => "i-123456",
        "Name" => "Test",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type create_image_opts :: [
    block_device_mappings: [block_device_mapping, ...],
    description: binary,
    dry_run: boolean,
    no_reboot: boolean
  ]
  @spec create_image(instance_id :: binary, name :: binary) :: ExAws.Operation.Query.t
  @spec create_image(instance_id :: binary, name :: binary, opts :: create_image_opts) :: ExAws.Operation.Query.t
  def create_image(instance_id, name, opts \\ []) do
    [ {"InstanceId", instance_id},
      {"Name", name} | opts ]
    |> build_request(:create_image)
  end


  @doc """
  Initiates the copy of an AMI from the specified source region to the current
  region. You specify the destination region by using its endpoint when
  making the request.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CopyImage.html

  ## Examples:

      iex> ExAws.EC2.copy_image("Test", "ami-123456", "us-east-1")
      %ExAws.Operation.Query{action: :copy_image,
      params: %{
        "Action" => "CopyImage",
        "Name" => "Test",
        "SourceImageId" => "ami-123456",
        "SourceRegion" => "us-east-1",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type copy_image_opts :: [
    client_token: binary,
    description: binary,
    dry_run: boolean,
    encrypted: boolean,
    kms_key_id: binary
  ]
  @spec copy_image(name :: binary, source_image_id :: binary, source_region :: binary) :: ExAws.Operation.Query.t
  @spec copy_image(name :: binary, source_image_id :: binary, source_region :: binary, opts :: copy_image_opts) :: ExAws.Operation.Query.t
  def copy_image(name, source_image_id, source_region, opts \\ []) do
    [ {"Name", name},
      {"SourceImageId", source_image_id},
      {"SourceRegion", source_region} | opts ]
      |> build_request(:copy_image)
  end


  @doc """
  Describes one or more of the images (AMIs, AKIs, and ARIs) available to you.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeImages.html

  ## Examples:

      iex> ExAws.EC2.describe_images
      %ExAws.Operation.Query{action: :describe_images,
      params: %{
        "Action" => "DescribeImages",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

      iex> ExAws.EC2.describe_images([image_ids: ["ami-123456", "ami-1a2b3c4d"]])
      %ExAws.Operation.Query{action: :describe_images,
      params: %{
        "Action" => "DescribeImages",
        "ImageId.1" => "ami-123456",
        "ImageId.2" => "ami-1a2b3c4d",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type describe_images_opts :: [
    dry_run: boolean,
    executable_by_list: [binary, ...],
    filters: [filter, ...],
    image_ids: [binary, ...],
    owners: [binary, ...]
  ]
  @spec describe_images() :: ExAws.Operation.Query.t
  @spec describe_images(opts :: describe_images_opts) :: ExAws.Operation.Query.t
  def describe_images(opts \\ []) do
    opts |> build_request(:describe_images)
  end


  @doc """
  Describes the specified attribute of the specified AMI. You can specify
  only one attribute at a time.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeImageAttribute.html

  ## Examples:

      iex> ExAws.EC2.describe_image_attribute("ami-123456", "description")
      %ExAws.Operation.Query{action: :describe_image_attribute,
      params: %{
        "Action" => "DescribeImageAttribute",
        "ImageId" => "ami-123456",
        "Attribute" => "description",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type describe_image_attribute_opts :: [
    dry_run: boolean
  ]
  @spec describe_image_attribute(image_id :: binary, attribute :: binary) :: ExAws.Operation.Query.t
  @spec describe_image_attribute(image_id :: binary, attribute :: binary, opts :: describe_image_attribute_opts) :: ExAws.Operation.Query.t
  def describe_image_attribute(image_id, attribute, opts \\ []) do
    [ {"ImageId", image_id},
      {"Attribute", attribute} | opts ]
      |> build_request(:describe_image_attribute)
  end

  @doc """
  Modifies the specified attribute of the specified AMI. You can specify only
  one attribute at a time.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ModifyImageAttribute.html

  ## Examples:

      iex> ExAws.EC2.modify_image_attribute("ami-123456", [attribute: "description"])
      %ExAws.Operation.Query{action: :modify_image_attribute,
      params: %{
        "Action" => "ModifyImageAttribute",
        "ImageId" => "ami-123456",
        "Attribute" => "description",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type modify_image_attribute_opts :: [
    attribute: binary,
    description: attribute_value,
    dry_run: boolean,
    launch_permission: permission_modifications,
    operation_type: binary,
    product_codes: [binary, ...],
    user_ids: [binary, ...],
    user_groups: [binary, ...],
    value: binary
  ]
  @spec modify_image_attribute(image_id :: binary) :: ExAws.Operation.Query.t
  @spec modify_image_attribute(image_id :: binary, opts :: modify_image_attribute_opts) :: ExAws.Operation.Query.t
  def modify_image_attribute(image_id, opts \\ []) do
    [ {"ImageId", image_id} | opts ]
      |> build_request(:modify_image_attribute)
  end


  @doc """
  Resets an attribute of an AMI to its default value.
  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ResetImageAttribute.html

  NOTE: You can currently only reset the launchPermission attribute. Please refer to the
  doc in case something has changed.

  ## Examples:

      iex> ExAws.EC2.reset_image_attribute("ami-1234567", "launchPermission")
      %ExAws.Operation.Query{action: :reset_image_attribute,
      params: %{
        "Action" => "ResetImageAttribute",
        "ImageId" => "ami-1234567",
        "Attribute" => "launchPermission",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type reset_image_attribute_opts :: [
    dry_run: boolean
  ]
  @spec reset_image_attribute(image_id :: binary, attribute :: binary) :: ExAws.Operation.Query.t
  @spec reset_image_attribute(image_id :: binary, attribute :: binary, opts :: reset_image_attribute_opts) :: ExAws.Operation.Query.t
  def reset_image_attribute(image_id, attribute, opts \\ []) do
    [ {"ImageId", image_id},
      {"Attribute", attribute} | opts ]
      |> build_request(:reset_image_attribute)
  end

  @doc """
  Registers an AMI. When you're creating an AMI, this is the final step you
  must complete before you can launch an instance from the AMI.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_RegisterImage.html

  ## Examples:

      iex> ExAws.EC2.register_image("Test")
      %ExAws.Operation.Query{action: :register_image,
      params: %{
        "Action" => "RegisterImage",
        "Name" => "Test",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

      iex>
      ExAws.EC2.register_image("Test", [block_device_mappings: [
      [device_name: "/dev/sda1", ebs: [snapshot_id: "snap-1234567890abcdef0"]],
      [device_name: "/dev/sdb",  ebs: [snapshot_id: "snap-1234567890abcdef1"]],
      [device_name: "/dev/sdc",  ebs: [volume_size: 100]]
      ]])
      %ExAws.Operation.Query{action: :register_image,
      params: %{"
          Action" => "RegisterImage",
          "BlockDeviceMapping.1.DeviceName" => "/dev/sda1",
          "BlockDeviceMapping.1.Ebs.SnapshotId" => "snap-1234567890abcdef0",
          "BlockDeviceMapping.2.DeviceName" => "/dev/sdb",
          "BlockDeviceMapping.2.Ebs.SnapshotId" => "snap-1234567890abcdef1",
          "BlockDeviceMapping.3.DeviceName" => "/dev/sdc",
          "BlockDeviceMapping.3.Ebs.VolumeSize" => 100, "Name" => "Test",
          "Version" => "2016-11-15"}, parser: &ExAws.Utils.identity/2, path: "/",
       service: :ec2}

  """
  @type register_image_opts :: [
    architecture: binary,
    billing_products: [binary, ...],
    block_device_mappings: [block_device_mapping, ...],
    description: binary,
    dry_run: boolean,
    ena_support: boolean,
    image_location: binary,
    kernel_id: binary,
    ramdisk_id: binary,
    root_device_name: binary,
    sriov_net_support: binary,
    virtualization_type: binary
  ]
  @spec register_image(name :: binary) :: ExAws.Operation.Query.t
  @spec register_image(name :: binary, opts :: register_image_opts) :: ExAws.Operation.Query.t
  def register_image(name, opts \\ []) do
    [ {"Name", name} | opts ]
      |> build_request(:register_image)
  end


  @doc """
  Deregisters the specified AMI. After you deregister an AMI, it can't be used
  to launch new instances.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DeregisterImage.html

  ## Examples:

      iex> ExAws.EC2.deregister_image("ami-123456")
      %ExAws.Operation.Query{action: :deregister_image,
      params: %{
        "Action" => "DeregisterImage",
        "ImageId" => "ami-123456",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type deregister_image_opts :: [
    dry_run: boolean
  ]
  @spec deregister_image(image_id :: binary) :: ExAws.Operation.Query.t
  @spec deregister_image(image_id :: binary, opts :: deregister_image_opts) :: ExAws.Operation.Query.t
  def deregister_image(image_id, opts \\ []) do
    [ {"ImageId", image_id} | opts  ]
      |> build_request(:deregister_image)
  end


  #####################
  # Volume Operations #
  #####################

  @doc """
  Attaches a volume to a specified instance

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_AttachVolume.html

  ## Examples:

      iex> ExAws.EC2.attach_volume("i-123456", "vol-123456", "/dev/sdh")
      %ExAws.Operation.Query{action: :attach_volume,
      params: %{
        "Action" => "AttachVolume",
        "InstanceId" => "i-123456",
        "VolumeId" => "vol-123456",
        "Device" => "/dev/sdh",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type attach_volume_opts :: [
    dry_run: boolean
  ]
  @spec attach_volume(instance_id :: binary, volume_id :: binary, device :: binary, opts :: attach_volume_opts) :: ExAws.Operation.Query.t
  def attach_volume(instance_id, volume_id, device, opts \\ []) do
    [ {"InstanceId", instance_id},
      {"VolumeId", volume_id},
      {"Device", device} | opts]
      |> build_request(:attach_volume)
  end

  @doc """
  Detaches a specific volume

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DetachVolume.html

  ## Examples:

      iex> ExAws.EC2.detach_volume("vol-123456")
      %ExAws.Operation.Query{action: :detach_volume,
      params: %{
        "Action" => "DetachVolume",
        "VolumeId" => "vol-123456",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type detach_volume_opts :: [
    instance_id: binary,
    force: boolean,
    dry_run: boolean,
    device: binary
  ]
  @spec detach_volume(volume_id :: binary, opts :: detach_volume_opts) :: ExAws.Operation.Query.t
  def detach_volume(volume_id, opts \\ []) do
    [ {"VolumeId", volume_id} | opts ]
      |> build_request(:detach_volume)
  end


  @doc """
  Creates an EBS volume that can be attached to an instance in the same
  Availability Zone

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateVolume.html

  ## Examples:
      iex> ExAws.EC2.create_volume("us-east-1")
      %ExAws.Operation.Query{action: :create_volume,
      params: %{
        "Action" => "CreateVolume",
        "AvailabilityZone" => "us-east-1",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type create_volume_opts :: [
    dry_run: boolean,
    encrypted: boolean,
    iops: integer,
    kms_key_id: binary,
    size: integer,
    snapshot_id: binary,
    tag_specifications: [tag_specification, ...],
    volume_type: binary
  ]
  @spec create_volume(availability_zone :: binary, opts :: create_volume_opts) :: ExAws.Operation.Query.t
  def create_volume(availability_zone, opts \\ []) do
    [ {"AvailabilityZone", availability_zone} | opts  ]
      |> build_request(:create_volume)
  end


  @doc """
  Deletes a specified volume

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DeleteVolume.html

  ## Examples:

      iex> ExAws.EC2.delete_volume("vol-123456")
      %ExAws.Operation.Query{action: :delete_volume,
      params: %{
        "Action" => "DeleteVolume",
        "VolumeId" => "vol-123456",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type delete_volume_opts :: [
    dry_run: boolean
  ]
  @spec delete_volume(volume_id :: binary, opts :: delete_volume_opts) :: ExAws.Operation.Query.t
  def delete_volume(volume_id, opts \\ []) do
    [ {"VolumeId", volume_id} | opts ]
    |> build_request(:delete_volume)
  end


  @doc """
  Modifies a specified volume.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ModifyVolume.html

  ## Examples:

      iex> ExAws.EC2.modify_volume("vol-123456")
      %ExAws.Operation.Query{action: :modify_volume,
      params: %{
        "Action" => "ModifyVolume",
        "VolumeId" => "vol-123456",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

      iex> ExAws.EC2.modify_volume("vol-123456", [iops: 1000, size: 300, volume_type: "io1"])
      %ExAws.Operation.Query{action: :modify_volume,
      params: %{
        "Action" => "ModifyVolume",
        "VolumeId" => "vol-123456",
        "Iops" => 1000,
        "Size" => 300,
        "VolumeType" => "io1",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type modify_volume_opts :: [
    dry_run: boolean,
    iops: integer,
    size: integer,
    volume_type: binary
  ]
  @spec modify_volume(volume_id :: binary, opts :: modify_volume_opts) :: ExAws.Operation.Query.t
  def modify_volume(volume_id, opts \\ []) do
    [ {"VolumeId", volume_id} | opts ]
    |> build_request(:modify_volume)
  end


  @doc """
  Enables I/O operations for a volume that had I/O operations disabled because
  the data on the volume was potentially inconsistent.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_EnableVolumeIO.html

  ## Examples:

        iex> ExAws.EC2.enable_volume_io("vol-123456")
        %ExAws.Operation.Query{action: :enable_volume_i_o,
        params: %{
          "Action" => "EnableVolumeIO",
          "VolumeId" => "vol-123456",
          "Version" => "2016-11-15"
        }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type enable_volume_io_opts :: [
    dry_run: boolean
  ]
  @spec enable_volume_io(volume_id :: binary) :: ExAws.Operation.Query.t
  @spec enable_volume_io(volume_id :: binary, opts :: enable_volume_io_opts) :: ExAws.Operation.Query.t
  def enable_volume_io(volume_id, opts \\ []) do
    [ {"VolumeId", volume_id} | opts ]
    |> build_request(:enable_volume_i_o) # AWS is inconsistent at this..."IO" in this case is not camelcase. "IO" needs to be uppercased.
  end


  @doc """
  Describes the specified EBS volumes.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeVolumes.html

  ## Examples:

        iex> ExAws.EC2.describe_volumes
        %ExAws.Operation.Query{action: :describe_volumes,
        params: %{
          "Action" => "DescribeVolumes",
          "Version" => "2016-11-15"
        }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

        iex> ExAws.EC2.describe_volumes([max_results: 10, next_token: "TestToken",
        ...>  volume_ids: ["vol-123456", "vol-987654"]
        ...> ])
        %ExAws.Operation.Query{action: :describe_volumes,
        params: %{
          "Action" => "DescribeVolumes",
          "MaxResults" => 10,
          "NextToken" => "TestToken",
          "VolumeId.1" => "vol-123456",
          "VolumeId.2" => "vol-987654",
          "Version" => "2016-11-15"
        }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type describe_volumes_opts :: [
    dry_run: boolean,
    filters: [filter, ...],
    max_results: integer,
    next_token: binary,
    volume_ids: [binary, ...]
  ]
  @spec describe_volumes() :: ExAws.Operation.Query.t
  @spec describe_volumes(opts :: describe_volumes_opts) :: ExAws.Operation.Query.t
  def describe_volumes(opts \\ []) do
    opts |> build_request(:describe_volumes)
  end

  @doc """
  Describes the status of the specified volumes.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeVolumeStatus.html

  ## Examples:

        iex> ExAws.EC2.describe_volume_status
        %ExAws.Operation.Query{action: :describe_volume_status,
        params: %{
          "Action" => "DescribeVolumeStatus",
          "Version" => "2016-11-15"
        }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

        iex> ExAws.EC2.describe_volume_status(
        ...> [
        ...>  filters: [
        ...>    "availability-zone": ["us-east-1d"],
        ...>    "volume-status.details-name": ["io-enabled", "test"],
        ...>    "status.details-status": ["failed"]
        ...>  ]
        ...> ])
        %ExAws.Operation.Query{action: :describe_volume_status,
        params: %{
          "Action" => "DescribeVolumeStatus",
          "Filter.1.Name" => "availability-zone",
          "Filter.1.Value.1" => "us-east-1d",
          "Filter.2.Name" => "volume-status.details-name",
          "Filter.2.Value.1" => "io-enabled",
          "Filter.2.Value.2" => "test",
          "Filter.3.Name" => "status.details-status",
          "Filter.3.Value.1" => "failed",
          "Version" => "2016-11-15"
        }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type describe_volume_status_opts :: [
    dry_run: boolean,
    filters: [filter, ...],
    max_results: integer,
    next_token: binary,
    volume_ids: [binary, ...]
 ]
 @spec describe_volume_status() :: ExAws.Operation.Query.t
 @spec describe_volume_status(opts :: describe_volume_status_opts) :: ExAws.Operation.Query.t
 def describe_volume_status(opts \\ []) do
   opts |> build_request(:describe_volume_status)
 end


 @doc """
 Modifies a volume attribute.

 Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ModifyVolumeAttribute.html

 ## Examples:

       iex> ExAws.EC2.modify_volume_attribute("vol-123456")
       %ExAws.Operation.Query{action: :modify_volume_attribute,
       params: %{
         "Action" => "ModifyVolumeAttribute",
         "VolumeId" => "vol-123456",
         "Version" => "2016-11-15"
       }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

       iex> ExAws.EC2.modify_volume_attribute("vol-123456", auto_enable_io: [value: true])
       %ExAws.Operation.Query{action: :modify_volume_attribute,
       params: %{
         "Action" => "ModifyVolumeAttribute",
         "VolumeId" => "vol-123456",
         "AutoEnableIO.Value" => true,
         "Version" => "2016-11-15"
       }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

 """
 @type modify_volume_attribute_opts :: [
    auto_enable_io: attribute_boolean_value,
    dry_run: boolean
 ]
 @spec modify_volume_attribute(volume_id :: binary) :: ExAws.Operation.Query.t
 @spec modify_volume_attribute(volume_id :: binary, opts :: modify_volume_attribute_opts) :: ExAws.Operation.Query.t
 def modify_volume_attribute(volume_id, opts \\ []) do
   [ {"VolumeId", volume_id} | opts ]
   |> build_request(:modify_volume_attribute)
 end


  @doc """
  Describes the specified attribute of the specified volume. You can specify
  only one attribute at a time.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeVolumeAttribute.html

  ## Examples:

        iex> ExAws.EC2.describe_volume_attribute("vol-123456", "description")
        %ExAws.Operation.Query{action: :describe_volume_attribute,
        params: %{
          "Action" => "DescribeVolumeAttribute",
          "VolumeId" => "vol-123456",
          "Attribute" => "description",
          "Version" => "2016-11-15"
        }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type describe_volume_attribute_opts :: [
    dry_run: boolean
  ]
  @spec describe_volume_attribute(volume_id :: binary, attribute :: binary) :: ExAws.Operation.Query.t
  @spec describe_volume_attribute(volume_id :: binary, attribute :: binary, opts :: describe_volume_attribute_opts) :: ExAws.Operation.Query.t
  def describe_volume_attribute(volume_id, attribute, opts \\ []) do
    [ {"VolumeId", volume_id}, {"Attribute", attribute} | opts ]
    |> build_request(:describe_volume_attribute)
  end


  #######################
  # Snapshot Operations #
  #######################

  @doc """
  Describes one or more of the EBS snapshots available to you.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeSnapshots.html

  ## Examples:

        iex> ExAws.EC2.describe_snapshots
        %ExAws.Operation.Query{action: :describe_snapshots,
        params: %{
          "Action" => "DescribeSnapshots",
          "Version" => "2016-11-15"
        }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

        iex> ExAws.EC2.describe_snapshots([snapshot_ids: ["snap-123456", "snap-1a2b3c", "snap-987654"]])
        %ExAws.Operation.Query{action: :describe_snapshots,
        params: %{
          "Action" => "DescribeSnapshots",
          "SnapshotId.1" => "snap-123456",
          "SnapshotId.2" => "snap-1a2b3c",
          "SnapshotId.3" => "snap-987654",
          "Version" => "2016-11-15"
        }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type describe_snapshots_opts :: [
    dry_run: boolean,
    filters: [filter, ...],
    max_results: integer,
    next_token: binary,
    owners: [binary, ...],
    restorable_by_ids: [binary, ...],
    snapshot_ids: [binary, ...]
  ]
  @spec describe_snapshots() :: ExAws.Operation.Query.t
  @spec describe_snapshots(opts :: describe_snapshots_opts) :: ExAws.Operation.Query.t
  def describe_snapshots(opts \\ []) do
    opts |> build_request(:describe_snapshots)
  end

  @doc """
  Creates a snapshot of an EBS volume and stores it in Amazon S3.
  You can use snapshots for backups, to make copies of EBS volumes, and to
  save data before shutting down an instance.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateSnapshot.html

  ## Examples:

        iex> ExAws.EC2.create_snapshot("vol-123456")
        %ExAws.Operation.Query{action: :create_snapshot,
        params: %{
          "Action" => "CreateSnapshot",
          "VolumeId" => "vol-123456",
          "Version" => "2016-11-15"
        }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

        iex> ExAws.EC2.create_snapshot("vol-123456", [description: "Test Description"])
        %ExAws.Operation.Query{action: :create_snapshot,
        params: %{
          "Action" => "CreateSnapshot",
          "VolumeId" => "vol-123456",
          "Description" => "Test Description",
          "Version" => "2016-11-15"
        }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type create_snapshot_opts :: [
    description: binary,
    dry_run: boolean
  ]
  @spec create_snapshot(volume_id :: binary) :: ExAws.Operation.Query.t
  @spec create_snapshot(volume_id :: binary, opts :: create_snapshot_opts) :: ExAws.Operation.Query.t
  def create_snapshot(volume_id, opts \\ []) do
    [ {"VolumeId", volume_id} | opts ]
    |> build_request(:create_snapshot)
  end

  @doc """
  Copies a point-in-time snapshot of an EBS volume and stores it in Amazon S3.
  You can copy the snapshot within the same region or from one region to
  another.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CopySnapshot.html

  ## Examples:

        iex> ExAws.EC2.copy_snapshot("snap-123456", "us-east-1a")
        %ExAws.Operation.Query{action: :copy_snapshot,
        params: %{
          "Action" => "CopySnapshot",
          "SourceSnapshotId" => "snap-123456",
          "SourceRegion" => "us-east-1a",
          "Version" => "2016-11-15"
        }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

        iex> ExAws.EC2.copy_snapshot("snap-123456", "us-east-1a", [description: "TestDescription", encrypted: true, kms_key_id: "TestKmsKeyId"])
        %ExAws.Operation.Query{action: :copy_snapshot,
        params: %{
          "Action" => "CopySnapshot",
          "SourceSnapshotId" => "snap-123456",
          "SourceRegion" => "us-east-1a",
          "Description" => "TestDescription",
          "Encrypted" => true,
          "KmsKeyId" => "TestKmsKeyId",
          "Version" => "2016-11-15"
        }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type copy_snapshot_opts :: [
    description: binary,
    destination_region: binary,
    dry_run: boolean,
    encrypted: boolean,
    kms_key_id: binary,
    presigned_url: binary
  ]
  @spec copy_snapshot(source_snapshot_id :: binary, source_region :: binary) :: ExAws.Operation.Query.t
  @spec copy_snapshot(source_snapshot_id :: binary, source_region :: binary, opts :: copy_snapshot_opts) :: ExAws.Operation.Query.t
  def copy_snapshot(source_snapshot_id, source_region, opts \\ []) do
    [ {"SourceSnapshotId", source_snapshot_id},
      {"SourceRegion", source_region} | opts ]
      |> build_request(:copy_snapshot)
  end

  @doc """
  Deletes the specified snapshot.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DeleteSnapshot.html

  ## Examples:

      iex> ExAws.EC2.delete_snapshot("snap-123456")
      %ExAws.Operation.Query{action: :delete_snapshot,
      params: %{
        "Action" => "DeleteSnapshot",
        "SnapshotId" => "snap-123456",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

      iex> ExAws.EC2.delete_snapshot("snap-123456", [dry_run: true])
      %ExAws.Operation.Query{action: :delete_snapshot,
      params: %{
        "Action" => "DeleteSnapshot",
        "SnapshotId" => "snap-123456",
        "DryRun" => true,
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}


  """
  @type delete_snapshot_opts :: [
    dry_run: boolean
  ]
  @spec delete_snapshot(snapshot_id :: binary) :: ExAws.Operation.Query.t
  @spec delete_snapshot(snapshot_id :: binary, opts :: delete_snapshot_opts) :: ExAws.Operation.Query.t
  def delete_snapshot(snapshot_id, opts \\ []) do
    [ {"SnapshotId", snapshot_id} | opts ]
    |> build_request(:delete_snapshot)
  end


  @doc """
  Describes the specified attribute of the specified snapshot. You can specify
  only one attribute at a time.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeSnapshotAttribute.html

  ## Examples:

      iex> ExAws.EC2.describe_snapshot_attribute("snap-123456", "description")
      %ExAws.Operation.Query{action: :describe_snapshot_attribute,
      params: %{
        "Action" => "DescribeSnapshotAttribute",
        "SnapshotId" => "snap-123456",
        "Attribute" => "description",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type describe_snapshot_attribute_opts :: [
    dry_run: boolean
  ]
  @spec describe_snapshot_attribute(snapshot_id :: binary, attribute :: binary) :: ExAws.Operation.Query.t
  @spec describe_snapshot_attribute(snapshot_id :: binary, attribute :: binary, opts :: describe_snapshot_attribute_opts) :: ExAws.Operation.Query.t
  def describe_snapshot_attribute(snapshot_id, attribute, opts \\ []) do
    [ {"SnapshotId", snapshot_id},
      {"Attribute", attribute} | opts ]
      |> build_request(:describe_snapshot_attribute)
  end

  @doc """
  Adds or removes permission settings for the specified snapshot.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ModifySnapshotAttribute.html

  ## Examples:

      iex> ExAws.EC2.modify_snapshot_attribute("snap-123456")
      %ExAws.Operation.Query{action: :modify_snapshot_attribute,
      params: %{
        "Action" => "ModifySnapshotAttribute",
        "SnapshotId" => "snap-123456",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

      iex> ExAws.EC2.modify_snapshot_attribute("snap-123456", [attribute: "description"])
      %ExAws.Operation.Query{action: :modify_snapshot_attribute,
      params: %{
        "Action" => "ModifySnapshotAttribute",
        "SnapshotId" => "snap-123456",
        "Attribute" => "description",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type modify_snapshot_attribute_opts :: [
    attribute: binary,
    create_volume_permission: permission_modifications,
    dry_run: boolean,
    user_groups: [binary, ...],
    user_ids: [binary, ...]
  ]
  @spec modify_snapshot_attribute(snapshot_id :: binary) :: ExAws.Operation.Query.t
  @spec modify_snapshot_attribute(snapshot_id :: binary, opts :: modify_snapshot_attribute_opts) :: ExAws.Operation.Query.t
  def modify_snapshot_attribute(snapshot_id, opts \\ []) do
    [ {"SnapshotId", snapshot_id} | opts ]
    |> build_request(:modify_snapshot_attribute)
  end

  @doc """
  Resets permission settings for the specified snapshot.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ResetSnapshotAttribute.html

  ## Examples:

        iex> ExAws.EC2.reset_snapshot_attribute("snap-123456", "description")
        %ExAws.Operation.Query{action: :reset_snapshot_attribute,
        params: %{
          "Action" => "ResetSnapshotAttribute",
          "SnapshotId" => "snap-123456",
          "Attribute" => "description",
          "Version" => "2016-11-15"
        }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

        iex> ExAws.EC2.reset_snapshot_attribute("snap-123456", "description", [dry_run: true])
        %ExAws.Operation.Query{action: :reset_snapshot_attribute,
        params: %{
          "Action" => "ResetSnapshotAttribute",
          "SnapshotId" => "snap-123456",
          "Attribute" => "description",
          "DryRun" => true,
          "Version" => "2016-11-15"
        }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type reset_snapshot_attribute_opts :: [
    dry_run: boolean
  ]
  @spec reset_snapshot_attribute(snapshot_id :: binary, attribute :: binary) :: ExAws.Operation.Query.t
  @spec reset_snapshot_attribute(snapshot_id :: binary, attribute :: binary, opts :: reset_snapshot_attribute_opts) :: ExAws.Operation.Query.t
  def reset_snapshot_attribute(snapshot_id, attribute, opts \\ []) do
    [ {"SnapshotId", snapshot_id},
      {"Attribute", attribute} | opts ]
      |> build_request(:reset_snapshot_attribute)
  end


  ############################
  ### Bundle Tasks Actions ###
  ############################

  @doc """
  Bundles an Amazon instance store-backed Windows instance.
  During bundling, only the root device volume (C:\) is bundled. Data on other
  instance store volumes is not preserved.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_BundleInstance.html

  ## Examples:

      iex> ExAws.EC2.bundle_instance("i-123456", "TestS3AccessKeyId", "TestS3Bucket", "TestS3Prefix", "TestS3UploadPolicy", "TestS3UploadPolicySig")
      %ExAws.Operation.Query{action: :bundle_instance,
      params: %{
        "Action" => "BundleInstance",
        "InstanceId" => "i-123456",
        "Storage.S3.AWSAccessKeyId" => "TestS3AccessKeyId",
        "Storage.S3.Bucket" => "TestS3Bucket",
        "Storage.S3.Prefix" => "TestS3Prefix",
        "Storage.S3.UploadPolicy" => "TestS3UploadPolicy",
        "Storage.S3.UploadPolicySignature" => "TestS3UploadPolicySig",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}


  """
  @type bundle_instance_opts :: [
    dry_run: boolean
  ]
  @spec bundle_instance(instance_id :: binary, s3_aws_access_key_id :: binary, s3_bucket :: binary, s3_prefix :: binary, s3_upload_policy :: binary, s3_upload_policy_signature :: binary) :: ExAws.Operation.Query.t
  @spec bundle_instance(instance_id :: binary, s3_aws_access_key_id :: binary, s3_bucket :: binary, s3_prefix :: binary, s3_upload_policy :: binary, s3_upload_policy_signature :: binary, opts :: bundle_instance_opts) :: ExAws.Operation.Query.t
  def bundle_instance(instance_id, s3_aws_access_key_id, s3_bucket, s3_prefix, s3_upload_policy, s3_upload_policy_signature, opts \\ []) do
    [ {"InstanceId", instance_id},
      {"Storage.S3.AWSAccessKeyId", s3_aws_access_key_id},
      {"Storage.S3.Bucket", s3_bucket},
      {"Storage.S3.Prefix", s3_prefix},
      {"Storage.S3.UploadPolicy", s3_upload_policy},
      {"Storage.S3.UploadPolicySignature", s3_upload_policy_signature} | opts]
      |> build_request(:bundle_instance)
  end

  @doc """
  Cancels a bundling operation for an instance store-backed Windows instance.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CancelBundleTask.html

  ## Examples:

        iex> ExAws.EC2.cancel_bundle_task("TestBundleId")
        %ExAws.Operation.Query{action: :cancel_bundle_task,
        params: %{
          "Action" => "CancelBundleTask",
          "BundleId" => "TestBundleId",
          "Version" => "2016-11-15"
        }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

        iex> ExAws.EC2.cancel_bundle_task("bun-c1a540a8", [dry_run: true])
        %ExAws.Operation.Query{action: :cancel_bundle_task,
        params: %{
          "Action" => "CancelBundleTask",
          "BundleId" => "bun-c1a540a8",
          "DryRun" => true,
          "Version" => "2016-11-15"
        }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type cancel_bundle_task_opts :: [
    dry_run: boolean
  ]
  @spec cancel_bundle_task(bundle_id :: binary) :: ExAws.Operation.Query.t
  @spec cancel_bundle_task(bundle_id :: binary, opts :: cancel_bundle_task_opts) :: ExAws.Operation.Query.t
  def cancel_bundle_task(bundle_id, opts \\ []) do
    [ {"BundleId", bundle_id} | opts ]
    |> build_request(:cancel_bundle_task)
  end


  @doc """
  Describes one or more of your bundling tasks.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeBundleTasks.html

  ## Examples:

        iex> ExAws.EC2.describe_bundle_tasks
        %ExAws.Operation.Query{action: :describe_bundle_tasks,
        params: %{
          "Action" => "DescribeBundleTasks",
          "Version" => "2016-11-15"
        }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

        iex> ExAws.EC2.describe_bundle_tasks([bundle_ids: ["bun-123456", "bun-1a2b3c"]])
        %ExAws.Operation.Query{action: :describe_bundle_tasks,
        params: %{
          "Action" => "DescribeBundleTasks",
          "BundleId.1" => "bun-123456",
          "BundleId.2" => "bun-1a2b3c",
          "Version" => "2016-11-15"
        }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type describe_bundle_tasks_opts :: [
    bundle_ids: [binary, ...],
    dry_run: boolean,
    filters: [filter, ...]
  ]
  @spec describe_bundle_tasks() :: ExAws.Operation.Query.t
  @spec describe_bundle_tasks(opts :: describe_bundle_tasks_opts) :: ExAws.Operation.Query.t
  def describe_bundle_tasks(opts \\ []) do
    opts |> build_request(:describe_bundle_tasks)
  end

  ###################
  # Tags Operations #
  ###################

  @doc """
  Describes one or more of the tags for your EC2 resources.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeTags.html
  NOTE: If you need to pass in filters, pay special attention to what is allowed to be
  passed in in the doc.

  ## Examples:

        iex> ExAws.EC2.describe_tags
        %ExAws.Operation.Query{action: :describe_tags,
        params: %{
          "Action" => "DescribeTags",
          "Version" => "2016-11-15"
        }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

        iex> ExAws.EC2.describe_tags([filters: ["resource-type": ["instance", "snapshot"]]])
        %ExAws.Operation.Query{action: :describe_tags,
        params: %{
          "Action" => "DescribeTags",
          "Filter.1.Name" => "resource-type",
          "Filter.1.Value.1" => "instance",
          "Filter.1.Value.2" => "snapshot",
          "Version" => "2016-11-15"
        }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type describe_tags_opts :: [
    dry_run: boolean,
    filters: [filter, ...],
    max_results: integer,
    next_token: binary
  ]
  @spec describe_tags() :: ExAws.Operation.Query.t
  @spec describe_tags(opts :: describe_tags_opts) :: ExAws.Operation.Query.t
  def describe_tags(opts \\ []) do
    opts |> build_request(:describe_tags)
  end

  @doc """
  Adds or overwrites one or more tags for the specified Amazon EC2 resource or
  resources. Each resource can have a maximum of 10 tags. Each tag consists of
  a key and optional value. Tag keys must be unique per resource.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateTags.html

  ## Examples:

      iex> ExAws.EC2.create_tags(["i-123456", "snap-123456"], ["automation": "test", "owner": "TestOwner"])
      %ExAws.Operation.Query{action: :create_tags,
      params: %{
        "Action" => "CreateTags",
        "ResourceId.1" => "i-123456",
        "ResourceId.2" => "snap-123456",
        "Tag.1.Key" => "automation",
        "Tag.1.Value" => "test",
        "Tag.2.Key" => "owner",
        "Tag.2.Value" => "TestOwner",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type create_tags_opts :: [
    dry_run: boolean
  ]
  @spec create_tags(resource_ids :: [binary, ...], tags :: [tag, ...]) :: ExAws.Operation.Query.t
  @spec create_tags(resource_ids :: [binary, ...], tags :: [tag, ...], opts :: create_tags_opts) :: ExAws.Operation.Query.t
  def create_tags(resource_ids, tags, opts \\ []) do
    [ {:resource_ids, resource_ids},
      {:tags, tags} | opts ]
    |> build_request(:create_tags)
  end

  @doc """
  Deletes the specified set of tags from the specified set of resources.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DeleteTags.html

  ## Examples:

      iex> ExAws.EC2.delete_tags(["i-123456", "snap-123456"])
      %ExAws.Operation.Query{action: :delete_tags,
      params: %{
        "Action" => "DeleteTags",
        "ResourceId.1" => "i-123456",
        "ResourceId.2" => "snap-123456",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

      iex> ExAws.EC2.delete_tags(["i-123456", "snap-123456"], [tags: ["name": "Test", "owner": "TestOwner"]])
      %ExAws.Operation.Query{action: :delete_tags,
      params: %{
        "Action" => "DeleteTags",
        "ResourceId.1" => "i-123456",
        "ResourceId.2" => "snap-123456",
        "Tag.1.Key" => "name",
        "Tag.1.Value" => "Test",
        "Tag.2.Key" => "owner",
        "Tag.2.Value" => "TestOwner",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type delete_tags_opts :: [
    dry_run: boolean,
    tags: [tag, ...]
  ]
  @spec delete_tags(resource_ids :: [binary, ...]) :: ExAws.Operation.Query.t
  @spec delete_tags(resource_ids :: [binary, ...], opts :: delete_tags_opts) :: ExAws.Operation.Query.t
  def delete_tags(resource_ids, opts \\ []) do
    [ {:resource_ids, resource_ids} | opts ]
    |> build_request(:delete_tags)
  end


  #############################################
  # Regions and Availability Zones Operations #
  #############################################

  @doc """
  Describes one or more of the Availability Zones that are available to you.
  The results include zones only for the region you're currently using.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeAvailabilityZones.html

  ## Examples:

        iex> ExAws.EC2.describe_availability_zones
        %ExAws.Operation.Query{action: :describe_availability_zones,
        params: %{
          "Action" => "DescribeAvailabilityZones",
          "Version" => "2016-11-15"
        }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type describe_availability_zones_opts :: [
    dry_run: boolean,
    zone_names: [binary, ...],
    filters: [filter, ...]
  ]
  @spec describe_availability_zones() :: ExAws.Operation.Query.t
  @spec describe_availability_zones(opts :: describe_availability_zones_opts) :: ExAws.Operation.Query.t
  def describe_availability_zones(opts \\ []) do
    opts |> build_request(:describe_availability_zones)
  end


  @doc """
  Describes one or more regions that are currently available to you.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeRegions.html

  ## Examples:

        iex> ExAws.EC2.describe_regions
        %ExAws.Operation.Query{action: :describe_regions,
        params: %{
          "Action" => "DescribeRegions",
          "Version" => "2016-11-15"
        }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

        iex> ExAws.EC2.describe_regions([region_names: ["us-east-1", "eu-west-1"]])
        %ExAws.Operation.Query{action: :describe_regions,
        params: %{
          "Action" => "DescribeRegions",
          "RegionName.1" => "us-east-1",
          "RegionName.2" => "eu-west-1",
          "Version" => "2016-11-15"
        }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type describe_regions_opts :: [
    dry_run: boolean,
    filters: [filter, ...],
    region_names: [binary, ...]
  ]
  @spec describe_regions() :: ExAws.Operation.Query.t
  @spec describe_regions(opts :: describe_regions_opts) :: ExAws.Operation.Query.t
  def describe_regions(opts \\ []) do
    opts |> build_request(:describe_regions)
  end

  ###########################
  # Resource ID Operatioons #
  ###########################

  @doc """
  Describes the ID format settings for your resources on a per-region basis,
  for example, to view which resource types are enabled for longer IDs.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeIdFormat.html

  ## Examples:

      iex> ExAws.EC2.describe_id_format
      %ExAws.Operation.Query{action: :describe_id_format,
      params: %{
        "Action" => "DescribeIdFormat",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

      iex> ExAws.EC2.describe_id_format([resource: "instance"])
      %ExAws.Operation.Query{action: :describe_id_format,
      params: %{
        "Action" => "DescribeIdFormat",
        "Resource" => "instance",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type describe_id_format_opts :: [
    resource: binary
  ]
  @spec describe_id_format() :: ExAws.Operation.Query.t
  @spec describe_id_format(opts :: describe_id_format_opts) :: ExAws.Operation.Query.t
  def describe_id_format(opts \\ []) do
    opts |> build_request(:describe_id_format)
  end

  @doc """
  Modifies the ID format for the specified resource on a per-region basis.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ModifyIdFormat.html
  ## Examples:

      iex> ExAws.EC2.modify_id_format("instance", true)
      %ExAws.Operation.Query{action: :modify_id_format,
      params: %{
        "Action" => "ModifyIdFormat",
        "Resource" => "instance",
        "UseLongIds" => true,
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @spec modify_id_format(resource :: binary, use_long_ids :: boolean) :: ExAws.Operation.Query.t
  def modify_id_format(resource, use_long_ids) do
    [ {"Resource", resource},
      {"UseLongIds", use_long_ids} ]
    |> build_request(:modify_id_format)
  end

  #################################
  # Account Attributes Operations #
  #################################

  @doc """
  Describes attributes of your AWS account.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeAccountAttributes.html
  ## Examples:

      iex> ExAws.EC2.describe_account_attributes
      %ExAws.Operation.Query{action: :describe_account_attributes,
      params: %{
        "Action" => "DescribeAccountAttributes",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

      iex> ExAws.EC2.describe_account_attributes([attribute_names: ["supported-platforms", "default-vpc"], dry_run: true])
      %ExAws.Operation.Query{action: :describe_account_attributes,
      params: %{
        "Action" => "DescribeAccountAttributes",
        "AttributeName.1" => "supported-platforms",
        "AttributeName.2" => "default-vpc",
        "DryRun" => true,
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type describe_account_attributes_opts :: [
    attribute_names: [binary, ...],
    dry_run: boolean
  ]
  @spec describe_account_attributes() :: ExAws.Operation.Query.t
  @spec describe_account_attributes(opts :: describe_account_attributes_opts) :: ExAws.Operation.Query.t
  def describe_account_attributes(opts \\ []) do
    opts |> build_request(:describe_account_attributes)
  end

  ####################
  ### VPCs Actions ###
  ####################

  @doc """
  Describes one or more of your VPCs.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeVpcs.html
  ## Examples:

      iex> ExAws.EC2.describe_vpcs
      %ExAws.Operation.Query{action: :describe_vpcs,
      params: %{
        "Action" => "DescribeVpcs",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

      iex> ExAws.EC2.describe_vpcs(vpc_ids: ["vpc-1a2b3c4d", "vpc-5e6f7g8h"])
      %ExAws.Operation.Query{action: :describe_vpcs,
      params: %{
        "Action" => "DescribeVpcs",
        "VpcId.1" => "vpc-1a2b3c4d",
        "VpcId.2" => "vpc-5e6f7g8h",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type describe_vpcs_opts :: [
    dry_run: boolean,
    filters: [filter, ...],
    vpc_ids: [binary, ...]
  ]
  @spec describe_vpcs() :: ExAws.Operation.Query.t
  @spec describe_vpcs(opts :: describe_vpcs_opts) :: ExAws.Operation.Query.t
  def describe_vpcs(opts \\ []) do
    opts |> build_request(:describe_vpcs)
  end

  @doc """
  Creates a VPC with the specified CIDR block.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateVpc.html
  ## Examples:

        iex> ExAws.EC2.create_vpc("10.32.0.0/16", [instance_tenancy: "dedicated"])
        %ExAws.Operation.Query{action: :create_vpc,
        params: %{
          "Action" => "CreateVpc",
          "CidrBlock" => "10.32.0.0/16",
          "InstanceTenancy" => "dedicated",
          "Version" => "2016-11-15"
        }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type create_vpc_opts :: [
    dry_run: boolean,
    instance_tenancy: binary,
    amazon_provided_ipv6_cidr_block: boolean
  ]
  @spec create_vpc(cidr_block :: binary) :: ExAws.Operation.Query.t
  @spec create_vpc(cidr_block :: binary, opts :: create_vpc_opts) :: ExAws.Operation.Query.t
  def create_vpc(cidr_block, opts \\ []) do
    [ {"CidrBlock", cidr_block} | opts ]
    |> build_request(:create_vpc)
  end


  @doc """
  Deletes the specified VPC.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DeleteVpc.html
  ## Examples:

      iex> ExAws.EC2.delete_vpc("vpc-123456", [dry_run: true])
      %ExAws.Operation.Query{action: :delete_vpc,
      params: %{
        "Action" => "DeleteVpc",
        "VpcId" => "vpc-123456",
        "DryRun" => true,
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type delete_vpc_opts :: [
    dry_run: boolean
  ]
  @spec delete_vpc(vpc_id :: binary) :: ExAws.Operation.Query.t
  @spec delete_vpc(vpc_id :: binary, opts :: delete_vpc_opts) :: ExAws.Operation.Query.t
  def delete_vpc(vpc_id, opts \\ []) do
    [ {"VpcId", vpc_id} | opts ]
    |> build_request(:delete_vpc)
  end


  @doc """
  Describes the specified attribute of the specified VPC. You can specify only one attribute at a time.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeVpcAttribute.html
  ## Examples:

      iex> ExAws.EC2.describe_vpc_attribute("vpc-123456", "enableDnsSupport", [dry_run: true])
      %ExAws.Operation.Query{action: :describe_vpc_attribute,
      params: %{
        "Action" => "DescribeVpcAttribute",
        "Attribute" => "enableDnsSupport",
        "VpcId" => "vpc-123456",
        "DryRun" => true,
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type describe_vpc_attribute_opts :: [
    dry_run: boolean
  ]
  @spec describe_vpc_attribute(vpc_id :: binary, attribute :: binary) :: ExAws.Operation.Query.t
  @spec describe_vpc_attribute(vpc_id :: binary, attribute :: binary, opts :: describe_vpc_attribute_opts) :: ExAws.Operation.Query.t
  def describe_vpc_attribute(vpc_id, attribute, opts \\ []) do
    [ {"VpcId", vpc_id},
      {"Attribute", attribute}| opts ]
    |> build_request(:describe_vpc_attribute)
  end


  @doc """
  Modifies the specified attribute of the specified VPC.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ModifyVpcAttribute.html
  ## Examples:

        iex> ExAws.EC2.modify_vpc_attribute("vpc-123456", ["enable_dns_support": true])
        %ExAws.Operation.Query{action: :modify_vpc_attribute,
        params: %{
          "Action" => "ModifyVpcAttribute",
          "VpcId" => "vpc-123456",
          "EnableDnsSupport.Value" => true,
          "Version" => "2016-11-15"
        }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type modify_vpc_attribute_opts :: [
    enable_dns_hostnames: boolean,
    enable_dns_support: boolean
  ]
  @spec modify_vpc_attribute(vpc_id :: binary) :: ExAws.Operation.Query.t
  @spec modify_vpc_attribute(vpc_id :: binary, opts :: modify_vpc_attribute_opts) :: ExAws.Operation.Query.t
  def modify_vpc_attribute(vpc_id, opts \\ []) do
    [ {"VpcId", vpc_id} | opts ]
    |> build_request(:modify_vpc_attribute)
  end

  ######################
  # Subnets Operations #
  ######################

  @doc """
  Describes one or more of your subnets.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeSubnets.html
  ## Examples:

        iex> ExAws.EC2.describe_subnets([subnet_ids: ["subnet-9d4a7b6c", "subnet-6e7f829e"]])
        %ExAws.Operation.Query{action: :describe_subnets,
        params: %{
          "Action" => "DescribeSubnets",
          "SubnetId.1" => "subnet-9d4a7b6c",
          "SubnetId.2" => "subnet-6e7f829e",
          "Version" => "2016-11-15"
        }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

        iex> ExAws.EC2.describe_subnets(filters: ["vpc-id": ["vpc-1a2b3c4d", "vpc-6e7f8a92"], "state": ["available"]])
        %ExAws.Operation.Query{action: :describe_subnets,
        params: %{
          "Action" => "DescribeSubnets",
          "Filter.1.Name" => "vpc-id",
          "Filter.1.Value.1" => "vpc-1a2b3c4d",
          "Filter.1.Value.2" => "vpc-6e7f8a92",
          "Filter.2.Name" => "state",
          "Filter.2.Value.1" => "available",
          "Version" => "2016-11-15"
        }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type describe_subnets_opts :: [
    dry_run: boolean,
    filters: [filter, ...],
    subnet_ids: [binary, ...]
  ]
  @spec describe_subnets() :: ExAws.Operation.Query.t
  @spec describe_subnets(opts :: describe_subnets_opts) :: ExAws.Operation.Query.t
  def describe_subnets(opts \\ []) do
    opts |> build_request(:describe_subnets)
  end

  @doc """
  Creates a subnet in an existing VPC.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateSubnet.html

  ## Examples:

        iex> ExAws.EC2.create_subnet("vpc-1a2b3c4d", "10.0.1.0/24", [ipv6_cidr_block: "2001:db8:1234:1a00::/64"])
        %ExAws.Operation.Query{action: :create_subnet,
        params: %{
          "Action" => "CreateSubnet",
          "VpcId" => "vpc-1a2b3c4d",
          "CidrBlock" => "10.0.1.0/24",
          "Ipv6CidrBlock" => "2001:db8:1234:1a00::/64",
          "Version" => "2016-11-15"
        }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type create_subnet_opts :: [
    availability_zone: binary,
    dry_run: boolean,
    ipv6_cidr_block: binary
  ]
  @spec create_subnet(vpc_id :: binary, cidr_block :: binary) :: ExAws.Operation.Query.t
  @spec create_subnet(vpc_id :: binary, cidr_block :: binary, opts :: create_subnet_opts) :: ExAws.Operation.Query.t
  def create_subnet(vpc_id, cidr_block, opts \\ []) do
    [ {"VpcId", vpc_id},
      {"CidrBlock", cidr_block} | opts ]
    |> build_request(:create_subnet)
  end

  @doc """
  Deletes the specified subnet.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DeleteSubnet.html
  ## Examples:

      iex> ExAws.EC2.delete_subnet("subnet-9d4a7b6c", [dry_run: true])
      %ExAws.Operation.Query{action: :delete_subnet,
      params: %{
        "Action" => "DeleteSubnet",
        "SubnetId" => "subnet-9d4a7b6c",
        "DryRun" => true,
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type delete_subnet_opts :: [
    dry_run: boolean
  ]
  @spec delete_subnet(subnet_id :: binary) :: ExAws.Operation.Query.t
  @spec delete_subnet(subnet_id :: binary, opts :: delete_subnet_opts) :: ExAws.Operation.Query.t
  def delete_subnet(subnet_id, opts \\ []) do
    [ {"SubnetId", subnet_id} | opts ]
    |> build_request(:delete_subnet)
  end

  @doc """
  Modifies a subnet attribute.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ModifySubnetAttribute.html
  ## Examples:

      iex> ExAws.EC2.modify_subnet_attribute("subnet-9d4a7b6c", [dry_run: true])
      %ExAws.Operation.Query{action: :modify_subnet_attribute,
      params: %{
        "Action" => "ModifySubnetAttribute",
        "SubnetId" => "subnet-9d4a7b6c",
        "DryRun" => true,
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type modify_subnet_attribute_opts :: [
    map_public_ip_on_launch: boolean,
    assign_ipv6_address_on_creation: boolean
  ]
  @spec modify_subnet_attribute(subnet_id :: binary) :: ExAws.Operation.Query.t
  @spec modify_subnet_attribute(subnet_id :: binary, opts :: modify_subnet_attribute_opts) :: ExAws.Operation.Query.t
  def modify_subnet_attribute(subnet_id, opts \\ []) do
    [ {"SubnetId", subnet_id} | opts ]
    |> build_request(:modify_subnet_attribute)
  end

  ########################
  # Key Pairs Operations #
  ########################

  @doc """
  Describes one or more of your key pairs.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeKeyPairs.html
  ## Examples:

      iex> ExAws.EC2.describe_key_pairs
      %ExAws.Operation.Query{action: :describe_key_pairs,
      params: %{
        "Action" => "DescribeKeyPairs",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

      iex> ExAws.EC2.describe_key_pairs([key_names: ["my-key-pair", "test-key-pair"]])
      %ExAws.Operation.Query{action: :describe_key_pairs,
      params: %{
        "Action" => "DescribeKeyPairs",
        "KeyName.1" => "my-key-pair",
        "KeyName.2" => "test-key-pair",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}


  """
  @type describe_key_pairs_opts :: [
    dry_run: boolean,
    filters: [filter, ...],
    key_names: [binary, ...]
  ]
  @spec describe_key_pairs() :: ExAws.Operation.Query.t
  @spec describe_key_pairs(opts :: describe_key_pairs_opts) :: ExAws.Operation.Query.t
  def describe_key_pairs(opts \\ []) do
    opts |> build_request(:describe_key_pairs)
  end

  @doc """
  Creates a 2048-bit RSA key pair with the specified name. Amazon EC2 stores
  the public key and displays the private key for you to save to a file.
  The private key is returned as an unencrypted PEM encoded PKCS#8 private key.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateKeyPair.html

  ## Examples:

      iex> ExAws.EC2.create_key_pair("my-key-pair", [dry_run: true])
      %ExAws.Operation.Query{action: :create_key_pair,
      params: %{
        "Action" => "CreateKeyPair",
        "KeyName" => "my-key-pair",
        "DryRun" => true,
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type create_key_pair_opts :: [
    dry_run: boolean
  ]
  @spec create_key_pair(key_name :: binary) :: ExAws.Operation.Query.t
  @spec create_key_pair(key_name :: binary, opts :: create_key_pair_opts) :: ExAws.Operation.Query.t
  def create_key_pair(key_name, opts \\ []) do
    [ {"KeyName", key_name} | opts ]
    |> build_request(:create_key_pair)
  end

  @doc """
  Deletes the specified key pair, by removing the public key from Amazon EC2.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DeleteKeyPair.html
  ## Examples:

      iex> ExAws.EC2.create_key_pair("my-key-pair", [dry_run: true])
      %ExAws.Operation.Query{action: :create_key_pair,
      params: %{
        "Action" => "CreateKeyPair",
        "KeyName" => "my-key-pair",
        "DryRun" => true,
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type delete_key_pair_opts :: [
    dry_run: boolean
  ]
  @spec delete_key_pair(key_name :: binary) :: ExAws.Operation.Query.t
  @spec delete_key_pair(key_name :: binary, opts :: delete_key_pair_opts) :: ExAws.Operation.Query.t
  def delete_key_pair(key_name, opts \\ []) do
    [ {"KeyName", key_name} | opts ]
    |> build_request(:delete_key_pair)
  end

  @doc """
  Imports the public key from an RSA key pair that you created with a
  third-party tool.

  NOTE: public_key_material is base64-encoded binary data object.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ImportKeyPair.html
  ## Examples:

      iex> ExAws.EC2.import_key_pair("my-key-pair", "Base64PublicKeyMaterial")
      %ExAws.Operation.Query{action: :import_key_pair,
      params: %{
        "Action" => "ImportKeyPair",
        "KeyName" => "my-key-pair",
        "PublicKeyMaterial" => "Base64PublicKeyMaterial",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type import_key_pair_opts :: [
    dry_run: boolean
  ]
  @spec import_key_pair(key_name :: binary, public_key_material :: binary) :: ExAws.Operation.Query.t
  @spec import_key_pair(key_name :: binary, public_key_material :: binary, opts :: import_key_pair_opts) :: ExAws.Operation.Query.t
  def import_key_pair(key_name, public_key_material, opts \\ []) do
    [ {"KeyName", key_name},
      {"PublicKeyMaterial", public_key_material} | opts]
    |> build_request(:import_key_pair)
  end

  ##############################
  # Security Groups Operations #
  ##############################

  @doc """
  Describes one or more of your security groups.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeSecurityGroups.html

  ## Examples:

        iex> ExAws.EC2.describe_security_groups
        %ExAws.Operation.Query{action: :describe_security_groups,
        params: %{
          "Action" => "DescribeSecurityGroups",
          "Version" => "2016-11-15"
        }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

        iex> ExAws.EC2.describe_security_groups([filters: ["ip.permission.protocol": ["tcp"], "ip-permission.group_name": ["app_server_group", "database_group"]]])
        %ExAws.Operation.Query{action: :describe_security_groups,
        params: %{
          "Action" => "DescribeSecurityGroups",
          "Filter.1.Name" => "ip.permission.protocol",
          "Filter.1.Value.1" => "tcp",
          "Filter.2.Name" => "ip-permission.group_name",
          "Filter.2.Value.1" => "app_server_group",
          "Filter.2.Value.2" => "database_group",
          "Version" => "2016-11-15"
        }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type describe_security_groups_opts :: [
    dry_run: boolean,
    filters: [filter, ...],
    group_ids: [binary, ...],
    group_names: [binary, ...]
  ]
  @spec describe_security_groups() :: ExAws.Operation.Query.t
  @spec describe_security_groups(opts :: describe_security_groups_opts) :: ExAws.Operation.Query.t
  def describe_security_groups(opts \\ []) do
    opts |> build_request(:describe_security_groups)
  end

  @doc """
  Creates a security group.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateSecurityGroup.html

  ## Examples:

      iex> ExAws.EC2.create_security_group("websrv", "Web Servers")
      %ExAws.Operation.Query{action: :create_security_group,
      params: %{
        "Action" => "CreateSecurityGroup",
        "GroupName" => "websrv",
        "GroupDescription" => "Web Servers",
        "Version" => "2016-11-15"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type create_security_group_opts :: [
    dry_run: boolean,
    vpc_id: binary
  ]
  @spec create_security_group(group_name :: binary, group_description :: binary) :: ExAws.Operation.Query.t
  @spec create_security_group(group_name :: binary, group_description :: binary, opts :: create_security_group_opts) :: ExAws.Operation.Query.t
  def create_security_group(group_name, group_description, opts \\ []) do
      [ {"GroupName", group_name},
        {"GroupDescription", group_description} | opts ]
      |> build_request(:create_security_group)
  end


  @doc """
  Adds one or more ingress rules to a security group.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_AuthorizeSecurityGroupIngress.html

  ## Examples:

        iex> ExAws.EC2.authorize_security_group_ingress([group_id: "sg-1a2b3c4d",
        ...>  ip_permissions: [
        ...>    [ip_protocol: "tcp", from_port: 22, to_port: 22, ipv6_ranges: [
        ...>      [cidr_ipv6: "2001:db8:1234:1a00::/64"]
        ...>    ]]
        ...>  ]
        ...> ])
        %ExAws.Operation.Query{action: :authorize_security_group_ingress,
        params: %{
          "Action" => "AuthorizeSecurityGroupIngress",
          "GroupId" => "sg-1a2b3c4d",
          "IpPermissions.1.IpProtocol" => "tcp",
          "IpPermissions.1.FromPort" => 22,
          "IpPermissions.1.ToPort" => 22,
          "IpPermissions.1.Ipv6Ranges.1.CidrIpv6" => "2001:db8:1234:1a00::/64",
          "Version" => "2016-11-15"
        }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type user_id_group_pair :: [
    group_id: binary,
    group_name: binary,
    peering_status: binary,
    user_id: binary,
    vpc_id: binary,
    vpc_peering_connection_id: binary
  ]
  @type ip_range :: [
    cidr_ip: binary
  ]
  @type ipv6_range :: [
    cidr_ipv6: binary
  ]
  @type prefix_list_id :: [
    prefix_list_id: binary
  ]
  @type ip_permission :: [
    from_port: integer,
    user_id_group_pairs: [user_id_group_pair, ...],
    ip_protocol: binary,
    ip_ranges: [ip_range, ...],
    ipv6_ranges: [ipv6_range, ...],
    prefix_list_ids: [prefix_list_id, ...],
    to_port: integer
  ]
  @type authorize_security_group_ingress_opts :: [
    cidr_ip: binary,
    dry_run: boolean,
    from_port: integer,
    group_id: binary,
    group_name: binary,
    ip_permissions: [ip_permission, ...],
    ip_protocol: binary,
    source_security_group_name: binary,
    source_security_group_owner_id: binary,
    to_port: integer
  ]
  @spec authorize_security_group_ingress() :: ExAws.Operation.Query.t
  @spec authorize_security_group_ingress(opts :: authorize_security_group_ingress_opts) :: ExAws.Operation.Query.t
  def authorize_security_group_ingress(opts \\ []) do
    opts |> build_request(:authorize_security_group_ingress)
  end


  @doc """
  Adds one or more egress rules to a security group for use with a VPC.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_AuthorizeSecurityGroupEgress.html

  ## Examples:

        iex> ExAws.EC2.authorize_security_group_egress("sg-1a2b3c4d", [group_name: "websrv",
        ...> ip_permissions: [
        ...>  [ip_protocol: "tcp", from_port: 1433, to_port: 1433, user_id_group_pairs: [
        ...>    [group_id: "sg-9a8d7f5c", group_name: "test"],
        ...>    [group_name: "blah"]
        ...>  ]],
        ...>  [ip_protocol: "udp", from_port: 1234]
        ...> ]])
        %ExAws.Operation.Query{action: :authorize_security_group_egress,
        params: %{
          "Action" => "AuthorizeSecurityGroupEgress",
          "GroupId" => "sg-1a2b3c4d",
          "GroupName" => "websrv",
          "IpPermissions.1.IpProtocol" => "tcp",
          "IpPermissions.1.FromPort" => 1433,
          "IpPermissions.1.ToPort" => 1433,
          "IpPermissions.1.UserIdGroupPairs.1.GroupId" => "sg-9a8d7f5c",
          "IpPermissions.1.UserIdGroupPairs.1.GroupName" => "test",
          "IpPermissions.1.UserIdGroupPairs.2.GroupName" => "blah",
          "IpPermissions.2.IpProtocol" => "udp",
          "IpPermissions.2.FromPort" => 1234,
          "Version" => "2016-11-15"
        }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}

  """
  @type authorize_security_group_egress_opts :: [
    cidr_ip: binary,
    dry_run: boolean,
    from_port: integer,
    ip_permissions: [ip_permission, ...],
    ip_protocol: binary,
    source_security_group_name: binary,
    source_security_group_owner_id: binary,
    to_port: integer
  ]
  @spec authorize_security_group_egress(group_id :: binary) :: ExAws.Operation.Query.t
  @spec authorize_security_group_egress(group_id :: binary, opts :: authorize_security_group_egress_opts) :: ExAws.Operation.Query.t
  def authorize_security_group_egress(group_id, opts \\ []) do
    [ {"GroupId", group_id} | opts ]
    |> build_request(:authorize_security_group_egress)
  end


  @doc """
  Removes one or more ingress rules from a security group. The values that
  you specify in the revoke request (for example, ports) must match
  the existing rule's values for the rule to be removed.

  Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_RevokeSecurityGroupIngress.html

  ## Examples:

        iex> ExAws.EC2.revoke_security_group_ingress([ip_protocol: "tcp",
        ...> source_security_group_name: "websrv", source_security_group_owner_id: "test_id"])
        %ExAws.Operation.Query{action: :revoke_security_group_ingress,
        params: %{
          "Action" => "RevokeSecurityGroupIngress",
          "IpProtocol" => "tcp",
          "SourceSecurityGroupName" => "websrv",
          "SourceSecurityGroupOwnerId" => "test_id",
          "Version" => "2016-11-15"
        }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}


  """
  @type revoke_security_group_ingress_opts :: [
   cidr_ip: binary,
   dry_run: boolean,
   from_port: integer,
   group_id: binary,
   group_name: binary,
   ip_permissions: [ip_permission, ...],
   ip_protocol: binary,
   source_security_group_name: binary,
   source_security_group_owner_id: binary,
   to_port: integer
  ]
 @spec revoke_security_group_ingress() :: ExAws.Operation.Query.t
 @spec revoke_security_group_ingress(opts :: revoke_security_group_ingress_opts) :: ExAws.Operation.Query.t
 def revoke_security_group_ingress(opts \\ []) do
    opts |> build_request(:revoke_security_group_ingress)
 end

 @doc """
 Removes one or more egress rules from a security group for EC2-VPC.

 Doc: http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_RevokeSecurityGroupEgress.html

 ## Examples:

        iex> ExAws.EC2.revoke_security_group_egress("sg-123456", [
        ...>  cidr_ip: "10.0.0.2", dry_run: true, from_port: 22, to_port: 22
        ...> ])
        %ExAws.Operation.Query{action: :revoke_security_group_egress,
        params: %{
          "Action" => "RevokeSecurityGroupEgress",
          "GroupId" => "sg-123456",
          "CidrIp" => "10.0.0.2",
          "DryRun" => true,
          "FromPort" => 22,
          "ToPort" => 22,
          "Version" => "2016-11-15"
        }, parser: &ExAws.Utils.identity/2, path: "/", service: :ec2}
 """

 @type revoke_security_group_egress_opts :: [
   cidr_ip: binary,
   dry_run: boolean,
   from_port: integer,
   ip_permissions: [ip_permission, ...],
   ip_protocol: binary,
   source_security_group_name: binary,
   source_security_group_owner_id: binary,
   to_port: integer
 ]
 @spec revoke_security_group_egress(group_id :: binary) :: ExAws.Operation.Query.t
 @spec revoke_security_group_egress(group_id :: binary, opts :: revoke_security_group_egress_opts) :: ExAws.Operation.Query.t
 def revoke_security_group_egress(group_id, opts \\ []) do
   [ {"GroupId", group_id} | opts ]
   |> build_request(:revoke_security_group_egress)
 end


  ####################
  # Helper Functions #
  ####################

  defp build_request(opts, action) do
    opts
    |> Enum.flat_map(&format_param/1)
    |> request(action)
  end

  defp request(params, action) do
    action_string = action |> Atom.to_string |> Macro.camelize

    %ExAws.Operation.Query{
      path: "/",
      params: params |> filter_nil_params |> Map.put("Action", action_string) |> Map.put("Version", @version),
      service: :ec2,
      action: action
    }
  end

  ####################
  # Format Functions #
  ####################

  defp format_param({:attribute_names, attribute_names}) do
    attribute_names |> format(prefix: "AttributeName")
  end

  defp format_param({:auto_enable_io, auto_enable_io}) do
    auto_enable_io |> format(prefix: "AutoEnableIO")
  end

  defp format_param({:billing_products, billing_products}) do
    billing_products |> format(prefix: "BillingProduct")
  end

  defp format_param({:block_device_mappings, block_device_mappings}) do
    block_device_mappings |> format(prefix: "BlockDeviceMapping")
  end

  defp format_param({:bundle_ids, bundle_ids}) do
    bundle_ids |> format(prefix: "BundleId")
  end

  defp format_param({:end_time, end_time}) do
    end_time
    |> DateTime.to_iso8601
    |> format(prefix: "EndTime")
  end

  defp format_param({:executable_by_list, executable_by_list}) do
    executable_by_list |> format(prefix: "ExecutableBy")
  end

  defp format_param({:filters, filters}) do
    filters
    |> Enum.map(fn {key, values} -> [name: maybe_stringify(key), value: values] end)
    |> format(prefix: "Filter")
  end

  defp format_param({:group_ids, group_ids}) do
    group_ids |> format(prefix: "GroupId")
  end

  defp format_param({:group_names, group_names}) do
    group_names |> format(prefix: "GroupName")
  end

  defp format_param({:image_ids, image_ids}) do
    image_ids |> format(prefix: "ImageId")
  end

  defp format_param({:instance_ids, instance_ids}) do
    instance_ids |> format(prefix: "InstanceId")
  end

  defp format_param({:ipv6_addresses, ipv6_addresses}) do
    ipv6_addresses |> format(prefix: "Ipv6Address")
  end

  defp format_param({:key_names, key_names}) do
    key_names |> format(prefix: "KeyName")
  end

  defp format_param({:network_interfaces, network_interfaces}) do
    network_interfaces |> format(prefix: "NetworkInterface")
  end

  defp format_param({:owners, owners}) do
    owners
    |> format(prefix: "Owner")
  end

  defp format_param({:product_codes, product_codes}) do
    product_codes |> format(prefix: "ProductCode")
  end

  defp format_param({:reason_codes, reason_codes}) do
    reason_codes |> format(prefix: "ReasonCode")
  end

  defp format_param({:region_names, region_names}) do
    region_names |> format(prefix: "RegionName")
  end

  defp format_param({:resource_ids, resource_ids}) do
    resource_ids |> format(prefix: "ResourceId")
  end

  defp format_param({:restorable_by_ids, restorable_by_ids}) do
    restorable_by_ids  |> format(prefix: "RestorableBy")
  end

  defp format_param({:snapshot_ids, snapshot_ids}) do
    snapshot_ids |> format(prefix: "SnapshotId")
  end

  defp format_param({:start_time, start_time}) do
    start_time
    |> DateTime.to_iso8601
    |> format(prefix: "StartTime")
  end

  defp format_param({:subnet_ids, subnet_ids}) do
    subnet_ids |> format(prefix: "SubnetId")
  end

  defp format_param({:tag_specifications, tag_specifications}) do
    format_tag =
      fn {key, value} ->
        [ key: maybe_stringify(key), value: value ]
      end

    # FYI, the reason why it is "tag" and not "tags" is the prefix would end up being
    # incorrect. For example: instead of the correct: "TagSpecification.1.Tag.1.Key".
    # it would have been "TagSpecification.1.Tags.1.Key" which AWS wouldn't accept
    # as a param.
    format_tagspec =
      fn {resource_type, tags} ->
        [ resource_type: Atom.to_string(resource_type),
          tag: tags |> Enum.map(format_tag) ]
      end

    tag_specifications
    |> Enum.map(format_tagspec)
    |> format(prefix: "TagSpecification")
  end

  defp format_param({:tags, tags}) do
    tags
    |> Enum.map(fn {key, value} -> [key: maybe_stringify(key), value: value] end)
    |> format(prefix: "Tag")
  end

  defp format_param({:user_ids, user_ids}) do
    user_ids |> format(prefix: "UserId")
  end

  defp format_param({:user_groups, user_groups}) do
    user_groups |> format(prefix: "UserGroup")
  end

  defp format_param({:volume_ids, volume_ids}) do
    volume_ids |> format(prefix: "VolumeId")
  end

  defp format_param({:vpc_ids, vpc_ids}) do
    vpc_ids |> format(prefix: "VpcId")
  end

  defp format_param({:zone_names, zone_names}) do
    zone_names |> format(prefix: "ZoneName")
  end

  defp format_param({key, parameters}) do
    format([ {key, parameters} ])
  end
end
