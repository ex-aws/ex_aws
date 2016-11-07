defmodule ExAws.KMS do
  @moduledoc """
  Operations on AWS KMS
  """

  import ExAws.Utils

  @version "2014-11-01"

  @doc "Canel a key deletion"
  @spec cancel_key_deletion(key_id :: binary) :: ExAws.Operation.JSON.t
  def cancel_key_deletion(key_id) do
    query_params = %{
      "Action"  => "CancelKeyDeletion",
      "Version" => @version,
      "KeyId"   => key_id}

    request(:cancel_key_deletion, query_params)
  end

  @doc "Create a alias"
  @spec create_alias(alias_name :: binary, target_key_id :: binary) :: ExAws.Operation.JSON.t
  def create_alias(alias_name, target_key_id) do
    query_params = %{
      "Action"      => "CreateAlias",
      "Version"     => @version,
      "AliasName"   => alias_name,
      "TargetKeyId" => target_key_id}

    request(:create_alias, query_params)
  end

  @doc "Adds a grant to a key"
  @spec create_grant(grantee_principal :: binary, key_id :: binary) :: ExAws.Operation.JSON.t
  @spec create_grant(grantee_principal :: binary, key_id :: binary, opts :: Keyword.t) :: ExAws.Operation.JSON.t
  def create_grant(grantee_principal, key_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"           => "CreateGrant",
          "Version"          => @version,
          "GranteePrincipal" => grantee_principal,
          "KeyId"            => key_id})

    request(:create_grant, query_params)
  end

  @doc "Creates a customer master key (CMK)"
  @spec create_key() :: ExAws.Operation.JSON.t
  @spec create_key(opts :: Keyword.t) :: ExAws.Operation.JSON.t
  def create_key(opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"  => "CreateKey",
          "Version" => @version})

    request(:create_key, query_params)
  end

  @doc "Decrypts ciphertext"
  @spec decrypt(ciphertext :: binary) :: ExAws.Operation.JSON.t
  @spec decrypt(ciphertext :: binary, opts :: Keyword.t) :: ExAws.Operation.JSON.t
  def decrypt(ciphertext, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"  => "Decrypt",
          "Version" => @version,
          "CiphertextBlob"   => ciphertext,
                 })

    request(:decrypt, query_params)
  end

  @doc "Delete a alias"
  @spec delete_alias(alias_name :: binary) :: ExAws.Operation.JSON.t
  def delete_alias(alias_name) do
    query_params = %{
      "Action"    => "DeleteAlias",
      "Version"   => @version,
      "AliasName" => alias_name}

    request(:delete_alias, query_params)
  end

  @doc "Delete a imported key material"
  @spec delete_imported_key_material(key_id :: binary) :: ExAws.Operation.JSON.t
  def delete_imported_key_material(key_id) do
    query_params = %{
      "Action"  => "DeleteImportedKeyMaterial",
      "Version" => @version,
      "KeyId"   => key_id}

    request(:delete_imported_key_material, query_params)
  end

  @doc "Describe a key"
  @type describe_key_opts :: [
    {:grant_tokens, list(binary)}
  ]
  @spec describe_key(key_id :: binary) :: ExAws.Operation.JSON.t
  @spec describe_key(key_id :: binary, opts :: describe_key_opts) :: ExAws.Operation.JSON.t
  def describe_key(key_id, opts \\[]) when is_list(opts) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"  => "DescribeKey",
          "Version" => @version,
          "KeyId"   => key_id})

    request(:describe_key, query_params)
  end

  @doc "Disable a key"
  @type disable_key_opts :: [
    {:grant_tokens, list(binary)}
  ]
  @spec disable_key(key_id :: binary) :: ExAws.Operation.JSON.t
  @spec disable_key(key_id :: binary, opts :: disable_key_opts) :: ExAws.Operation.JSON.t
  def disable_key(key_id, opts \\[]) when is_list(opts) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"  => "DisableKey",
          "Version" => @version,
          "KeyId"   => key_id})

    request(:disable_key, query_params)
  end

  @doc "Disable a key rotation"
  @spec disable_key_rotation(key_id :: binary) :: ExAws.Operation.JSON.t
  def disable_key_rotation(key_id) do
    query_params = %{
      "Action"  => "DisableKeyRotation",
      "Version" => @version,
      "KeyId"   => key_id}

    request(:disable_key_rotation, query_params)
  end

  @doc "Enable a key"
  @spec enable_key(key_id :: binary) :: ExAws.Operation.JSON.t
  def enable_key(key_id) do
    query_params = %{
      "Action"  => "EnableKey",
      "Version" => @version,
      "KeyId"   => key_id}

    request(:enable_key, query_params)
  end

  @doc "Enable a key rotation"
  @spec enable_key_rotation(key_id :: binary) :: ExAws.Operation.JSON.t
  def enable_key_rotation(key_id) do
    query_params = %{
      "Action"  => "EnableKeyRotation",
      "Version" => @version,
      "KeyId"   => key_id}

    request(:enable_key_rotation, query_params)
  end

  @doc "Encrypt a data by a key"
  @type encrypt_opts :: [
    {:encryption_context, map} |
    {:grant_tokens, list(binary)}
  ]
  @spec encrypt(key_id :: binary, plaintext :: binary) :: ExAws.Operation.JSON.t
  @spec encrypt(key_id :: binary, plaintext :: binary, opts :: encrypt_opts) :: ExAws.Operation.JSON.t
  def encrypt(key_id, plaintext, opts \\[]) when is_list(opts) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"    => "Encrypt",
          "Version"   => @version,
          "KeyId"     => key_id,
          "Plaintext" => plaintext})

    request(:encrypt, query_params)
  end

  @doc "Generate a data key"
  @type generate_data_key_opts :: [
    {:encryption_context, map} |
    {:grant_tokens, list(binary)} |
    {:key_spec, binary} |
    {:number_of_bytes, pos_integer}
  ]
  @spec generate_data_key(key_id :: binary) :: ExAws.Operation.JSON.t
  @spec generate_data_key(key_id :: binary, opts :: generate_data_key_opts) :: ExAws.Operation.JSON.t
  def generate_data_key(key_id, opts \\[]) when is_list(opts) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"  => "GenerateDataKey",
          "Version" => @version,
          "KeyId"   => key_id,
          "KeySpec" => opts[:key_spec] || "AES_256"})

    request(:generate_data_key, query_params)
  end

  @doc "Generate a data key without plaintext"
  @type generate_data_key_without_plaintext_opts :: [
    {:encryption_context, map} |
    {:grant_tokens, list(binary)} |
    {:key_spec, binary} |
    {:number_of_bytes, pos_integer}
  ]
  @spec generate_data_key_without_plaintext(key_id :: binary) :: ExAws.Operation.JSON.t
  @spec generate_data_key_without_plaintext(key_id :: binary, opts :: generate_data_key_without_plaintext_opts) :: ExAws.Operation.JSON.t
  def generate_data_key_without_plaintext(key_id, opts \\[]) when is_list(opts) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"  => "GenerateDataKeyWithoutPlaintext",
          "Version" => @version,
          "KeyId"   => key_id,
          "KeySpec" => opts[:key_spec] || "AES_256"})

    request(:generate_data_key_without_plaintext, query_params)
  end

  @doc "Generates an unpredictable byte string"
  @spec generate_random(number_of_bytes :: pos_integer) :: ExAws.Operation.JSON.t
  def generate_random(number_of_bytes) when is_integer(number_of_bytes) do
    query_params = %{
      "Action"        => "GenerateRandom",
      "Version"       => @version,
      "NumberOfBytes" => number_of_bytes}

    request(:generate_random, query_params)
  end

  @doc "Retrieves a policy attached to the specified key"
  @spec get_key_policy(key_id :: binary, policy_name :: binary) :: ExAws.Operation.JSON.t
  def get_key_policy(key_id, policy_name) when is_binary(key_id) and is_binary(policy_name) do
    query_params = %{
      "Action"     => "GetKeyPolicy",
      "Version"    => @version,
      "KeyId"      => key_id,
      "PolicyName" => policy_name}

    request(:get_key_policy, query_params)
  end

  @doc "Indicates whether key rotation is enabled for the specified key"
  @spec get_key_rotation_status(key_id :: binary) :: ExAws.Operation.JSON.t
  def get_key_rotation_status(key_id) when is_binary(key_id) do
    query_params = %{
      "Action"  => "GetKeyRotationStatus",
      "Version" => @version,
      "KeyId"   => key_id}

    request(:get_key_rotation_status, query_params)
  end

  @doc "Import key matrial"
  @spec get_parameters_for_import(key_id :: binary) :: ExAws.Operation.JSON.t
  @spec get_parameters_for_import(key_id :: binary, wrapping_algorithm :: binary) :: ExAws.Operation.JSON.t
  @spec get_parameters_for_import(key_id :: binary, wrapping_algorithm :: binary, wrapping_key_spec :: binary) :: ExAws.Operation.JSON.t
  def get_parameters_for_import(key_id, wrapping_algorithm \\ "RSAES_PKCS1_V1_5", wrapping_key_spec \\ "RSA_2048") do
    query_params = %{
      "Action"            => "GetParametersForImport",
      "Version"           => @version,
      "KeyId"             => key_id,
      "WrappingAlgorithm" => wrapping_algorithm,
      "WrappingKeySpec"   => wrapping_key_spec}

    request(:get_parameters_for_import, query_params)
  end

  @doc "Imports key material into an AWS KMS customer master key (CMK)"
  @type import_key_material_opts :: [
    {:expiration_model, binary} |
    {:valid_to, binary}
  ]
  @spec import_key_material(encrypted_key_material :: binary, import_token :: binary, key_id :: binary) :: ExAws.Operation.JSON.t
  @spec import_key_material(encrypted_key_material :: binary, import_token :: binary, key_id :: binary, opts :: import_key_material_opts) :: ExAws.Operation.JSON.t
  def import_key_material(encrypted_key_material, import_token, key_id, opts \\ []) when is_list(opts) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"               => "ImportKeyMaterial",
          "Version"              => @version,
          "EncryptedKeyMaterial" => encrypted_key_material,
          "ImportToken"          => import_token,
          "KeyId"                => key_id})

    request(:import_key_material, query_params)
  end

  @doc "Lists all of the key aliases"
  @type list_aliases_opts :: [
    {:limit, integer} |
    {:marker, binary}
  ]
  @spec list_aliases() :: ExAws.Operation.JSON.t
  @spec list_aliases(opts :: list_aliases_opts) :: ExAws.Operation.JSON.t
  def list_aliases(opts \\ []) when is_list(opts) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"  => "ListAliases",
          "Version" => @version
                 })

    request(:list_aliases, query_params)
  end

  @doc "List the grants for a specified key"
  @type list_grants_opts :: [
    {:limit, integer} |
    {:marker, binary}
  ]
  @spec list_grants(key_id :: binary) :: ExAws.Operation.JSON.t
  @spec list_grants(key_id :: binary, opts :: list_grants_opts) :: ExAws.Operation.JSON.t
  def list_grants(key_id, opts \\[]) when is_list(opts) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"  => "ListGrants",
          "Version" => @version,
          "KeyId"   => key_id})

    request(:list_grants, query_params)
  end

  @doc "Retrieves a list of policies attached to a key"
  @type list_key_policies_opts :: [
    {:limit, integer} |
    {:marker, binary}
  ]
  @spec list_key_policies(key_id :: binary) :: ExAws.Operation.JSON.t
  @spec list_key_policies(key_id :: binary, opts :: list_key_policies_opts) :: ExAws.Operation.JSON.t
  def list_key_policies(key_id, opts \\[]) when is_list(opts) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"  => "ListKeyPolicies",
          "Version" => @version,
          "KeyId"   => key_id})

    request(:list_key_policies, query_params)
  end

  @doc "Lists the customer master keys"
  @type list_keys_opts :: [
    {:limit, integer} |
    {:marker, binary}
  ]
  @spec list_keys() :: ExAws.Operation.JSON.t
  @spec list_keys(opts :: list_keys_opts) :: ExAws.Operation.JSON.t
  def list_keys(opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"  => "ListKeys",
          "Version" => @version
                 })

    request(:list_keys, query_params)
  end

  @doc "A list of all grants for which the grant's RetiringPrincipal matches the one specified"
  @type list_retirable_grants_opts :: [
    {:limit, integer} |
    {:marker, binary}
  ]
  @spec list_retirable_grants(retiring_principal :: binary) :: ExAws.Operation.JSON.t
  @spec list_retirable_grants(retiring_principal :: binary, opts :: list_retirable_grants_opts) :: ExAws.Operation.JSON.t
  def list_retirable_grants(retiring_principal, opts \\ []) when is_list(opts) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"            => "ListRetirableGrants",
          "Version"           => @version,
          "RetiringPrincipal" => retiring_principal})

    request(:list_retirable_grants, query_params)
  end

  @doc "Attaches a key policy to the specified customer master key (CMK)"
  @spec put_key_policy(key_id :: binary, policy :: binary, policy_name :: binary) :: ExAws.Operation.JSON.t
  @spec put_key_policy(key_id :: binary, policy :: binary, policy_name :: binary, bypass_policy_lockout_safety_check :: boolean) :: ExAws.Operation.JSON.t
  def put_key_policy(key_id, policy, policy_name, bypass_policy_lockout_safety_check \\ false) do
    query_params = %{
      "Action"                         => "PutKeyPolicy",
      "Version"                        => @version,
      "BypassPolicyLockoutSafetyCheck" => bypass_policy_lockout_safety_check,
      "KeyId"                          => key_id,
      "Policy"                         => policy,
      "PolicyName"                     => policy_name}

    request(:put_key_policy, query_params)
  end

  @doc "Encrypts data with a new CMK without exposing the plaintext of the data"
  @type re_encrypt_opts :: [
    {:destination_encryption_context, map} |
    {:grant_tokens, list(binary)} |
    {:source_encryption_context, map}
  ]
  @spec re_encrypt(ciphertext :: binary, describe_key :: binary) :: ExAws.Operation.JSON.t
  @spec re_encrypt(ciphertext :: binary, describe_key :: binary, opts :: re_encrypt_opts) :: ExAws.Operation.JSON.t
  def re_encrypt(ciphertext, destination_key_id, opts \\ []) when is_list(opts) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"  => "ReEncrypt",
          "Version" => @version,
          "CiphertextBlob" => ciphertext,
          "DestinationKeyId" => destination_key_id})

    request(:re_encrypt, query_params)
  end

  @doc "Retires a grant"
  @type retire_grant_opts :: [
    {:grant_id, binary} |
    {:grant_token, binary} |
    {:key_id, binary}
  ]
  @spec retire_grant(opts :: retire_grant_opts) :: ExAws.Operation.JSON.t
  def retire_grant(opts) when is_list(opts) do
    opts
    |> normalize_opts
    |> _retire_grant
  end

  @doc "Retires a grant"
  @spec retire_grant(grant_token :: binary) :: ExAws.Operation.JSON.t
  def retire_grant(grant_token) when is_binary(grant_token) do
    query_params = %{}
    |> Map.merge(%{
          "GrantToken" => grant_token})

    _retire_grant(query_params)
  end

  @doc "Retires a grant"
  @spec retire_grant(grant_id :: binary, key_id :: binary) :: ExAws.Operation.JSON.t
  def retire_grant(grant_id, key_id) do
    query_params = %{}
    |> Map.merge(%{
          "GrantId" => grant_id,
          "KeyId"   => key_id})

    _retire_grant(query_params)
  end

  defp _retire_grant(opts) do
    query_params = opts
    |> Map.merge(%{
          "Action"  => "RetireGrant",
          "Version" => @version})

    request(:retire_grant, query_params)
  end

  @doc "Revokes a grant"
  @spec revoke_grant(grant_id :: binary, key_id :: binary) :: ExAws.Operation.JSON.t
  def revoke_grant(grant_id, key_id) when is_binary(grant_id) and is_binary(key_id) do
    query_params = %{
      "Action"  => "RevokeGrant",
      "Version" => @version,
      "GrantId" => grant_id,
      "KeyId"   => key_id}

    request(:revoke_grant, query_params)
  end

  @doc "Schedules the deletion of CMK"
  @spec schedule_key_deletion(key_id :: binary) :: ExAws.Operation.JSON.t
  @spec schedule_key_deletion(key_id :: binary, pending_windows_in_days :: integer) :: ExAws.Operation.JSON.t
  def schedule_key_deletion(key_id, pending_windows_in_days \\ 30) when pending_windows_in_days > 0 and pending_windows_in_days <= 256 do
    query_params = %{
      "Action"  => "ScheduleKeyDeletion",
      "Version" => @version,
      "KeyId"   => key_id,
      "PendingWindowInDays" => pending_windows_in_days}

    request(:schedule_key_deletion, query_params)
  end

  @doc "Updates an alias to map it to a different key"
  @spec update_alias(alias_name :: binary, target_key_id :: binary) :: ExAws.Operation.JSON.t
  def update_alias(alias_name, target_key_id) when is_binary(alias_name) and is_binary(target_key_id) do
    query_params = %{
      "Action"      => "UpdateAlias",
      "Version"     => @version,
      "AliasName"   => alias_name,
      "TargetKeyId" => target_key_id}

    request(:update_alias, query_params)
  end

  @doc "Updates the description of a key"
  @spec update_key_description(description :: binary, key_id :: binary) :: ExAws.Operation.JSON.t
  def update_key_description(description, key_id) when is_binary(description) and is_binary(key_id) do
    query_params = %{
      "Action"  => "UpdateKeyDescription",
      "Version" => @version,
      "Description" => description,
      "KeyId" => key_id}

    request(:update_key_description, query_params)
  end

  ########################
  ### Helper Functions ###
  ########################

  defp request(action, params, opts \\ %{}) do
    operation =
      action
      |> Atom.to_string
      |> Macro.camelize

    ExAws.Operation.JSON.new(:kms, %{
          data: params,
          headers: [
            {"x-amz-target", "TrentService.#{operation}"},
            {"content-type", "application/x-amz-json-1.0"},
          ]
    } |> Map.merge(opts))
  end

  defp normalize_opts(opts) do
    opts
    |> Enum.into(%{})
    |> camelize_keys
  end
end
