defmodule ExAws.Dynamo.Conversion.TypeError do
  defexception [:message]

  def exception(msg) do
    %__MODULE__{message: msg}
  end
end

defprotocol ExAws.Dynamo.Conversion do
  @doc "Converts an elixir value into a map tagging the value with its dynamodb type"
  def dynamize(value)
end

defimpl ExAws.Dynamo.Conversion, for: Atom do
  def dynamize(true),  do: %{BOOL: "true"}
  def dynamize(false), do: %{BOOL: "false"}
  def dynamize(value), do: %{S: value |> Atom.to_string}
end

defimpl ExAws.Dynamo.Conversion, for: Integer do
  def dynamize(val) do
    %{N: val |> Integer.to_string}
  end
end

defimpl ExAws.Dynamo.Conversion, for: Float do
  def dynamize(val) do
    %{N: val |> Float.to_string}
  end
end

defimpl ExAws.Dynamo.Conversion, for: [Map, HashDict] do
  def dynamize(%{__struct__: _} = struct) do
    %{M: val} = struct
    |> Map.from_struct
    |> dynamize
    val
  end
  def dynamize(map) do
    map = Enum.reduce(map, %{}, fn
      ({_, nil}, map) -> map
      ({_, []}, map)  -> map
      ({k, v}, map)   -> Map.put(map, k, ExAws.Dynamo.Conversion.dynamize(v))
    end)
    %{M: map}
  end
end

defimpl ExAws.Dynamo.Conversion, for: BitString do
  def dynamize(val) do
    %{S: val}
  end
end

defimpl ExAws.Dynamo.Conversion, for: List do
  alias ExAws.Dynamo.Conversion
  def dynamize([]) do
    raise Conversion.TypeError, "cannot have an empty set"
  end
  @doc """
    Dynamodb offers typed sets and L, a generic list of typed attributes.
    This
  """
  def dynamize(list) do
    typed_values = list
    |> Enum.map(&Conversion.dynamize/1)

    {types, values} = Enum.reduce(typed_values, {[], []}, fn(item, {types, values}) ->
      {type, value} = item
      |> Map.to_list
      |> hd
      {[type | types], [value, values]}
    end)

    case types |> Enum.uniq do
      [B] -> %{BS: values}
      [N] -> %{NS: values}
      [S] -> %{SS: values}
      _   -> %{L: typed_values}
    end
  end
end
