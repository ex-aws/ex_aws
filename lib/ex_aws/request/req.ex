defmodule ExAws.Request.Req do
  @behaviour ExAws.Request.HttpClient

  @moduledoc """
  Configuration for `m:Req`.

  Options can be set for `m:Req` with the following config:

      config :ex_aws, :req_opts,
        receive_timeout: 30_000

  The default config handles setting the above.
  """

  @default_opts [receive_timeout: 30_000]

  @impl true
  def request(method, url, body \\ "", headers \\ [], http_opts \\ []) do
    [method: method, url: url, body: body, headers: headers, decode_body: false]
    |> Keyword.merge(Application.get_env(:ex_aws, :req_opts, @default_opts))
    |> Keyword.merge(http_opts)
    |> Req.request()
    |> case do
      {:ok, %{status: status, headers: headers, body: body}} ->
        {:ok, %{status_code: status, headers: headers, body: body}}

      {:error, reason} ->
        {:error, %{reason: reason}}
    end
  end
end
