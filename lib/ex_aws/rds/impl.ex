defmodule ExAws.RDS.Impl do
  import ExAws.Utils, only: [camelize_keys: 1]

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

  def add_tags_to_resource(client, resource, tags) do
    query_params = %{
      "Action" => "AddTagsToResource",
      "ResourceName" => resource,
      "Version" => @version
    }

    tags_map = %{}

    tags_map =
    for {{k, v}, n} <- Stream.with_index(tags, 1) do
      tags_map
      |> Map.put("Tags.member.#{Integer.to_string(n)}.Key", k)
      |> Map.put("Tags.member.#{Integer.to_string(n)}.Value", v)
    end

    query_params = tags_helper tags_map, query_params

    request(client, :post, "/", params: query_params)
  end

  defp tags_helper([h | []], state), do: Map.merge(state, h)
  defp tags_helper([h | t], state) do
    tags_helper t, Map.merge(state, h)
  end

  def apply_pending_maintenance(client, resource_id, action, opt_in_type) do
    query_params = %{
      "Action" => "ApplyPendingMaintenanceAction",
      "ResourceIdentifier" => resource_id,
      "ApplyAction" => action,
      "OptInType" => opt_in_type,
      "Version" => @version
    }

    request(client, :post, "/", params: query_params)
  end

  def describe_db_instances(client, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeDBInstances",
      "Version" => @version
    })

    request(client, :get, "/", params: query_params)
  end

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

  def describe_events(client, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Action"  => "DescribeEvents",
      "Version" => @version,
      })

    request(client, :get, "/", params: query_params)
  end

  defp request(%{__struct__: client_module} = client, verb, path, data) do
    client_module.request(client, verb, path, data)
  end

  defp normalize_opts(opts) do
    opts
    |> Enum.into(%{})
    |> camelize_keys
  end
end
