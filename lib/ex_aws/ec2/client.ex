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