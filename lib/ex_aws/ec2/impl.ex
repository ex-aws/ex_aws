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
      "Action"  => "DescribeInstanceStatus"
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
    |> Map..merge(list_builder(instance_ids, "InstanceId", 1, %{}))

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

  def report_instance_status(client, instance_ids, status, opts \\ %{}) do
    query_params = put_action_and_version("ReportInstanceStatus")
    |> Map.merge(list_builder(instance_ids, "InstanceId", 1, %{}))
    |> Map.put_new("Status", status)
    |> Map.merge(opts)

    HTTP.request(client, :get, "/", params: query_params)
  end

  def monitor_instances(client, instance_ids, opts \\ %{}) do
    query_params = put_action_and_version("MonitorInstances")
    |> Map.merge(list_builder(instance_ids, "InstanceId", 1, %{}))
    |> Map.merge(opts)

    HTTP.request(client, :post, "/", params: query_params)    
  end

  def unmonitor_instances(client, instance_ids, opts \\ %{}) do
    query_params = put_action_and_version("UnmonitorInstances")
    |> Map.merge(list_builder(instance_ids, "InstanceId", 1, %{}))
    |> Map.merge(opts)

    HTTP.request(client, :post, "/", params: query_params)    
  end

  def describe_instance_attribute(client, instance_id, attribute, opts \\ %{}) do
    query_params = put_action_and_version("DescribeInstanceAttribute")
    |> Map.put_new("InstanceId", instance_id)
    |> Map.put_new("Attribute", attribute)
    |> Map.merge(opts)

    HTTP.request(client, :get, "/", params: query_params)
  end

  def modify_instance_attribute(client, instance_id, attribute, opts \\ %{}) do
    query_params = put_action_and_version("ModifyInstanceAttribute")
    |> Map.put_new("InstanceId", instance_id)
    |> Map.put_new("Attribute", attribute)
    |> Map.merge(opts)

    HTTP.request(client, :post, "/", params: query_params)
  end

  def reset_instance_attribute(client, instance_id, attribute, opts \\ %{}) do
    query_params = put_action_and_version("ResetInstanceAttribute")
    |> Map.put_new("InstanceId", instance_id)
    |> Map.put_new("Attribute", attribute)
    |> Map.merge(opts)

    HTTP.request(client, :post, "/", params: query_params)    
  end

  def get_console_output(client, instance_id, opts \\ %{}) do
    query_params = put_action_and_version("GetConsoleOutput")
    |> Map.put_new("InstanceId", instance_id)
    |> Map.merge(opts)

    HTTP.request(client, :get, "/", params: query_params)
  end

  def get_password_data(client, instance_id, opts \\ %{}) do
    query_params = put_action_and_version("GetPasswordData")
    |> Map.put_new("InstanceId", instance_id)
    |> Map.merge(opts)

    HTTP.request(client, :get, "/", params: query_params)    
  end

  ##############################################
  ### Regions and Availability Zones Actions ###
  ##############################################

  def describe_availability_zones(client, opts \\ %{}) do
    query_params = put_action_and_version("DescribeAvailabilityZones")
    |> Map.merge(opts)

    HTTP.request(client, :get, "/", params: query_params)
  end

  def describe_regions(client, opts \\ %{}) do
    query_params = put_action_and_version("DescribeRegions")
    |> Map.merge(opts)

    HTTP.request(client, :get, "/", params: query_params)
  end

  ###################
  ### AMI Actions ###
  ###################

  def create_image(client, instance_id, name, opts \\ %{}) do
    query_params = put_action_and_version("CreateImage")
    |> Map.put_new("InstanceId", instance_id)
    |> Map.put_new("Name", name)
    |> Map.merge(opts)

    HTTP.request(client, :post, "/", params: query_params)
  end

  def copy_image(client, name, source_image_id, source_region, opts \\ %{}) do
    query_params = put_action_and_version("CopyImage")
    |> Map.put_new("Name", name)
    |> Map.put_new("SourceImageId", source_image_id)
    |> Map.put_new("SourceRegion", source_region)
    |> Map.merge(opts)

    HTTP.request(client, :post, "/", params: query_params)
  end

  def describe_images(client, opts \\ %{}) do
    query_params = put_action_and_version("DescribeImages")
    |> Map.merge(opts)
    
    HTTP.request(client, :get, "/", params: query_params)
  end

  def describe_image_attribute(client, image_id, attribute, opts \\ %{}) do
    query_params = put_action_and_version("DescribeImageAttribute")
    |> Map.put_new("ImageId", image_id)
    |> Map.put_new("Attribute", attribute)
    |> Map.merge(opts)

    HTTP.request(client, :get, "/", params: query_params)    
  end

  def modify_image_attribute(client, image_id, opts \\ %{}) do
    query_params = put_action_and_version("ModifyImageAttribute")
    |> Map.put_new("ImageId", image_id)
    |> Map.merge(opts)

    HTTP.request(client, :post, "/", params: query_params)        
  end

  def reset_image_attribute(client, image_id, attribute, opts \\ %{}) do
    query_params = put_action_and_version("ResetImageAttribute")
    |> Map.put_new("ImageId", image_id)
    |> Map.put_new("Attribute", attribute)
    |> Map.merge(opts)

    HTTP.request(client, :post, "/", params: query_params)     
  end

  def register_image(client, name, parameter_value, parameter_type, opts \\ %{}) when parameter_type == :root_device_name or parameter_type == :image_location do
    query_params = put_action_and_version("RegisterImage")
    |> Map.put_new("Name", name)
    |> Map.merge(opts)

    query_params = 
      case parameter_type do 
        :root_device_name -> query_params |> Map.put_new("RootDeviceName", parameter_value)
        :image_location   -> query_params |> Map.put_new("ImageLocation",  parameter_value)
      end

    HTTP.request(client, :post, "/", params: query_params)  
  end

  def deregister_image(client, image_id, opts \\ %{}) do
    query_params = put_action_and_version("DeregisterImage")
    |> Map.put_new("ImageId", image_id)
    |> Map.merge(opts)
    
    HTTP.request(client, :post, "/", params: query_params)
  end

  #########################
  ### Key Pairs Actions ###
  #########################

  def describe_key_pairs(client, opts \\ %{}) do
    query_params = put_action_and_version("DescribeKeyPairs")
    |> Map.merge(opts)

    HTTP.request(client, :get, "/", params: query_params)
  end

  def create_key_pair(client, key_name, opts \\ %{}) do
    query_params = put_action_and_version("CreateKeyPair")
    |> Map.put_new("KeyName", key_name)
    |> Map.merge(opts)

    HTTP.request(client, :post, "/", params: query_params)
  end

  def delete_key_pair(client, key_name, opts \\ %{}) do
    query_params = put_action_and_version("DeleteKeyPair")
    |> Map.put_new("KeyName", key_name)
    |> Map.merge(opts)

    HTTP.request(client, :post, "/", params: query_params)
  end

  def import_key_pair(client, key_name, public_key_material, opts \\ %{}) do
    query_params = put_action_and_version("ImportKeyPair")
    |> Map.put_new("KeyName", key_name)
    |> Map.put_new("PublicKeyMaterial", Base.url_encode64(public_key_material))
    |> Map.merge(opts)

    HTTP.request(client, :post, "/", params: query_params)
  end

  ###########################
  ### Resource ID Actions ###
  ###########################

  def describe_id_format(client, opts \\ %{}) do
    query_params = put_action_and_version("DescribeIdFormat")
    |> Map.merge(opts)

    HTTP.request(client, :get, "/", params: query_params)
  end

  def modify_id_format(client, resource, use_long_ids, opts \\ %{}) do
    query_params = put_action_and_version("ModifyIdFormat")
    |> Map.put_new("Resource", resource)
    |> Map.put_new("UseLongIds", use_long_ids)
    |> Map.merge(opts)

    HTTP.request(client, :post, "/", params: query_params)
  end

  ###############################
  ### Security Groups Actions ###
  ###############################

  def describe_security_groups(client, opts \\ %{}) do
    query_params = put_action_and_version("DescribeSecurityGroups")   
    |> Map.merge(opts)

    HTTP.request(client, :get, "/", params: query_params)
  end 

  def create_security_group(client, group_name, group_description, opts \\ %{}) do
    query_params = put_action_and_version("CreateSecurityGroup")
    |> Map.put_new("GroupName", group_name)
    |> Map.put_new("GroupDescription", group_description)
    |> Map.merge(opts)

    HTTP.request(client, :post, "/", params: query_params)
  end

  def authorize_security_group_ingress(client, opts \\ %{}) do
    query_params = put_action_and_version("AuthorizeSecurityGroupIngress")
    |> Map.merge(opts)

    HTTP.request(client, :post, "/", params: query_params)
  end  

  def authorize_security_group_egress(client, group_id, opts \\ %{}) do
    query_params = put_action_and_version("AuthorizeSecurityGroupEgress")
    |> Map.put_new("GroupId", group_id)
    |> Map.merge(opts)

    HTTP.request(client, :post, "/", params: query_params)
  end

  def revoke_security_group_ingress(client, opts \\ %{}) do
    query_params = put_action_and_version("RevokeSecurityGroupIngress")
    |> Map.merge(opts)

    HTTP.request(client, :post, "/", params: query_params)
  end

  def revoke_security_group_egress(client, group_id, opts \\ %{}) do
    query_params = put_action_and_version("RevokeSecurityGroupEgress")
    |> Map.put_new("GroupId", group_id)
    |> Map.merge(opts)

    HTTP.request(client, :post, "/", params: query_params)
  end

  ####################
  ### VPCs Actions ###
  ####################

  def describe_vpcs(client, opts \\ %{}) do
    query_params = put_action_and_version("DescribeVpcs")
    |> Map.merge(opts)

    HTTP.request(client, :get, "/", params: query_params)
  end

  def create_vpc(client, cidr_block, opts \\ %{}) do
    query_params = put_action_and_version("CreateVpc")
    |> Map.put_new("CidrBlock", cidr_block)
    |> Map.merge(opts)
    
    HTTP.request(client, :post, "/", params: query_params)
  end

  def delete_vpc(client, vpc_id, opts \\ %{}) do
    query_params = put_action_and_version("DeleteVpc")
    |> Map.put_new("VpcId", vpc_id)
    |> Map.merge(opts)

    HTTP.request(client, :post, "/", params: query_params)
  end

  def describe_vpc_attribute(client, vpc_id, attribute, opts \\ %{}) do
    query_params = put_action_and_version("DescribeVpcAttribute")
    |> Map.put_new("VpcId", vpc_id)
    |> Map.put_new("Attribute", attribute)
    |> Map.merge(opts)

    HTTP.request(client, :get, "/", params: query_params)
  end

  def modify_vpc_attribute(client, vpc_id, attribute, value, opts \\ %{}) when attribute == :dns_hostnames or attribute == :dns_support do
    query_params = put_action_and_version("ModifyVpcAttribute")
    |> Map.put_new("VpcId", vpc_id)
    |> Map.merge(opts)

    query_params = 
      case attribute do 
        :dns_hostnames -> query_params |> Map.put_new("EnableDnsHostnames.Value", value)
        :dns_support   -> query_params |> Map.put_new("EnableDnsSupport.Value", value)
      end

    HTTP.request(client, :post, "/", params: query_params)
  end

  #######################
  ### Subnets Actions ###
  #######################

  def describe_subnets(client, opts \\ %{}) do
    query_params = put_action_and_version("DescribeSubnets")
    |> Map.merge(opts)

    HTTP.request(client, :get, "/", params: query_params)
  end

  def create_subnet(client, vpc_id, cidr_block, opts \\ %{}) do
    query_params = put_action_and_version("CreateSubnet")
    |> Map.put_new("VpcId", vpc_id)
    |> Map.put_new("CidrBlock", cidr_block)
    |> Map.merge(opts)
    
    HTTP.request(client, :post, "/", params: query_params)
  end

  def delete_subnet(client, subnet_id, opts \\ %{}) do
    query_params = put_action_and_version("DeleteSubnet")
    |> Map.put_new("SubnetId", subnet_id)
    |> Map.merge(opts)
    
    HTTP.request(client, :post, "/", params: query_params)
  end

  def modify_subnet_attribute(client, subnet_id, opts \\ %{}) do
    query_params = put_action_and_version("ModifySubnetAttribute")
    |> Map.put_new("SubnetId", subnet_id)
    |> Map.merge(opts)

    HTTP.request(client, :post, "/", params: query_params)
  end

  ####################
  ### Tags Actions ###
  ####################

  def describe_tags(client, opts \\ %{}) do
    query_params = put_action_and_version("DescribeTags")
    |> Map.merge(opts)

    HTTP.request(client, :get, "/", params: query_params)
  end

  def create_tags(client, resource_ids, tags, opts \\ %{}) do
    query_params = put_action_and_version("CreateTags")
    |> Map.merge(list_builder(resource_ids, "ResourceId", 1, %{}))
    |> Map.merge(list_builder_key_val(tags, "Tag", 1, %{}))
    |> Map.merge(opts)

    HTTP.request(client, :post, "/", params: query_params)
  end

  def delete_tags(client, resource_ids, opts \\ %{}) do
    query_params = put_action_and_version("DeleteTags")
    |> Map.merge(list_builder(resource_ids, "ResourceId", 1, %{}))
    |> Map.merge(opts)

    HTTP.request(client, :post, "/", params: query_params)
  end

  ####################################
  ### Elastic Block Stores Actions ###
  ####################################

  def describe_volumes(client, opts \\ %{}) do
    query_params = put_action_and_version("DescribeVolumes")
    |> Map.merge(opts)

    HTTP.request(client, :get, "/", params: query_params)
  end

  def create_volume(client, availability_zone, size, opts \\ %{}) do
    query_params = put_action_and_version("CreateVolume")
    |> Map.put_new("AvailabilityZone", availability_zone)
    |> Map.put_new("Size", size)
    |> Map.merge(opts)
    
    HTTP.request(client, :post, "/", params: query_params)
  end

  def delete_volume(client, volume_id, opts \\ %{}) do
    query_params = put_action_and_version("DeleteVolume")
    |> Map.put_new("VolumeId", volume_id)
    |> Map.merge(opts)

    HTTP.request(client, :post, "/", params: query_params)
  end

  def attach_volume(client, instance_id, volume_id, device, opts \\ %{}) do
    query_params = put_action_and_version("AttachVolume")
    |> Map.put_new("InstanceId", instance_id)
    |> Map.put_new("VolumeId", volume_id)
    |> Map.put_new("Device", device)
    |> Map.merge(opts)

    HTTP.request(client, :post, "/", params: query_params)
  end

  def detach_volume(client, volume_id, opts \\ %{}) do
    query_params = put_action_and_version("DetachVolume")
    |> Map.put_new("VolumeId", volume_id)
    |> Map.merge(opts)

    HTTP.request(client, :post, "/", params: query_params)
  end

  def describe_volume_attribute(client, volume_id, attribute, opts \\ %{}) do
    query_params = put_action_and_version("DescribeVolumeAttribute")
    |> Map.put_new("VolumeId", volume_id)
    |> Map.put_new("Attribute", attribute)
    |> Map.merge(opts)

    HTTP.request(client, :get, "/", params: query_params)
  end

  def modify_volume_attribute(client, volume_id, opts \\ %{}) do
    query_params = put_action_and_version("ModifyVolumeAttribute")
    |> Map.put_new("VolumeId", volume_id)
    |> Map.merge(opts)

    HTTP.request(client, :post, "/", params: query_params)
  end

  def enable_volume_io(client, volume_id, opts \\ %{}) do
    query_params = put_action_and_version("EnableVolumeIO")
    |> Map.put_new("VolumeId", volume_id)
    |> Map.merge(opts)

    HTTP.request(client, :post, "/", params: query_params)
  end

  def describe_volume_status(client, opts \\ %{}) do
    query_params = put_action_and_version("DescribeVolumeStatus")
    |> Map.merge(opts)

    HTTP.request(client, :get, "/", params: query_params)
  end

  def describe_snapshots(client, opts \\ %{}) do
    query_params = put_action_and_version("DescribeSnapshots")
    |> Map.merge(opts)

    HTTP.request(client, :get, "/", params: query_params)
  end

  def create_snapshot(client, volume_id, opts \\ %{}) do
    query_params = put_action_and_version("CreateSnapshot")
    |> Map.put_new("VolumeId", volume_id)
    |> Map.merge(opts)

    HTTP.request(client, :post, "/", params: query_params)
  end

  def copy_snapshot(client, source_snapshot_id, source_region, opts \\ %{}) do
    query_params = put_action_and_version("CopySnapshot")
    |> Map.put_new("SourceSnapshotId", source_snapshot_id)
    |> Map.put_new("SourceRegion", source_region)
    |> Map.merge(opts)
    
    HTTP.request(client, :post, "/", params: query_params)
  end

  def delete_snapshot(client, snapshot_id, opts \\ %{}) do
    query_params = put_action_and_version("DeleteSnapshot")
    |> Map.put_new("SnapshotId", snapshot_id)
    |> Map.merge(opts)

    HTTP.request(client, :post, "/", params: query_params)
  end

  def describe_snapshot_attribute(client, snapshot_id, attribute, opts \\ %{}) do
    query_params = put_action_and_version("DescribeSnapshotAttribute")
    |> Map.put_new("SnapshotId", snapshot_id)
    |> Map.put_new("Attribute", attribute)
    |> Map.merge(opts)

    HTTP.request(client, :get, "/", params: query_params)
  end

  def modify_snapshot_attribute(client, snapshot_id, opts \\ %{}) do
    query_params = put_action_and_version("ModifySnapshotAttribute")
    |> Map.put_new("SnapshotId", snapshot_id)
    |> Map.merge(opts)

    HTTP.request(client, :post, "/", params: query_params)
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