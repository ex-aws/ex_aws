defmodule ExAws.Kinesis.Client do
  use Behaviour

  @moduledoc """
  Defines a Kinesis client.

  Usage:
  ```
  defmodule MyApp.Kinesis do
    use ExAws.Kinesis.Client, otp_app: :my_otp_app
  end
  ```

  In your config
  ```
  config :my_otp_app, :ex_aws,
    kinesis:  [], # kinesis config goes here
    dynamodb: [], # you get the idea
  ```

  You can now use MyApp.Kinesis as the root module for the Kinesis api without needing
  to pass in a particular configuration.
  This enables different otp apps to configure their AWS configuration separately.

  The alignment with a particular OTP app however is entirely optional.
  The following also works:

  ```
  defmodule MyApp.Kinesis do
    use ExAws.Kinesis.Client

    def config_root do
      Application.get_all_env(:my_aws_config_root)
    end
  end
  ```
  ExAws now expects the config for that kinesis client to live under

  ```elixir
  config :my_aws_config_root
    kinesis: [] # Kinesis config goes here
  ```

  Default config values can be found in ExAws.Config

  http://docs.aws.amazon.com/kinesis/latest/APIReference/API_Operations.html
  """

  ## Streams

  @doc "Lists streams"
  defcallback list_streams() :: ExAws.Request.response_t

  @doc "Describe Stream"
  defcallback describe_stream(stream_name :: iodata) :: ExAws.Request.response_t
  defcallback describe_stream(stream_name :: iodata, opts :: %{}) :: ExAws.Request.response_t

  @doc """
  Same as describe_stream/1,2 except the shards key is a stream and will automatically handle pagination
  Returns the normally shaped AWS response, except the Shards key is now a stream
  """
  defcallback stream_shards(stream_name :: iodata) :: ExAws.Request.response_t
  defcallback stream_shards(stream_name :: iodata :: %{}) :: ExAws.Request.response_t

  @doc "Creates stream"
  defcallback create_stream(stream_name :: iodata) :: ExAws.Request.response_t
  defcallback create_stream(stream_name :: iodata, shard_count :: pos_integer) :: ExAws.Request.response_t

  @doc "Deletes stream"
  defcallback delete_stream(stream_name :: iodata) :: ExAws.Request.response_t

  ## Records

  @doc "Get stream records"
  defcallback get_records(shard_iterator :: iodata) :: ExAws.Request.response_t
  defcallback get_records(shard_iterator :: iodata, opts :: %{}) :: ExAws.Request.response_t

  @doc """
  Returns a stream of kinesis records
  NOTE: This stream is basically INFINITE, in that it runs
  until the shard it is reading from closes, which may be never.
  If you want it to take records until there are no more (at the moment), something like

  ```
  Kinesis.stream_records("my-stream")
  |> Enum.take_while(fn(val) -> !match?(%{"Data" => []}, val))
  ```
  ought to do the trick.

  The optional iterator_fun is a function that is called after every actual AWS request.
  Generally speaking you won't need this, but it can be handy if you're trying to prevent flooding.
  See Mix.Tasks.Kinesis.Tail.get_records/1 for an example.
  """
  defcallback stream_records(shard_iterator :: iodata)# :: Stream.t
  defcallback stream_records(shard_iterator :: iodata, opts :: %{})# :: Stream.t
  defcallback stream_records(shard_iterator :: iodata, opts :: %{}, iterator_fun :: Fun)# :: Stream.t

  @doc "Puts a record on a stream"
  defcallback put_record(stream_name :: iodata, partition_key :: iodata, blob :: iodata) :: ExAws.Request.response_t
  defcallback put_record(stream_name :: iodata, partition_key :: iodata, blob :: iodata, opts :: %{}) :: ExAws.Request.response_t

  @doc "Put multiple records on a stream"
  defcallback put_records(stream_name :: iodata, records :: [%{}]) :: ExAws.Request.response_t

  ## Shards

  @doc """
  Get a shard iterator
  @type shard_iterator_types :: "AT_SEQUENCE_NUMBER"
    | "AFTER_SEQUENCE_NUMBER"
    | "TRIM_HORIZON"
    | "LATEST"
  """
  defcallback get_shard_iterator(stream_name :: iodata, shard_id :: iodata, shard_iterator_type :: iodata) :: ExAws.Request.response_t
  defcallback get_shard_iterator(stream_name :: iodata, shard_id :: iodata, shard_iterator_type :: iodata, opts :: %{}) :: ExAws.Request.response_t

  @doc "Merge adjacent shards"
  defcallback merge_shards(stream_name :: iodata, adjacent_shard_id :: iodata, shard_id :: iodata) :: ExAws.Request.response_t

  @doc "Split a shard"
  defcallback split_shard(name :: iodata, shard :: iodata, new_starting_hash_key :: iodata) :: ExAws.Request.response_t

  ## Tags

  @doc "Add tags to stream"
  defcallback add_tags_to_stream(name :: iodata, tags :: %{}) :: ExAws.Request.response_t

  @doc "Add tags to stream"
  defcallback list_tags_for_stream(name :: iodata)
  defcallback list_tags_for_stream(name :: iodata, opts :: %{}) :: ExAws.Request.response_t

  @doc "Remove tags from stream"
  defcallback remove_tags_from_stream(name :: iodata , tag_keys :: [binary]) :: ExAws.Request.response_t

  @doc """
  Enables custom request handling.

  By default this just forwards the request to the `ExAws.Kinesis.Request.request/2`.
  However, this can be overriden in your client to provide pre-request adjustments to headers, params, etc.
  """
  defcallback request(data :: %{}, action :: atom)

  @doc "Service"
  defcallback service() :: atom

  @doc "Retrieves the root AWS config for this client"
  defcallback config_root() :: Keyword.t

  @doc "Returns the canonical configuration for this service"
  defcallback config() :: Keyword.t

  defmacro __using__(opts) do
    boilerplate = __MODULE__
    |> ExAws.Client.generate_boilerplate

    quote do
      @otp_app Keyword.get(unquote(opts), :otp_app)
      @behaviour unquote(__MODULE__)

      @moduledoc false

      unquote(boilerplate)

      @doc false
      def request(data, action) do
        ExAws.Kinesis.Request.request(__MODULE__, action, data)
      end

      @doc false
      def service, do: :kinesis

      @doc false
      def config_root, do: Application.get_env(@otp_app, :ex_aws)

      @doc false
      def config, do: __MODULE__ |> ExAws.Config.get

      defoverridable config_root: 0, request: 2
    end
  end
end
