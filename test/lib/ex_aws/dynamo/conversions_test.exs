defmodule Test.User do
  @derive [ExAws.Dynamo.Conversion]
  defstruct [:email, :name, :age, :admin]
end

defmodule ExAws.Dynamo.ConversionTest do
  use ExUnit.Case, async: true
  alias ExAws.Dynamo.Conversion
  alias ExAws.Dynamo.Coercion
  alias Test.User

  test "dynamize converts numbers to binaries" do
    assert Conversion.dynamize(34) == %{N: "34"}
  end

  test "dyanmize can handle map values" do
    result = %{a: 1, b: %{c: 2, d: "asdf"}} |> Conversion.dynamize
    assert %{M: %{a: %{N: "1"}, b: %{M: %{c: %{N: "2"}, d: %{B: "asdf"}}}}} == result
  end

  test "dynamize can handle floats" do
    assert Conversion.dynamize(0.4) == %{N: "4.00000000000000022204e-01"}
  end

  test "undynamize ints works" do
    assert Coercion.undynamize(%{"N" => "23"}) == 23
    assert Coercion.undynamize(%{"N" => 23}) == 23
  end

  test "undynamize floats works" do
    assert Coercion.undynamize(%{"N" => "23.1"}) == 23.1
    assert Coercion.undynamize(%{"N" => 23.1}) == 23.1
  end

  test "undynamize structs works properly" do
    user = %User{email: "foo@bar.com", name: "Bob", age: 23, admin: false}
    user = %User{email: "foo@bar.com", name: "Bob", age: 23, admin: false}
    duser = Conversion.dynamize(user) |> Poison.encode! |> Poison.Parser.parse!
    |> IO.inspect
    cuser = duser |> Coercion.coerce(User)
    assert cuser == user
  end
end
