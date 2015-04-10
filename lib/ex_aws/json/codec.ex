defmodule ExAws.JSON.Codec do
  use Behaviour

  defcallback encode!(Map.t) :: String.t
  defcallback encode(Map.t) :: {:ok, String.t} | {:error, String.t}

  defcallback decode!(String.t) :: %{}
  defcallback decode(String.t) :: {:ok, %{}} | {:error, %{}}
end
