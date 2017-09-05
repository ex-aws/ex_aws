defprotocol ExAws.GameLift.Encodable do
  @type t :: any
  @doc "Converts an elixir value into a map tagging the value with its gamelift type"
  def encode(value, options \\ [])
  def encode(value, options)
end

defimpl ExAws.GameLift.Encodable, for: Atom do
  def encode(atom, _), do: %{"S" => Atom.to_string(atom)}
end

defimpl ExAws.GameLift.Encodable, for: BitString do
  def encode(string, _), do: %{"S" => string}
end

defimpl ExAws.GameLift.Encodable, for: Integer do
  def encode(int, _), do: %{"N" => int}
end

defimpl ExAws.GameLift.Encodable, for: Float do
  def encode(float, _), do: %{"N" => float}
end

defimpl ExAws.GameLift.Encodable, for: List do
  def encode(list, _), do: %{"SL" => Enum.map(list, &to_string/1)}
end

defimpl ExAws.GameLift.Encodable, for: Map do
  defmacro __deriving__(module, struct, options) do
    ExAws.GameLift.Encodable.Any.deriving(module, struct, options)
  end

  def encode(map, options) do
    %{"SDM" => do_encode(map, options)}
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
    map
    |> Stream.map(fn {k, v} when is_number(v) -> {to_string(k), v} end)
    |> Enum.into(%{})
  end
end

defimpl ExAws.GameLift.Encodable, for: Any do
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
      defimpl ExAws.GameLift.Encodable, for: unquote(module) do
        def encode(struct, options) do
          ExAws.GameLift.Encodable.Map.encode(unquote(extractor), options)
        end
      end
    end
  end

  def encode(_, _), do: raise "ExAws.GameLift.Encodable does not fallback to any"
end
