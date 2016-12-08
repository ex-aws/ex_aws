defmodule ExAws.CloudFront.SignaturesTest do
  use ExUnit.Case, async: true

  alias ExAws.CloudFront.Signatures

  setup context do
    context |> Map.put(:default_params, %{
      keypair_id: "APKAIL7VCI7EL2WS2MSA",
      expire_time: 2147483646,
      private_key_string: "#{__DIR__}/files/private.pem" |> File.read!
    })
  end

  test "get_signed_url/2", %{default_params: default_params} do
    uri = "http://d7311xa8wes2l.cloudfront.net/index.html" |> Signatures.get_signed_url(default_params) |> URI.parse
    query = uri |> Map.get(:query) |> URI.query_decoder |> Map.new

    assert "http://d7311xa8wes2l.cloudfront.net/index.html" == %{uri | query: nil} |> to_string
    assert query["Expires"] == "2147483646"
    assert query["Policy"] == "eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cDovL2Q3MzExeGE4d2VzMmwuY2xvdWRmcm9udC5uZXQvaW5kZXguaHRtbCIsIkNvbmRpdGlvbiI6eyJEYXRlTGVzc1RoYW4iOnsiQVdTOkVwb2NoVGltZSI6MjE0NzQ4MzY0Nn19fV19"
    assert query["Signature"] == "DZ9wlO6wsowBSKWDcX-bWwO0XpoLWz0e-3E3S5WS-o0Y0TFWwB4KDF1zaU2LJLFEv2J~tlOSjAXe0TNSFwz11ogMnb0fR9J40mgoNXn98fvJLZfUpX56Q5VEoWK7fq22GkqRbKvcm6V40RYbem2U4KN1iha5vIvwKNTg4ZgcSg-fnv3Umhie78TZ0ef4bVoUG62RdWy7N22R1SuC~R5aWpb9JSq0T8hcHryPUhypXFulgpTXVOXseSQT19AkPSAUI-0McJU0OkB8LfYslGEiwo~LQykLuzT2yQn9N9SLq0hQTm12xqhUNBJVzAZaLf8WmiFKq5UD0ZVdFwKmQwDTEA__"
    assert query["Key-Pair-Id"] == "APKAIL7VCI7EL2WS2MSA"

    policy = query["Policy"] |> aws_decode64 |> Poison.decode!

    assert %{
      "Statement" => [%{
        "Resource" => "http://d7311xa8wes2l.cloudfront.net/index.html",
        "Condition" => %{
          "DateLessThan" => %{
            "AWS:EpochTime" => 2147483646
          }
        }
      }]
    } == policy

    public_key =
      "#{__DIR__}/files/public.pem"
      |> File.read!
      |> :public_key.pem_decode
      |> Enum.map(&:public_key.pem_entry_decode/1)
      |> List.first
    signature = query["Signature"] |> aws_decode64
    payload = policy|> Poison.encode!

    assert :public_key.verify(payload, :sha, signature, public_key)
  end

  defp aws_decode64(value) do
    value
    |> String.replace("-", "+")
    |> String.replace("_", "=")
    |> String.replace("~", "/")
    |> Base.decode64!
  end
end
