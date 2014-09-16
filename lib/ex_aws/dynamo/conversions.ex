defmodule ExAws.Dynamo.Conversions do
  def dynamize_attrs(attrs) do
    attrs |> Enum.map(fn({name, type}) ->
      [AttributeName: name, AttributeType: type]
    end)
  end

  # Basic values to their dynamo format
  def dynamize(val) when is_integer(val) do
    [N: val]
  end

  def dynamize(val) when is_binary(val) do
    [S: val]
  end

  def dynamize(true),  do: [S: "TRUE"]
  def dynamize(false), do: [S: "FALSE"]

  # Convert structures and their attributes
  def dynamize(%{__struct__: _} = record) do
    record
      |> Map.from_struct
      |> Map.to_list
      |> Enum.filter(fn({_, v}) -> v end)
      |> Enum.map(fn({k, v}) -> {k, dynamize(v)} end)
  end

  ### Dynamo format to elixir
  ############################

  def coerce_collection(items, struct_module)do
    items |> Enum.map(&coerce(&1, struct_module))
  end

  def coerce(item, struct_module) do
    item
      |> Enum.map(&undynamize/1)
      |> Enum.into(%{})
      |> binary_map_to_struct(struct_module)
  end

  def undynamize({key, [{"S", "TRUE"}]}),  do: {key, true}
  def undynamize({key, [{"S", "FALSE"}]}), do: {key, false}
  def undynamize({key, [{_, value}]}),     do: {key, value}

  def binary_map_to_struct(bmap, module) do
    struct(module)
      |> Map.from_struct
      |> Enum.reduce(%{}, fn({k, v}, map) ->
        Map.put(map, k, Map.get(bmap, Atom.to_string(k), v))
      end)
      |> Map.put(:__struct__, module)
  end
end
