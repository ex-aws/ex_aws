defmodule ExAws.Config.Adapter do
  @moduledoc false

  @doc "Retrieve config options"
  @callback get(pid(), config :: map()) :: map()
  @callback get(pid(), config :: map(), profile :: String.t(), expiration :: integer()) :: map()

  defmacro __using__(_params) do
    quote do
      @behaviour ExAws.Config.Adapter

      def get(pid, config), do: config
      def get(pid, config, _profile, _expiration), do: config

      defoverridable [get: 2, get: 4]
    end
  end
end
