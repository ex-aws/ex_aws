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

  def create_signature(payload, private_key_string) do
    :public_key.sign payload, :sha, get_private_key(private_key_string)
  end

  def aws_encode64(value), do: value |> Base.encode64 |> urlify
  def aws_decode64(value), do: value |> deurlify |> Base.decode64!

  def urlify(value), do: value |> String.replace("+", "-") |> String.replace("=", "_") |> String.replace("/", "~")
  def deurlify(value), do: value |> String.replace("-", "+") |> String.replace("_", "=") |> String.replace("~", "/")

  defp get_private_key(private_key_string) do
    with [pem_entry] = :public_key.pem_decode(private_key_string) do
      :public_key.pem_entry_decode pem_entry
    end
  end
end
