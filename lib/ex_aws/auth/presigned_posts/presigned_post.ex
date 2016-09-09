defmodule ExAws.Auth.PresignedPosts.PresignedPost do
  @moduledoc false
  alias ExAws.Auth.PresignedPosts.Policy
  alias ExAws.Auth.Signatures

  @doc """
  Creates a new PresignedPost struct with a pre-initialized policy
  """
  def new do
    %{fields: %{}, policy: Policy.new }
  end

  @doc """
  Set the expiration datetime of this policy
  """
  def set_expiration(%{policy: policy} = presigned_post, datetime) do
    %{presigned_post | policy: Policy.set_expiration(policy, datetime)}
  end

  @doc """
  Adds a field to the presigned post
  """
  def put_field(%{fields: fields} = presigned_post, "key", value) do
    fields = Map.put(fields, "key", value)

    %{presigned_post | fields: fields}
    |> put_policy_condition(["starts-with", "$key", "#{Path.dirname(value)}/"])
  end
  def put_field(%{fields: fields} = presigned_post, field_name, value) do
    fields = Map.put(fields, field_name, value)

    %{presigned_post | fields: fields}
    |> put_policy_condition(%{field_name => value})
  end

  @doc """
  Adds a condition to the presigned post's policy
  """
  def put_policy_condition(%{policy: policy} = presigned_post, condition) do
    policy = Policy.add_condition(policy, condition)
    %{presigned_post | policy: policy}
  end

  @doc """
  Sets the bucket for a presigned post
  """
  def set_bucket(presigned_post, bucket_name) do
    put_policy_condition(presigned_post, %{"bucket" => bucket_name})
  end

  @doc """
  Returns all of the post fields
  """
  def fields_with_signature(presigned_post, config, datetime) do
    encoded_policy = Policy.encode(presigned_post.policy, config)
    signature = Signatures.generate_signature_v4(
      "s3", config, datetime, encoded_policy)

    presigned_post.fields
    |> Map.put("policy", encoded_policy)
    |> Map.put("x-amz-signature", signature)
  end
end
