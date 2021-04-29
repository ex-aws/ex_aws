defmodule ExAws.InstanceMetaTest do
  use ExUnit.Case, async: false

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
          secret_access_key: "dummy"
        )

      assert ExAws.InstanceMeta.instance_role(config) == role_name
    end
  end
end
