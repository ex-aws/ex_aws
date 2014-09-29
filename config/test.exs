use Mix.Config

config :ex_aws,
  ddb_namespace: "staging",
  kinesis_namespace: "staging",
  ddb_scheme: "http://",
  ddb_host: "localhost",
  ddb_port: 8000,
  access_key_id: "access_key_id",
  secret_access_key: "secret_access_key"
