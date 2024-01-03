defmodule ExAws.Request.HttpClient do
  @moduledoc """
  Specifies expected behaviour of an HTTP client.

  ExAws allows you to use your HTTP client of choice, provided that
  it can be coerced into complying with this module's specification.

  The default is `:hackney`.

  ## Example: Req

  Here is an example using [Req](https://hexdocs.pm/req/readme.html).

  First, create a module implementing the `ExAws.Request.HttpClient` behaviour.

  ```
  defmodule ExAws.Request.Req do
    @moduledoc \"""
    ExAws HTTP client implementation for Req.
    \"""
    @behaviour ExAws.Request.HttpClient

    @impl ExAws.Request.HttpClient
    def request(method, url, body, headers, _http_opts) do
      case Req.request(method: method, url: url, body: body, headers: headers, decode_body: false) do
        {:ok, response} -> {:ok, adapt_response(response)}
        {:error, reason} -> {:error, %{reason: reason}}
      end
    end

    defp adapt_response(response) do
      # adapt the response to fit the shape expected by ExAWS
      flat_headers =
        Enum.flat_map(response.headers, fn
          {name, vals} when is_list(vals) -> Enum.map(vals, &{name, &1})
          {name, val} -> {name, val}
        end)

      %{
        body: response.body,
        status_code: response.status,
        headers: flat_headers
      }
    end
  end
  ```

  Then, in build-time config (e.g. config.exs):

  ```
  config :ex_aws,
    http_client: ExAws.Request.Req
  ```

  When conforming your selected HTTP Client take note of a few things:

    - The module name doesn't need to follow the same styling as this module it
      is simply your own 'HTTP Client', i.e. `MyApp.HttpClient`

    - The request function must accept the methods as described in the
      `c:request/5` callback, you can however set these as optional,
      i.e. `http_opts \\ []`

    - Ensure the call to your chosen HTTP Client is correct and the return is
      in the same format as defined in the `c:request/5` callback

  ## Example: Mojito

      def request(method, url, body, headers, http_opts \\ []) do
        Mojito.request(method, url, headers, body, http_opts)
      end

  """

  @type http_method :: :get | :post | :put | :delete | :options | :head
  @callback request(
              method :: http_method,
              url :: binary,
              req_body :: binary,
              headers :: [{binary, binary}, ...],
              http_opts :: term
            ) ::
              {:ok, %{status_code: pos_integer, headers: any}}
              | {:ok, %{status_code: pos_integer, headers: any, body: binary}}
              | {:error, %{reason: any}}
end
