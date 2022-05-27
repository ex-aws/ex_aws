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

  test "using adapter retries when there is an error" do
    # The flaky adapter simulates failures on the adapter side
    # for a few a tries and then returns a successful response.

    defmodule FlakyAdapter do
      @moduledoc false

      @behaviour ExAws.Config.AuthCache.AuthConfigAdapter

      @config %{
        access_key_id: "AKIAIOSFODNN7EXAMPLE",
        secret_access_key: "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
        region: "us-east-1"
      }

      def init do
        :ets.new(__MODULE__, [:named_table, :set, :public, read_concurrency: true])
        :ets.insert(__MODULE__, {:count, 0})
      end

      @impl true
      def adapt_auth_config(_config, _profile, _expiration) do
        [count: count] = :ets.lookup(__MODULE__, :count)

        if count < 3 do
          :ets.insert(__MODULE__, {:count, count + 1})
          {:error, %{status_code: 400, body: "Throttling", reason: "Throttling"}}
        else
          @config
        end
      end
    end

    FlakyAdapter.init()
    Application.put_env(:ex_aws, :awscli_auth_adapter, FlakyAdapter)

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

    ExAws.Request.HttpMock
    |> expect(:request, fn _method, _url, _body, _headers, _opts ->
      @response
    end)

    Process.sleep(100)
    assert ExAws.request(op, @config) == @response
  end
end
