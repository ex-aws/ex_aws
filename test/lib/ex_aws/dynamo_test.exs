defmodule ExAws.DynamoTest do
  alias Test.Dynamo
  alias Test.User
  use ExUnit.Case, async: true

  setup_all do
    Dynamo.delete_table(User)
    Dynamo.delete_table(Foo)
    :ok
  end

  test "#list_tables" do
    assert {:ok, %{"TableNames" => _}} = Dynamo.list_tables
    |> IO.inspect
  end

  test "#create and destroy table" do
    assert {:ok, %{"TableDescription" => %{"TableName" => "Elixir.Foo"}}} =
      Dynamo.create_table(Foo, "shard_id", [shard_id: "S"], 1, 1)
    assert {:ok, _} = Dynamo.delete_table(Foo)
  end

  test "put and get item with map values work" do
    Dynamo.create_table(User, "email", %{email: "S"}, 1, 1)
    user = %Test.User{email: "foo@bar.com", name: %{first: "bob", last: "bubba"}, age: 23, admin: false}
    assert {:ok, _} = Dynamo.put_item(User, user)
    # assert user == Dynamo.get_item(User, user.email)
  end

end
