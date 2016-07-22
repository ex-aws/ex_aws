defmodule ExAws.ConfigTest do
  use ExUnit.Case, async: true

  test "{:system} style configs work" do
    value = "foo"
    System.put_env("ExAwsConfigTest", value)
    assert :s3
    |> ExAws.Config.new([access_key_id: {:system, "ExAwsConfigTest"}])
    |> Map.get(:access_key_id) == value
  end

  test "security_token is configured properly" do
    value = "security_token"
    System.put_env("AWS_SECURITY_TOKEN", value)
    assert :s3
    |> ExAws.Config.new([access_key_id: {:system, "AWS_SECURITY_TOKEN"}, security_token: {:system, "AWS_SECURITY_TOKEN"}])
    |> Map.get(:security_token) == value
  end
end
