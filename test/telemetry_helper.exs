defmodule TelemetryHelper do
  alias ExUnit.Callbacks

  def attach_telemetry(prefix) do
    name = "ex_aws_test"
    parent_pid = self()

    :ok =
      :telemetry.attach_many(
        name,
        [
          prefix ++ [:start],
          prefix ++ [:stop],
          prefix ++ [:exception]
        ],
        fn path, args, metadata, _config ->
          send(parent_pid, {path, args, metadata})
        end,
        nil
      )

    Callbacks.on_exit(fn ->
      :telemetry.detach(name)
    end)
  end
end
