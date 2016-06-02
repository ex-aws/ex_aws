defmodule ExAws.MachineLearning.Client do
  use Behaviour
  alias ExAws.MachineLearning.Request

  @moduledoc """
  The purpose of this module is to surface the ExAws.MachineLearning API with a single
  configuration chosen, such that it does not need passed in with every request.

  Usage:
  ```
  defmodule MyApp.MachineLearning do
    use ExAws.MachineLearning.Client, otp_app: :my_otp_app
  end
  ```

  In your config
  ```
  config :my_otp_app, :ex_aws,
    machinelearning: [], # machinelearning config goes here
  ```

  You can now use MyApp.MachineLearning as the module for the MachineLearning api without needing
  to pass in a particular configuration.
  This enables different otp apps to configure their AWS configuration separately.

  The alignment with a particular OTP app however is entirely optional.
  The following also works:

  ```
  defmodule MyApp.MachineLearning do
    use ExAws.MachineLearning.Client

    def config_root do
      Application.get_all_env(:my_aws_config_root)
    end
  end
  ```
  ExAws now expects the config for that machinelearning client to live under

  ```elixir
  config :my_aws_config_root
    machinelearning: [] # MachineLearning config goes here
  ```

  Default config values can be found in ExAws.Config

  http://docs.aws.amazon.com/kinesis/latest/APIReference/API_Operations.html
  """

  @doc "Request a prediction from a Machine Learning Real-Time Endpoint"
  defcallback predict(record :: %{}) :: ExAws.Request.response_t

  defmacro __using__(opts) do
    boilerplate = __MODULE__
    |> ExAws.Client.generate_boilerplate(opts)

    quote do
      defstruct config: nil, service: :machinelearning
      unquote(boilerplate)

      @doc false
      def request(client, action, data, headers \\ []) do
        ExAws.MachineLearning.Request.request(client, action, data, headers)
      end

      @doc false
      def service, do: :machinelearning

      defoverridable config_root: 0, request: 4
    end
  end
end
