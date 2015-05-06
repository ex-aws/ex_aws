defmodule Test.Dummy.Dynamo do
  use ExAws.Dynamo.Client

  def config_root, do: Application.get_all_env(:ex_aws)

  def request(data, _action), do: data
end

defmodule ExAws.DynamoTest do
  use ExUnit.Case, async: true
  alias Test.Dummy.Dynamo

  test "#scan" do
    expected = %{"ExclusiveStartKey" => %{api_key: %{"S" => "api_key"}}, "ExpressionAttributeNames" => %{api_key: "#api_key"},
      "ExpressionAttributeValues" => %{":api_key" => %{"S" => "asdfasdfasdf"}, ":name" => %{"S" => "bubba"}},
      "FilterExpression" => "ApiKey = #api_key and Name = :name", "Limit" => 12, "TableName" => "Users"}

    assert Dynamo.scan("Users",
      limit: 12,
      exclusive_start_key: [api_key: "api_key"],
      expression_attribute_names: [api_key: "#api_key"],
      expression_attribute_values: [api_key: "asdfasdfasdf", name: "bubba"],
      filter_expression: "ApiKey = #api_key and Name = :name") == expected
  end

  test "#query" do
    expected = %{"ExclusiveStartKey" => %{api_key: %{"S" => "api_key"}}, "ExpressionAttributeNames" => %{api_key: "#api_key"},
      "ExpressionAttributeValues" => %{":api_key" => %{"S" => "asdfasdfasdf"}, ":name" => %{"S" => "bubba"}},
      "FilterExpression" => "ApiKey = #api_key and Name = :name", "Limit" => 12, "TableName" => "Users"}

    assert Dynamo.scan("Users",
      limit: 12,
      exclusive_start_key: [api_key: "api_key"],
      expression_attribute_names: [api_key: "#api_key"],
      expression_attribute_values: [api_key: "asdfasdfasdf", name: "bubba"],
      filter_expression: "ApiKey = #api_key and Name = :name") == expected
  end

  test "#batch_get_item" do
    expected = %{"RequestItems" => %{"Subscriptions" => %{"Keys" => [%{id: %{"S" => "id1"}}]},
      "Users" => %{"ConsistentRead" => true, "Keys" => [%{api_key: %{"S" => "key1"}}, %{api_key: %{"S" => "api_key2"}}]}}}

    request = Dynamo.batch_get_item(%{
      "Users" => [
        consistent_read: true,
        keys: [
          [api_key: "key1"],
          [api_key: "api_key2"]
        ]
      ],
      "Subscriptions" => %{keys: [%{id: "id1"}]}
    })
    assert request == expected
  end

  test "#batch_write_item" do
    user = %Test.User{email: "foo@bar.com", name: %{first: "bob", last: "bubba"}, age: 23, admin: false}
    Dynamo.batch_write_item(%{
      "Users" => [
        [delete_request: [key: "api_key1"]],
        [put_request: [item: user]]
      ]
    })
    |> IO.inspect
  end

  test "put item" do
    expected = %{"Item" => %{"admin" => %{"BOOL" => "false"}, "age" => %{"N" => "23"},
      "email" => %{"S" => "foo@bar.com"},
      "name" => %{"M" => %{"first" => %{"S" => "bob"},
        "last" => %{"S" => "bubba"}}}}, "TableName" => "Users"}
    user = %Test.User{email: "foo@bar.com", name: %{first: "bob", last: "bubba"}, age: 23, admin: false}
    assert Dynamo.put_item("Users", user) == expected
  end
end
