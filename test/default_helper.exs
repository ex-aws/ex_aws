## Clients

## Other

defmodule Test.JSONCodec do
  @behaviour ExAws.JSON.Codec

  defdelegate encode!(data), to: Poison
  defdelegate encode(data), to: Poison
  defdelegate decode!(data), to: Poison
  defdelegate decode(data), to: Poison
end
