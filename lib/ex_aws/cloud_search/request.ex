defmodule ExAws.CloudSearch.Request do
  @version "2013-01-01"

  def request(client = %{config: config}, :get, path, data) do
    data = URI.encode_query(data)
    path = Enum.join([path, data], "?")

    ExAws.Request.request(:get, url(config, path), "", [], client)
    |> parse(config)
  end

  def request(client = %{config: config}, :post, path, data) do
    data    = config.json_codec.encode! data
    headers = [{"content-type", "application/json"}]

    ExAws.Request.request(:post, url(config, path), data, headers, client)
    |> parse(config)
  end

  def parse({:error, result}, _), do: {:error, result}
  def parse({:ok, %{body: body}}, config) do
    {:ok, config[:json_codec].decode!(body)}
  end

  defp url(%{search_endpoint: search_endpoint}, path = "/search" <> _) do
    Path.join(search_endpoint, Enum.join([@version, path]))
  end
  defp url(%{document_endpoint: document_endpoint}, path = "/documents" <> _) do
    Path.join(document_endpoint, Enum.join([@version, path]))
  end
  defp url(_, _) do
    raise """
      Missing configuration: You are missing `:document_endpoint` or
      `:search_endpoint` in your environment configuration.
      """
  end
end
