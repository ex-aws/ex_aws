defmodule ExAws.JSON.Codec do
  use Behaviour

  defcallback encode!(Map.t) :: String.t
  defcallback encode(Map.t) :: {:ok, String.t} | {:error, String.t}

  defcallback decode!(String.t) :: Map.t
  defcallback decode(String.t) :: {:ok, Map.t} | {:error, Map.t}
end
