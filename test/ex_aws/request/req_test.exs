defmodule ExAws.Request.ReqTest do
  use ExUnit.Case, async: true

  test "ExAws.Request conformance" do
    plug = fn conn ->
      attempt = Process.get(:retry_attempt, 0)

      if attempt < 3 do
        Process.put(:retry_attempt, attempt + 1)
        Plug.Conn.send_resp(conn, 500, "oops")
      else
        assert conn.host == "test-server"
        assert Plug.Conn.get_req_header(conn, "x-foo") == ["bar"]
        {:ok, body, conn} = Plug.Conn.read_body(conn)
        assert body == ~s|{"message":"hello"}|
        Req.Test.json(conn, %{attempt: attempt})
      end
    end

    config = %{
      http_client: ExAws.Request.Req,
      http_opts: [
        plug: plug
      ],
      retries: [
        base_backoff_in_ms: 1
      ],
      json_codec: Jason,
      access_key_id: "AKIAIOSFODNN7EXAMPLE",
      secret_access_key: "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
      region: "us-east-1"
    }

    {:ok, resp} =
      ExAws.Request.request(
        :post,
        "https://test-server",
        %{message: "hello"},
        [{"x-foo", "bar"}],
        config,
        :s3
      )

    assert resp.status_code == 200

    assert List.keyfind(resp.headers, "content-type", 0) ==
             {"content-type", "application/json; charset=utf-8"}

    assert resp.body == ~s|{"attempt":3}|
  end

  test "sends a bodyless GET as GET (req 0.7 must not rewrite it to POST)" do
    plug = fn conn ->
      Plug.Conn.send_resp(conn, 200, conn.method)
    end

    config = %{
      http_client: ExAws.Request.Req,
      http_opts: [
        plug: plug
      ],
      retries: [
        base_backoff_in_ms: 1
      ],
      json_codec: Jason,
      access_key_id: "AKIAIOSFODNN7EXAMPLE",
      secret_access_key: "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
      region: "us-east-1"
    }

    {:ok, resp} =
      ExAws.Request.request(:get, "https://test-server", "", [], config, :s3)

    assert resp.status_code == 200
    assert resp.body == "GET"
  end

  describe "Req option renaming" do
    setup tags do
      inspect_adapter = fn request ->
        send(self(), {:request, request})
        {request, %Req.Response{status: 200, body: "OK"}}
      end

      http_opts =
        Map.get(tags, :http_opts, [])
        |> Keyword.put_new(:adapter, inspect_adapter)

      config = %{
        http_client: ExAws.Request.Req,
        http_opts: http_opts,
        json_codec: Jason,
        access_key_id: "AKIAIOSFODNN7EXAMPLE",
        secret_access_key: "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
        region: "us-east-1"
      }

      {:ok, %{config: config}}
    end

    @tag http_opts: [follow_redirect: true]
    test "renames :follow_redirect to :redirect", %{config: config} do
      ExAws.Request.request(:get, "https://test-server", "", [], config, :s3)

      assert_receive {:request, request}
      assert Map.get(request.options, :redirect) == true
    end

    @tag http_opts: [redirect: true]
    test "respects existing redirect", %{config: config} do
      ExAws.Request.request(:get, "https://test-server", "", [], config, :s3)

      assert_receive {:request, request}
      assert Map.get(request.options, :redirect) == true
    end

    @tag http_opts: [redirect: false, follow_redirect: true]
    test "prefers Req's redirect to hackney's follow_redirect", %{config: config} do
      ExAws.Request.request(:get, "https://test-server", "", [], config, :s3)

      assert_receive {:request, request}
      assert Map.get(request.options, :redirect) == false
    end

    test "uses default redirect when none is provided", %{config: config} do
      ExAws.Request.request(:get, "https://test-server", "", [], config, :s3)

      assert_receive {:request, request}
      assert Map.get(request.options, :redirect) == false
    end

    @tag http_opts: [recv_timeout: 10_000]
    test "renames :recv_timeout to :receive_timeout", %{config: config} do
      ExAws.Request.request(:get, "https://test-server", "", [], config, :s3)

      assert_receive {:request, request}
      assert Map.get(request.options, :receive_timeout) == 10_000
    end

    @tag http_opts: [receive_timeout: 10_000]
    test "respects existing receive_timeout", %{config: config} do
      ExAws.Request.request(:get, "https://test-server", "", [], config, :s3)

      assert_receive {:request, request}
      assert Map.get(request.options, :receive_timeout) == 10_000
    end

    @tag http_opts: [receive_timeout: 10_000, recv_timeout: 20_000]
    test "prefers Req's receive_timeout to hackney's recv_timeout", %{config: config} do
      ExAws.Request.request(:get, "https://test-server", "", [], config, :s3)

      assert_receive {:request, request}
      assert Map.get(request.options, :receive_timeout) == 10_000
    end

    test "uses default receive_timeout when none is provided", %{config: config} do
      ExAws.Request.request(:get, "https://test-server", "", [], config, :s3)

      assert_receive {:request, request}
      assert Map.get(request.options, :receive_timeout) == 30_000
    end
  end
end

defmodule ExAws.Request.ReqOptsTest do
  # Sets the global :req_opts, so it must not run alongside async tests using Req
  use ExUnit.Case, async: false

  setup tags do
    previous = Application.fetch_env(:ex_aws, :req_opts)
    Application.put_env(:ex_aws, :req_opts, tags.req_opts)

    on_exit(fn ->
      case previous do
        {:ok, value} -> Application.put_env(:ex_aws, :req_opts, value)
        :error -> Application.delete_env(:ex_aws, :req_opts)
      end
    end)

    inspect_adapter = fn request ->
      send(self(), {:request, request})
      {request, %Req.Response{status: 200, body: "OK"}}
    end

    config = %{
      http_client: ExAws.Request.Req,
      http_opts: Keyword.put(Map.get(tags, :http_opts, []), :adapter, inspect_adapter),
      json_codec: Jason,
      access_key_id: "AKIAIOSFODNN7EXAMPLE",
      secret_access_key: "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
      region: "us-east-1"
    }

    {:ok, %{config: config}}
  end

  @tag req_opts: [receive_timeout: 900_000, redirect: true]
  test "uses :req_opts when http_opts does not set the option", %{config: config} do
    ExAws.Request.request(:get, "https://test-server", "", [], config, :s3)

    assert_receive {:request, request}
    assert Map.get(request.options, :receive_timeout) == 900_000
    assert Map.get(request.options, :redirect) == true
  end

  @tag req_opts: [receive_timeout: 900_000, redirect: true]
  @tag http_opts: [recv_timeout: 10_000, follow_redirect: false]
  test "prefers http_opts to :req_opts", %{config: config} do
    ExAws.Request.request(:get, "https://test-server", "", [], config, :s3)

    assert_receive {:request, request}
    assert Map.get(request.options, :receive_timeout) == 10_000
    assert Map.get(request.options, :redirect) == false
  end
end
