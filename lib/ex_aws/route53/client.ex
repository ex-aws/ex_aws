defmodule ExAws.Route53.Client do
  use Behaviour

  @doc "Retrieves a list of all the hosted zones"
  defcallback list_hosted_zones() :: Route53.Request.response_t

  defmacro __using__(opts) do
    boilerplate = __MODULE__
    |> ExAws.Client.generate_boilerplate(opts)

    quote do
      defstruct config: nil, service: :route53
      unquote(boilerplate)

      @doc false
      def request(client, method, path, params) do
        ExAws.Route53.Request.request(client, method, path, params)
      end

      defoverridable config_root: 0, request: 4

    end
  end
end