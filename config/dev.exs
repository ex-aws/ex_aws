use Mix.Config

config :ex_aws,
  debug_requests: true,
  access_key_id: [{:system, "AWS_ACCESS_KEY_ID"}, :instance_role],
  secret_access_key: [{:system, "AWS_SECRET_ACCESS_KEY"}, :instance_role],
  region: "us-east-1"

config :ex_aws, :dynamodb,
  scheme: "http://",
  host: "localhost",
  port: 8000,
  region: "us-east-1"

config :ex_aws, :dynamodb_streams,
  scheme: "http://",
  host: "localhost",
  port: 8000,
  region: "us-east-1"

config :ex_aws, :rds,
  scheme: "https://",
  host: {"$region", "rds.$region.amazonaws.com"},
  region: "us-east-1",
  port: 80

config :ex_aws, :ses,
  scheme: "https://",
  host: "email.us-east-1.amazonaws.com",
  region: "us-east-1",
  port: 443

config :ex_aws, :cloudformation,
  scheme: "https://",
  host: {"$region","cloudformation.$region.amazonaws.com"},
  port: 443
