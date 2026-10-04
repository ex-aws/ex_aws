defmodule ExAws.InstanceMetaTest do
  use ExUnit.Case, async: false

  import Mox

  # Let expect statements apply to ExAws.InstanceMetaTokenProvider process as well
  setup :set_mox_from_context

  test "instance_role" do
    role_name = "dummy-role"

    ExAws.Request.HttpMock
    |> expect(:request, fn _method, _url, _body, _headers, _opts ->
      {:ok, %{status_code: 200, body: role_name}}
    end)

    config =
      ExAws.Config.new(:s3,
        http_client: ExAws.Request.HttpMock,
        access_key_id: "dummy",
        secret_access_key: "dummy",
        # Don't cache the metadata token, so we can always expect a request to get the token
        no_metadata_token_cache: true
      )

    assert ExAws.InstanceMeta.instance_role(config) == role_name
  end

  describe "metadata options" do
    setup %{metadata_opts: metadata_opts} do
      metadata_opts_old = Application.get_env(:ex_aws, :metadata, nil)

      on_exit(fn ->
        case metadata_opts_old do
          nil ->
            Application.delete_env(:ex_aws, :metadata)

          _other ->
            Application.put_env(:ex_aws, :metadata, metadata_opts_old)
        end
      end)

      Application.put_env(:ex_aws, :metadata, metadata_opts)
    end

    @tag metadata_opts: [http_opts: [pool: :ex_aws_metadata]]
    test "separate http opts for instance metadata" do
      role_name = "dummy-role"

      ExAws.Request.HttpMock
      |> expect(:request, fn _method, _url, _body, _headers, opts ->
        assert Keyword.get(opts, :pool) == :ex_aws_metadata
        {:ok, %{status_code: 200, body: role_name}}
      end)

      config =
        ExAws.Config.new(:ec2,
          http_client: ExAws.Request.HttpMock,
          access_key_id: "dummy",
          secret_access_key: "dummy",
          # Don't cache the metadata token, so we can always expect a request to get the token
          no_metadata_token_cache: true
        )

      assert ExAws.InstanceMeta.instance_role(config) == role_name
    end
  end

  describe "IMDSv2" do
    test "when initial metadata request fails with a 401, fallback to IMDSv2 flow" do
      role_name = "dummy-role-imdsv2"

      ExAws.Request.HttpMock
      |> expect(:request, fn :get, _url, _body, _headers, _opts ->
        {:ok, %{status_code: 401, body: ""}}
      end)
      |> expect(:request, fn :put, _url, _body, _headers, _opts ->
        {:ok, %{status_code: 200, body: "dummy-token"}}
      end)
      |> expect(:request, fn :get, _url, _body, headers, _opts ->
        assert Enum.member?(headers, {"x-aws-ec2-metadata-token", "dummy-token"})
        {:ok, %{status_code: 200, body: role_name}}
      end)

      config =
        ExAws.Config.new(:s3,
          http_client: ExAws.Request.HttpMock,
          access_key_id: "dummy",
          secret_access_key: "dummy",
          # Don't cache the metadata token, so we can always expect a request to get the token
          no_metadata_token_cache: true
        )

      assert ExAws.InstanceMeta.instance_role(config) == role_name
    end

    test "configuration to use IMDSv2 by default" do
      role_name = "dummy-role-imdsv2"

      ExAws.Request.HttpMock
      |> expect(:request, fn :put, _url, _body, _headers, _opts ->
        {:ok, %{status_code: 200, body: "dummy-token"}}
      end)
      |> expect(:request, fn :get, _url, _body, headers, _opts ->
        assert Enum.member?(headers, {"x-aws-ec2-metadata-token", "dummy-token"})
        {:ok, %{status_code: 200, body: role_name}}
      end)

      config =
        ExAws.Config.new(:s3,
          http_client: ExAws.Request.HttpMock,
          access_key_id: "dummy",
          secret_access_key: "dummy",
          # Don't cache the metadata token, so we can always expect a request to get the token
          no_metadata_token_cache: true,
          require_imds_v2: true
        )

      assert ExAws.InstanceMeta.instance_role(config) == role_name
    end

    test "token request targets the EC2 metadata endpoint even when running in ECS" do
      # ECS sets AWS_CONTAINER_CREDENTIALS_RELATIVE_URI in every task. The
      # task-role credentials endpoint (169.254.170.2) does not issue IMDSv2
      # tokens, so the token PUT must still go to 169.254.169.254 — otherwise
      # the credentials-endpoint response body is used as a bogus token and
      # all subsequent metadata requests fail with a 401.
      System.put_env("AWS_CONTAINER_CREDENTIALS_RELATIVE_URI", "/v2/credentials/dummy-id")
      on_exit(fn -> System.delete_env("AWS_CONTAINER_CREDENTIALS_RELATIVE_URI") end)

      role_name = "dummy-role-ecs"

      ExAws.Request.HttpMock
      |> expect(:request, fn :put, url, _body, _headers, _opts ->
        assert url == "http://169.254.169.254/latest/api/token"
        {:ok, %{status_code: 200, body: "dummy-token"}}
      end)
      |> expect(:request, fn :get, _url, _body, headers, _opts ->
        assert Enum.member?(headers, {"x-aws-ec2-metadata-token", "dummy-token"})
        {:ok, %{status_code: 200, body: role_name}}
      end)

      config =
        ExAws.Config.new(:s3,
          http_client: ExAws.Request.HttpMock,
          access_key_id: "dummy",
          secret_access_key: "dummy",
          # Don't cache the metadata token, so we can always expect a request to get the token
          no_metadata_token_cache: true,
          require_imds_v2: true
        )

      assert ExAws.InstanceMeta.instance_role(config) == role_name
    end
  end
end
