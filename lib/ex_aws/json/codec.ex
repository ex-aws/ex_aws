defmodule ExAws.JSON.Codec do
  use Behaviour

  defcallback encode!(%{}) :: String.t
  defcallback encode(%{}) :: {:ok, String.t} | {:error, String.t}

  defcallback decode!(String.t) :: %{}
  defcallback decode(String.t) :: {:ok, %{}} | {:error, %{}}
end
