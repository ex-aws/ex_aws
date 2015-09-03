defmodule Test.Nested do
  @derive {ExAws.Dynamo.Encodable, only: [:items]}
  defstruct items: [], secret: nil
end

defmodule ExAws.Dynamo.EncoderTest do
  use ExUnit.Case, async: true
  alias ExAws.Dynamo.Encoder

  test "Encoder converts numbers to binaries" do
    assert Encoder.encode(34) == %{"N" => "34"}
  end

  test "Encoder can handle map values" do
    result = %{foo: 1, bar: %{baz: 2, zounds: "asdf"}} |> Encoder.encode
    assert %{"M" => %{"bar" => %{"M" => %{"baz" => %{"N" => "2"}, "zounds" => %{"S" => "asdf"}}}, "foo" => %{"N" => "1"}}} == result
  end

  test "Encoder handles hashdicts" do
    dict = %{foo: 1, bar: 2} |> Enum.into(HashDict.new)
    assert dict |> Encoder.encode == %{"M" => %{"bar" => %{"N" => "2"}, "foo" => %{"N" => "1"}}}
  end

  test "Encoder can handle floats" do
    assert Encoder.encode(0.4) == %{"N" => "4.00000000000000022204e-01"}
  end

  test "Encoder with structs works properly" do
    user = %Test.User{email: "foo@bar.com", name: "Bob", age: 23, admin: false}
    assert %{"admin" => %{"BOOL" => "false"}, "age" => %{"N" => "23"},
      "email" => %{"S" => "foo@bar.com"}, "name" => %{"S" => "Bob"}} = Encoder.encode_root(user)
  end

  test "encoder handles lists properly" do
    assert ["foo", "bar"] |> Encoder.encode == %{"SS" => ["foo", "bar"]}
    assert [1, 2] |> Encoder.encode == %{"NS" => ["1", "2"]}
    assert ["foo", 1] |> Encoder.encode == %{"L" => [%{"S" => "foo"}, %{"N" => "1"}]}
  end

  test "encoder is idempotent" do
    value = %{foo: 1, bar: %{baz: 2, zounds: "asdf"}}
    assert value |> Encoder.encode == value |> Encoder.encode |> Encoder.encode
  end

  test "encoder works with nested structs" do
    nested_structs = %Test.Nested{items: [%Test.Nested{items: ["asdf"], secret: "foo"}], secret: "bar"} |> Encoder.encode_root
    expected = %{"items" => %{"L" => [%{"M" => %{"items" => %{"SS" => ["asdf"]}}}]}}
    assert nested_structs == expected
  end
end
