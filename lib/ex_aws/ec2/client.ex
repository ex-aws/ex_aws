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