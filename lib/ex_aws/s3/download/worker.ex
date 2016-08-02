alias Experimental.GenStage

defmodule ExAws.S3.Download.Worker do
  use GenStage

  def start_link(state) do
    GenStage.start_link(__MODULE__, state, [])
  end

  def init(state) do
    {:producer_consumer, state}
  end

  def handle_events(boundaries, _from, state) do
    chunks = for %{start_byte: start_byte, end_byte: end_byte} <- boundaries do
      %{body: body} =
        state.bucket
        |> ExAws.S3.get_object(state.path, [range: "bytes=#{start_byte}-#{end_byte}"])
        |> ExAws.request!(state.config)

      {start_byte, body}
    end

    {:noreply, chunks, state}
  end
end
