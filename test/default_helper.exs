## Clients

## Other

defmodule Test.JSONCodec do
  @behaviour ExAws.JSON.Codec

  defdelegate encode!(data), to: Jason
  defdelegate encode(data), to: Jason
  defdelegate decode!(data), to: Jason
  defdelegate decode(data), to: Jason
end
