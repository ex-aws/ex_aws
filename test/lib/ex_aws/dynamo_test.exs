defmodule ExAws.DynamoTest do
  alias ExAws.Dynamo
  use ExUnit.Case

  setup_all do
    Dynamo.delete_table(User)
    Dynamo.create_table(User, "email", [email: "S"], 1, 1)
    :ok
  end

  test "#list_tables" do
    assert {:ok, %{"TableNames" => _}} = Dynamo.list_tables
  end

  test "#create_table" do
    assert {:ok, %{"TableDescription" => %{"TableName" => "Elixir.Foo-test"}}} =
      Dynamo.create_table(Foo, "shard_id", [shard_id: "S"], 1, 1)
  end

  test "#destroy_table" do
    assert {:ok, _} = Dynamo.delete_table(Foo)
  end

  test "put and get item with map values work" do
    user = %Test.User{email: "foo@bar.com", name: %{first: "bob", last: "bubba"}, age: 23, admin: false}
    assert {:ok, _} = Dynamo.put_item(User, user)
    IO.puts "getting item"
    assert user == Dynamo.get_item(User, user.email)
  end

end
