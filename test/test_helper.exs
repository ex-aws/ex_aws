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
    Application.get_env(:ex_aws, :dynamodb)
  end
end


ExUnit.start()
