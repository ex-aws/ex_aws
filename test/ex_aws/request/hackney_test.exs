defmodule ExAws.Request.HackneyTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, bypass: Bypass.open()}
  end

  test "returns the body of a GET response", %{bypass: bypass} do
    Bypass.expect_once(bypass, "GET", "/object", fn conn ->
      Plug.Conn.send_resp(conn, 200, "hello world")
    end)

    assert {:ok, %{status_code: 200, headers: headers, body: "hello world"}} =
             ExAws.Request.Hackney.request(:get, url(bypass), "", [], [])

    assert is_list(headers)
  end

  test "returns an empty body for a HEAD response", %{bypass: bypass} do
    Bypass.expect_once(bypass, "HEAD", "/object", fn conn ->
      conn
      |> Plug.Conn.put_resp_header("x-foo", "bar")
      |> Plug.Conn.send_resp(200, "")
    end)

    assert {:ok, %{status_code: 200, headers: headers, body: nil}} =
             ExAws.Request.Hackney.request(:head, url(bypass), "", [], [])

    assert List.keyfind(headers, "x-foo", 0) == {"x-foo", "bar"}
  end

  test "returns the reason when the request fails", %{bypass: bypass} do
    Bypass.down(bypass)

    assert {:error, %{reason: :econnrefused}} =
             ExAws.Request.Hackney.request(:get, url(bypass), "", [], [])
  end

  defp url(bypass), do: "http://localhost:#{bypass.port}/object"
end
