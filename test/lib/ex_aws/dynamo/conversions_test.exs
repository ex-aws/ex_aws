defmodule Test.User do
  defstruct [:email, :name, :age, :admin]
end

defmodule ExAws.Dynamo.ConversionsTest do
  use ExUnit.Case, async: true
  alias ExAws.Dynamo.Conversions
  alias Test.User

  test "dynamize converts numbers to binaries" do
    assert Conversions.dynamize(34) == %{N: "34"}
  end

  test "undynamize ints works" do
    assert Conversions.undynamize(%{"N" => "23"}) == 23
    assert Conversions.undynamize(%{"N" => 23}) == 23
  end

  test "undynamize structs works properly" do
    user = %User{email: "foo@bar.com", name: "Bob", age: 23, admin: false}
    user = %User{email: "foo@bar.com", name: "Bob", age: 23, admin: false}
    duser = Conversions.dynamize(user) |> Poison.encode! |> Poison.Parser.parse!
    cuser = duser |> Conversions.coerce(User)
    assert cuser == user
  end
end
