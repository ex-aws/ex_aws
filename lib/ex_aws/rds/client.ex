defmodule ExAws.RDS.Client do
  use Behaviour

  @moduledoc """
  The purpose of this module is to surface the ExAws.RDS API tied to a single
  configuration chosen, sich that it does not need passed in with every request.

  Usage:
  ```
  defmodule MyApp.RDS do 
    use ExAws.RDS.Client, otp_app: :my_otp_app
  end
  ```

  In your config
  ```
  config :my_otp_app, :ex_aws,
    rds: [], # RDS config goes here
  ```
  """

  @doc """
  Adds a source identifier to an existing RDS event notification subscription.
  """
  defcallback add_source_id_to_subscription(source_id :: binary, subscription :: binary) :: ExAws.Request.response_t

  @doc """
  Adds metadata tags to an Amazon RDS resource. 
  """
  defcallback add_tags_to_resource(resource :: binary, tags :: List.t, n :: integer) :: ExAws.Request.response_t

  @doc """
  Applies a pending maintenance action to a resource.
  """
  defcallback apply_pending_maintenance(resource_id :: binary, action :: binary, opt_in_type :: binary) :: ExAws.Request.response_t

  @doc """
  Returns information about provisioned RDS instances.
  """
  defcallback describe_db_instances() :: ExAws.Request.response_t
  defcallback describe_db_instances(opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Creates a new DB instance. 
  """
  defcallback create_db_instance(instance_id :: binary, username :: binary, password :: binary, storage :: integer, class :: binary, engine :: binary) :: ExAws.Request.response_t
  defcallback create_db_instance(instance_id :: binary, username :: binary, password :: binary, storage :: integer, class :: binary, engine :: binary, opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Modify settings for a DB instance. 
  """
  defcallback modify_db_instance(instance_id :: binary) :: ExAws.Request.response_t
  defcallback modify_db_instance(instance_id :: binary, opts :: Map.t) :: ExAws.Request.response_t  

  @doc """
  Reboots a DB instance.
  """
  defcallback reboot_db_instance(instance_id :: binary) :: ExAws.Request.response_t
  defcallback reboot_db_instance(instance_id :: binary, failover :: boolean) :: ExAws.Request.response_t

  @doc """
  Deletes a DB instance.
  """
  defcallback delete_db_instance(instance_id :: binary, final_snapshot_id :: binary) :: ExAws.Request.response_t
  defcallback delete_db_instance(instance_id :: binary, final_snapshot_id :: binary, opts :: Map.t) :: ExAws.Request.response_t  
  defcallback delete_db_instance(instance_id :: binary) :: ExAws.Request.response_t
  defcallback delete_db_instance(instance_id :: binary, opts :: Map.t) :: ExAws.Request.response_t

  @doc """
  Returns events related to DB instances, DB security groups, DB snapshots, 
  and DB parameter groups for the past 14 days.
  """
  defcallback describe_events() :: ExAws.Request.response_t
  defcallback describe_events(opts :: Map.t) :: ExAws.Request.response_t  

  defmacro __using__(opts) do 

    boilerplate = __MODULE__
    |> ExAws.Client.generate_boilerplate(opts)
     quote do 
      defstruct config: nil, service: :rds
      unquote(boilerplate)

      @doc false
      def request(client, http_method, path, data \\ []) do
        ExAws.RDS.Request.request(client, http_method, path, data)
      end

      defoverridable config_root: 0, request: 3, request: 4
     end
  end
end