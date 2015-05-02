defmodule ExAws.DynamoTest do
  use ExUnit.Case, async: true
  alias Test.Dummy.Dynamo

  test "#update_item" do
    assert Dynamo.update_item("Users", %{email: "foo@bar.com"}, %{name: "bubba"}) == 
      %{AttributeUpdates: %{"name" => %{"S" => "bubba"}}, Key: %{"email" => %{"S" => "foo@bar.com"}}, TableName: "Users"}
  end
end
