defmodule ExAws.RDS.Impl do
  
  def describe_db_instances(client, opts \\ []) do 
    request(client, :get, "/", params: [action: "DescribeDBInstances"] ++ opts)
  end

  def reboot_db_instance(client, instance_id, failover \\ :empty) do
    opts = %{"DBInstanceIdentifier" => instance_id}

    if failover != :empty do 
      opts = Map.merge(opts, %{"Failover" => failover})
    end

    request(client, :get, "/", 
      params: Map.merge(%{"Action" => "RebootDBInstance"}, opts))
  end

  defp request(%{__struct__: client_module} = client, verb, path, data \\[]) do
    client_module.request(client, verb, path, data)
  end
end