defmodule ExAws.Dynamo.Coercion do

  @moduledoc """
    Converts from the dynamo type spec into more native elixir types
  """

  def coerce_collection(items, struct_module)do
    items |> Stream.map(&coerce(&1, struct_module))
  end

  def coerce(item, struct_module) do
    item
    |> undynamize
    |> binary_map_to_struct(struct_module)
  end

  def undynamize(%{"S" => "TRUE"}),  do: true
  def undynamize(%{"S" => "FALSE"}), do: false
  def undynamize(%{"BOOL" => "true"}),  do: true
  def undynamize(%{"BOOL" => "false"}), do: false
  def undynamize(%{"B" => value}), do: value
  def undynamize(%{"S" => value}),   do: value
  def undynamize(%{"M" => value}),   do: value |> undynamize
  def undynamize(%{"N" => value}) when is_binary(value), do: binary_to_number(value)
  def undynamize(%{"N" => value}) when value |> is_integer or value |> is_float, do: value
  def undynamize(item = %{}) do
    item |> Enum.reduce(%{}, fn({k, v}, map) ->
      Map.put(map, k, undynamize(v))
    end)
  end

  def binary_to_number(binary) do
    try do
      String.to_float(binary)
    rescue
      e in [ArgumentError] -> String.to_integer(binary)
    end
  end

  def binary_map_to_struct(bmap, module) do
    module.__struct__
      |> Map.from_struct
      |> Enum.reduce(%{}, fn({k, v}, map) ->
        Map.put(map, k, Map.get(bmap, Atom.to_string(k), v))
      end)
      |> Map.put(:__struct__, module)
  end
end
