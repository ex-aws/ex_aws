defmodule ExAws.DynamoIntegrationTest do
  alias ExAws.Dynamo
  alias ExAws.Dynamo.Decoder
  use ExUnit.Case, async: true

  ## These tests run against DynamoDb Local
  #
  # http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Tools.DynamoDBLocal.html
  # In this way they can safely delete data and tables without risking actual data on
  # Dynamo
  #

  setup_all do
    Dynamo.delete_table("Users") |> ExAws.request
    Dynamo.delete_table(Test.User) |> ExAws.request
    Dynamo.delete_table(Foo) |> ExAws.request
    Dynamo.delete_table("books") |> ExAws.request
    :ok
  end

  test "#list_tables" do
    assert {:ok, %{"TableNames" => _}} = Dynamo.list_tables |> ExAws.request
  end

  test "#create and destroy table" do
    assert {:ok, %{"TableDescription" => %{"TableName" => "Elixir.Foo"}}} =
      Dynamo.create_table(Foo, :shard_id, [shard_id: :string], 1, 1) |> ExAws.request
  end

  test "#create table with range" do
    assert Dynamo.create_table("UsersWithRange", [email: :hash, age: :range], [email: :string, age: :number], 1, 1) |> ExAws.request
  end

  test "put and get item with map values work" do
    {:ok, _} = Dynamo.create_table(Test.User, :email, [email: :string], 1, 1) |> ExAws.request

    user = %Test.User{email: "foo@bar.com", name: %{first: "bob", last: "bubba"}, age: 23, admin: false}
    assert {:ok, _} = Dynamo.put_item(Test.User, user) |> ExAws.request

    {:ok, %{"Item" => item}} = Dynamo.get_item(Test.User, %{email: user.email}) |> ExAws.request
    assert user == item |> Decoder.decode(as: Test.User)
  end

  test "stream scan" do
    {:ok, _} = Dynamo.create_table("Users", :email, [email: :string], 1, 1) |> ExAws.request
    user = %Test.User{email: "foo@bar.com", name: %{first: "bob", last: "bubba"}, age: 23, admin: false}
    assert {:ok, _} = Dynamo.put_item("Users", user) |> ExAws.request
    user = %Test.User{email: "bar@bar.com", name: %{first: "bob", last: "bubba"}, age: 23, admin: false}
    assert {:ok, _} = Dynamo.put_item("Users", user) |> ExAws.request
    user = %Test.User{email: "baz@bar.com", name: %{first: "bob", last: "bubba"}, age: 23, admin: false}
    assert {:ok, _} = Dynamo.put_item("Users", user) |> ExAws.request

    assert Dynamo.scan("Users", limit: 1)
    |> ExAws.stream!
    |> Enum.count == 3
  end
  
  test "batch_write_item works" do
    {:ok, _} = Dynamo.create_table("books", [title: "hash", format: "range"], [title: :string, format: :string], 1, 1) |> ExAws.request
    
    requests = [
      [put_request: [item: %{title: "Tale of Two Cities", format: "hardcover", price: 20.00}]],
      [put_request: [item: %{title: "Tale of Two Cities", format: "softcover", price: 10.00}]]
    ]
    assert {:ok, _} = Dynamo.batch_write_item(%{"books" => requests}) |> ExAws.request
    
    delete_requests = [
      [delete_request: [key: %{title: "Tale of Two Cities", format: "hardcover"}]],
      [delete_request: [key: %{title: "Tale of Two Cities", format: "softcover"}]]
    ]
    assert {:ok, _} = Dynamo.batch_write_item(%{"books" => delete_requests}) |> ExAws.request
    
  end

end
