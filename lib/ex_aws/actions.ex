defmodule ExAws.Actions do
  defmacro __using__(_) do
    quote do
      alias unquote(__MODULE__)
      @before_compile unquote(__MODULE__)
    end
  end

  defmacro __before_compile__(_) do
    quote do
      @action_map @actions |> Enum.reduce(%{}, fn({action, method}, actions) ->
        name = action |> Atom.to_string |> Mix.Utils.camelize
        Map.put(actions, action, {"#{@namespace}.#{name}", method})
      end)
      def __actions__, do: @action_map
    end
  end

  def get(module, action) do
    module.__actions__ |> Map.get(action)
  end
end
