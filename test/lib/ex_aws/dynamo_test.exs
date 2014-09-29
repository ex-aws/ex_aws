defmodule ExAws.DynamoTest do
  alias ExAws.Dynamo
  use ExUnit.Case, async: true

  test "#list_tables" do
    assert {:ok, %{"TableNames" => _}} = Dynamo.list_tables
  end

end
