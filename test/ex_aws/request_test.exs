defmodule ExAws.RequestTest do
  use ExUnit.Case, async: false
  import ExUnit.CaptureLog
  alias ExAws.JSON.JSX
  import Mox

  setup do
    {:ok,
     config: %{
       http_client: ExAws.Request.HttpMock,
       json_codec: JSX,
       access_key_id: "AKIAIOSFODNN7EXAMPLE",
       secret_access_key: "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
       region: "us-east-1",
       retries: [
         max_attempts: 5,
         base_backoff_in_ms: 1,
         max_backoff_in_ms: 20
       ]
     },
     headers: [
       {"x-amz-bucket-region", "us-east-1"},
       {"x-amz-content-sha256", ExAws.Auth.Utils.hash_sha256("")},
       {"content-length", byte_size("")}
     ]}
  end

  test "301 redirect", context do
    TelemetryHelper.attach_telemetry([:ex_aws, :request])

    ExAws.Request.HttpMock
    |> expect(:request, fn _method, _url, _body, _headers, _opts -> {:ok, %{status_code: 301}} end)

    http_method = :get
    url = "https://examplebucket.s3.amazonaws.com/test.txt"
    service = :s3
    request_body = ""

    assert capture_log(fn ->
             assert {:error, {:http_error, 301, "redirected"}} ==
                      ExAws.Request.request_and_retry(
                        http_method,
                        url,
                        service,
                        context[:config],
                        context[:headers],
                        request_body,
                        {:attempt, 1}
                      )
           end) =~ "Received redirect, did you specify the correct region?"

    assert_receive {[:ex_aws, :request, :start], %{system_time: _},
                    %{
                      options: [],
                      attempt: 1
                    }}

    assert_receive {[:ex_aws, :request, :stop], %{duration: _},
                    %{
                      options: [],
                      attempt: 1,
                      result: :error
                    }}
  end

  test "handles encoding S3 URLs with params", context do
    http_method = :get
    url = "https://examplebucket.s3.amazonaws.com/test hello #3.txt?acl=21"
    service = :s3
    request_body = ""

    TelemetryHelper.attach_telemetry([:ex_aws, :request])

    expect(
      ExAws.Request.HttpMock,
      :request,
      fn _method, url, _body, _headers, _opts ->
        assert url == "https://examplebucket.s3.amazonaws.com/test%20hello%20%233.txt?acl=21"
        {:ok, %{status_code: 200}}
      end
    )

    assert {:ok, %{status_code: 200}} ==
             ExAws.Request.request_and_retry(
               http_method,
               url,
               service,
               context[:config],
               context[:headers],
               request_body,
               {:attempt, 1}
             )

    assert_receive {[:ex_aws, :request, :start], %{system_time: _},
                    %{
                      options: [],
                      attempt: 1
                    }}

    assert_receive {[:ex_aws, :request, :stop], %{duration: _},
                    %{
                      options: [],
                      attempt: 1,
                      result: :ok
                    }}
  end

  test "handles encoding S3 URLs without params", context do
    http_method = :get
    url = "https://examplebucket.s3.amazonaws.com/up//double//test hello+#3.txt"
    service = :s3
    request_body = ""

    expect(
      ExAws.Request.HttpMock,
      :request,
      fn _method, url, _body, _headers, _opts ->
        assert url == "https://examplebucket.s3.amazonaws.com/up//double//test%20hello%2B%233.txt"
        {:ok, %{status_code: 200}}
      end
    )

    assert {:ok, %{status_code: 200}} ==
             ExAws.Request.request_and_retry(
               http_method,
               url,
               service,
               context[:config],
               context[:headers],
               request_body,
               {:attempt, 1}
             )
  end

  test "ProvisionedThroughputExceededException is retried", context do
    exception =
      "{\"__type\": \"ProvisionedThroughputExceededException\", \"message\": \"Rate exceeded for shard shardId-000000000005 in stream my_stream under account 1234567890.\"}"

    success =
      "{\"SequenceNumber\":\"49592207023850419758877078054930583111417627497740632066\",\"ShardId\":\"shardId-000000000000\"}"

    TelemetryHelper.attach_telemetry([:ex_aws, :request])

    ExAws.Request.HttpMock
    |> expect(:request, 2, fn _method, _url, _body, _headers, _opts ->
      {:ok, %{status_code: 400, body: exception}}
    end)
    |> expect(:request, fn _method, _url, _body, _headers, _opts ->
      {:ok, %{status_code: 200, body: success}}
    end)

    http_method = :post
    url = "https://kinesis.aws.com/"
    service = :kinesis
    request_body = ""

    assert {:ok, %{body: success, status_code: 200}} ==
             ExAws.Request.request_and_retry(
               http_method,
               url,
               service,
               context[:config],
               context[:headers],
               request_body,
               {:attempt, 1}
             )

    assert_receive {[:ex_aws, :request, :start], %{system_time: _}, %{attempt: 1}}
    assert_receive {[:ex_aws, :request, :stop], %{duration: _}, %{attempt: 1, result: :error}}
    assert_receive {[:ex_aws, :request, :start], %{system_time: _}, %{attempt: 2}}
    assert_receive {[:ex_aws, :request, :stop], %{duration: _}, %{attempt: 2, result: :error}}
    assert_receive {[:ex_aws, :request, :start], %{system_time: _}, %{attempt: 3}}
    assert_receive {[:ex_aws, :request, :stop], %{duration: _}, %{attempt: 3, result: :ok}}
  end
end
