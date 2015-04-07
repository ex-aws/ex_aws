defmodule ExAws.Kinesis.Adapter do
  use Behaviour

  @moduledoc """
    The purpose of this module is to surface the ExAws.Kinesis API with a single
    configuration chosen, such that it does not need passed in with every request.

    Usage:
    ```
    defmodule MyApp.Kinesis do
      use ExAws.Kinesis.Adapter, otp_app: :my_otp_app
    end
    ```

    In your config
    ```
    config :my_otp_app, ExAws,
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
      use ExAws.Kinesis.Adapter

      def config do
        [
          kinesis:  [], # kinesis config goes here
          dynamodb: [], # you get the idea
        ]
      end
    end
    ```

    This is in fact how the functions in ExAws.Kinesis that do not require a config work.
    Default config values can be found in ExAws.Config
  """

  ## Streams

  @doc "Lists streams"
  defcallback list_streams()

  @doc "Describe Stream"
  defcallback describe_stream(stream_name :: iodata)
  defcallback describe_stream(stream_name :: iodata, opts :: %{})

  @doc """
    Same as describe_stream/1,2 except the shards key is a stream and will automatically handle pagination
    Returns the normally shaped AWS response, except the Shards key is now a stream
  """
  defcallback stream_shards(stream_name :: iodata)
  defcallback stream_shards(stream_name :: iodata :: %{})

  @doc "Creates stream"
  defcallback create_stream(stream_name :: iodata)
  defcallback create_stream(stream_name :: iodata, shard_count :: pos_integer)

  @doc "Deletes stream"
  defcallback delete_stream(stream_name :: iodata)

  ## Records

  @doc "Get stream records"
  defcallback get_records(stream_name :: iodata)
  defcallback get_records(stream_name :: iodata, opts :: %{})

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
  defcallback stream_records(stream_name :: iodata)
  defcallback stream_records(stream_name :: iodata, opts :: %{})
  defcallback stream_records(stream_name :: iodata, opts :: %{}, iterator_fun :: Fun)

  @doc "Puts a record on a stream"
  defcallback put_record(stream_name :: iodata, partition_key :: iodata, blob :: iodata)
  defcallback put_record(stream_name :: iodata, partition_key :: iodata, blob :: iodata, opts :: %{})

  ## Shards

  @doc """
  Get a shard iterator
  @type shard_iterator_types :: "AT_SEQUENCE_NUMBER"
    | "AFTER_SEQUENCE_NUMBER"
    | "TRIM_HORIZON"
    | "LATEST"
  """
  defcallback get_shard_iterator(stream_name :: iodata, shard_id :: iodata, shard_iterator_type :: iodata)
  defcallback get_shard_iterator(stream_name :: iodata, shard_id :: iodata, shard_iterator_type :: iodata, opts :: %{})

  @doc "Merge adjacent shards"
  defcallback merge_shards(stream_name :: iodata, adjacent_shard_id :: iodata, shard_id :: iodata)

  @doc "Split a shard"
  defcallback split_shard(name :: iodata, shard :: iodata, new_starting_hash_key :: iodata)

  ## Tags

  @doc "Add tags to stream"
  defcallback add_tags_to_stream(name :: iodata, tags :: %{})

  @doc "Add tags to stream"
  defcallback list_tags_for_stream(name :: iodata)
  defcallback list_tags_for_stream(name :: iodata, opts :: %{})

  @doc "Remove tags from stream"
  defcallback remove_tags_for_stream(name :: iodata , tag_keys :: [binary])

  @doc """
    By default the config is obtained by
    ```
    Application.get_env(@otp_app, ExAws)[:kinesis]
    ```
    via a function created when ```using ExAws.Kinesis.Adapter```
    is called.

    See ExAws.Kinesis.config/0 for an example that overrides this default
  """
  defcallback config() :: Keyword.t

  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts, behavior_module: __MODULE__] do
      @otp_app Keyword.get(opts, :otp_app)
      @behaviour behavior_module
      alias ExAws.Kinesis

      @doc false
      def list_streams do
        Kinesis.list_streams(config)
      end

      @doc false
      def describe_stream(name, opts \\ %{}) do
        Kinesis.describe_stream(config, name, opts)
      end

      @doc false
      def stream_shards(name, opts \\ %{}) do
        Kinesis.Lazy.stream_shards(config, name, opts)
      end

      @doc false
      def create_stream(name, shard_count \\ 1) do
        Kinesis.create_stream(config, name, shard_count)
      end

      @doc false
      def delete_stream(name) do
        Kinesis.delete_stream(config, name)
      end

      @doc false
      def get_records(shard_iterator, opts \\ %{}) do
        Kinesis.get_records(config, shard_iterator, opts)
      end

      @doc false
      def stream_records(shard_iterator, opts \\ %{}, iterator_fun \\ &Kinesis.Lazy.pass/1) do
        Kinesis.Lazy.stream_records(config, shard_iterator, opts, iterator_fun)
      end

      @doc false
      def put_record(stream_name, partition_key, blob, opts \\ %{}) do
        Kinesis.put_record(config, stream_name, partition_key, blob, opts)
      end

      @doc false
      def get_shard_iterator(name, shard_id, shard_iterator_type, opts \\ %{}) do
        Kinesis.get_shard_iterator(config, name, shard_id, shard_iterator_type, opts)
      end

      @doc false
      def merge_shards(name, adjacent_shard, shard) do
        Kinesis.merge_shards(config, name, adjacent_shard, shard)
      end

      @doc false
      def split_shard(name, shard, new_starting_hash_key) do
        Kinesis.split_shard(config, name, shard, new_starting_hash_key)
      end

      @doc false
      def add_tags_to_stream(name, tags) do
        Kinesis.add_tags_to_stream(config, name, tags)
      end

      @doc false
      def list_tags_for_stream(name, opts \\ %{}) do
        Kinesis.list_tags_for_stream(config, name, opts)
      end

      @doc false
      def remove_tags_for_stream(name, tag_keys) when is_list(tag_keys) do
        Kinesis.remove_tags_for_stream(config, name, tag_keys)
      end

      @doc false
      def config do
        Application.get_env(@otp_app, ExAws)[:kinesis]
      end

      defoverridable config: 0
    end
  end
end
