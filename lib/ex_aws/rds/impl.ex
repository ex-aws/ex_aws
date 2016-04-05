defmodule ExAws.RDS.Impl do
  
  def describe_db_instances(client, opts \\ []) do 
    request(client, :get, "", "/", 
      params: [action: "DescribeDBInstances"] ++ opts)
  end

  defp request(%{__struct__: client_module} = client, verb, instance, path, data \\[]) do
    client_module.request(client, verb, instance, path, data)
  end
end