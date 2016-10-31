defmodule ExAws.KMSIntegratinTest do
  use ExUnit.Case, async: true

  defp key_id do
    System.get_env("AWS_KEY_ARN")
  end

  if System.get_env("AWS_KEY_ARN") do

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
