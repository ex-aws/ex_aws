defmodule ExAws.CognitoIdentity.Core do
  import ExAws.Core.JSON, only: [format_input: 1]
  @actions [
    "CreateIdentityPool",
    "DeleteIdentities",
    "DeleteIdentityPool",
    "DescribeIdentity",
    "DescribeIdentityPool",
    "GetCredentialsForIdentity",
    "GetId",
    "GetIdentityPoolRoles",
    "GetOpenIdToken",
    "GetOpenIdTokenForDeveloperIdentity",
    "ListIdentities",
    "ListIdentityPools",
    "LookupDeveloperIdentity",
    "MergeDeveloperIdentities",
    "SetIdentityPoolRoles",
    "UnlinkDeveloperIdentity",
    "UnlinkIdentity",
    "UpdateIdentityPool"]

  @moduledoc """
  ## Amazon Cognito Identity

  Amazon Cognito

  Amazon Cognito is a web service that delivers scoped temporary credentials
  to mobile devices and other untrusted environments. Amazon Cognito uniquely
  identifies a device and supplies the user with a consistent identity over
  the lifetime of an application.

  Using Amazon Cognito, you can enable authentication with one or more
  third-party identity providers (Facebook, Google, or Login with Amazon),
  and you can also choose to support unauthenticated access from your app.
  Cognito delivers a unique identifier for each user and acts as an OpenID
  token provider trusted by AWS Security Token Service (STS) to access
  temporary, limited-privilege AWS credentials.

  To provide end-user credentials, first make an unsigned call to `GetId`. If
  the end user is authenticated with one of the supported identity providers,
  set the `Logins` map with the identity provider token. `GetId` returns a
  unique identifier for the user.

  Next, make an unsigned call to `GetCredentialsForIdentity`. This call
  expects the same `Logins` map as the `GetId` call, as well as the
  `IdentityID` originally returned by `GetId`. Assuming your identity pool
  has been configured via the `SetIdentityPoolRoles` operation,
  `GetCredentialsForIdentity` will return AWS credentials for your use. If
  your pool has not been configured with `SetIdentityPoolRoles`, or if you
  want to follow legacy flow, make an unsigned call to `GetOpenIdToken`,
  which returns the OpenID token necessary to call STS and retrieve AWS
  credentials. This call expects the same `Logins` map as the `GetId` call,
  as well as the `IdentityID` originally returned by `GetId`. The token
  returned by `GetOpenIdToken` can be passed to the STS operation
  [AssumeRoleWithWebIdentity](http://docs.aws.amazon.com/STS/latest/APIReference/API_AssumeRoleWithWebIdentity.html)
  to retrieve AWS credentials.

  If you want to use Amazon Cognito in an Android, iOS, or Unity application,
  you will probably want to make API calls via the AWS Mobile SDK. To learn
  more, see the [AWS Mobile SDK Developer
  Guide](http://docs.aws.amazon.com/mobile/index.html).
  """

  @type arn_string :: binary

  @type access_key_string :: binary

  @type account_id :: binary

  @type concurrent_modification_exception :: [
    message: binary,
  ]

  @type create_identity_pool_input :: [
    allow_unauthenticated_identities: identity_pool_unauthenticated,
    developer_provider_name: developer_provider_name,
    identity_pool_name: identity_pool_name,
    open_id_connect_provider_ar_ns: oidc_provider_list,
    supported_login_providers: identity_providers,
  ]

  @type credentials :: [
    access_key_id: access_key_string,
    expiration: date_type,
    secret_key: secret_key_string,
    session_token: session_token_string,
  ]

  @type date_type :: integer

  @type delete_identities_input :: [
    identity_ids_to_delete: identity_id_list,
  ]

  @type delete_identities_response :: [
    unprocessed_identity_ids: unprocessed_identity_id_list,
  ]

  @type delete_identity_pool_input :: [
    identity_pool_id: identity_pool_id,
  ]

  @type describe_identity_input :: [
    identity_id: identity_id,
  ]

  @type describe_identity_pool_input :: [
    identity_pool_id: identity_pool_id,
  ]

  @type developer_provider_name :: binary

  @type developer_user_already_registered_exception :: [
    message: binary,
  ]

  @type developer_user_identifier :: binary

  @type developer_user_identifier_list :: [developer_user_identifier]

  @type error_code :: binary

  @type external_service_exception :: [
    message: binary,
  ]

  @type get_credentials_for_identity_input :: [
    identity_id: identity_id,
    logins: logins_map,
  ]

  @type get_credentials_for_identity_response :: [
    credentials: credentials,
    identity_id: identity_id,
  ]

  @type get_id_input :: [
    account_id: account_id,
    identity_pool_id: identity_pool_id,
    logins: logins_map,
  ]

  @type get_id_response :: [
    identity_id: identity_id,
  ]

  @type get_identity_pool_roles_input :: [
    identity_pool_id: identity_pool_id,
  ]

  @type get_identity_pool_roles_response :: [
    identity_pool_id: identity_pool_id,
    roles: roles_map,
  ]

  @type get_open_id_token_for_developer_identity_input :: [
    identity_id: identity_id,
    identity_pool_id: identity_pool_id,
    logins: logins_map,
    token_duration: token_duration,
  ]

  @type get_open_id_token_for_developer_identity_response :: [
    identity_id: identity_id,
    token: oidc_token,
  ]

  @type get_open_id_token_input :: [
    identity_id: identity_id,
    logins: logins_map,
  ]

  @type get_open_id_token_response :: [
    identity_id: identity_id,
    token: oidc_token,
  ]

  @type hide_disabled :: boolean

  @type identities_list :: [identity_description]

  @type identity_description :: [
    creation_date: date_type,
    identity_id: identity_id,
    last_modified_date: date_type,
    logins: logins_list,
  ]

  @type identity_id :: binary

  @type identity_id_list :: [identity_id]

  @type identity_pool :: [
    allow_unauthenticated_identities: identity_pool_unauthenticated,
    developer_provider_name: developer_provider_name,
    identity_pool_id: identity_pool_id,
    identity_pool_name: identity_pool_name,
    open_id_connect_provider_ar_ns: oidc_provider_list,
    supported_login_providers: identity_providers,
  ]

  @type identity_pool_id :: binary

  @type identity_pool_name :: binary

  @type identity_pool_short_description :: [
    identity_pool_id: identity_pool_id,
    identity_pool_name: identity_pool_name,
  ]

  @type identity_pool_unauthenticated :: boolean

  @type identity_pools_list :: [identity_pool_short_description]

  @type identity_provider_id :: binary

  @type identity_provider_name :: binary

  @type identity_provider_token :: binary

  @type identity_providers :: [{identity_provider_name, identity_provider_id}]

  @type internal_error_exception :: [
    message: binary,
  ]

  @type invalid_identity_pool_configuration_exception :: [
    message: binary,
  ]

  @type invalid_parameter_exception :: [
    message: binary,
  ]

  @type limit_exceeded_exception :: [
    message: binary,
  ]

  @type list_identities_input :: [
    hide_disabled: hide_disabled,
    identity_pool_id: identity_pool_id,
    max_results: query_limit,
    next_token: pagination_key,
  ]

  @type list_identities_response :: [
    identities: identities_list,
    identity_pool_id: identity_pool_id,
    next_token: pagination_key,
  ]

  @type list_identity_pools_input :: [
    max_results: query_limit,
    next_token: pagination_key,
  ]

  @type list_identity_pools_response :: [
    identity_pools: identity_pools_list,
    next_token: pagination_key,
  ]

  @type logins_list :: [identity_provider_name]

  @type logins_map :: [{identity_provider_name, identity_provider_token}]

  @type lookup_developer_identity_input :: [
    developer_user_identifier: developer_user_identifier,
    identity_id: identity_id,
    identity_pool_id: identity_pool_id,
    max_results: query_limit,
    next_token: pagination_key,
  ]

  @type lookup_developer_identity_response :: [
    developer_user_identifier_list: developer_user_identifier_list,
    identity_id: identity_id,
    next_token: pagination_key,
  ]

  @type merge_developer_identities_input :: [
    destination_user_identifier: developer_user_identifier,
    developer_provider_name: developer_provider_name,
    identity_pool_id: identity_pool_id,
    source_user_identifier: developer_user_identifier,
  ]

  @type merge_developer_identities_response :: [
    identity_id: identity_id,
  ]

  @type not_authorized_exception :: [
    message: binary,
  ]

  @type oidc_provider_list :: [arn_string]

  @type oidc_token :: binary

  @type pagination_key :: binary

  @type query_limit :: integer

  @type resource_conflict_exception :: [
    message: binary,
  ]

  @type resource_not_found_exception :: [
    message: binary,
  ]

  @type role_type :: binary

  @type roles_map :: [{role_type, arn_string}]

  @type secret_key_string :: binary

  @type session_token_string :: binary

  @type set_identity_pool_roles_input :: [
    identity_pool_id: identity_pool_id,
    roles: roles_map,
  ]

  @type token_duration :: integer

  @type too_many_requests_exception :: [
    message: binary,
  ]

  @type unlink_developer_identity_input :: [
    developer_provider_name: developer_provider_name,
    developer_user_identifier: developer_user_identifier,
    identity_id: identity_id,
    identity_pool_id: identity_pool_id,
  ]

  @type unlink_identity_input :: [
    identity_id: identity_id,
    logins: logins_map,
    logins_to_remove: logins_list,
  ]

  @type unprocessed_identity_id :: [
    error_code: error_code,
    identity_id: identity_id,
  ]

  @type unprocessed_identity_id_list :: [unprocessed_identity_id]





  @doc """
  CreateIdentityPool

  Creates a new identity pool. The identity pool is a store of user identity
  information that is specific to your AWS account. The limit on identity
  pools is 60 per account. You must use AWS Developer credentials to call
  this API.
  """

  @spec create_identity_pool(client :: ExAws.CognitoIdentity.t, input :: create_identity_pool_input) :: ExAws.Request.JSON.response_t
  def create_identity_pool(client, input) do
    request(client, "CreateIdentityPool", format_input(input))
  end

  @doc """
  Same as `create_identity_pool/2` but raise on error.
  """
  @spec create_identity_pool!(client :: ExAws.CognitoIdentity.t, input :: create_identity_pool_input) :: ExAws.Request.JSON.success_t | no_return
  def create_identity_pool!(client, input) do
    case create_identity_pool(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteIdentities

  Deletes identities from an identity pool. You can specify a list of 1-60
  identities that you want to delete.

  You must use AWS Developer credentials to call this API.
  """

  @spec delete_identities(client :: ExAws.CognitoIdentity.t, input :: delete_identities_input) :: ExAws.Request.JSON.response_t
  def delete_identities(client, input) do
    request(client, "DeleteIdentities", format_input(input))
  end

  @doc """
  Same as `delete_identities/2` but raise on error.
  """
  @spec delete_identities!(client :: ExAws.CognitoIdentity.t, input :: delete_identities_input) :: ExAws.Request.JSON.success_t | no_return
  def delete_identities!(client, input) do
    case delete_identities(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteIdentityPool

  Deletes a user pool. Once a pool is deleted, users will not be able to
  authenticate with the pool.

  You must use AWS Developer credentials to call this API.
  """

  @spec delete_identity_pool(client :: ExAws.CognitoIdentity.t, input :: delete_identity_pool_input) :: ExAws.Request.JSON.response_t
  def delete_identity_pool(client, input) do
    request(client, "DeleteIdentityPool", format_input(input))
  end

  @doc """
  Same as `delete_identity_pool/2` but raise on error.
  """
  @spec delete_identity_pool!(client :: ExAws.CognitoIdentity.t, input :: delete_identity_pool_input) :: ExAws.Request.JSON.success_t | no_return
  def delete_identity_pool!(client, input) do
    case delete_identity_pool(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeIdentity

  Returns metadata related to the given identity, including when the identity
  was created and any associated linked logins.

  You must use AWS Developer credentials to call this API.
  """

  @spec describe_identity(client :: ExAws.CognitoIdentity.t, input :: describe_identity_input) :: ExAws.Request.JSON.response_t
  def describe_identity(client, input) do
    request(client, "DescribeIdentity", format_input(input))
  end

  @doc """
  Same as `describe_identity/2` but raise on error.
  """
  @spec describe_identity!(client :: ExAws.CognitoIdentity.t, input :: describe_identity_input) :: ExAws.Request.JSON.success_t | no_return
  def describe_identity!(client, input) do
    case describe_identity(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeIdentityPool

  Gets details about a particular identity pool, including the pool name, ID
  description, creation date, and current number of users.

  You must use AWS Developer credentials to call this API.
  """

  @spec describe_identity_pool(client :: ExAws.CognitoIdentity.t, input :: describe_identity_pool_input) :: ExAws.Request.JSON.response_t
  def describe_identity_pool(client, input) do
    request(client, "DescribeIdentityPool", format_input(input))
  end

  @doc """
  Same as `describe_identity_pool/2` but raise on error.
  """
  @spec describe_identity_pool!(client :: ExAws.CognitoIdentity.t, input :: describe_identity_pool_input) :: ExAws.Request.JSON.success_t | no_return
  def describe_identity_pool!(client, input) do
    case describe_identity_pool(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetCredentialsForIdentity

  Returns credentials for the the provided identity ID. Any provided logins
  will be validated against supported login providers. If the token is for
  cognito-identity.amazonaws.com, it will be passed through to AWS Security
  Token Service with the appropriate role for the token.

  This is a public API. You do not need any credentials to call this API.
  """

  @spec get_credentials_for_identity(client :: ExAws.CognitoIdentity.t, input :: get_credentials_for_identity_input) :: ExAws.Request.JSON.response_t
  def get_credentials_for_identity(client, input) do
    request(client, "GetCredentialsForIdentity", format_input(input))
  end

  @doc """
  Same as `get_credentials_for_identity/2` but raise on error.
  """
  @spec get_credentials_for_identity!(client :: ExAws.CognitoIdentity.t, input :: get_credentials_for_identity_input) :: ExAws.Request.JSON.success_t | no_return
  def get_credentials_for_identity!(client, input) do
    case get_credentials_for_identity(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetId

  Generates (or retrieves) a Cognito ID. Supplying multiple logins will
  create an implicit linked account.

  token+";"+tokenSecret.

  This is a public API. You do not need any credentials to call this API.
  """

  @spec get_id(client :: ExAws.CognitoIdentity.t, input :: get_id_input) :: ExAws.Request.JSON.response_t
  def get_id(client, input) do
    request(client, "GetId", format_input(input))
  end

  @doc """
  Same as `get_id/2` but raise on error.
  """
  @spec get_id!(client :: ExAws.CognitoIdentity.t, input :: get_id_input) :: ExAws.Request.JSON.success_t | no_return
  def get_id!(client, input) do
    case get_id(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetIdentityPoolRoles

  Gets the roles for an identity pool.

  You must use AWS Developer credentials to call this API.
  """

  @spec get_identity_pool_roles(client :: ExAws.CognitoIdentity.t, input :: get_identity_pool_roles_input) :: ExAws.Request.JSON.response_t
  def get_identity_pool_roles(client, input) do
    request(client, "GetIdentityPoolRoles", format_input(input))
  end

  @doc """
  Same as `get_identity_pool_roles/2` but raise on error.
  """
  @spec get_identity_pool_roles!(client :: ExAws.CognitoIdentity.t, input :: get_identity_pool_roles_input) :: ExAws.Request.JSON.success_t | no_return
  def get_identity_pool_roles!(client, input) do
    case get_identity_pool_roles(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetOpenIdToken

  Gets an OpenID token, using a known Cognito ID. This known Cognito ID is
  returned by `GetId`. You can optionally add additional logins for the
  identity. Supplying multiple logins creates an implicit link.

  The OpenId token is valid for 15 minutes.

  This is a public API. You do not need any credentials to call this API.
  """

  @spec get_open_id_token(client :: ExAws.CognitoIdentity.t, input :: get_open_id_token_input) :: ExAws.Request.JSON.response_t
  def get_open_id_token(client, input) do
    request(client, "GetOpenIdToken", format_input(input))
  end

  @doc """
  Same as `get_open_id_token/2` but raise on error.
  """
  @spec get_open_id_token!(client :: ExAws.CognitoIdentity.t, input :: get_open_id_token_input) :: ExAws.Request.JSON.success_t | no_return
  def get_open_id_token!(client, input) do
    case get_open_id_token(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetOpenIdTokenForDeveloperIdentity

  Registers (or retrieves) a Cognito `IdentityId` and an OpenID Connect token
  for a user authenticated by your backend authentication process. Supplying
  multiple logins will create an implicit linked account. You can only
  specify one developer provider as part of the `Logins` map, which is linked
  to the identity pool. The developer provider is the "domain" by which
  Cognito will refer to your users.

  You can use `GetOpenIdTokenForDeveloperIdentity` to create a new identity
  and to link new logins (that is, user credentials issued by a public
  provider or developer provider) to an existing identity. When you want to
  create a new identity, the `IdentityId` should be null. When you want to
  associate a new login with an existing authenticated/unauthenticated
  identity, you can do so by providing the existing `IdentityId`. This API
  will create the identity in the specified `IdentityPoolId`.

  You must use AWS Developer credentials to call this API.
  """

  @spec get_open_id_token_for_developer_identity(client :: ExAws.CognitoIdentity.t, input :: get_open_id_token_for_developer_identity_input) :: ExAws.Request.JSON.response_t
  def get_open_id_token_for_developer_identity(client, input) do
    request(client, "GetOpenIdTokenForDeveloperIdentity", format_input(input))
  end

  @doc """
  Same as `get_open_id_token_for_developer_identity/2` but raise on error.
  """
  @spec get_open_id_token_for_developer_identity!(client :: ExAws.CognitoIdentity.t, input :: get_open_id_token_for_developer_identity_input) :: ExAws.Request.JSON.success_t | no_return
  def get_open_id_token_for_developer_identity!(client, input) do
    case get_open_id_token_for_developer_identity(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListIdentities

  Lists the identities in a pool.

  You must use AWS Developer credentials to call this API.
  """

  @spec list_identities(client :: ExAws.CognitoIdentity.t, input :: list_identities_input) :: ExAws.Request.JSON.response_t
  def list_identities(client, input) do
    request(client, "ListIdentities", format_input(input))
  end

  @doc """
  Same as `list_identities/2` but raise on error.
  """
  @spec list_identities!(client :: ExAws.CognitoIdentity.t, input :: list_identities_input) :: ExAws.Request.JSON.success_t | no_return
  def list_identities!(client, input) do
    case list_identities(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListIdentityPools

  Lists all of the Cognito identity pools registered for your account.

  This is a public API. You do not need any credentials to call this API.
  """

  @spec list_identity_pools(client :: ExAws.CognitoIdentity.t, input :: list_identity_pools_input) :: ExAws.Request.JSON.response_t
  def list_identity_pools(client, input) do
    request(client, "ListIdentityPools", format_input(input))
  end

  @doc """
  Same as `list_identity_pools/2` but raise on error.
  """
  @spec list_identity_pools!(client :: ExAws.CognitoIdentity.t, input :: list_identity_pools_input) :: ExAws.Request.JSON.success_t | no_return
  def list_identity_pools!(client, input) do
    case list_identity_pools(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  LookupDeveloperIdentity

  Retrieves the `IdentityID` associated with a `DeveloperUserIdentifier` or
  the list of `DeveloperUserIdentifier`s associated with an `IdentityId` for
  an existing identity. Either `IdentityID` or `DeveloperUserIdentifier` must
  not be null. If you supply only one of these values, the other value will
  be searched in the database and returned as a part of the response. If you
  supply both, `DeveloperUserIdentifier` will be matched against
  `IdentityID`. If the values are verified against the database, the response
  returns both values and is the same as the request. Otherwise a
  `ResourceConflictException` is thrown.

  You must use AWS Developer credentials to call this API.
  """

  @spec lookup_developer_identity(client :: ExAws.CognitoIdentity.t, input :: lookup_developer_identity_input) :: ExAws.Request.JSON.response_t
  def lookup_developer_identity(client, input) do
    request(client, "LookupDeveloperIdentity", format_input(input))
  end

  @doc """
  Same as `lookup_developer_identity/2` but raise on error.
  """
  @spec lookup_developer_identity!(client :: ExAws.CognitoIdentity.t, input :: lookup_developer_identity_input) :: ExAws.Request.JSON.success_t | no_return
  def lookup_developer_identity!(client, input) do
    case lookup_developer_identity(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  MergeDeveloperIdentities

  Merges two users having different `IdentityId`s, existing in the same
  identity pool, and identified by the same developer provider. You can use
  this action to request that discrete users be merged and identified as a
  single user in the Cognito environment. Cognito associates the given source
  user (`SourceUserIdentifier`) with the `IdentityId` of the
  `DestinationUserIdentifier`. Only developer-authenticated users can be
  merged. If the users to be merged are associated with the same public
  provider, but as two different users, an exception will be thrown.

  You must use AWS Developer credentials to call this API.
  """

  @spec merge_developer_identities(client :: ExAws.CognitoIdentity.t, input :: merge_developer_identities_input) :: ExAws.Request.JSON.response_t
  def merge_developer_identities(client, input) do
    request(client, "MergeDeveloperIdentities", format_input(input))
  end

  @doc """
  Same as `merge_developer_identities/2` but raise on error.
  """
  @spec merge_developer_identities!(client :: ExAws.CognitoIdentity.t, input :: merge_developer_identities_input) :: ExAws.Request.JSON.success_t | no_return
  def merge_developer_identities!(client, input) do
    case merge_developer_identities(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  SetIdentityPoolRoles

  Sets the roles for an identity pool. These roles are used when making calls
  to `GetCredentialsForIdentity` action.

  You must use AWS Developer credentials to call this API.
  """

  @spec set_identity_pool_roles(client :: ExAws.CognitoIdentity.t, input :: set_identity_pool_roles_input) :: ExAws.Request.JSON.response_t
  def set_identity_pool_roles(client, input) do
    request(client, "SetIdentityPoolRoles", format_input(input))
  end

  @doc """
  Same as `set_identity_pool_roles/2` but raise on error.
  """
  @spec set_identity_pool_roles!(client :: ExAws.CognitoIdentity.t, input :: set_identity_pool_roles_input) :: ExAws.Request.JSON.success_t | no_return
  def set_identity_pool_roles!(client, input) do
    case set_identity_pool_roles(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UnlinkDeveloperIdentity

  Unlinks a `DeveloperUserIdentifier` from an existing identity. Unlinked
  developer users will be considered new identities next time they are seen.
  If, for a given Cognito identity, you remove all federated identities as
  well as the developer user identifier, the Cognito identity becomes
  inaccessible.

  This is a public API. You do not need any credentials to call this API.
  """

  @spec unlink_developer_identity(client :: ExAws.CognitoIdentity.t, input :: unlink_developer_identity_input) :: ExAws.Request.JSON.response_t
  def unlink_developer_identity(client, input) do
    request(client, "UnlinkDeveloperIdentity", format_input(input))
  end

  @doc """
  Same as `unlink_developer_identity/2` but raise on error.
  """
  @spec unlink_developer_identity!(client :: ExAws.CognitoIdentity.t, input :: unlink_developer_identity_input) :: ExAws.Request.JSON.success_t | no_return
  def unlink_developer_identity!(client, input) do
    case unlink_developer_identity(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UnlinkIdentity

  Unlinks a federated identity from an existing account. Unlinked logins will
  be considered new identities next time they are seen. Removing the last
  linked login will make this identity inaccessible.

  This is a public API. You do not need any credentials to call this API.
  """

  @spec unlink_identity(client :: ExAws.CognitoIdentity.t, input :: unlink_identity_input) :: ExAws.Request.JSON.response_t
  def unlink_identity(client, input) do
    request(client, "UnlinkIdentity", format_input(input))
  end

  @doc """
  Same as `unlink_identity/2` but raise on error.
  """
  @spec unlink_identity!(client :: ExAws.CognitoIdentity.t, input :: unlink_identity_input) :: ExAws.Request.JSON.success_t | no_return
  def unlink_identity!(client, input) do
    case unlink_identity(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateIdentityPool

  Updates a user pool.

  You must use AWS Developer credentials to call this API.
  """

  @spec update_identity_pool(client :: ExAws.CognitoIdentity.t, input :: identity_pool) :: ExAws.Request.JSON.response_t
  def update_identity_pool(client, input) do
    request(client, "UpdateIdentityPool", format_input(input))
  end

  @doc """
  Same as `update_identity_pool/2` but raise on error.
  """
  @spec update_identity_pool!(client :: ExAws.CognitoIdentity.t, input :: identity_pool) :: ExAws.Request.JSON.success_t | no_return
  def update_identity_pool!(client, input) do
    case update_identity_pool(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  defp request(%{__struct__: client_module} = client, action, input) do
    apply(client_module, :request, [client, action, input])
  end
end
