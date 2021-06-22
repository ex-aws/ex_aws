defmodule ExAws.Request.HttpClient do
  @moduledoc """
  Specifies expected behaviour of an http client

  ExAws allows you to use your http client of choice, provided that
  it can be coerced into complying with this module's specification.

  The default is :hackney.

  ## Example

  Here for example is the code required to make HTTPotion comply with this spec.

  In your config you would do:

      config :ex_aws,
        http_client: ExAws.Request.HTTPotion

      defmodule ExAws.Request.HTTPotion do
        @behaviour ExAws.Request.HttpClient
        def request(method, url, body, headers, http_opts) do
          {:ok, HTTPotion.request(method, url, [body: body, headers: headers, ibrowse: [headers_as_is: true]])}
        end
      end

  ```

  When conforming your selected HTTP Client take note of a few things:

    - The module name doesn't need to follow the same styling as this module it
      is simply your own 'HTTP Client', i.e. MyApp.HttpClient

    - The request function must accept the methods as described in the
      @callback below, you can however set these as optional, i.e. (http_opts \\ [])

    - Ensure the call to your chosen HTTP Client is correct and the return is
      in the same format as defined in the @callback below, for example:

  ## Example

      def request(method, url, body, headers, http_opts \\ []) do
        Mojito.request(method, url, headers, body, http_opts)
      end

  """

  @type http_method :: :get | :post | :put | :delete
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
