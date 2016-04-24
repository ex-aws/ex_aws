defmodule ExAws.EC2.Impl do
  alias ExAws.EC2.Request, as: HTTP
  
  @moduledoc """
  
  """

  @version "2015-10-01"

  ########################
  ### Instance Actions ###
  ########################

  def describe_instances(client, opts \\ %{}) do
    query_params = put_action_and_version("DescribeInstances")
    |> Map.merge(opts)

    HTTP.request(client, :get, "/", params: query_params)
  end

  def describe_instance_status(client, opts \\ %{}) do
    query_params = put_action_and_version("DescribeInstanceStatus")
    |> Map.merge(opts)

    HTTP.request(client, :get, "/", params: query_params)
  end  

  def run_instances(client, image_id, max, min, opts \\ %{}) do
    query_params = put_action_and_version("RunInstances")
    |> Map.put_new("ImageId", image_id)
    |> Map.put_new("MaxCount", max)
    |> Map.put_new("MinCount", min)
    |> Map.merge(opts)

    HTTP.request(client, :post, "/", params: query_params)
  end

  def start_instances(client, instance_ids, opts \\ %{}) do
    query_params = put_action_and_version("StartInstances")
    |> Map.merge(list_builder(instance_ids, "InstanceId", 1, %{}))
    |> Map.merge(opts)

    HTTP.request(client, :post, "/", params: query_params)
  end

  def stop_instances(client, instance_ids, opts \\ %{}) do
    query_params = put_action_and_version("StopInstances")
    |> Map.merge(list_builder(instance_ids, "InstanceId", 1, %{}))
    |> Map.merge(opts)

    HTTP.request(client, :post, "/", params: query_params)    
  end

  def terminate_instances(client, instance_ids, opts \\ %{}) do
    query_params = put_action_and_version("TerminateInstances")
    |> Map.merge(list_builder(instance_ids, "InstanceId", 1, %{}))
    |> Map.merge(opts)

    HTTP.request(client, :post, "/", params: query_params)      
  end

  def reboot_instances(client, instance_ids, opts \\ %{}) do 
    query_params = put_action_and_version("RebootInstances")
    |> Map.merge(list_builder(instance_ids, "InstanceId", 1, %{}))
    |> Map.merge(opts)

    HTTP.request(client, :post, "/", params: query_params)
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

  ########################
  ### Helper Functions ###
  ########################  

  defp put_action_and_version(action) do
    Map.new
    |> Map.put_new("Action", action)
    |> Map.put_new("Version", @version)
  end

  defp list_builder([h | []], key, count, state) do
    Map.put_new(state, "#{key}.#{count}", h)
  end

  defp list_builder([h | t], key, count, state) do
    list_builder t, key, count + 1, Map.put_new(state, "#{key}.#{count}", h)
  end

end