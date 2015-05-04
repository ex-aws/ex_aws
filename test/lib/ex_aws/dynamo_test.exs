defmodule Test.Dummy.Dynamo do
  use ExAws.Dynamo.Client

  def config_root, do: Application.get_all_env(:ex_aws)

  def request(data, action), do: data
end

defmodule ExAws.DynamoTest do
  use ExUnit.Case, async: true
  alias Test.Dummy.Dynamo

  test "#update_item" do
    assert Dynamo.update_item("Users", %{email: "foo@bar.com"}, %{name: "bubba"}) ==
      %{AttributeUpdates: %{"name" => %{"S" => "bubba"}}, Key: %{"email" => %{"S" => "foo@bar.com"}}, TableName: "Users"}
  end
end
