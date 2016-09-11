defmodule ExAws.S3.Download do
  @moduledoc """
  Represents an AWS S3 file download operation
  """

  @enforce_keys ~w(bucket path dest)a
  defstruct [
    :bucket,
    :path,
    :dest,
    chunk_size: 1024 * 1024,
    opts: [],
    service: :s3,
  ]

  @type t :: %__MODULE__{}

  def get_chunk(op, %{start_byte: start_byte, end_byte: end_byte}, config) do
    %{body: body} =
      op.bucket
      |> ExAws.S3.get_object(op.path, [range: "bytes=#{start_byte}-#{end_byte}"])
      |> ExAws.request!(config)

    {start_byte, body}
  end

  def build_chunk_stream(op, config) do
    op.bucket
    |> get_file_size(op.path, config)
    |> chunk_stream(op.chunk_size)
  end

  def chunk_stream(file_size, chunk_size) do
    Stream.unfold(0, fn counter ->
      start_byte = counter * chunk_size

      if start_byte >= file_size do
        nil
      else
        end_byte = (counter + 1) * chunk_size

        # byte ranges are inclusive, so we want to remove one. IE, first 500 bytes
        # is range 0-499. Also, we need it bounded by the max size of the file
        end_byte = min(end_byte, file_size) - 1

        {%{start_byte: start_byte, end_byte: end_byte}, counter + 1}
      end
    end)
  end

  defp get_file_size(bucket, path, config) do
    %{headers: headers} = ExAws.S3.head_object(bucket, path) |> ExAws.request!(config)

    headers
    |> List.keyfind("Content-Length", 0, nil)
    |> elem(1)
    |> String.to_integer
  end
end

defimpl ExAws.Operation, for: ExAws.S3.Download do

  alias ExAws.S3.Download

  alias Experimental.Flow

  def perform(op, config) do
    init_file = fn -> File.open!(op.dest, [:write, :raw, :delayed_write, :binary]) end

    write_chunk = fn chunks, file ->
      :ok = :file.pwrite(file, [chunks])
      file
    end

    chunk_stream = Download.build_chunk_stream(op, config)

    Flow.new(stages: op.opts[:max_concurrency] || 8, max_demand: 2)
    |> Flow.from_enumerable(chunk_stream)
    |> Flow.map(&Download.get_chunk(op, &1, config))
    |> Flow.reduce(init_file, write_chunk)
    |> Flow.run

    {:ok, :done}
  end

  def stream!(_op, _config) do
    raise "not supported yet"
  end
end
