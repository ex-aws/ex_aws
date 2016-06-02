defmodule ExAws.EC2.Impl do
  import ExAws.Utils, only: [camelize_keys: 1, upcase: 1]
  
  @moduledoc """
  
  """

  @version "2015-10-01"

  ########################
  ### Instance Actions ###
  ########################

  def describe_instances(client, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeInstances",
      "Version" => @version
      })

    request(client, :get, "/", params: query_params)
  end

  def describe_instance_status(client, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeInstanceStatus",
      "Version" => @version
      })

    request(client, :get, "/", params: query_params)
  end  

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

  def monitor_instances(client, instance_ids, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "MonitorInstances",
      "Version" => @version
      })
    |> Map.merge(list_builder(instance_ids, "InstanceId", 1, %{}))

    request(client, :post, "/", params: query_params)    
  end

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

  def describe_availability_zones(client, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeAvailabilityZones",
      "Version" => @version
      })

    request(client, :get, "/", params: query_params)
  end

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

  def describe_images(client, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeImages",
      "Version" => @version
      })
    
    request(client, :get, "/", params: query_params)
  end

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

  def describe_key_pairs(client, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeKeyPairs",
      "Version" => @version,
      })

    request(client, :get, "/", params: query_params)
  end

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

  def describe_security_groups(client, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeSecurityGroups",
      "Version" => @version
      })

    request(client, :get, "/", params: query_params)
  end 

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

  def authorize_security_group_ingress(client, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "AuthorizeSecurityGroupIngress", 
      "Version" => @version
      })

    request(client, :post, "/", params: query_params)
  end  

  def authorize_security_group_egress(client, group_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "AuthorizeSecurityGroupEgress", 
      "Version" => @version,
      "GroupId" => group_id
      })

    request(client, :post, "/", params: query_params)
  end

  def revoke_security_group_ingress(client, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "RevokeSecurityGroupIngress", 
      "Version" => @version
      })

    request(client, :post, "/", params: query_params)
  end

  def revoke_security_group_egress(client, group_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "RevokeSecurityGroupEgress", 
      "Version" => @version,
      "GroupId" => group_id
      })

    request(client, :post, "/", params: query_params)
  end

  ####################
  ### VPCs Actions ###
  ####################

  def describe_vpcs(client, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeVpcs",
      "Version" => @version
      })

    request(client, :get, "/", params: query_params)
  end

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

  def describe_subnets(client, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeSubnets",
      "Version" => @version
      })

    request(client, :get, "/", params: query_params)
  end

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

  def describe_tags(client, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeTags",
      "Version" => @version
      })

    request(client, :get, "/", params: query_params)
  end

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

  def describe_volume_status(client, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeVolumeStatus",
      "Version" => @version
      })
    
    request(client, :get, "/", params: query_params)
  end

  def describe_snapshots(client, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeSnapshots",
      "Version" => @version
      })

    request(client, :get, "/", params: query_params)
  end

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

  def reset_snapshot_attribute(client, snapshot_id, attribute, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"     => "ResetSnapshotAttribute",
      "Version"    => @version,
      "SnapshotId" => snapshot_id,
      "Attribute"  => attribute
      })

    request(client, :post, "/", params: query_params)
  end

  ##################################
  ### Account Attributes Actions ###
  ##################################

  def describe_account_attributes(client, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeAccountAttributes",
      "Version" => @version
      })

    request(client, :get, "/", params: query_params)
  end

  ############################
  ### Bundle Tasks Actions ###
  ############################

  def bundle_instance(client, instance_id, {s3_aws_access_key_id, s3_bucket, s3_prefix, s3_upload_policy, s3_upload_policy_sig}, opts \\ []) do
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

    request(client, :post, "/", params: query_params)
  end

  def cancel_bundle_task(client, bundle_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"   => "CancelBundleTask",
      "Version"  => @version,
      "BundleId" => bundle_id
      })

    request(client, :post, "/", params: query_params)
  end

  def describe_bundle_tasks(client, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeBundleTasks",
      "Version" => @version
      })

    request(client, :get, "/", params: query_params)
  end

  ########################
  ### Helper Functions ###
  ########################

  defp request(%{__struct__: client_module} = client, verb, path, data) do
    client_module.request(client, verb, path, data)
  end

  defp normalize_opts(opts) do
    opts
    |> Enum.into(%{})
    |> camelize_keys
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

