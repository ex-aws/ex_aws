defmodule ExAws.RDS.Client do
  use Behaviour

  @moduledoc """
  The purpose of this module is to surface the ExAws.RDS API tied to a single
  configuration chosen, sich that it does not need passed in with every request.

  Usage:
  ```
  defmodule MyApp.RDS do 
    use ExAws.RDS.Client, otp_app: :my_otp_app
  end
  ```

  In your config
  ```
  config :my_otp_app, :ex_aws,
    rds: [], # RDS config goes here
  ```
  """

  defcallback describe_db_instances() :: ExAws.Request.response_t

  defmacro __using__(opts) do 

    boilerplate = __MODULE__
    |> ExAws.Client.generate_boilerplate(opts)
     quote do 
      defstruct config: nil, service: :rds
      unquote(boilerplate)

      @doc false
      def request(client, http_method, instance, path, data \\ []) do
        ExAws.RDS.Request.request(client, http_method, instance, path, data)
      end

      defoverridable config_root: 0, request: 4, request: 5
     end
  end
end