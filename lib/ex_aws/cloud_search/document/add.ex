defmodule ExAws.CloudSearch.Document.Add do
  defstruct id: "", fields: %{}
end

defimpl ExAws.CloudSearch.Document, for: ExAws.CloudSearch.Document.Add do
  def encode(document) do
    %{
      type: "add",
      id: document.id,
      fields: document.fields
    }
  end
end
