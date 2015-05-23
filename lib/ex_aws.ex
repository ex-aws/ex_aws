defmodule ExAws do
  @moduledoc File.read!("#{__DIR__}/../README.md")
  use Application


  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(ExAws.Config.AuthCache, [[name: ExAws.Config.AuthCache]])
    ]

    opts = [strategy: :one_for_one, name: ExAws.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
