defmodule ExAws.Dynamo.Decoder do
  @moduledoc """
    Converts from the dynamo type spec into more native elixir types
  """

  @doc "Convenience function, see decode/2"
  def decode_collection(items, as: struct_module)do
    items |> Stream.map(&decode(&1, struct_module))
  end

  @doc """
    Decodes a dynamo response into a struct.

    If Dynamo.Decodable is implimented for the struct it will be called
    after the completion of the coercion.

    This is important for handling nested maps if you wanted the nested maps
    to have atom keys.
  """
  def decode(item, as: struct_module) do
    item
    |> decode
    |> binary_map_to_struct(struct_module)
    |> ExAws.Dynamo.Decodable.decode
  end

  @doc """
    Convert dynamo format to elixir

    Functions which convert the dynamo style values into normal elixir values.
    Use these if you just want the dynamo result to look more like elixir without
    coercing it into a particular struct.
  """
  def decode(%{"S" => "TRUE"}),   do: true
  def decode(%{"S" => "FALSE"}),  do: false
  def decode(%{"BOOL" => true}),  do: true
  def decode(%{"BOOL" => false}), do: false
  def decode(%{"BOOL" => "true"}),  do: true
  def decode(%{"BOOL" => "false"}), do: false
  def decode(%{"B" => value}),    do: value
  def decode(%{"S" => value}),    do: value
  def decode(%{"M" => value}),    do: value |> decode
  def decode(%{"N" => value}) when is_binary(value), do: binary_to_number(value)
  def decode(%{"N" => value}) when value |> is_integer or value |> is_float, do: value
  def decode(item = %{}) do
    item |> Enum.reduce(%{}, fn({k, v}, map) ->
      Map.put(map, k, decode(v))
    end)
  end

  def binary_to_number(binary) do
    try do
      String.to_float(binary)
    rescue
      ArgumentError -> String.to_integer(binary)
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
