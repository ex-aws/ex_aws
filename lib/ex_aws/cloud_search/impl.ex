defmodule ExAws.CloudSearch.Impl do
  def documents_batch(client, documents) do
    data =
      documents
      |> List.wrap
      |> Enum.map(&ExAws.CloudSearch.Document.encode/1)

    request client, :post, "/documents/batch", data
  end

  def search(client, search_term) do
    params = ExAws.CloudSearch.SearchTerm.encode(search_term)

    request client, :get, "/search", params
  end

  defp request(%{__struct__: client_module} = client, action, path, data) do
    client_module.request(client, action, path, data)
  end
end
