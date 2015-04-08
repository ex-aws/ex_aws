Code.require_file("default_helper.exs", __DIR__)
Code.require_file("alternate_helper.exs", __DIR__)

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

Application.ensure_all_started(:httpoison)
Application.ensure_all_started(:jsx)

ExUnit.start()
