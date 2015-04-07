use Mix.Config

config :ex_aws,
  debug_requests: true,
  access_key_id: System.get_env("AWS_ACCESS_KEY_ID"),
  secret_access_key: System.get_env("6fw4s/k2wHKtuMyeKM8+QUriBdRNmq4tN9QH2zyo")

config :ex_aws, :dynamodb,
  scheme: "https://",
  host: "dynamodb.us-east-1.amazonaws.com",
  port: 80,
  region: "us-east-1"
