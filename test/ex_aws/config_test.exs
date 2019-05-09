defmodule ExAws.ConfigTest do
  use ExUnit.Case, async: true

  test "overrides work properly" do
    config = ExAws.Config.new(:s3, region: "us-west-2")
    assert config.region == "us-west-2"
  end

  test "{:system} style configs work" do
    value = "foo"
    System.put_env("ExAwsConfigTest", value)

    assert :s3
           |> ExAws.Config.new(
             access_key_id: {:system, "ExAwsConfigTest"},
             secret_access_key: {:system, "AWS_SECURITY_TOKEN"}
           )
           |> Map.get(:access_key_id) == value
  end

  test "security_token is configured properly" do
    value = "security_token"
    System.put_env("AWS_SECURITY_TOKEN", value)

    assert :s3
           |> ExAws.Config.new(
             access_key_id: {:system, "AWS_SECURITY_TOKEN"},
             security_token: {:system, "AWS_SECURITY_TOKEN"}
           )
           |> Map.get(:security_token) == value
  end

  test "credentials file is parsed" do
    example_credentials = """
    [default]
    aws_access_key_id     = TESTKEYID
    aws_secret_access_key = TESTSECRET
    aws_session_token     = TESTTOKEN
    """

    credentials =
      ExAws.CredentialsIni.parse_ini_file({:ok, example_credentials}, "default")
      |> ExAws.CredentialsIni.replace_token_key()

    assert credentials.access_key_id == "TESTKEYID"
    assert credentials.secret_access_key == "TESTSECRET"
    assert credentials.security_token == "TESTTOKEN"
  end
  
  test "{:system} in profile name gets dynamic profile name" do
    System.put_env("AWS_PROFILE", "custom-profile")

    example_credentials = """
    [custom-profile]
    aws_access_key_id     = TESTKEYID
    aws_secret_access_key = TESTSECRET
    aws_session_token     = TESTTOKEN
    """

    assert :s3
           |> ExAws.Config.new(
             access_key_id: [{:awscli, :system, 30}],
             secret_access_key: [{:awscli, :system, 30}]
           )
           |> (fn 
             %{access_key_id: "TESTKEYID", secret_access_key: "TESTSECRET", security_token: "TESTTOKEN"} -> true
             _ -> false
           end).()
  end


  test "config file is parsed" do
    example_config = """
    [default]
    region = eu-west-1
    """

    config = ExAws.CredentialsIni.parse_ini_file({:ok, example_config}, "default")

    assert config.region == "eu-west-1"
  end
end
