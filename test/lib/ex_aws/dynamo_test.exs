defmodule ExAws.DynamoTest do
  alias ExAws.Dynamo
  use ExUnit.Case, async: true

  test "#list_tables" do
    assert {:ok, %{"TableNames" => _}} = Dynamo.list_tables
  end

  test "#create_table" do
    assert {:ok, _} = Dynamo.create_table(Foo, :id, %{id: "S"}, 1, 1)
  end

end
