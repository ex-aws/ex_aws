defmodule ExAws.Email.Core do
  @actions [
    "DeleteIdentity",
    "DeleteIdentityPolicy",
    "DeleteVerifiedEmailAddress",
    "GetIdentityDkimAttributes",
    "GetIdentityNotificationAttributes",
    "GetIdentityPolicies",
    "GetIdentityVerificationAttributes",
    "GetSendQuota",
    "GetSendStatistics",
    "ListIdentities",
    "ListIdentityPolicies",
    "ListVerifiedEmailAddresses",
    "PutIdentityPolicy",
    "SendEmail",
    "SendRawEmail",
    "SetIdentityDkimEnabled",
    "SetIdentityFeedbackForwardingEnabled",
    "SetIdentityNotificationTopic",
    "VerifyDomainDkim",
    "VerifyDomainIdentity",
    "VerifyEmailAddress",
    "VerifyEmailIdentity"]

  @moduledoc """
  ## Amazon Simple Email Service

  Amazon Simple Email Service

  This is the API Reference for Amazon Simple Email Service (Amazon SES).
  This documentation is intended to be used in conjunction with the [Amazon
  SES Developer
  Guide](http://docs.aws.amazon.com/ses/latest/DeveloperGuide/Welcome.html).

  Note:For a list of Amazon SES endpoints to use in service requests, see
  [Regions and Amazon
  SES](http://docs.aws.amazon.com/ses/latest/DeveloperGuide/regions.html) in
  the Amazon SES Developer Guide.
  """

  @type address :: binary

  @type address_list :: [address]

  @type amazon_resource_name :: binary

  @type body :: [
    html: content,
    text: content,
  ]

  @type charset :: binary

  @type content :: [
    charset: charset,
    data: message_data,
  ]

  @type counter :: integer

  @type delete_identity_policy_request :: [
    identity: identity,
    policy_name: policy_name,
  ]

  @type delete_identity_policy_response :: [
  ]

  @type delete_identity_request :: [
    identity: identity,
  ]

  @type delete_identity_response :: [
  ]

  @type delete_verified_email_address_request :: [
    email_address: address,
  ]

  @type destination :: [
    bcc_addresses: address_list,
    cc_addresses: address_list,
    to_addresses: address_list,
  ]

  @type dkim_attributes :: [{identity, identity_dkim_attributes}]

  @type domain :: binary

  @type enabled :: boolean

  @type get_identity_dkim_attributes_request :: [
    identities: identity_list,
  ]

  @type get_identity_dkim_attributes_response :: [
    dkim_attributes: dkim_attributes,
  ]

  @type get_identity_notification_attributes_request :: [
    identities: identity_list,
  ]

  @type get_identity_notification_attributes_response :: [
    notification_attributes: notification_attributes,
  ]

  @type get_identity_policies_request :: [
    identity: identity,
    policy_names: policy_name_list,
  ]

  @type get_identity_policies_response :: [
    policies: policy_map,
  ]

  @type get_identity_verification_attributes_request :: [
    identities: identity_list,
  ]

  @type get_identity_verification_attributes_response :: [
    verification_attributes: verification_attributes,
  ]

  @type get_send_quota_response :: [
    max24_hour_send: max24_hour_send,
    max_send_rate: max_send_rate,
    sent_last24_hours: sent_last24_hours,
  ]

  @type get_send_statistics_response :: [
    send_data_points: send_data_point_list,
  ]

  @type identity :: binary

  @type identity_dkim_attributes :: [
    dkim_enabled: enabled,
    dkim_tokens: verification_token_list,
    dkim_verification_status: verification_status,
  ]

  @type identity_list :: [identity]

  @type identity_notification_attributes :: [
    bounce_topic: notification_topic,
    complaint_topic: notification_topic,
    delivery_topic: notification_topic,
    forwarding_enabled: enabled,
  ]

  @type identity_type :: binary

  @type identity_verification_attributes :: [
    verification_status: verification_status,
    verification_token: verification_token,
  ]

  @type invalid_policy_exception :: [
  ]

  @type list_identities_request :: [
    identity_type: identity_type,
    max_items: max_items,
    next_token: next_token,
  ]

  @type list_identities_response :: [
    identities: identity_list,
    next_token: next_token,
  ]

  @type list_identity_policies_request :: [
    identity: identity,
  ]

  @type list_identity_policies_response :: [
    policy_names: policy_name_list,
  ]

  @type list_verified_email_addresses_response :: [
    verified_email_addresses: address_list,
  ]

  @type max24_hour_send :: float

  @type max_items :: integer

  @type max_send_rate :: float

  @type message :: [
    body: body,
    subject: content,
  ]

  @type message_data :: binary

  @type message_id :: binary

  @type message_rejected :: [
  ]

  @type next_token :: binary

  @type notification_attributes :: [{identity, identity_notification_attributes}]

  @type notification_topic :: binary

  @type notification_type :: binary

  @type policy :: binary

  @type policy_map :: [{policy_name, policy}]

  @type policy_name :: binary

  @type policy_name_list :: [policy_name]

  @type put_identity_policy_request :: [
    identity: identity,
    policy: policy,
    policy_name: policy_name,
  ]

  @type put_identity_policy_response :: [
  ]

  @type raw_message :: [
    data: raw_message_data,
  ]

  @type raw_message_data :: binary

  @type send_data_point :: [
    bounces: counter,
    complaints: counter,
    delivery_attempts: counter,
    rejects: counter,
    timestamp: timestamp,
  ]

  @type send_data_point_list :: [send_data_point]

  @type send_email_request :: [
    destination: destination,
    message: message,
    reply_to_addresses: address_list,
    return_path: address,
    return_path_arn: amazon_resource_name,
    source: address,
    source_arn: amazon_resource_name,
  ]

  @type send_email_response :: [
    message_id: message_id,
  ]

  @type send_raw_email_request :: [
    destinations: address_list,
    from_arn: amazon_resource_name,
    raw_message: raw_message,
    return_path_arn: amazon_resource_name,
    source: address,
    source_arn: amazon_resource_name,
  ]

  @type send_raw_email_response :: [
    message_id: message_id,
  ]

  @type sent_last24_hours :: float

  @type set_identity_dkim_enabled_request :: [
    dkim_enabled: enabled,
    identity: identity,
  ]

  @type set_identity_dkim_enabled_response :: [
  ]

  @type set_identity_feedback_forwarding_enabled_request :: [
    forwarding_enabled: enabled,
    identity: identity,
  ]

  @type set_identity_feedback_forwarding_enabled_response :: [
  ]

  @type set_identity_notification_topic_request :: [
    identity: identity,
    notification_type: notification_type,
    sns_topic: notification_topic,
  ]

  @type set_identity_notification_topic_response :: [
  ]

  @type timestamp :: integer

  @type verification_attributes :: [{identity, identity_verification_attributes}]

  @type verification_status :: binary

  @type verification_token :: binary

  @type verification_token_list :: [verification_token]

  @type verify_domain_dkim_request :: [
    domain: domain,
  ]

  @type verify_domain_dkim_response :: [
    dkim_tokens: verification_token_list,
  ]

  @type verify_domain_identity_request :: [
    domain: domain,
  ]

  @type verify_domain_identity_response :: [
    verification_token: verification_token,
  ]

  @type verify_email_address_request :: [
    email_address: address,
  ]

  @type verify_email_identity_request :: [
    email_address: address,
  ]

  @type verify_email_identity_response :: [
  ]




  @doc """
  DeleteIdentity

  Deletes the specified identity (email address or domain) from the list of
  verified identities.

  This action is throttled at one request per second.
  """

  @spec delete_identity(client :: ExAws.Email.t, input :: delete_identity_request) :: ExAws.Request.Query.response_t
  def delete_identity(client, input) do
    request(client, "/", "DeleteIdentity", input)
  end

  @doc """
  Same as `delete_identity/2` but raise on error.
  """
  @spec delete_identity!(client :: ExAws.Email.t, input :: delete_identity_request) :: ExAws.Request.Query.success_t | no_return
  def delete_identity!(client, input) do
    case delete_identity(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteIdentityPolicy

  Deletes the specified sending authorization policy for the given identity
  (email address or domain). This API returns successfully even if a policy
  with the specified name does not exist.

  Note:This API is for the identity owner only. If you have not verified the
  identity, this API will return an error. Sending authorization is a feature
  that enables an identity owner to authorize other senders to use its
  identities. For information about using sending authorization, see the
  [Amazon SES Developer
  Guide](http://docs.aws.amazon.com/ses/latest/DeveloperGuide/sending-authorization.html).

  This action is throttled at one request per second.
  """

  @spec delete_identity_policy(client :: ExAws.Email.t, input :: delete_identity_policy_request) :: ExAws.Request.Query.response_t
  def delete_identity_policy(client, input) do
    request(client, "/", "DeleteIdentityPolicy", input)
  end

  @doc """
  Same as `delete_identity_policy/2` but raise on error.
  """
  @spec delete_identity_policy!(client :: ExAws.Email.t, input :: delete_identity_policy_request) :: ExAws.Request.Query.success_t | no_return
  def delete_identity_policy!(client, input) do
    case delete_identity_policy(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteVerifiedEmailAddress

  Deletes the specified email address from the list of verified addresses.

  **The DeleteVerifiedEmailAddress action is deprecated as of the May 15,
  2012 release of Domain Verification. The DeleteIdentity action is now
  preferred.** This action is throttled at one request per second.
  """

  @spec delete_verified_email_address(client :: ExAws.Email.t, input :: delete_verified_email_address_request) :: ExAws.Request.Query.response_t
  def delete_verified_email_address(client, input) do
    request(client, "/", "DeleteVerifiedEmailAddress", input)
  end

  @doc """
  Same as `delete_verified_email_address/2` but raise on error.
  """
  @spec delete_verified_email_address!(client :: ExAws.Email.t, input :: delete_verified_email_address_request) :: ExAws.Request.Query.success_t | no_return
  def delete_verified_email_address!(client, input) do
    case delete_verified_email_address(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetIdentityDkimAttributes

  Returns the current status of Easy DKIM signing for an entity. For domain
  name identities, this action also returns the DKIM tokens that are required
  for Easy DKIM signing, and whether Amazon SES has successfully verified
  that these tokens have been published.

  This action takes a list of identities as input and returns the following
  information for each:

  - Whether Easy DKIM signing is enabled or disabled.

  - A set of DKIM tokens that represent the identity. If the identity is an
  email address, the tokens represent the domain of that address.

  - Whether Amazon SES has successfully verified the DKIM tokens published in
  the domain's DNS. This information is only returned for domain name
  identities, not for email addresses.

  This action is throttled at one request per second and can only get DKIM
  attributes for up to 100 identities at a time.

  For more information about creating DNS records using DKIM tokens, go to
  the [Amazon SES Developer
  Guide](http://docs.aws.amazon.com/ses/latest/DeveloperGuide/easy-dkim-dns-records.html).
  """

  @spec get_identity_dkim_attributes(client :: ExAws.Email.t, input :: get_identity_dkim_attributes_request) :: ExAws.Request.Query.response_t
  def get_identity_dkim_attributes(client, input) do
    request(client, "/", "GetIdentityDkimAttributes", input)
  end

  @doc """
  Same as `get_identity_dkim_attributes/2` but raise on error.
  """
  @spec get_identity_dkim_attributes!(client :: ExAws.Email.t, input :: get_identity_dkim_attributes_request) :: ExAws.Request.Query.success_t | no_return
  def get_identity_dkim_attributes!(client, input) do
    case get_identity_dkim_attributes(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetIdentityNotificationAttributes

  Given a list of verified identities (email addresses and/or domains),
  returns a structure describing identity notification attributes.

  This action is throttled at one request per second and can only get
  notification attributes for up to 100 identities at a time.

  For more information about using notifications with Amazon SES, see the
  [Amazon SES Developer
  Guide](http://docs.aws.amazon.com/ses/latest/DeveloperGuide/notifications.html).
  """

  @spec get_identity_notification_attributes(client :: ExAws.Email.t, input :: get_identity_notification_attributes_request) :: ExAws.Request.Query.response_t
  def get_identity_notification_attributes(client, input) do
    request(client, "/", "GetIdentityNotificationAttributes", input)
  end

  @doc """
  Same as `get_identity_notification_attributes/2` but raise on error.
  """
  @spec get_identity_notification_attributes!(client :: ExAws.Email.t, input :: get_identity_notification_attributes_request) :: ExAws.Request.Query.success_t | no_return
  def get_identity_notification_attributes!(client, input) do
    case get_identity_notification_attributes(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetIdentityPolicies

  Returns the requested sending authorization policies for the given identity
  (email address or domain). The policies are returned as a map of policy
  names to policy contents. You can retrieve a maximum of 20 policies at a
  time.

  Note:This API is for the identity owner only. If you have not verified the
  identity, this API will return an error. Sending authorization is a feature
  that enables an identity owner to authorize other senders to use its
  identities. For information about using sending authorization, see the
  [Amazon SES Developer
  Guide](http://docs.aws.amazon.com/ses/latest/DeveloperGuide/sending-authorization.html).

  This action is throttled at one request per second.
  """

  @spec get_identity_policies(client :: ExAws.Email.t, input :: get_identity_policies_request) :: ExAws.Request.Query.response_t
  def get_identity_policies(client, input) do
    request(client, "/", "GetIdentityPolicies", input)
  end

  @doc """
  Same as `get_identity_policies/2` but raise on error.
  """
  @spec get_identity_policies!(client :: ExAws.Email.t, input :: get_identity_policies_request) :: ExAws.Request.Query.success_t | no_return
  def get_identity_policies!(client, input) do
    case get_identity_policies(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetIdentityVerificationAttributes

  Given a list of identities (email addresses and/or domains), returns the
  verification status and (for domain identities) the verification token for
  each identity.

  This action is throttled at one request per second and can only get
  verification attributes for up to 100 identities at a time.
  """

  @spec get_identity_verification_attributes(client :: ExAws.Email.t, input :: get_identity_verification_attributes_request) :: ExAws.Request.Query.response_t
  def get_identity_verification_attributes(client, input) do
    request(client, "/", "GetIdentityVerificationAttributes", input)
  end

  @doc """
  Same as `get_identity_verification_attributes/2` but raise on error.
  """
  @spec get_identity_verification_attributes!(client :: ExAws.Email.t, input :: get_identity_verification_attributes_request) :: ExAws.Request.Query.success_t | no_return
  def get_identity_verification_attributes!(client, input) do
    case get_identity_verification_attributes(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetSendQuota

  Returns the user's current sending limits.

  This action is throttled at one request per second.
  """

  @spec get_send_quota(client :: ExAws.Email.t) :: ExAws.Request.Query.response_t
  def get_send_quota(client) do
    request(client, "/", "GetSendQuota", [])
  end

  @doc """
  Same as `get_send_quota/2` but raise on error.
  """
  @spec get_send_quota!(client :: ExAws.Email.t) :: ExAws.Request.Query.success_t | no_return
  def get_send_quota!(client) do
    case get_send_quota(client) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetSendStatistics

  Returns the user's sending statistics. The result is a list of data points,
  representing the last two weeks of sending activity.

  Each data point in the list contains statistics for a 15-minute interval.

  This action is throttled at one request per second.
  """

  @spec get_send_statistics(client :: ExAws.Email.t) :: ExAws.Request.Query.response_t
  def get_send_statistics(client) do
    request(client, "/", "GetSendStatistics", [])
  end

  @doc """
  Same as `get_send_statistics/2` but raise on error.
  """
  @spec get_send_statistics!(client :: ExAws.Email.t) :: ExAws.Request.Query.success_t | no_return
  def get_send_statistics!(client) do
    case get_send_statistics(client) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListIdentities

  Returns a list containing all of the identities (email addresses and
  domains) for a specific AWS Account, regardless of verification status.

  This action is throttled at one request per second.
  """

  @spec list_identities(client :: ExAws.Email.t, input :: list_identities_request) :: ExAws.Request.Query.response_t
  def list_identities(client, input) do
    request(client, "/", "ListIdentities", input)
  end

  @doc """
  Same as `list_identities/2` but raise on error.
  """
  @spec list_identities!(client :: ExAws.Email.t, input :: list_identities_request) :: ExAws.Request.Query.success_t | no_return
  def list_identities!(client, input) do
    case list_identities(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListIdentityPolicies

  Returns a list of sending authorization policies that are attached to the
  given identity (email address or domain). This API returns only a list. If
  you want the actual policy content, you can use `GetIdentityPolicies`.

  Note:This API is for the identity owner only. If you have not verified the
  identity, this API will return an error. Sending authorization is a feature
  that enables an identity owner to authorize other senders to use its
  identities. For information about using sending authorization, see the
  [Amazon SES Developer
  Guide](http://docs.aws.amazon.com/ses/latest/DeveloperGuide/sending-authorization.html).

  This action is throttled at one request per second.
  """

  @spec list_identity_policies(client :: ExAws.Email.t, input :: list_identity_policies_request) :: ExAws.Request.Query.response_t
  def list_identity_policies(client, input) do
    request(client, "/", "ListIdentityPolicies", input)
  end

  @doc """
  Same as `list_identity_policies/2` but raise on error.
  """
  @spec list_identity_policies!(client :: ExAws.Email.t, input :: list_identity_policies_request) :: ExAws.Request.Query.success_t | no_return
  def list_identity_policies!(client, input) do
    case list_identity_policies(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListVerifiedEmailAddresses

  Returns a list containing all of the email addresses that have been
  verified.

  **The ListVerifiedEmailAddresses action is deprecated as of the May 15,
  2012 release of Domain Verification. The ListIdentities action is now
  preferred.** This action is throttled at one request per second.
  """

  @spec list_verified_email_addresses(client :: ExAws.Email.t) :: ExAws.Request.Query.response_t
  def list_verified_email_addresses(client) do
    request(client, "/", "ListVerifiedEmailAddresses", [])
  end

  @doc """
  Same as `list_verified_email_addresses/2` but raise on error.
  """
  @spec list_verified_email_addresses!(client :: ExAws.Email.t) :: ExAws.Request.Query.success_t | no_return
  def list_verified_email_addresses!(client) do
    case list_verified_email_addresses(client) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  PutIdentityPolicy

  Adds or updates a sending authorization policy for the specified identity
  (email address or domain).

  Note:This API is for the identity owner only. If you have not verified the
  identity, this API will return an error. Sending authorization is a feature
  that enables an identity owner to authorize other senders to use its
  identities. For information about using sending authorization, see the
  [Amazon SES Developer
  Guide](http://docs.aws.amazon.com/ses/latest/DeveloperGuide/sending-authorization.html).

  This action is throttled at one request per second.
  """

  @spec put_identity_policy(client :: ExAws.Email.t, input :: put_identity_policy_request) :: ExAws.Request.Query.response_t
  def put_identity_policy(client, input) do
    request(client, "/", "PutIdentityPolicy", input)
  end

  @doc """
  Same as `put_identity_policy/2` but raise on error.
  """
  @spec put_identity_policy!(client :: ExAws.Email.t, input :: put_identity_policy_request) :: ExAws.Request.Query.success_t | no_return
  def put_identity_policy!(client, input) do
    case put_identity_policy(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  SendEmail

  Composes an email message based on input data, and then immediately queues
  the message for sending.

  There are several important points to know about `SendEmail`:

  - You can only send email from verified email addresses and domains;
  otherwise, you will get an "Email address not verified" error. If your
  account is still in the Amazon SES sandbox, you must also verify every
  recipient email address except for the recipients provided by the Amazon
  SES mailbox simulator. For more information, go to the [Amazon SES
  Developer
  Guide](http://docs.aws.amazon.com/ses/latest/DeveloperGuide/verify-addresses-and-domains.html).

  - The total size of the message cannot exceed 10 MB. This includes any
  attachments that are part of the message.

  - Amazon SES has a limit on the total number of recipients per message. The
  combined number of To:, CC: and BCC: email addresses cannot exceed 50. If
  you need to send an email message to a larger audience, you can divide your
  recipient list into groups of 50 or fewer, and then call Amazon SES
  repeatedly to send the message to each group.

  - For every message that you send, the total number of recipients (To:, CC:
  and BCC:) is counted against your sending quota - the maximum number of
  emails you can send in a 24-hour period. For information about your sending
  quota, go to the [Amazon SES Developer
  Guide](http://docs.aws.amazon.com/ses/latest/DeveloperGuide/manage-sending-limits.html).
  """

  @spec send_email(client :: ExAws.Email.t, input :: send_email_request) :: ExAws.Request.Query.response_t
  def send_email(client, input) do
    request(client, "/", "SendEmail", input)
  end

  @doc """
  Same as `send_email/2` but raise on error.
  """
  @spec send_email!(client :: ExAws.Email.t, input :: send_email_request) :: ExAws.Request.Query.success_t | no_return
  def send_email!(client, input) do
    case send_email(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  SendRawEmail

  Sends an email message, with header and content specified by the client.
  The `SendRawEmail` action is useful for sending multipart MIME emails. The
  raw text of the message must comply with Internet email standards;
  otherwise, the message cannot be sent.

  There are several important points to know about `SendRawEmail`:

  - You can only send email from verified email addresses and domains;
  otherwise, you will get an "Email address not verified" error. If your
  account is still in the Amazon SES sandbox, you must also verify every
  recipient email address except for the recipients provided by the Amazon
  SES mailbox simulator. For more information, go to the [Amazon SES
  Developer
  Guide](http://docs.aws.amazon.com/ses/latest/DeveloperGuide/verify-addresses-and-domains.html).

  - The total size of the message cannot exceed 10 MB. This includes any
  attachments that are part of the message.

  - Amazon SES has a limit on the total number of recipients per message. The
  combined number of To:, CC: and BCC: email addresses cannot exceed 50. If
  you need to send an email message to a larger audience, you can divide your
  recipient list into groups of 50 or fewer, and then call Amazon SES
  repeatedly to send the message to each group.

  - The To:, CC:, and BCC: headers in the raw message can contain a group
  list. Note that each recipient in a group list counts towards the
  50-recipient limit.

  - For every message that you send, the total number of recipients (To:, CC:
  and BCC:) is counted against your sending quota - the maximum number of
  emails you can send in a 24-hour period. For information about your sending
  quota, go to the [Amazon SES Developer
  Guide](http://docs.aws.amazon.com/ses/latest/DeveloperGuide/manage-sending-limits.html).

  - If you are using sending authorization to send on behalf of another user,
  `SendRawEmail` enables you to specify the cross-account identity for the
  email's "Source," "From," and "Return-Path" parameters in one of two ways:
  you can pass optional parameters `SourceArn`, `FromArn`, and/or
  `ReturnPathArn` to the API, or you can include the following X-headers in
  the header of your raw email:

  - `X-SES-SOURCE-ARN`

  - `X-SES-FROM-ARN`

  - `X-SES-RETURN-PATH-ARN`

  **Do not include these X-headers in the DKIM signature, because they are
  removed by Amazon SES before sending the email.** For the most common
  sending authorization use case, we recommend that you specify the
  `SourceIdentityArn` and do not specify either the `FromIdentityArn` or
  `ReturnPathIdentityArn`. (The same note applies to the corresponding
  X-headers.) If you only specify the `SourceIdentityArn`, Amazon SES will
  simply set the "From" address and the "Return Path" address to the identity
  specified in `SourceIdentityArn`. For more information about sending
  authorization, see the [Amazon SES Developer
  Guide](http://docs.aws.amazon.com/ses/latest/DeveloperGuide/sending-authorization.html).
  """

  @spec send_raw_email(client :: ExAws.Email.t, input :: send_raw_email_request) :: ExAws.Request.Query.response_t
  def send_raw_email(client, input) do
    request(client, "/", "SendRawEmail", input)
  end

  @doc """
  Same as `send_raw_email/2` but raise on error.
  """
  @spec send_raw_email!(client :: ExAws.Email.t, input :: send_raw_email_request) :: ExAws.Request.Query.success_t | no_return
  def send_raw_email!(client, input) do
    case send_raw_email(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  SetIdentityDkimEnabled

  Enables or disables Easy DKIM signing of email sent from an identity:

  - If Easy DKIM signing is enabled for a domain name identity (e.g.,
  `example.com`), then Amazon SES will DKIM-sign all email sent by addresses
  under that domain name (e.g., `user@example.com`).

  - If Easy DKIM signing is enabled for an email address, then Amazon SES
  will DKIM-sign all email sent by that email address.

  For email addresses (e.g., `user@example.com`), you can only enable Easy
  DKIM signing if the corresponding domain (e.g., `example.com`) has been set
  up for Easy DKIM using the AWS Console or the `VerifyDomainDkim` action.

  This action is throttled at one request per second.

  For more information about Easy DKIM signing, go to the [Amazon SES
  Developer
  Guide](http://docs.aws.amazon.com/ses/latest/DeveloperGuide/easy-dkim.html).
  """

  @spec set_identity_dkim_enabled(client :: ExAws.Email.t, input :: set_identity_dkim_enabled_request) :: ExAws.Request.Query.response_t
  def set_identity_dkim_enabled(client, input) do
    request(client, "/", "SetIdentityDkimEnabled", input)
  end

  @doc """
  Same as `set_identity_dkim_enabled/2` but raise on error.
  """
  @spec set_identity_dkim_enabled!(client :: ExAws.Email.t, input :: set_identity_dkim_enabled_request) :: ExAws.Request.Query.success_t | no_return
  def set_identity_dkim_enabled!(client, input) do
    case set_identity_dkim_enabled(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  SetIdentityFeedbackForwardingEnabled

  Given an identity (email address or domain), enables or disables whether
  Amazon SES forwards bounce and complaint notifications as email. Feedback
  forwarding can only be disabled when Amazon Simple Notification Service
  (Amazon SNS) topics are specified for both bounces and complaints.

  Note:Feedback forwarding does not apply to delivery notifications. Delivery
  notifications are only available through Amazon SNS. This action is
  throttled at one request per second.

  For more information about using notifications with Amazon SES, see the
  [Amazon SES Developer
  Guide](http://docs.aws.amazon.com/ses/latest/DeveloperGuide/notifications.html).
  """

  @spec set_identity_feedback_forwarding_enabled(client :: ExAws.Email.t, input :: set_identity_feedback_forwarding_enabled_request) :: ExAws.Request.Query.response_t
  def set_identity_feedback_forwarding_enabled(client, input) do
    request(client, "/", "SetIdentityFeedbackForwardingEnabled", input)
  end

  @doc """
  Same as `set_identity_feedback_forwarding_enabled/2` but raise on error.
  """
  @spec set_identity_feedback_forwarding_enabled!(client :: ExAws.Email.t, input :: set_identity_feedback_forwarding_enabled_request) :: ExAws.Request.Query.success_t | no_return
  def set_identity_feedback_forwarding_enabled!(client, input) do
    case set_identity_feedback_forwarding_enabled(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  SetIdentityNotificationTopic

  Given an identity (email address or domain), sets the Amazon Simple
  Notification Service (Amazon SNS) topic to which Amazon SES will publish
  bounce, complaint, and/or delivery notifications for emails sent with that
  identity as the `Source`.

  Note:Unless feedback forwarding is enabled, you must specify Amazon SNS
  topics for bounce and complaint notifications. For more information, see
  `SetIdentityFeedbackForwardingEnabled`. This action is throttled at one
  request per second.

  For more information about feedback notification, see the [Amazon SES
  Developer
  Guide](http://docs.aws.amazon.com/ses/latest/DeveloperGuide/notifications.html).
  """

  @spec set_identity_notification_topic(client :: ExAws.Email.t, input :: set_identity_notification_topic_request) :: ExAws.Request.Query.response_t
  def set_identity_notification_topic(client, input) do
    request(client, "/", "SetIdentityNotificationTopic", input)
  end

  @doc """
  Same as `set_identity_notification_topic/2` but raise on error.
  """
  @spec set_identity_notification_topic!(client :: ExAws.Email.t, input :: set_identity_notification_topic_request) :: ExAws.Request.Query.success_t | no_return
  def set_identity_notification_topic!(client, input) do
    case set_identity_notification_topic(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  VerifyDomainDkim

  Returns a set of DKIM tokens for a domain. DKIM *tokens* are character
  strings that represent your domain's identity. Using these tokens, you will
  need to create DNS CNAME records that point to DKIM public keys hosted by
  Amazon SES. Amazon Web Services will eventually detect that you have
  updated your DNS records; this detection process may take up to 72 hours.
  Upon successful detection, Amazon SES will be able to DKIM-sign email
  originating from that domain.

  This action is throttled at one request per second.

  To enable or disable Easy DKIM signing for a domain, use the
  `SetIdentityDkimEnabled` action.

  For more information about creating DNS records using DKIM tokens, go to
  the [Amazon SES Developer
  Guide](http://docs.aws.amazon.com/ses/latest/DeveloperGuide/easy-dkim-dns-records.html).
  """

  @spec verify_domain_dkim(client :: ExAws.Email.t, input :: verify_domain_dkim_request) :: ExAws.Request.Query.response_t
  def verify_domain_dkim(client, input) do
    request(client, "/", "VerifyDomainDkim", input)
  end

  @doc """
  Same as `verify_domain_dkim/2` but raise on error.
  """
  @spec verify_domain_dkim!(client :: ExAws.Email.t, input :: verify_domain_dkim_request) :: ExAws.Request.Query.success_t | no_return
  def verify_domain_dkim!(client, input) do
    case verify_domain_dkim(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  VerifyDomainIdentity

  Verifies a domain.

  This action is throttled at one request per second.
  """

  @spec verify_domain_identity(client :: ExAws.Email.t, input :: verify_domain_identity_request) :: ExAws.Request.Query.response_t
  def verify_domain_identity(client, input) do
    request(client, "/", "VerifyDomainIdentity", input)
  end

  @doc """
  Same as `verify_domain_identity/2` but raise on error.
  """
  @spec verify_domain_identity!(client :: ExAws.Email.t, input :: verify_domain_identity_request) :: ExAws.Request.Query.success_t | no_return
  def verify_domain_identity!(client, input) do
    case verify_domain_identity(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  VerifyEmailAddress

  Verifies an email address. This action causes a confirmation email message
  to be sent to the specified address.

  **The VerifyEmailAddress action is deprecated as of the May 15, 2012
  release of Domain Verification. The VerifyEmailIdentity action is now
  preferred.** This action is throttled at one request per second.
  """

  @spec verify_email_address(client :: ExAws.Email.t, input :: verify_email_address_request) :: ExAws.Request.Query.response_t
  def verify_email_address(client, input) do
    request(client, "/", "VerifyEmailAddress", input)
  end

  @doc """
  Same as `verify_email_address/2` but raise on error.
  """
  @spec verify_email_address!(client :: ExAws.Email.t, input :: verify_email_address_request) :: ExAws.Request.Query.success_t | no_return
  def verify_email_address!(client, input) do
    case verify_email_address(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  VerifyEmailIdentity

  Verifies an email address. This action causes a confirmation email message
  to be sent to the specified address.

  This action is throttled at one request per second.
  """

  @spec verify_email_identity(client :: ExAws.Email.t, input :: verify_email_identity_request) :: ExAws.Request.Query.response_t
  def verify_email_identity(client, input) do
    request(client, "/", "VerifyEmailIdentity", input)
  end

  @doc """
  Same as `verify_email_identity/2` but raise on error.
  """
  @spec verify_email_identity!(client :: ExAws.Email.t, input :: verify_email_identity_request) :: ExAws.Request.Query.success_t | no_return
  def verify_email_identity!(client, input) do
    case verify_email_identity(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  defp request(%{__struct__: client_module} = client, uri, action, input) do
    apply(client_module, :request, [client, uri, action, input])
  end
end
