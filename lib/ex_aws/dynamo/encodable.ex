defprotocol ExAws.Dynamo.Encodable do

  @type t :: any

  @doc "Converts an elixir value into a map tagging the value with its dynamodb type"
  def encode(value, options)
end

defimpl ExAws.Dynamo.Encodable, for: Atom do
  def encode(true, _),  do: %{"BOOL" => "true"}
  def encode(false, _), do: %{"BOOL" => "false"}
  def encode(value, _), do: %{"S" => value |> Atom.to_string}
end

defimpl ExAws.Dynamo.Encodable, for: Integer do
  def encode(val, _) do
    %{"N" => val |> Integer.to_string}
  end
end

defimpl ExAws.Dynamo.Encodable, for: Float do
  def encode(val, _) do
    %{"N" => val |> Float.to_string}
  end
end

defimpl ExAws.Dynamo.Encodable, for: HashDict do
  def encode(hashdict, _) do
    %{"M" => ExAws.Dynamo.Encodable.Map.do_encode(hashdict)}
  end
end

defimpl ExAws.Dynamo.Encodable, for: Map do

  defmacro __deriving__(module, struct, options) do
    deriving(module, struct, options)
  end

  def deriving(module, _struct, options) do
    if only = options[:only] do
      extractor = quote(do: Map.take(struct, unquote(only)))
    else
      extractor = quote(do: :maps.remove(:__struct__, struct))
    end

    quote do
      defimpl ExAws.Dynamo.Encodable, for: unquote(module) do
        def encode(struct, options) do
          ExAws.Dynamo.Encodable.Map.encode(unquote(extractor), options)
        end
      end
    end
  end

  def encode(map, options) do
    %{"M" => do_encode(map, options)}
  end

  def do_encode(map, [only: only]) do
    map
    |> Map.take(only)
    |> do_encode
  end
  def do_encode(map, [except: except]) do
    :maps.without(except, map)
    |> do_encode
  end
  def do_encode(map, _), do: do_encode(map)
  def do_encode(map) do
    Enum.reduce(map, %{}, fn
      ({_, nil}, map) -> map
      ({_, []}, map)  -> map

      ({k, v}, map) when is_binary(k) ->
        Map.put(map, k, ExAws.Dynamo.Encodable.encode(v, []))
      ({k, v}, map)   ->
        key = String.Chars.to_string(k)
        Map.put(map, key, ExAws.Dynamo.Encodable.encode(v, []))
    end)
  end
end

defimpl ExAws.Dynamo.Encodable, for: BitString do
  def encode(val, _) do
    %{"S" => val}
  end
end

defimpl ExAws.Dynamo.Encodable, for: List do
  alias ExAws.Dynamo.Encodable
  def encode([], _), do: []

  @doc """
  Dynamodb offers typed sets and L, a generic list of typed attributes.

  If all items in the list have the same dynamo type, This will return the
  corrosponding Dynamo type set ie
  [%{"N" => 1},%{"N" => 2}] #=> %{"NS" => [1,2]}

  Otherwise, it will use the generic list type ie
  [%{"N" => 1},%{"S" => "Foo"}] #=> %{"L" => [%{"N" => 1},%{"S" => "Foo"}]}
  """
  def encode(list, _) do
    typed_values = list
    |> Enum.map(&Encodable.encode(&1, []))

    {types, values} = Enum.reduce(list, {[], []}, fn(item, {types, values}) ->
      [{type, value}] = item
      |> Encodable.encode([])
      |> Map.to_list

      {[type | types], [value | values]}
    end)

    case types |> Enum.uniq do
      ["B"] -> %{"BS" => values |> Enum.reverse}
      ["N"] -> %{"NS" => values |> Enum.reverse}
      ["S"] -> %{"SS" => values |> Enum.reverse}
      _     -> %{"L"  => typed_values}
    end
  end
end
