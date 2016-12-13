defmodule ExAws.CloudFront.CustomPolicyTest do
  use ExUnit.Case, async: true

  alias ExAws.CloudFront.Policy
  alias ExAws.CloudFront.CustomPolicy

  test "should fail if `url` is missing" do
    assert_raise ArgumentError, "Missing string param: `url`", fn ->
      %CustomPolicy{date_less_than: ExAws.Utils.now_in_seconds + 10000} |> Policy.to_statement
    end
  end

  test "should fail if `date_less_than` is missing" do
    assert_raise ArgumentError, "Missing integer param: `date_less_than`", fn ->
      %CustomPolicy{url: "http://t.com"} |> Policy.to_statement
    end
  end

  test "should fail if `date_less_than` is after the end of time" do
    assert_raise ArgumentError, "`date_less_than` must be less than January 19, 2038 03:14:08 GMT due to the limits of UNIX time", fn ->
      CustomPolicy.create("http://t.com", 3000000000000) |> Policy.to_statement
    end
  end

  test "should fail if `date_less_than` is before now" do
    assert_raise ArgumentError, "`date_less_than` must be after the current time", fn ->
      CustomPolicy.create("http://t.com", ExAws.Utils.now_in_seconds - 10000) |> Policy.to_statement
    end
  end

  test "should fail if `date_greater_than` is missing" do
    assert_raise ArgumentError, "Missing integer param: `date_greater_than`", fn ->
      %CustomPolicy{
        url: "http://t.com",
        date_less_than: ExAws.Utils.now_in_seconds + 10000,
        date_greater_than: "not_a_number"
      } |> Policy.to_statement
    end
  end

  test "should fail if `date_greater_than` is before now" do
    assert_raise ArgumentError, "`date_greater_than` must be after the current time", fn ->
      CustomPolicy.create("http://t.com", ExAws.Utils.now_in_seconds + 10000)
      |> CustomPolicy.put_date_greater_than(ExAws.Utils.now_in_seconds - 10000)
      |> Policy.to_statement
    end
  end

  test "should fail if `date_greater_than` is before `date_less_than`" do
    assert_raise ArgumentError, "`date_greater_than` must be before the `date_less_than`", fn ->
      CustomPolicy.create("http://t.com", ExAws.Utils.now_in_seconds + 10000)
      |> CustomPolicy.put_date_greater_than(ExAws.Utils.now_in_seconds + 20000)
      |> Policy.to_statement
    end
  end

  test "put_date_greater_than/2" do
    assert %{date_greater_than: 2147483646} = %CustomPolicy{} |> CustomPolicy.put_date_greater_than(2147483646)
  end

  test "put_ip_address/2" do
    assert %{ip_address: "1.2.3.0/24"} = %CustomPolicy{} |> CustomPolicy.put_ip_address("1.2.3.0/24")
  end

  test "should return the custom policy statement" do
    url = "http://t.com"
    date_greater_than = ExAws.Utils.now_in_seconds + 1000
    date_less_than = date_greater_than + 9000
    ip_address = "1.2.3.0/24"
    policy =
      CustomPolicy.create(url, date_less_than)
      |> CustomPolicy.put_date_greater_than(date_greater_than)
      |> CustomPolicy.put_ip_address(ip_address)
    result = policy |> Policy.to_statement

    assert %{
      "Statement" => [%{
        "Resource" => ^url,
        "Condition" => %{
          "DateLessThan" => %{
            "AWS:EpochTime" => ^date_less_than
          },
          "DateGreaterThan" => %{
            "AWS:EpochTime" => ^date_greater_than
          },
          "IpAddress" => %{
            "AWS:SourceIp" => ^ip_address
          }
        },
      }]
    } = result
  end

  test "should exclude beginning date and IP restrictions if none were given" do
    %{"Statement" => [%{"Condition" => condition}]} =
      CustomPolicy.create("http://t.com", ExAws.Utils.now_in_seconds + 10000)
      |> Policy.to_statement

    refute condition |> Map.has_key?("DateGreaterThan")
    refute condition |> Map.has_key?("IpAddress")
  end

  test "should exclude beginning date if none were given" do
    %{"Statement" => [%{"Condition" => condition}]} =
      CustomPolicy.create("http://t.com", ExAws.Utils.now_in_seconds + 10000)
      |> CustomPolicy.put_ip_address("1.2.3.0/24")
      |> Policy.to_statement

    refute condition |> Map.has_key?("DateGreaterThan")
  end

  test "should exclude IP restrictions if none were given" do
    %{"Statement" => [%{"Condition" => condition}]} =
      CustomPolicy.create("http://t.com", ExAws.Utils.now_in_seconds + 9000)
      |> CustomPolicy.put_date_greater_than(ExAws.Utils.now_in_seconds + 1000)
      |> Policy.to_statement

    refute condition |> Map.has_key?("IpAddress")
  end
end
