defmodule ExAws.Request.Url do
  @moduledoc false

  @doc """
  Builds URL for an operation and a config"
  """
  def build(operation, config) do
    query =  operation.params |> URI.encode_query
    config
    |> Map.take([:scheme, :host, :port])
    |> normalize_scheme
    |> Map.put(:query, query)
    |> Map.put(:path, operation.path)
    |> (&struct(URI, &1)).()
    |> URI.to_string
  end 

  defp normalize_scheme(%{scheme: scheme} = url) do
    scheme = scheme |> String.replace("://", "")
    url |> Map.put(:scheme, scheme)
  end
  defp normalize_scheme(url), do: url
end
