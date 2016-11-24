defmodule ExAws.STSTest do
  use ExUnit.Case, async: true
  alias ExAws.STS

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

    assert expected == STS.get_federation_token(duration, name, policy).params
  end
end
