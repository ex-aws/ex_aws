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

    spawn(fn ->
      ExAws.Request.HttpMock
      |> expect(:request, fn _method, _url, _body, _headers, _opts ->
        @response
      end)

      result = ExAws.request(op(), @config)
      send(parent, result)
    end)

    ExAws.Request.HttpMock
    |> expect(:request, fn _method, _url, _body, _headers, _opts ->
      @response
    end)

    Process.sleep(100)
    assert ExAws.request(op(), @config) == @response

    assert_receive @response, 1000
  end

  test "overriding refresh lead time" do
    defmodule RandomAdapter do
      @moduledoc false

      @behaviour ExAws.Config.AuthCache.AuthConfigAdapter

      def adapt_auth_config(_config, _profile, _expiration) do
        %{
          access_key_id: Base.encode64(:crypto.strong_rand_bytes(20)),
          secret_access_key: Base.encode64(:crypto.strong_rand_bytes(20))
        }
      end
    end

    config = [
      http_client: ExAws.Request.HttpMock,
      access_key_id: :instance_role,
      secret_access_key: :instance_role
    ]

    Application.put_env(:ex_aws, :awscli_auth_adapter, RandomAdapter)

    parent = self()

    ExAws.Request.HttpMock
    |> expect(:request, 5,
      fn :get, "http://169.254.169.254/latest/meta-data/iam/security-credentials/", _body, _headers, _opts ->
          {:ok, %{status_code: 200, body: "dummy-role"}}
        :get, _url, _body, headers, _opts ->
          send(parent, headers)
          @response
      end)

    assert ExAws.request(op(), config) == @response
    assert ExAws.request(op(), config) == @response
    assert ExAws.request(op(), [{:auth_cache_refresh_lead_time, 1_000_000_000_000} | config]) == @response
    assert_receive headers1, 1000
    assert_receive headers2, 1000
    assert_receive headers3, 1000

    IO.inspect(headers1)
    IO.inspect(headers2)
    IO.inspect(headers3)
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

    ExAws.Request.HttpMock
    |> expect(:request, fn _method, _url, _body, _headers, _opts ->
      @response
    end)

    Process.sleep(100)
    assert ExAws.request(op(), @config) == @response
  end

  defp op do
  %ExAws.Operation.S3{
      body: "",
      bucket: "",
      headers: %{},
      http_method: :get,
      params: [],
      parser: fn x -> x end,
      path: "/",
      resource: "",
      service: :s3,
      stream_builder: nil
    }
  end

end
