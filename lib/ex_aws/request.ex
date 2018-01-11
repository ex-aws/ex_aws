defmodule ExAws.Request do
  require Logger

  @moduledoc """
  Makes requests to AWS.
  """

  @type http_status :: pos_integer
  @type success_content :: %{body: binary, headers: [{binary, binary}]}
  @type success_t :: {:ok, success_content}
  @type error_t :: {:error, {:http_error, http_status, binary}}
  @type response_t :: success_t | error_t

  @retryable_errors [
    "ProvisionedThroughputExceededException",
    "ThrottlingException"
  ]

  def request(http_method, url, data, headers, config, service) do
    body = case data do
      []  -> "{}"
      d when is_binary(d) -> d
      _   -> config[:json_codec].encode!(data)
    end

    request_and_retry(http_method, url, service, config, headers, body, {:attempt, 1})
  end

  def request_and_retry(_method, _url, _service, _config, _headers, _req_body, {:error, reason}),
    do: {:error, reason}

  def request_and_retry(method, url, service, config, headers, req_body, {:attempt, attempt}) do
    full_headers = ExAws.Auth.headers(method, url, service, config, headers, req_body)

    url = replace_spaces(url)

    with {:ok, full_headers} <- full_headers do
      if config[:debug_requests] do
        Logger.debug("Request URL: #{inspect url}")
        Logger.debug("Request HEADERS: #{inspect full_headers}")
        Logger.debug("Request BODY: #{inspect req_body}")
      end

      case config[:http_client].request(method, url, req_body, full_headers, Map.get(config, :http_opts, [])) do
        {:ok, %{status_code: status} = resp} when status in 200..299 or status == 304 ->
          {:ok, resp}

        {:ok, %{status_code: status} = resp} when status in 400..499 ->
          case client_error(resp, config[:json_codec]) do
            {:retry, reason} ->
              Logger.warn("ExAws: HTTP ERROR: #{inspect(reason)}")
              request_and_retry(method, url, service, config, headers, req_body, attempt_again?(attempt, reason, config))
            {:error, reason} ->
              {:error, reason}
          end

        {:ok, %{status_code: status} = resp} when status >= 500 ->
          body = Map.get(resp, :body)
          reason = {:http_error, status, body}
          Logger.warn("ExAws: HTTP ERROR: #{inspect(reason)}")
          request_and_retry(method, url, service, config, headers, req_body, attempt_again?(attempt, reason, config))

        {:error, %{reason: reason}} ->
          Logger.warn("ExAws: HTTP ERROR: #{inspect reason}")
          request_and_retry(method, url, service, config, headers, req_body, attempt_again?(attempt, reason, config))
      end
    end
  end

  def client_error(%{status_code: status, body: body} = error, json_codec) do
    case json_codec.decode(body) do
      {:ok, %{"__type" => error_type, "message" => message} = err} ->
        if retry_error?(error_type) do
          {:retry, {error_type, message}}
        else
          {:error, {:http_error, status, err}}
        end

      _ ->
        {:error, {:http_error, status, error}}
    end
  end
  def client_error(%{status_code: status} = error, _) do
    {:error, {:http_error, status, error}}
  end

  def retry_error?(error_type) do
    clean_error_type = get_clean_error_type(error_type)
    Enum.member?(@retryable_errors, clean_error_type)
  end

  def get_clean_error_type(error_type) do
    error_type
    |> String.split("#")
    |> case do
      [_, type] -> type
      [type]    -> type
    end
  end

  def attempt_again?(attempt, reason, config) do
    if attempt >= config[:retries][:max_attempts] do
      {:error, reason}
    else
      attempt |> backoff(config)
      {:attempt, attempt + 1}
    end
  end

  def backoff(attempt, config) do
    (config[:retries][:base_backoff_in_ms] * :math.pow(2, attempt))
    |> min(config[:retries][:max_backoff_in_ms])
    |> trunc
    |> :rand.uniform
    |> :timer.sleep
  end

  defp replace_spaces(url) do
    String.replace(url, " ", "%20")
  end
end
