defmodule ExAws.Utils do
  def camelize_opts(opts = %{}) do
    opts |> Enum.reduce(%{}, fn({k ,v}, map) ->
      Map.put(map, Mix.Utils.camelize(k), camelize_opts(v))
    end)
  end
  def camelize_opts(opts), do: opts
end
