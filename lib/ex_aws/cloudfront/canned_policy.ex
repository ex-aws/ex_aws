defmodule ExAws.CloudFront.CannedPolicy do
  defstruct [:url, :expire_time]

  @doc """
  Create a Canned Policy.
  """
  def create(url), do: create(url, ExAws.Utils.now_in_seconds + 1800)
  def create(url, %DateTime{} = expire_time), do: create(url, DateTime.to_unix(expire_time))
  def create(url, expire_time) when is_binary(url) and is_integer(expire_time) do
    %__MODULE__{
      url: url,
      expire_time: expire_time
    }
  end
end

defimpl ExAws.CloudFront.Policy, for: ExAws.CloudFront.CannedPolicy do
  import ExAws.CloudFront.Utils

  @doc """
  Create a Signed URL Using a Canned Policy.
  """
  def get_signed_url(canned_policy, keypair_id, private_key) do
    get_signed_url(canned_policy, fn payload ->
      [
        {"Expires", canned_policy.expire_time},
        {"Signature", payload |> create_signature(private_key) |> aws_encode64},
        {"Key-Pair-Id", keypair_id}
      ]
    end)
  end

  @doc """
  Creating a Signature for a Signed Cookie That Uses a Canned Policy.
  """
  def get_signed_cookies(canned_policy, keypair_id, private_key) do
    get_signed_cookies(canned_policy, fn payload ->
      %{
        "CloudFront-Expires" => canned_policy.expire_time |> to_string,
        "CloudFront-Signature" => payload |> create_signature(private_key) |> aws_encode64,
        "CloudFront-Key-Pair-Id" => keypair_id
      }
    end)
  end

  @doc """
  Create a Policy Statement for a Signed URL That Uses a Canned Policy.
  """
  def to_statement(%{url: url, expire_time: expire_time}) do
    unless is_binary(url) do
      raise ArgumentError, message: "Missing string param: `url`"
    end

    unless is_integer(expire_time) do
      raise ArgumentError, message: "Missing integer param: `expire_time`"
    end

    unless expire_time < 2147483647 do
      raise ArgumentError, message:
        "`expire_time` must be less than 2147483647 (January 19, 2038 03:14:08 GMT)"
    end

    unless expire_time > ExAws.Utils.now_in_seconds do
      raise ArgumentError, message: "`expire_time` must be after the current time"
    end

    %{
      "Statement" => [%{
        "Resource" => url,
        "Condition" => %{
          "DateLessThan" => %{
            "AWS:EpochTime" => expire_time
          }
        }
      }]
    }
  end
end
