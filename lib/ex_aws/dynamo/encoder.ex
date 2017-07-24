defmodule ExAws.Dynamo.Encoder do
  @moduledoc """
  Takes an elixir value and converts it into a dynamo style map.

  ```elixir
  MapSet.new [1,2,3] |> #{__MODULE__}.encode
  #=> %{"NS" => ["1", "2", "3"]}

  MapSet.new ["A","B","C"] |> #{__MODULE__}.encode
  #=> %{"SS" => ["A", "B", "C"]}

  "bubba" |> ExAws.Dynamo.Encoder.encode
  #=> %{"S" => "bubba"}
  ```

  This is handled via the ExAws.Dynamo.Encodable protocol.
  """

  # These functions exist to ensure that encoding is idempotent.
  def encode(value), do: encode(value, [])
  def encode(%{"B"    => _} = val, _), do: val
  def encode(%{"BOOL" => _} = val, _), do: val
  def encode(%{"BS"   => _} = val, _), do: val
  def encode(%{"L"    => _} = val, _), do: val
  def encode(%{"M"    => _} = val, _), do: val
  def encode(%{"NS"   => _} = val, _), do: val
  def encode(%{"NULL" => _} = val, _), do: val
  def encode(%{"N"    => _} = val, _), do: val
  def encode(%{"S"    => _} = val, _), do: val
  def encode(%{"SS"   => _} = val, _), do: val

  def encode(value, options) do
    ExAws.Dynamo.Encodable.encode(value, options)
  end

  # Use this in case you want to encode something already in dynamo format
  # For some reason I cannot fathom. If you find yourself using this, please open an issue
  # so I can find out why and better support this.
  def encode!(value, options \\ []) do
    ExAws.Dynamo.Encodable.encode(value, options)
  end

  def encode_root(value, options \\ []) do
    case ExAws.Dynamo.Encodable.encode(value, options) do
      %{"M" => value} -> value
      %{"L" => value} -> value
    end
  end

  def atom_to_dynamo_type(:blob),        do: "B"
  def atom_to_dynamo_type(:boolean),     do: "BOOL"
  def atom_to_dynamo_type(:blob_set),    do: "BS"
  def atom_to_dynamo_type(:list),        do: "L"
  def atom_to_dynamo_type(:map),         do: "M"
  def atom_to_dynamo_type(:number_set),  do: "NS"
  def atom_to_dynamo_type(:null),        do: "NULL"
  def atom_to_dynamo_type(:number),      do: "N"
  def atom_to_dynamo_type(:string),      do: "S"
  def atom_to_dynamo_type(:string_set),  do: "SS"
  def atom_to_dynamo_type(value) do
    raise ArgumentError, "Unknown dynamo type for value: #{inspect value}"
  end
end
