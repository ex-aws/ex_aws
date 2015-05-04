defmodule Test.Dummy.Dynamo do
  use ExAws.Dynamo.Client

  def config_root, do: Application.get_all_env(:ex_aws)

  def request(data, action), do: data
end

defmodule ExAws.DynamoTest do
  use ExUnit.Case, async: true
  alias Test.Dummy.Dynamo

  test "#scan" do
    expected = %{
      "ExclusiveStartKey" => %{api_key: %{"S" => "api_key"}},
      "ExpressionAttributeNames" => %{api_key: "#api_key"},
      "ExpressionAttributeValues" => %{api_key: %{"S" => "asdfasdfasdf"},
        name: %{"S" => "bubba"}},
      "FilterExpression" => "ApiKey = #api_key and Name = :name", "Limit" => 12,
        "TableName" => "Users"}

    assert Dynamo.scan("Users",
      limit: 12,
      exclusive_start_key: [api_key: "api_key"],
      expression_attribute_names: [api_key: "#api_key"],
      expression_attribute_values: [api_key: "asdfasdfasdf", name: "bubba"],
      filter_expression: "ApiKey = #api_key and Name = :name") == expected
  end

  test "#query" do
    expected = %{
      "ExclusiveStartKey" => %{api_key: %{"S" => "api_key"}},
      "ExpressionAttributeNames" => %{api_key: "#api_key"},
      "ExpressionAttributeValues" => %{api_key: %{"S" => "asdfasdfasdf"},
        name: %{"S" => "bubba"}},
      "FilterExpression" => "ApiKey = #api_key and Name = :name", "Limit" => 12,
        "TableName" => "Users"}

    assert Dynamo.scan("Users",
      limit: 12,
      exclusive_start_key: [api_key: "api_key"],
      expression_attribute_names: [api_key: "#api_key"],
      expression_attribute_values: [api_key: "asdfasdfasdf", name: "bubba"],
      filter_expression: "ApiKey = #api_key and Name = :name") == expected
  end
end
