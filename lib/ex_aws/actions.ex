defmodule ExAws.Actions do
  defmacro __using__(_) do
    quote do
      @before_compile unquote(__MODULE__)
    end
  end

  defmacro __before_compile__(_) do
    quote do
      @action_map @actions |> Enum.reduce(%{}, fn(action, actions) ->
        name = action |> Atom.to_string |> Mix.Utils.camelize
        Map.put(actions, action, "#{@namespace}.#{name}")
      end)

      def list, do: @actions
      def get(op), do: @action_map |> Map.get(op)

    end
  end
end
