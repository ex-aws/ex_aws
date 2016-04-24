defmodule ExAws.EC2.Client do
  use Behaviour

  @moduledoc """
  
  """

  defcallback describe_instances() :: ExAws.Request.response_t
  defcallback describe_instances(opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Describes the status of one or more instances. By default, only running
  instances are described, unless specified otherwise.
  """
  defcallback describe_instance_status() :: ExAws.Request.response_t
  defcallback describe_instance_status(opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Launches the speficied number of instance using an AMI.
  """
  defcallback run_instances(image_id :: binary, max :: pos_integer, min :: pos_integer) :: ExAws.Request.response_t
  defcallback run_instances(image_id :: binary, max :: pos_integer, min :: pos_integer, opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Starts an Amazon EBS-backed AMI that was previously stopped.
  """
  defcallback start_instances(instance_ids :: list(binary)) :: ExAws.Request.response_t  
  defcallback start_instances(instance_ids :: list(binary), opts :: Map.t) :: ExAws.Request.response_t  

  @doc """
  Stops an Amazon EBS-backed AMI that was previously started.
  """
  defcallback stop_instances(instance_ids :: list(binary)) :: ExAws.Request.response_t
  defcallback stop_instances(instance_ids :: list(binary), opts :: Map.t) :: ExAws.Request.response_t  

  @doc """
  Shuts down one or more instances. Terminated instances remain visible after 
  termination (for approximately one hour).
  """
  defcallback terminate_instances(instance_ids :: list(binary)) :: ExAws.Request.response_t
  defcallback terminate_instances(instance_ids :: list(binary), opts :: Map.t) :: ExAws.Request.response_t    

  @doc """
  Requests a reboot of one or more instances. This operation is asynchronous; it
  only queues a request to reboot the specified instances.
  """
  defcallback reboot_instances(instance_ids :: list(binary)) :: ExAws.Request.response_t
  defcallback reboot_instances(instance_ids :: list(binary), opts :: Map.pt) :: ExAws.Request.response_t

  @doc """
  Submits feedback about the status of an instance. The instance must be in the 
  running state.
  """
  defcallback report_instance_status(instance_ids :: list(binary), status :: binary) :: ExAws.Request.response_t
  defcallback report_instance_status(instance_ids :: list(binary), status :: binary, opts :: Map.t) :: ExAws.Request.response_t  

  @doc """
  Enables monitoring for a running instance.
  """
  defcallback monitor_instances(instance_ids :: list(binary)) :: ExAws.Request.response_t
  defcallback monitor_instances(instance_ids :: list(binary), opts :: Map.pt) :: ExAws.Request.response_t

  @doc """
  Disables monitoring for a running instance. 
  """
  defcallback unmonitor_instances(instance_ids :: list(binary)) :: ExAws.Request.response_t
  defcallback unmonitor_instances(instance_ids :: list(binary), opts :: Map.pt) :: ExAws.Request.response_t    

  @doc """
  Describes the specified attribute of the specified instance. You can specify 
  only one attribute at a time.
  """
  defcallback describe_instance_attribute(instace_id :: binary, attribute :: binary) :: ExAws.Request.response_t
  defcallback describe_instance_attribute(instace_id :: binary, attribute :: binary, opts :: Map.t) :: ExAws.Request.response_t  

  @doc """
  Modifies the specified attribute of the specified instance. You can 
  specify only one attribute at a time.
  """
  defcallback modify_instance_attribute(instace_id :: binary, attribute :: binary) :: ExAws.Request.response_t
  defcallback modify_instance_attribute(instace_id :: binary, attribute :: binary, opts :: Map.t) :: ExAws.Request.response_t  

  @doc """
  Resets an attribute of an instance to its default value. To reset the kernel 
  or ramdisk, the instance must be in a stopped state. To reset the 
  SourceDestCheck, the instance can be either running or stopped.
  """
  defcallback reset_instance_attribute(instace_id :: binary, attribute :: binary) :: ExAws.Request.response_t
  defcallback reset_instance_attribute(instace_id :: binary, attribute :: binary, opts :: Map.t) :: ExAws.Request.response_t  

  @doc """
  Gets the console output for the specified instance.
  """
  defcallback get_console_output(instace_id :: binary) :: ExAws.Request.response_t
  defcallback get_console_output(instace_id :: binary, opts :: Map.t) :: ExAws.Request.response_t  

  @doc """
  Retrieves the encrypted administrator password for an instance running 
  Windows.
  """
  defcallback get_password_data(instace_id :: binary) :: ExAws.Request.response_t
  defcallback get_password_data(instace_id :: binary, opts :: Map.t) :: ExAws.Request.response_t  

  @doc """
  Describes one or more of the Availability Zones that are available to you. 
  The results include zones only for the region you're currently using.
  """
  defcallback describe_availability_zones() :: ExAws.Request.response_t
  defcallback describe_availability_zones(opts :: Map.t) :: ExAws.Request.response_t  

  @doc """
  Describes one or more regions that are currently available to you.
  """
  defcallback describe_regions() :: ExAws.Request.response_t
  defcallback describe_regions(opts :: Map.t) :: ExAws.Request.response_t  

  @doc """
  Creates an Amazon EBS-backed AMI from an Amazon EBS-backed instance 
  that is either running or stopped.
  """
  defcallback create_image(instace_id :: binary, name :: binary) :: ExAws.Request.response_t
  defcallback create_image(instace_id :: binary, name :: binary, opts :: Map.t) :: ExAws.Request.response_t  

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