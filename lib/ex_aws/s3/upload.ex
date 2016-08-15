alias Experimental.GenStage

defmodule ExAws.S3.Upload do
  @moduledoc """
  Represents an AWS S3 file download operation
  """

  @enforce_keys ~w(bucket path src)a
  defstruct [
    :src,
    :bucket,
    :path,
    :upload_id,
    opts: [],
    service: :s3,
  ]

  @type t :: %__MODULE__{}


  def complete!(parts, op, config) do
    ExAws.S3.complete_multipart_upload(op.bucket, op.path, op.upload_id, Enum.sort_by(parts, &elem(&1, 0)))
    |> ExAws.request!(config)
  end

  def initialize!(op, config) do
    %{body: %{upload_id: upload_id}} =
      ExAws.S3.initiate_multipart_upload(op.bucket, op.path, op.opts)
      |> ExAws.request!(config)
    %{op | upload_id: upload_id}
  end

  def stream_file!(op) do
    op.src
    |> File.stream!([:raw, :read_ahead, :binary], op.opts[:chunk_size] || 5 * 1024 * 1024)
    |> Stream.with_index(1)
  end

  def upload_chunk!({chunk, i}, op, config) do
    %{headers: headers} = ExAws.S3.upload_part(op.bucket, op.path, op.upload_id, i, chunk, op.opts)
    |> ExAws.request!(config)

    {_, etag} = List.keyfind(headers, "ETag", 0)
    {i, etag} |> IO.inspect
  end
end

defimpl ExAws.Operation, for: ExAws.S3.Upload do

  alias GenStage.Flow
  alias ExAws.S3.Upload

  def perform(op, config) do
    op = Upload.initialize!(op, config)
    stream = Upload.stream_file!(op)

    Flow.new(stages: op.opts[:max_concurrency] || 4, max_demand: 1)
    |> Flow.from_enumerable(stream)
    |> Flow.map(&Upload.upload_chunk!(&1, op, config))
    |> Enum.to_list
    |> Upload.complete!(op, config)

    {:ok, :done}
  end

  def stream!(_, _), do: raise "not implemented"
end
