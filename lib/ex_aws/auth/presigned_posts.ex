defmodule ExAws.Auth.PresignedPosts do
  @moduledoc false

  import ExAws.Auth.Utils
  alias ExAws.Auth.Credentials
  alias ExAws.Auth.PresignedPosts.PresignedPost

  def generate_presigned_post(config, bucket_name, key, opts \\ []) do
    datetime = Keyword.get(opts, :current_datetime, :calendar.universal_time)
    expires_in = Keyword.get(opts, :expires_in, 60 * 60) #seconds
    additional_fields = Keyword.get(opts, :fields, [])

    expiration = ExAws.Utils.add_seconds(datetime, expires_in)
    credential = Credentials.generate_credential_v4("s3", config, datetime)

    presigned_post =
      PresignedPost.new
      |> PresignedPost.set_expiration(expiration)
      |> PresignedPost.set_bucket(bucket_name)
      |> PresignedPost.put_field("key", key)
      |> PresignedPost.put_field("x-amz-algorithm", "AWS4-HMAC-SHA256")
      |> PresignedPost.put_field("x-amz-credential", credential)
      |> PresignedPost.put_field("x-amz-date", amz_date(datetime))
      |> add_additional_fields(additional_fields)

    %{
      url: base_url(config, bucket_name),
      form_fields: PresignedPost.fields_with_signature(presigned_post, config, datetime)
    }
  end

  defp add_additional_fields(presigned_post, additional_fields) do
    Enum.reduce(additional_fields, presigned_post, fn({field, value}, acc) ->
      PresignedPost.put_field(acc, field, value)
    end)
  end

  defp base_url(config, bucket_name) do
    "#{config.scheme}#{bucket_name}.#{config.host}"
  end
end
