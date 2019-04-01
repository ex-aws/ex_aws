defmodule ExAws.InstanceMetaTest do
  use ExUnit.Case

  import Mox

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
        secret_access_key: "dummy"
      )

    assert ExAws.InstanceMeta.instance_role(config) == role_name
  end

  test "retry after a 429" do
    ExAws.Request.HttpMock
    |> expect(:request, fn _method, _url, _body, _headers, _opts ->
      {:ok, %{status_code: 429, body: ""}}
    end)
    |> expect(:request, fn _method, _url, _body, _headers, _opts ->
      {:ok, %{status_code: 200, body: "body"}}
    end)

    config =
      ExAws.Config.new(:s3,
        http_client: ExAws.Request.HttpMock,
        access_key_id: "dummy",
        secret_access_key: "dummy"
      )

    assert ExAws.InstanceMeta.request(config, "url") == "body"
  end

  test "fails after too many 429s" do
    old_config = Application.get_env(:ex_aws, :retries) || []
    Application.put_env(:ex_aws, :retries, Keyword.put(old_config, :max_attempts, 0))
    on_exit fn ->
      Application.put_env(:ex_aws, :retries, old_config)
    end

    ExAws.Request.HttpMock
    |> expect(:request, fn _method, _url, _body, _headers, _opts ->
      {:ok, %{status_code: 429, body: ""}}
    end)

    config =
      ExAws.Config.new(:s3,
        http_client: ExAws.Request.HttpMock,
        access_key_id: "dummy",
        secret_access_key: "dummy"
      )

    assert_raise RuntimeError, fn ->
      ExAws.InstanceMeta.request(config, "url")
    end
  end
end
