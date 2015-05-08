defmodule ExAws.DynamoIntegrationTest do
  alias Test.Dynamo
  alias ExAws.Dynamo.Decoder
  use ExUnit.Case, async: true

  ## These tests run against DynamoDb Local
  #
  # http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Tools.DynamoDBLocal.html
  # In this way they can safely delete data and tables without risking actual data on
  # Dynamo
  #

  setup_all do
    Dynamo.delete_table("Users")
    Dynamo.delete_table(Test.User)
    Dynamo.delete_table(Foo)
    :ok
  end

  test "#list_tables" do
    assert {:ok, %{"TableNames" => _}} = Dynamo.list_tables
  end

  test "#create and destroy table" do
    assert {:ok, %{"TableDescription" => %{"TableName" => "Elixir.Foo"}}} =
      Dynamo.create_table(Foo, :shard_id, [shard_id: :string], 1, 1)
  end

  test "put and get item with map values work" do
    {:ok, _} = Dynamo.create_table(Test.User, :email, [email: :string], 1, 1)

    user = %Test.User{email: "foo@bar.com", name: %{first: "bob", last: "bubba"}, age: 23, admin: false}
    assert {:ok, _} = Dynamo.put_item(Test.User, user)

    {:ok, %{"Item" => item}} = Dynamo.get_item(Test.User, %{email: user.email})
    assert user == item |> Decoder.decode(as: Test.User)
  end

  test "stream scan" do
    {:ok, _} = Dynamo.create_table("Users", :email, [email: :string], 1, 1)
    user = %Test.User{email: "foo@bar.com", name: %{first: "bob", last: "bubba"}, age: 23, admin: false}
    assert {:ok, _} = Dynamo.put_item("Users", user)
    user = %Test.User{email: "bar@bar.com", name: %{first: "bob", last: "bubba"}, age: 23, admin: false}
    assert {:ok, _} = Dynamo.put_item("Users", user)
    user = %Test.User{email: "baz@bar.com", name: %{first: "bob", last: "bubba"}, age: 23, admin: false}
    assert {:ok, _} = Dynamo.put_item("Users", user)

    {:ok, %{"Items" => items}} = Dynamo.stream_scan("Users", limit: 1)
    assert items |> Enum.count == 3
  end

end
