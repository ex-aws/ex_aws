defmodule Test.User do
  @derive [ExAws.Dynamo.Encodable]
  defstruct [:email, :name, :age, :admin]

  defimpl ExAws.Dynamo.Decodable do
    def decode(%{name: %{"first" => first, "last" => last}} = user) do
      %{user | name: %{first: first, last: last}}
    end

    def decode(value), do: value
  end
end

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

Application.ensure_all_started(:httpoison)

ExUnit.start()
