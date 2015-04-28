defmodule ExAws.Request.HttpClient do
  use Behaviour

  @moduledoc """
  Specifies expected behaviour of an http client

  ExAws allows you to use your http client of choice, provided that
  it can be coerced into complying with this module's specification.

  Here for example is the code required to make HTTPotion comply with this spec.

  In your config you would do:

  ```elixir
  config :ex_aws,
    http_client: ExAws.HTTPotionClient
  ```

  ```elixir
  defmodule ExAws.HTTPotionClient do
    @behaviour ExAws.Request.HttpClient
    def request(method, url, body, headers) do
      {:ok, HTTPotion.request(method, url, [body: body, headers: headers, ibrowse: [headers_as_is: true]])}
    end
  end
  ```
  """

  @type http_method :: :get | :post | :put | :delete
  defcallback request(method :: http_method, url :: binary, req_body :: binary, headers :: [{binary, binary}, ...]) ::
    {:ok, %{status_code: pos_integer, body: binary}} |
    {:error, %{reason: any}}
end
