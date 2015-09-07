defmodule ExAws.Core.JSON do
  import ExAws.Utils, only: [camelize_key: 1]
  @moduledoc """
  Functionality used by json core files.
  """

  def format_input(%{} = input) do
    Enum.reduce(input, %{}, fn
      {k, v}, formatted when is_atom(k) ->
        Map.put(formatted, camelize_key(k), format_input(v))
      {k, v}, formatted ->
        Map.put(formatted, k, format_input(v))
    end)
  end
  def format_input(input) when is_list(input) do
    Enum.map(input, &format_input/1)
  end
  def format_input(input), do: input
end
