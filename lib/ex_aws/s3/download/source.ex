alias Experimental.GenStage

defmodule ExAws.S3.Download.Source do
  use GenStage

  defstruct [
    :file_size,
    done: false,
    counter: 0,
    chunk_size: 10,
  ]

  def start_link(file_size) do
    GenStage.start_link(__MODULE__, file_size, [])
  end

  def init(file_size) do
    state = %__MODULE__{
      file_size: file_size,
    }

    {:producer, state}
  end

  def handle_demand(demand, %{done: false} = state) do
    case build_boundaries(demand, state.counter, state) do
      {:done, boundaries} ->
        {:noreply, boundaries, %{state | done: true}}
      {:cont, boundaries} ->
        {:noreply, boundaries, %{state | counter: state.counter + demand}}
    end
  end
  def handle_demand(_, state) do
    {:noreply, [], state}
  end

  def build_boundaries(demand, counter, state, acc \\ [])
  def build_boundaries(0, _, _, acc), do: {:cont, acc}
  def build_boundaries(demand, counter, state, acc) do
    start_byte = counter * state.chunk_size

    if start_byte >= state.file_size do
      {:done, acc}
    else
      end_byte = (counter + 1) * state.chunk_size

      # byte ranges are inclusive, so we want to remove one. IE, first 500 bytes
      # is range 0-499. Also, we need it bounded by the max size of the file
      end_byte = min(end_byte, state.file_size) - 1

      boundary = %{
        start_byte: start_byte,
        end_byte: end_byte
      }

      build_boundaries(demand - 1, counter + 1, state, [boundary | acc])
    end
  end
end
