defmodule Mix.Tasks.Aws.Kinesis.Tail do
  use Mix.Task

  @shortdoc "tails a stream"

  @moduledoc """
  Tails a Stream

  ## Usage

      aws.kinesis.tail [stream_name] [options]

  ## Options

      --poll N   Time in seconds between polling. Default: 5
      --debug    Sets debug_requests: true on ex_aws. Logs all kinesis requests
      --from     Sequence number to start at. If unspecified, LATEST is used

  ## Examples

      $ mix aws.kinesis.tail my-kinesis-stream
      $ mix aws.kinesis.tail logs --debug --poll 10

  """

  def run(_) do
    raise "Not yet implemented in 1.0.0-beta1"
  end
end
