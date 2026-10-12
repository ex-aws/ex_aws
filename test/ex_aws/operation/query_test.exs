defmodule ExAws.Operation.QueryTest do
  use ExUnit.Case, async: false
  alias ExAws.JSON.JSX
  import Mox

  defmodule TestParser do
    use ExAws.Operation.Query.Parser

    def parse({:ok, _} = result, _action), do: result
  end

  setup do
    {:ok,
     config: %{
       http_client: ExAws.Request.HttpMock,
       json_codec: JSX,
       access_key_id: "AKIAIOSFODNN7EXAMPLE",
       secret_access_key: "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
       region: "us-east-1",
       host: "email.us-east-1.amazonaws.com",
       port: 443,
       scheme: "https://",
       normalize_path: true,
       retries: [
         max_attempts: 5,
         base_backoff_in_ms: 1,
         max_backoff_in_ms: 20
       ]
     }}
  end

  test "Query.perform retries XML throttling errors using the operation parser", context do
    throttled = """
    <ErrorResponse>
      <Error>
        <Type>Sender</Type>
        <Code>Throttling</Code>
        <Message>Rate exceeded</Message>
      </Error>
    </ErrorResponse>
    """

    success = """
    <SendCustomVerificationEmailResponse>
      <SendCustomVerificationEmailResult>
        <MessageId>abc123</MessageId>
      </SendCustomVerificationEmailResult>
    </SendCustomVerificationEmailResponse>
    """

    ExAws.Request.HttpMock
    |> expect(:request, 2, fn _method, _url, _body, _headers, _opts ->
      {:ok, %{status_code: 400, body: throttled}}
    end)
    |> expect(:request, fn _method, _url, _body, _headers, _opts ->
      {:ok, %{status_code: 200, body: success, headers: []}}
    end)

    operation = %ExAws.Operation.Query{
      path: "/",
      params: %{"Action" => "SendCustomVerificationEmail"},
      service: :ses,
      action: :send_custom_verification_email,
      parser: &TestParser.parse/2
    }

    assert {:ok, %{body: ^success}} = ExAws.Operation.perform(operation, context[:config])
  end

  test "Query.perform retries RequestThrottled errors using the operation parser", context do
    throttled = """
    <ErrorResponse>
      <Error>
        <Type>Sender</Type>
        <Code>RequestThrottled</Code>
        <Message>Request is throttled.</Message>
      </Error>
    </ErrorResponse>
    """

    success = """
    <SendMessageResponse>
      <SendMessageResult>
        <MessageId>msg123</MessageId>
      </SendMessageResult>
    </SendMessageResponse>
    """

    ExAws.Request.HttpMock
    |> expect(:request, 2, fn _method, _url, _body, _headers, _opts ->
      {:ok, %{status_code: 400, body: throttled}}
    end)
    |> expect(:request, fn _method, _url, _body, _headers, _opts ->
      {:ok, %{status_code: 200, body: success, headers: []}}
    end)

    operation = %ExAws.Operation.Query{
      path: "/",
      params: %{"Action" => "SendMessage"},
      service: :sqs,
      action: :send_message,
      parser: &TestParser.parse/2
    }

    assert {:ok, %{body: ^success}} = ExAws.Operation.perform(operation, context[:config])
  end

  test "Query.perform surfaces non-retryable XML errors via the operation parser", context do
    invalid =
      "<ErrorResponse><Error><Type>Sender</Type><Code>InvalidParameterValue</Code><Message>bad</Message></Error></ErrorResponse>"

    ExAws.Request.HttpMock
    |> expect(:request, 1, fn _method, _url, _body, _headers, _opts ->
      {:ok, %{status_code: 400, body: invalid}}
    end)

    operation = %ExAws.Operation.Query{
      path: "/",
      params: %{"Action" => "SendCustomVerificationEmail"},
      service: :ses,
      action: :send_custom_verification_email,
      parser: &TestParser.parse/2
    }

    assert {:error, {:http_error, 400, %{code: "InvalidParameterValue"}}} =
             ExAws.Operation.perform(operation, context[:config])
  end
end
