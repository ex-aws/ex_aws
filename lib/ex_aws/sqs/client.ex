defmodule ExAws.SQS.Client do
  use Behaviour

  @moduledoc """
  """
  
  defmacro __using__(opts) do
    boilerplate = __MODULE__
    |> ExAws.Client.generate_boilerplate(opts)

    quote do
      unquote(boilerplate)

      @doc false
      def request(queue_name, action, params \\ []) do
        ExAws.SQS.Request.request(__MODULE__, queue_name, action, params)
      end

      @doc false
      def service, do: :sqs

      defoverridable config_root: 0, request: 2, request: 3
  
    end     
  end
end
