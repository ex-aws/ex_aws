defmodule ExAws.RequestTest do
  use ExUnit.Case, async: false
  import Mox

  setup do
    {:ok,
     config: %{
       http_client: ExAws.Request.HttpMock,
       access_key_id: "AKIAIOSFODNN7EXAMPLE",
       secret_access_key: "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
       region: "us-east-1"
     },
     headers: [
       {"x-amz-bucket-region", "us-east-1"},
       {"x-amz-content-sha256", ExAws.Auth.Utils.hash_sha256("")},
       {"content-length", byte_size("")}
     ]}
  end

  test "301 redirect", context do
    ExAws.Request.HttpMock
    |> expect(:request, fn _method, _url, _body, _headers, _opts -> {:ok, %{status_code: 301}} end)

    http_method = :get
    url = "https://examplebucket.s3.amazonaws.com/test.txt"
    service = :s3
    request_body = ""

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
  end

  test "handles encoding S3 URLs", context do
    expect(
      ExAws.Request.HttpMock,
      :request,
      fn _method, url, _body, _headers, _opts ->
        assert url == "https://examplebucket.s3.amazonaws.com/test%20hello%20%233.txt"
        {:ok, %{status_code: 200}}
      end
    )

    http_method = :get
    url = "https://examplebucket.s3.amazonaws.com/test hello #3.txt"
    service = :s3
    request_body = ""

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
end
