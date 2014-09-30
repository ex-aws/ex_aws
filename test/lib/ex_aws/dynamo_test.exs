defmodule ExAws.DynamoTest do
  alias ExAws.Dynamo
  use ExUnit.Case

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

end
