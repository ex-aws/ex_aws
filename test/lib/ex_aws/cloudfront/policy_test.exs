defmodule ExAws.CloudFront.PolicyTest do
  use ExUnit.Case, async: true

  alias ExAws.CloudFront.Policy
  alias ExAws.CloudFront.CannedPolicy
  alias ExAws.CloudFront.CustomPolicy
  alias ExAws.CloudFront.Utils

  setup_all context do
    context
    |> Map.put(:keypair_id, "APKAIL7VCI7EL2WS2MSA")
    |> Map.put(:private_key, "#{__DIR__}/files/private.pem" |> File.read! |> Utils.decode_rsa_key)
    |> Map.put(:public_key, "#{__DIR__}/files/public.pem" |> File.read! |> Utils.decode_rsa_key)
  end

  test "Policy.get_signed_url/3, for: CannedPolicy", %{
    keypair_id: keypair_id,
    private_key: private_key,
    public_key: public_key
  } do
    expire_time = 2147483646
    policy = "http://d7311xa8wes2l.cloudfront.net/index.html" |> CannedPolicy.create(expire_time)
    uri = policy |> Policy.get_signed_url(keypair_id, private_key) |> URI.parse
    query = uri |> Map.get(:query) |> URI.query_decoder |> Map.new

    assert "http://d7311xa8wes2l.cloudfront.net/index.html" == %{uri | query: nil} |> to_string
    assert query["Expires"] == "2147483646"
    assert query["Signature"] == "DZ9wlO6wsowBSKWDcX-bWwO0XpoLWz0e-3E3S5WS-o0Y0TFWwB4KDF1zaU2LJLFEv2J~tlOSjAXe0TNSFwz11ogMnb0fR9J40mgoNXn98fvJLZfUpX56Q5VEoWK7fq22GkqRbKvcm6V40RYbem2U4KN1iha5vIvwKNTg4ZgcSg-fnv3Umhie78TZ0ef4bVoUG62RdWy7N22R1SuC~R5aWpb9JSq0T8hcHryPUhypXFulgpTXVOXseSQT19AkPSAUI-0McJU0OkB8LfYslGEiwo~LQykLuzT2yQn9N9SLq0hQTm12xqhUNBJVzAZaLf8WmiFKq5UD0ZVdFwKmQwDTEA__"
    assert query["Key-Pair-Id"] == "APKAIL7VCI7EL2WS2MSA"

    refute query["Policy"]

    signature = query["Signature"] |> Utils.aws_decode64
    payload = policy |> Policy.to_statement |> Poison.encode!

    assert :public_key.verify(payload, :sha, signature, public_key)
  end

  test "Policy.get_signed_url/3, for: CustomPolicy", %{
    keypair_id: keypair_id,
    private_key: private_key,
    public_key: public_key
  } do
    date_less_than = 2147483646
    date_greater_than = date_less_than - 10000
    ip_address = "1.2.3.0/24"
    policy =
      "http://d7311xa8wes2l.cloudfront.net/index.html"
      |> CustomPolicy.create(date_less_than)
      |> CustomPolicy.put_date_greater_than(date_greater_than)
      |> CustomPolicy.put_ip_address(ip_address)
    uri = policy |> Policy.get_signed_url(keypair_id, private_key) |> URI.parse
    query = uri |> Map.get(:query) |> URI.query_decoder |> Map.new

    assert "http://d7311xa8wes2l.cloudfront.net/index.html" == %{uri | query: nil} |> to_string
    assert query["Policy"] == "eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cDovL2Q3MzExeGE4d2VzMmwuY2xvdWRmcm9udC5uZXQvaW5kZXguaHRtbCIsIkNvbmRpdGlvbiI6eyJJcEFkZHJlc3MiOnsiQVdTOlNvdXJjZUlwIjoiMS4yLjMuMC8yNCJ9LCJEYXRlTGVzc1RoYW4iOnsiQVdTOkVwb2NoVGltZSI6MjE0NzQ4MzY0Nn0sIkRhdGVHcmVhdGVyVGhhbiI6eyJBV1M6RXBvY2hUaW1lIjoyMTQ3NDczNjQ2fX19XX0_"
    assert query["Signature"] == "VIoXLS-0~vGxqActcwzAL9RktWLZzl0byk4dzdN9iPO1C2zUm1ZW9jYFWMlvQC~~-7KcjGbi35Bmv5IRQKXfmyUs8ZZKBVR4T3oVj-xijR6OWss8TmQw6MCKvYkZIqJwvhQd6ZGCaK25kPN68eSlpu4ZJypyi1zXt2kcrxdunbqIwGrsrsZK2vQVDQyv5-oqoT9GE~r4gKRngPvDp1a5fT5GJ9hWQSk1RlatfztORjtF457PoOjXlGblJ38WsZ4NMssci~yb3PH69zmY85pT5qW4EZYZIGBECOA56ktBCxUnmUatKEir~qZkvxw9eWxy5lxZC-dIOTYztN19~M~YKA__"
    assert query["Key-Pair-Id"] == "APKAIL7VCI7EL2WS2MSA"
    assert query["Policy"] |> Utils.aws_decode64 == policy |> Policy.to_statement |> Poison.encode!

    refute query["Expires"]

    signature = query["Signature"] |> Utils.aws_decode64
    payload = policy |> Policy.to_statement |> Poison.encode!

    assert :public_key.verify(payload, :sha, signature, public_key)
  end
end
