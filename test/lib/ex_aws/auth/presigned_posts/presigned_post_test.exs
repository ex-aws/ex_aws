defmodule ExAws.Auth.PresignedPosts.PresignedPostTest do
  use ExUnit.Case, async: true

  alias ExAws.Auth.PresignedPosts.{Policy, PresignedPost}
  alias ExAws.Auth.Signatures

  describe "put_field/3" do
    test "adding a generic field" do
      presigned_post =
        PresignedPost.new
        |> PresignedPost.put_field("content-type", "application/json")

      assert %{"content-type" => "application/json"} = presigned_post.fields
      assert %{"content-type" => "application/json"} in presigned_post.policy.conditions
    end

    test "adding key field" do
      presigned_post =
        PresignedPost.new
        |> PresignedPost.put_field("key", "uploads/${filename}")

      assert %{"key" => "uploads/${filename}"} = presigned_post.fields
      assert ["starts-with", "$key", "uploads/"] in presigned_post.policy.conditions
    end
  end

  describe "put_policy_condition/2" do
    test "adds a condition to the policy" do
      condition = ["starts-with", "$content-type", "image/"]

      presigned_post =
        PresignedPost.new
        |> PresignedPost.put_policy_condition(condition)

      assert condition in presigned_post.policy.conditions
    end
  end

  describe "set_bucket/2" do
    test "adds a bucket condition to the policy" do
      presigned_post =
        PresignedPost.new
        |> PresignedPost.set_bucket("my-test-bucket")

      assert %{"bucket" => "my-test-bucket"} in presigned_post.policy.conditions
    end
  end

  describe "set_expiration/2" do
    test "setting the expiration on the policy" do
      datetime = {{2016,8,29},{19,41,33}}

      presigned_post =
        PresignedPost.new
        |> PresignedPost.set_expiration(datetime)

      assert presigned_post.policy.expiration == datetime
    end
  end

  describe "fields_with_signature/2" do
    test "with a basic presigned post" do
      config = ExAws.Config.new(:s3, [
        access_key_id: "AKIAIOSFODNN7EXAMPLE",
        secret_access_key: "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
        region: "us-east-1"
      ])
      datetime = {{2016,8,29},{19,41,33}}

      presigned_post =
        PresignedPost.new()
        |> PresignedPost.set_expiration(datetime)
        |> PresignedPost.put_field("content-type", "application/json")

      fields = PresignedPost.fields_with_signature(presigned_post, config, datetime)

      expected_policy = Policy.encode(presigned_post.policy, config)
      expected_signature = Signatures.generate_signature_v4(
        "s3", config, datetime, expected_policy)

      assert fields == %{
        "content-type" => "application/json",
        "policy" => expected_policy,
        "x-amz-signature" =>  expected_signature
      }
    end
  end
end
