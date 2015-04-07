defmodule Mix.Tasks.Kinesis.Tail do
  alias ExAws.Kinesis
  require Logger
  use Mix.Task

  @shortdoc "tails a stream"

  @moduledoc """
  Tails a Stream

  ## Usage
      kinesis.tail [stream_name] [options]

  ## Options
      --poll N   Time in seconds between polling. Default: 5
      --debug    Sets debug_requests: true on ex_aws. Logs all kinesis requests
      --from     Sequence number to start at. If unspecified, LATEST is used

  ## Examples
      $mix kinesis.tail my-kinesis-stream
      $mix kinesis.tail logs --debug --poll 10
  """


  def run(argv) do
    {:ok, _} = Application.ensure_all_started(:ex_aws)

    {opts, [stream_name|_], _} = OptionParser.parse(argv)

    sleep_time = Keyword.get(opts, :poll, "5") |> String.to_integer
    debug      = Keyword.get(opts, :debug, false)
    seq        = Keyword.get(opts, :from)
    {shard_type, opts} = case seq do
      nil -> {"LATEST", %{}}
      val -> {"AT_SEQUENCE_NUMBER", %{StartingSequenceNumber: val}}
    end

    Application.put_env(:ex_aws, :debug_requests, debug)

    Logger.info "Streaming from #{stream_name}"

    stream_name
    |> get_shards
    |> Enum.map(&Kinesis.get_shard_iterator(stream_name, &1["ShardId"], shard_type, opts))
    |> Enum.map(&get_records(&1, sleep_time))
  end

  def get_shards(name) do
    case Kinesis.describe_stream(name) do
      {:ok, %{"StreamDescription" => %{"Shards" => shards}}} -> shards
      error -> raise inspect(error)
    end
  end

  def get_records({:ok, %{"ShardIterator" => iterator}}, wait_time) do
    iterator
    |> Kinesis.stream_records(%{}, fn
      []  -> :timer.sleep(wait_time * 1000); []
      val -> val
    end)
    |> Stream.map(&format_msg/1)
    |> Stream.run
  end

  defp format_msg(msg) do
    IO.ANSI.format_fragment([:blue,  msg["PartitionKey"], :bright, " | ",
                             :reset, msg["Data"] |> ensure_new_line ])
    |> IO.chardata_to_string
    |> IO.write
  end

  defp ensure_new_line(data) do
    case String.last(data) do
      "\n" -> data
      _    -> [data, "\n"]
    end
  end

end
