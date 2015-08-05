use Mix.Config

config :ex_aws,
  debug_requests: true

config :ex_aws, :sqs,
  scheme: "https://",
  host: "sqs.us-east-1.amazonaws.com",
  region: "us-east-1"
