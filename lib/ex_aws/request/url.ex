defmodule ExAws.Request.Url do
  @moduledoc false

  @doc """
  Builds URL for an operation and a config"
  """
  def build(operation, config) do
    config
    |> Map.take([:scheme, :host, :port])
    |> Map.put(:query, query(operation))
    |> Map.put(:path, operation.path)
    |> normalize_scheme
    |> normalize_path
    |> convert_port_to_integer
    |> (&struct(URI, &1)).()
    |> URI.to_string()
    |> String.trim_trailing("?")
  end

  defp query(operation) do
    operation
    |> Map.get(:params, %{})
    |> normalize_params
    |> URI.encode_query()
  end

  defp normalize_scheme(url) do
    url |> Map.update(:scheme, "", &String.replace(&1, "://", ""))
  end

  defp normalize_path(url) do
    url |> Map.update(:path, "", &String.replace(&1, ~r/\/{2,}/, "/"))
  end

  defp convert_port_to_integer(url = %{port: port}) when is_binary(port) do
    {port, _} = Integer.parse(port)
    put_in(url[:port], port)
  end

  defp convert_port_to_integer(url), do: url

  defp normalize_params(params) when is_map(params) do
    params |> Map.delete("") |> Map.delete(nil)
  end

  defp normalize_params(params), do: params

  def sanitize(url, :s3 = service) do
    new_path =
      url
      |> get_path(service)
      |> String.replace_prefix("/", "")
      |> uri_encode()

    query =
      case String.split(url, "?", parts: 2) do
        [_] -> nil
        [_, ""] -> nil
        [_, q] -> q
      end

    url
    |> URI.parse()
    |> Map.put(:fragment, nil)
    |> Map.put(:path, "/" <> new_path)
    |> Map.put(:query, query)
    |> URI.to_string()
    |> String.replace("+", "%20")
  end
  def sanitize(url, _), do: String.replace(url, "+", "%20")

  def get_path(url, service \\ nil)
  def get_path(url, :s3) do
    base =
      url
      |> URI.parse()
      |> Map.put(:path, nil)
      |> Map.put(:query, nil)
      |> Map.put(:fragment, nil)
      |> URI.to_string()
      |> URI.parse()
      |> URI.to_string()

    url
    |> String.split(base, parts: 2)
    |> List.last()
    |> String.split("?")
    |> List.first()
  end

  def get_path(url, _), do: URI.parse(url).path

  def uri_encode(url) do
    url
    |> String.replace("+", " ")
    |> URI.encode(&valid_path_char?/1)
  end

  # Space character
  def valid_path_char?(?\ ), do: false
  def valid_path_char?(?/), do: true

  def valid_path_char?(c) do
    URI.char_unescaped?(c) && !URI.char_reserved?(c)
  end
end
