defmodule ExAws.KMS.Core do
  import ExAws.Core.JSON, only: [format_input: 1]
  @actions [
    "CreateAlias",
    "CreateGrant",
    "CreateKey",
    "Decrypt",
    "DeleteAlias",
    "DescribeKey",
    "DisableKey",
    "DisableKeyRotation",
    "EnableKey",
    "EnableKeyRotation",
    "Encrypt",
    "GenerateDataKey",
    "GenerateDataKeyWithoutPlaintext",
    "GenerateRandom",
    "GetKeyPolicy",
    "GetKeyRotationStatus",
    "ListAliases",
    "ListGrants",
    "ListKeyPolicies",
    "ListKeys",
    "PutKeyPolicy",
    "ReEncrypt",
    "RetireGrant",
    "RevokeGrant",
    "UpdateAlias",
    "UpdateKeyDescription"]

  @moduledoc """
  ## AWS Key Management Service

  AWS Key Management Service

  AWS Key Management Service (KMS) is an encryption and key management web
  service. This guide describes the KMS actions that you can call
  programmatically. For general information about KMS, see the [ AWS Key
  Management Service Developer Guide
  ](http://docs.aws.amazon.com/kms/latest/developerguide/overview.html)

  Note: AWS provides SDKs that consist of libraries and sample code for
  various programming languages and platforms (Java, Ruby, .Net, iOS,
  Android, etc.). The SDKs provide a convenient way to create programmatic
  access to KMS and AWS. For example, the SDKs take care of tasks such as
  signing requests (see below), managing errors, and retrying requests
  automatically. For more information about the AWS SDKs, including how to
  download and install them, see [Tools for Amazon Web
  Services](http://aws.amazon.com/tools/). We recommend that you use the AWS
  SDKs to make programmatic API calls to KMS.

  Clients must support TLS (Transport Layer Security) 1.0. We recommend TLS
  1.2. Clients must also support cipher suites with Perfect Forward Secrecy
  (PFS) such as Ephemeral Diffie-Hellman (DHE) or Elliptic Curve Ephemeral
  Diffie-Hellman (ECDHE). Most modern systems such as Java 7 and later
  support these modes.

  **Signing Requests**

  Requests must be signed by using an access key ID and a secret access key.
  We strongly recommend that you do not use your AWS account access key ID
  and secret key for everyday work with KMS. Instead, use the access key ID
  and secret access key for an IAM user, or you can use the AWS Security
  Token Service to generate temporary security credentials that you can use
  to sign requests.

  All KMS operations require [Signature Version
  4](http://docs.aws.amazon.com/general/latest/gr/signature-version-4.html).

  **Recording API Requests**

  KMS supports AWS CloudTrail, a service that records AWS API calls and
  related events for your AWS account and delivers them to an Amazon S3
  bucket that you specify. By using the information collected by CloudTrail,
  you can determine what requests were made to KMS, who made the request,
  when it was made, and so on. To learn more about CloudTrail, including how
  to turn it on and find your log files, see the [AWS CloudTrail User
  Guide](http://docs.aws.amazon.com/awscloudtrail/latest/userguide/whatiscloudtrail.html)

  **Additional Resources**

  For more information about credentials and request signing, see the
  following:

  - [AWS Security
  Credentials](http://docs.aws.amazon.com/general/latest/gr/aws-security-credentials.html).
  This topic provides general information about the types of credentials used
  for accessing AWS.

  - [AWS Security Token
  Service](http://docs.aws.amazon.com/STS/latest/UsingSTS/). This guide
  describes how to create and use temporary security credentials.

  - [Signing AWS API
  Requests](http://docs.aws.amazon.com/general/latest/gr/signing_aws_api_requests.html).
  This set of topics walks you through the process of signing a request using
  an access key ID and a secret access key.

  **Commonly Used APIs**

  Of the APIs discussed in this guide, the following will prove the most
  useful for most applications. You will likely perform actions other than
  these, such as creating keys and assigning policies, by using the console.

  - `Encrypt`

  - `Decrypt`

  - `GenerateDataKey`

  - `GenerateDataKeyWithoutPlaintext`
  """

  @type aws_account_id_type :: binary

  @type alias_list :: [alias_list_entry]

  @type alias_list_entry :: [
    alias_arn: arn_type,
    alias_name: alias_name_type,
    target_key_id: key_id_type,
  ]

  @type alias_name_type :: binary

  @type already_exists_exception :: [
    message: error_message_type,
  ]

  @type arn_type :: binary

  @type boolean_type :: boolean

  @type ciphertext_type :: binary

  @type create_alias_request :: [
    alias_name: alias_name_type,
    target_key_id: key_id_type,
  ]

  @type create_grant_request :: [
    constraints: grant_constraints,
    grant_tokens: grant_token_list,
    grantee_principal: principal_id_type,
    key_id: key_id_type,
    operations: grant_operation_list,
    retiring_principal: principal_id_type,
  ]

  @type create_grant_response :: [
    grant_id: grant_id_type,
    grant_token: grant_token_type,
  ]

  @type create_key_request :: [
    description: description_type,
    key_usage: key_usage_type,
    policy: policy_type,
  ]

  @type create_key_response :: [
    key_metadata: key_metadata,
  ]

  @type data_key_spec :: binary

  @type date_type :: integer

  @type decrypt_request :: [
    ciphertext_blob: ciphertext_type,
    encryption_context: encryption_context_type,
    grant_tokens: grant_token_list,
  ]

  @type decrypt_response :: [
    key_id: key_id_type,
    plaintext: plaintext_type,
  ]

  @type delete_alias_request :: [
    alias_name: alias_name_type,
  ]

  @type dependency_timeout_exception :: [
    message: error_message_type,
  ]

  @type describe_key_request :: [
    key_id: key_id_type,
  ]

  @type describe_key_response :: [
    key_metadata: key_metadata,
  ]

  @type description_type :: binary

  @type disable_key_request :: [
    key_id: key_id_type,
  ]

  @type disable_key_rotation_request :: [
    key_id: key_id_type,
  ]

  @type disabled_exception :: [
    message: error_message_type,
  ]

  @type enable_key_request :: [
    key_id: key_id_type,
  ]

  @type enable_key_rotation_request :: [
    key_id: key_id_type,
  ]

  @type encrypt_request :: [
    encryption_context: encryption_context_type,
    grant_tokens: grant_token_list,
    key_id: key_id_type,
    plaintext: plaintext_type,
  ]

  @type encrypt_response :: [
    ciphertext_blob: ciphertext_type,
    key_id: key_id_type,
  ]

  @type encryption_context_key :: binary

  @type encryption_context_type :: [{encryption_context_key, encryption_context_value}]

  @type encryption_context_value :: binary

  @type error_message_type :: binary

  @type generate_data_key_request :: [
    encryption_context: encryption_context_type,
    grant_tokens: grant_token_list,
    key_id: key_id_type,
    key_spec: data_key_spec,
    number_of_bytes: number_of_bytes_type,
  ]

  @type generate_data_key_response :: [
    ciphertext_blob: ciphertext_type,
    key_id: key_id_type,
    plaintext: plaintext_type,
  ]

  @type generate_data_key_without_plaintext_request :: [
    encryption_context: encryption_context_type,
    grant_tokens: grant_token_list,
    key_id: key_id_type,
    key_spec: data_key_spec,
    number_of_bytes: number_of_bytes_type,
  ]

  @type generate_data_key_without_plaintext_response :: [
    ciphertext_blob: ciphertext_type,
    key_id: key_id_type,
  ]

  @type generate_random_request :: [
    number_of_bytes: number_of_bytes_type,
  ]

  @type generate_random_response :: [
    plaintext: plaintext_type,
  ]

  @type get_key_policy_request :: [
    key_id: key_id_type,
    policy_name: policy_name_type,
  ]

  @type get_key_policy_response :: [
    policy: policy_type,
  ]

  @type get_key_rotation_status_request :: [
    key_id: key_id_type,
  ]

  @type get_key_rotation_status_response :: [
    key_rotation_enabled: boolean_type,
  ]

  @type grant_constraints :: [
    encryption_context_equals: encryption_context_type,
    encryption_context_subset: encryption_context_type,
  ]

  @type grant_id_type :: binary

  @type grant_list :: [grant_list_entry]

  @type grant_list_entry :: [
    constraints: grant_constraints,
    grant_id: grant_id_type,
    grantee_principal: principal_id_type,
    issuing_account: principal_id_type,
    operations: grant_operation_list,
    retiring_principal: principal_id_type,
  ]

  @type grant_operation :: binary

  @type grant_operation_list :: [grant_operation]

  @type grant_token_list :: [grant_token_type]

  @type grant_token_type :: binary

  @type invalid_alias_name_exception :: [
    message: error_message_type,
  ]

  @type invalid_arn_exception :: [
    message: error_message_type,
  ]

  @type invalid_ciphertext_exception :: [
    message: error_message_type,
  ]

  @type invalid_grant_token_exception :: [
    message: error_message_type,
  ]

  @type invalid_key_usage_exception :: [
    message: error_message_type,
  ]

  @type invalid_marker_exception :: [
    message: error_message_type,
  ]

  @type kms_internal_exception :: [
    message: error_message_type,
  ]

  @type key_id_type :: binary

  @type key_list :: [key_list_entry]

  @type key_list_entry :: [
    key_arn: arn_type,
    key_id: key_id_type,
  ]

  @type key_metadata :: [
    aws_account_id: aws_account_id_type,
    arn: arn_type,
    creation_date: date_type,
    description: description_type,
    enabled: boolean_type,
    key_id: key_id_type,
    key_usage: key_usage_type,
  ]

  @type key_unavailable_exception :: [
    message: error_message_type,
  ]

  @type key_usage_type :: binary

  @type limit_exceeded_exception :: [
    message: error_message_type,
  ]

  @type limit_type :: integer

  @type list_aliases_request :: [
    limit: limit_type,
    marker: marker_type,
  ]

  @type list_aliases_response :: [
    aliases: alias_list,
    next_marker: marker_type,
    truncated: boolean_type,
  ]

  @type list_grants_request :: [
    key_id: key_id_type,
    limit: limit_type,
    marker: marker_type,
  ]

  @type list_grants_response :: [
    grants: grant_list,
    next_marker: marker_type,
    truncated: boolean_type,
  ]

  @type list_key_policies_request :: [
    key_id: key_id_type,
    limit: limit_type,
    marker: marker_type,
  ]

  @type list_key_policies_response :: [
    next_marker: marker_type,
    policy_names: policy_name_list,
    truncated: boolean_type,
  ]

  @type list_keys_request :: [
    limit: limit_type,
    marker: marker_type,
  ]

  @type list_keys_response :: [
    keys: key_list,
    next_marker: marker_type,
    truncated: boolean_type,
  ]

  @type malformed_policy_document_exception :: [
    message: error_message_type,
  ]

  @type marker_type :: binary

  @type not_found_exception :: [
    message: error_message_type,
  ]

  @type number_of_bytes_type :: integer

  @type plaintext_type :: binary

  @type policy_name_list :: [policy_name_type]

  @type policy_name_type :: binary

  @type policy_type :: binary

  @type principal_id_type :: binary

  @type put_key_policy_request :: [
    key_id: key_id_type,
    policy: policy_type,
    policy_name: policy_name_type,
  ]

  @type re_encrypt_request :: [
    ciphertext_blob: ciphertext_type,
    destination_encryption_context: encryption_context_type,
    destination_key_id: key_id_type,
    grant_tokens: grant_token_list,
    source_encryption_context: encryption_context_type,
  ]

  @type re_encrypt_response :: [
    ciphertext_blob: ciphertext_type,
    key_id: key_id_type,
    source_key_id: key_id_type,
  ]

  @type retire_grant_request :: [
    grant_id: grant_id_type,
    grant_token: grant_token_type,
    key_id: key_id_type,
  ]

  @type revoke_grant_request :: [
    grant_id: grant_id_type,
    key_id: key_id_type,
  ]

  @type unsupported_operation_exception :: [
    message: error_message_type,
  ]

  @type update_alias_request :: [
    alias_name: alias_name_type,
    target_key_id: key_id_type,
  ]

  @type update_key_description_request :: [
    description: description_type,
    key_id: key_id_type,
  ]





  @doc """
  CreateAlias

  Creates a display name for a customer master key. An alias can be used to
  identify a key and should be unique. The console enforces a one-to-one
  mapping between the alias and a key. An alias name can contain only
  alphanumeric characters, forward slashes (/), underscores (_), and dashes
  (-). An alias must start with the word "alias" followed by a forward slash
  (alias/). An alias that begins with "aws" after the forward slash
  (alias/aws...) is reserved by Amazon Web Services (AWS).

  To associate an alias with a different key, call `UpdateAlias`.

  Note that you cannot create or update an alias that represents a key in
  another account.
  """

  @spec create_alias(client :: ExAws.KMS.t, input :: create_alias_request) :: ExAws.Request.JSON.response_t
  def create_alias(client, input) do
    request(client, "CreateAlias", format_input(input))
  end

  @doc """
  Same as `create_alias/2` but raise on error.
  """
  @spec create_alias!(client :: ExAws.KMS.t, input :: create_alias_request) :: ExAws.Request.JSON.success_t | no_return
  def create_alias!(client, input) do
    case create_alias(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateGrant

  Adds a grant to a key to specify who can access the key and under what
  conditions. Grants are alternate permission mechanisms to key policies. For
  more information about grants, see
  [Grants](http://docs.aws.amazon.com/kms/latest/developerguide/grants.html)
  in the developer guide. If a grant is absent, access to the key is
  evaluated based on IAM policies attached to the user.

  - `ListGrants`

  - `RetireGrant`

  - `RevokeGrant`
  """

  @spec create_grant(client :: ExAws.KMS.t, input :: create_grant_request) :: ExAws.Request.JSON.response_t
  def create_grant(client, input) do
    request(client, "CreateGrant", format_input(input))
  end

  @doc """
  Same as `create_grant/2` but raise on error.
  """
  @spec create_grant!(client :: ExAws.KMS.t, input :: create_grant_request) :: ExAws.Request.JSON.success_t | no_return
  def create_grant!(client, input) do
    case create_grant(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateKey

  Creates a customer master key. Customer master keys can be used to encrypt
  small amounts of data (less than 4K) directly, but they are most commonly
  used to encrypt or envelope data keys that are then used to encrypt
  customer data. For more information about data keys, see `GenerateDataKey`
  and `GenerateDataKeyWithoutPlaintext`.
  """

  @spec create_key(client :: ExAws.KMS.t, input :: create_key_request) :: ExAws.Request.JSON.response_t
  def create_key(client, input) do
    request(client, "CreateKey", format_input(input))
  end

  @doc """
  Same as `create_key/2` but raise on error.
  """
  @spec create_key!(client :: ExAws.KMS.t, input :: create_key_request) :: ExAws.Request.JSON.success_t | no_return
  def create_key!(client, input) do
    case create_key(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  Decrypt

  Decrypts ciphertext. Ciphertext is plaintext that has been previously
  encrypted by using any of the following functions:

  - `GenerateDataKey`

  - `GenerateDataKeyWithoutPlaintext`

  - `Encrypt`

  Note that if a caller has been granted access permissions to all keys
  (through, for example, IAM user policies that grant `Decrypt` permission on
  all resources), then ciphertext encrypted by using keys in other accounts
  where the key grants access to the caller can be decrypted. To remedy this,
  we recommend that you do not grant `Decrypt` access in an IAM user policy.
  Instead grant `Decrypt` access only in key policies. If you must grant
  `Decrypt` access in an IAM user policy, you should scope the resource to
  specific keys or to specific trusted accounts.
  """

  @spec decrypt(client :: ExAws.KMS.t, input :: decrypt_request) :: ExAws.Request.JSON.response_t
  def decrypt(client, input) do
    request(client, "Decrypt", format_input(input))
  end

  @doc """
  Same as `decrypt/2` but raise on error.
  """
  @spec decrypt!(client :: ExAws.KMS.t, input :: decrypt_request) :: ExAws.Request.JSON.success_t | no_return
  def decrypt!(client, input) do
    case decrypt(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteAlias

  Deletes the specified alias. To associate an alias with a different key,
  call `UpdateAlias`.
  """

  @spec delete_alias(client :: ExAws.KMS.t, input :: delete_alias_request) :: ExAws.Request.JSON.response_t
  def delete_alias(client, input) do
    request(client, "DeleteAlias", format_input(input))
  end

  @doc """
  Same as `delete_alias/2` but raise on error.
  """
  @spec delete_alias!(client :: ExAws.KMS.t, input :: delete_alias_request) :: ExAws.Request.JSON.success_t | no_return
  def delete_alias!(client, input) do
    case delete_alias(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeKey

  Provides detailed information about the specified customer master key.
  """

  @spec describe_key(client :: ExAws.KMS.t, input :: describe_key_request) :: ExAws.Request.JSON.response_t
  def describe_key(client, input) do
    request(client, "DescribeKey", format_input(input))
  end

  @doc """
  Same as `describe_key/2` but raise on error.
  """
  @spec describe_key!(client :: ExAws.KMS.t, input :: describe_key_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_key!(client, input) do
    case describe_key(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DisableKey

  Marks a key as disabled, thereby preventing its use.
  """

  @spec disable_key(client :: ExAws.KMS.t, input :: disable_key_request) :: ExAws.Request.JSON.response_t
  def disable_key(client, input) do
    request(client, "DisableKey", format_input(input))
  end

  @doc """
  Same as `disable_key/2` but raise on error.
  """
  @spec disable_key!(client :: ExAws.KMS.t, input :: disable_key_request) :: ExAws.Request.JSON.success_t | no_return
  def disable_key!(client, input) do
    case disable_key(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DisableKeyRotation

  Disables rotation of the specified key.
  """

  @spec disable_key_rotation(client :: ExAws.KMS.t, input :: disable_key_rotation_request) :: ExAws.Request.JSON.response_t
  def disable_key_rotation(client, input) do
    request(client, "DisableKeyRotation", format_input(input))
  end

  @doc """
  Same as `disable_key_rotation/2` but raise on error.
  """
  @spec disable_key_rotation!(client :: ExAws.KMS.t, input :: disable_key_rotation_request) :: ExAws.Request.JSON.success_t | no_return
  def disable_key_rotation!(client, input) do
    case disable_key_rotation(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  EnableKey

  Marks a key as enabled, thereby permitting its use. You can have up to 25
  enabled keys at one time.
  """

  @spec enable_key(client :: ExAws.KMS.t, input :: enable_key_request) :: ExAws.Request.JSON.response_t
  def enable_key(client, input) do
    request(client, "EnableKey", format_input(input))
  end

  @doc """
  Same as `enable_key/2` but raise on error.
  """
  @spec enable_key!(client :: ExAws.KMS.t, input :: enable_key_request) :: ExAws.Request.JSON.success_t | no_return
  def enable_key!(client, input) do
    case enable_key(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  EnableKeyRotation

  Enables rotation of the specified customer master key.
  """

  @spec enable_key_rotation(client :: ExAws.KMS.t, input :: enable_key_rotation_request) :: ExAws.Request.JSON.response_t
  def enable_key_rotation(client, input) do
    request(client, "EnableKeyRotation", format_input(input))
  end

  @doc """
  Same as `enable_key_rotation/2` but raise on error.
  """
  @spec enable_key_rotation!(client :: ExAws.KMS.t, input :: enable_key_rotation_request) :: ExAws.Request.JSON.success_t | no_return
  def enable_key_rotation!(client, input) do
    case enable_key_rotation(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  Encrypt

  Encrypts plaintext into ciphertext by using a customer master key. The
  `Encrypt` function has two primary use cases:

  - You can encrypt up to 4 KB of arbitrary data such as an RSA key, a
  database password, or other sensitive customer information.

  - If you are moving encrypted data from one region to another, you can use
  this API to encrypt in the new region the plaintext data key that was used
  to encrypt the data in the original region. This provides you with an
  encrypted copy of the data key that can be decrypted in the new region and
  used there to decrypt the encrypted data.

  Unless you are moving encrypted data from one region to another, you don't
  use this function to encrypt a generated data key within a region. You
  retrieve data keys already encrypted by calling the `GenerateDataKey` or
  `GenerateDataKeyWithoutPlaintext` function. Data keys don't need to be
  encrypted again by calling `Encrypt`.

  If you want to encrypt data locally in your application, you can use the
  `GenerateDataKey` function to return a plaintext data encryption key and a
  copy of the key encrypted under the customer master key (CMK) of your
  choosing.
  """

  @spec encrypt(client :: ExAws.KMS.t, input :: encrypt_request) :: ExAws.Request.JSON.response_t
  def encrypt(client, input) do
    request(client, "Encrypt", format_input(input))
  end

  @doc """
  Same as `encrypt/2` but raise on error.
  """
  @spec encrypt!(client :: ExAws.KMS.t, input :: encrypt_request) :: ExAws.Request.JSON.success_t | no_return
  def encrypt!(client, input) do
    case encrypt(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GenerateDataKey

  Generates a data key that you can use in your application to locally
  encrypt data. This call returns a plaintext version of the key in the
  `Plaintext` field of the response object and an encrypted copy of the key
  in the `CiphertextBlob` field. The key is encrypted by using the master key
  specified by the `KeyId` field. To decrypt the encrypted key, pass it to
  the `Decrypt` API.

  We recommend that you use the following pattern to locally encrypt data:
  call the `GenerateDataKey` API, use the key returned in the `Plaintext`
  response field to locally encrypt data, and then erase the plaintext data
  key from memory. Store the encrypted data key (contained in the
  `CiphertextBlob` field) alongside of the locally encrypted data.

  Note:You should not call the `Encrypt` function to re-encrypt your data
  keys within a region. `GenerateDataKey` always returns the data key
  encrypted and tied to the customer master key that will be used to decrypt
  it. There is no need to decrypt it twice. If you decide to use the optional
  `EncryptionContext` parameter, you must also store the context in full or
  at least store enough information along with the encrypted data to be able
  to reconstruct the context when submitting the ciphertext to the `Decrypt`
  API. It is a good practice to choose a context that you can reconstruct on
  the fly to better secure the ciphertext. For more information about how
  this parameter is used, see [Encryption
  Context](http://docs.aws.amazon.com/kms/latest/developerguide/encrypt-context.html).

  To decrypt data, pass the encrypted data key to the `Decrypt` API.
  `Decrypt` uses the associated master key to decrypt the encrypted data key
  and returns it as plaintext. Use the plaintext data key to locally decrypt
  your data and then erase the key from memory. You must specify the
  encryption context, if any, that you specified when you generated the key.
  The encryption context is logged by CloudTrail, and you can use this log to
  help track the use of particular data.
  """

  @spec generate_data_key(client :: ExAws.KMS.t, input :: generate_data_key_request) :: ExAws.Request.JSON.response_t
  def generate_data_key(client, input) do
    request(client, "GenerateDataKey", format_input(input))
  end

  @doc """
  Same as `generate_data_key/2` but raise on error.
  """
  @spec generate_data_key!(client :: ExAws.KMS.t, input :: generate_data_key_request) :: ExAws.Request.JSON.success_t | no_return
  def generate_data_key!(client, input) do
    case generate_data_key(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GenerateDataKeyWithoutPlaintext

  Returns a data key encrypted by a customer master key without the plaintext
  copy of that key. Otherwise, this API functions exactly like
  `GenerateDataKey`. You can use this API to, for example, satisfy an audit
  requirement that an encrypted key be made available without exposing the
  plaintext copy of that key.
  """

  @spec generate_data_key_without_plaintext(client :: ExAws.KMS.t, input :: generate_data_key_without_plaintext_request) :: ExAws.Request.JSON.response_t
  def generate_data_key_without_plaintext(client, input) do
    request(client, "GenerateDataKeyWithoutPlaintext", format_input(input))
  end

  @doc """
  Same as `generate_data_key_without_plaintext/2` but raise on error.
  """
  @spec generate_data_key_without_plaintext!(client :: ExAws.KMS.t, input :: generate_data_key_without_plaintext_request) :: ExAws.Request.JSON.success_t | no_return
  def generate_data_key_without_plaintext!(client, input) do
    case generate_data_key_without_plaintext(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GenerateRandom

  Generates an unpredictable byte string.
  """

  @spec generate_random(client :: ExAws.KMS.t, input :: generate_random_request) :: ExAws.Request.JSON.response_t
  def generate_random(client, input) do
    request(client, "GenerateRandom", format_input(input))
  end

  @doc """
  Same as `generate_random/2` but raise on error.
  """
  @spec generate_random!(client :: ExAws.KMS.t, input :: generate_random_request) :: ExAws.Request.JSON.success_t | no_return
  def generate_random!(client, input) do
    case generate_random(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetKeyPolicy

  Retrieves a policy attached to the specified key.
  """

  @spec get_key_policy(client :: ExAws.KMS.t, input :: get_key_policy_request) :: ExAws.Request.JSON.response_t
  def get_key_policy(client, input) do
    request(client, "GetKeyPolicy", format_input(input))
  end

  @doc """
  Same as `get_key_policy/2` but raise on error.
  """
  @spec get_key_policy!(client :: ExAws.KMS.t, input :: get_key_policy_request) :: ExAws.Request.JSON.success_t | no_return
  def get_key_policy!(client, input) do
    case get_key_policy(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetKeyRotationStatus

  Retrieves a Boolean value that indicates whether key rotation is enabled
  for the specified key.
  """

  @spec get_key_rotation_status(client :: ExAws.KMS.t, input :: get_key_rotation_status_request) :: ExAws.Request.JSON.response_t
  def get_key_rotation_status(client, input) do
    request(client, "GetKeyRotationStatus", format_input(input))
  end

  @doc """
  Same as `get_key_rotation_status/2` but raise on error.
  """
  @spec get_key_rotation_status!(client :: ExAws.KMS.t, input :: get_key_rotation_status_request) :: ExAws.Request.JSON.success_t | no_return
  def get_key_rotation_status!(client, input) do
    case get_key_rotation_status(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListAliases

  Lists all of the key aliases in the account.
  """

  @spec list_aliases(client :: ExAws.KMS.t, input :: list_aliases_request) :: ExAws.Request.JSON.response_t
  def list_aliases(client, input) do
    request(client, "ListAliases", format_input(input))
  end

  @doc """
  Same as `list_aliases/2` but raise on error.
  """
  @spec list_aliases!(client :: ExAws.KMS.t, input :: list_aliases_request) :: ExAws.Request.JSON.success_t | no_return
  def list_aliases!(client, input) do
    case list_aliases(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListGrants

  List the grants for a specified key.
  """

  @spec list_grants(client :: ExAws.KMS.t, input :: list_grants_request) :: ExAws.Request.JSON.response_t
  def list_grants(client, input) do
    request(client, "ListGrants", format_input(input))
  end

  @doc """
  Same as `list_grants/2` but raise on error.
  """
  @spec list_grants!(client :: ExAws.KMS.t, input :: list_grants_request) :: ExAws.Request.JSON.success_t | no_return
  def list_grants!(client, input) do
    case list_grants(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListKeyPolicies

  Retrieves a list of policies attached to a key.
  """

  @spec list_key_policies(client :: ExAws.KMS.t, input :: list_key_policies_request) :: ExAws.Request.JSON.response_t
  def list_key_policies(client, input) do
    request(client, "ListKeyPolicies", format_input(input))
  end

  @doc """
  Same as `list_key_policies/2` but raise on error.
  """
  @spec list_key_policies!(client :: ExAws.KMS.t, input :: list_key_policies_request) :: ExAws.Request.JSON.success_t | no_return
  def list_key_policies!(client, input) do
    case list_key_policies(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListKeys

  Lists the customer master keys.
  """

  @spec list_keys(client :: ExAws.KMS.t, input :: list_keys_request) :: ExAws.Request.JSON.response_t
  def list_keys(client, input) do
    request(client, "ListKeys", format_input(input))
  end

  @doc """
  Same as `list_keys/2` but raise on error.
  """
  @spec list_keys!(client :: ExAws.KMS.t, input :: list_keys_request) :: ExAws.Request.JSON.success_t | no_return
  def list_keys!(client, input) do
    case list_keys(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  PutKeyPolicy

  Attaches a policy to the specified key.
  """

  @spec put_key_policy(client :: ExAws.KMS.t, input :: put_key_policy_request) :: ExAws.Request.JSON.response_t
  def put_key_policy(client, input) do
    request(client, "PutKeyPolicy", format_input(input))
  end

  @doc """
  Same as `put_key_policy/2` but raise on error.
  """
  @spec put_key_policy!(client :: ExAws.KMS.t, input :: put_key_policy_request) :: ExAws.Request.JSON.success_t | no_return
  def put_key_policy!(client, input) do
    case put_key_policy(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ReEncrypt

  Encrypts data on the server side with a new customer master key without
  exposing the plaintext of the data on the client side. The data is first
  decrypted and then encrypted. This operation can also be used to change the
  encryption context of a ciphertext.

  Unlike other actions, `ReEncrypt` is authorized twice - once as
  `ReEncryptFrom` on the source key and once as `ReEncryptTo` on the
  destination key. We therefore recommend that you include the
  `"action":"kms:ReEncrypt*"` statement in your key policies to permit
  re-encryption from or to the key. The statement is included automatically
  when you authorize use of the key through the console but must be included
  manually when you set a policy by using the `PutKeyPolicy` function.
  """

  @spec re_encrypt(client :: ExAws.KMS.t, input :: re_encrypt_request) :: ExAws.Request.JSON.response_t
  def re_encrypt(client, input) do
    request(client, "ReEncrypt", format_input(input))
  end

  @doc """
  Same as `re_encrypt/2` but raise on error.
  """
  @spec re_encrypt!(client :: ExAws.KMS.t, input :: re_encrypt_request) :: ExAws.Request.JSON.success_t | no_return
  def re_encrypt!(client, input) do
    case re_encrypt(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RetireGrant

  Retires a grant. You can retire a grant when you're done using it to clean
  up. You should revoke a grant when you intend to actively deny operations
  that depend on it. The following are permitted to call this API:

  - The account that created the grant

  - The `RetiringPrincipal`, if present

  - The `GranteePrincipal`, if `RetireGrant` is a grantee operation

  The grant to retire must be identified by its grant token or by a
  combination of the key ARN and the grant ID. A grant token is a unique
  variable-length base64-encoded string. A grant ID is a 64 character unique
  identifier of a grant. Both are returned by the `CreateGrant` function.
  """

  @spec retire_grant(client :: ExAws.KMS.t, input :: retire_grant_request) :: ExAws.Request.JSON.response_t
  def retire_grant(client, input) do
    request(client, "RetireGrant", format_input(input))
  end

  @doc """
  Same as `retire_grant/2` but raise on error.
  """
  @spec retire_grant!(client :: ExAws.KMS.t, input :: retire_grant_request) :: ExAws.Request.JSON.success_t | no_return
  def retire_grant!(client, input) do
    case retire_grant(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RevokeGrant

  Revokes a grant. You can revoke a grant to actively deny operations that
  depend on it.
  """

  @spec revoke_grant(client :: ExAws.KMS.t, input :: revoke_grant_request) :: ExAws.Request.JSON.response_t
  def revoke_grant(client, input) do
    request(client, "RevokeGrant", format_input(input))
  end

  @doc """
  Same as `revoke_grant/2` but raise on error.
  """
  @spec revoke_grant!(client :: ExAws.KMS.t, input :: revoke_grant_request) :: ExAws.Request.JSON.success_t | no_return
  def revoke_grant!(client, input) do
    case revoke_grant(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateAlias

  Updates an alias to associate it with a different key.

  An alias name can contain only alphanumeric characters, forward slashes
  (/), underscores (_), and dashes (-). An alias must start with the word
  "alias" followed by a forward slash (alias/). An alias that begins with
  "aws" after the forward slash (alias/aws...) is reserved by Amazon Web
  Services (AWS).

  An alias is not a property of a key. Therefore, an alias can be associated
  with and disassociated from an existing key without changing the properties
  of the key.

  Note that you cannot create or update an alias that represents a key in
  another account.
  """

  @spec update_alias(client :: ExAws.KMS.t, input :: update_alias_request) :: ExAws.Request.JSON.response_t
  def update_alias(client, input) do
    request(client, "UpdateAlias", format_input(input))
  end

  @doc """
  Same as `update_alias/2` but raise on error.
  """
  @spec update_alias!(client :: ExAws.KMS.t, input :: update_alias_request) :: ExAws.Request.JSON.success_t | no_return
  def update_alias!(client, input) do
    case update_alias(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateKeyDescription

  Updates the description of a key.
  """

  @spec update_key_description(client :: ExAws.KMS.t, input :: update_key_description_request) :: ExAws.Request.JSON.response_t
  def update_key_description(client, input) do
    request(client, "UpdateKeyDescription", format_input(input))
  end

  @doc """
  Same as `update_key_description/2` but raise on error.
  """
  @spec update_key_description!(client :: ExAws.KMS.t, input :: update_key_description_request) :: ExAws.Request.JSON.success_t | no_return
  def update_key_description!(client, input) do
    case update_key_description(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  defp request(%{__struct__: client_module} = client, action, input) do
    apply(client_module, :request, [client, action, input])
  end
end
