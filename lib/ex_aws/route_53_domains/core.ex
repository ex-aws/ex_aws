defmodule ExAws.Route53Domains.Core do
  import ExAws.Core.JSON, only: [format_input: 1]
  @actions [
    "CheckDomainAvailability",
    "DeleteTagsForDomain",
    "DisableDomainAutoRenew",
    "DisableDomainTransferLock",
    "EnableDomainAutoRenew",
    "EnableDomainTransferLock",
    "GetDomainDetail",
    "GetOperationDetail",
    "ListDomains",
    "ListOperations",
    "ListTagsForDomain",
    "RegisterDomain",
    "RetrieveDomainAuthCode",
    "TransferDomain",
    "UpdateDomainContact",
    "UpdateDomainContactPrivacy",
    "UpdateDomainNameservers",
    "UpdateTagsForDomain"]

  @moduledoc """
  ## Amazon Route 53 Domains


  """

  @type address_line :: binary

  @type check_domain_availability_request :: [
    domain_name: domain_name,
    idn_lang_code: lang_code,
  ]

  @type check_domain_availability_response :: [
    availability: domain_availability,
  ]

  @type city :: binary

  @type contact_detail :: [
    address_line1: address_line,
    address_line2: address_line,
    city: city,
    contact_type: contact_type,
    country_code: country_code,
    email: email,
    extra_params: extra_param_list,
    fax: contact_number,
    first_name: contact_name,
    last_name: contact_name,
    organization_name: contact_name,
    phone_number: contact_number,
    state: state,
    zip_code: zip_code,
  ]

  @type contact_name :: binary

  @type contact_number :: binary

  @type contact_type :: binary

  @type country_code :: binary

  @type dns_sec :: binary

  @type delete_tags_for_domain_request :: [
    domain_name: domain_name,
    tags_to_delete: tag_key_list,
  ]

  @type delete_tags_for_domain_response :: [
  ]

  @type disable_domain_auto_renew_request :: [
    domain_name: domain_name,
  ]

  @type disable_domain_auto_renew_response :: [
  ]

  @type disable_domain_transfer_lock_request :: [
    domain_name: domain_name,
  ]

  @type disable_domain_transfer_lock_response :: [
    operation_id: operation_id,
  ]

  @type domain_auth_code :: binary

  @type domain_availability :: binary

  @type domain_limit_exceeded :: [
    message: error_message,
  ]

  @type domain_name :: binary

  @type domain_status :: binary

  @type domain_status_list :: [domain_status]

  @type domain_summary :: [
    auto_renew: boolean,
    domain_name: domain_name,
    expiry: timestamp,
    transfer_lock: boolean,
  ]

  @type domain_summary_list :: [domain_summary]

  @type duplicate_request :: [
    message: error_message,
  ]

  @type duration_in_years :: integer

  @type email :: binary

  @type enable_domain_auto_renew_request :: [
    domain_name: domain_name,
  ]

  @type enable_domain_auto_renew_response :: [
  ]

  @type enable_domain_transfer_lock_request :: [
    domain_name: domain_name,
  ]

  @type enable_domain_transfer_lock_response :: [
    operation_id: operation_id,
  ]

  @type error_message :: binary

  @type extra_param :: [
    name: extra_param_name,
    value: extra_param_value,
  ]

  @type extra_param_list :: [extra_param]

  @type extra_param_name :: binary

  @type extra_param_value :: binary

  @type fi_auth_key :: binary

  @type get_domain_detail_request :: [
    domain_name: domain_name,
  ]

  @type get_domain_detail_response :: [
    abuse_contact_email: email,
    abuse_contact_phone: contact_number,
    admin_contact: contact_detail,
    admin_privacy: boolean,
    auto_renew: boolean,
    creation_date: timestamp,
    dns_sec: dns_sec,
    domain_name: domain_name,
    expiration_date: timestamp,
    nameservers: nameserver_list,
    registrant_contact: contact_detail,
    registrant_privacy: boolean,
    registrar_name: registrar_name,
    registrar_url: registrar_url,
    registry_domain_id: registry_domain_id,
    reseller: reseller,
    status_list: domain_status_list,
    tech_contact: contact_detail,
    tech_privacy: boolean,
    updated_date: timestamp,
    who_is_server: registrar_who_is_server,
  ]

  @type get_operation_detail_request :: [
    operation_id: operation_id,
  ]

  @type get_operation_detail_response :: [
    domain_name: domain_name,
    message: error_message,
    operation_id: operation_id,
    status: operation_status,
    submitted_date: timestamp,
    type: operation_type,
  ]

  @type glue_ip :: binary

  @type glue_ip_list :: [glue_ip]

  @type host_name :: binary

  @type invalid_input :: [
    message: error_message,
  ]

  @type lang_code :: binary

  @type list_domains_request :: [
    marker: page_marker,
    max_items: page_max_items,
  ]

  @type list_domains_response :: [
    domains: domain_summary_list,
    next_page_marker: page_marker,
  ]

  @type list_operations_request :: [
    marker: page_marker,
    max_items: page_max_items,
  ]

  @type list_operations_response :: [
    next_page_marker: page_marker,
    operations: operation_summary_list,
  ]

  @type list_tags_for_domain_request :: [
    domain_name: domain_name,
  ]

  @type list_tags_for_domain_response :: [
    tag_list: tag_list,
  ]

  @type nameserver :: [
    glue_ips: glue_ip_list,
    name: host_name,
  ]

  @type nameserver_list :: [nameserver]

  @type operation_id :: binary

  @type operation_limit_exceeded :: [
    message: error_message,
  ]

  @type operation_status :: binary

  @type operation_summary :: [
    operation_id: operation_id,
    status: operation_status,
    submitted_date: timestamp,
    type: operation_type,
  ]

  @type operation_summary_list :: [operation_summary]

  @type operation_type :: binary

  @type page_marker :: binary

  @type page_max_items :: integer

  @type register_domain_request :: [
    admin_contact: contact_detail,
    auto_renew: boolean,
    domain_name: domain_name,
    duration_in_years: duration_in_years,
    idn_lang_code: lang_code,
    privacy_protect_admin_contact: boolean,
    privacy_protect_registrant_contact: boolean,
    privacy_protect_tech_contact: boolean,
    registrant_contact: contact_detail,
    tech_contact: contact_detail,
  ]

  @type register_domain_response :: [
    operation_id: operation_id,
  ]

  @type registrar_name :: binary

  @type registrar_url :: binary

  @type registrar_who_is_server :: binary

  @type registry_domain_id :: binary

  @type reseller :: binary

  @type retrieve_domain_auth_code_request :: [
    domain_name: domain_name,
  ]

  @type retrieve_domain_auth_code_response :: [
    auth_code: domain_auth_code,
  ]

  @type state :: binary

  @type tld_rules_violation :: [
    message: error_message,
  ]

  @type tag :: [
    key: tag_key,
    value: tag_value,
  ]

  @type tag_key :: binary

  @type tag_key_list :: [tag_key]

  @type tag_list :: [tag]

  @type tag_value :: binary

  @type timestamp :: integer

  @type transfer_domain_request :: [
    admin_contact: contact_detail,
    auth_code: domain_auth_code,
    auto_renew: boolean,
    domain_name: domain_name,
    duration_in_years: duration_in_years,
    idn_lang_code: lang_code,
    nameservers: nameserver_list,
    privacy_protect_admin_contact: boolean,
    privacy_protect_registrant_contact: boolean,
    privacy_protect_tech_contact: boolean,
    registrant_contact: contact_detail,
    tech_contact: contact_detail,
  ]

  @type transfer_domain_response :: [
    operation_id: operation_id,
  ]

  @type unsupported_tld :: [
    message: error_message,
  ]

  @type update_domain_contact_privacy_request :: [
    admin_privacy: boolean,
    domain_name: domain_name,
    registrant_privacy: boolean,
    tech_privacy: boolean,
  ]

  @type update_domain_contact_privacy_response :: [
    operation_id: operation_id,
  ]

  @type update_domain_contact_request :: [
    admin_contact: contact_detail,
    domain_name: domain_name,
    registrant_contact: contact_detail,
    tech_contact: contact_detail,
  ]

  @type update_domain_contact_response :: [
    operation_id: operation_id,
  ]

  @type update_domain_nameservers_request :: [
    domain_name: domain_name,
    fi_auth_key: fi_auth_key,
    nameservers: nameserver_list,
  ]

  @type update_domain_nameservers_response :: [
    operation_id: operation_id,
  ]

  @type update_tags_for_domain_request :: [
    domain_name: domain_name,
    tags_to_update: tag_list,
  ]

  @type update_tags_for_domain_response :: [
  ]

  @type zip_code :: binary





  @doc """
  CheckDomainAvailability

  This operation checks the availability of one domain name. You can access
  this API without authenticating. Note that if the availability status of a
  domain is pending, you must submit another request to determine the
  availability of the domain name.
  """

  @spec check_domain_availability(client :: ExAws.Route53Domains.t, input :: check_domain_availability_request) :: ExAws.Request.JSON.response_t
  def check_domain_availability(client, input) do
    request(client, "CheckDomainAvailability", format_input(input))
  end

  @doc """
  Same as `check_domain_availability/2` but raise on error.
  """
  @spec check_domain_availability!(client :: ExAws.Route53Domains.t, input :: check_domain_availability_request) :: ExAws.Request.JSON.success_t | no_return
  def check_domain_availability!(client, input) do
    case check_domain_availability(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteTagsForDomain

  This operation deletes the specified tags for a domain.

  All tag operations are eventually consistent; subsequent operations may not
  immediately represent all issued operations.
  """

  @spec delete_tags_for_domain(client :: ExAws.Route53Domains.t, input :: delete_tags_for_domain_request) :: ExAws.Request.JSON.response_t
  def delete_tags_for_domain(client, input) do
    request(client, "DeleteTagsForDomain", format_input(input))
  end

  @doc """
  Same as `delete_tags_for_domain/2` but raise on error.
  """
  @spec delete_tags_for_domain!(client :: ExAws.Route53Domains.t, input :: delete_tags_for_domain_request) :: ExAws.Request.JSON.success_t | no_return
  def delete_tags_for_domain!(client, input) do
    case delete_tags_for_domain(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DisableDomainAutoRenew

  This operation disables automatic renewal of domain registration for the
  specified domain.

  Note:Caution! Amazon Route 53 doesn't have a manual renewal process, so if
  you disable automatic renewal, registration for the domain will not be
  renewed when the expiration date passes, and you will lose control of the
  domain name.
  """

  @spec disable_domain_auto_renew(client :: ExAws.Route53Domains.t, input :: disable_domain_auto_renew_request) :: ExAws.Request.JSON.response_t
  def disable_domain_auto_renew(client, input) do
    request(client, "DisableDomainAutoRenew", format_input(input))
  end

  @doc """
  Same as `disable_domain_auto_renew/2` but raise on error.
  """
  @spec disable_domain_auto_renew!(client :: ExAws.Route53Domains.t, input :: disable_domain_auto_renew_request) :: ExAws.Request.JSON.success_t | no_return
  def disable_domain_auto_renew!(client, input) do
    case disable_domain_auto_renew(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DisableDomainTransferLock

  This operation removes the transfer lock on the domain (specifically the
  `clientTransferProhibited` status) to allow domain transfers. We recommend
  you refrain from performing this action unless you intend to transfer the
  domain to a different registrar. Successful submission returns an operation
  ID that you can use to track the progress and completion of the action. If
  the request is not completed successfully, the domain registrant will be
  notified by email.
  """

  @spec disable_domain_transfer_lock(client :: ExAws.Route53Domains.t, input :: disable_domain_transfer_lock_request) :: ExAws.Request.JSON.response_t
  def disable_domain_transfer_lock(client, input) do
    request(client, "DisableDomainTransferLock", format_input(input))
  end

  @doc """
  Same as `disable_domain_transfer_lock/2` but raise on error.
  """
  @spec disable_domain_transfer_lock!(client :: ExAws.Route53Domains.t, input :: disable_domain_transfer_lock_request) :: ExAws.Request.JSON.success_t | no_return
  def disable_domain_transfer_lock!(client, input) do
    case disable_domain_transfer_lock(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  EnableDomainAutoRenew

  This operation configures Amazon Route 53 to automatically renew the
  specified domain before the domain registration expires. The cost of
  renewing your domain registration is billed to your AWS account.

  The period during which you can renew a domain name varies by TLD. For a
  list of TLDs and their renewal policies, see ["Renewal, restoration, and
  deletion
  times"](http://wiki.gandi.net/en/domains/renew#renewal_restoration_and_deletion_times)
  on the website for our registrar partner, Gandi. Route 53 requires that you
  renew before the end of the renewal period that is listed on the Gandi
  website so we can complete processing before the deadline.
  """

  @spec enable_domain_auto_renew(client :: ExAws.Route53Domains.t, input :: enable_domain_auto_renew_request) :: ExAws.Request.JSON.response_t
  def enable_domain_auto_renew(client, input) do
    request(client, "EnableDomainAutoRenew", format_input(input))
  end

  @doc """
  Same as `enable_domain_auto_renew/2` but raise on error.
  """
  @spec enable_domain_auto_renew!(client :: ExAws.Route53Domains.t, input :: enable_domain_auto_renew_request) :: ExAws.Request.JSON.success_t | no_return
  def enable_domain_auto_renew!(client, input) do
    case enable_domain_auto_renew(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  EnableDomainTransferLock

  This operation sets the transfer lock on the domain (specifically the
  `clientTransferProhibited` status) to prevent domain transfers. Successful
  submission returns an operation ID that you can use to track the progress
  and completion of the action. If the request is not completed successfully,
  the domain registrant will be notified by email.
  """

  @spec enable_domain_transfer_lock(client :: ExAws.Route53Domains.t, input :: enable_domain_transfer_lock_request) :: ExAws.Request.JSON.response_t
  def enable_domain_transfer_lock(client, input) do
    request(client, "EnableDomainTransferLock", format_input(input))
  end

  @doc """
  Same as `enable_domain_transfer_lock/2` but raise on error.
  """
  @spec enable_domain_transfer_lock!(client :: ExAws.Route53Domains.t, input :: enable_domain_transfer_lock_request) :: ExAws.Request.JSON.success_t | no_return
  def enable_domain_transfer_lock!(client, input) do
    case enable_domain_transfer_lock(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetDomainDetail

  This operation returns detailed information about the domain. The domain's
  contact information is also returned as part of the output.
  """

  @spec get_domain_detail(client :: ExAws.Route53Domains.t, input :: get_domain_detail_request) :: ExAws.Request.JSON.response_t
  def get_domain_detail(client, input) do
    request(client, "GetDomainDetail", format_input(input))
  end

  @doc """
  Same as `get_domain_detail/2` but raise on error.
  """
  @spec get_domain_detail!(client :: ExAws.Route53Domains.t, input :: get_domain_detail_request) :: ExAws.Request.JSON.success_t | no_return
  def get_domain_detail!(client, input) do
    case get_domain_detail(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetOperationDetail

  This operation returns the current status of an operation that is not
  completed.
  """

  @spec get_operation_detail(client :: ExAws.Route53Domains.t, input :: get_operation_detail_request) :: ExAws.Request.JSON.response_t
  def get_operation_detail(client, input) do
    request(client, "GetOperationDetail", format_input(input))
  end

  @doc """
  Same as `get_operation_detail/2` but raise on error.
  """
  @spec get_operation_detail!(client :: ExAws.Route53Domains.t, input :: get_operation_detail_request) :: ExAws.Request.JSON.success_t | no_return
  def get_operation_detail!(client, input) do
    case get_operation_detail(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListDomains

  This operation returns all the domain names registered with Amazon Route 53
  for the current AWS account.
  """

  @spec list_domains(client :: ExAws.Route53Domains.t, input :: list_domains_request) :: ExAws.Request.JSON.response_t
  def list_domains(client, input) do
    request(client, "ListDomains", format_input(input))
  end

  @doc """
  Same as `list_domains/2` but raise on error.
  """
  @spec list_domains!(client :: ExAws.Route53Domains.t, input :: list_domains_request) :: ExAws.Request.JSON.success_t | no_return
  def list_domains!(client, input) do
    case list_domains(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListOperations

  This operation returns the operation IDs of operations that are not yet
  complete.
  """

  @spec list_operations(client :: ExAws.Route53Domains.t, input :: list_operations_request) :: ExAws.Request.JSON.response_t
  def list_operations(client, input) do
    request(client, "ListOperations", format_input(input))
  end

  @doc """
  Same as `list_operations/2` but raise on error.
  """
  @spec list_operations!(client :: ExAws.Route53Domains.t, input :: list_operations_request) :: ExAws.Request.JSON.success_t | no_return
  def list_operations!(client, input) do
    case list_operations(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListTagsForDomain

  This operation returns all of the tags that are associated with the
  specified domain.

  All tag operations are eventually consistent; subsequent operations may not
  immediately represent all issued operations.
  """

  @spec list_tags_for_domain(client :: ExAws.Route53Domains.t, input :: list_tags_for_domain_request) :: ExAws.Request.JSON.response_t
  def list_tags_for_domain(client, input) do
    request(client, "ListTagsForDomain", format_input(input))
  end

  @doc """
  Same as `list_tags_for_domain/2` but raise on error.
  """
  @spec list_tags_for_domain!(client :: ExAws.Route53Domains.t, input :: list_tags_for_domain_request) :: ExAws.Request.JSON.success_t | no_return
  def list_tags_for_domain!(client, input) do
    case list_tags_for_domain(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RegisterDomain

  This operation registers a domain. Domains are registered by the AWS
  registrar partner, Gandi. For some top-level domains (TLDs), this operation
  requires extra parameters.

  When you register a domain, Amazon Route 53 does the following:

  - Creates a Amazon Route 53 hosted zone that has the same name as the
  domain. Amazon Route 53 assigns four name servers to your hosted zone and
  automatically updates your domain registration with the names of these name
  servers.

  - Enables autorenew, so your domain registration will renew automatically
  each year. We'll notify you in advance of the renewal date so you can
  choose whether to renew the registration.

  - Optionally enables privacy protection, so WHOIS queries return contact
  information for our registrar partner, Gandi, instead of the information
  you entered for registrant, admin, and tech contacts.

  - If registration is successful, returns an operation ID that you can use
  to track the progress and completion of the action. If the request is not
  completed successfully, the domain registrant is notified by email.

  - Charges your AWS account an amount based on the top-level domain. For
  more information, see [Amazon Route 53
  Pricing](http://aws.amazon.com/route53/pricing/).
  """

  @spec register_domain(client :: ExAws.Route53Domains.t, input :: register_domain_request) :: ExAws.Request.JSON.response_t
  def register_domain(client, input) do
    request(client, "RegisterDomain", format_input(input))
  end

  @doc """
  Same as `register_domain/2` but raise on error.
  """
  @spec register_domain!(client :: ExAws.Route53Domains.t, input :: register_domain_request) :: ExAws.Request.JSON.success_t | no_return
  def register_domain!(client, input) do
    case register_domain(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RetrieveDomainAuthCode

  This operation returns the AuthCode for the domain. To transfer a domain to
  another registrar, you provide this value to the new registrar.
  """

  @spec retrieve_domain_auth_code(client :: ExAws.Route53Domains.t, input :: retrieve_domain_auth_code_request) :: ExAws.Request.JSON.response_t
  def retrieve_domain_auth_code(client, input) do
    request(client, "RetrieveDomainAuthCode", format_input(input))
  end

  @doc """
  Same as `retrieve_domain_auth_code/2` but raise on error.
  """
  @spec retrieve_domain_auth_code!(client :: ExAws.Route53Domains.t, input :: retrieve_domain_auth_code_request) :: ExAws.Request.JSON.success_t | no_return
  def retrieve_domain_auth_code!(client, input) do
    case retrieve_domain_auth_code(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  TransferDomain

  This operation transfers a domain from another registrar to Amazon Route
  53. When the transfer is complete, the domain is registered with the AWS
  registrar partner, Gandi.

  For transfer requirements, a detailed procedure, and information about
  viewing the status of a domain transfer, see [Transferring Registration for
  a Domain to Amazon Route
  53](http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/domain-transfer-to-route-53.html)
  in the Amazon Route 53 Developer Guide.

  If the registrar for your domain is also the DNS service provider for the
  domain, we highly recommend that you consider transferring your DNS service
  to Amazon Route 53 or to another DNS service provider before you transfer
  your registration. Some registrars provide free DNS service when you
  purchase a domain registration. When you transfer the registration, the
  previous registrar will not renew your domain registration and could end
  your DNS service at any time.

  Note:Caution! If the registrar for your domain is also the DNS service
  provider for the domain and you don't transfer DNS service to another
  provider, your website, email, and the web applications associated with the
  domain might become unavailable. If the transfer is successful, this method
  returns an operation ID that you can use to track the progress and
  completion of the action. If the transfer doesn't complete successfully,
  the domain registrant will be notified by email.
  """

  @spec transfer_domain(client :: ExAws.Route53Domains.t, input :: transfer_domain_request) :: ExAws.Request.JSON.response_t
  def transfer_domain(client, input) do
    request(client, "TransferDomain", format_input(input))
  end

  @doc """
  Same as `transfer_domain/2` but raise on error.
  """
  @spec transfer_domain!(client :: ExAws.Route53Domains.t, input :: transfer_domain_request) :: ExAws.Request.JSON.success_t | no_return
  def transfer_domain!(client, input) do
    case transfer_domain(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateDomainContact

  This operation updates the contact information for a particular domain.
  Information for at least one contact (registrant, administrator, or
  technical) must be supplied for update.

  If the update is successful, this method returns an operation ID that you
  can use to track the progress and completion of the action. If the request
  is not completed successfully, the domain registrant will be notified by
  email.
  """

  @spec update_domain_contact(client :: ExAws.Route53Domains.t, input :: update_domain_contact_request) :: ExAws.Request.JSON.response_t
  def update_domain_contact(client, input) do
    request(client, "UpdateDomainContact", format_input(input))
  end

  @doc """
  Same as `update_domain_contact/2` but raise on error.
  """
  @spec update_domain_contact!(client :: ExAws.Route53Domains.t, input :: update_domain_contact_request) :: ExAws.Request.JSON.success_t | no_return
  def update_domain_contact!(client, input) do
    case update_domain_contact(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateDomainContactPrivacy

  This operation updates the specified domain contact's privacy setting. When
  the privacy option is enabled, personal information such as postal or email
  address is hidden from the results of a public WHOIS query. The privacy
  services are provided by the AWS registrar, Gandi. For more information,
  see the [Gandi privacy
  features](http://www.gandi.net/domain/whois/?currency=USD&amp;amp;lang=en).

  This operation only affects the privacy of the specified contact type
  (registrant, administrator, or tech). Successful acceptance returns an
  operation ID that you can use with GetOperationDetail to track the progress
  and completion of the action. If the request is not completed successfully,
  the domain registrant will be notified by email.
  """

  @spec update_domain_contact_privacy(client :: ExAws.Route53Domains.t, input :: update_domain_contact_privacy_request) :: ExAws.Request.JSON.response_t
  def update_domain_contact_privacy(client, input) do
    request(client, "UpdateDomainContactPrivacy", format_input(input))
  end

  @doc """
  Same as `update_domain_contact_privacy/2` but raise on error.
  """
  @spec update_domain_contact_privacy!(client :: ExAws.Route53Domains.t, input :: update_domain_contact_privacy_request) :: ExAws.Request.JSON.success_t | no_return
  def update_domain_contact_privacy!(client, input) do
    case update_domain_contact_privacy(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateDomainNameservers

  This operation replaces the current set of name servers for the domain with
  the specified set of name servers. If you use Amazon Route 53 as your DNS
  service, specify the four name servers in the delegation set for the hosted
  zone for the domain.

  If successful, this operation returns an operation ID that you can use to
  track the progress and completion of the action. If the request is not
  completed successfully, the domain registrant will be notified by email.
  """

  @spec update_domain_nameservers(client :: ExAws.Route53Domains.t, input :: update_domain_nameservers_request) :: ExAws.Request.JSON.response_t
  def update_domain_nameservers(client, input) do
    request(client, "UpdateDomainNameservers", format_input(input))
  end

  @doc """
  Same as `update_domain_nameservers/2` but raise on error.
  """
  @spec update_domain_nameservers!(client :: ExAws.Route53Domains.t, input :: update_domain_nameservers_request) :: ExAws.Request.JSON.success_t | no_return
  def update_domain_nameservers!(client, input) do
    case update_domain_nameservers(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateTagsForDomain

  This operation adds or updates tags for a specified domain.

  All tag operations are eventually consistent; subsequent operations may not
  immediately represent all issued operations.
  """

  @spec update_tags_for_domain(client :: ExAws.Route53Domains.t, input :: update_tags_for_domain_request) :: ExAws.Request.JSON.response_t
  def update_tags_for_domain(client, input) do
    request(client, "UpdateTagsForDomain", format_input(input))
  end

  @doc """
  Same as `update_tags_for_domain/2` but raise on error.
  """
  @spec update_tags_for_domain!(client :: ExAws.Route53Domains.t, input :: update_tags_for_domain_request) :: ExAws.Request.JSON.success_t | no_return
  def update_tags_for_domain!(client, input) do
    case update_tags_for_domain(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  defp request(%{__struct__: client_module} = client, action, input) do
    apply(client_module, :request, [client, action, input])
  end
end
