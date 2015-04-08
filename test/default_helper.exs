defmodule Test.Dynamo do
  use ExAws.Dynamo.Adapter

  def config do
    Keyword.merge(super, Application.get_env(:ex_aws, :dynamodb))
  end
end

defmodule Test.Kinesis do
  use ExAws.Kinesis.Adapter

  def config do
    Keyword.merge(super, Application.get_env(:ex_aws, :kinesis))
  end
end

defmodule Test.HTTPClient do
  @behaviour ExAws.Request.HttpClient

  def post(url, body, headers) do
    HTTPoison.post(url, body, headers)
  end
end

defmodule Test.JSONCodec do
  @behaviour ExAws.JSON.Codec

  defdelegate [encode!(data), encode(data), decode!(data), decode(data)], to: Poison
end
