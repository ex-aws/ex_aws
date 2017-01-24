defmodule ExAws.Firehose do
  @moduledoc """
  AWS Kinesis Firehose
  """

  import ExAws.Utils, only: [camelize_keys: 1]
  require Logger

  @namespace "Firehose_20150804"

  ## Streams
  ######################

  @type stream_name :: binary

  @doc "Lists streams"
  @type list_delivery_stream_opts :: [
    {:exclusive_start_delivery_stream_name, binary} |
    {:limit, pos_integer}
  ]
  @spec list_delivery_streams() :: ExAws.Operation.JSON.t
  @spec list_delivery_streams(opts :: list_delivery_stream_opts) :: ExAws.Operation.JSON.t
  def list_delivery_streams(opts \\ []) do
    data = opts
    |> camelize_keys
    |> Map.merge(%{})

    request(:list_delivery_streams, data)
  end

  @doc "Describe Stream"
  @type describe_delivery_stream_opts :: [
    {:limit, pos_integer} |
    {:exclusive_start_destination_id, binary}
  ]
  @spec describe_delivery_stream(stream_name :: stream_name) :: ExAws.Operation.JSON.t
  @spec describe_delivery_stream(stream_name :: stream_name, opts :: describe_delivery_stream_opts) :: ExAws.Operation.JSON.t
  def describe_delivery_stream(stream_name, opts \\ []) do
    data = opts
    |> camelize_keys
    |> Map.merge(%{"DeliveryStreamName" => stream_name})
    request(:describe_delivery_stream, data)
  end

  @doc "Creates stream"
  @type create_delivery_stream_opts :: [
    {:elasticsearch_destination_configuration, Keyword.t} |
    {:redshift_destination_configuration, Keyword.t} |
    {:s3_destination_configuration, Keyword.t}
  ]
  @spec create_delivery_stream(stream_name :: stream_name) :: ExAws.Operation.JSON.t
  @spec create_delivery_stream(stream_name :: stream_name, opts :: create_delivery_stream_opts) :: ExAws.Operation.JSON.t
  def create_delivery_stream(stream_name, shard_count \\ 1) do
    data = %{
      "ShardCount" => shard_count,
      "DeliveryStreamName" => stream_name}
    request(:create_delivery_stream, data)
  end

  @doc "Deletes stream"
  @spec delete_delivery_stream(stream_name :: stream_name) :: ExAws.Operation.JSON.t
  def delete_delivery_stream(stream_name) do
    request(:delete_delivery_stream, %{"DeliveryStreamName" => stream_name})
  end

  ## Records
  ######################

  @doc "Puts a record on a stream"
  @spec put_record(stream_name :: stream_name, data :: binary) :: ExAws.Operation.JSON.t
  def put_record(stream_name, data, opts \\ []) do
    data = opts
    |> camelize_keys
    |> Map.merge(%{
      "Record" => format_record(data),
      "DeliveryStreamName" => stream_name})

    request(:put_record, data)
  end

  @doc "Put multiple records on a stream"
  @type put_record_batch_record :: [
    {:data, binary}
  ]
  @spec put_record_batch(stream_name :: stream_name, records :: [put_record_batch_record]) :: ExAws.Operation.JSON.t
  def put_record_batch(stream_name, records) when is_list(records) do
    data = %{
      "Records"    => records |> Enum.map(&format_record/1),
      "DeliveryStreamName" => stream_name
    }

    request(:put_record_batch, data)
  end

  defp format_record(data) when is_binary(data), do: format_record(%{data: data})
  defp format_record(%{data: data}) do
    %{"Data" => data |> Base.encode64}
  end

  ## Destinations
  ######################

  @doc "Updates the specified destination of the specified delivery stream."
  @type update_destination_opts :: [
    {:elasticsearch_destination_update, Keyword.t} |
    {:redshift_destination_update, Keyword.t} |
    {:s3_destination_update, Keyword.t}
  ]
  @spec update_destination(stream_name :: stream_name, version_id :: binary, destination_id :: binary) :: ExAws.Operation.JSON.t
  @spec update_destination(stream_name :: stream_name, version_id :: binary, destination_id :: binary, opts :: update_destination_opts) :: ExAws.Operation.JSON.t
  def update_destination(stream_name, version_id, destination_id, opts \\ []) do
    data = opts
    |> camelize_keys
    |> Map.merge(%{
      "DeliveryStreamName" => stream_name,
      "CurrentDeliveryStreamVersionId" => version_id,
      "DestinationId" => destination_id,
    })

    request(:update_destination, data)
  end

  defp request(action, data, opts \\ %{}) do
    operation =
      action
      |> Atom.to_string
      |> Macro.camelize

    ExAws.Operation.JSON.new(:firehose, %{
      data: data,
      headers: [
        {"x-amz-target", "#{@namespace}.#{operation}"},
        {"content-type", "application/x-amz-json-1.1"}
      ]
    } |> Map.merge(opts))
  end
end
