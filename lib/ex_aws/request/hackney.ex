defmodule ExAws.Request.Hackney do
  @behaviour ExAws.Request.HttpClient

  @moduledoc """
  Configuration for `:hackney`

  Options can be set for `:hackney` with the following config:

      config :ex_aws, :hackney_opts,
        recv_timeout: 30_000

  The default config handles setting the above.
  """

  @default_opts [recv_timeout: 30_000]

  def request(method, url, body \\ "", headers \\ [], http_opts \\ []) do
    opts = Application.get_env(:ex_aws, :hackney_opts, @default_opts)
    opts = http_opts ++ [:with_body | opts]

    case :hackney.request(method, url, headers, body, opts) do
      {:ok, status, headers} ->
        {:ok, %{status_code: status, headers: headers}}

      {:ok, status, headers, body} ->
        {:ok, %{status_code: status, headers: headers, body: body}}

      {:error, reason} ->
        {:error, %{reason: reason}}
    end
  end
end
