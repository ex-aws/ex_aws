defmodule ExAws.Request.Hackney do
  @behaviour ExAws.Request.HttpClient

  @moduledoc """
  Configuration for `:hackney`.

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

  def request_stream(method, url, body \\ "", headers \\ [], http_opts \\ []) do
    {:ok, headers} = headers

    {:ok, status, headers, client} = :hackney.request(method, url, headers, body, http_opts)

    stream =
      Stream.resource(
        fn -> client end,
        &continue_stream/1,
        &finish_stream/1
      )

    {:ok, status, headers, stream}
  end

  defp continue_stream(client) do
    case :hackney.stream_body(client) do
      {:ok, data} ->
        {[data], client}

      :done ->
        {:halt, client}

      {:error, reason} ->
        raise reason
    end
  end

  defp finish_stream(client) do
    :hackney.close(client)
  end
end
