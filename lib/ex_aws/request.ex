defmodule ExAws.Request do
  alias ExAws.Config

  def request(service, operation, data) do
    body = Poison.encode!(data)
    headers = headers(service, operation, body)
    request_and_retry(service, headers, body, {:attempt, 1})
  end

  def headers(service, operation, body) do
    conf = Config.config_map
    headers = [
      {'host', Map.get(conf, :"#{service}_host")},
      {'x-amz-target', operation |> String.to_char_list},
    ]

    host = Map.get(conf, :"#{service}_host") |> List.to_string
    region = case host |> String.split(".") do
      [_, value, _, _] -> value |> String.to_char_list
      _ -> 'us-east-1'
    end
    :erlcloud_aws.sign_v4(Config.erlcloud_config, headers, body, region, service |> Atom.to_string)
  end

  def request_and_retry(_, _, _, {:error, reason}), do: {:error, reason}

  def request_and_retry(service, headers, body, {:attempt, attempt}) do
    url = url(service, Config.config_map)
    headers = [{'content-type', 'application/x-amz-json-1.1'} | headers] |> binary_headers
    url |> IO.inspect
    headers |> IO.inspect
    HTTPoison.post(url, body, headers)
  end

  def binary_headers(headers) do
    headers |> Enum.map(fn({k, v}) -> {List.to_string(k), List.to_string(v)} end)
  end

  defp url(service, config) do
    [
      Map.get(config, :"#{service}_scheme"),
      Map.get(config, :"#{service}_host"),
      Map.get(config, :"#{service}_port") |> port
    ] |> Enum.join
  end

  defp port(80), do: ""
  defp port(p),  do: ":#{p}"
end
