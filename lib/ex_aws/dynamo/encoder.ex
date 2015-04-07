defmodule ExAws.Dynamo.Encoder do
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
