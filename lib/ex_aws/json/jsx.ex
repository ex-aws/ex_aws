defmodule ExAws.JSON.JSX do
  @behaviour ExAws.JSON.Codec

  @moduledoc false

  def encode!(%{} = map) do
    map |> :jsx.encode
  end

  def encode(map) do
    try do
      {:ok, encode!(map)}
    rescue
      ArgumentError -> {:error, :badarg}
    end
  end

  def decode!(string) do
    :jsx.decode(string, [:return_maps])
  end

  def decode(string) do
    try do
      {:ok, decode!(string)}
    rescue
      ArgumentError -> {:error, :badarg}
    end
  end
end
