defmodule ExAws.Auth.CredentialsTest do
  use ExUnit.Case, async: true

  alias ExAws.Auth.Credentials

  test "generate_credential_v4/3 returns the correct value" do
    datetime = {{2013, 5, 24}, {0, 0, 0}}
    config = [
      access_key_id: "AKIAIOSFODNN7EXAMPLE",
      region: "us-east-1"
    ]

    scope = Credentials.generate_credential_v4("s3", config, datetime)

    assert scope == "AKIAIOSFODNN7EXAMPLE/20130524/us-east-1/s3/aws4_request"
  end

  test "generate_credential_scope_v4/3 returns the correct value" do
    datetime = {{2013, 5, 24}, {0, 0, 0}}
    config = [region: "us-east-1"]

    scope = Credentials.generate_credential_scope_v4("s3", config, datetime)

    assert scope == "20130524/us-east-1/s3/aws4_request"
  end
end
