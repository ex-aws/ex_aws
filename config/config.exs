use Mix.Config

config :ex_aws,
  debug_requests: true,
  access_key_id: "access_key_id",
  secret_access_key: "secret_access_key"

config :ex_aws, :dynamodb,
  scheme: "http://",
  host: "localhost",
  port: 8000,
  region: "us-east-1"


config :logger, :console,
  level: :debug,
  format: "$date $time [$level] $metadata$message\n",
  metadata: [:user_id]

import_config "#{Mix.env}.exs"
