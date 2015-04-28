defmodule ExAws.JSON.Codec do
  use Behaviour

  @moduledoc """
  Defines the specification for a JSON codec.

  ExAws supports the use of your favorite JSON codec provided it fulfills this specification.

  See the contents of `ExAws.JSON.JSX` for an example.
  """

  defcallback encode!(%{}) :: String.t
  defcallback encode(%{}) :: {:ok, String.t} | {:error, String.t}

  defcallback decode!(String.t) :: %{}
  defcallback decode(String.t) :: {:ok, %{}} | {:error, %{}}
end
