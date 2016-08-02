alias Experimental.GenStage

defmodule ExAws.S3.Download.Sink do
  use GenStage

  def start_link(path) do
    GenStage.start_link(__MODULE__, path, [])
  end

  def init(path) do
    {:consumer, File.open!(path, [:write, :raw, :delayed_write, :binary])}
  end

  def handle_events(chunks, _from, file) do
    :ok = :file.pwrite(file, chunks)

    {:noreply, [], file}
  end
end
