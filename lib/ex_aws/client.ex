defmodule ExAws.Client do
  @moduledoc false

  def generate_boilerplate(client, opts) do
    config_boilerplate = create_config_boilerplate(client, opts)
    impl_module = impl_module(client)

    functions = impl_module.__info__(:functions)

    generated_functions = functions
    |> Enum.sort_by(fn {_, var_count} -> var_count end)
    |> Enum.map(&generate_function(&1, impl_module))

    {:__block__, [], [general_boilplate | generated_functions]}
  end

  def create_config_boilerplate(client, opts) do
    quote do
      @moduledoc false
      @otp_app Keyword.get(unquote(opts), :otp_app)
      @behaviour unquote(client)

      @doc false
      def config_root, do: Application.get_env(@otp_app, :ex_aws)

      @doc false
      def config, do: __MODULE__ |> ExAws.Config.get
    end
  end

  ## This generates a function that looks like the following for a client named
  # `ExAws.Example.Client`
  # @doc false
  # def function_name(arg1, arg2) do
  #   ExAws.Example.Impl.function_name(__MODULE__, arg1, arg2)
  # end
  def generate_function({name, var_count}, impl_module) do
    {:def, [], [{name, [], build_variables(var_count - 1)}, [do: {
      # Function call to the Impl.function_name
      {:., [], [impl_module, name]}, [],
      # Function args
      [{:__MODULE__, [], Elixir} | build_variables(var_count - 1)]
    }]]}
  end

  def impl_module(client) do
    client
    |> Atom.to_string
    |> String.replace("Client", "Impl")
    |> String.to_existing_atom
  end

  def build_variables(n) do
    0..1000
    |> Stream.map(&("arg#{&1}"))
    |> Stream.map(&String.to_atom/1)
    |> Enum.take(n)
    |> Enum.map(fn(var) -> {var, [], Elixir} end)
  end

end
