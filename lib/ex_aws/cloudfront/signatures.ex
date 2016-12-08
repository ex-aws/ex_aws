defmodule ExAws.CloudFront.Signatures do
  @moduledoc """
  Cloudfront URL signature utility.
  """

  alias ExAws.CloudFront.CannedPolicy

  @doc """
  Build an AWS signed URL.
  """
  def get_signed_url(url, params) do
    private_key = get_private_key params
    policy = create_policy url, params
    payload = policy |> CannedPolicy.encode

    # Return a formatted URL string with signature.
    url
    |> URI.parse
    |> Map.update!(:query, fn query ->
      query
      |> to_string
      |> URI.query_decoder
      |> Stream.concat([
        {"Expires", policy.expire_time},
        {"Policy", payload |> aws_encode64},
        {"Signature", payload |> create_signature(private_key) |> aws_encode64},
        {"Key-Pair-Id", params[:keypair_id]}
      ])
      |> URI.encode_query
    end)
    |> to_string
  end

  defp create_policy(url, params) do
    url |> CannedPolicy.create(
      # If an expiration time isn't set, default to 30 minutes.
      params |> Map.get_lazy(:expire_time, fn -> ExAws.Utils.now_in_seconds + 1800 end),
      params |> Map.get(:ip_range)
    )
  end

  defp get_private_key(%{private_key_path: private_key_path}) do
    %{private_key_string: private_key_path |> File.read!} |> get_private_key
  end

  defp get_private_key(%{private_key_string: private_key_string}) do
    with [pem_entry] = :public_key.pem_decode(private_key_string) do
      :public_key.pem_entry_decode pem_entry
    end
  end

  defp create_signature(payload, private_key) do
    :public_key.sign payload, :sha, private_key
  end

  defp aws_encode64(value) do
    value
    |> Base.encode64
    |> String.replace("+", "-")
    |> String.replace("=", "_")
    |> String.replace("/", "~")
  end
end
