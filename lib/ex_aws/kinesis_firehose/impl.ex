defmodule ExAws.KinesisFirehose.Impl do
  use ExAws.Actions
  import ExAws.Utils, only: [camelize_keys: 1, upcase: 1]
  require Logger

  @moduledoc false
  # Implimentation of the AWS Kinesis Firehose API.
  #
  # See ExAws.KinesisFirehose.Client for usage.

  @namespace "Firehose_20150804"
  @actions [
    create_delivery_stream:   :post,
    delete_delivery_stream:   :post,
    describe_delivery_stream: :post,
    list_delivery_streams:    :post,
    put_record:               :post,
    put_record_batch:         :post,
    update_destination:       :post,
  ]

  ## Streams
  ######################

  def list_delivery_streams(client, opts \\ []) do
    data = opts
    |> camelize_keys
    |> Map.merge(%{})

    request(client, :list_delivery_streams, data)
  end

  def describe_delivery_stream(client, stream_name, opts \\ []) do
    data = opts
    |> camelize_keys
    |> Map.merge(%{"StreamName" => stream_name})
    request(client, :describe_delivery_stream, data)
  end

  def create_delivery_stream(client, stream_name, shard_count \\ 1) do
    data = %{
      "ShardCount" => shard_count,
      "StreamName" => stream_name}
    request(client, :create_delivery_stream, data)
  end

  def delete_delivery_stream(client, stream_name) do
    request(client, :delete_delivery_stream, %{"StreamName" => stream_name})
  end

  ## Records
  ######################

  def put_record(client, stream_name, data, opts \\ []) do
    data = opts
    |> camelize_keys
    |> Map.merge(%{
      "Data" => data |> Base.encode64,
      "DeliveryStreamName" => stream_name})

    request(client, :put_record, data)
  end

  def put_record_batch(client, stream_name, records) when is_list(records) do
    data = %{
      "Records"    => records |> Enum.map(&format_record/1),
      "DeliveryStreamName" => stream_name
    }

    request(client, :put_record_batch, data)
  end

  defp format_record(data) when is_binary(data), do: format_record(%{data: data})
  defp format_record(%{data: data}) do
    %{"Data" => data |> Base.encode64}
  end

  defp request(%{__struct__: client_module} = client, action, data) do
    client_module.request(client, action, data)
  end

  ## Destinations
  ######################

  def update_destination(client, stream_name, version_id, destination_id, opts \\ []) do
    data = opts
    |> camelize_keys
    |> Map.merge(%{
      "DeliveryStreamName" => stream_name,
      "CurrentDeliveryStreamVersionId" => version_id,
      "DestinationId" => destination_id,
    })

    request(client, :update_destination, data)
  end
end
