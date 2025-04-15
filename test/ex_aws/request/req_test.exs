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
end
