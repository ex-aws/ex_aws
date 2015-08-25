defprotocol ExAws.CloudSearch.Document do
  @fallback_to_any true

  def encode(document)
end
