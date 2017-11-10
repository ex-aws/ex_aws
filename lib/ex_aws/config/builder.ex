defmodule ExAws.Config.Builder do

  def get_partitions() do
    :ex_aws
    |> :code.priv_dir()
    |> Path.join("endpoints.json")
    |> File.read!
    |> Poison.decode!
    |> Map.get("partitions")
    |> Map.new(fn partition ->
      {partition["partition"], partition}
    end)
  end
end
