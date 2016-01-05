defmodule Test.User do
  @derive ExAws.Dynamo.Encodable
  defstruct [:email, :name, :age, :admin]

  defimpl ExAws.Dynamo.Decodable do
    def decode(%{name: %{"first" => first, "last" => last}} = user) do
      %{user | name: %{first: first, last: last}}
    end

    def decode(value), do: value
  end
end

defmodule Test.Nested do
  @derive {ExAws.Dynamo.Encodable, only: [:items]}
  defstruct items: [], secret: nil
end
