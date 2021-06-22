defmodule ExAws.CredentialsIni.File.FileTest do
  use ExUnit.Case, async: true

  test "credentials file is parsed" do
    example_credentials = """
    [default]
    aws_access_key_id     = TESTKEYID
    aws_secret_access_key = TESTSECRET
    aws_session_token     = TESTTOKEN
    """

    credentials =
      ExAws.CredentialsIni.File.parse_ini_file({:ok, example_credentials}, "default")
      |> ExAws.CredentialsIni.File.replace_token_key()

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

    credentials =
      ExAws.CredentialsIni.File.parse_ini_file({:ok, example_credentials}, :system)
      |> ExAws.CredentialsIni.File.replace_token_key()

    assert credentials.access_key_id == "TESTKEYID"
    assert credentials.secret_access_key == "TESTSECRET"
    assert credentials.security_token == "TESTTOKEN"
  end

  test "config file is parsed" do
    example_config = """
    [default]
    region = eu-west-1
    """

    config = ExAws.CredentialsIni.File.parse_ini_file({:ok, example_config}, "default")

    assert config.region == "eu-west-1"
  end
end
