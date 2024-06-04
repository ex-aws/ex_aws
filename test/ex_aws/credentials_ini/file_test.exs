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

  test "config file is parsed with sso config" do
    example_config = """
    [default]
    sso_start_url = https://start.us-gov-home.awsapps.com/directory/somecompany
    sso_region = us-gov-west-1
    sso_account_id = 123456789101
    sso_role_name = SomeRole
    region = us-gov-west-1
    output = json
    """

    config = ExAws.CredentialsIni.File.parse_ini_file({:ok, example_config}, "default")

    assert config.sso_start_url == "https://start.us-gov-home.awsapps.com/directory/somecompany"
    assert config.sso_region == "us-gov-west-1"
    assert config.sso_account_id == "123456789101"
    assert config.sso_role_name == "SomeRole"
  end

  test "config file is parsed with sso config that uses sso_session" do
    example_config = """
    [sso-session somecompany]
    sso_start_url = https://start.us-gov-home.awsapps.com/directory/somecompany
    sso_region = us-gov-west-1

    [default]
    sso_session = somecompany
    sso_account_id = 123456789101
    sso_role_name = SomeRole
    region = us-gov-west-1
    output = json
    """

    config = ExAws.CredentialsIni.File.parse_ini_file({:ok, example_config}, "default")

    assert config.sso_session == "somecompany"
    assert config.sso_start_url == "https://start.us-gov-home.awsapps.com/directory/somecompany"
    assert config.sso_region == "us-gov-west-1"
    assert config.sso_account_id == "123456789101"
    assert config.sso_role_name == "SomeRole"
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
