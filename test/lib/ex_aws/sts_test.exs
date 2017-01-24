defmodule ExAws.STSTest do
  use ExUnit.Case, async: true
  alias ExAws.STS

  test "basic actual hit on the service" do
    result = ExAws.STS.get_caller_identity |> ExAws.request

    assert {:ok, %{body: %{account: _}}} = result
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
end
