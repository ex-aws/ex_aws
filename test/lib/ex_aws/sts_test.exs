defmodule ExAws.STSTest do
  use ExUnit.Case, async: true
  alias ExAws.STS

  test "basic actual hit on the service" do
    result = ExAws.STS.get_caller_identity |> ExAws.request

    assert {:ok, %{body: %{account: _}}} = result
  end

  test "#assume_role" do
    version = "2011-06-15"
    arn = "1111111/test_role"
    name = "test role"
    expected = %{
      "Action" => "AssumeRole",
      "RoleSessionName" => name,
      "RoleArn" => arn,
      "Version" => version,
    }

    assert expected == STS.assume_role(arn, name).params
  end


  test "#decode_authorization_message" do
    version = "2011-06-15"
    message = "msgcontent"
    expected = %{
      "Action" => "DecodeAuthorizationMessage",
      "EncodedMessage" => message,
      "Version" => version,
    }

    assert expected == STS.decode_authorization_message(message).params
  end


  test "#get_federation_token" do
    version = "2011-06-15"
    duration = 900
    name = "Bob"
    policy = %{
      "Statement" => [
        %{
          "Sid" => "Stmt1",
          "Effect" => "Allow",
          "Action" => "s3:*",
          "Resource" => "*"
        }
      ]
    }

    expected = %{
      "Action" => "GetFederationToken",
      "DurationSeconds" => duration,
      "Name" => name,
      "Policy" => Poison.encode!(policy),
      "Version" => version,
    }

    opts = [duration: duration, policy: policy]

    assert expected == STS.get_federation_token(name, opts).params
  end

  test "#get_session_token" do
    version = "2011-06-15"
    duration = 900

    expected = %{
      "Action" => "GetSessionToken",
      "DurationSeconds" => duration,
      "Version" => version,
    }

    assert expected == STS.get_session_token([duration: duration]).params
  end

end
