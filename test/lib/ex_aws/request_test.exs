defmodule ExAws.RequestTest do
  use ExUnit.Case, async: true
  alias ExAws.Request

  test "it parses DynamoDB-style error bodies" do
    error = %{
      status_code: 400,
      body: ~S({
        "__type": "com.amazonaws.dynamodb.v20120810#InvalidRequestException",
        "message": "Request is invalid"
      })
    }
    expected = {:error, {"InvalidRequestException", "Request is invalid"}}
    assert Request.client_error(error, Poison) == expected
  end

  test "it parses GameLift-style error bodies" do
    error = %{
      status_code: 400,
      body: ~S({
        "__type": "InvalidRequestException",
        "Message": "Request is invalid"
      })
    }
    expected = {:error, {"InvalidRequestException", "Request is invalid"}}
    assert Request.client_error(error, Poison) == expected
  end
end
