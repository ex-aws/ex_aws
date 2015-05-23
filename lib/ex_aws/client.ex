defmodule ExAws.Client do
  @moduledoc false

  # Generates boilerplate for client configuration and implementation.
  # It uses the functions in Impl as the list to generate from, so that
  # the built in behaviour checking logic can operate normally.
  #
  # However, the impl list is filtered according to the callback list

  def generate_boilerplate(client, opts) do
    config_boilerplate = create_config_boilerplate(client, opts)

    {:module, impl_module} = impl_module(client)
    functions = impl_module.__info__(:functions)

    generated_functions = functions
    |> Enum.sort_by(&elem(&1, 1))
    |> Enum.map(&generate_function(&1, impl_module))

    {:__block__, [], [config_boilerplate | generated_functions]}
  end

  def create_config_boilerplate(client, opts) do
    quote do
      @moduledoc false
      @otp_app Keyword.get(unquote(opts), :otp_app)
      @behaviour unquote(client)

      def new(opts \\ []) do
        config = config()
        |> Map.merge(opts |> Enum.into(%{}))
        %__MODULE__{config: config}
      end

      @doc false
      def config_root, do: Application.get_env(@otp_app, :ex_aws)

      @doc false
      def config, do: %__MODULE__{} |> ExAws.Config.get
    end
  end

  ## This generates a function that looks like the following for a client named
  # `ExAws.Example.Client`
  # @doc false
  # def function_name(arg1, arg2, ...) do
  #   ExAws.Example.Impl.function_name(__MODULE__, arg1, arg2, ....)
  # end
  def generate_function({name, var_count}, impl_module) do
    arguments = build_arguments(var_count - 1)
    {:def, [], [{name, [], arguments}, [do: {
      # Function call to the Impl.function_name
      {:., [], [impl_module, name]}, [],
      # Append client_data to the function arguments passed to
      # The implementation function.
      [new_client_struct | arguments]
    }]]}
  end

  def new_client_struct do
    quote do: __MODULE__.new
  end

  # ExAws.Dynamo.Client #=> ExAws.Dynamo.Impl
  def impl_module(client) do
    client
    |> Atom.to_string
    |> String.replace("Client", "Impl")
    |> String.to_atom
    |> Code.ensure_compiled
  end

  def build_arguments(n) when n > 0 do
    Stream.iterate(0, &(&1 + 1))
    |> Stream.map(&("arg#{&1}"))
    |> Stream.map(&String.to_atom/1)
    |> Enum.take(n)
    |> Enum.map(fn(var) -> {var, [], Elixir} end)
  end

  def build_arguments(_), do: []

end
