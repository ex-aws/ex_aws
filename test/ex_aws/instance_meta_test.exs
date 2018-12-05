defmodule ExAws.InstanceMetaTest do
  use ExUnit.Case, async: true

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
end
