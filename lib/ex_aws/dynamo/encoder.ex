defmodule ExAws.Dynamo.Encoder do
  @moduledoc """
  Takes an elixir value and converts it into a dynamo style map.

  ```elixir
  [1,2,3] |> #{__MODULE__}.encode
  #=> %{"NS" => ["1", "2", "3"]}

  "bubba" |> ExAws.Dynamo.Encoder.encode
  #=> %{"S" => "bubba"}
  ```

  This is handled via the ExAws.Dynamo.Encodable protocol.
  """

  def encode(value) do
    ExAws.Dynamo.Encodable.encode(value)
  end

  def encode_flat(value) do
    case ExAws.Dynamo.Encodable.encode(value) do
      %{"M" => value} -> value
      %{"L" => value} -> value
    end
  end
end
