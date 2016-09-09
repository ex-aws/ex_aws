defmodule ExAws.Auth.PresignedPosts.PolicyTest do
  use ExUnit.Case, async: true

  alias ExAws.Auth.PresignedPosts.Policy

  describe "add_condition/2" do
    test "adding multiple entries retains order" do
      policy =
        Policy.new
        |> Policy.add_condition(%{"acl" => "public-read"})
        |> Policy.add_condition(["starts_with", "$key", "something/"])
        |> Policy.add_condition(%{"Content-Type" => "image/jpeg"})

      assert policy.conditions == [
        %{"acl" => "public-read"},
        ["starts_with", "$key", "something/"],
        %{"Content-Type" => "image/jpeg"},
      ]
    end
  end

  describe "encode/2" do
    test "encoding a policy with an expiration" do
      config = build_config()
      datetime = {{2016,8,29},{19,41,33}}

      policy =
        Policy.new
        |> Policy.set_expiration(datetime)
        |> Policy.add_condition(%{"acl" => "public-read"})

      encoded_policy = Policy.encode(policy, config)

      assert decode_policy(encoded_policy, config) == %{
        "expiration" => "2016-08-29T19:41:33Z",
        "conditions" => [%{"acl" => "public-read"}]
      }
    end

    test "encoding a policy without an expiration" do
      config = build_config()

      policy =
        Policy.new
        |> Policy.add_condition(%{"acl" => "public-read"})

        encoded_policy = Policy.encode(policy, config)

      assert decode_policy(encoded_policy, config) == %{
        "expiration" => nil,
        "conditions" => [%{"acl" => "public-read"}]
      }
    end

    defp decode_policy(encoded_policy, config) do
      encoded_policy |> Base.decode64! |> config.json_codec.decode!
    end

    defp build_config() do
      ExAws.Config.new(:s3, [
        access_key_id: "AKIAIOSFODNN7EXAMPLE",
        secret_access_key: "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
        region: "us-east-1"
      ])
    end
  end
end
