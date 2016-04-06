defmodule ExAws.RDS.Impl do
  
  def describe_db_instances(client, opts \\ %{}) do 
    query_params = Map.new
    |> Map.put_new("Action", "DescribeDBInstances")
    |> Map.merge(opts)

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
    |> Map.merge(opts)

    request(client, :post, "/", params: query_params)
  end

  def delete_db_instance(client, instance_id, opts \\ %{}) do 
    query_params = Map.new
    |> Map.put_new("Action", "DeleteDBInstance")
    |> Map.put_new("DBInstanceIdentifier", instance_id)
    |> Map.merge(opts)

    request(client, :delete, "/", params: query_params)
  end

  def reboot_db_instance(client, instance_id, failover \\ :empty) do
    query_params = Map.new
    |> Map.put_new("Action", "RebootDBInstance")
    |> Map.put_new("DBInstanceIdentifier", instance_id)

    if failover != :empty do 
      query_params = Map.merge(query_params, %{"Failover" => failover})
    end

    request(client, :get, "/", params: query_params)
  end

  defp request(%{__struct__: client_module} = client, verb, path, data \\[]) do
    client_module.request(client, verb, path, data)
  end
end