defprotocol ExAws.Dynamo.Decodable do
  @fallback_to_any true

  @moduledoc """
  Allows custom decoding logic for your struct.
  """
  def decode(value)
end

defimpl ExAws.Dynamo.Decodable, for: Any do
  def decode(value), do: value
end
