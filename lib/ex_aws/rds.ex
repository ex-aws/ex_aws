defmodule ExAws.RDS do
  @moduledoc """
  Operations on AWS RDS
  """

  import ExAws.Utils, only: [camelize_keys: 1]

  @version "2014-10-31"

  @type db_instance_classes :: [
    :db_t1_micro   | :db_m1_small    | :db_m1_medium  | :db_m1_large  | :db_m1_xlarge  |
    :db_m2_xlarge  | :db_m2_2xlarge  | :db_m2_4xlarge | :db_m3_medium | :db_m3_large   |
    :db_m3_xlarge  | :db_m3_2xlarge  | :db_m4_large   | :db_m4_xlarge | :db_m4_2xlarge |
    :db_m4_4xlarge | :db_m4_10xlarge | :db_r3_large   | :db_r3_xlarge | :db_r3_2xlarge |
    :db_r3_4xlarge | :db_r3_8xlarge  | :db_t2_micro   | :db_t2_small  | :db_t2_medium  |
    :db_t2_large
  ]

  @type filter :: {name :: binary, values :: [binary]}

  @type tag :: {key :: binary, value :: binary}
  @doc """
  Adds a source identifier to an existing RDS event notification subscription.
  """
  @spec add_source_id_to_subscription(source_id :: binary, subscription :: binary) :: ExAws.Operation.RestQuery.t
  def add_source_id_to_subscription(source_id, subscription) do
    query_params = %{
      "Action"           => "AddSourceIdentifierToSubscription",
      "SourceIdentifier" => source_id,
      "SubscriptionName" => subscription,
      "Version"          => @version
    }

    request(:post, "/", query_params)
  end

  def add_tags_to_resource(resource, tags) do
    query_params = %{
      "Action" => "AddTagsToResource",
      "ResourceName" => resource,
      "Version" => @version
    }

    query_params =
      tags
      |> Stream.with_index(1)
      |> Enum.reduce(query_params, fn {{k, v}, n}, tags_map ->
        tags_map
        |> Map.put("Tags.member.#{Integer.to_string(n)}.Key", k)
        |> Map.put("Tags.member.#{Integer.to_string(n)}.Value", v)
      end)

    request(:post, "/", query_params)
  end

  @type apply_pending_maintenance_actions :: :system_upgrade | :db_upgrade
  @type apply_pending_maintenance_opt_in_types :: :immediate | :next_maintenance | :undo_opt_in
  @doc """
  Applies a pending maintenance action to a resource.
  """
  @spec apply_pending_maintenance(resource_id :: binary, action :: apply_pending_maintenance_actions, opt_in_type :: apply_pending_maintenance_opt_in_types) :: ExAws.Operation.RestQuery.t
  def apply_pending_maintenance(resource_id, action, opt_in_type) do
    query_params = %{
      "Action" => "ApplyPendingMaintenanceAction",
      "ResourceIdentifier" => resource_id,
      "ApplyAction" => action,
      "OptInType" => opt_in_type,
      "Version" => @version
    }

    request(:post, "/", query_params)
  end

  @type describe_db_instances_opts :: [
    {:db_instance_identifier, binary}
    | [{:filter_member_1, filter}, ...]
    | {:marker, binary}
    | {:max_records, 20..100}
  ]
  @doc """
  Returns information about provisioned RDS instances.
  """
  @spec describe_db_instances() :: ExAws.Operation.RestQuery.t
  @spec describe_db_instances(opts :: describe_db_instances_opts) :: ExAws.Operation.RestQuery.t
  def describe_db_instances(opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeDBInstances",
      "Version" => @version
    })

    request(:get, "/", query_params)
  end

  @type mysql_port_range :: 1150..65535
  @type maria_db_port_range :: 1150..65535
  @type postgres_sql_port_range :: 1150..65535
  @type oracle_port_range :: 1150..65535
  @type sql_server_port_range :: 1150..65535
  @type amazon_aurora_port_rage :: 1150..65535

  @type create_db_instance_opts :: [
    {:auto_minor_version_upgrade, boolean}
    | {:availability_zone, binary}
    | {:backup_retention_period, integer}
    | {:character_set_name, binary}
    | {:copy_tags_to_snapshot, boolean}
    | {:db_cluster_identifier, binary}
    | {:db_name, binary}
    | {:db_parameter_group_name, binary}
    | [{:db_security_groups_member_1, [binary]}, ...]
    | {:db_subnet_group_name, binary}
    | {:domain, binary}
    | {:domain_iam_role_name, binary}
    | {:engine_version, binary}
    | {:iops, integer}
    | {:kms_key_id, binary}
    | {:license_model, :license_included | :bring_your_own_license | :general_public_license}
    | {:monitoring_interval, 0 | 1 | 5 | 10 | 15 | 30 | 60}
    | {:monitoring_role_arn, binary}
    | {:multi_az, boolean}
    | {:option_group_name, binary}
    | {:port, mysql_port_range | maria_db_port_range | postgres_sql_port_range | oracle_port_range | sql_server_port_range | amazon_aurora_port_rage}
    | {:preferred_backup_window, binary}
    | {:preferred_maintenance_window, binary}
    | {:promotion_tier, 0..15}
    | {:publicly_accessible, boolean}
    | {:storage_encrypted, boolean}
    | {:storage_type, :standard | :gp2 | :io1}
    | [{:tags_member_1, [tag]}, ...]
    | {:tde_credential_arn, binary}
    | {:tde_credential_password, binary}
    | [{:vpc_security_group_ids_member_1, [binary]}, ...]
  ]
  @doc """
  Creates a new DB instance.
  """
  @spec create_db_instance(instance_id :: binary, username :: binary, password :: binary, storage :: integer, class :: binary, engine :: binary) :: ExAws.Operation.RestQuery.t
  @spec create_db_instance(instance_id :: binary, username :: binary, password :: binary, storage :: integer, class :: binary, engine :: binary, opts :: create_db_instance_opts) :: ExAws.Operation.RestQuery.t
  def create_db_instance(instance_id, username, password, storage, class, engine, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"               => "CreateDBInstance",
      "MasterUsername"       => username,
      "MasterUserPassword"   => password,
      "AllocatedStorage"     => storage,
      "DBInstanceIdentifier" => instance_id,
      "DBInstanceClass"      => class,
      "Engine"               => engine,
      "Version"              => @version
    })

    request(:post, "/", query_params)
  end

  @type mysql_allowed_storage :: 5..6144
  @type maria_db_allowed_storage :: 5..6144
  @type postgres_sql_allowed_storage :: 5..6144
  @type oracle_allowed_storage :: 10..6144

  @type modify_db_instance_opts :: [
    {:allocated_storage, mysql_allowed_storage | maria_db_allowed_storage | postgres_sql_allowed_storage | oracle_allowed_storage}
    | {:allow_major_version_upgrade, boolean}
    | {:apply_immediately, boolean}
    | {:auto_minor_version_upgrade, boolean}
    | {:backup_retention_period, integer}
    | {:ca_certificate_identifier, binary}
    | {:copy_tags_to_snapshot, boolean}
    | {:db_instance_class, db_instance_classes}
    | {:db_parameter_group_name, binary}
    | {:db_port_number, mysql_port_range | maria_db_port_range | postgres_sql_port_range | oracle_port_range | sql_server_port_range}
    | [{:sb_security_groups_member_1, [binary]}, ...]
    | {:domain, binary}
    | {:domain_iam_role_name, binary}
    | {:engine_version, binary}
    | {:iops, integer}
    | {:master_user_password, binary}
    | {:monitoring_interval, 0 | 1 | 5 | 10 | 15 | 30 | 60}
    | {:monitoring_role_arn, binary}
    | {:multi_az, boolean}
    | {:new_db_instance_identifier, binary}
    | {:option_group_name, binary}
    | {:preferred_backup_window, binary}
    | {:preferred_maintenance_window, binary}
    | {:promotion_tier, 0..15}
    | {:publicly_accessible, boolean}
    | {:storage_type, :standard | :gp2 | :io1}
    | {:tde_credential_arn, binary}
    | {:tde_credential_password, binary}
    | [{:vpc_security_group_ids_member_1, [binary]}, ...]
  ]
  @doc """
  Modify settings for a DB instance.
  """
  @spec modify_db_instance(instance_id :: binary) :: ExAws.Operation.RestQuery.t
  @spec modify_db_instance(instance_id :: binary, opts :: modify_db_instance_opts) :: ExAws.Operation.RestQuery.t
  def modify_db_instance(instance_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"               => "ModifyDBInstance",
      "DBInstanceIdentifier" => instance_id,
      "Version"              => @version
    })

    request(:patch, "/", query_params)
  end

  @type delete_db_instance_opts :: [
    {:final_db_snapshot_identifier, binary} |
    {:skip_final_snapshot, boolean}
  ]
  @doc """
  Deletes a DB instance.
  """
  @spec delete_db_instance(instance_id :: binary) :: ExAws.Operation.RestQuery.t
  @spec delete_db_instance(instance_id :: binary, opts :: delete_db_instance_opts) :: ExAws.Operation.RestQuery.t
  def delete_db_instance(instance_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"               => "DeleteDBInstance",
      "DBInstanceIdentifier" => instance_id,
      "Version"              => @version
    })

    request(:delete, "/", query_params)
  end

  @type reboot_db_instance_opts :: [
    {:force_failover, boolean}
  ]
  @doc """
  Reboots a DB instance.
  """
  @spec reboot_db_instance(instance_id :: binary) :: ExAws.Operation.RestQuery.t
  @spec reboot_db_instance(instance_id :: binary, opts :: reboot_db_instance_opts) :: ExAws.Operation.RestQuery.t
  def reboot_db_instance(instance_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"               => "RebootDBInstance",
      "DBInstanceIdentifier" => instance_id,
      "Version"              => @version
    })

    request(:get, "/", query_params)
  end

  @type describe_events_opts :: [
    {:duration, integer}
    | {:end_time, binary}
    | [{:event_categories_member_1, [binary]}, ...]
    | [{:filter_member_1, filter}, ...]
    | {:marker, binary}
    | {:max_records, 20..100}
    | {:source_identifier, binary}
    | {:source_type, :db_instance | :db_parameter_group | :db_security_group | :db_snapshot | :db_cluster | :db_cluster_snapsot}
    | {:start_time, binary}
  ]
  @doc """
  Returns events related to DB instances, DB security groups, DB snapshots,
  and DB parameter groups for the past 14 days.
  """
  @spec describe_events() :: ExAws.Operation.RestQuery.t
  @spec describe_events(opts :: describe_db_instances_opts) :: ExAws.Operation.RestQuery.t
  def describe_events(opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeEvents",
      "Version" => @version,
      })

    request(:get, "/", query_params)
  end

  defp request(http_method, path, data) do
    %ExAws.Operation.RestQuery{
      http_method: http_method,
      path: path,
      params: data,
      service: :rds
    }
  end

  defp normalize_opts(opts) do
    opts
    |> Enum.into(%{})
    |> camelize_keys
  end
end
