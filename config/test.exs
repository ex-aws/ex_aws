use Mix.Config
config :ex_aws,
  access_key_id: System.get_env("AWS_ACCESS_KEY_ID"),
  secret_access_key: System.get_env("AWS_SECRET_ACCESS_KEY")
  http_client: HTTPoison

config :ex_aws, :kinesis,
  scheme: "https://",
  host: "kinesis.us-east-1.amazonaws.com",
  region: "us-east-1",
  port: 80

config :ex_aws, :dynamodb,
  scheme: "http://",
  host: "localhost",
  port: 8000,
  region: "us-east-1"
