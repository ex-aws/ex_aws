defprotocol ExAws.CloudSearch.Document do
  @doc """
  The encode function returns a hash that follows the data structure of documents
  in AWS Cloud Search as found [here](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/preparing-data.html#adding-documents)
  and [here](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/preparing-data.html#deleting-documents).

  More specifically there are two types of documents:

  * Add: `{"type":"add","id":"<id>",fields:{"<field name>":"<field value>"}}`
  * Delete: `{"type":"delete","id":"<id>"}

  ExAws ships with a generic add and a generic delete document but by implementing
  this protocol you can build you own document modules (or augment existing modules).
  """
  def encode(document)
end
