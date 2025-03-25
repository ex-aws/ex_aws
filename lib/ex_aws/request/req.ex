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
    http_opts = rename_follow_redirect(http_opts)

    [method: method, url: url, body: body, headers: headers, decode_body: false, retry: false]
    |> Keyword.merge(Application.get_env(:ex_aws, :req_opts, @default_opts))
    |> Keyword.merge(http_opts)
    |> Req.request()
    |> case do
      {:ok, resp} ->
        {:ok, %{status_code: resp.status, headers: Req.get_headers_list(resp), body: resp.body}}

      {:error, reason} ->
        {:error, %{reason: reason}}
    end
  end

  # Req >= 0.4.0 uses :redirect, but some clients pass the :hackney option
  # :follow_redirect. Rename the option for Req to use.
  defp rename_follow_redirect(opts) do
    {follow, opts} = Keyword.pop(opts, :follow_redirect, false)

    Keyword.put(opts, :redirect, follow)
  end
end
