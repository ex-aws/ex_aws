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
  end

  describe "IMDSv2 token request (GHSA-mww9-g5mj-j664)" do
    test "is made without following redirects" do
      ExAws.Request.HttpMock
      |> expect(:request, fn :put, url, _body, _headers, opts ->
        assert url == "http://169.254.169.254/latest/api/token"
        assert Keyword.fetch!(opts, :follow_redirect) == false
        {:ok, %{status_code: 200, body: "dummy-token"}}
      end)

      config = %{http_client: ExAws.Request.HttpMock}
      assert ExAws.InstanceMetaTokenProvider.request_token(config) == "dummy-token"
    end

    test "a redirect is an error, not a token" do
      ExAws.Request.HttpMock
      |> expect(:request, fn :put, _url, _body, _headers, _opts ->
        {:ok,
         %{
           status_code: 302,
           headers: [{"location", "http://attacker.example/token"}],
           body: "ATTACKER-CONTROLLED-SESSION-TOKEN"
         }}
      end)

      assert_raise RuntimeError, ~r/HTTP response status code 302/, fn ->
        ExAws.InstanceMetaTokenProvider.request_token(%{http_client: ExAws.Request.HttpMock})
      end
    end

    # The token request relies on the HTTP client honouring `follow_redirect:
    # false`. Check that against real servers: one stands in for the metadata
    # endpoint and redirects, the other is where the redirect points.
    for client <- [ExAws.Request.Hackney, ExAws.Request.Req], Code.ensure_loaded?(client) do
      test "#{inspect(client)} does not follow a redirect when told not to" do
        client = unquote(client)
        metadata = Bypass.open()
        elsewhere = Bypass.open()
        test_pid = self()

        Bypass.expect_once(metadata, "PUT", "/latest/api/token", fn conn ->
          conn
          |> Plug.Conn.put_resp_header(
            "location",
            "http://localhost:#{elsewhere.port}/latest/api/token"
          )
          |> Plug.Conn.resp(302, "")
        end)

        Bypass.stub(elsewhere, "PUT", "/latest/api/token", fn conn ->
          send(test_pid, :redirect_followed)
          Plug.Conn.resp(conn, 200, "ATTACKER-CONTROLLED-SESSION-TOKEN")
        end)

        response =
          client.request(
            :put,
            "http://localhost:#{metadata.port}/latest/api/token",
            "",
            [{"x-aws-ec2-metadata-token-ttl-seconds", "21600"}],
            follow_redirect: false
          )

        assert {:ok, %{status_code: 302}} = response
        refute_received :redirect_followed
      end
    end
  end
end
