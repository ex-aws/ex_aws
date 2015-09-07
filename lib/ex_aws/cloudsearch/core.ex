defmodule ExAws.Cloudsearch.Core do
  @actions [
    "BuildSuggesters",
    "CreateDomain",
    "DefineAnalysisScheme",
    "DefineExpression",
    "DefineIndexField",
    "DefineSuggester",
    "DeleteAnalysisScheme",
    "DeleteDomain",
    "DeleteExpression",
    "DeleteIndexField",
    "DeleteSuggester",
    "DescribeAnalysisSchemes",
    "DescribeAvailabilityOptions",
    "DescribeDomains",
    "DescribeExpressions",
    "DescribeIndexFields",
    "DescribeScalingParameters",
    "DescribeServiceAccessPolicies",
    "DescribeSuggesters",
    "IndexDocuments",
    "ListDomainNames",
    "UpdateAvailabilityOptions",
    "UpdateScalingParameters",
    "UpdateServiceAccessPolicies"]

  @moduledoc """
  ## Amazon CloudSearch

  Amazon CloudSearch Configuration Service

  You use the Amazon CloudSearch configuration service to create, configure,
  and manage search domains. Configuration service requests are submitted
  using the AWS Query protocol. AWS Query requests are HTTP or HTTPS requests
  submitted via HTTP GET or POST with a query parameter named Action.

  The endpoint for configuration service requests is region-specific:
  cloudsearch.*region*.amazonaws.com. For example,
  cloudsearch.us-east-1.amazonaws.com. For a current list of supported
  regions and endpoints, see [Regions and
  Endpoints](http://docs.aws.amazon.com/general/latest/gr/rande.html#cloudsearch_region"
  target="_blank).
  """

  @type api_version :: binary

  @type arn :: binary

  @type access_policies_status :: [
    options: policy_document,
    status: option_status,
  ]

  @type algorithmic_stemming :: binary

  @type analysis_options :: [
    algorithmic_stemming: algorithmic_stemming,
    japanese_tokenization_dictionary: binary,
    stemming_dictionary: binary,
    stopwords: binary,
    synonyms: binary,
  ]

  @type analysis_scheme :: [
    analysis_options: analysis_options,
    analysis_scheme_language: analysis_scheme_language,
    analysis_scheme_name: standard_name,
  ]

  @type analysis_scheme_language :: binary

  @type analysis_scheme_status :: [
    options: analysis_scheme,
    status: option_status,
  ]

  @type analysis_scheme_status_list :: [analysis_scheme_status]

  @type availability_options_status :: [
    options: multi_az,
    status: option_status,
  ]

  @type base_exception :: [
    code: error_code,
    message: error_message,
  ]

  @type build_suggesters_request :: [
    domain_name: domain_name,
  ]

  @type build_suggesters_response :: [
    field_names: field_name_list,
  ]

  @type create_domain_request :: [
    domain_name: domain_name,
  ]

  @type create_domain_response :: [
    domain_status: domain_status,
  ]

  @type date_array_options :: [
    default_value: field_value,
    facet_enabled: boolean,
    return_enabled: boolean,
    search_enabled: boolean,
    source_fields: field_name_comma_list,
  ]

  @type date_options :: [
    default_value: field_value,
    facet_enabled: boolean,
    return_enabled: boolean,
    search_enabled: boolean,
    sort_enabled: boolean,
    source_field: field_name,
  ]

  @type define_analysis_scheme_request :: [
    analysis_scheme: analysis_scheme,
    domain_name: domain_name,
  ]

  @type define_analysis_scheme_response :: [
    analysis_scheme: analysis_scheme_status,
  ]

  @type define_expression_request :: [
    domain_name: domain_name,
    expression: expression,
  ]

  @type define_expression_response :: [
    expression: expression_status,
  ]

  @type define_index_field_request :: [
    domain_name: domain_name,
    index_field: index_field,
  ]

  @type define_index_field_response :: [
    index_field: index_field_status,
  ]

  @type define_suggester_request :: [
    domain_name: domain_name,
    suggester: suggester,
  ]

  @type define_suggester_response :: [
    suggester: suggester_status,
  ]

  @type delete_analysis_scheme_request :: [
    analysis_scheme_name: standard_name,
    domain_name: domain_name,
  ]

  @type delete_analysis_scheme_response :: [
    analysis_scheme: analysis_scheme_status,
  ]

  @type delete_domain_request :: [
    domain_name: domain_name,
  ]

  @type delete_domain_response :: [
    domain_status: domain_status,
  ]

  @type delete_expression_request :: [
    domain_name: domain_name,
    expression_name: standard_name,
  ]

  @type delete_expression_response :: [
    expression: expression_status,
  ]

  @type delete_index_field_request :: [
    domain_name: domain_name,
    index_field_name: dynamic_field_name,
  ]

  @type delete_index_field_response :: [
    index_field: index_field_status,
  ]

  @type delete_suggester_request :: [
    domain_name: domain_name,
    suggester_name: standard_name,
  ]

  @type delete_suggester_response :: [
    suggester: suggester_status,
  ]

  @type describe_analysis_schemes_request :: [
    analysis_scheme_names: standard_name_list,
    deployed: boolean,
    domain_name: domain_name,
  ]

  @type describe_analysis_schemes_response :: [
    analysis_schemes: analysis_scheme_status_list,
  ]

  @type describe_availability_options_request :: [
    deployed: boolean,
    domain_name: domain_name,
  ]

  @type describe_availability_options_response :: [
    availability_options: availability_options_status,
  ]

  @type describe_domains_request :: [
    domain_names: domain_name_list,
  ]

  @type describe_domains_response :: [
    domain_status_list: domain_status_list,
  ]

  @type describe_expressions_request :: [
    deployed: boolean,
    domain_name: domain_name,
    expression_names: standard_name_list,
  ]

  @type describe_expressions_response :: [
    expressions: expression_status_list,
  ]

  @type describe_index_fields_request :: [
    deployed: boolean,
    domain_name: domain_name,
    field_names: dynamic_field_name_list,
  ]

  @type describe_index_fields_response :: [
    index_fields: index_field_status_list,
  ]

  @type describe_scaling_parameters_request :: [
    domain_name: domain_name,
  ]

  @type describe_scaling_parameters_response :: [
    scaling_parameters: scaling_parameters_status,
  ]

  @type describe_service_access_policies_request :: [
    deployed: boolean,
    domain_name: domain_name,
  ]

  @type describe_service_access_policies_response :: [
    access_policies: access_policies_status,
  ]

  @type describe_suggesters_request :: [
    deployed: boolean,
    domain_name: domain_name,
    suggester_names: standard_name_list,
  ]

  @type describe_suggesters_response :: [
    suggesters: suggester_status_list,
  ]

  @type disabled_operation_exception :: [
  ]

  @type document_suggester_options :: [
    fuzzy_matching: suggester_fuzzy_matching,
    sort_expression: binary,
    source_field: field_name,
  ]

  @type domain_id :: binary

  @type domain_name :: binary

  @type domain_name_list :: [domain_name]

  @type domain_name_map :: [{domain_name, api_version}]

  @type domain_status :: [
    arn: arn,
    created: boolean,
    deleted: boolean,
    doc_service: service_endpoint,
    domain_id: domain_id,
    domain_name: domain_name,
    limits: limits,
    processing: boolean,
    requires_index_documents: boolean,
    search_instance_count: instance_count,
    search_instance_type: search_instance_type,
    search_partition_count: partition_count,
    search_service: service_endpoint,
  ]

  @type domain_status_list :: [domain_status]

  @type double :: float

  @type double_array_options :: [
    default_value: double,
    facet_enabled: boolean,
    return_enabled: boolean,
    search_enabled: boolean,
    source_fields: field_name_comma_list,
  ]

  @type double_options :: [
    default_value: double,
    facet_enabled: boolean,
    return_enabled: boolean,
    search_enabled: boolean,
    sort_enabled: boolean,
    source_field: field_name,
  ]

  @type dynamic_field_name :: binary

  @type dynamic_field_name_list :: [dynamic_field_name]

  @type error_code :: binary

  @type error_message :: binary

  @type expression :: [
    expression_name: standard_name,
    expression_value: expression_value,
  ]

  @type expression_status :: [
    options: expression,
    status: option_status,
  ]

  @type expression_status_list :: [expression_status]

  @type expression_value :: binary

  @type field_name :: binary

  @type field_name_comma_list :: binary

  @type field_name_list :: [field_name]

  @type field_value :: binary

  @type index_documents_request :: [
    domain_name: domain_name,
  ]

  @type index_documents_response :: [
    field_names: field_name_list,
  ]

  @type index_field :: [
    date_array_options: date_array_options,
    date_options: date_options,
    double_array_options: double_array_options,
    double_options: double_options,
    index_field_name: dynamic_field_name,
    index_field_type: index_field_type,
    int_array_options: int_array_options,
    int_options: int_options,
    lat_lon_options: lat_lon_options,
    literal_array_options: literal_array_options,
    literal_options: literal_options,
    text_array_options: text_array_options,
    text_options: text_options,
  ]

  @type index_field_status :: [
    options: index_field,
    status: option_status,
  ]

  @type index_field_status_list :: [index_field_status]

  @type index_field_type :: binary

  @type instance_count :: integer

  @type int_array_options :: [
    default_value: long,
    facet_enabled: boolean,
    return_enabled: boolean,
    search_enabled: boolean,
    source_fields: field_name_comma_list,
  ]

  @type int_options :: [
    default_value: long,
    facet_enabled: boolean,
    return_enabled: boolean,
    search_enabled: boolean,
    sort_enabled: boolean,
    source_field: field_name,
  ]

  @type internal_exception :: [
  ]

  @type invalid_type_exception :: [
  ]

  @type lat_lon_options :: [
    default_value: field_value,
    facet_enabled: boolean,
    return_enabled: boolean,
    search_enabled: boolean,
    sort_enabled: boolean,
    source_field: field_name,
  ]

  @type limit_exceeded_exception :: [
  ]

  @type limits :: [
    maximum_partition_count: maximum_partition_count,
    maximum_replication_count: maximum_replication_count,
  ]

  @type list_domain_names_response :: [
    domain_names: domain_name_map,
  ]

  @type literal_array_options :: [
    default_value: field_value,
    facet_enabled: boolean,
    return_enabled: boolean,
    search_enabled: boolean,
    source_fields: field_name_comma_list,
  ]

  @type literal_options :: [
    default_value: field_value,
    facet_enabled: boolean,
    return_enabled: boolean,
    search_enabled: boolean,
    sort_enabled: boolean,
    source_field: field_name,
  ]

  @type long :: integer

  @type maximum_partition_count :: integer

  @type maximum_replication_count :: integer

  @type multi_az :: boolean

  @type option_state :: binary

  @type option_status :: [
    creation_date: update_timestamp,
    pending_deletion: boolean,
    state: option_state,
    update_date: update_timestamp,
    update_version: u_int_value,
  ]

  @type partition_count :: integer

  @type partition_instance_type :: binary

  @type policy_document :: binary

  @type resource_not_found_exception :: [
  ]

  @type scaling_parameters :: [
    desired_instance_type: partition_instance_type,
    desired_partition_count: u_int_value,
    desired_replication_count: u_int_value,
  ]

  @type scaling_parameters_status :: [
    options: scaling_parameters,
    status: option_status,
  ]

  @type search_instance_type :: binary

  @type service_endpoint :: [
    endpoint: service_url,
  ]

  @type service_url :: binary

  @type standard_name :: binary

  @type standard_name_list :: [standard_name]

  @type suggester :: [
    document_suggester_options: document_suggester_options,
    suggester_name: standard_name,
  ]

  @type suggester_fuzzy_matching :: binary

  @type suggester_status :: [
    options: suggester,
    status: option_status,
  ]

  @type suggester_status_list :: [suggester_status]

  @type text_array_options :: [
    analysis_scheme: word,
    default_value: field_value,
    highlight_enabled: boolean,
    return_enabled: boolean,
    source_fields: field_name_comma_list,
  ]

  @type text_options :: [
    analysis_scheme: word,
    default_value: field_value,
    highlight_enabled: boolean,
    return_enabled: boolean,
    sort_enabled: boolean,
    source_field: field_name,
  ]

  @type u_int_value :: integer

  @type update_availability_options_request :: [
    domain_name: domain_name,
    multi_az: boolean,
  ]

  @type update_availability_options_response :: [
    availability_options: availability_options_status,
  ]

  @type update_scaling_parameters_request :: [
    domain_name: domain_name,
    scaling_parameters: scaling_parameters,
  ]

  @type update_scaling_parameters_response :: [
    scaling_parameters: scaling_parameters_status,
  ]

  @type update_service_access_policies_request :: [
    access_policies: policy_document,
    domain_name: domain_name,
  ]

  @type update_service_access_policies_response :: [
    access_policies: access_policies_status,
  ]

  @type update_timestamp :: integer

  @type word :: binary




  @doc """
  BuildSuggesters

  Indexes the search suggestions. For more information, see [Configuring
  Suggesters](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/getting-suggestions.html#configuring-suggesters)
  in the *Amazon CloudSearch Developer Guide*.
  """

  @spec build_suggesters(client :: ExAws.Cloudsearch.t, input :: build_suggesters_request) :: ExAws.Request.Query.response_t
  def build_suggesters(client, input) do
    request(client, "/", "BuildSuggesters", input)
  end

  @doc """
  Same as `build_suggesters/2` but raise on error.
  """
  @spec build_suggesters!(client :: ExAws.Cloudsearch.t, input :: build_suggesters_request) :: ExAws.Request.Query.success_t | no_return
  def build_suggesters!(client, input) do
    case build_suggesters(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateDomain

  Creates a new search domain. For more information, see [Creating a Search
  Domain](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/creating-domains.html"
  target="_blank) in the *Amazon CloudSearch Developer Guide*.
  """

  @spec create_domain(client :: ExAws.Cloudsearch.t, input :: create_domain_request) :: ExAws.Request.Query.response_t
  def create_domain(client, input) do
    request(client, "/", "CreateDomain", input)
  end

  @doc """
  Same as `create_domain/2` but raise on error.
  """
  @spec create_domain!(client :: ExAws.Cloudsearch.t, input :: create_domain_request) :: ExAws.Request.Query.success_t | no_return
  def create_domain!(client, input) do
    case create_domain(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DefineAnalysisScheme

  Configures an analysis scheme that can be applied to a `text` or
  `text-array` field to define language-specific text processing options. For
  more information, see [Configuring Analysis
  Schemes](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/configuring-analysis-schemes.html"
  target="_blank) in the *Amazon CloudSearch Developer Guide*.
  """

  @spec define_analysis_scheme(client :: ExAws.Cloudsearch.t, input :: define_analysis_scheme_request) :: ExAws.Request.Query.response_t
  def define_analysis_scheme(client, input) do
    request(client, "/", "DefineAnalysisScheme", input)
  end

  @doc """
  Same as `define_analysis_scheme/2` but raise on error.
  """
  @spec define_analysis_scheme!(client :: ExAws.Cloudsearch.t, input :: define_analysis_scheme_request) :: ExAws.Request.Query.success_t | no_return
  def define_analysis_scheme!(client, input) do
    case define_analysis_scheme(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DefineExpression

  Configures an ``Expression`` for the search domain. Used to create new
  expressions and modify existing ones. If the expression exists, the new
  configuration replaces the old one. For more information, see [Configuring
  Expressions](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/configuring-expressions.html"
  target="_blank) in the *Amazon CloudSearch Developer Guide*.
  """

  @spec define_expression(client :: ExAws.Cloudsearch.t, input :: define_expression_request) :: ExAws.Request.Query.response_t
  def define_expression(client, input) do
    request(client, "/", "DefineExpression", input)
  end

  @doc """
  Same as `define_expression/2` but raise on error.
  """
  @spec define_expression!(client :: ExAws.Cloudsearch.t, input :: define_expression_request) :: ExAws.Request.Query.success_t | no_return
  def define_expression!(client, input) do
    case define_expression(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DefineIndexField

  Configures an ``IndexField`` for the search domain. Used to create new
  fields and modify existing ones. You must specify the name of the domain
  you are configuring and an index field configuration. The index field
  configuration specifies a unique name, the index field type, and the
  options you want to configure for the field. The options you can specify
  depend on the ``IndexFieldType``. If the field exists, the new
  configuration replaces the old one. For more information, see [Configuring
  Index
  Fields](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/configuring-index-fields.html"
  target="_blank) in the *Amazon CloudSearch Developer Guide*.
  """

  @spec define_index_field(client :: ExAws.Cloudsearch.t, input :: define_index_field_request) :: ExAws.Request.Query.response_t
  def define_index_field(client, input) do
    request(client, "/", "DefineIndexField", input)
  end

  @doc """
  Same as `define_index_field/2` but raise on error.
  """
  @spec define_index_field!(client :: ExAws.Cloudsearch.t, input :: define_index_field_request) :: ExAws.Request.Query.success_t | no_return
  def define_index_field!(client, input) do
    case define_index_field(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DefineSuggester

  Configures a suggester for a domain. A suggester enables you to display
  possible matches before users finish typing their queries. When you
  configure a suggester, you must specify the name of the text field you want
  to search for possible matches and a unique name for the suggester. For
  more information, see [Getting Search
  Suggestions](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/getting-suggestions.html"
  target="_blank) in the *Amazon CloudSearch Developer Guide*.
  """

  @spec define_suggester(client :: ExAws.Cloudsearch.t, input :: define_suggester_request) :: ExAws.Request.Query.response_t
  def define_suggester(client, input) do
    request(client, "/", "DefineSuggester", input)
  end

  @doc """
  Same as `define_suggester/2` but raise on error.
  """
  @spec define_suggester!(client :: ExAws.Cloudsearch.t, input :: define_suggester_request) :: ExAws.Request.Query.success_t | no_return
  def define_suggester!(client, input) do
    case define_suggester(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteAnalysisScheme

  Deletes an analysis scheme. For more information, see [Configuring Analysis
  Schemes](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/configuring-analysis-schemes.html"
  target="_blank) in the *Amazon CloudSearch Developer Guide*.
  """

  @spec delete_analysis_scheme(client :: ExAws.Cloudsearch.t, input :: delete_analysis_scheme_request) :: ExAws.Request.Query.response_t
  def delete_analysis_scheme(client, input) do
    request(client, "/", "DeleteAnalysisScheme", input)
  end

  @doc """
  Same as `delete_analysis_scheme/2` but raise on error.
  """
  @spec delete_analysis_scheme!(client :: ExAws.Cloudsearch.t, input :: delete_analysis_scheme_request) :: ExAws.Request.Query.success_t | no_return
  def delete_analysis_scheme!(client, input) do
    case delete_analysis_scheme(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteDomain

  Permanently deletes a search domain and all of its data. Once a domain has
  been deleted, it cannot be recovered. For more information, see [Deleting a
  Search
  Domain](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/deleting-domains.html"
  target="_blank) in the *Amazon CloudSearch Developer Guide*.
  """

  @spec delete_domain(client :: ExAws.Cloudsearch.t, input :: delete_domain_request) :: ExAws.Request.Query.response_t
  def delete_domain(client, input) do
    request(client, "/", "DeleteDomain", input)
  end

  @doc """
  Same as `delete_domain/2` but raise on error.
  """
  @spec delete_domain!(client :: ExAws.Cloudsearch.t, input :: delete_domain_request) :: ExAws.Request.Query.success_t | no_return
  def delete_domain!(client, input) do
    case delete_domain(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteExpression

  Removes an ``Expression`` from the search domain. For more information, see
  [Configuring
  Expressions](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/configuring-expressions.html"
  target="_blank) in the *Amazon CloudSearch Developer Guide*.
  """

  @spec delete_expression(client :: ExAws.Cloudsearch.t, input :: delete_expression_request) :: ExAws.Request.Query.response_t
  def delete_expression(client, input) do
    request(client, "/", "DeleteExpression", input)
  end

  @doc """
  Same as `delete_expression/2` but raise on error.
  """
  @spec delete_expression!(client :: ExAws.Cloudsearch.t, input :: delete_expression_request) :: ExAws.Request.Query.success_t | no_return
  def delete_expression!(client, input) do
    case delete_expression(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteIndexField

  Removes an ``IndexField`` from the search domain. For more information, see
  [Configuring Index
  Fields](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/configuring-index-fields.html"
  target="_blank) in the *Amazon CloudSearch Developer Guide*.
  """

  @spec delete_index_field(client :: ExAws.Cloudsearch.t, input :: delete_index_field_request) :: ExAws.Request.Query.response_t
  def delete_index_field(client, input) do
    request(client, "/", "DeleteIndexField", input)
  end

  @doc """
  Same as `delete_index_field/2` but raise on error.
  """
  @spec delete_index_field!(client :: ExAws.Cloudsearch.t, input :: delete_index_field_request) :: ExAws.Request.Query.success_t | no_return
  def delete_index_field!(client, input) do
    case delete_index_field(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteSuggester

  Deletes a suggester. For more information, see [Getting Search
  Suggestions](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/getting-suggestions.html"
  target="_blank) in the *Amazon CloudSearch Developer Guide*.
  """

  @spec delete_suggester(client :: ExAws.Cloudsearch.t, input :: delete_suggester_request) :: ExAws.Request.Query.response_t
  def delete_suggester(client, input) do
    request(client, "/", "DeleteSuggester", input)
  end

  @doc """
  Same as `delete_suggester/2` but raise on error.
  """
  @spec delete_suggester!(client :: ExAws.Cloudsearch.t, input :: delete_suggester_request) :: ExAws.Request.Query.success_t | no_return
  def delete_suggester!(client, input) do
    case delete_suggester(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeAnalysisSchemes

  Gets the analysis schemes configured for a domain. An analysis scheme
  defines language-specific text processing options for a `text` field. Can
  be limited to specific analysis schemes by name. By default, shows all
  analysis schemes and includes any pending changes to the configuration. Set
  the `Deployed` option to `true` to show the active configuration and
  exclude pending changes. For more information, see [Configuring Analysis
  Schemes](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/configuring-analysis-schemes.html"
  target="_blank) in the *Amazon CloudSearch Developer Guide*.
  """

  @spec describe_analysis_schemes(client :: ExAws.Cloudsearch.t, input :: describe_analysis_schemes_request) :: ExAws.Request.Query.response_t
  def describe_analysis_schemes(client, input) do
    request(client, "/", "DescribeAnalysisSchemes", input)
  end

  @doc """
  Same as `describe_analysis_schemes/2` but raise on error.
  """
  @spec describe_analysis_schemes!(client :: ExAws.Cloudsearch.t, input :: describe_analysis_schemes_request) :: ExAws.Request.Query.success_t | no_return
  def describe_analysis_schemes!(client, input) do
    case describe_analysis_schemes(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeAvailabilityOptions

  Gets the availability options configured for a domain. By default, shows
  the configuration with any pending changes. Set the `Deployed` option to
  `true` to show the active configuration and exclude pending changes. For
  more information, see [Configuring Availability
  Options](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/configuring-availability-options.html"
  target="_blank) in the *Amazon CloudSearch Developer Guide*.
  """

  @spec describe_availability_options(client :: ExAws.Cloudsearch.t, input :: describe_availability_options_request) :: ExAws.Request.Query.response_t
  def describe_availability_options(client, input) do
    request(client, "/", "DescribeAvailabilityOptions", input)
  end

  @doc """
  Same as `describe_availability_options/2` but raise on error.
  """
  @spec describe_availability_options!(client :: ExAws.Cloudsearch.t, input :: describe_availability_options_request) :: ExAws.Request.Query.success_t | no_return
  def describe_availability_options!(client, input) do
    case describe_availability_options(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeDomains

  Gets information about the search domains owned by this account. Can be
  limited to specific domains. Shows all domains by default. To get the
  number of searchable documents in a domain, use the console or submit a
  `matchall` request to your domain's search endpoint:
  `q=matchall&amp;amp;q.parser=structured&amp;amp;size=0`. For more
  information, see [Getting Information about a Search
  Domain](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/getting-domain-info.html"
  target="_blank) in the *Amazon CloudSearch Developer Guide*.
  """

  @spec describe_domains(client :: ExAws.Cloudsearch.t, input :: describe_domains_request) :: ExAws.Request.Query.response_t
  def describe_domains(client, input) do
    request(client, "/", "DescribeDomains", input)
  end

  @doc """
  Same as `describe_domains/2` but raise on error.
  """
  @spec describe_domains!(client :: ExAws.Cloudsearch.t, input :: describe_domains_request) :: ExAws.Request.Query.success_t | no_return
  def describe_domains!(client, input) do
    case describe_domains(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeExpressions

  Gets the expressions configured for the search domain. Can be limited to
  specific expressions by name. By default, shows all expressions and
  includes any pending changes to the configuration. Set the `Deployed`
  option to `true` to show the active configuration and exclude pending
  changes. For more information, see [Configuring
  Expressions](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/configuring-expressions.html"
  target="_blank) in the *Amazon CloudSearch Developer Guide*.
  """

  @spec describe_expressions(client :: ExAws.Cloudsearch.t, input :: describe_expressions_request) :: ExAws.Request.Query.response_t
  def describe_expressions(client, input) do
    request(client, "/", "DescribeExpressions", input)
  end

  @doc """
  Same as `describe_expressions/2` but raise on error.
  """
  @spec describe_expressions!(client :: ExAws.Cloudsearch.t, input :: describe_expressions_request) :: ExAws.Request.Query.success_t | no_return
  def describe_expressions!(client, input) do
    case describe_expressions(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeIndexFields

  Gets information about the index fields configured for the search domain.
  Can be limited to specific fields by name. By default, shows all fields and
  includes any pending changes to the configuration. Set the `Deployed`
  option to `true` to show the active configuration and exclude pending
  changes. For more information, see [Getting Domain
  Information](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/getting-domain-info.html"
  target="_blank) in the *Amazon CloudSearch Developer Guide*.
  """

  @spec describe_index_fields(client :: ExAws.Cloudsearch.t, input :: describe_index_fields_request) :: ExAws.Request.Query.response_t
  def describe_index_fields(client, input) do
    request(client, "/", "DescribeIndexFields", input)
  end

  @doc """
  Same as `describe_index_fields/2` but raise on error.
  """
  @spec describe_index_fields!(client :: ExAws.Cloudsearch.t, input :: describe_index_fields_request) :: ExAws.Request.Query.success_t | no_return
  def describe_index_fields!(client, input) do
    case describe_index_fields(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeScalingParameters

  Gets the scaling parameters configured for a domain. A domain's scaling
  parameters specify the desired search instance type and replication count.
  For more information, see [Configuring Scaling
  Options](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/configuring-scaling-options.html"
  target="_blank) in the *Amazon CloudSearch Developer Guide*.
  """

  @spec describe_scaling_parameters(client :: ExAws.Cloudsearch.t, input :: describe_scaling_parameters_request) :: ExAws.Request.Query.response_t
  def describe_scaling_parameters(client, input) do
    request(client, "/", "DescribeScalingParameters", input)
  end

  @doc """
  Same as `describe_scaling_parameters/2` but raise on error.
  """
  @spec describe_scaling_parameters!(client :: ExAws.Cloudsearch.t, input :: describe_scaling_parameters_request) :: ExAws.Request.Query.success_t | no_return
  def describe_scaling_parameters!(client, input) do
    case describe_scaling_parameters(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeServiceAccessPolicies

  Gets information about the access policies that control access to the
  domain's document and search endpoints. By default, shows the configuration
  with any pending changes. Set the `Deployed` option to `true` to show the
  active configuration and exclude pending changes. For more information, see
  [Configuring Access for a Search
  Domain](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/configuring-access.html"
  target="_blank) in the *Amazon CloudSearch Developer Guide*.
  """

  @spec describe_service_access_policies(client :: ExAws.Cloudsearch.t, input :: describe_service_access_policies_request) :: ExAws.Request.Query.response_t
  def describe_service_access_policies(client, input) do
    request(client, "/", "DescribeServiceAccessPolicies", input)
  end

  @doc """
  Same as `describe_service_access_policies/2` but raise on error.
  """
  @spec describe_service_access_policies!(client :: ExAws.Cloudsearch.t, input :: describe_service_access_policies_request) :: ExAws.Request.Query.success_t | no_return
  def describe_service_access_policies!(client, input) do
    case describe_service_access_policies(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeSuggesters

  Gets the suggesters configured for a domain. A suggester enables you to
  display possible matches before users finish typing their queries. Can be
  limited to specific suggesters by name. By default, shows all suggesters
  and includes any pending changes to the configuration. Set the `Deployed`
  option to `true` to show the active configuration and exclude pending
  changes. For more information, see [Getting Search
  Suggestions](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/getting-suggestions.html"
  target="_blank) in the *Amazon CloudSearch Developer Guide*.
  """

  @spec describe_suggesters(client :: ExAws.Cloudsearch.t, input :: describe_suggesters_request) :: ExAws.Request.Query.response_t
  def describe_suggesters(client, input) do
    request(client, "/", "DescribeSuggesters", input)
  end

  @doc """
  Same as `describe_suggesters/2` but raise on error.
  """
  @spec describe_suggesters!(client :: ExAws.Cloudsearch.t, input :: describe_suggesters_request) :: ExAws.Request.Query.success_t | no_return
  def describe_suggesters!(client, input) do
    case describe_suggesters(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  IndexDocuments

  Tells the search domain to start indexing its documents using the latest
  indexing options. This operation must be invoked to activate options whose
  `OptionStatus` is `RequiresIndexDocuments`.
  """

  @spec index_documents(client :: ExAws.Cloudsearch.t, input :: index_documents_request) :: ExAws.Request.Query.response_t
  def index_documents(client, input) do
    request(client, "/", "IndexDocuments", input)
  end

  @doc """
  Same as `index_documents/2` but raise on error.
  """
  @spec index_documents!(client :: ExAws.Cloudsearch.t, input :: index_documents_request) :: ExAws.Request.Query.success_t | no_return
  def index_documents!(client, input) do
    case index_documents(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListDomainNames

  Lists all search domains owned by an account.
  """

  @spec list_domain_names(client :: ExAws.Cloudsearch.t) :: ExAws.Request.Query.response_t
  def list_domain_names(client) do
    request(client, "/", "ListDomainNames", [])
  end

  @doc """
  Same as `list_domain_names/2` but raise on error.
  """
  @spec list_domain_names!(client :: ExAws.Cloudsearch.t) :: ExAws.Request.Query.success_t | no_return
  def list_domain_names!(client) do
    case list_domain_names(client) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateAvailabilityOptions

  Configures the availability options for a domain. Enabling the Multi-AZ
  option expands an Amazon CloudSearch domain to an additional Availability
  Zone in the same Region to increase fault tolerance in the event of a
  service disruption. Changes to the Multi-AZ option can take about half an
  hour to become active. For more information, see [Configuring Availability
  Options](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/configuring-availability-options.html"
  target="_blank) in the *Amazon CloudSearch Developer Guide*.
  """

  @spec update_availability_options(client :: ExAws.Cloudsearch.t, input :: update_availability_options_request) :: ExAws.Request.Query.response_t
  def update_availability_options(client, input) do
    request(client, "/", "UpdateAvailabilityOptions", input)
  end

  @doc """
  Same as `update_availability_options/2` but raise on error.
  """
  @spec update_availability_options!(client :: ExAws.Cloudsearch.t, input :: update_availability_options_request) :: ExAws.Request.Query.success_t | no_return
  def update_availability_options!(client, input) do
    case update_availability_options(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateScalingParameters

  Configures scaling parameters for a domain. A domain's scaling parameters
  specify the desired search instance type and replication count. Amazon
  CloudSearch will still automatically scale your domain based on the volume
  of data and traffic, but not below the desired instance type and
  replication count. If the Multi-AZ option is enabled, these values control
  the resources used per Availability Zone. For more information, see
  [Configuring Scaling
  Options](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/configuring-scaling-options.html"
  target="_blank) in the *Amazon CloudSearch Developer Guide*.
  """

  @spec update_scaling_parameters(client :: ExAws.Cloudsearch.t, input :: update_scaling_parameters_request) :: ExAws.Request.Query.response_t
  def update_scaling_parameters(client, input) do
    request(client, "/", "UpdateScalingParameters", input)
  end

  @doc """
  Same as `update_scaling_parameters/2` but raise on error.
  """
  @spec update_scaling_parameters!(client :: ExAws.Cloudsearch.t, input :: update_scaling_parameters_request) :: ExAws.Request.Query.success_t | no_return
  def update_scaling_parameters!(client, input) do
    case update_scaling_parameters(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateServiceAccessPolicies

  Configures the access rules that control access to the domain's document
  and search endpoints. For more information, see [ Configuring Access for an
  Amazon CloudSearch
  Domain](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/configuring-access.html"
  target="_blank).
  """

  @spec update_service_access_policies(client :: ExAws.Cloudsearch.t, input :: update_service_access_policies_request) :: ExAws.Request.Query.response_t
  def update_service_access_policies(client, input) do
    request(client, "/", "UpdateServiceAccessPolicies", input)
  end

  @doc """
  Same as `update_service_access_policies/2` but raise on error.
  """
  @spec update_service_access_policies!(client :: ExAws.Cloudsearch.t, input :: update_service_access_policies_request) :: ExAws.Request.Query.success_t | no_return
  def update_service_access_policies!(client, input) do
    case update_service_access_policies(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  defp request(%{__struct__: client_module} = client, uri, action, input) do
    apply(client_module, :request, [client, uri, action, input])
  end
end
