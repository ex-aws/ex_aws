defmodule ExAws.KMS.ClientEncryption.Result do
  @enforce_keys [:encrypted_data_key, :ciphertext]
  defstruct [:encrypted_data_key, :ciphertext]
end

defmodule ExAws.KMS.ClientEncryption do

  @doc "Encrypts a map as json with a data key generated for the master key_id provided"
  @spec encrypt(data :: Map.t(), key_id :: String.t()) :: ExAws.KMS.ClientEncryption.Result
  def encrypt_map(%{} = data, key_id) do
    config = ExAws.Config.new(:kms)
    json = config[:json_codec].encode!(data)
    encrypt(json, key_id)
  end

  @doc "Decrypts the result of a call to encrypt_map() (Note: keys will be strings)"
  @spec decrypt(message :: ExAws.KMS.ClientEncryption.Result) :: Map.t()
  def decrypt_map(message) do
    plaintext = decrypt(message)
    config = ExAws.Config.new(:kms)
    {:ok, obj} = config[:json_codec].decode(plaintext)
    obj
  end

  @doc "Encrypts plaintext with a data key generated for the master key_id provided"
  @spec encrypt(plaintext :: String.t(), key_id :: String.t()) :: ExAws.KMS.ClientEncryption.Result
  def encrypt(plaintext, key_id) do
    case  ExAws.KMS.generate_data_key(key_id, [{:key_spec, "AES_256"}]) |> ExAws.request do
      {:ok, %{"CiphertextBlob" => encrypted_data_key, "KeyId" => _, "Plaintext" => data_key}} ->

	iv    = :crypto.strong_rand_bytes(16)
	state = :crypto.stream_init(:aes_ctr, :base64.decode(data_key), iv)

	{_state, ciphertext} = :crypto.stream_encrypt(state, to_string(plaintext))
	%ExAws.KMS.ClientEncryption.Result{encrypted_data_key: encrypted_data_key, ciphertext: :base64.encode(iv <> ciphertext)}
    end
  end

  @doc "Decrypts the result of a call to encrypt()"
  @spec decrypt(message :: ExAws.KMS.ClientEncryption.Result) :: String.t()
  def decrypt(message) do
    case  ExAws.KMS.decrypt(message.encrypted_data_key) |> ExAws.request do
      {:ok, %{"KeyId" => _, "Plaintext" => data_key}} ->
	<<iv::binary-16, ciphertext::binary>> = :base64.decode(message.ciphertext)
	state = :crypto.stream_init(:aes_ctr,  :base64.decode(data_key), iv)

	{_state, plaintext} = :crypto.stream_decrypt(state, ciphertext)
	plaintext
    end
  end

end
