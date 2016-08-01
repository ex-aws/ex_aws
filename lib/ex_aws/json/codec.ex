defmodule ExAws.JSON.Codec do
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
      |> Map.new
    end

    def decode(string) do
      {:ok, decode!(string)}
    end
  end
  ```
  """

  @callback encode!(%{}) :: String.t
  @callback encode(%{}) :: {:ok, String.t} | {:error, String.t}

  @callback decode!(String.t) :: %{}
  @callback decode(String.t) :: {:ok, %{}} | {:error, %{}}
end
