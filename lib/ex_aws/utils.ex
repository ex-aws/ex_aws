defmodule ExAws.Utils do

  @moduledoc false

  def camelize_keys(opts) do
    camelize_keys(opts, deep: false)
  end

  # This isn't tail recursive. However, given that the structures
  # being worked upon are relatively shallow, this is ok.
  def camelize_keys(opts = %{}, deep: deep) do
    opts |> Enum.reduce(%{}, fn({k ,v}, map) ->
      if deep do
        Map.put(map, camelize_key(k), camelize_keys(v, deep: true))
      else
        Map.put(map, camelize_key(k), v)
      end
    end)
  end

  def camelize_keys(opts, depth) do
    try do
      opts
      |> Enum.into(%{})
      |> camelize_keys(depth)
    rescue
      [Protocol.UndefinedError, ArgumentError] -> opts
    end
  end

  defp camelize_key(key) when is_atom(key) do
    key
    |> Atom.to_string
    |> Mix.Utils.camelize
  end

  defp camelize_key(key) when is_binary(key) do
    key |> Mix.Utils.camelize
  end
end
