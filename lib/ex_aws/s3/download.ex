alias Experimental.GenStage

defmodule ExAws.S3.Download do
  @moduledoc false

  defstruct [
    :bucket,
    :path,
    :dest,
    opts: [],
  ]
end

defimpl ExAws.Operation, for: ExAws.S3.Download do

  alias ExAws.S3.Download

  def perform(op, config) do
    {:ok, source} =
      op.bucket
      |> get_file_size(op.path, config)
      |> Download.Source.start_link

    {:ok, sink} = Download.Sink.start_link(op.dest)

    for _ <- 1..Keyword.get(op.opts, :max_concurrency, 8) do
      {:ok, worker} = Download.Worker.start_link(%{bucket: op.bucket, path: op.path, config: config})

      GenStage.sync_subscribe(sink, to: worker, min_demand: 0, max_demand: 1)
      GenStage.sync_subscribe(worker, to: source, min_demand: 0, max_demand: 1)
    end

    ref = Process.monitor(sink)

    receive do
      {:DOWN, ^ref, :process, ^sink, _} ->
        :ok
    end
  end

  def stream!(_op, _config) do
    raise "not supported yet"
  end

  defp get_file_size(bucket, path, config) do
    %{headers: headers} = ExAws.S3.head_object(bucket, path) |> ExAws.request!(config)

    headers
    |> List.keyfind("Content-Length", 0, nil)
    |> elem(1)
    |> String.to_integer
  end
end
