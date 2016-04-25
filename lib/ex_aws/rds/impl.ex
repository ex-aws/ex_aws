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

  def describe_db_instances(client, opts \\ []) do 
    query_params = %{
      "Action"  => "DescribeDBInstances",
      "Version" => @version
    }
    |> Map.merge(normalize_opts(opts))

    request(client, :get, "/", params: query_params)
  end

  def create_db_instance(client, instance_id, username, password, storage, class, engine, opts \\ %{}) do 
    query_params = Map.new
    |> Map.put_new("Action", "CreateDBInstance")
    |> Map.put_new("MasterUsername", username)
    |> Map.put_new("MasterUserPassword", password)
    |> Map.put_new("AllocatedStorage", storage)
    |> Map.put_new("DBInstanceIdentifier", instance_id)
    |> Map.put_new("DBInstanceClass", class)
    |> Map.put_new("Engine", engine)
    |> Map.put_new("Version", @version)
    |> Map.merge(opts)

    request(client, :post, "/", params: query_params)
  end

  def modify_db_instance(client, instance_id, opts \\ %{}) do 
    query_params = Map.new
    |> Map.put_new("Action", "ModifyDBInstance")
    |> Map.put_new("DBInstanceIdentifier", instance_id)
    |> Map.put_new("Version", @version)    
    |> Map.merge(opts)

    request(client, :patch, "/", params: query_params)
  end

  def delete_db_instance(client, instance_id, final_snapshot_id \\ :empty, opts \\ %{}) do 
    query_params = Map.new
    |> Map.put_new("Action", "DeleteDBInstance")
    |> Map.put_new("DBInstanceIdentifier", instance_id)
    |> Map.put_new("Version", @version)

    if final_snapshot_id != :empty do 
      query_params = Map.put_new(query_params, "FinalDBSnapshotIdentifier", final_snapshot_id)
    else
      query_params = Map.put_new(query_params, "SkipFinalSnapshot", true)
    end    

    query_params = Map.merge(query_params, opts)

    request(client, :delete, "/", params: query_params)
  end

  def reboot_db_instance(client, instance_id, failover \\ :empty) do
    query_params = Map.new
    |> Map.put_new("Action", "RebootDBInstance")
    |> Map.put_new("DBInstanceIdentifier", instance_id)
    |> Map.put_new("Version", @version)    

    if failover != :empty do 
      query_params = Map.merge(query_params, %{"Failover" => failover})
    end

    request(client, :get, "/", params: query_params)
  end

  def describe_events(client, opts \\ %{}) do 
    query_params = Map.new
    |> Map.put_new("Action", "DescribeEvents")
    |> Map.put_new("Version", @version)    
    |> Map.merge(opts)

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