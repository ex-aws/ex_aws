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

  @type db_instance_classes :: [
    "db.t1.micro" | "db.m1.small" | "db.m1.medium" | "db.m1.large" | "db.m1.xlarge" | 
    "db.m2.xlarge" | "db.m2.2xlarge" | "db.m2.4xlarge" | "db.m3.medium" | "db.m3.large" | 
    "db.m3.xlarge" | "db.m3.2xlarge" | "db.m4.large" | "db.m4.xlarge" | "db.m4.2xlarge" | 
    "db.m4.4xlarge" | "db.m4.10xlarge" | "db.r3.large" | "db.r3.xlarge" | "db.r3.2xlarge" | 
    "db.r3.4xlarge" | "db.r3.8xlarge" | "db.t2.micro" | "db.t2.small" | "db.t2.medium" | 
    "db.t2.large"
  ]


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

  @type describe_db_instances_opts :: [
    {:db_instance_identifier, binary} | 
    #{:filter_member_n}
    {:marker, binary} |
    {:max_records, 20..100}
  ]
  @doc """
  Returns information about provisioned RDS instances.
  """
  defcallback describe_db_instances() :: ExAws.Request.response_t
  defcallback describe_db_instances(opts :: describe_db_instances_opts) :: ExAws.Request.response_t

  @type mysql_port_range :: 1150..65535
  @type maria_db_port_range :: 1150..65535
  @type postgres_sql_port_range :: 1150..65535
  @type oracle_port_range :: 1150..65535
  @type sql_server_port_range :: 1150..65535
  @type amazon_aurora_port_rage :: 1150..65535

  @type create_db_instance_opts :: [
    {:auto_minor_version_upgrade, boolean} |
    {:availability_zone, binary} |
    {:backup_retention_period, integer} |
    {:character_set_name, binary} |
    {:copy_tags_to_snapshot, boolean} |
    {:db_cluster_identifier, binary} |
    {:db_name, binary} | 
    {:db_parameter_group_name, binary} |
    #{:db_security_groups}
    {:db_subnet_group_name, binary} |
    {:domain, binary} |
    {:domain_iam_role_name, binary} |
    {:engine_version, binary} |
    {:iops, integer} | 
    {:kms_key_id, binary} |
    {:license_model, "license-included" | "bring-your-own-license" | "general-public-license"} | 
    {:monitoring_interval, 0 | 1 | 5 | 10 | 15 | 30 | 60} | 
    {:monitoring_role_arn, binary} | 
    {:multi_az, boolean} | 
    {:option_group_name, binary} | 
    {:port, mysql_port_range | maria_db_port_range | postgres_sql_port_range | oracle_port_range | sql_server_port_range | amazon_aurora_port_rage} |
    {:preferred_backup_window, binary} | 
    {:preferred_maintenance_window, binary} |
    {:promotion_tier, 0..15} | 
    {:publicly_accessible, boolean} | 
    {:storage_encrypted, boolean} | 
    {:storage_type, :standard | :gp2 | :io1} |
    #{:tags.member}
    {:tde_credential_arn, binary} | 
    {:tde_credential_password, binary} | 
    #{:vpc_security_group_ids.member}
  ]
  @doc """
  Creates a new DB instance. 
  """
  defcallback create_db_instance(instance_id :: binary, username :: binary, password :: binary, storage :: integer, class :: binary, engine :: binary) :: ExAws.Request.response_t
  defcallback create_db_instance(instance_id :: binary, username :: binary, password :: binary, storage :: integer, class :: binary, engine :: binary, opts :: create_db_instance_opts) :: ExAws.Request.response_t

  @type mysql_allowed_storage :: 5..6144
  @type maria_db_allowed_storage :: 5..6144
  @type postgres_sql_allowed_storage :: 5..6144
  @type oracle_allowed_storage :: 10..6144

  @type modify_db_instance_opts :: [
    {:allocated_storage, mysql_allowed_storage | maria_db_allowed_storage | postgres_sql_allowed_storage | oracle_allowed_storage} | 
    {:allow_major_version_upgrade, boolean} | 
    {:apply_immediately, boolean} | 
    {:auto_minor_version_upgrade, boolean} |
    {:backup_retention_period, integer} | 
    {:ca_certificate_identifier, binary} | 
    {:copy_tags_to_snapshot, boolean} | 
    {:db_instance_class, db_instance_classes} | 
    {:db_parameter_group_name, binary} | 
    {:db_port_number, mysql_port_range | maria_db_port_range | postgres_sql_port_range | oracle_port_range | sql_server_port_range} | 
    #{:sb_security_groups_member_n}
    {:domain, binary} | 
    {:domain_iam_role_name, binary} | 
    {:engine_version, binary}| 
    {:iops, integer} | 
    {:master_user_password, binary} | # Needs a regex to remove '/', '@' and '"'
    {:monitoring_interval, 0 | 1 | 5 | 10 | 15 | 30 | 60} | 
    {:monitoring_role_arn, binary} | 
    {:multi_az, boolean} | 
    {:new_db_instance_identifier, binary} | # Needs regex to allow 1 to 63 char length, first char must be a letter and cannot end with hyphen or have two consecutive ones
    {:option_group_name, binary} | 
    {:preferred_backup_window, binary} | # Needs regex for hh24:mi-hh24:mi format
    {:preferred_maintenance_window, binary} | # Needs regex for ddd:hh24:mi-ddd:hh24:mi format
    {:promotion_tier, 0..15} | 
    {:publicly_accessible, boolean} | 
    {:storage_type, :standard | :gp2 | :io1} | 
    {:tde_credential_arn, binary} | 
    {:tde_credential_password, binary} | 
    #{:vpc_security_group_ids}
  ]
  @doc """
  Modify settings for a DB instance. 
  """
  defcallback modify_db_instance(instance_id :: binary) :: ExAws.Request.response_t
  defcallback modify_db_instance(instance_id :: binary, opts :: modify_db_instance_opts) :: ExAws.Request.response_t  

  @type reboot_db_instance_opts :: [
    {:force_failover, boolean}
  ]
  @doc """
  Reboots a DB instance.
  """
  defcallback reboot_db_instance(instance_id :: binary) :: ExAws.Request.response_t
  defcallback reboot_db_instance(instance_id :: binary, opts :: reboot_db_instance_opts) :: ExAws.Request.response_t

  @type delete_db_instance_opts :: [
    {:final_db_snapshot_identifier, binary} | 
    {:skip_final_snapshot, boolean}
  ]
  @doc """
  Deletes a DB instance.
  """
  defcallback delete_db_instance(instance_id :: binary) :: ExAws.Request.response_t
  defcallback delete_db_instance(instance_id :: binary, opts :: delete_db_instance_opts) :: ExAws.Request.response_t

  @type describe_events_opts :: [
    {:duration, integer} | 
    # {:end_time, binary} # Needs regex for ISO 8601 format
    #{:event_categories_member_n}
    #:filter_member_n
    {:marker, binary} | 
    {:max_records, 20..100} | 
    {:source_identifier, binary} | 
    {:source_type, "db-instance" | "db-parameter-group" | "db-security-group" | "db-snapshot" | "db-cluster" | "db-cluster-snapsot"} | 
    #{:start_time, } # Needs regex for ISO 8601 format
  ]
  @doc """
  Returns events related to DB instances, DB security groups, DB snapshots, 
  and DB parameter groups for the past 14 days.
  """
  defcallback describe_events() :: ExAws.Request.response_t
  defcallback describe_events(opts :: describe_db_instances_opts) :: ExAws.Request.response_t  

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
