defmodule Test.Dummy.Dynamo do
  use ExAws.Dynamo.Client

  def config_root, do: Application.get_all_env(:ex_aws)

  def request(data, _client_data, _action), do: data
end

defmodule ExAws.DynamoTest do
  use ExUnit.Case, async: true
  alias Test.Dummy.Dynamo

  ## NOTE:
  # These tests are not intended to be operational examples, but intead mere
  # ensure that the form of the data to be sent to AWS is correct.
  #

  test "#create_table" do
    expected = %{"AttributeDefinitions" => [%{"AttributeName" => :email, "AttributeType" => "S"}, %{"AttributeName" => :age, "AttributeType" => "N"}],
             "KeySchema" => [%{"AttributeName" => :email, "KeyType" => "HASH"}, %{"AttributeName" => :age, "KeyType" => "RANGE"}],
             "ProvisionedThroughput" => %{"ReadCapacityUnits" => 1, "WriteCapacityUnits" => 1}, "TableName" => "Users"}

    assert Dynamo.create_table("Users", [email: :hash, age: :range], [email: :string, age: :number], 1, 1) == expected
  end

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

    assert Dynamo.query("Users",
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
    expected = %{"RequestItems" => %{"Users" => [%{"DeleteRequest" => %{"Key" => %{"S" => "api_key1"}}},
     %{"PutRequest" => %{"Item" => %{"admin" => %{"BOOL" => "false"},
     "age" => %{"N" => "23"}, "email" => %{"S" => "foo@bar.com"},
     "name" => %{"M" => %{"first" => %{"S" => "bob"}, "last" => %{"S" => "bubba"}}}}}}]}}

    user = %Test.User{email: "foo@bar.com", name: %{first: "bob", last: "bubba"}, age: 23, admin: false}
    assert Dynamo.batch_write_item(%{
      "Users" => [
        [delete_request: [key: "api_key1"]],
        [put_request: [item: user]]
      ]
    }) == expected
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
