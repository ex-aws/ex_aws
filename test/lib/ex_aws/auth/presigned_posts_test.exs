defmodule ExAws.Auth.PresignedPostsTest do
  use ExUnit.Case, async: true

  import ExAws.Auth.Utils
  alias ExAws.Auth.{Credentials, PresignedPosts, Signatures}
  alias ExAws.Auth.PresignedPosts.{Policy, PresignedPost}

  describe "generate_presigned_post/4" do
    test "integration test to ensure the post is generated correctly" do
      config = build_config
      bucket_name = "my-test-bucket"
      key = "my-test-folder/${filename}"
      datetime = {{2016,8,29},{19,41,33}}

      expected_policy =
        Policy.new
        |> Policy.set_expiration(datetime |> ExAws.Utils.add_seconds(3600))
        |> Policy.add_condition(%{"bucket" => bucket_name})
        |> Policy.add_condition(["starts-with", "$key", "my-test-folder/"])
        |> Policy.add_condition(%{"x-amz-algorithm" => "AWS4-HMAC-SHA256"})
        |> Policy.add_condition(%{"x-amz-credential" => Credentials.generate_credential_v4("s3", config, datetime)})
        |> Policy.add_condition(%{"x-amz-date" => amz_date(datetime)})
        |> Policy.add_condition(%{"content-type" => "application/json"})
        |> Policy.add_condition(%{"acl" => "public-read"})
        |> Policy.encode(config)

      result = PresignedPosts.generate_presigned_post(
        config,
        bucket_name,
        key,
        fields: [{"content-type", "application/json"},{"acl", "public-read"}],
        current_datetime: datetime)

      assert result == %{
        url: "#{config.scheme}#{bucket_name}.#{config.host}",
        form_fields: %{
          "key" => key,
          "x-amz-date" => amz_date(datetime),
          "x-amz-algorithm" => "AWS4-HMAC-SHA256",
          "x-amz-credential" => Credentials.generate_credential_v4("s3", config, datetime),
          "x-amz-signature" =>  Signatures.generate_signature_v4("s3", config, datetime, expected_policy),
          "content-type" => "application/json",
          "acl" => "public-read",
          "policy" => expected_policy,
        }
      }
    end

    test "generates the correct form fields with default options" do
      config = build_config()
      bucket_name = "my-test-bucket"
      key = "my-test-folder/${filename}"
      datetime = {{2016,8,29},{19,41,33}}

      result = PresignedPosts.generate_presigned_post(
        config,
        bucket_name,
        key,
        current_datetime: datetime)

      expected_presigned_post =
        PresignedPost.new
        |> PresignedPost.set_expiration(datetime |> ExAws.Utils.add_seconds(3600))
        |> PresignedPost.set_bucket(bucket_name)
        |> PresignedPost.put_field("key", key)
        |> PresignedPost.put_field("x-amz-algorithm", "AWS4-HMAC-SHA256")
        |> PresignedPost.put_field(
            "x-amz-credential", Credentials.generate_credential_v4("s3", config, datetime))
        |> PresignedPost.put_field("x-amz-date", amz_date(datetime))

      assert result.form_fields ==
        PresignedPost.fields_with_signature(expected_presigned_post, config, datetime)
    end

    test "returns the correct url for a us-west-2 bucket" do
      config = build_config(region: "us-west-2", host: "s3-us-west-2.amazonaws.com")
      bucket_name = "my-test-bucket"
      key = "my-test-folder/${filename}"

      result = PresignedPosts.generate_presigned_post(config, bucket_name, key)

      assert result.url == "https://my-test-bucket.s3-us-west-2.amazonaws.com"
    end

    test "returns the correct url for a us-east-1 bucket" do
      config = build_config(region: "us-east-1")
      bucket_name = "my-test-bucket"
      key = "my-test-folder/${filename}"

      result = PresignedPosts.generate_presigned_post(config, bucket_name, key)

      assert result.url == "https://my-test-bucket.s3.amazonaws.com"
    end
  end

  defp build_config(opts \\ []) do
    defaults = [
      access_key_id: "AKIAIOSFODNN7EXAMPLE",
      secret_access_key: "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
      region: "us-east-1"
    ]

    ExAws.Config.new(:s3, Keyword.merge(defaults, opts))
  end
end
