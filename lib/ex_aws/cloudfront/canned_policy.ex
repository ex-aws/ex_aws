defmodule ExAws.CloudFront.CannedPolicy do
  defstruct [:url, :expire_time, :ip_range]

  @doc """
  Create a new `CannedPolicy`.
  """
  def create(url, expire_time, ip_range \\ nil) do
    %__MODULE__{
      url: url,
      expire_time: expire_time,
      ip_range: ip_range
    }
  end

  @doc """
  Serialize the CannedPolicy instance.
  """
  def encode(%__MODULE__{url: url, expire_time: expire_time, ip_range: ip_range}) do
    unless is_binary url do
      raise ArgumentError, message: "Missing string param: `url`"
    end

    unless is_integer expire_time do
      raise ArgumentError, message: "Missing integer param: `expire_time`"
    end

    unless expire_time < 2147483647 do
      raise ArgumentError, message: "`expire_time` must be less than January 19, 2038 03:14:08 GMT due to the limits of UNIX time"
    end

    unless expire_time > ExAws.Utils.now_in_seconds do
      raise ArgumentError, message: "`expire_time` must be after the current time"
    end

    condition = %{
      "DateLessThan": %{
        "AWS:EpochTime": expire_time
      }
    }

    Poison.encode! %{
      "Statement": [%{
        "Resource": url,
        "Condition":
          if is_binary ip_range do
            condition |> Map.put("IpAddress", %{"AWS:SourceIp": ip_range})
          else
            condition
          end
      }]
    }
  end
end
