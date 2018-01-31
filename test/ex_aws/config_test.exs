defmodule ExAws.ConfigTest do
  use ExUnit.Case, async: true

  setup do
    ExAws.Config.AuthCache.use_awscli_filenames(fixture("aws_config"), fixture("aws_credentials"))
    :ok
  end

  defp fixture(file_name), do: Path.join(["test", "ex_aws", "fixtures", file_name])

  test "allows to specify options that override the defaults" do
    config = [
      http_client: ExAws.ConfigTest,
      http_opts: [x: 1, y: 2],
      access_key_id: "TEST_ACCESS_KEY_ID",
      retries: [
        max_attempts: 3,
        base_backoff_in_ms: 100,
        max_backoff_in_ms: 20_000
      ]
    ]

    assert %{
        http_client: ExAws.ConfigTest,
        http_opts: [x: 1, y: 2],
        access_key_id: "TEST_ACCESS_KEY_ID",
        retries: [
          max_attempts: 3,
          base_backoff_in_ms: 100,
          max_backoff_in_ms: 20_000
        ],
        port: 443
      } = ExAws.Config.new(:s3, config)
  end

  test "overrides work properly" do
    config = ExAws.Config.new(:s3, region: "us-west-2")
    assert config.region == "us-west-2"
  end

  test "{:system} style configs work" do
    [
      {"EX_AWS_TEST_ACCESS_KEY_ID", "TEST_ACCESS_KEY_ID"},
      {"EX_AWS_TEST_SECRET_ACCESS_KEY", "TEST_SECRET_ACCESS_KEY"},
      {"EX_AWS_TEST_SECURITY_TOKEN", "TEST_SECURITY_TOKEN"},
      {"EX_AWS_TEST_HOST", "TEST_HOST"}
    ] |> Enum.each(fn {env_var, value} -> System.put_env(env_var, value) end)

    config = [
      access_key_id: {:system, "EX_AWS_TEST_ACCESS_KEY_ID"},
      secret_access_key: {:system, "EX_AWS_TEST_SECRET_ACCESS_KEY"},
      security_token: {:system, "EX_AWS_TEST_SECURITY_TOKEN"},
      host: {:system, "EX_AWS_TEST_HOST"}
    ]

    assert %{
        access_key_id: "TEST_ACCESS_KEY_ID",
        secret_access_key: "TEST_SECRET_ACCESS_KEY",
        security_token: "TEST_SECURITY_TOKEN",
        host: "TEST_HOST"
      } = ExAws.Config.new(:s3, config)
  end

  test "supports mulitple {:system} styles" do
    System.put_env("EX_AWS_TEST_ENV_VAR_2", "TEST_ACCESS_KEY_ID")

    config = [
      access_key_id: [
        {:system, "EX_AWS_TEST_ENV_VAR_1"},
        {:system, "EX_AWS_TEST_ENV_VAR_2"}
      ]
    ]

    assert %{access_key_id: "TEST_ACCESS_KEY_ID"} = ExAws.Config.new(:s3, config)
  end

  test "{:awscli} style configs work" do
    config = [
      access_key_id: {:awscli, "default", 30},
      secret_access_key: {:awscli, "default", 30},
      security_token: {:awscli, "default", 30}
    ]

    assert %{
        access_key_id: "TEST_ACCESS_KEY_ID",
        secret_access_key: "TEST_SECRET_ACCESS_KEY",
        security_token: "TEST_SECURITY_TOKEN",
        region: "us-east-1"
      } = ExAws.Config.new(:s3, config)
  end

  test "can use multiple styles" do
    config = [
      access_key_id: [
        {:system, "EX_AWS_TEST_NEVER_SET"},
        {:awscli, "default", 30}
      ]
    ]

    assert %{access_key_id: "TEST_ACCESS_KEY_ID"} = ExAws.Config.new(:s3, config)
  end

  test "supports complex host configuration" do
    config = [
      region: "eu-west-1",
      host: {"(region)", "service-(region).amazonaws.com"}
    ]

    assert ExAws.Config.new(:sts, config).host == "service-eu-west-1.amazonaws.com"
  end

  test "host in config file overrides the derived host" do
    assert ExAws.Config.new(:s3, region: "eu-west-1").host == "s3.amazonaws.com"
  end
end
