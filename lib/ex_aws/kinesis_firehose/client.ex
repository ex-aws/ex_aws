defmodule ExAws.KinesisFirehose.Client do
  use Behaviour
  alias ExAws.KinesisFirehose.Request

  @moduledoc """
  Defines a Kinesis Firehose client.

  Usage:
  ```
  defmodule MyApp.KinesisFirehose do
    use ExAws.KinesisFirehose.Client, otp_app: :my_otp_app
  end
  ```

  In your config
  ```
  config :my_otp_app, :ex_aws,
    kinesis:  [], # kinesis config goes here
    dynamodb: [], # you get the idea
  ```

  You can now use MyApp.KinesisFirehose as the root module for the Kinesis Firehose api without needing
  to pass in a particular configuration.
  This enables different otp apps to configure their AWS configuration separately.

  The alignment with a particular OTP app however is entirely optional.
  The following also works:

  ```
  defmodule MyApp.KinesisFirehose do
    use ExAws.KinesisFirehose.Client

    def config_root do
      Application.get_all_env(:my_aws_config_root)
    end
  end
  ```
  ExAws now expects the config for that kinesis client to live under

  ```elixir
  config :my_aws_config_root
    kinesis: [] # KinesisFirehose config goes here
  ```

  Default config values can be found in ExAws.Config

  http://docs.aws.amazon.com/firehose/latest/APIReference/API_Operations.html
  """

  ## Streams

  @type stream_name :: binary

  @doc "Lists streams"
  @type list_delivery_stream_opts :: [
    {:exclusive_start_delivery_stream_name, binary} |
    {:limit, pos_integer}
  ]
  defcallback list_delivery_streams() :: Request.response_t
  defcallback list_delivery_streams(opts :: list_delivery_stream_opts) :: Request.response_t

  @doc "Describe Stream"
  @type describe_delivery_stream_opts :: [
    {:limit, pos_integer} |
    {:exclusive_start_destination_id, binary}
  ]
  defcallback describe_delivery_stream(stream_name :: stream_name) :: Request.response_t
  defcallback describe_delivery_stream(stream_name :: stream_name, opts :: describe_delivery_stream_opts) :: Request.response_t

  @doc "Creates stream"
  @type create_delivery_stream_opts :: [
    {:elasticsearch_destination_configuration, Keyword.t} |
    {:redshift_destination_configuration, Keyword.t} |
    {:s3_destination_configuration, Keyword.t}
  ]
  defcallback create_delivery_stream(stream_name :: stream_name) :: Request.response_t
  defcallback create_delivery_stream(stream_name :: stream_name, opts :: create_delivery_stream_opts) :: Request.response_t

  @doc "Deletes stream"
  defcallback delete_delivery_stream(stream_name :: stream_name) :: Request.response_t

  ## Records

  @doc "Puts a record on a stream"
  defcallback put_record(stream_name :: stream_name, data :: binary) :: Request.response_t

  @doc "Put multiple records on a stream"
  @type put_record_batch_record :: [
    {:data, binary}
  ]
  defcallback put_record_batch(stream_name :: stream_name, records :: [put_record_batch_record]) :: Request.response_t

  ## Destinations

  @doc "Updates the specified destination of the specified delivery stream."
  @type update_destination_opts :: [
    {:elasticsearch_destination_update, Keyword.t} |
    {:redshift_destination_update, Keyword.t} |
    {:s3_destination_update, Keyword.t}
  ]
  defcallback update_destination(stream_name :: stream_name, version_id :: binary, destination_id :: binary) :: Request.response_t
  defcallback update_destination(stream_name :: stream_name, version_id :: binary, destination_id :: binary, opts :: update_destination_opts) :: Request.response_t

  @doc """
  Enables custom request handling.

  By default this just forwards the request to the `ExAws.KinesisFirehose.Request.request/2`.
  However, this can be overriden in your client to provide pre-request adjustments to headers, params, etc.
  """
  defcallback request(client :: %{}, data :: %{}, action :: atom)

  @doc "Retrieves the root AWS config for this client"
  defcallback config_root() :: Keyword.t

  defmacro __using__(opts) do
    boilerplate = __MODULE__
    |> ExAws.Client.generate_boilerplate(opts)

    quote do
      defstruct config: nil, service: :kinesis
      unquote(boilerplate)

      @doc false
      def request(client, action, data) do
        ExAws.KinesisFirehose.Request.request(client, action, data)
      end

      defoverridable config_root: 0, request: 3
    end
  end
end
