defprotocol ExAws.GameLift.Encodable do
      @type t :: any
      @doc "Converts an elixir value into a map tagging the value with its gamelift type"
      def encode(value, options)
end
    
    defimpl ExAws.GameLift.Encodable, for: Atom do
      def encode(value, _), do: %{"S" => value |> Atom.to_string}
    end
    
    defimpl ExAws.GameLift.Encodable, for: Integer do
      def encode(val, _) do
        %{"N" => val}
      end
    end
    
    defimpl ExAws.GameLift.Encodable, for: Float do
      def encode(val, _) do
        %{"N" => val}
      end
    end
    
    defimpl ExAws.GameLift.Encodable, for: HashDict do
      def encode(hashdict, _) do
        %{"M" => ExAws.GameLift.Encodable.Map.do_encode(hashdict)}
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
    
      def encode(_, _), do: raise "ExAws.Dynamo.Encodable does not fallback to any"
    end
    
    defimpl ExAws.GameLift.Encodable, for: Map do
    
      defmacro __deriving__(module, struct, options) do
        ExAws.GameLift.Encodable.Any.deriving(module, struct, options)
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
            Map.put(map, k, ExAws.GameLift.Encodable.encode(v, []))
          ({k, v}, map)   ->
            key = String.Chars.to_string(k)
            Map.put(map, key, ExAws.GameLift.Encodable.encode(v, []))
        end)
      end
    end
    
    defimpl ExAws.GameLift.Encodable, for: BitString do
      def encode(val, _) do
        %{"S" => val}
      end
    end
