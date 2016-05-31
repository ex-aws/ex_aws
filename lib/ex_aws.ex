defmodule ExAws do
  @moduledoc File.read!("#{__DIR__}/../README.md")
  use Application

  def request(%ExAws.Operation{request_module: request_module} = op, config_overrides \\ []) do
    request_module.request(op, ExAws.Config.build(op, config_overrides))
  end

  def request!(op, config_overrides \\ []) do
    case request(op, config_overrides) do
      {:ok, result} -> result
      other -> raise ExAws.Error, """
      ExAws Request Error!

      #{inspect other}
      """
    end
  end

  def stream!(op, config_overrides \\ [])
  def stream!(%ExAws.Operation{stream_builder: nil}, _) do
    raise ArgumentError, """
    This operation does not support streaming!
    """
  end
  def stream!(%ExAws.Operation{stream_builder: stream_builder}, config_overrides) do
    stream_builder.(config_overrides)
  end

  @doc false
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(ExAws.Config.AuthCache, [[name: ExAws.Config.AuthCache]])
    ]

    opts = [strategy: :one_for_one, name: ExAws.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
