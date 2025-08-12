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
                      attempt: 1,
                      service: :s3
                    }}

    assert_receive {[:ex_aws, :request, :stop], %{duration: _},
                    %{
                      options: [],
                      attempt: 1,
                      service: :s3,
                      result: :error
                    }}
  end

  # URL encoding is done under ExAws.Operation.S3
  @tag :skip
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
                      attempt: 1,
                      service: :s3
                    }}

    assert_receive {[:ex_aws, :request, :stop], %{duration: _},
                    %{
                      options: [],
                      attempt: 1,
                      service: :s3,
                      result: :ok
                    }}
  end

  # URL encoding is done under ExAws.Operation.S3
  @tag :skip
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
    TelemetryHelper.attach_telemetry([:ex_aws, :request])
    success = mock_provisioned_throughput_response(2)

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

  test "ProvisionedThroughputExceededException is not retried if client error retries is set to 1",
       context do
    TelemetryHelper.attach_telemetry([:ex_aws, :request])
    mock_provisioned_throughput_response(1)

    http_method = :post
    url = "https://kinesis.aws.com/"
    service = :kinesis
    request_body = ""

    config = context[:config] |> put_in([:retries, :client_error_max_attempts], 1)

    assert {:error, {"ProvisionedThroughputExceededException", _}} =
             ExAws.Request.request_and_retry(
               http_method,
               url,
               service,
               config,
               context[:headers],
               request_body,
               {:attempt, 1}
             )

    assert_receive {[:ex_aws, :request, :start], %{system_time: _}, %{attempt: 1}}
    assert_receive {[:ex_aws, :request, :stop], %{duration: _}, %{attempt: 1, result: :error}}
    refute_receive {[:ex_aws, :request, :start], %{system_time: _}, %{attempt: 2}}
  end

  test "Expected sequence token is provided", context do
    exception =
      "{\"__type\": \"InvalidSequenceTokenException\", \"message\": \"The given sequenceToken is invalid. The next expected sequenceToken is: 49616449618992442982853194240983586320797062450229805234\", \"expectedSequenceToken\": \"49616449618992442982853194240983586320797062450229805234\"}"

    ExAws.Request.HttpMock
    |> expect(:request, fn _method, _url, _body, _headers, _opts ->
      {:ok, %{status_code: 400, body: exception}}
    end)

    http_method = :post
    url = "https://kinesis.aws.com/"
    service = :kinesis
    request_body = ""

    assert {:error,
            {"InvalidSequenceTokenException", _,
             "49616449618992442982853194240983586320797062450229805234"}} =
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

  test "Retries on errors, when the error reason is a map", context do
    ExAws.Request.HttpMock
    |> expect(:request, fn _method, _url, _body, _headers, _opts ->
      {:error, %{reason: :closed}}
    end)

    http_method = :get
    url = "https://examplebucket.s3.amazonaws.com/test.txt"
    service = :s3
    request_body = ""

    assert {:error, :closed} ==
             ExAws.Request.request_and_retry(
               http_method,
               url,
               service,
               context[:config],
               context[:headers],
               request_body,
               {:attempt, 5}
             )
  end

  test "Retries on errors, when the error reason is a keyword list", context do
    ExAws.Request.HttpMock
    |> expect(:request, fn _method, _url, _body, _headers, _opts ->
      {:error, [reason: :closed]}
    end)

    http_method = :get
    url = "https://examplebucket.s3.amazonaws.com/test.txt"
    service = :s3
    request_body = ""

    assert {:error, :closed} ==
             ExAws.Request.request_and_retry(
               http_method,
               url,
               service,
               context[:config],
               context[:headers],
               request_body,
               {:attempt, 5}
             )
  end

  test "TooManyRequestsException is retried", context do
    TelemetryHelper.attach_telemetry([:ex_aws, :request])
    success = mock_too_many_requests_exception(3)

    http_method = :post
    url = "https://cognito-idp.eu-west-1.amazonaws.com"
    service = :"cognito-idp"

    request_body =
      "{\"MessageAction\":\"SUPPRESS\",\"UserAttributes\":[{\"Name\":\"email_verified\",\"Value\":\"False\"},{\"Name\":\"email\",\"Value\":\"user-email@test.com\"}],\"UserPoolId\":\" eu-west-1_abc1dEFGH\",\"Username\":\"user-email@test.com\"}"

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
    assert_receive {[:ex_aws, :request, :stop], %{duration: _}, %{attempt: 3, result: :error}}
    assert_receive {[:ex_aws, :request, :start], %{system_time: _}, %{attempt: 4}}
    assert_receive {[:ex_aws, :request, :stop], %{duration: _}, %{attempt: 4, result: :ok}}
  end

  defp mock_provisioned_throughput_response(success_after_retries) do
    exception =
      "{\"__type\": \"ProvisionedThroughputExceededException\", \"message\": \"Rate exceeded for shard shardId-000000000005 in stream my_stream under account 1234567890.\"}"

    success =
      "{\"SequenceNumber\":\"49592207023850419758877078054930583111417627497740632066\",\"ShardId\":\"shardId-000000000000\"}"

    ExAws.Request.HttpMock
    |> expect(:request, success_after_retries, fn _method, _url, _body, _headers, _opts ->
      {:ok, %{status_code: 400, body: exception}}
    end)
    |> expect(:request, fn _method, _url, _body, _headers, _opts ->
      {:ok, %{status_code: 200, body: success}}
    end)

    success
  end

  def mock_too_many_requests_exception(success_after_retries) do
    exception = "{\"__type\":\"TooManyRequestsException\",\"message\":\"Too many requests\"}"

    success =
      "{\"User\":{\"Attributes\":[{\"Name\":\"email\",\"Value\":\"user-email@test.com\"}],\"Enabled\":true,\"UserCreateDate\":1.743179259439E9,\"UserLastModifiedDate\":1.743179259439E9,\"UserStatus\":\"FORCE_CHANGE_PASSWORD\",\"Username\":\"f52064a4-3061-7030-581b-ae8392e97edd\"}}"

    ExAws.Request.HttpMock
    |> expect(:request, success_after_retries, fn _method, _url, _body, _headers, _opts ->
      {:ok, %{status_code: 400, body: exception}}
    end)
    |> expect(:request, fn _method, _url, _body, _headers, _opts ->
      {:ok, %{status_code: 200, body: success}}
    end)

    success
  end
end
