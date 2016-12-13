defmodule ExAws.CloudFront.Utils do
  alias ExAws.CloudFront.Policy

  @doc """
  Create a Signed URL Using a Policy and Query Builder.
  """
  def get_signed_url(policy, query_builder) do
    policy.url
    |> URI.parse
    |> Map.update!(:query, fn query ->
      query
      |> to_string
      |> URI.query_decoder
      |> Stream.concat(policy |> Policy.to_statement |> query_builder.())
      |> URI.encode_query
    end)
    |> to_string
  end

  def create_signature(payload, private_key) when is_binary(private_key) do
    create_signature payload, private_key |> decode_rsa_key
  end
  def create_signature(payload, private_key), do: :public_key.sign payload, :sha, private_key

  def aws_encode64(value), do: value |> Base.encode64 |> urlify
  def aws_decode64(value), do: value |> deurlify |> Base.decode64!

  def urlify(value), do: value |> String.replace("+", "-") |> String.replace("=", "_") |> String.replace("/", "~")
  def deurlify(value), do: value |> String.replace("-", "+") |> String.replace("_", "=") |> String.replace("~", "/")

  def decode_rsa_key(rsa_key) when is_binary(rsa_key) do
    with [pem_entry] = :public_key.pem_decode(rsa_key) do
      :public_key.pem_entry_decode pem_entry
    end
  end
end
