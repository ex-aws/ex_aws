## Clients

defmodule Test.Dummy.Dynamo do
  use ExAws.Dynamo.Client

  def config_root, do: Application.get_all_env(:ex_aws)

  def request(data, action), do: data
end

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

## Other

defmodule Test.HTTPClient do
  @behaviour ExAws.Request.HttpClient

  def request(method, url, body, headers) do
    HTTPoison.request(method, url, body, headers)
  end
end

defmodule Test.JSONCodec do
  @behaviour ExAws.JSON.Codec

  defdelegate [encode!(data), encode(data), decode!(data), decode(data)], to: Poison
end
