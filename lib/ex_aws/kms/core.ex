defmodule ExAws.KMS.Core do
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
  def create_alias(client, input) do
    request(client, "CreateAlias", input)
  end

  @doc """
  CreateGrant

  Adds a grant to a key to specify who can access the key and under what
  conditions. Grants are alternate permission mechanisms to key policies. For
  more information about grants, see
  [Grants](http://docs.aws.amazon.com/kms/latest/developerguide/grants.html)
  in the developer guide. If a grant is absent, access to the key is
  evaluated based on IAM policies attached to the user. <ol>
  <li>`ListGrants`</li> <li>`RetireGrant`</li> <li>`RevokeGrant`</li> </ol>
  """
  def create_grant(client, input) do
    request(client, "CreateGrant", input)
  end

  @doc """
  CreateKey

  Creates a customer master key. Customer master keys can be used to encrypt
  small amounts of data (less than 4K) directly, but they are most commonly
  used to encrypt or envelope data keys that are then used to encrypt
  customer data. For more information about data keys, see `GenerateDataKey`
  and `GenerateDataKeyWithoutPlaintext`.
  """
  def create_key(client, input) do
    request(client, "CreateKey", input)
  end

  @doc """
  Decrypt

  Decrypts ciphertext. Ciphertext is plaintext that has been previously
  encrypted by using any of the following functions: <ul>
  <li>`GenerateDataKey`</li> <li>`GenerateDataKeyWithoutPlaintext`</li>
  <li>`Encrypt`</li> </ul>

  Note that if a caller has been granted access permissions to all keys
  (through, for example, IAM user policies that grant `Decrypt` permission on
  all resources), then ciphertext encrypted by using keys in other accounts
  where the key grants access to the caller can be decrypted. To remedy this,
  we recommend that you do not grant `Decrypt` access in an IAM user policy.
  Instead grant `Decrypt` access only in key policies. If you must grant
  `Decrypt` access in an IAM user policy, you should scope the resource to
  specific keys or to specific trusted accounts.
  """
  def decrypt(client, input) do
    request(client, "Decrypt", input)
  end

  @doc """
  DeleteAlias

  Deletes the specified alias. To associate an alias with a different key,
  call `UpdateAlias`.
  """
  def delete_alias(client, input) do
    request(client, "DeleteAlias", input)
  end

  @doc """
  DescribeKey

  Provides detailed information about the specified customer master key.
  """
  def describe_key(client, input) do
    request(client, "DescribeKey", input)
  end

  @doc """
  DisableKey

  Marks a key as disabled, thereby preventing its use.
  """
  def disable_key(client, input) do
    request(client, "DisableKey", input)
  end

  @doc """
  DisableKeyRotation

  Disables rotation of the specified key.
  """
  def disable_key_rotation(client, input) do
    request(client, "DisableKeyRotation", input)
  end

  @doc """
  EnableKey

  Marks a key as enabled, thereby permitting its use. You can have up to 25
  enabled keys at one time.
  """
  def enable_key(client, input) do
    request(client, "EnableKey", input)
  end

  @doc """
  EnableKeyRotation

  Enables rotation of the specified customer master key.
  """
  def enable_key_rotation(client, input) do
    request(client, "EnableKeyRotation", input)
  end

  @doc """
  Encrypt

  Encrypts plaintext into ciphertext by using a customer master key. The
  `Encrypt` function has two primary use cases: <ul> <li>You can encrypt up
  to 4 KB of arbitrary data such as an RSA key, a database password, or other
  sensitive customer information.</li> <li>If you are moving encrypted data
  from one region to another, you can use this API to encrypt in the new
  region the plaintext data key that was used to encrypt the data in the
  original region. This provides you with an encrypted copy of the data key
  that can be decrypted in the new region and used there to decrypt the
  encrypted data. </li> </ul>

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
  def encrypt(client, input) do
    request(client, "Encrypt", input)
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
  def generate_data_key(client, input) do
    request(client, "GenerateDataKey", input)
  end

  @doc """
  GenerateDataKeyWithoutPlaintext

  Returns a data key encrypted by a customer master key without the plaintext
  copy of that key. Otherwise, this API functions exactly like
  `GenerateDataKey`. You can use this API to, for example, satisfy an audit
  requirement that an encrypted key be made available without exposing the
  plaintext copy of that key.
  """
  def generate_data_key_without_plaintext(client, input) do
    request(client, "GenerateDataKeyWithoutPlaintext", input)
  end

  @doc """
  GenerateRandom

  Generates an unpredictable byte string.
  """
  def generate_random(client, input) do
    request(client, "GenerateRandom", input)
  end

  @doc """
  GetKeyPolicy

  Retrieves a policy attached to the specified key.
  """
  def get_key_policy(client, input) do
    request(client, "GetKeyPolicy", input)
  end

  @doc """
  GetKeyRotationStatus

  Retrieves a Boolean value that indicates whether key rotation is enabled
  for the specified key.
  """
  def get_key_rotation_status(client, input) do
    request(client, "GetKeyRotationStatus", input)
  end

  @doc """
  ListAliases

  Lists all of the key aliases in the account.
  """
  def list_aliases(client, input) do
    request(client, "ListAliases", input)
  end

  @doc """
  ListGrants

  List the grants for a specified key.
  """
  def list_grants(client, input) do
    request(client, "ListGrants", input)
  end

  @doc """
  ListKeyPolicies

  Retrieves a list of policies attached to a key.
  """
  def list_key_policies(client, input) do
    request(client, "ListKeyPolicies", input)
  end

  @doc """
  ListKeys

  Lists the customer master keys.
  """
  def list_keys(client, input) do
    request(client, "ListKeys", input)
  end

  @doc """
  PutKeyPolicy

  Attaches a policy to the specified key.
  """
  def put_key_policy(client, input) do
    request(client, "PutKeyPolicy", input)
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
  def re_encrypt(client, input) do
    request(client, "ReEncrypt", input)
  end

  @doc """
  RetireGrant

  Retires a grant. You can retire a grant when you're done using it to clean
  up. You should revoke a grant when you intend to actively deny operations
  that depend on it. The following are permitted to call this API: <ul>
  <li>The account that created the grant</li> <li>The `RetiringPrincipal`, if
  present</li> <li>The `GranteePrincipal`, if `RetireGrant` is a grantee
  operation</li> </ul> The grant to retire must be identified by its grant
  token or by a combination of the key ARN and the grant ID. A grant token is
  a unique variable-length base64-encoded string. A grant ID is a 64
  character unique identifier of a grant. Both are returned by the
  `CreateGrant` function.
  """
  def retire_grant(client, input) do
    request(client, "RetireGrant", input)
  end

  @doc """
  RevokeGrant

  Revokes a grant. You can revoke a grant to actively deny operations that
  depend on it.
  """
  def revoke_grant(client, input) do
    request(client, "RevokeGrant", input)
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
  def update_alias(client, input) do
    request(client, "UpdateAlias", input)
  end

  @doc """
  UpdateKeyDescription

  Updates the description of a key.
  """
  def update_key_description(client, input) do
    request(client, "UpdateKeyDescription", input)
  end


  defp request(%{__struct__: client_module} = client, action, input) do
    client_module.request(client, action, input)
  end
end
