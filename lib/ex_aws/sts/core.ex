defmodule ExAws.Sts.Core do
  @actions [
    "AssumeRole",
    "AssumeRoleWithSAML",
    "AssumeRoleWithWebIdentity",
    "DecodeAuthorizationMessage",
    "GetFederationToken",
    "GetSessionToken"]

  @moduledoc """
  ## AWS Security Token Service

  AWS Security Token Service

  The AWS Security Token Service (STS) is a web service that enables you to
  request temporary, limited-privilege credentials for AWS Identity and
  Access Management (IAM) users or for users that you authenticate (federated
  users). This guide provides descriptions of the STS API. For more detailed
  information about using this service, go to [Using Temporary Security
  Credentials](http://docs.aws.amazon.com/STS/latest/UsingSTS/Welcome.html"
  target="_blank).

  Note: As an alternative to using the API, you can use one of the AWS SDKs,
  which consist of libraries and sample code for various programming
  languages and platforms (Java, Ruby, .NET, iOS, Android, etc.). The SDKs
  provide a convenient way to create programmatic access to STS. For example,
  the SDKs take care of cryptographically signing requests, managing errors,
  and retrying requests automatically. For information about the AWS SDKs,
  including how to download and install them, see the [Tools for Amazon Web
  Services page](http://aws.amazon.com/tools/). For information about setting
  up signatures and authorization through the API, go to [Signing AWS API
  Requests](http://docs.aws.amazon.com/general/latest/gr/signing_aws_api_requests.html"
  target="_blank) in the *AWS General Reference*. For general information
  about the Query API, go to [Making Query
  Requests](http://docs.aws.amazon.com/IAM/latest/UserGuide/IAM_UsingQueryAPI.html"
  target="_blank) in *Using IAM*. For information about using security tokens
  with other AWS products, go to [Using Temporary Security Credentials to
  Access
  AWS](http://docs.aws.amazon.com/STS/latest/UsingSTS/UsingTokens.html) in
  *Using Temporary Security Credentials*.

  If you're new to AWS and need additional technical information about a
  specific AWS product, you can find the product's technical documentation at
  [http://aws.amazon.com/documentation/](http://aws.amazon.com/documentation/"
  target="_blank).

  **Endpoints**

  The AWS Security Token Service (STS) has a default endpoint of
  https://sts.amazonaws.com that maps to the US East (N. Virginia) region.
  Additional regions are available, but must first be activated in the AWS
  Management Console before you can use a different region's endpoint. For
  more information about activating a region for STS see [Activating STS in a
  New
  Region](http://docs.aws.amazon.com/STS/latest/UsingSTS/sts-enableregions.html)
  in the *Using Temporary Security Credentials* guide.

  For information about STS endpoints, see [Regions and
  Endpoints](http://docs.aws.amazon.com/general/latest/gr/rande.html#sts_region)
  in the *AWS General Reference*.

  **Recording API requests**

  STS supports AWS CloudTrail, which is a service that records AWS calls for
  your AWS account and delivers log files to an Amazon S3 bucket. By using
  information collected by CloudTrail, you can determine what requests were
  successfully made to STS, who made the request, when it was made, and so
  on. To learn more about CloudTrail, including how to turn it on and find
  your log files, see the [AWS CloudTrail User
  Guide](http://docs.aws.amazon.com/awscloudtrail/latest/userguide/what_is_cloud_trail_top_level.html).
  """

  @type assume_role_request :: [
    duration_seconds: role_duration_seconds_type,
    external_id: external_id_type,
    policy: session_policy_document_type,
    role_arn: arn_type,
    role_session_name: user_name_type,
    serial_number: serial_number_type,
    token_code: token_code_type,
  ]

  @type assume_role_response :: [
    assumed_role_user: assumed_role_user,
    credentials: credentials,
    packed_policy_size: non_negative_integer_type,
  ]

  @type assume_role_with_saml_request :: [
    duration_seconds: role_duration_seconds_type,
    policy: session_policy_document_type,
    principal_arn: arn_type,
    role_arn: arn_type,
    saml_assertion: saml_assertion_type,
  ]

  @type assume_role_with_saml_response :: [
    assumed_role_user: assumed_role_user,
    audience: audience,
    credentials: credentials,
    issuer: issuer,
    name_qualifier: name_qualifier,
    packed_policy_size: non_negative_integer_type,
    subject: subject,
    subject_type: subject_type,
  ]

  @type assume_role_with_web_identity_request :: [
    duration_seconds: role_duration_seconds_type,
    policy: session_policy_document_type,
    provider_id: url_type,
    role_arn: arn_type,
    role_session_name: user_name_type,
    web_identity_token: client_token_type,
  ]

  @type assume_role_with_web_identity_response :: [
    assumed_role_user: assumed_role_user,
    audience: audience,
    credentials: credentials,
    packed_policy_size: non_negative_integer_type,
    provider: issuer,
    subject_from_web_identity_token: web_identity_subject_type,
  ]

  @type assumed_role_user :: [
    arn: arn_type,
    assumed_role_id: assumed_role_id_type,
  ]

  @type audience :: binary

  @type credentials :: [
    access_key_id: access_key_id_type,
    expiration: date_type,
    secret_access_key: access_key_secret_type,
    session_token: token_type,
  ]

  @type decode_authorization_message_request :: [
    encoded_message: encoded_message_type,
  ]

  @type decode_authorization_message_response :: [
    decoded_message: decoded_message_type,
  ]

  @type expired_token_exception :: [
    message: expired_identity_token_message,
  ]

  @type federated_user :: [
    arn: arn_type,
    federated_user_id: federated_id_type,
  ]

  @type get_federation_token_request :: [
    duration_seconds: duration_seconds_type,
    name: user_name_type,
    policy: session_policy_document_type,
  ]

  @type get_federation_token_response :: [
    credentials: credentials,
    federated_user: federated_user,
    packed_policy_size: non_negative_integer_type,
  ]

  @type get_session_token_request :: [
    duration_seconds: duration_seconds_type,
    serial_number: serial_number_type,
    token_code: token_code_type,
  ]

  @type get_session_token_response :: [
    credentials: credentials,
  ]

  @type idp_communication_error_exception :: [
    message: idp_communication_error_message,
  ]

  @type idp_rejected_claim_exception :: [
    message: idp_rejected_claim_message,
  ]

  @type invalid_authorization_message_exception :: [
    message: invalid_authorization_message,
  ]

  @type invalid_identity_token_exception :: [
    message: invalid_identity_token_message,
  ]

  @type issuer :: binary

  @type malformed_policy_document_exception :: [
    message: malformed_policy_document_message,
  ]

  @type name_qualifier :: binary

  @type packed_policy_too_large_exception :: [
    message: packed_policy_too_large_message,
  ]

  @type saml_assertion_type :: binary

  @type subject :: binary

  @type subject_type :: binary

  @type access_key_id_type :: binary

  @type access_key_secret_type :: binary

  @type arn_type :: binary

  @type assumed_role_id_type :: binary

  @type client_token_type :: binary

  @type date_type :: integer

  @type decoded_message_type :: binary

  @type duration_seconds_type :: integer

  @type encoded_message_type :: binary

  @type expired_identity_token_message :: binary

  @type external_id_type :: binary

  @type federated_id_type :: binary

  @type idp_communication_error_message :: binary

  @type idp_rejected_claim_message :: binary

  @type invalid_authorization_message :: binary

  @type invalid_identity_token_message :: binary

  @type malformed_policy_document_message :: binary

  @type non_negative_integer_type :: integer

  @type packed_policy_too_large_message :: binary

  @type role_duration_seconds_type :: integer

  @type serial_number_type :: binary

  @type session_policy_document_type :: binary

  @type token_code_type :: binary

  @type token_type :: binary

  @type url_type :: binary

  @type user_name_type :: binary

  @type web_identity_subject_type :: binary




  @doc """
  AssumeRole

  Returns a set of temporary security credentials (consisting of an access
  key ID, a secret access key, and a security token) that you can use to
  access AWS resources that you might not normally have access to. Typically,
  you use `AssumeRole` for cross-account access or federation.

  **Important:** You cannot call `AssumeRole` by using AWS account
  credentials; access will be denied. You must use IAM user credentials or
  temporary security credentials to call `AssumeRole`.

  For cross-account access, imagine that you own multiple accounts and need
  to access resources in each account. You could create long-term credentials
  in each account to access those resources. However, managing all those
  credentials and remembering which one can access which account can be time
  consuming. Instead, you can create one set of long-term credentials in one
  account and then use temporary security credentials to access all the other
  accounts by assuming roles in those accounts. For more information about
  roles, see [IAM Roles (Delegation and
  Federation)](http://docs.aws.amazon.com/IAM/latest/UserGuide/roles-toplevel.html)
  in *Using IAM*.

  For federation, you can, for example, grant single sign-on access to the
  AWS Management Console. If you already have an identity and authentication
  system in your corporate network, you don't have to recreate user
  identities in AWS in order to grant those user identities access to AWS.
  Instead, after a user has been authenticated, you call `AssumeRole` (and
  specify the role with the appropriate permissions) to get temporary
  security credentials for that user. With those temporary security
  credentials, you construct a sign-in URL that users can use to access the
  console. For more information, see [Scenarios for Granting Temporary
  Access](http://docs.aws.amazon.com/STS/latest/UsingSTS/STSUseCases.html) in
  *Using Temporary Security Credentials*.

  The temporary security credentials are valid for the duration that you
  specified when calling `AssumeRole`, which can be from 900 seconds (15
  minutes) to 3600 seconds (1 hour). The default is 1 hour.

  Optionally, you can pass an IAM access policy to this operation. If you
  choose not to pass a policy, the temporary security credentials that are
  returned by the operation have the permissions that are defined in the
  access policy of the role that is being assumed. If you pass a policy to
  this operation, the temporary security credentials that are returned by the
  operation have the permissions that are allowed by both the access policy
  of the role that is being assumed, ***and*** the policy that you pass. This
  gives you a way to further restrict the permissions for the resulting
  temporary security credentials. You cannot use the passed policy to grant
  permissions that are in excess of those allowed by the access policy of the
  role that is being assumed. For more information, see [Permissions for
  AssumeRole, AssumeRoleWithSAML, and
  AssumeRoleWithWebIdentity](http://docs.aws.amazon.com/STS/latest/UsingSTS/permissions-assume-role.html)
  in *Using Temporary Security Credentials*.

  To assume a role, your AWS account must be trusted by the role. The trust
  relationship is defined in the role's trust policy when the role is
  created. You must also have a policy that allows you to call
  `sts:AssumeRole`.

  **Using MFA with AssumeRole**

  You can optionally include multi-factor authentication (MFA) information
  when you call `AssumeRole`. This is useful for cross-account scenarios in
  which you want to make sure that the user who is assuming the role has been
  authenticated using an AWS MFA device. In that scenario, the trust policy
  of the role being assumed includes a condition that tests for MFA
  authentication; if the caller does not include valid MFA information, the
  request to assume the role is denied. The condition in a trust policy that
  tests for MFA authentication might look like the following example.

  `"Condition": {"Bool": {"aws:MultiFactorAuthPresent": true}}`

  For more information, see [Configuring MFA-Protected API
  Access](http://docs.aws.amazon.com/IAM/latest/UserGuide/MFAProtectedAPI.html)
  in *Using IAM* guide.

  To use MFA with `AssumeRole`, you pass values for the `SerialNumber` and
  `TokenCode` parameters. The `SerialNumber` value identifies the user's
  hardware or virtual MFA device. The `TokenCode` is the time-based one-time
  password (TOTP) that the MFA devices produces.

  <member name="RoleArn" target="arnType"></member> <member
  name="RoleSessionName" target="userNameType"></member> <member
  name="Policy" target="sessionPolicyDocumentType"></member> <member
  name="DurationSeconds" target="roleDurationSecondsType"></member> <member
  name="ExternalId" target="externalIdType"></member>
  """

  @spec assume_role(client :: ExAws.Sts.t, input :: assume_role_request) :: ExAws.Request.Query.response_t
  def assume_role(client, input) do
    request(client, "/", "AssumeRole", input)
  end

  @doc """
  Same as `assume_role/2` but raise on error.
  """
  @spec assume_role!(client :: ExAws.Sts.t, input :: assume_role_request) :: ExAws.Request.Query.success_t | no_return
  def assume_role!(client, input) do
    case assume_role(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  AssumeRoleWithSAML

  Returns a set of temporary security credentials for users who have been
  authenticated via a SAML authentication response. This operation provides a
  mechanism for tying an enterprise identity store or directory to role-based
  AWS access without user-specific credentials or configuration.

  The temporary security credentials returned by this operation consist of an
  access key ID, a secret access key, and a security token. Applications can
  use these temporary security credentials to sign calls to AWS services. The
  credentials are valid for the duration that you specified when calling
  `AssumeRoleWithSAML`, which can be up to 3600 seconds (1 hour) or until the
  time specified in the SAML authentication response's `SessionNotOnOrAfter`
  value, whichever is shorter.

  Note:The maximum duration for a session is 1 hour, and the minimum duration
  is 15 minutes, even if values outside this range are specified. Optionally,
  you can pass an IAM access policy to this operation. If you choose not to
  pass a policy, the temporary security credentials that are returned by the
  operation have the permissions that are defined in the access policy of the
  role that is being assumed. If you pass a policy to this operation, the
  temporary security credentials that are returned by the operation have the
  permissions that are allowed by both the access policy of the role that is
  being assumed, ***and*** the policy that you pass. This gives you a way to
  further restrict the permissions for the resulting temporary security
  credentials. You cannot use the passed policy to grant permissions that are
  in excess of those allowed by the access policy of the role that is being
  assumed. For more information, see [Permissions for
  AssumeRoleWithSAML](http://docs.aws.amazon.com/STS/latest/UsingSTS/permissions-assume-role.html)
  in *Using Temporary Security Credentials*.

  Before your application can call `AssumeRoleWithSAML`, you must configure
  your SAML identity provider (IdP) to issue the claims required by AWS.
  Additionally, you must use AWS Identity and Access Management (IAM) to
  create a SAML provider entity in your AWS account that represents your
  identity provider, and create an IAM role that specifies this SAML provider
  in its trust policy.

  Calling `AssumeRoleWithSAML` does not require the use of AWS security
  credentials. The identity of the caller is validated by using keys in the
  metadata document that is uploaded for the SAML provider entity for your
  identity provider.

  For more information, see the following resources:

  - [Creating Temporary Security Credentials for SAML
  Federation](http://docs.aws.amazon.com/STS/latest/UsingSTS/CreatingSAML.html).

  - [SAML
  Providers](http://docs.aws.amazon.com/IAM/latest/UserGuide/idp-managing-identityproviders.html)
  in *Using IAM*.

  - [Configuring a Relying Party and
  Claims](http://docs.aws.amazon.com/IAM/latest/UserGuide/create-role-saml-IdP-tasks.html)
  in *Using IAM*.

  - [Creating a Role for SAML-Based
  Federation](http://docs.aws.amazon.com/IAM/latest/UserGuide/create-role-saml.html)
  in *Using IAM*.

  <member name="RoleArn" target="arnType"></member> <member
  name="SAMLAssertion" target="SAMLAssertionType"></member> <member
  name="Policy" target="sessionPolicyDocumentType"></member> <member
  name="DurationSeconds" target="roleDurationSecondsType"></member>
  """

  @spec assume_role_with_saml(client :: ExAws.Sts.t, input :: assume_role_with_saml_request) :: ExAws.Request.Query.response_t
  def assume_role_with_saml(client, input) do
    request(client, "/", "AssumeRoleWithSAML", input)
  end

  @doc """
  Same as `assume_role_with_saml/2` but raise on error.
  """
  @spec assume_role_with_saml!(client :: ExAws.Sts.t, input :: assume_role_with_saml_request) :: ExAws.Request.Query.success_t | no_return
  def assume_role_with_saml!(client, input) do
    case assume_role_with_saml(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  AssumeRoleWithWebIdentity

  Returns a set of temporary security credentials for users who have been
  authenticated in a mobile or web application with a web identity provider,
  such as Amazon Cognito, Login with Amazon, Facebook, Google, or any OpenID
  Connect-compatible identity provider.

  Note: For mobile applications, we recommend that you use Amazon Cognito.
  You can use Amazon Cognito with the [AWS SDK for
  iOS](http://aws.amazon.com/sdkforios/) and the [AWS SDK for
  Android](http://aws.amazon.com/sdkforandroid/) to uniquely identify a user
  and supply the user with a consistent identity throughout the lifetime of
  an application.

  To learn more about Amazon Cognito, see [Amazon Cognito
  Overview](http://docs.aws.amazon.com/mobile/sdkforandroid/developerguide/cognito-auth.html#d0e840)
  in the *AWS SDK for Android Developer Guide* guide and [Amazon Cognito
  Overview](http://docs.aws.amazon.com/mobile/sdkforios/developerguide/cognito-auth.html#d0e664)
  in the *AWS SDK for iOS Developer Guide*.

  Calling `AssumeRoleWithWebIdentity` does not require the use of AWS
  security credentials. Therefore, you can distribute an application (for
  example, on mobile devices) that requests temporary security credentials
  without including long-term AWS credentials in the application, and without
  deploying server-based proxy services that use long-term AWS credentials.
  Instead, the identity of the caller is validated by using a token from the
  web identity provider.

  The temporary security credentials returned by this API consist of an
  access key ID, a secret access key, and a security token. Applications can
  use these temporary security credentials to sign calls to AWS service APIs.
  The credentials are valid for the duration that you specified when calling
  `AssumeRoleWithWebIdentity`, which can be from 900 seconds (15 minutes) to
  3600 seconds (1 hour). By default, the temporary security credentials are
  valid for 1 hour.

  Optionally, you can pass an IAM access policy to this operation. If you
  choose not to pass a policy, the temporary security credentials that are
  returned by the operation have the permissions that are defined in the
  access policy of the role that is being assumed. If you pass a policy to
  this operation, the temporary security credentials that are returned by the
  operation have the permissions that are allowed by both the access policy
  of the role that is being assumed, ***and*** the policy that you pass. This
  gives you a way to further restrict the permissions for the resulting
  temporary security credentials. You cannot use the passed policy to grant
  permissions that are in excess of those allowed by the access policy of the
  role that is being assumed. For more information, see [Permissions for
  AssumeRoleWithWebIdentity](http://docs.aws.amazon.com/STS/latest/UsingSTS/permissions-assume-role.html).

  Before your application can call `AssumeRoleWithWebIdentity`, you must have
  an identity token from a supported identity provider and create a role that
  the application can assume. The role that your application assumes must
  trust the identity provider that is associated with the identity token. In
  other words, the identity provider must be specified in the role's trust
  policy.

  For more information about how to use web identity federation and the
  `AssumeRoleWithWebIdentity` API, see the following resources:

  - [ Creating a Mobile Application with Third-Party
  Sign-In](http://docs.aws.amazon.com/STS/latest/UsingSTS/STSUseCases.html#MobileApplication-KnownProvider)
  and [ Creating Temporary Security Credentials for Mobile Apps Using
  Third-Party Identity
  Providers](http://docs.aws.amazon.com/STS/latest/UsingSTS/CreatingWIF.html).

  - [ Web Identity Federation
  Playground](https://web-identity-federation-playground.s3.amazonaws.com/index.html).
  This interactive website lets you walk through the process of
  authenticating via Login with Amazon, Facebook, or Google, getting
  temporary security credentials, and then using those credentials to make a
  request to AWS.

  - [AWS SDK for iOS](http://aws.amazon.com/sdkforios/) and [AWS SDK for
  Android](http://aws.amazon.com/sdkforandroid/). These toolkits contain
  sample apps that show how to invoke the identity providers, and then how to
  use the information from these providers to get and use temporary security
  credentials.

  - [Web Identity Federation with Mobile
  Applications](http://aws.amazon.com/articles/4617974389850313). This
  article discusses web identity federation and shows an example of how to
  use web identity federation to get access to content in Amazon S3.
  """

  @spec assume_role_with_web_identity(client :: ExAws.Sts.t, input :: assume_role_with_web_identity_request) :: ExAws.Request.Query.response_t
  def assume_role_with_web_identity(client, input) do
    request(client, "/", "AssumeRoleWithWebIdentity", input)
  end

  @doc """
  Same as `assume_role_with_web_identity/2` but raise on error.
  """
  @spec assume_role_with_web_identity!(client :: ExAws.Sts.t, input :: assume_role_with_web_identity_request) :: ExAws.Request.Query.success_t | no_return
  def assume_role_with_web_identity!(client, input) do
    case assume_role_with_web_identity(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DecodeAuthorizationMessage

  Decodes additional information about the authorization status of a request
  from an encoded message returned in response to an AWS request.

  For example, if a user is not authorized to perform an action that he or
  she has requested, the request returns a `Client.UnauthorizedOperation`
  response (an HTTP 403 response). Some AWS actions additionally return an
  encoded message that can provide details about this authorization failure.

  Note: Only certain AWS actions return an encoded authorization message. The
  documentation for an individual action indicates whether that action
  returns an encoded message in addition to returning an HTTP code. The
  message is encoded because the details of the authorization status can
  constitute privileged information that the user who requested the action
  should not see. To decode an authorization status message, a user must be
  granted permissions via an IAM policy to request the
  `DecodeAuthorizationMessage` (`sts:DecodeAuthorizationMessage`) action.

  The decoded message includes the following type of information:

  - Whether the request was denied due to an explicit deny or due to the
  absence of an explicit allow. For more information, see [Determining
  Whether a Request is Allowed or
  Denied](http://docs.aws.amazon.com/IAM/latest/UserGuide/AccessPolicyLanguage_EvaluationLogic.html#policy-eval-denyallow)
  in *Using IAM*.

  - The principal who made the request.

  - The requested action.

  - The requested resource.

  - The values of condition keys in the context of the user's request.
  """

  @spec decode_authorization_message(client :: ExAws.Sts.t, input :: decode_authorization_message_request) :: ExAws.Request.Query.response_t
  def decode_authorization_message(client, input) do
    request(client, "/", "DecodeAuthorizationMessage", input)
  end

  @doc """
  Same as `decode_authorization_message/2` but raise on error.
  """
  @spec decode_authorization_message!(client :: ExAws.Sts.t, input :: decode_authorization_message_request) :: ExAws.Request.Query.success_t | no_return
  def decode_authorization_message!(client, input) do
    case decode_authorization_message(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetFederationToken

  Returns a set of temporary security credentials (consisting of an access
  key ID, a secret access key, and a security token) for a federated user. A
  typical use is in a proxy application that gets temporary security
  credentials on behalf of distributed applications inside a corporate
  network. Because you must call the `GetFederationToken` action using the
  long-term security credentials of an IAM user, this call is appropriate in
  contexts where those credentials can be safely stored, usually in a
  server-based application.

  Note: If you are creating a mobile-based or browser-based app that can
  authenticate users using a web identity provider like Login with Amazon,
  Facebook, Google, or an OpenID Connect-compatible identity provider, we
  recommend that you use [Amazon Cognito](http://aws.amazon.com/cognito/) or
  `AssumeRoleWithWebIdentity`. For more information, see [Creating Temporary
  Security Credentials for Mobile Apps Using Identity
  Providers](http://docs.aws.amazon.com/STS/latest/UsingSTS/CreatingWIF.html).

  The `GetFederationToken` action must be called by using the long-term AWS
  security credentials of an IAM user. You can also call `GetFederationToken`
  using the security credentials of an AWS account (root), but this is not
  recommended. Instead, we recommend that you create an IAM user for the
  purpose of the proxy application and then attach a policy to the IAM user
  that limits federated users to only the actions and resources they need
  access to. For more information, see [IAM Best
  Practices](http://docs.aws.amazon.com/IAM/latest/UserGuide/IAMBestPractices.html)
  in *Using IAM*.

  The temporary security credentials that are obtained by using the long-term
  credentials of an IAM user are valid for the specified duration, between
  900 seconds (15 minutes) and 129600 seconds (36 hours). Temporary
  credentials that are obtained by using AWS account (root) credentials have
  a maximum duration of 3600 seconds (1 hour)

  **Permissions**

  The permissions for the temporary security credentials returned by
  `GetFederationToken` are determined by a combination of the following:

  - The policy or policies that are attached to the IAM user whose
  credentials are used to call `GetFederationToken`.

  - The policy that is passed as a parameter in the call.

  The passed policy is attached to the temporary security credentials that
  result from the `GetFederationToken` API call--that is, to the *federated
  user*. When the federated user makes an AWS request, AWS evaluates the
  policy attached to the federated user in combination with the policy or
  policies attached to the IAM user whose credentials were used to call
  `GetFederationToken`. AWS allows the federated user's request only when
  both the federated user ***and*** the IAM user are explicitly allowed to
  perform the requested action. The passed policy cannot grant more
  permissions than those that are defined in the IAM user policy.

  A typical use case is that the permissions of the IAM user whose
  credentials are used to call `GetFederationToken` are designed to allow
  access to all the actions and resources that any federated user will need.
  Then, for individual users, you pass a policy to the operation that scopes
  down the permissions to a level that's appropriate to that individual user,
  using a policy that allows only a subset of permissions that are granted to
  the IAM user.

  If you do not pass a policy, the resulting temporary security credentials
  have no effective permissions. The only exception is when the temporary
  security credentials are used to access a resource that has a
  resource-based policy that specifically allows the federated user to access
  the resource.

  For more information about how permissions work, see [Permissions for
  GetFederationToken](http://docs.aws.amazon.com/STS/latest/UsingSTS/permissions-get-federation-token.html).
  For information about using `GetFederationToken` to create temporary
  security credentials, see [Creating Temporary Credentials to Enable Access
  for Federated
  Users](http://docs.aws.amazon.com/STS/latest/UsingSTS/CreatingFedTokens.html).
  """

  @spec get_federation_token(client :: ExAws.Sts.t, input :: get_federation_token_request) :: ExAws.Request.Query.response_t
  def get_federation_token(client, input) do
    request(client, "/", "GetFederationToken", input)
  end

  @doc """
  Same as `get_federation_token/2` but raise on error.
  """
  @spec get_federation_token!(client :: ExAws.Sts.t, input :: get_federation_token_request) :: ExAws.Request.Query.success_t | no_return
  def get_federation_token!(client, input) do
    case get_federation_token(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetSessionToken

  Returns a set of temporary credentials for an AWS account or IAM user. The
  credentials consist of an access key ID, a secret access key, and a
  security token. Typically, you use `GetSessionToken` if you want to use MFA
  to protect programmatic calls to specific AWS APIs like Amazon EC2
  `StopInstances`. MFA-enabled IAM users would need to call `GetSessionToken`
  and submit an MFA code that is associated with their MFA device. Using the
  temporary security credentials that are returned from the call, IAM users
  can then make programmatic calls to APIs that require MFA authentication.

  The `GetSessionToken` action must be called by using the long-term AWS
  security credentials of the AWS account or an IAM user. Credentials that
  are created by IAM users are valid for the duration that you specify,
  between 900 seconds (15 minutes) and 129600 seconds (36 hours); credentials
  that are created by using account credentials have a maximum duration of
  3600 seconds (1 hour).

  Note: We recommend that you do not call `GetSessionToken` with root account
  credentials. Instead, follow our [best
  practices](http://docs.aws.amazon.com/IAM/latest/UserGuide/IAMBestPractices.html#create-iam-users)
  by creating one or more IAM users, giving them the necessary permissions,
  and using IAM users for everyday interaction with AWS.

  The permissions associated with the temporary security credentials returned
  by `GetSessionToken` are based on the permissions associated with account
  or IAM user whose credentials are used to call the action. If
  `GetSessionToken` is called using root account credentials, the temporary
  credentials have root account permissions. Similarly, if `GetSessionToken`
  is called using the credentials of an IAM user, the temporary credentials
  have the same permissions as the IAM user.

  For more information about using `GetSessionToken` to create temporary
  credentials, go to [Creating Temporary Credentials to Enable Access for IAM
  Users](http://docs.aws.amazon.com/STS/latest/UsingSTS/CreatingSessionTokens.html"
  target="_blank).
  """

  @spec get_session_token(client :: ExAws.Sts.t, input :: get_session_token_request) :: ExAws.Request.Query.response_t
  def get_session_token(client, input) do
    request(client, "/", "GetSessionToken", input)
  end

  @doc """
  Same as `get_session_token/2` but raise on error.
  """
  @spec get_session_token!(client :: ExAws.Sts.t, input :: get_session_token_request) :: ExAws.Request.Query.success_t | no_return
  def get_session_token!(client, input) do
    case get_session_token(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  defp request(%{__struct__: client_module} = client, uri, action, input) do
    apply(client_module, :request, [client, uri, action, input])
  end
end
