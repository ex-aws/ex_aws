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
    opts: [],
    service: :s3,
  ]

  @type t :: %__MODULE__{}
end

defimpl ExAws.Operation, for: ExAws.S3.Upload do

  alias GenStage.Flow

  def perform(op, config) do
    upload_id = start_upload(op, config)
    stream = build_stream(op)

    Flow.new(stages: op.opts[:max_concurrency] || 8, max_demand: 1)
    |> Flow.from_enumerable(stream)
    |> Flow.map(&upload_chunk(&1, upload_id, op, config))
    |> Enum.to_list
    |> complete_upload(upload_id, op, config)

    {:ok, :done}
  end

  defp complete_upload(parts, upload_id, op, config) do
    ExAws.S3.complete_multipart_upload(op.bucket, op.path, upload_id, Enum.sort_by(parts, &elem(&1, 0)))
    |> ExAws.request!(config)
  end

  defp start_upload(op, config) do
    %{body: %{upload_id: upload_id}} =
      ExAws.S3.initiate_multipart_upload(op.bucket, op.path, op.opts)
      |> ExAws.request!(config)
    upload_id
  end

  defp build_stream(op) do
    op.src
    |> File.stream!([:raw, :read_ahead, :binary], op.opts[:chunk_size] || 5 * 1024 * 1024)
    |> Stream.with_index(1)
  end

  def stream!(_, _), do: raise "not implemented"

  def upload_chunk({chunk, i}, upload_id, op, config) do
    %{headers: headers} = ExAws.S3.upload_part(op.bucket, op.path, upload_id, i, chunk, op.opts)
    |> ExAws.request!

    {_, etag} = List.keyfind(headers, "ETag", 0)
    {i, Macro.unescape_string(etag)} |> IO.inspect
  end
end
