use Mix.Config

config :logger, level: :warn

config :ex_aws,
  json_codec: Test.JSONCodec,
  access_key_id: ["test_key_id"],
  secret_access_key: ["secret_access_key"]

config :ex_aws, :kinesis,
  scheme: "https://",
  host: "kinesis.us-east-1.amazonaws.com",
  region: "us-east-1",
  port: 443

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

config :ex_aws, :lambda,
  host: "lambda.us-east-1.amazonaws.com",
  scheme: "https://",
  region: "us-east-1",
  port: 443

config :ex_aws, :s3,
  scheme: "https://",
  host: "s3.amazonaws.com",
  region: "us-east-1"
