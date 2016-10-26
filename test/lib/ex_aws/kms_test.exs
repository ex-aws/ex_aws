defmodule ExAws.KMSTest do
  use ExUnit.Case, async: true

  defp key_arn do
    System.get_env("AWS_KEY_ARN")
  end

  test "#list_keys" do
    assert {:ok, %{"Keys" => _keys}} = ExAws.KMS.list_keys |> ExAws.request
  end

  test "#enable_key_rotation" do
    assert {:ok, %{"KeyRotationEnabled" => true}} = key_arn |> ExAws.KMS.enable_key_rotation |> ExAws.request
  end

  test "#get_key_rotation_status" do
    assert {:ok, %{"KeyRotationEnabled" => bool}} = key_arn |> ExAws.KMS.get_key_rotation_status |> ExAws.request
    assert is_boolean(bool)
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
end
