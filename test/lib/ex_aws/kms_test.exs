defmodule ExAws.KMSTest do
  use ExUnit.Case, async: true

  test "#list_keys" do
    assert {:ok, %{"Keys" => _keys}} = ExAws.KMS.list_keys |> ExAws.request
  end

  test "#generate_data_key" do
    key_arn = System.get_env("AWS_KEY_ARN")
    assert {:ok, %{"CiphertextBlob" => _ciphertext,
                   "KeyId" => _key_id,
                   "Plaintext" => _plaintext}} = ExAws.KMS.generate_data_key(key_arn) |> ExAws.request
  end
end
