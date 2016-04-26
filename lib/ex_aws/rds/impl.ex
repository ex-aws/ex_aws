defmodule ExAws.RDS.Impl do
  import ExAws.Utils, only: [camelize_keys: 1, upcase: 1]

  @version "2014-10-31"

  def add_source_id_to_subscription(client, source_id, subscription) do
    query_params = %{
      "Action"           => "AddSourceIdentifierToSubscription",
      "SourceIdentifier" => source_id,
      "SubscriptionName" => subscription,
      "Version"          => @version
    }

    request(client, :post, "/", params: query_params)
  end

  def add_tags_to_resource(client, resource, tags, n) do
    query_params = Map.new
    |> Map.put_new("Action", "AddTagsToResource")
    |> Map.put_new("ResourceName", resource)
    |> Map.put_new("Version", @version)

    for {k, v} <- tags do 
      query_params = query_params
      |> Map.put_new("Tags.member.#{Integer.to_string(n)}.Key", k)
      |> Map.put_new("Tags.member.#{Integer.to_string(n)}.Value", v)
    end

    request(client, :post, "/", params: query_params)
  end

  def apply_pending_maintenance(client, resource_id, action, opt_in_type) when action == "system-update" do 
    query_params = Map.new
    |> Map.put_new("Action", "ApplyPendingMaintenanceAction")
    |> Map.put_new("ResourceIdentifier", resource_id)
    |> Map.put_new("ApplyAction", action)
    |> Map.put_new("OptInType", opt_in_type)
    |> Map.put_new("Version", @version)

    request(client, :post, "/", params: query_params)
  end

  def apply_pending_maintenance(client, resource_id, action, opt_in_type) when action == "db-upgrade" do 
    query_params = Map.new
    |> Map.put_new("Action", "ApplyPendingMaintenanceAction")
    |> Map.put_new("ResourceIdentifier", resource_id)
    |> Map.put_new("ApplyAction", action)
    |> Map.put_new("OptInType", opt_in_type)
    |> Map.put_new("Version", @version)

    request(client, :post, "/", params: query_params)
  end  

  @params [:db_instance_identifier, :marker, :max_records]
  def describe_db_instances(client, opts \\ []) do 
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeDBInstances",
      "Version" => @version
    })

    request(client, :get, "/", params: query_params)
  end

  @params [:auto_minor_version_upgrade, :availability_zone, :backup_retention_period, :character_set_name, :copy_tags_to_snapshot,
           :db_cluster_identifier, :db_name, :db_parameter_group_name, :db_subnet_group_name, :domain, 
           :domain_iam_role_name, :engine_version, :iops, :kms_key_id, :license_model, :monitoring_interval, 
           :monitoring_role_arn, :multi_az, :option_group_name, :port, :preferred_backup_window, :preferred_maintenance_window, 
           :promotion_tier, :publicly_accessible, :storage_encrypted, :storage_type, :tde_credential_arn, :tde_credential_password
  ]
  def create_db_instance(client, instance_id, username, password, storage, class, engine, opts \\ []) do 
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

    request(client, :post, "/", params: query_params)
  end

  @params [:allocated_storage, :allow_major_version_upgrade, :apply_immediately, :auto_minor_version_upgrade, :backup_retention_period, 
           :ca_certificate_identifier, :copy_tags_to_snapshot, :db_instance_class, :db_parameter_group_name, :db_port_number, 
           :domain, :domain_iam_role_name, :engine_version, :iops, :master_user_password, :monitoring_interval, :monitoring_role_arn, 
           :multi_az, :new_db_instance_identifier, :option_group_name, :preferred_backup_window, :preferred_maintenance_window, :promotion_tier, 
           :publicly_accessible, :storage_type, :tde_credential_arn, :tde_credential_password, 
  ]
  def modify_db_instance(client, instance_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"               => "ModifyDBInstance",
      "DBInstanceIdentifier" => instance_id,
      "Version"              => @version
    })

    request(client, :patch, "/", params: query_params)
  end

  @params [:final_snapshot_identifier, :skip_final_snapshot]
  def delete_db_instance(client, instance_id, opts \\ []) do 
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"               => "DeleteDBInstance",
      "DBInstanceIdentifier" => instance_id,
      "Version"              => @version
    })

    request(client, :delete, "/", params: query_params)
  end

  @params [:force_failover]
  def reboot_db_instance(client, instance_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"               => "RebootDBInstance",
      "DBInstanceIdentifier" => instance_id,
      "Version"              => @version
    })

    request(client, :get, "/", params: query_params)
  end

  @params [:duration, :end_time, :marker, :max_records, :source_identifier, :source_type, :start_time] 
  def describe_events(client, opts \\ []) do 
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action" => "DescribeEvents",
      "Version" => @version,
      })

    request(client, :get, "/", params: query_params)
  end

  defp request(%{__struct__: client_module} = client, verb, path, data \\[]) do
    client_module.request(client, verb, path, data)
  end

  defp normalize_opts(opts) do
    opts
    |> Enum.into(%{})
    |> camelize_keys
  end
end
