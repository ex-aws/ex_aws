defmodule ExAws.CloudSearch.Document.Delete do
  defstruct id: ""
end

defimpl ExAws.CloudSearch.Document, for: ExAws.CloudSearch.Document.Delete do
  def encode(document) do
    %{
      type: "delete",
      id: document.id
    }
  end
end
