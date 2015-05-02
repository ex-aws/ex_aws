defmodule ExAws.Client do
  def generate_boilerplate(client) do
    impl_module = impl_module(client)

    functions = impl_module.__info__(:functions)

    generated_functions = functions
    |> Enum.sort_by(fn {_, var_count} -> var_count end)
    |> Enum.map(&generate_function(&1, impl_module))

    {:__block__, [], [{:@, [], [{:doc, [], [false]}]}, generated_functions]}
  end

  def generate_function({name, var_count}, impl_module) do
    {:def, [context: Elixir, import: Kernel],
      [
        {name, [context: Elixir], build_variables(var_count - 1)},
        [do: {
          {:., [], [impl_module, name]}, [],
          [{:__MODULE__, [], Elixir} | build_variables(var_count - 1)]
        }]
      ]
    }
  end

  def impl_module(client) do
    client
    |> Atom.to_string
    |> String.replace("Client", "Impl")
    |> String.to_existing_atom
  end

  def build_variables(n) do
    [:a, :b, :c, :d, :e, :f, :g, :h, :i, :j, :k, :l, :m, :n]
    |> Enum.take(n)
    |> Enum.map(fn(var) -> {var, [], Elixir} end)
  end

end
