defmodule ExAws.SDB.Core do
  @actions [
    "BatchDeleteAttributes",
    "BatchPutAttributes",
    "CreateDomain",
    "DeleteAttributes",
    "DeleteDomain",
    "DomainMetadata",
    "GetAttributes",
    "ListDomains",
    "PutAttributes",
    "Select"]

  @moduledoc """
  ## Amazon SimpleDB

  Amazon SimpleDB is a web service providing the core database functions of
  data indexing and querying in the cloud. By offloading the time and effort
  associated with building and operating a web-scale database, SimpleDB
  provides developers the freedom to focus on application development. A
  traditional, clustered relational database requires a sizable upfront
  capital outlay, is complex to design, and often requires extensive and
  repetitive database administration. Amazon SimpleDB is dramatically
  simpler, requiring no schema, automatically indexing your data and
  providing a simple API for storage and access. This approach eliminates the
  administrative burden of data modeling, index maintenance, and performance
  tuning. Developers gain access to this functionality within Amazon's proven
  computing environment, are able to scale instantly, and pay only for what
  they use.

  Visit [http://aws.amazon.com/simpledb/](http://aws.amazon.com/simpledb/)
  for more information.
  """

  @type attribute :: [
    alternate_name_encoding: binary,
    alternate_value_encoding: binary,
    name: binary,
    value: binary,
  ]

  @type attribute_does_not_exist :: [
    box_usage: float,
  ]

  @type attribute_list :: [attribute]

  @type attribute_name_list :: [binary]

  @type batch_delete_attributes_request :: [
    domain_name: binary,
    items: deletable_item_list,
  ]

  @type batch_put_attributes_request :: [
    domain_name: binary,
    items: replaceable_item_list,
  ]

  @type create_domain_request :: [
    domain_name: binary,
  ]

  @type deletable_item :: [
    attributes: attribute_list,
    name: binary,
  ]

  @type deletable_item_list :: [deletable_item]

  @type delete_attributes_request :: [
    attributes: attribute_list,
    domain_name: binary,
    expected: update_condition,
    item_name: binary,
  ]

  @type delete_domain_request :: [
    domain_name: binary,
  ]

  @type domain_metadata_request :: [
    domain_name: binary,
  ]

  @type domain_metadata_result :: [
    attribute_name_count: integer,
    attribute_names_size_bytes: long,
    attribute_value_count: integer,
    attribute_values_size_bytes: long,
    item_count: integer,
    item_names_size_bytes: long,
    timestamp: integer,
  ]

  @type domain_name_list :: [binary]

  @type duplicate_item_name :: [
    box_usage: float,
  ]

  @type get_attributes_request :: [
    attribute_names: attribute_name_list,
    consistent_read: boolean,
    domain_name: binary,
    item_name: binary,
  ]

  @type get_attributes_result :: [
    attributes: attribute_list,
  ]

  @type invalid_next_token :: [
    box_usage: float,
  ]

  @type invalid_number_predicates :: [
    box_usage: float,
  ]

  @type invalid_number_value_tests :: [
    box_usage: float,
  ]

  @type invalid_parameter_value :: [
    box_usage: float,
  ]

  @type invalid_query_expression :: [
    box_usage: float,
  ]

  @type item :: [
    alternate_name_encoding: binary,
    attributes: attribute_list,
    name: binary,
  ]

  @type item_list :: [item]

  @type list_domains_request :: [
    max_number_of_domains: integer,
    next_token: binary,
  ]

  @type list_domains_result :: [
    domain_names: domain_name_list,
    next_token: binary,
  ]

  @type long :: integer

  @type missing_parameter :: [
    box_usage: float,
  ]

  @type no_such_domain :: [
    box_usage: float,
  ]

  @type number_domain_attributes_exceeded :: [
    box_usage: float,
  ]

  @type number_domain_bytes_exceeded :: [
    box_usage: float,
  ]

  @type number_domains_exceeded :: [
    box_usage: float,
  ]

  @type number_item_attributes_exceeded :: [
    box_usage: float,
  ]

  @type number_submitted_attributes_exceeded :: [
    box_usage: float,
  ]

  @type number_submitted_items_exceeded :: [
    box_usage: float,
  ]

  @type put_attributes_request :: [
    attributes: replaceable_attribute_list,
    domain_name: binary,
    expected: update_condition,
    item_name: binary,
  ]

  @type replaceable_attribute :: [
    name: binary,
    replace: boolean,
    value: binary,
  ]

  @type replaceable_attribute_list :: [replaceable_attribute]

  @type replaceable_item :: [
    attributes: replaceable_attribute_list,
    name: binary,
  ]

  @type replaceable_item_list :: [replaceable_item]

  @type request_timeout :: [
    box_usage: float,
  ]

  @type select_request :: [
    consistent_read: boolean,
    next_token: binary,
    select_expression: binary,
  ]

  @type select_result :: [
    items: item_list,
    next_token: binary,
  ]

  @type too_many_requested_attributes :: [
    box_usage: float,
  ]

  @type update_condition :: [
    exists: boolean,
    name: binary,
    value: binary,
  ]




  @doc """
  BatchDeleteAttributes

  Performs multiple DeleteAttributes operations in a single call, which
  reduces round trips and latencies. This enables Amazon SimpleDB to optimize
  requests, which generally yields better throughput.

  The following limitations are enforced for this operation:

  - 1 MB request size

  - 25 item limit per BatchDeleteAttributes operation
  """

  @spec batch_delete_attributes(client :: ExAws.SDB.t, input :: batch_delete_attributes_request) :: ExAws.Request.Query.response_t
  def batch_delete_attributes(client, input) do
    request(client, "/", "BatchDeleteAttributes", input)
  end

  @doc """
  Same as `batch_delete_attributes/2` but raise on error.
  """
  @spec batch_delete_attributes!(client :: ExAws.SDB.t, input :: batch_delete_attributes_request) :: ExAws.Request.Query.success_t | no_return
  def batch_delete_attributes!(client, input) do
    case batch_delete_attributes(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  BatchPutAttributes

  The `BatchPutAttributes` operation creates or replaces attributes within
  one or more items. By using this operation, the client can perform multiple
  `PutAttribute` operation with a single call. This helps yield savings in
  round trips and latencies, enabling Amazon SimpleDB to optimize requests
  and generally produce better throughput.

  The client may specify the item name with the `Item.X.ItemName` parameter.
  The client may specify new attributes using a combination of the
  `Item.X.Attribute.Y.Name` and `Item.X.Attribute.Y.Value` parameters. The
  client may specify the first attribute for the first item using the
  parameters `Item.0.Attribute.0.Name` and `Item.0.Attribute.0.Value`, and
  for the second attribute for the first item by the parameters
  `Item.0.Attribute.1.Name` and `Item.0.Attribute.1.Value`, and so on.

  Attributes are uniquely identified within an item by their name/value
  combination. For example, a single item can have the attributes `{
  "first_name", "first_value" }` and `{ "first_name", "second_value" }`.
  However, it cannot have two attribute instances where both the
  `Item.X.Attribute.Y.Name` and `Item.X.Attribute.Y.Value` are the same.

  Optionally, the requester can supply the `Replace` parameter for each
  individual value. Setting this value to `true` will cause the new attribute
  values to replace the existing attribute values. For example, if an item
  `I` has the attributes `{ 'a', '1' }, { 'b', '2'}` and `{ 'b', '3' }` and
  the requester does a BatchPutAttributes of `{'I', 'b', '4' }` with the
  Replace parameter set to true, the final attributes of the item will be `{
  'a', '1' }` and `{ 'b', '4' }`, replacing the previous values of the 'b'
  attribute with the new value.

  ** This operation is vulnerable to exceeding the maximum URL size when
  making a REST request using the HTTP GET method. This operation does not
  support conditions using `Expected.X.Name`, `Expected.X.Value`, or
  `Expected.X.Exists`. ** You can execute multiple `BatchPutAttributes`
  operations and other operations in parallel. However, large numbers of
  concurrent `BatchPutAttributes` calls can result in Service Unavailable
  (503) responses.

  The following limitations are enforced for this operation:

  - 256 attribute name-value pairs per item

  - 1 MB request size

  - 1 billion attributes per domain

  - 10 GB of total user data storage per domain

  - 25 item limit per `BatchPutAttributes` operation
  """

  @spec batch_put_attributes(client :: ExAws.SDB.t, input :: batch_put_attributes_request) :: ExAws.Request.Query.response_t
  def batch_put_attributes(client, input) do
    request(client, "/", "BatchPutAttributes", input)
  end

  @doc """
  Same as `batch_put_attributes/2` but raise on error.
  """
  @spec batch_put_attributes!(client :: ExAws.SDB.t, input :: batch_put_attributes_request) :: ExAws.Request.Query.success_t | no_return
  def batch_put_attributes!(client, input) do
    case batch_put_attributes(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateDomain

  The `CreateDomain` operation creates a new domain. The domain name should
  be unique among the domains associated with the Access Key ID provided in
  the request. The `CreateDomain` operation may take 10 or more seconds to
  complete.

  The client can create up to 100 domains per account.

  If the client requires additional domains, go to [
  http://aws.amazon.com/contact-us/simpledb-limit-request/](http://aws.amazon.com/contact-us/simpledb-limit-request/).
  """

  @spec create_domain(client :: ExAws.SDB.t, input :: create_domain_request) :: ExAws.Request.Query.response_t
  def create_domain(client, input) do
    request(client, "/", "CreateDomain", input)
  end

  @doc """
  Same as `create_domain/2` but raise on error.
  """
  @spec create_domain!(client :: ExAws.SDB.t, input :: create_domain_request) :: ExAws.Request.Query.success_t | no_return
  def create_domain!(client, input) do
    case create_domain(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteAttributes

  Deletes one or more attributes associated with an item. If all attributes
  of the item are deleted, the item is deleted.

  `DeleteAttributes` is an idempotent operation; running it multiple times on
  the same item or attribute does not result in an error response.

  Because Amazon SimpleDB makes multiple copies of item data and uses an
  eventual consistency update model, performing a `GetAttributes` or `Select`
  operation (read) immediately after a `DeleteAttributes` or `PutAttributes`
  operation (write) might not return updated item data.
  """

  @spec delete_attributes(client :: ExAws.SDB.t, input :: delete_attributes_request) :: ExAws.Request.Query.response_t
  def delete_attributes(client, input) do
    request(client, "/", "DeleteAttributes", input)
  end

  @doc """
  Same as `delete_attributes/2` but raise on error.
  """
  @spec delete_attributes!(client :: ExAws.SDB.t, input :: delete_attributes_request) :: ExAws.Request.Query.success_t | no_return
  def delete_attributes!(client, input) do
    case delete_attributes(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteDomain

  The `DeleteDomain` operation deletes a domain. Any items (and their
  attributes) in the domain are deleted as well. The `DeleteDomain` operation
  might take 10 or more seconds to complete.
  """

  @spec delete_domain(client :: ExAws.SDB.t, input :: delete_domain_request) :: ExAws.Request.Query.response_t
  def delete_domain(client, input) do
    request(client, "/", "DeleteDomain", input)
  end

  @doc """
  Same as `delete_domain/2` but raise on error.
  """
  @spec delete_domain!(client :: ExAws.SDB.t, input :: delete_domain_request) :: ExAws.Request.Query.success_t | no_return
  def delete_domain!(client, input) do
    case delete_domain(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DomainMetadata

  Returns information about the domain, including when the domain was
  created, the number of items and attributes in the domain, and the size of
  the attribute names and values.
  """

  @spec domain_metadata(client :: ExAws.SDB.t, input :: domain_metadata_request) :: ExAws.Request.Query.response_t
  def domain_metadata(client, input) do
    request(client, "/", "DomainMetadata", input)
  end

  @doc """
  Same as `domain_metadata/2` but raise on error.
  """
  @spec domain_metadata!(client :: ExAws.SDB.t, input :: domain_metadata_request) :: ExAws.Request.Query.success_t | no_return
  def domain_metadata!(client, input) do
    case domain_metadata(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetAttributes

  Returns all of the attributes associated with the specified item.
  Optionally, the attributes returned can be limited to one or more
  attributes by specifying an attribute name parameter.

  If the item does not exist on the replica that was accessed for this
  operation, an empty set is returned. The system does not return an error as
  it cannot guarantee the item does not exist on other replicas.
  """

  @spec get_attributes(client :: ExAws.SDB.t, input :: get_attributes_request) :: ExAws.Request.Query.response_t
  def get_attributes(client, input) do
    request(client, "/", "GetAttributes", input)
  end

  @doc """
  Same as `get_attributes/2` but raise on error.
  """
  @spec get_attributes!(client :: ExAws.SDB.t, input :: get_attributes_request) :: ExAws.Request.Query.success_t | no_return
  def get_attributes!(client, input) do
    case get_attributes(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListDomains

  The `ListDomains` operation lists all domains associated with the Access
  Key ID. It returns domain names up to the limit set by
  [MaxNumberOfDomains](#MaxNumberOfDomains). A [NextToken](#NextToken) is
  returned if there are more than `MaxNumberOfDomains` domains. Calling
  `ListDomains` successive times with the `NextToken` provided by the
  operation returns up to `MaxNumberOfDomains` more domain names with each
  successive operation call.
  """

  @spec list_domains(client :: ExAws.SDB.t, input :: list_domains_request) :: ExAws.Request.Query.response_t
  def list_domains(client, input) do
    request(client, "/", "ListDomains", input)
  end

  @doc """
  Same as `list_domains/2` but raise on error.
  """
  @spec list_domains!(client :: ExAws.SDB.t, input :: list_domains_request) :: ExAws.Request.Query.success_t | no_return
  def list_domains!(client, input) do
    case list_domains(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  PutAttributes

  The PutAttributes operation creates or replaces attributes in an item. The
  client may specify new attributes using a combination of the
  `Attribute.X.Name` and `Attribute.X.Value` parameters. The client specifies
  the first attribute by the parameters `Attribute.0.Name` and
  `Attribute.0.Value`, the second attribute by the parameters
  `Attribute.1.Name` and `Attribute.1.Value`, and so on.

  Attributes are uniquely identified in an item by their name/value
  combination. For example, a single item can have the attributes `{
  "first_name", "first_value" }` and `{ "first_name", second_value" }`.
  However, it cannot have two attribute instances where both the
  `Attribute.X.Name` and `Attribute.X.Value` are the same.

  Optionally, the requestor can supply the `Replace` parameter for each
  individual attribute. Setting this value to `true` causes the new attribute
  value to replace the existing attribute value(s). For example, if an item
  has the attributes `{ 'a', '1' }`, `{ 'b', '2'}` and `{ 'b', '3' }` and the
  requestor calls `PutAttributes` using the attributes `{ 'b', '4' }` with
  the `Replace` parameter set to true, the final attributes of the item are
  changed to `{ 'a', '1' }` and `{ 'b', '4' }`, which replaces the previous
  values of the 'b' attribute with the new value.

  You cannot specify an empty string as an attribute name.

  Because Amazon SimpleDB makes multiple copies of client data and uses an
  eventual consistency update model, an immediate `GetAttributes` or `Select`
  operation (read) immediately after a `PutAttributes` or `DeleteAttributes`
  operation (write) might not return the updated data.

  The following limitations are enforced for this operation:

  - 256 total attribute name-value pairs per item

  - One billion attributes per domain

  - 10 GB of total user data storage per domain
  """

  @spec put_attributes(client :: ExAws.SDB.t, input :: put_attributes_request) :: ExAws.Request.Query.response_t
  def put_attributes(client, input) do
    request(client, "/", "PutAttributes", input)
  end

  @doc """
  Same as `put_attributes/2` but raise on error.
  """
  @spec put_attributes!(client :: ExAws.SDB.t, input :: put_attributes_request) :: ExAws.Request.Query.success_t | no_return
  def put_attributes!(client, input) do
    case put_attributes(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  Select

  The `Select` operation returns a set of attributes for `ItemNames` that
  match the select expression. `Select` is similar to the standard SQL SELECT
  statement.

  The total size of the response cannot exceed 1 MB in total size. Amazon
  SimpleDB automatically adjusts the number of items returned per page to
  enforce this limit. For example, if the client asks to retrieve 2500 items,
  but each individual item is 10 kB in size, the system returns 100 items and
  an appropriate `NextToken` so the client can access the next page of
  results.

  For information on how to construct select expressions, see Using Select to
  Create Amazon SimpleDB Queries in the Developer Guide.
  """

  @spec select(client :: ExAws.SDB.t, input :: select_request) :: ExAws.Request.Query.response_t
  def select(client, input) do
    request(client, "/", "Select", input)
  end

  @doc """
  Same as `select/2` but raise on error.
  """
  @spec select!(client :: ExAws.SDB.t, input :: select_request) :: ExAws.Request.Query.success_t | no_return
  def select!(client, input) do
    case select(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  defp request(%{__struct__: client_module} = client, uri, action, input) do
    apply(client_module, :request, [client, uri, action, input])
  end
end
