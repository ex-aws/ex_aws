defmodule ExAws.KMSTest do
  use ExUnit.Case, async: true

  @version "2014-11-01"

  defp key_arn do
    System.get_env("AWS_KEY_ARN")
  end

  test "CancelKeyDeletion" do
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"     => "CancelKeyDeletion",
                                         "KeyId"      => "key-id",
                                         "Version"    => @version},
                                 headers: [{"x-amz-target", "TrentService.CancelKeyDeletion"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.cancel_key_deletion("key-id")
  end

  test "CreateAlias" do
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"      => "CreateAlias",
                                         "AliasName"   => "alias-name",
                                         "TargetKeyId" => "key-id",
                                         "Version"     => @version},
                                 headers: [{"x-amz-target", "TrentService.CreateAlias"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.create_alias("alias-name", "key-id")
  end

  test "CreateGrant" do
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"            => "CreateGrant",
                                         "Version"          => @version,
                                         "GranteePrincipal" => "grantee-principal",
                                         "KeyId"            => "key-id"},
                                 headers: [{"x-amz-target", "TrentService.CreateGrant"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.create_grant("grantee-principal", "key-id")
  end

  test "CreateKey" do
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"  => "CreateKey",
                                         "Version" => @version},
                                 headers: [{"x-amz-target", "TrentService.CreateKey"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.create_key
  end

  test "Decrypt" do
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"         => "Decrypt",
                                         "CiphertextBlob" => "ciphertext",
                                         "Version"        => @version},
                                 headers: [{"x-amz-target", "TrentService.Decrypt"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.decrypt("ciphertext")
  end

  test "DeleteAlias" do
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"    => "DeleteAlias",
                                         "AliasName" => "alias-name",
                                         "Version"   => @version},
                                 headers: [{"x-amz-target", "TrentService.DeleteAlias"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.delete_alias("alias-name")
  end

  test "DeleteImportedKeyMaterial" do
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"  => "DeleteImportedKeyMaterial",
                                         "KeyId"   => "key-id",
                                         "Version" => @version},
                                 headers: [{"x-amz-target", "TrentService.DeleteImportedKeyMaterial"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.delete_imported_key_material("key-id")
  end

  test "DescribeKey" do
    assert {:ok, %{"KeyMetadata" => _}} = key_arn |> ExAws.KMS.describe_key |> ExAws.request
  end

  test "DisableKey" do
    key_id = System.get_env("AWS_KEY_ARN_2")
    assert {:ok, %{}} = key_id |> ExAws.KMS.disable_key |> ExAws.request
  end

  test "DisableKeyRotation" do
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"  => "DisableKeyRotation",
                                         "Version" => @version,
                                         "KeyId"   => "key-id"},
                                 headers: [{"x-amz-target", "TrentService.DisableKeyRotation"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.disable_key_rotation("key-id")
  end

  test "EnableKey" do
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"  => "EnableKey",
                                         "Version" => @version,
                                         "KeyId"   => "key-id"},
                                 headers: [{"x-amz-target", "TrentService.EnableKey"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.enable_key("key-id")
  end

  test "EnableKeyRotation" do
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"    => "EnableKeyRotation",
                                         "Version"   => @version,
                                         "KeyId"     => "key-id"},
                                 headers: [{"x-amz-target", "TrentService.EnableKeyRotation"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.enable_key_rotation("key-id")
  end

  test "Encrypt" do
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"    => "Encrypt",
                                         "Version"   => @version,
                                         "KeyId"     => "key-id",
                                         "Plaintext" => "plaintext"},
                                 headers: [{"x-amz-target", "TrentService.Encrypt"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.encrypt("key-id", "plaintext")
  end

  test "GenerateDataKey" do
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"  => "GenerateDataKey",
                                         "Version" => @version,
                                         "KeyId"   => "key-id"},
                                 headers: [{"x-amz-target", "TrentService.GenerateDataKey"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.generate_data_key("key-id")
  end

  test "GenerateDataKeyWithoutPlaintext" do
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"  => "GenerateDataKeyWithoutPlaintext",
                                         "Version" => @version,
                                         "KeyId"   => "key-id"},
                                 headers: [{"x-amz-target", "TrentService.GenerateDataKeyWithoutPlaintext"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.generate_data_key_without_plaintext("key-id")
  end

  test "GenerateRandom" do
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"        => "GenerateRandom",
                                         "Version"       => @version,
                                         "NumberOfBytes" => 32},
                                 headers: [{"x-amz-target", "TrentService.GenerateRandom"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.generate_random(32)
  end

  test "GetKeyPolicy" do
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"     => "GetKeyPolicy",
                                         "KeyId"      => "key-id",
                                         "PolicyName" => "policy-name",
                                         "Version"    => @version},
                                 headers: [{"x-amz-target", "TrentService.GetKeyPolicy"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.get_key_policy("key-id", "policy-name")
  end

  test "GetKeyRotationStatus" do
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"  => "GetKeyRotationStatus",
                                         "Version" => @version,
                                         "KeyId"   => "key-id",},
                                 headers: [{"x-amz-target", "TrentService.GetKeyRotationStatus"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.get_key_rotation_status("key-id")
  end

  test "GetParametersForImport" do
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"            => "GetParametersForImport",
                                         "KeyId"             => "key-id",
                                         "WrappingAlgorithm" => "RSAES_PKCS1_V1_5",
                                         "WrappingKeySpec"   => "RSA_2048",
                                         "Version"           => @version},
                                 headers: [{"x-amz-target", "TrentService.GetParametersForImport"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.get_parameters_for_import("key-id")
  end

  test "ImportKeyMaterial" do
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"               => "ImportKeyMaterial",
                                         "EncryptedKeyMaterial" => "encrypted-key-material",
                                         "ImportToken"          => "import-token",
                                         "KeyId"                => "key-id",
                                         "Version"              => @version},
                                 headers: [{"x-amz-target", "TrentService.ImportKeyMaterial"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.import_key_material("encrypted-key-material", "import-token", "key-id")
  end

  test "ListAliases" do
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"  => "ListAliases",
                                         "Version" => @version},
                                 headers: [{"x-amz-target", "TrentService.ListAliases"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.list_aliases
  end

  test "ListGrants" do
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"  => "ListGrants",
                                         "Version" => @version,
                                         "KeyId"   => "key-id"},
                                 headers: [{"x-amz-target", "TrentService.ListGrants"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.list_grants("key-id")
  end

  test "ListKeyPolicies" do
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"  => "ListKeyPolicies",
                                         "Version" => @version,
                                         "KeyId"   => "key-id"},
                                 headers: [{"x-amz-target", "TrentService.ListKeyPolicies"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.list_key_policies("key-id")
  end

  test "ListKeys" do
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"            => "ListKeys",
                                         "Version"           => @version},
                                 headers: [{"x-amz-target", "TrentService.ListKeys"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.list_keys
  end

  test "ListRetirableGrants" do
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"            => "ListRetirableGrants",
                                         "RetiringPrincipal" => "retiring-principal",
                                         "Version"           => @version},
                                 headers: [{"x-amz-target", "TrentService.ListRetirableGrants"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.list_retirable_grants("retiring-principal")
  end

  test "PutKeyPolicy" do
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"     => "PutKeyPolicy",
                                         "KeyId"      => "key-id",
                                         "Policy"     => "policy",
                                         "PolicyName" => "policy-name",
                                         "Version"    => @version},
                                 headers: [{"x-amz-target", "TrentService.PutKeyPolicy"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.put_key_policy("key-id", "policy", "policy-name")
  end

  test "ReEncrypt" do
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"           => "ReEncrypt",
                                         "CiphertextBlob"   => "ciphertext",
                                         "DestinationKeyId" => "key-id",
                                         "Version"          => @version},
                                 headers: [{"x-amz-target", "TrentService.ReEncrypt"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.re_encrypt("ciphertext", "key-id")
  end

  test "RetireGrant .retire_grant/1 use grant token" do
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"     => "RetireGrant",
                                         "GrantToken" => "grant-token",
                                         "Version"    => @version},
                                 headers: [{"x-amz-target", "TrentService.RetireGrant"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.retire_grant(grant_token: "grant-token")
  end

  test "RetireGrant .retire_grant/1 use grant id and key id" do
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"  => "RetireGrant",
                                         "GrantId" => 123,
                                         "KeyId"   => "key-id",
                                         "Version" => @version},
                                 headers: [{"x-amz-target", "TrentService.RetireGrant"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.retire_grant(grant_id: 123, key_id: "key-id")
  end

  test "RetireGrant .retire_grant/2" do
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"     => "RetireGrant",
                                         "GrantToken" => "grant-token",
                                         "Version"    => @version},
                                 headers: [{"x-amz-target", "TrentService.RetireGrant"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.retire_grant("grant-token")
  end

  test "RetireGrant .retire_grant/3" do
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"  => "RetireGrant",
                                         "GrantId" => 123,
                                         "KeyId"   => "key-id",
                                         "Version" => @version},
                                 headers: [{"x-amz-target", "TrentService.RetireGrant"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.retire_grant(123, "key-id")
  end

  test "RevokeGrant" do
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"  => "RevokeGrant",
                                         "GrantId" => 123,
                                         "KeyId"   => "key-id",
                                         "Version" => @version},
                                 headers: [{"x-amz-target", "TrentService.RevokeGrant"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.revoke_grant(123, "key-id")
  end

  test "ScheduleKeyDeletion" do
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"  => "ScheduleKeyDeletion",
                                         "KeyId"   => "key-id",
                                         "Version" => @version},
                                 headers: [{"x-amz-target", "TrentService.ScheduleKeyDeletion"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.schedule_key_deletion("key-id")
  end

  test "UpdateAlias" do
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"      => "UpdateAlias",
                                         "AliasName"   => "alias_name",
                                         "TargetKeyId" => "target_key_id",
                                         "Version"    => @version},
                                 headers: [{"x-amz-target", "TrentService.UpdateAlias"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.update_alias("alias_name", "target_key_id")
  end

  test "UpdateKeyDescription" do
    assert %ExAws.Operation.JSON{before_request: nil,
                                 data: %{"Action"      => "UpdateKeyDescription",
                                         "Description" => "description",
                                         "KeyId"       => "key-id",
                                         "Version"     => @version},
                                 headers: [{"x-amz-target", "TrentService.UpdateKeyDescription"},
                                           {"content-type", "application/x-amz-json-1.0"}],
                                 http_method: :post,
                                 parser: _,
                                 path: "/",
                                 service: :kms,
                                 stream_builder: nil} = ExAws.KMS.update_key_description("description", "key-id")
  end
end
