defmodule ExAws.CloudFront.CannedPolicyTest do
  use ExUnit.Case, async: true

  alias ExAws.CloudFront.CannedPolicy

  test "should fail if `url` is missing" do
    assert_raise ArgumentError, "Missing string param: `url`", fn ->
      CannedPolicy.create(nil, ExAws.Utils.now_in_seconds + 10000) |> CannedPolicy.encode
    end
  end

  test "should fail if `expire_time` is missing" do
    assert_raise ArgumentError, "Missing integer param: `expire_time`", fn ->
      CannedPolicy.create("http://t.com", nil) |> CannedPolicy.encode
    end
  end

  test "should fail if `expire_time` is after the end of time" do
    assert_raise ArgumentError, "`expire_time` must be less than January 19, 2038 03:14:08 GMT due to the limits of UNIX time", fn ->
      CannedPolicy.create("http://t.com", 3000000000000) |> CannedPolicy.encode
    end
  end

  test "should fail if `expire_time` is before now" do
    assert_raise ArgumentError, "`expire_time` must be after the current time", fn ->
      CannedPolicy.create("http://t.com", ExAws.Utils.now_in_seconds - 10000) |> CannedPolicy.encode
    end
  end

  test "should return the canned policy as stringified JSON" do
    url = "http://t.com"
    expire_time = ExAws.Utils.now_in_seconds + 10000
    ip_range = "1.2.3.0/24"
    policy = CannedPolicy.create url, expire_time, ip_range
    result = policy |> CannedPolicy.encode |> Poison.decode!

    assert %{
      "Statement" => [%{
        "Resource" => ^url,
        "Condition" => %{
          "DateLessThan" => %{
            "AWS:EpochTime" => ^expire_time
          },
          "IpAddress" => %{
            "AWS:SourceIp" => ^ip_range
          }
        },
      }]
    } = result
  end

  test "should exclude IP restrictions if none were given" do
    %{"Statement" => [%{"Condition" => condition}]} =
      CannedPolicy.create("http://t.com", ExAws.Utils.now_in_seconds + 10000)
      |> CannedPolicy.encode
      |> Poison.decode!

    refute condition |> Map.has_key?("IpAddress")
  end
end
