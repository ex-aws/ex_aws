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