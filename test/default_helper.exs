## Clients

defmodule Test.Dynamo do
  use ExAws.Dynamo.Client

  def config_root, do: Application.get_all_env(:ex_aws)
end

defmodule Test.Kinesis do
  use ExAws.Kinesis.Client

  def config_root, do: Application.get_all_env(:ex_aws)
end

defmodule Test.S3 do
  use ExAws.S3.Client

  def config_root, do: Application.get_all_env(:ex_aws)
end

defmodule Test.SNS do
  use ExAws.SNS.Client

  def config_root, do: Application.get_all_env(:ex_aws)
end

## Other

defmodule Test.JSONCodec do
  @behaviour ExAws.JSON.Codec

  defdelegate encode!(data), to: Poison
  defdelegate encode(data), to: Poison
  defdelegate decode!(data), to: Poison
  defdelegate decode(data), to: Poison
end
