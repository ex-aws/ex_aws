defmodule ExAws.KMSIntegratinTest do
  use ExUnit.Case, async: true

  defp key_id do
    System.get_env("AWS_KEY_ARN")
  end

  if System.get_env("AWS_KEY_ARN") do

    test "GenerateDataKey and Decrypt" do
      assert {:ok, %{"CiphertextBlob" => ciphertext,
                     "KeyId" => key_id,
                     "Plaintext" => plaintext}} = ExAws.KMS.generate_data_key(key_id) |> ExAws.request

      {:ok, key} =  Base.decode64(plaintext)
      iv = :crypto.strong_rand_bytes(32)
      {encrypt_ciphertext, encrypt_ciphertag} = :crypto.block_encrypt(:aes_gcm, key, iv, { "", "hello"})

      assert {:ok, %{"KeyId" => decrypt_key_id,
                     "Plaintext" => decrypt_plaintext}} = ExAws.KMS.decrypt(ciphertext) |> ExAws.request

      assert key_id == decrypt_key_id
      assert plaintext == decrypt_plaintext

      assert "hello" == :crypto.block_decrypt(:aes_gcm, key, iv, {"", encrypt_ciphertext, encrypt_ciphertag})
    end

    test "DisableKeyRotation" do
      assert {:ok, %{}} = key_id |> ExAws.KMS.disable_key_rotation |> ExAws.request
    end

    test "EnableKey" do
      assert {:ok, %{}} = key_id |> ExAws.KMS.enable_key |> ExAws.request
    end

    test "EnableKeyRotation" do
      assert {:ok, %{}} = key_id |> ExAws.KMS.enable_key_rotation |> ExAws.request
    end

    test "Encrypt" do
      plaintext = Base.encode64("foobar")
      assert {:ok, %{"CiphertextBlob" => ciphertext,
                     "KeyId"          => key_arn}} = ExAws.KMS.encrypt(key_id, plaintext) |> ExAws.request
      assert key_arn == key_id
      assert ciphertext != Base.decode64(ciphertext)
    end

    test "GenerateDataKeyWithoutPlaintext" do
      assert {:ok, %{"CiphertextBlob" => _blob,
                     "KeyId"          => _key_id}} = key_id |> ExAws.KMS.generate_data_key_without_plaintext |> ExAws.request
    end

    test "GenerateRandom" do
      assert {:ok, %{"Plaintext" => blob}} = 32 |> ExAws.KMS.generate_random |> ExAws.request
      assert {:ok, data} = Base.decode64(blob)
      assert byte_size(data) == 32
    end

    test "GetKeyRotationStatus" do
      assert {:ok, %{"KeyRotationEnabled" => bool}} = key_id |> ExAws.KMS.get_key_rotation_status |> ExAws.request
      assert is_boolean(bool)
    end

    test "ListAliases" do
      assert {:ok, %{"Aliases" => _, "Truncated" => bool}} = ExAws.KMS.list_aliases |> ExAws.request
      assert is_boolean(bool)
    end

    test "ListGrants" do
      assert {:ok, %{"Grants" => _, "Truncated" => bool}} = key_id |> ExAws.KMS.list_grants |> ExAws.request
      assert is_boolean(bool)
    end

    test "ListKeyPolicies" do
      assert {:ok, %{"PolicyNames" => _policy_name, "Truncated" => bool}} = key_id |> ExAws.KMS.list_key_policies |> ExAws.request
      assert is_boolean(bool)
    end

    test "ListKeys" do
      assert {:ok, %{"Keys" => _keys}} = ExAws.KMS.list_keys |> ExAws.request
    end

    test "UpdateKeyDescription" do
      description = "ex_aws test key"
      assert {:ok, %{}} = ExAws.KMS.update_key_description(description, key_id) |> ExAws.request
    end

    if System.get_env("AWS_KEY_ARN_2") do
      test "ReEncrypt" do
        assert {:ok, %{"CiphertextBlob" => ciphertext,
                       "KeyId"          => key_id,
                       "Plaintext"      => _plaintext}} = ExAws.KMS.generate_data_key(key_id) |> ExAws.request

        new_key_id = System.get_env("AWS_KEY_ARN_2")

        assert {:ok, %{"CiphertextBlob" => re_encrypted_ciphertext,
                       "KeyId"          => re_encrypted_key_id,
                       "SourceKeyId"    => old_key_id}} = ExAws.KMS.re_encrypt(ciphertext, new_key_id) |> ExAws.request

        assert key_id == old_key_id
        assert ciphertext != re_encrypted_ciphertext
        assert key_id != re_encrypted_key_id
      end
    end
  end
end
