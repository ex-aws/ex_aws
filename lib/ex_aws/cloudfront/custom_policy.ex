defmodule ExAws.CloudFront.CustomPolicy do
  defstruct [:url, :date_less_than, :date_greater_than, :ip_address]

  @doc """
  Create a Custom Policy.
  """
  def create(url, date_less_than) do
    %__MODULE__{
      url: url,
      date_less_than: date_less_than
    }
  end

  @doc """
  Puts a beginning date and time in Unix time format and UTC.
  """
  def put_date_greater_than(%__MODULE__{} = policy, date) do
    %__MODULE__{ policy | date_greater_than: date }
  end

  @doc """
  Puts an IP address.
  """
  def put_ip_address(%__MODULE__{} = policy, ip_address) do
    %__MODULE__{ policy | ip_address: ip_address }
  end
end

defimpl ExAws.CloudFront.Policy, for: ExAws.CloudFront.CustomPolicy do
  import ExAws.CloudFront.Utils

  @doc """
  Create a Signed URL Using a Custom Policy.
  """
  def get_signed_url(custom_policy, keypair_id, private_key_string) do
    get_signed_url(custom_policy, fn statement ->
      with payload = statement |> Poison.encode!, do: [
        {"Policy", payload |> aws_encode64},
        {"Signature", payload |> create_signature(private_key_string) |> aws_encode64},
        {"Key-Pair-Id", keypair_id}
      ]
    end)
  end

  @doc """
  Create a Policy Statement for a Signed URL That Uses a Custom Policy.
  """
  def to_statement(%{
    url: url,
    date_less_than: date_less_than,
    date_greater_than: date_greater_than,
    ip_address: ip_address
  }) do
    unless is_binary url do
      raise ArgumentError, message: "Missing string param: `url`"
    end

    unless is_integer date_less_than do
      raise ArgumentError, message: "Missing integer param: `date_less_than`"
    end

    unless date_less_than < 2147483647 do
      raise ArgumentError, message:
        "`date_less_than` must be less than January 19, 2038 03:14:08 GMT due to the limits of UNIX time"
    end

    unless date_less_than > ExAws.Utils.now_in_seconds do
      raise ArgumentError, message: "`date_less_than` must be after the current time"
    end

    unless is_nil(date_greater_than) do
      unless is_integer date_greater_than do
        raise ArgumentError, message: "Missing integer param: `date_greater_than`"
      end

      unless date_greater_than < date_less_than do
        raise ArgumentError, message: "`date_greater_than` must be before the `date_less_than`"
      end

      unless date_greater_than > ExAws.Utils.now_in_seconds do
        raise ArgumentError, message: "`date_greater_than` must be after the current time"
      end
    end

    %{
      "Statement" => [%{
        "Resource" => url,
        "Condition" =>
          case {date_greater_than, ip_address} do
            {nil, nil} -> %{
              "DateLessThan" => aws_epoch_time(date_less_than)
            }

            {_, nil} -> %{
              "DateLessThan" => aws_epoch_time(date_less_than),
              "DateGreaterThan" => aws_epoch_time(date_greater_than)
            }

            {nil, _} -> %{
              "DateLessThan" => aws_epoch_time(date_less_than),
              "IpAddress" => aws_source_ip(ip_address)
            }

            {_, _} -> %{
              "DateLessThan" => aws_epoch_time(date_less_than),
              "DateGreaterThan" => aws_epoch_time(date_greater_than),
              "IpAddress" => aws_source_ip(ip_address)
            }
          end
      }]
    }
  end

  defp aws_epoch_time(value), do: %{"AWS:EpochTime" => value}
  defp aws_source_ip(value), do: %{"AWS:SourceIp" => value}
end
