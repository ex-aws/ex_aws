defmodule ExAws.Request do
  @moduledoc """
  Makes requests to AWS.
  """

  require Logger

  @type http_status :: pos_integer
  @type success_content :: %{body: binary, headers: [{binary, binary}]}
  @type success_t :: {:ok, success_content}
  @type error_t :: {:error, {:http_error, http_status, binary}}
  @type response_t :: success_t | error_t

  def request(http_method, url, data, headers, config, service) do
    body =
      case data do
        [] -> "{}"
        d when is_binary(d) -> d
        _ -> config[:json_codec].encode!(data)
      end

    request_and_retry(http_method, url, service, config, headers, body, {:attempt, 1})
  end

  def request_and_retry(_method, _url, _service, _config, _headers, _req_body, {:error, reason}),
    do: {:error, reason}

  def request_and_retry(method, url, service, config, headers, req_body, {:attempt, attempt}) do
    full_headers = ExAws.Auth.headers(method, url, service, config, headers, req_body)

    with {:ok, full_headers} <- full_headers do
      safe_url = ExAws.Request.Url.sanitize(url, service)

      if config[:debug_requests] do
        Logger.debug(
          "ExAws: Request URL: #{inspect(safe_url)} HEADERS: #{inspect(full_headers)} BODY: #{
            inspect(req_body)
          } ATTEMPT: #{attempt}"
        )
      end

      case do_request(config, method, safe_url, req_body, full_headers, attempt) do
        {:ok, %{status_code: status} = resp} when status in 200..299 or status == 304 ->
          {:ok, resp}

        {:ok, %{status_code: status} = _resp} when status == 301 ->
          Logger.warn("ExAws: Received redirect, did you specify the correct region?")
          {:error, {:http_error, status, "redirected"}}

        {:ok, %{status_code: status} = resp} when status in 400..499 ->
          case client_error(resp, config[:json_codec]) do
            {:retry, reason} ->
              request_and_retry(
                method,
                url,
                service,
                config,
                headers,
                req_body,
                attempt_again?(attempt, reason, config)
              )

            {:error, reason} ->
              {:error, reason}
          end

        {:ok, %{status_code: status} = resp} when status >= 500 ->
          body = Map.get(resp, :body)
          reason = {:http_error, status, body}

          request_and_retry(
            method,
            url,
            service,
            config,
            headers,
            req_body,
            attempt_again?(attempt, reason, config)
          )

        {:error, %{reason: reason}} ->
          Logger.warn(
            "ExAws: HTTP ERROR: #{inspect(reason)} for URL: #{inspect(safe_url)} ATTEMPT: #{
              attempt
            }"
          )

          request_and_retry(
            method,
            url,
            service,
            config,
            headers,
            req_body,
            attempt_again?(attempt, reason, config)
          )
      end
    end
  end

  defp do_request(config, method, safe_url, req_body, full_headers, attempt) do
    telemetry_event = Map.get(config, :telemetry_event, [:ex_aws, :request])
    telemetry_options = Map.get(config, :telemetry_options, [])
    telemetry_metadata = %{options: telemetry_options, attempt: attempt}

    :telemetry.span(telemetry_event, telemetry_metadata, fn ->
      result =
        config[:http_client].request(
          method,
          safe_url,
          req_body,
          full_headers,
          Map.get(config, :http_opts, [])
        )

      telemetry_result =
        case result do
          {:ok, %{status_code: status}} when status in 200..299 or status == 304 -> :ok
          _ -> :error
        end

      telemetry_metadata = Map.put(telemetry_metadata, :result, telemetry_result)
      {result, telemetry_metadata}
    end)
  end

  def client_error(%{status_code: status, body: body} = error, json_codec) do
    case json_codec.decode(body) do
      {:ok, %{"__type" => error_type, "message" => message} = err} ->
        handle_error(error_type, message, status, err)

      # Rather irritatingly, as of 1.15, the local version of DynamoDB returns this with a
      # capital M in "Message"
      {:ok, %{"__type" => error_type, "Message" => message} = err} ->
        handle_error(error_type, message, status, err)

      _ ->
        {:error, {:http_error, status, error}}
    end
  end

  def client_error(%{status_code: status} = error, _) do
    {:error, {:http_error, status, error}}
  end

  def handle_aws_error("ProvisionedThroughputExceededException" = type, message) do
    {:retry, {type, message}}
  end

  def handle_aws_error("ThrottlingException" = type, message) do
    {:retry, {type, message}}
  end

  def handle_aws_error(type, message) do
    {:error, {type, message}}
  end

  defp handle_error(error_type, message, status, err) do
    error_type
    |> String.split("#")
    |> case do
      [_, type] -> handle_aws_error(type, message)
      [type] -> handle_aws_error(type, message)
      _ -> {:error, {:http_error, status, err}}
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
    |> :rand.uniform()
    |> :timer.sleep()
  end
end
