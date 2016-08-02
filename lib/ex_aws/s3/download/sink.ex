alias Experimental.GenStage

defmodule ExAws.S3.Download.Sink do
  use GenStage

  defstruct [
    :file_size,
    :file,
    bytes_written: 0
  ]

  def start_link(path, file_size) do
    GenStage.start_link(__MODULE__, {path, file_size}, [])
  end

  def init({path, file_size}) do
    state = %__MODULE__{
      file: File.open!(path, [:write, :raw, :delayed_write, :binary]),
      file_size: file_size,
    }
    {:consumer, state}
  end

  def handle_events(chunks, _from, state) do
    :ok = :file.pwrite(state.file, chunks)

    state = %{state | bytes_written: state.bytes_written + total_bytes(chunks)}

    if done?(state) do
      {:stop, :normal, state}
    else
      {:noreply, [], state}
    end
  end

  defp done?(%{bytes_written: size, file_size: size}), do: true
  defp done?(_), do: false

  defp total_bytes(chunks) do
    Enum.reduce(chunks, 0, fn {_, binary}, sum ->
      sum + byte_size(binary)
    end)
  end
end
