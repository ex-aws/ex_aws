defmodule ExAws.KMSTest do
  use ExUnit.Case, async: true

  @version "2014-11-01"

  defp key_arn do
    System.get_env("AWS_KEY_ARN")
  end

  test "CancelKeyDeletion" do
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"     => "CancelKeyDeletion",
                                         "KeyId"      => key_arn,
                                         "Version"    => @version},
                                 headers: [{"x-amz-target", "TrentService.CancelKeyDeletion"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.cancel_key_deletion(key_arn)
  end

  test "CreateAlias" do
    alias_name ="alias name"

    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"      => "CreateAlias",
                                         "AliasName"   => alias_name,
                                         "TargetKeyId" => key_arn,
                                         "Version"     => @version},
                                 headers: [{"x-amz-target", "TrentService.CreateAlias"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.create_alias(alias_name, key_arn)
  end

  # CreateGrant
  # CreateKey
  # Dfined: Decrypt

  test "DeleteAlias" do
    alias_name = "alias name"
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"    => "DeleteAlias",
                                         "AliasName" => alias_name,
                                         "Version"   => @version},
                                 headers: [{"x-amz-target", "TrentService.DeleteAlias"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.delete_alias(alias_name)
  end

  # DeleteImportedKeyMaterial

  test "#describe_key" do
    assert {:ok, %{"KeyMetadata" => _}} = key_arn |> ExAws.KMS.describe_key |> ExAws.request
  end

  test "#disable_key" do
    key_id = System.get_env("AWS_KEY_ARN_2")
    assert {:ok, %{}} = key_id |> ExAws.KMS.disable_key |> ExAws.request
  end

  test "#disable_key_rotation" do
    assert {:ok, %{}} = key_arn |> ExAws.KMS.disable_key_rotation |> ExAws.request
  end

  test "#enable_key" do
    key_id = System.get_env("AWS_KEY_ARN_2")
    assert {:ok, %{}} = key_id |> ExAws.KMS.enable_key |> ExAws.request
  end

  test "#enable_key_rotation" do
    assert {:ok, %{"KeyRotationEnabled" => bool}} = key_arn |> ExAws.KMS.enable_key_rotation |> ExAws.request
    assert is_boolean(bool)
  end

  test "#encrypt" do
    plaintext = Base.encode64("foobar")
    assert {:ok, %{"CiphertextBlob" => ciphertext,
                   "KeyId"          => key_id}} = ExAws.KMS.encrypt(key_arn, plaintext) |> ExAws.request
    assert key_id == key_arn
    assert ciphertext != Base.decode64(ciphertext)
  end

  test "#generate_data_key and #decrypt" do
    assert {:ok, %{"CiphertextBlob" => ciphertext,
                   "KeyId" => key_id,
                   "Plaintext" => plaintext}} = ExAws.KMS.generate_data_key(key_arn) |> ExAws.request

    assert key_arn == key_id

    {:ok, key} =  Base.decode64(plaintext)
    iv = :crypto.strong_rand_bytes(32)
    {encrypt_ciphertext, encrypt_ciphertag} = :crypto.block_encrypt(:aes_gcm, key, iv, { "", "hello"})

    assert {:ok, %{"KeyId" => decrypt_key_id,
                   "Plaintext" => decrypt_plaintext}} = ExAws.KMS.decrypt(ciphertext) |> ExAws.request

    assert key_id == decrypt_key_id
    assert plaintext == decrypt_plaintext

    assert "hello" == :crypto.block_decrypt(:aes_gcm, key, iv, {"", encrypt_ciphertext, encrypt_ciphertag})
  end

  test "#generate_data_key_without_plaintext" do
    assert {:ok, %{"CiphertextBlob" => _blob,
                   "KeyId"          => _key_id}} = key_arn |> ExAws.KMS.generate_data_key_without_plaintext |> ExAws.request

  end

  test "#generate_random" do
    assert {:ok, %{"Plaintext" => blob}} = 32 |> ExAws.KMS.generate_random |> ExAws.request
    assert {:ok, data} = Base.decode64(blob)
    assert byte_size(data) == 32
  end

  test "GetKeyPolicy" do
    policy_name = "policy name"
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"     => "GetKeyPolicy",
                                         "KeyId"      => key_arn,
                                         "PolicyName" => policy_name,
                                         "Version"    => @version},
                                 headers: [{"x-amz-target", "TrentService.GetKeyPolicy"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.get_key_policy(key_arn, policy_name)
  end

  test "#get_key_rotation_status" do
    assert {:ok, %{"KeyRotationEnabled" => bool}} = key_arn |> ExAws.KMS.get_key_rotation_status |> ExAws.request
    assert is_boolean(bool)
  end

  # GetParametersForImport
  # ImportKeyMaterial

  test "#list_aliases" do
    assert {:ok, %{"Aliases" => _, "Truncated" => bool}} = ExAws.KMS.list_aliases |> ExAws.request
    assert is_boolean(bool)
  end

  test "#list_grants" do
    assert {:ok, %{"Grants" => _, "Truncated" => bool}} = key_arn |> ExAws.KMS.list_grants |> ExAws.request
    assert is_boolean(bool)
  end

  test "#list_key_policies" do
    assert {:ok, %{"PolicyNames" => _policy_name, "Truncated" => bool}} = key_arn |> ExAws.KMS.list_key_policies |> ExAws.request
    assert is_boolean(bool)
  end

  test "#list_keys" do
    assert {:ok, %{"Keys" => _keys}} = ExAws.KMS.list_keys |> ExAws.request
  end

  test "#list_retirable_grants" do
    retiring_principal = "arn"

    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"            => "ListRetirableGrants",
                                         "RetiringPrincipal" => retiring_principal,
                                         "Version"           => @version},
                                 headers: [{"x-amz-target", "TrentService.ListRetirableGrants"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.list_retirable_grants(retiring_principal)
  end

  test "PutKeyPolicy" do
    policy = "json policy"
    policy_name = "test policy"
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"     => "PutKeyPolicy",
                                         "KeyId"      => key_arn,
                                         "Policy"     => policy,
                                         "PolicyName" => policy_name,
                                         "Version"    => @version},
                                 headers: [{"x-amz-target", "TrentService.PutKeyPolicy"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.put_key_policy(key_arn, policy, policy_name)
  end

  test "#re_encrypt" do
    assert {:ok, %{"CiphertextBlob" => ciphertext,
                   "KeyId"          => key_id,
                   "Plaintext"      => _plaintext}} = ExAws.KMS.generate_data_key(key_arn) |> ExAws.request

    new_key_id = System.get_env("AWS_KEY_ARN_2")

    assert {:ok, %{"CiphertextBlob" => re_encrypted_ciphertext,
                   "KeyId"          => re_encrypted_key_id,
                   "SourceKeyId"    => old_key_id}} = ExAws.KMS.re_encrypt(ciphertext, new_key_id) |> ExAws.request

    assert key_id == old_key_id
    assert ciphertext != re_encrypted_ciphertext
    assert key_id != re_encrypted_key_id
  end

  test ".retire_grant/1 use grant token" do
    grant_token = "grant token"
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"     => "RetireGrant",
                                         "GrantToken" => grant_token,
                                         "Version"    => @version},
                                 headers: [{"x-amz-target", "TrentService.RetireGrant"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.retire_grant(grant_token: grant_token)

  end

  test ".retire_grant/1 use grant id and key id" do
    grant_id = 1
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"  => "RetireGrant",
                                         "GrantId" => grant_id,
                                         "KeyId"   => key_arn,
                                         "Version" => @version},
                                 headers: [{"x-amz-target", "TrentService.RetireGrant"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.retire_grant(grant_id: grant_id, key_id: key_arn)
  end

  test ".retire_grant/2" do
    grant_token = "grant token"
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"     => "RetireGrant",
                                         "GrantToken" => grant_token,
                                         "Version"    => @version},
                                 headers: [{"x-amz-target", "TrentService.RetireGrant"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.retire_grant(grant_token)
  end

  test ".retire_grant/3" do
    grant_id = 1
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"  => "RetireGrant",
                                         "GrantId" => grant_id,
                                         "KeyId"   => key_arn,
                                         "Version" => @version},
                                 headers: [{"x-amz-target", "TrentService.RetireGrant"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.retire_grant(grant_id, key_arn)
  end

  test "RevokeGrant" do
    grant_id = 1
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"  => "RevokeGrant",
                                         "GrantId" => grant_id,
                                         "KeyId"   => key_arn,
                                         "Version" => @version},
                                 headers: [{"x-amz-target", "TrentService.RevokeGrant"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.revoke_grant(grant_id, key_arn)
  end

  test "ScheduleKeyDeletion" do
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"  => "ScheduleKeyDeletion",
                                         "KeyId"   => key_arn,
                                         "Version" => @version},
                                 headers: [{"x-amz-target", "TrentService.ScheduleKeyDeletion"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.schedule_key_deletion(key_arn)
  end

  test "UpdateAlias" do
    alias_name = "name"
    target_key_id = "key_id"

    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"      => "UpdateAlias",
                                         "AliasName"   => alias_name,
                                         "TargetKeyId" => target_key_id,
                                         "Version"    => @version},
                                 headers: [{"x-amz-target", "TrentService.UpdateAlias"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.update_alias(alias_name, target_key_id)
  end

  test "#update_key_description" do
    description = "for development2 dev2"
    update_key = System.get_env("AWS_KEY_ARN_2")
    assert {:ok, %{}} = ExAws.KMS.update_key_description(description, update_key) |> ExAws.request
  end
end
