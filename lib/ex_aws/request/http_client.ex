defmodule ExAws.Request.HttpClient do
  use Behaviour

  @type http_method :: :get | :post | :put | :delete
  defcallback request(method :: http_method, url :: binary, req_body :: binary, headers :: [{binary, binary}, ...]) ::
    {:ok, %{status_code: pos_integer, body: binary}} |
    {:error, %{reason: any}}
end
