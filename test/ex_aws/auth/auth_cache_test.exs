defmodule ExAws.AuthCacheTest do
  use ExUnit.Case, async: false

  import Mox

  @response {:ok, %{status_code: 200, body: %{}}}

  @config [
    http_client: ExAws.Request.HttpMock,
    access_key_id: [{:awscli, "xpto", 1}],
    secret_access_key: [{:awscli, "xpto", 1}]
  ]

  defmodule SleepAdapter do
    @moduledoc false

    @behaviour ExAws.Config.AuthCache.AuthConfigAdapter

    @config %{
      access_key_id: "AKIAIOSFODNN7EXAMPLE",
      secret_access_key: "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
      region: "us-east-1"
    }

    @impl true
    def adapt_auth_config(_config, _profile, _expiration) do
      Process.sleep(200)
      @config
    end
  end

  setup do
    Application.put_env(:ex_aws, :awscli_auth_adapter, SleepAdapter)

    :ok
  end

  test "using adapter does not leak dirty cache" do
    parent = self()

    op = %ExAws.Operation.S3{
      body: "",
      bucket: "",
      headers: %{},
      http_method: :get,
      params: [],
      parser: & &1,
      path: "/",
      resource: "",
      service: :s3,
      stream_builder: nil
    }

    spawn(fn ->
      ExAws.Request.HttpMock
      |> expect(:request, fn _method, _url, _body, _headers, _opts ->
        @response
      end)

      result = ExAws.request(op, @config)
      send(parent, result)
    end)

    ExAws.Request.HttpMock
    |> expect(:request, fn _method, _url, _body, _headers, _opts ->
      @response
    end)

    Process.sleep(100)
    assert ExAws.request(op, @config) == @response

    assert_receive @response, 1000
  end
end
