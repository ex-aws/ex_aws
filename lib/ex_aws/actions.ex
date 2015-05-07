defmodule ExAws.Actions do

  @moduledoc false

  # Ensures listed actions for a service are defined.
  # Really only used by Kinesis and Dynamo, may be refactored.

  defmacro __using__(_) do
    quote do
      alias unquote(__MODULE__)
      @before_compile unquote(__MODULE__)
      @after_compile unquote(__MODULE__)
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

  defmacro __after_compile__(env, _) do
    module = env.module
    defined_actions = module
    |> Module.definitions_in
    |> Keyword.keys

    module
    |> apply(:__actions__, [])
    |> Map.keys
    |> Enum.filter(&(!Enum.member?(defined_actions, &1)))
    |> Enum.each(fn(action) ->
      IO.puts "#{Path.relative_to_cwd(env.file)}: Action :#{action} listed but not defined in #{module}"
    end)
    nil
  end

  def get(module, action) do
    module |> apply(:__actions__, []) |> Map.get(action)
  end
end
