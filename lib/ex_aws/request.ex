defmodule ExAws.Request do
  require Logger
  alias ExAws.Config
  @max_attempts 10

  def request(service, action) do
    request(service, action, %{})
  end

  def request(service, operation, data) do
    body = case data do
      [] -> "{}"
      _  -> Poison.encode!(data)
    end

    headers = headers(service, Config.for_service(service), operation, body)
    request_and_retry(service, Config.for_service(service), headers, body, {:attempt, 1})
  end

  def headers(service, config, operation, body) do
    headers = [
      {"host", Keyword.get(config, :host)},
      {"x-amz-target", operation},
      {"content-type", json_version(service)}
    ]

    host = Keyword.get(config, :host)
    region = Keyword.get(config, :region)

    auth_header = AWSAuth.sign_authorization_header(
      Config.get(:access_key_id),
      Config.get(:access_key_id),
      "POST",
      config |> url,
      region,
      service |> service_name,
      headers |> Enum.into(%{}))
    |> IO.inspect

    [{"Authorization", auth_header} | headers ]
    |> IO.inspect
  end

  defp json_version(:dynamodb), do: "application/x-amz-json-1.0"
  defp json_version(:kinesis), do: "application/x-amz-json-1.1"

  def service_name(service), do: service |> Atom.to_string

  def request_and_retry(_, _, _, {:error, reason}), do: {:error, reason}

  def request_and_retry(service, config, headers, body, {:attempt, attempt}) do
    url = config |> url

    if Application.get_env(:ex_aws, :debug_requests) do
      Logger.debug("Request URL: #{inspect url}")
      Logger.debug("Request HEADERS: #{inspect headers}")
      Logger.debug("Request BODY: #{body}")
    end

    case HTTPoison.post(url, body, headers) do
      {:ok, %HTTPoison.Response{status_code: status, body: ""}} when status in 200..299 ->
        {:ok, ""}
      {:ok, %HTTPoison.Response{status_code: status, body: body}} when status in 200..299 ->
        case Poison.Parser.parse(body) do
          {:ok, result} -> {:ok, result}
          {:error, _}   -> {:error, body}
        end
      {:ok, %HTTPoison.Response{status_code: status} = resp} when status in 400..499 ->
        case client_error(resp) do
          {:retry, reason} ->
            request_and_retry(service, config, headers, body, attempt_again?(attempt, reason))
          {:error, reason} -> {:error, reason}
        end
      {:ok, %HTTPoison.Response{status_code: status, body: body}} when status >= 500 ->
        reason = {:http_error, status, body}
        request_and_retry(service, config, headers, body, attempt_again?(attempt, reason))
      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error("ExAws: HTTPOISON ERROR: #{inspect reason}")
        request_and_retry(service, config, headers, body, attempt_again?(attempt, reason))
      whoknows ->
        Logger.info "Unknown response"
        whoknows |> inspect |> Logger.info
        {:error, whoknows}
    end
  end

  def client_error(%HTTPoison.Response{status_code: status, body: body}) do
    case Poison.Parser.parse(body) do
      {:ok, %{"__type" => error_type, "message" => message} = err} ->
        error_type
        |> String.split("#")
        |> case do
          [_, type] -> handle_aws_error(type, message)
          _         -> {:error, {:http_error, status, err}}
        end
      _ -> {:error, {:http_error, status, body}}
    end
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

  def attempt_again?(attempt, reason) when attempt >= @max_attempts do
    {:error, reason}
  end

  def attempt_again?(attempt, _) do
    attempt |> backoff
    {:attempt, attempt + 1}
  end

  # TODO: make exponential
  # TODO: add jitter
  def backoff(attempt) do
    :timer.sleep(attempt * 1000)
  end

  defp url(config) do
    [
      Keyword.get(config, :scheme),
      Keyword.get(config, :host),
      Keyword.get(config, :port) |> port
    ] |> IO.iodata_to_binary
  end

  defp port(80), do: ""
  defp port(p),  do: ":#{p}"
end
