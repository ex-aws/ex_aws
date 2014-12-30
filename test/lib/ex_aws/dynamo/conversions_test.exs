defmodule Test.User do
  defstruct [:email, :name, :age, :admin]
end

defmodule ExAws.Dynamo.ConversionsTest do
  use ExUnit.Case, async: true
  alias ExAws.Dynamo.Conversions
  alias Test.User

  test "dynamize converts numbers to binaries" do
    assert Conversions.do_dynamize(34) == %{N: "34"}
  end

  test "dyanmize can handle map values" do
    result = %{a: 1, b: %{c: 2, d: "asdf"}} |> Conversions.dynamize
    assert %{a: %{N: "1"}, b: %{M: %{c: %{N: "2"}, d: %{S: "asdf"}}}} == result
  end

  test "dynamize can handle floats" do
    assert Conversions.do_dynamize(0.4) == %{N: "4.00000000000000022204e-01"}
  end

  test "undynamize ints works" do
    assert Conversions.undynamize(%{"N" => "23"}) == 23
    assert Conversions.undynamize(%{"N" => 23}) == 23
  end

  test "undynamize floats works" do
    assert Conversions.undynamize(%{"N" => "23.1"}) == 23.1
    assert Conversions.undynamize(%{"N" => 23.1}) == 23.1
  end

  test "undynamize structs works properly" do
    user = %User{email: "foo@bar.com", name: "Bob", age: 23, admin: false}
    user = %User{email: "foo@bar.com", name: "Bob", age: 23, admin: false}
    duser = Conversions.dynamize(user) |> Poison.encode! |> Poison.Parser.parse!
    cuser = duser |> Conversions.coerce(User)
    assert cuser == user
  end
end
