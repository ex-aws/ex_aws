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
