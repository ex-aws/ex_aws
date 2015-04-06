defmodule ExAws.Kinesis.Adapter do
  use Behaviour

  ## Streams

  @doc "Lists streams"
  defcallback list_streams() :: [] | [%{}]

  @doc "Describe Stream"
  defcallback describe_stream(stream_name :: iodata)
  defcallback describe_stream(stream_name :: iodata, opts :: %{})

  @doc "Creates stream"
  defcallback create_stream(stream_name :: iodata)
  defcallback create_stream(stream_name :: iodata, shard_count :: pos_integer)

  @doc "Deletes stream"
  defcallback delete_stream(stream_name :: iodata)

  ## Records

  @doc "Get stream records"
  defcallback get_records(stream_name :: iodata)
  defcallback get_records(stream_name :: iodata, opts :: %{})

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
      def config do
        Application.get_env(@otp_app, ExAws)[:kinesis]
      end

      defoverridable config: 0
    end
  end
end
