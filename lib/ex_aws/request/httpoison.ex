defmodule ExAws.Request.HTTPoison do
  @behaviour ExAws.Request.HttpClient

  @moduledoc """
  Configuration for HTTPoison

  Options can set for HTTPoison with the following config

  HTTPoison 0.7.X
  ```
  config :ex_aws, :httpoison_opts,
    recv_timeout: 30_000
  ```

  HTTPoison 0.6.X
  ```
  config :ex_aws, :httpoison_opts,
    hackney: [recv_timeout: 30_000]
  ```

  The default config handles setting both of the above
  """

  @default_timeout 30_000

  # The recv_timeout is repeated inside :hackney because in 0.6.X of
  # HTTPoison it couldn't be set as an option to httpoison directly.
  @default_opts [
    recv_timeout: @default_timeout,
    hackney: [recv_timeout: @default_timeout, pool: false]
  ]

  def request(method, url, body \\ "", headers \\ []) do
    opts = Application.get_env(:ex_aws, :httpoison_opts, @default_opts)
    HTTPoison.request(method, url, body, headers, opts)
  end
end
