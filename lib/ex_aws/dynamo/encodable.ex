defprotocol ExAws.Dynamo.Encodable do

  @type t :: any

  @doc "Converts an elixir value into a map tagging the value with its dynamodb type"
  def encode(value, options)
end

defimpl ExAws.Dynamo.Encodable, for: Atom do
  def encode(true, _),  do: %{"BOOL" => "true"}
  def encode(false, _), do: %{"BOOL" => "false"}
  def encode(nil, _), do: %{"NULL" => "true"}
  def encode(value, _), do: %{"S" => value |> Atom.to_string}
end

defimpl ExAws.Dynamo.Encodable, for: Integer do
  def encode(val, _) do
    %{"N" => val |> Integer.to_string}
  end
end

defimpl ExAws.Dynamo.Encodable, for: Float do
  def encode(val, _) do
    %{"N" => String.Chars.Float.to_string(val)}
  end
end

defimpl ExAws.Dynamo.Encodable, for: HashDict do
  def encode(hashdict, _) do
    %{"M" => ExAws.Dynamo.Encodable.Map.do_encode(hashdict)}
  end
end

defimpl ExAws.Dynamo.Encodable, for: Any do

  defmacro __deriving__(module, struct, options) do
    deriving(module, struct, options)
  end

  def deriving(module, _struct, options) do
    extractor = if only = options[:only] do
      quote(do: Map.take(struct, unquote(only)))
    else
      quote(do: :maps.remove(:__struct__, struct))
    end

    quote do
      defimpl ExAws.Dynamo.Encodable, for: unquote(module) do
        def encode(struct, options) do
          ExAws.Dynamo.Encodable.Map.encode(unquote(extractor), options)
        end
      end
    end
  end

  def encode(_, _), do: raise "ExAws.Dynamo.Encodable does not fallback to any"
end

defimpl ExAws.Dynamo.Encodable, for: Map do

  defmacro __deriving__(module, struct, options) do
    ExAws.Dynamo.Encodable.Any.deriving(module, struct, options)
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
      ({_, ""}, map)  -> map

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
  def encode([], _), do: %{"L"  => []}

  @doc """
  Dynamodb offers typed sets and L, a generic list of typed attributes.
  """
  def encode(list, _) do
    typed_values = for value <- list do
      Encodable.encode(value, [])
    end

    %{"L"  => typed_values}
  end
end

defimpl ExAws.Dynamo.Encodable, for: MapSet do
  def encode(mapset, _) do
    cond do
      MapSet.size(mapset) == 0 ->
        raise "Cannot determine a proper data type for an empty MapSet"
      Enum.all?(mapset, &is_number/1) ->
        %{"NS" => number_set_to_list(mapset)}
      Enum.all?(mapset, &is_binary/1) ->
        %{"SS" => MapSet.to_list(mapset)}
      true ->
        raise "All elements in a MapSet must be only numbers or only strings"
    end
  end

  defp number_set_to_list(number_mapset) do
    number_mapset
    |> MapSet.to_list
    |> Enum.map(fn
      (n) when is_integer(n) -> Integer.to_string(n)
      (n) when is_float(n)   -> Float.to_string(n)
    end)
  end
end
