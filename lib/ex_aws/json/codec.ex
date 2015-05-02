defmodule ExAws.JSON.Codec do
  use Behaviour

  @moduledoc """
  Defines the specification for a JSON codec.

  ExAws supports the use of your favorite JSON codec provided it fulfills this specification.
  Poison fulfills this spec without modification, and is the default.

  See the contents of `ExAws.JSON.JSX` for an example of an alternative implementation.
  ## Example
  Here for example is the code required to make HTTPotion comply with this spec.

  In your config you would do:

  ```elixir
  config :ex_aws,
    json_codec: ExAws.JSON.JSX
  ```

  ```elixir
  defmodule ExAws.JSON.JSX do
    @behaviour ExAws.JSON.Codec

    @moduledoc false

    def encode!(%{} = map) do
      map
      |> Map.to_list
      |> :jsx.encode
      |> case do
        "[]" -> "{}"
        val -> val
      end
    end

    def encode(map) do
      {:ok, encode!(map)}
    end

    def decode!(string) do
      :jsx.decode(string)
      |> Enum.into(%{})
    end

    def decode(string) do
      {:ok, decode!(string)}
    end
  end
  ```
  """

  defcallback encode!(%{}) :: String.t
  defcallback encode(%{}) :: {:ok, String.t} | {:error, String.t}

  defcallback decode!(String.t) :: %{}
  defcallback decode(String.t) :: {:ok, %{}} | {:error, %{}}
end
