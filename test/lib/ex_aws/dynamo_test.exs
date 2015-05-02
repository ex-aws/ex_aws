defmodule ExAws.DynamoTest do
  alias Test.Dynamo
  alias ExAws.Dynamo.Decoder
  use ExUnit.Case, async: true

  setup_all do
    Dynamo.delete_table(Test.User)
    Dynamo.delete_table(Foo)
    :ok
  end

  test "#list_tables" do
    assert {:ok, %{"TableNames" => _}} = Dynamo.list_tables
  end

  test "#create and destroy table" do
    assert {:ok, %{"TableDescription" => %{"TableName" => "Elixir.Foo"}}} =
      Dynamo.create_table(Foo, "shard_id", %{shard_id: :string}, 1, 1)
    assert {:ok, _} = Dynamo.delete_table(Foo)
  end

  test "put and get item with map values work" do
    {:ok, _} = Dynamo.create_table(Test.User, "email", %{email: :string}, 1, 1)
    user = %Test.User{email: "foo@bar.com", name: %{first: "bob", last: "bubba"}, age: 23, admin: false}
    assert {:ok, _} = Dynamo.put_item(Test.User, user)
    {:ok, %{"Item" => item}} = Dynamo.get_item(Test.User, %{email: user.email})
    assert user == item |> Decoder.decode(as: Test.User)
  end

end
