defmodule ExAws.Dynamo.Encodable.TypeError do
  defexception [:message]

  def exception(msg) do
    %__MODULE__{message: msg}
  end
end

defprotocol ExAws.Dynamo.Encodable do
  @doc "Converts an elixir value into a map tagging the value with its dynamodb type"
  def encode(value)
end

defimpl ExAws.Dynamo.Encodable, for: Atom do
  def encode(true),  do: %{"BOOL" => "true"}
  def encode(false), do: %{"BOOL" => "false"}
  def encode(value), do: %{"S" => value |> Atom.to_string}
end

defimpl ExAws.Dynamo.Encodable, for: Integer do
  def encode(val) do
    %{"N" => val |> Integer.to_string}
  end
end

defimpl ExAws.Dynamo.Encodable, for: Float do
  def encode(val) do
    %{"N" => val |> Float.to_string}
  end
end

defimpl ExAws.Dynamo.Encodable, for: [Map, HashDict] do
  def encode(%{__struct__: _} = struct) do
    %{"M" => val} = struct
    |> Map.from_struct
    |> encode
    val
  end
  def encode(map) do
    map = Enum.reduce(map, %{}, fn
      ({_, nil}, map) -> map
      ({_, []}, map)  -> map
      ({k, v}, map) when is_binary(k) ->
        Map.put(map, k, ExAws.Dynamo.Encodable.encode(v))
      ({k, v}, map)   ->
        key = String.Chars.to_string(k)
        Map.put(map, key, ExAws.Dynamo.Encodable.encode(v))
    end)
    %{"M" => map}
  end
end

defimpl ExAws.Dynamo.Encodable, for: BitString do
  def encode(val) do
    %{"S" => val}
  end
end

defimpl ExAws.Dynamo.Encodable, for: List do
  alias ExAws.Dynamo.Encodable
  def encode([]) do
    raise Encodable.TypeError, "cannot have an empty set"
  end

  @doc """
    Dynamodb offers typed sets and L, a generic list of typed attributes.

    If all items in the list have the same dynamo type, This will return the
    corrosponding Dynamo type set ie
    [%{"N" => 1},%{"N" => 2}] #=> %{"NS" => [1,2]}

    Otherwise, it will use the generic list type ie
    [%{"N" => 1},%{"S" => "Foo"}] #=> %{"L" => [%{"N" => 1},%{"S" => "Foo"}]}
  """
  def encode(list) do
    typed_values = list
    |> Enum.map(&Encodable.encode/1)

    {types, values} = Enum.reduce(typed_values, {[], []}, fn(item, {types, values}) ->
      {type, value} = item
      |> Map.to_list
      |> hd
      {[type | types], [value, values]}
    end)

    case types |> Enum.uniq do
      ["B"] -> %{"BS" => values}
      ["N"] -> %{"NS" => values}
      ["S"] -> %{"SS" => values}
      _     -> %{"L"  => typed_values}
    end
  end
end
