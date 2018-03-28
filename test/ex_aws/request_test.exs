defmodule ExAws.RequestTest do
  use ExUnit.Case, async: false
  import Mock

  setup do
    {:ok, config: %{http_client: ExAws.Request.Hackney}}
  end

  test "301 redirect", context do
    with_mocks [
      {ExAws.Request.Hackney,
        [],
        [request: fn(_method, _url, _body, _headers, _opts) -> {:ok, %{status_code: 301}} end]},
      {ExAws.Auth,
        [],
        [headers: fn(_method, _url, _service, _config, _headers, _req_body) -> {:ok, %{}} end]}
    ] do
      assert {:error, {:http_error, 301, "redirected"}} == ExAws.Request.request_and_retry(:get, "https://s3.amazonaws.com/test", nil, context[:config], %{}, %{}, {:attempt, 1})
    end
  end
end
