defmodule ExAws.Dynamo.DecoderTest do
  use ExUnit.Case, async: true
  alias ExAws.Dynamo.Decoder
  alias ExAws.Dynamo.Encoder

  test "decoder works on lists of numbers" do
    assert %{"NS" => ["1", "2", "3"]}
    |> Decoder.decode == [1, 2, 3]

    assert %{"NS" => [1, 2, 3]}
    |> Decoder.decode == [1,2,3]
  end

  test "lists of different types" do
    assert %{"L" => [%{"S" => "asdf"}, %{"N" => "1"}]}
    |> Decoder.decode == ["asdf", 1]
  end

  test "Decoder ints works" do
    assert Decoder.decode(%{"N" => "23"}) == 23
    assert Decoder.decode(%{"N" => 23}) == 23
  end

  test "Decoder floats works" do
    assert Decoder.decode(%{"N" => "23.1"}) == 23.1
    assert Decoder.decode(%{"N" => 23.1}) == 23.1
  end

  test "Decoder nil works" do
    assert Decoder.decode(%{"NULL" => "true"}) == nil
    assert Decoder.decode(%{"NULL" => true}) == nil
  end

  test "Decoder structs works properly" do
    user = %Test.User{email: "foo@bar.com", name: "Bob", age: 23, admin: false}
    assert user == user |> Encoder.encode |> Decoder.decode(as: Test.User)
  end

  test "Decoder full string works" do
    assert Decoder.decode(%{"S" => "val"}) == "val"
  end

  test "Decoder empty string works" do
    assert Decoder.decode(%{"S" => ""}) == ""
  end

end
