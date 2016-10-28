defmodule ExAws.KMS do
  @moduledoc """
  Operations on AWS KMS
  """

  import ExAws.Utils

  @version "2014-11-01"

  def cancel_key_deletion(key_id, opts \\[]) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"  => "CancelKeyDeletion",
          "Version" => @version,
          "KeyId"   => key_id})

    request(:cancel_key_deletion, query_params)
  end

  def create_alias(alias_name, target_key_id, opts \\[]) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"      => "CreateAlias",
          "Version"     => @version,
          "AliasName"   => alias_name,
          "TargetKeyId" => target_key_id})

    request(:create_alias, query_params)
  end

  def delete_alias(alias_name, opts \\[]) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"    => "DeleteAlias",
          "Version"   => @version,
          "AliasName" => alias_name})

    request(:delete_alias, query_params)
  end

  def describe_key(key_id, opts \\[]) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"  => "DescribeKey",
          "Version" => @version,
          "KeyId"   => key_id})

    request(:describe_key, query_params)
  end

  def disable_key(key_id, opts \\[]) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"  => "DisableKey",
          "Version" => @version,
          "KeyId"   => key_id})

    request(:disable_key, query_params)
  end

  def disable_key_rotation(key_id, opts \\[]) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"  => "DisableKeyRotation",
          "Version" => @version,
          "KeyId"   => key_id})

    request(:disable_key_rotation, query_params)
  end

  def enable_key(key_id, opts \\[]) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"  => "EnableKey",
          "Version" => @version,
          "KeyId"   => key_id})

    request(:enable_key, query_params)
  end

  def enable_key_rotation(key_id, opts \\[]) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"  => "EnableKeyRotation",
          "Version" => @version,
          "KeyId"   => key_id})

    request(:get_key_rotation_status, query_params)
  end

  def encrypt(key_id, plaintext, opts \\[]) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"    => "Encrypt",
          "Version"   => @version,
          "KeyId"     => key_id,
          "Plaintext" => plaintext})

    request(:encrypt, query_params)
  end

  def generate_data_key(key_id, opts \\[]) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"  => "GenerateDataKey",
          "Version" => @version,
          "KeyId"   => key_id,
          "KeySpec" => opts[:key_spec] || "AES_256"
                 })

    request(:generate_data_key, query_params)
  end

  def generate_data_key_without_plaintext(key_id, opts \\[]) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"  => "GenerateDataKeyWithoutPlaintext",
          "Version" => @version,
          "KeyId"   => key_id,
          "KeySpec" => opts[:key_spec] || "AES_256"})

    request(:generate_data_key_without_plaintext, query_params)
  end

  def generate_random(byte_size, opts \\[]) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"  => "GenerateRandom",
          "Version" => @version,
          "NumberOfBytes"   => byte_size,})

    request(:generate_random, query_params)
  end

  def get_key_policy(key_id, policy_name, opts \\[]) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"     => "GetKeyPolicy",
          "Version"    => @version,
          "KeyId"      => key_id,
          "PolicyName" => policy_name})

    request(:get_key_policy, query_params)
  end

  def get_key_rotation_status(key_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"  => "GetKeyRotationStatus",
          "Version" => @version,
          "KeyId"   => key_id})

    request(:get_key_rotation_status, query_params)
  end

  def get_parameters_for_import(key_id, wrapping_algorithm \\ "RSAES_PKCS1_V1_5", wrapping_key_spec \\ "RSA_2048", opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"            => "GetParametersForImport",
          "Version"           => @version,
          "KeyId"             => key_id,
          "WrappingAlgorithm" => wrapping_algorithm,
          "WrappingKeySpec"   => wrapping_key_spec})

    request(:get_parameters_for_import, query_params)
  end

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

  def create_key(opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"  => "CreateKey",
          "Version" => @version})

    request(:create_key, query_params)
  end

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

  def import_key_material(encrypted_key_material, import_token, key_id, opts \\ []) do
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

  def list_aliases(opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"  => "ListAliases",
          "Version" => @version
                 })

    request(:list_aliases, query_params)
  end

  def list_grants(key_id, opts \\[]) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"  => "ListGrants",
          "Version" => @version,
          "KeyId"   => key_id})

    request(:list_grants, query_params)
  end

  def list_key_policies(key_id, opts \\[]) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"  => "ListKeyPolicies",
          "Version" => @version,
          "KeyId"   => key_id})

    request(:list_key_policies, query_params)
  end

  @spec list_keys() :: ExAws.Operation.JSON.t
  def list_keys(opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"  => "ListKeys",
          "Version" => @version
                 })

    request(:list_keys, query_params)
  end

  def list_retirable_grants(retiring_principal, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"            => "ListRetirableGrants",
          "Version"           => @version,
          "RetiringPrincipal" => retiring_principal})

    request(:list_retirable_grants, query_params)
  end

  def put_key_policy(key_id, policy, policy_name, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"            => "PutKeyPolicy",
          "Version"           => @version,
          "KeyId" => key_id,
          "Policy" => policy,
          "PolicyName" => policy_name})

    request(:put_key_policy, query_params)
  end

  def re_encrypt(ciphertext, destination_key_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"  => "ReEncrypt",
          "Version" => @version,
          "CiphertextBlob" => ciphertext,
          "DestinationKeyId" => destination_key_id})

    request(:re_encrypt, query_params)
  end

  def retire_grant(opts) when is_list(opts) do
    opts
    |> normalize_opts
    |> _retire_grant
  end

  def retire_grant(grant_token) when is_binary(grant_token) do
    query_params = %{}
    |> Map.merge(%{
          "GrantToken" => grant_token})

    _retire_grant(query_params)
  end

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

  def revoke_grant(grant_id, key_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"  => "RevokeGrant",
          "Version" => @version,
          "GrantId" => grant_id,
          "KeyId"   => key_id})

    request(:revoke_grant, query_params)
  end

  def schedule_key_deletion(key_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"  => "ScheduleKeyDeletion",
          "Version" => @version,
          "KeyId"   => key_id})

    request(:schedule_key_deletion, query_params)
  end

  def update_alias(alias_name, target_key_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"      => "UpdateAlias",
          "Version"     => @version,
          "AliasName"   => alias_name,
          "TargetKeyId" => target_key_id})

    request(:update_alias, query_params)
  end

  def update_key_description(description, key_id, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"  => "UpdateKeyDescription",
          "Version" => @version,
          "Description" => description,
          "KeyId" => key_id})

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
