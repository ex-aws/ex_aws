defmodule ExAws.Dynamo.Decoder do
  @doc """
  Decodes a dynamo response into a struct.

  If Dynamo.Decodable is implemented for the struct it will be called
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
  def decode(%{"BOOL" => true}),    do: true
  def decode(%{"BOOL" => false}),   do: false
  def decode(%{"BOOL" => "true"}),  do: true
  def decode(%{"BOOL" => "false"}), do: false
  def decode(%{"NULL" => true}),    do: nil
  def decode(%{"NULL" => "true"}),  do: nil
  def decode(%{"B" => value}),      do: value
  def decode(%{"S" => value}),      do: value
  def decode(%{"M" => value}),      do: value |> decode
  def decode(%{"SS" => values}),    do: values
  def decode(%{"BS" => values}),    do: values
  def decode(%{"NS" => values}) do
    Enum.map(values, &binary_to_number/1)
  end
  def decode(%{"L" => values}) do
    Enum.map(values, &decode/1)
  end
  def decode(%{"N" => value}) when is_binary(value), do: binary_to_number(value)
  def decode(%{"N" => value}) when value |> is_integer or value |> is_float, do: value
  def decode(item = %{}) do
    item |> Enum.reduce(%{}, fn({k, v}, map) ->
      Map.put(map, k, decode(v))
    end)
  end

  @doc "Attempts to convert a number to a float, and then an integer"
  def binary_to_number(binary) when is_binary(binary) do
    try do
      String.to_float(binary)
    rescue
      ArgumentError -> String.to_integer(binary)
    end
  end
  def binary_to_number(binary), do: binary

  @doc "Converts a map with binary keys to the specified struct"
  def binary_map_to_struct(bmap, module) do
    module.__struct__
    |> Map.from_struct
    |> Enum.reduce(%{}, fn({k, v}, map) ->
      Map.put(map, k, Map.get(bmap, Atom.to_string(k), v))
    end)
    |> Map.put(:__struct__, module)
  end
end
