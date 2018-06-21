use Mix.Config

config :logger, :console,
  level: :debug,
  format: "$date $time [$level] $metadata$message\n",
  metadata: [:user_id]

import_config "#{Mix.env()}.exs"
