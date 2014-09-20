use Mix.Config

config :ex_aws,
  ddb_scheme: "http://",
  ddb_host: "localhost",
  ddb_port: 8000,
  access_key_id: System.get_env("AWS_ACCESS_KEY_ID"),
  secret_access_key: System.get_env("AWS_SECRET_ACCESS_KEY"),
  ddb_namespace: System.get_env("STAGE"),
  kinesis_namespace: System.get_env("STAGE")
