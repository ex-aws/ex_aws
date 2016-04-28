defmodule ExAws.EC2.Impl do
  alias ExAws.EC2.Request, as: HTTP
  import ExAws.Utils, only: [camelize_keys: 1, upcase: 1]
  
  @moduledoc """
  
  """

  @version "2015-10-01"

  ########################
  ### Instance Actions ###
  ########################

  @params [:dry_run, :max_results, :next_token]
  def describe_instances(client, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeInstances",
      "Version" => @version
      })

    request(client, :get, "/", params: query_params)
  end

  @params [:dry_run, :include_all_instances, :max_results, :next_token]
  def describe_instance_status(client, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeInstanceStatus",
      "Version" => @version
      })

    request(client, :get, "/", params: query_params)
  end  

  @params [:additional_info, :client_token, :disable_api_termination, :dry_run, :ebs_optimized, 
           :iam_instance_profile, :instance_initiated_shutdown_behavior, :instance_type, 
           :kernel_id, :key_name, :monitoring, :placement, :private_ip_address, :ram_disk_id, 
           :user_data]
  def run_instances(client, image_id, max, min, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"   => "RunInstances",
      "Version"  => @version,
      "ImageId"  => image_id,
      "MaxCount" => max,
      "MinCount" => min
      })

    request(client, :post, "/", params: query_params)
  end

  @params [:additional_info, :dry_run]
  def start_instances(client, instance_ids, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "StartInstances",
      "Version" => @version,
      })
    |> Map.merge(list_builder(instance_ids, "InstanceId", 1, %{}))

    request(client, :post, "/", params: query_params)
  end

  @params [:dry_run, :force]
  def stop_instances(client, instance_ids, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "StopInstances",
      "Version" => @version
      })
    |> Map.merge(list_builder(instance_ids, "InstanceId", 1, %{}))

    request(client, :post, "/", params: query_params)    
  end

  @params [:dry_run]
  def terminate_instances(client, instance_ids, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "TerminateInstances",
      "Version" => @version
      })
    |> Map.merge(list_builder(instance_ids, "InstanceId", 1, %{}))

    request(client, :post, "/", params: query_params)      
  end

  @params [:dry_run]
  def reboot_instances(client, instance_ids, opts \\ []) do 
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "RebootInstances",
      "Version" => @version
      })
    |> Map.merge(list_builder(instance_ids, "InstanceId", 1, %{}))

    request(client, :post, "/", params: query_params)
  end

  @params [:description, :dry_run, :end_time, :start_time, :status]
  def report_instance_status(client, instance_ids, status, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "ReportInstanceStatus",
      "Version" => @version,
      "Status"  => status
      })
    |> Map.merge(list_builder(instance_ids, "InstanceId", 1, %{}))

    request(client, :get, "/", params: query_params)
  end

  @params [:dry_run]
  def monitor_instances(client, instance_ids, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "MonitorInstances",
      "Version" => @version
      })
    Map.merge(list_builder(instance_ids, "InstanceId", 1, %{}))

    request(client, :post, "/", params: query_params)    
  end

  @params [:dry_run]
  def unmonitor_instances(client, instance_ids, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "UnmonitorInstances",
      "Version" => @version
      })
    |> Map.merge(list_builder(instance_ids, "InstanceId", 1, %{}))

    request(client, :post, "/", params: query_params)    
  end

  @params [:attribute, :dry_run, :instance_id]
  def describe_instance_attribute(client, instance_id, attribute, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"     => "DescribeInstanceAttribute",
      "Version"    => @version,
      "InstanceId" => instance_id,
      "Attribute"  => attribute
      })

    request(client, :get, "/", params: query_params)
  end

  @params [:attribute, :disable_api_termination, :dry_run, :ebs_optimized, :instance_initiated_shutdown_behavior,
           :kernel, :ramdisk, :source_dest_check, :sriov_net_support, :user_data, :value]
  def modify_instance_attribute(client, instance_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"     => "ModifyInstanceAttribute",
      "Version"    => @version,
      "InstanceId" => instance_id,
      })

    request(client, :post, "/", params: query_params)
  end

  @params [:dry_run]
  def reset_instance_attribute(client, instance_id, attribute, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"     => "ResetInstanceAttribute",
      "Version"    => @version,
      "InstanceId" => instance_id,
      "Attribute"  => attribute
      })

    request(client, :post, "/", params: query_params)    
  end

  @params [:dry_run, :instance_id]
  def get_console_output(client, instance_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"     => "GetConsoleOutput",
      "Version"    => @version,
      "InstanceId" => instance_id
      })

    request(client, :get, "/", params: query_params)
  end

  @params [:dry_run, :instance_id]
  def get_password_data(client, instance_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"     => "GetPasswordData",
      "Version"    => @version,
      "InstanceId" => instance_id
      })

    request(client, :get, "/", params: query_params)    
  end

  ##############################################
  ### Regions and Availability Zones Actions ###
  ##############################################

  @params [:dry_run]
  def describe_availability_zones(client, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeAvailabilityZones",
      "Version" => @version
      })

    request(client, :get, "/", params: query_params)
  end

  @params [:dry_run]
  def describe_regions(client, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeRegions",
      "Version" => @version
      })

    request(client, :get, "/", params: query_params)
  end

  ###################
  ### AMI Actions ###
  ###################

  @params [:description, :dry_run, :no_reboot]
  def create_image(client, instance_id, name, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"     => "CreateImage",
      "Version"    => @version,
      "InstanceId" => instance_id,
      "Name"       => name
      })

    request(client, :post, "/", params: query_params)
  end

  @params [:client_token, :description, :dry_run, :encrypted, :kms_key_id]
  def copy_image(client, name, source_image_id, source_region, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"        => "CopyImage",
      "Version"       => @version,
      "Name"          => name,
      "SourceImageId" => source_image_id,
      "SourceRegion"  => source_region
      })

    request(client, :post, "/", params: query_params)
  end

  @params [:dry_run]
  def describe_images(client, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeImages",
      "Version" => @version
      })
    
    request(client, :get, "/", params: query_params)
  end

  @params [:dry_run]
  def describe_image_attribute(client, image_id, attribute, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"    => "DescribeImageAttribute",
      "Version"   => @version,
      "ImageId"   => image_id,
      "Attribute" => attribute
      })

    request(client, :get, "/", params: query_params)    
  end

  @params [:attribute, :description, :dry_run, :launch_permission, :operation_type, :value]
  def modify_image_attribute(client, image_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "ModifyImageAttribute",
      "Version" => @version,
      "ImageId" => image_id
      })

    request(client, :post, "/", params: query_params)        
  end

  @params [:dry_run]
  def reset_image_attribute(client, image_id, attribute, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"    => "ResetImageAttribute",
      "Version"   => @version,
      "ImageId"   => image_id,
      "Attribute" => attribute
      })

    request(client, :post, "/", params: query_params)     
  end

  @params [:architecture, :description, :dry_run, :image_location, :kernel_id, :ram_disk_id, 
           :root_device_name, :sriov_net_support, :virtualization_type] 
  def register_image(client, name, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "RegisterImage",
      "Version" => @version,
      "Name"    => name
      })

    request(client, :post, "/", params: query_params)  
  end

  @params [:dry_run]
  def deregister_image(client, image_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DeregisterImage",
      "Version" => @version,
      "ImageId" => image_id
      })
    
    request(client, :post, "/", params: query_params)
  end

  #########################
  ### Key Pairs Actions ###
  #########################

  @params [:dry_run]
  def describe_key_pairs(client, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeKeyPairs",
      "Version" => @version,
      })

    request(client, :get, "/", params: query_params)
  end

  @params [:dry_run]
  def create_key_pair(client, key_name, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "CreateKeyPair",
      "Version" => @version,
      "KeyName" => key_name
      })

    request(client, :post, "/", params: query_params)
  end

  @params [:dry_run]
  def delete_key_pair(client, key_name, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DeleteKeyPair",
      "Version" => @version,
      "KeyName" => key_name
      })

    request(client, :post, "/", params: query_params)
  end

  @params [:dry_run]
  def import_key_pair(client, key_name, public_key_material, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"            => "ImportKeyPair",
      "Version"           => @version,
      "KeyName"           => key_name,
      "PublicKeyMaterial" => Base.url_encode64(public_key_material)
      })

    request(client, :post, "/", params: query_params)
  end

  ###########################
  ### Resource ID Actions ###
  ###########################

  @params [:resource]
  def describe_id_format(client, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeIdFormat",
      "Version" => @version
      })

    request(client, :get, "/", params: query_params)
  end

  def modify_id_format(client, resource, use_long_ids) do
    query_params = %{
      "Action"     => "ModifyIdFormat",
      "Version"    => @version,
      "Resource"   => resource,
      "UseLongIds" => use_long_ids
    }

    request(client, :post, "/", params: query_params)
  end

  ###############################
  ### Security Groups Actions ###
  ###############################

  @params [:dry_run]
  def describe_security_groups(client, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeSecurityGroups",
      "Version" => @version
      })

    request(client, :get, "/", params: query_params)
  end 

  @params [:dry_run, :vpc_id]
  def create_security_group(client, group_name, group_description, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"           => "CreateSecurityGroup",
      "Version"          => @version,
      "GroupName"        => group_name,
      "GroupDescription" => group_description
      })

    request(client, :post, "/", params: query_params)
  end

  @params [:cidr_ip, :dry_run, :from_port, :group_id, :group_name, :ip_protocol, :source_security_group_name, 
           :source_security_group_owner_id, :to_port]
  def authorize_security_group_ingress(client, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "AuthorizeSecurityGroupIngress", 
      "Version" => @version
      })

    request(client, :post, "/", params: query_params)
  end  

  @params [:cidr_ip, :dry_run, :from_port, :group_id, :group_name, :ip_protocol, :source_security_group_name, 
           :source_security_group_owner_id, :to_port]  
  def authorize_security_group_egress(client, group_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "AuthorizeSecurityGroupEgress", 
      "Version" => @version
      })

    request(client, :post, "/", params: query_params)
  end

  @params [:cidr_ip, :dry_run, :from_port, :group_id, :group_name, :ip_protocol, :source_security_group_name, 
           :source_security_group_owner_id, :to_port] 
  def revoke_security_group_ingress(client, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "RevokeSecurityGroupIngress", 
      "Version" => @version
      })

    request(client, :post, "/", params: query_params)
  end

  @params [:cidr_ip, :dry_run, :from_port, :group_id, :group_name, :ip_protocol, :source_security_group_name, 
           :source_security_group_owner_id, :to_port] 
  def revoke_security_group_egress(client, group_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "RevokeSecurityGroupEgress", 
      "Version" => @version
      })

    request(client, :post, "/", params: query_params)
  end

  ####################
  ### VPCs Actions ###
  ####################

  @params [:dry_run]
  def describe_vpcs(client, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeVpcs",
      "Version" => @version
      })

    request(client, :get, "/", params: query_params)
  end

  @params [:dry_run, :instance_tenancy]
  def create_vpc(client, cidr_block, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"    => "CreateVpc",
      "Version"   => @version,
      "CidrBlock" => cidr_block
      })
    
    request(client, :post, "/", params: query_params)
  end

  @params [:dry_run]
  def delete_vpc(client, vpc_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DeleteVpc",
      "Version" => @version,
      "VpcId"   => vpc_id
      })

    request(client, :post, "/", params: query_params)
  end

  @params [:dry_run]
  def describe_vpc_attribute(client, vpc_id, attribute, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"    => "DescribeVpcAttribute",
      "Version"   => @version,
      "VpcId"     => vpc_id,
      "Attribute" => attribute
      })

    request(client, :get, "/", params: query_params)
  end

  @params [:enable_dns_hostnames, :enable_dns_support]
  def modify_vpc_attribute(client, vpc_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "ModifyVpcAttribute",
      "Version" => @version,
      "VpcId"   => vpc_id
      })

    request(client, :post, "/", params: query_params)
  end

  #######################
  ### Subnets Actions ###
  #######################

  @params [:dry_run]
  def describe_subnets(client, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeSubnets",
      "Version" => @version
      })

    request(client, :get, "/", params: query_params)
  end

  @params [:availability_zone, :dry_run]
  def create_subnet(client, vpc_id, cidr_block, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"    => "CreateSubnet",
      "Version"   => @version,
      "VpcId"     => vpc_id,
      "CidrBlock" => cidr_block
      })
    
    request(client, :post, "/", params: query_params)
  end

  @params [:dry_run]
  def delete_subnet(client, subnet_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"   => "DeleteSubnet",
      "Version"  => @version,
      "SubnetId" => subnet_id
      })
    
    request(client, :post, "/", params: query_params)
  end

  @params [:map_public_ip_on_launch]
  def modify_subnet_attribute(client, subnet_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"   => "ModifySubnetAttribute",
      "Version"  => @version,
      "SubnetId" => subnet_id
      })

    request(client, :post, "/", params: query_params)
  end

  ####################
  ### Tags Actions ###
  ####################

  @params [:dry_run, :max_results, :next_token]
  def describe_tags(client, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeTags",
      "Version" => @version
      })

    request(client, :get, "/", params: query_params)
  end

  @params [:dry_run]
  def create_tags(client, resource_ids, tags, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "CreateTags",
      "Version" => @version
      })
    |> Map.merge(list_builder(resource_ids, "ResourceId", 1, %{}))
    |> Map.merge(list_builder_key_val(tags, "Tag", 1, %{}))

    request(client, :post, "/", params: query_params)
  end

  @params [:dry_run, :tags]
  def delete_tags(client, resource_ids, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DeleteTags",
      "Version" => @version
      })
    |> Map.merge(list_builder(resource_ids, "ResourceId", 1, %{}))
    
    request(client, :post, "/", params: query_params)
  end

  ####################################
  ### Elastic Block Stores Actions ###
  ####################################

  @params [:dry_run, :max_results, :next_token]
  def describe_volumes(client, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeVolumes",
      "Version" => @version
      })

    request(client, :get, "/", params: query_params)
  end

  def create_volume(client, availability_zone, size, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"           => "CreateVolume", 
      "Version"          => @version,
      "AvailabilityZone" => availability_zone,
      "Size"             => size
      })
    
    request(client, :post, "/", params: query_params)
  end

  @params [:dry_run]
  def delete_volume(client, volume_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"   => "DeleteVolume",
      "Version"  => @version,
      "VolumeId" => volume_id
      })

    request(client, :post, "/", params: query_params)
  end

  @params [:dry_run]
  def attach_volume(client, instance_id, volume_id, device, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"     => "AttachVolume", 
      "Version"    => @version,
      "InstanceId" => instance_id,
      "VolumeId"   => volume_id,
      "Device"     => device
      })

    request(client, :post, "/", params: query_params)
  end

  @params [:dry_run, :device, :force, :instance_id]
  def detach_volume(client, volume_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"   => "DetachVolume",
      "Version"  => @version,
      "VolumeId" => volume_id,
      })

    request(client, :post, "/", params: query_params)
  end

  @params [:attribute, :dry_run]
  def describe_volume_attribute(client, volume_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"    => "DescribeVolumeAttribute",
      "Version"   => @version,
      "VolumeId"  => volume_id
      })

    request(client, :get, "/", params: query_params)
  end

  @params [:auto_enable_io, :dry_run]
  def modify_volume_attribute(client, volume_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"   => "ModifyVolumeAttribute",
      "Version"  => @version,
      "VolumeId" => volume_id
      })

    request(client, :post, "/", params: query_params)
  end

  @params [:dry_run]
  def enable_volume_io(client, volume_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"   => "EnableVolumeIO",
      "Version"  => @version,
      "VolumeId" => volume_id
      })

    request(client, :post, "/", params: query_params)
  end

  @params [:dry_run, :max_results, :next_token]
  def describe_volume_status(client, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeVolumeStatus",
      "Version" => @version
      })
    
    request(client, :get, "/", params: query_params)
  end

  @params [:dry_run, :max_results, :next_token]
  def describe_snapshots(client, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeSnapshots",
      "Version" => @version
      })

    request(client, :get, "/", params: query_params)
  end

  @params [:description, :dry_run]
  def create_snapshot(client, volume_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"   => "CreateSnapshot",
      "Version"  => @version,
      "VolumeId" => volume_id
      })

    request(client, :post, "/", params: query_params)
  end

  @params [:description, :destination_region, :dry_run, :encrypted, :kms_key_id, :presigned_url]
  def copy_snapshot(client, source_snapshot_id, source_region, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"           => "CopySnapshot",
      "Version"          => @version,
      "SourceSnapshotId" => source_snapshot_id,
      "SourceRegion"     => source_region
      })

    request(client, :post, "/", params: query_params)
  end

  @params [:dry_run, :snapshot_id]
  def delete_snapshot(client, snapshot_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"     => "DeleteSnapshot",
      "Version"    => @version,
      "SnapshotId" => snapshot_id
      })

    request(client, :post, "/", params: query_params)
  end

  @params [:dry_run]
  def describe_snapshot_attribute(client, snapshot_id, attribute, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"     => "DescribeSnapshotAttribute",
      "Version"    => @version,
      "SnapshotId" => snapshot_id, 
      "Attribute"  => attribute
      })

    request(client, :get, "/", params: query_params)
  end

  @params [:attribute, :create_volume_permission, :dry_run, :operation_type]
  def modify_snapshot_attribute(client, snapshot_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"     => "ModifySnapshotAttribute",
      "Version"    => @version,
      "SnapshotId" => snapshot_id
      })

    request(client, :post, "/", params: query_params)
  end

  def reset_snapshot_attribute(client, snapshot_id, attribute, opts \\ %{}) do
    query_params = put_action_and_version("ResetSnapshotAttribute")
    |> Map.put_new("SnapshotId", snapshot_id)
    |> Map.put_new("Attribute", attribute)
    |> Map.merge(opts)

    HTTP.request(client, :post, "/", params: query_params)
  end

  ##################################
  ### Account Attributes Actions ###
  ##################################

  def describe_account_attributes(client, opts \\ %{}) do
    query_params = put_action_and_version("DescribeAccountAttributes")
    |> Map.merge(opts)

    HTTP.request(client, :get, "/", params: query_params)
  end

  ############################
  ### Bundle Tasks Actions ###
  ############################

  def bundle_instance(client, instance_id, {s3_aws_access_key_id, s3_bucket, s3_prefix, s3_upload_policy, s3_upload_policy_sig}, opts \\ %{}) do
    query_params = put_action_and_version("BundleInstance")
    |> Map.put_new("InstanceId", instance_id)
    |> Map.put_new("Storage.S3.AWSAccessKeyId", s3_aws_access_key_id)
    |> Map.put_new("Storage.S3.Bucket", s3_bucket)
    |> Map.put_new("Storage.S3.Prefix", s3_prefix)
    |> Map.put_new("Storage.S3.UploadPolicy", s3_upload_policy)
    |> Map.put_new("Storage.S3.UploadPolicySignature", Base.url_encode64(s3_upload_policy_sig))
    |> Map.merge(opts)

    HTTP.request(client, :post, "/", params: query_params)
  end

  def cancel_bundle_task(client, bundle_id, opts \\ %{}) do
    query_params = put_action_and_version("CancelBundleTask")
    |> Map.put_new("BundleId", bundle_id)
    |> Map.merge(opts)

    HTTP.request(client, :post, "/", params: query_params)
  end

  def describe_bundle_tasks(client, opts \\ %{}) do
    query_params = put_action_and_version("DescribeBundleTasks")
    |> Map.merge(opts)

    HTTP.request(client, :get, "/", params: query_params)
  end

  ########################
  ### Helper Functions ###
  ########################

  defp request(%{__struct__: client_module} = client, verb, path, data \\[]) do
    client_module.request(client, verb, path, data)
  end

  defp normalize_opts(opts) do
    opts
    |> Enum.into(%{})
    |> camelize_keys
  end 

  defp put_action_and_version(action) do
    %{
      "Action"  => action,
      "Version" => @version
    }
  end

  defp list_builder([h | []], key, count, state) do
    Map.put_new(state, "#{key}.#{count}", h)
  end

  defp list_builder([h | t], key, count, state) do
    list_builder t, key, count + 1, Map.put_new(state, "#{key}.#{count}", h)
  end

  defp list_builder_key_val([_h = {f, s} | []], key, count, state) do
    new_map = Map.new
    |> Map.put_new("#{key}.#{count}.Key", f)
    |> Map.put_new("#{key}.#{count}.Value", s)

    Map.merge(state, new_map)    
  end

  defp list_builder_key_val([_h = {f, s} | t], key, count, state) do
    new_map = Map.new
    |> Map.put_new("#{key}.#{count}.Key", f)
    |> Map.put_new("#{key}.#{count}.Value", s)

    list_builder_key_val t, key, count + 1, Map.merge(state, new_map)
  end

end