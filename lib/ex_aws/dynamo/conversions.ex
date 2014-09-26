defmodule ExAws.Dynamo.Conversions do
  def dynamize_attrs(attrs) do
    attrs |> Enum.map(fn({name, type}) ->
      %{AttributeName: name, AttributeType: type}
    end)
  end

  # Basic values to their dynamo format
  def dynamize(val) when is_integer(val) do
    %{N: val |> Integer.to_string}
  end

  def dynamize(val) when is_binary(val) do
    %{S: val}
  end

  def dynamize(true),  do: %{S: "TRUE"}
  def dynamize(false), do: %{S: "FALSE"}

  # Convert structures and their attributes
  def dynamize(%{__struct__: _} = record) do
    record
      |> Map.from_struct
      |> dynamize
    end

  def dynamize(%{} = map) do
    map |> Enum.reduce(%{}, fn
      ({k, v}, map) when not is_nil(v) -> Map.put(map, k, dynamize(v))
      (_, map) -> map
    end)
  end

  ### Dynamo format to elixir
  ############################

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
  def undynamize(%{"S" => value}),   do: value
  def undynamize(%{"N" => value}) when is_binary(value), do: String.to_integer(value)
  def undynamize(%{"N" => value}) when is_integer(value), do: value
  def undynamize(item = %{}) do
    item |> Enum.reduce(%{}, fn({k, v}, map) ->
      Map.put(map, k, undynamize(v))
    end)
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
