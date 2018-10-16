defmodule ExAws.Request.Httpc do
  @behaviour ExAws.Request.HttpClient

  @ex_aws_profile :ex_aws

  @moduledoc """
  Configuration for :httpc

  Options can be set for :httpc with the following config:

      config :ex_aws, :httpc_http_opts,
        connect_timeout: 5_000,
        timeout: 60_000

      config :ex_aws, :httpc_profile_opts,
        max_pipeline_length: 10,
        pipeline_timeout: 5_000,
        max_sessions: 4

  """

  @default_http_opts [connect_timeout: 5_000, timeout: 60_000]
  @default_profile_opts [max_sessions: 4, socket_opts: [reuseaddr: true]]
  @default_opts []


  def request(method, url, body \\ "", headers \\ [], http_opts \\ []) do

    http_opts = http_opts ++ Application.get_env(:ex_aws, :httpc_http_opts, @default_http_opts)
    opts = Application.get_env(:ex_aws, :httpc_opts, @default_opts)
    case :inets.start(:httpc, [profile: @ex_aws_profile]) do
      {:ok, _pid} ->
        :httpc.set_options(@default_profile_opts, @ex_aws_profile)
      {:error, {:already_started, _pid}} ->
        :ok
    end
    httpc_content_type = Enum.reduce(headers, "no_content_type", fn {key, value}, acc ->
      if String.downcase(key) == "content-type", do: value, else: acc
    end) |> to_charlist()

    httpc_headers = for {field, value} <- headers, do: {to_charlist(field), to_charlist(value)}
    httpc_url = url |> to_charlist()

    httpc_request = if httpc_content_type == 'no_content_type' do
      {httpc_url, httpc_headers}
    else
      {httpc_url, httpc_headers, httpc_content_type, body}
    end

    case :httpc.request(method, httpc_request, http_opts, opts, @ex_aws_profile) do
      {:ok, {{_http_version, status_code, _reason_phrase}, httpc_resp_headers, resp_body}} ->
        resp_headers = for {field, value} <- httpc_resp_headers, do: {to_string(field), to_string(value)}
        resp_body = if resp_body |> is_binary() do
          resp_body
        else
          to_string(resp_body)
        end
        {:ok, %{status_code: status_code, headers: resp_headers, body: resp_body}}
      {:ok, {{_http_version, status_code, _reason_phrase}, httpc_resp_headers}} ->
        resp_headers = for {field, value} <- httpc_resp_headers, do: {to_string(field), to_string(value)}
        {:ok, %{status_code: status_code, headers: resp_headers}}
      {:error, reason} ->
        {:error, %{reason: reason}}
    end
  end
end
