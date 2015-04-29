defmodule ExAws.JSON.Codec do
  use Behaviour

  @moduledoc """
  Defines the specification for a JSON codec.

  ExAws supports the use of your favorite JSON codec provided it fulfills this specification.
  Poison fulfills this spec without modification, and is the default.

  See the contents of `ExAws.JSON.JSX` for an example of an alternative implementation.
  """

  defcallback encode!(%{}) :: String.t
  defcallback encode(%{}) :: {:ok, String.t} | {:error, String.t}

  defcallback decode!(String.t) :: %{}
  defcallback decode(String.t) :: {:ok, %{}} | {:error, %{}}
end
