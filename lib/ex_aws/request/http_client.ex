defmodule ExAws.Request.HttpClient do
  use Behaviour

  defcallback post(url :: binary, req_body :: binary, headers :: [{binary, binary}, ...]) ::
    {:ok, %{status_code: pos_integer, body: binary}} |
    {:error, %{reason: any}}
end
