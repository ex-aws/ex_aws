defmodule ExAws.S3.Impl do
  import ExAws.S3.Utils
  alias ExAws.S3.Parsers
  alias ExAws.Config

  @moduledoc false
  # Implementation of the AWS S3 API.
  #
  # See ExAws.S3.Client for usage.

  ## Buckets
  #############

  defdelegate stream_objects!(client, bucket), to: ExAws.S3.Lazy
  defdelegate stream_objects!(client, bucket, opts), to: ExAws.S3.Lazy

  def list_buckets(client, opts \\ []) do
    client = opts
    |> Keyword.get(:client, [])
    |> apply_client_options(client)

    opts = opts
    |> Keyword.delete(:client)

    request(client, :get, "", "/", params: opts)
  end

  def delete_bucket(client, bucket) do
    request(client, :delete, bucket, "/")
  end

  def delete_bucket_cors(client, bucket) do
    request(client, :delete, bucket, "/", resource: "cors")
  end

  def delete_bucket_lifecycle(client, bucket) do
    request(client, :delete, bucket, "/", resource: "lifecycle")
  end

  def delete_bucket_policy(client, bucket) do
    request(client, :delete, bucket, "/", resource: "policy")
  end

  def delete_bucket_replication(client, bucket) do
    request(client, :delete, bucket, "/", resource: "replication")
  end

  def delete_bucket_tagging(client, bucket) do
    request(client, :delete, bucket, "/", resource: "tagging")
  end

  def delete_bucket_website(client, bucket) do
    request(client, :delete, bucket, "/", resource: "website")
  end

  @params [:delimiter, :marker, :prefix, :encoding_type, :max_keys]
  def list_objects(client, bucket, opts \\ []) do
    client = opts
    |> Keyword.get(:client, [])
    |> apply_client_options(client)

    params = opts
    |> format_and_take(@params)

    request(client, :get, bucket, "/", params: params)
    |> Parsers.parse_list_objects
  end

  def list_objects!(client, bucket, opts \\ []) do
    {:ok, resp} = list_objects(client, bucket, opts)
    resp
  end

  def get_bucket_acl(client, bucket) do
    request(client, :get, bucket, "/", resource: "acl")
  end

  def get_bucket_cors(client, bucket) do
    request(client, :get, bucket, "/", resource: "cors")
  end

  def get_bucket_lifecycle(client, bucket) do
    request(client, :get, bucket, "/", resource: "lifecycle")
  end

  def get_bucket_policy(client, bucket) do
    request(client, :get, bucket, "/", resource: "policy")
  end

  def get_bucket_location(client, bucket) do
    request(client, :get, bucket, "/", resource: "location")
  end

  def get_bucket_logging(client, bucket) do
    request(client, :get, bucket, "/", resource: "logging")
  end

  def get_bucket_notification(client, bucket) do
    request(client, :get, bucket, "/", resource: "notification")
  end

  def get_bucket_replication(client, bucket) do
    request(client, :get, bucket, "/", resource: "replication")
  end

  def get_bucket_tagging(client, bucket) do
    request(client, :get, bucket, "/", resource: "tagging")
  end

  def get_bucket_object_versions(client, bucket, opts \\ []) do
    request(client, :get, bucket, "/", resource: "versions", params: opts)
  end

  def get_bucket_request_payment(client, bucket) do
    request(client, :get, bucket, "/", resource: "requestPayment")
  end

  def get_bucket_versioning(client, bucket) do
    request(client, :get, bucket, "/", resource: "versioning")
  end

  def get_bucket_website(client, bucket) do
    request(client, :get, bucket, "/", resource: "website")
  end

  def head_bucket(client, bucket) do
    request(client, :head, bucket, "/")
  end

  @params [:delimiter, :encoding_type, :max_uploads, :key_marker, :prefix, :upload_id_marker]
  def list_multipart_uploads(client, bucket, opts \\ []) do
    params = opts |> format_and_take(@params)
    request(client, :get, bucket, "/", resource: "uploads", params: params)
  end

  def put_bucket(client, bucket, region, opts \\ []) do
    client = opts
    |> Keyword.get(:client, [])
    |> apply_client_options(client)

    headers = opts
    |> Enum.into(%{})
    |> format_acl_headers

    body = """
    <CreateBucketConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
      <LocationConstraint>#{region}</LocationConstraint>
    </CreateBucketConfiguration>
    """
    request(client, :put, bucket, "/", body: body, headers: headers)
  end

  def put_bucket_acl(client, bucket, grants) do
    request(client, :put, bucket, "/", headers: format_acl_headers(grants))
  end

  def put_bucket_cors(client, bucket, cors_rules) do
    rules = cors_rules
    |> Enum.map(&build_cors_rule/1)
    |> IO.iodata_to_binary

    body = "<CORSConfiguration>#{rules}</CORSConfiguration>"
    request(client, :put, bucket, "/", body: body)
  end

  def put_bucket_lifecycle(client, bucket, _livecycle_config) do
    raise "not yet implemented"
    request(client, :put, bucket, "/")
  end

  def put_bucket_policy(client, bucket, policy) when is_binary(policy) do
    request(client, :put, bucket, "/", resource: "policy", body: policy)
  end

  def put_bucket_policy(client, bucket, policy) do
    put_bucket_policy(client, bucket, client.config.json_codec.encode!(policy))
  end

  def put_bucket_logging(client, bucket, _logging_config) do
    raise "not yet implemented"
    request(client, :put, bucket, "/")
  end

  def put_bucket_notification(client, bucket, _notification_config) do
    raise "not yet implemented"
    request(client, :put, bucket, "/")
  end

  def put_bucket_replication(client, bucket, _replication_config) do
    raise "not yet implemented"
    request(client, :put, bucket, "/")
  end

  def put_bucket_tagging(client, bucket, _tags) do
    raise "not yet implemented"
    request(client, :put, bucket, "/")
  end

  def put_bucket_request_payment(client, bucket, _payer) do
    raise "not yet implemented"
    request(client, :put, bucket, "/")
  end

  def put_bucket_versioning(client, bucket, _version_config) do
    raise "not yet implemented"
    request(client, :put, bucket, "/")
  end

  def put_bucket_website(client, bucket, _website_config) do
    raise "not yet implemented"
    request(client, :put, bucket, "/")
  end

  ## Objects
  ###########

  def delete_object(client, bucket, object, opts \\ []) do
    client = opts
    |> Keyword.get(:client, [])
    |> apply_client_options(client)

    request(client, :delete, bucket, object, headers: opts |> Enum.into(%{}))
  end
  def delete_object!(client, bucket, object, opts \\ []) do
    {:ok, resp} = delete_object(client, bucket, object, opts)
    resp
  end

  def delete_multiple_objects(client, bucket, objects, opts \\ []) do
    objects_xml = Enum.map(objects, fn
      {key, version} -> ["<Object><Key>", key, "</Key><VersionId>", version, "</VersionId></Object>"]
      key -> ["<Object><Key>", key, "</Key></Object>"]
    end)

    quiet = case opts do
      [quiet: true] -> "<Quiet>true</Quiet>"
      _ -> ""
    end

    body = [
      ~s(<?xml version="1.0" encoding="UTF-8"?>),
      quiet,
      "<Delete>",
      objects_xml,
      "</Delete>"
    ]

    content_md5 = :crypto.hash(:md5, body) |> Base.encode64
    body_binary = body |> IO.iodata_to_binary

    request(client, :post, bucket, "/?delete", body: body_binary, headers: %{"content-md5" => content_md5})
  end

  @response_params [:content_type, :content_language, :expires, :cache_control, :content_disposition, :content_encoding]
  @request_headers [:range, :if_modified_since, :if_unmodified_since, :if_match, :if_none_match]
  def get_object(client, bucket, object, opts \\ []) do
    opts = opts |> Enum.into(%{})

    client = opts
    |> Map.get(:client, [])
    |> apply_client_options(client)

    response_opts = opts
    |> Map.get(:response, %{})
    |> format_and_take(@response_params)
    |> namespace("response")

    headers = opts
    |> format_and_take(@request_headers)

    headers = opts
    |> Map.get(:encryption, %{})
    |> build_encryption_headers
    |> Map.merge(headers)

    request(client, :get, bucket, object, headers: headers, params: response_opts)
  end

  def get_object!(client, bucket, object, opts \\ []) do
    {:ok, resp} = get_object(client, bucket, object, opts)
    resp
  end

  def get_object_acl(client, bucket, object, opts \\ []) do
    request(client, :get, bucket, object, resource: "acl", headers: opts |> Enum.into(%{}))
  end

  def get_object_torrent(client, bucket, object) do
    request(client, :get, bucket, object, resource: "torrent")
  end

  @request_headers [:range, :if_modified_since, :if_unmodified_since, :if_match, :if_none_match]
  def head_object(client, bucket, object, opts \\ []) do
    opts = opts |> Enum.into(%{})

    client = opts
    |> Map.get(:client, [])
    |> apply_client_options(client)

    headers = opts
    |> format_and_take(@request_headers)

    headers = opts
    |> Map.get(:encryption, %{})
    |> build_encryption_headers
    |> Map.merge(headers)

    params = case Map.fetch(opts, :version_id) do
      {:ok, id} -> %{"versionId" => id}
      _ -> %{}
    end
    request(client, :head, bucket, object, headers: headers, params: params)
  end

  def options_object(client, bucket, object, origin, request_method, request_headers \\ []) do
    headers = [
      {"Origin", origin},
      {"Access-Control-Request-Method", request_method},
      {"Access-Control-Request-Headers", request_headers |> Enum.join(",")},
    ]
    request(client, :options, bucket, object, headers: headers)
  end

  def post_object_restore(client, bucket, object, number_of_days, opts \\ []) do
    params = case Keyword.fetch(opts, :version_id) do
      {:ok, id} -> %{"versionId" => id}
      _ -> %{}
    end

    body = """
    <RestoreRequest xmlns="http://s3.amazonaws.com/doc/2006-3-01">
      <Days>#{number_of_days}</Days>
    </RestoreRequest>
    """
    request(client, :post, bucket, object, resource: "restore", params: params, body: body)
  end

  def put_object(client, bucket, object, body, opts \\ []) do
    request(client, :put, bucket, object, body: body, headers: put_object_headers(opts))
  end

  def put_object!(client, bucket, object, body, opts \\ []) do
    {:ok, resp} = put_object(client, bucket, object, body, opts)
    resp
  end

  def put_object_acl(client, bucket, object, acl) do
    headers = acl |> Enum.into(%{}) |> format_acl_headers
    request(client, :put, bucket, object, headers: headers, resource: "acl")
  end

  def put_object_acl!(client, bucket, object, acl) do
    {:ok, result} = put_object_acl(client, bucket, object, acl)
    result
  end

  @amz_headers ~w(
    metadata_directive
    copy_source_if_modified_since
    copy_source_if_unmodified_since
    copy_source_if_match
    copy_source_if_none_match
    storage_class
    website_redirect_location)a
  def put_object_copy(client, dest_bucket, dest_object, src_bucket, src_object, opts \\ []) do
    opts = opts |> Enum.into(%{})

    client = opts
    |> Map.get(:client, [])
    |> apply_client_options(client)

    amz_headers = opts
    |> format_and_take(@amz_headers)
    |> namespace("x-amz")

    source_encryption = opts
    |> Map.get(:source_encryption, %{})
    |> build_encryption_headers
    |> Enum.into(%{}, fn {<<"x-amz", k :: binary>>, v} ->
      {"x-amz-copy-source" <> k, v}
    end)

    destination_encryption = opts
    |> Map.get(:destination_encryption, %{})
    |> build_encryption_headers

    regular_headers = opts
    |> Map.delete(:encryption)
    |> put_object_headers

    headers = regular_headers
    |> Map.merge(amz_headers)
    |> Map.merge(source_encryption)
    |> Map.merge(destination_encryption)
    |> Map.put("x-amz-copy-source", URI.encode "/#{src_bucket}/#{src_object}")

    request(client, :put, dest_bucket, dest_object, headers: headers)
  end

  def put_object_copy!(client, dest_bucket, dest_object, src_bucket, src_object, opts \\ []) do
    {:ok, resp} = put_object_copy(client, dest_bucket, dest_object, src_bucket, src_object, opts)
    resp
  end

  def initiate_multipart_upload(client, bucket, object, opts \\ []) do
    request(client, :post, bucket, object, resource: "uploads", headers: put_object_headers(opts))
    |> Parsers.parse_initiate_multipart_upload
  end

  def upload_part(client, bucket, object, upload_id, part_number, body, _opts \\ []) do
    params = %{"uploadId" => upload_id, "partNumber" => part_number}
    request(client, :put, bucket, object, params: params, body: body)
  end

  @amz_headers ~w(
    copy_source_if_modified_since
    copy_source_if_unmodified_since
    copy_source_if_match
    copy_source_if_none_match)a
  def upload_part_copy(client, dest_bucket, dest_object, src_bucket, src_object, opts \\ []) do
    opts = opts |> Enum.into(%{})

    source_encryption = opts
    |> Map.get(:source_encryption, %{})
    |> build_encryption_headers
    |> Enum.into(%{}, fn {<<"x-amz", k :: binary>>, v} ->
      {"x-amz-copy-source" <> k, v}
    end)

    destination_encryption = opts
    |> Map.get(:destination_encryption, %{})
    |> build_encryption_headers

    headers = opts
    |> format_and_take(@amz_headers)
    |> namespace("x-amz")
    |> Map.merge(source_encryption)
    |> Map.merge(destination_encryption)

    headers = case opts do
      %{copy_source_range: first..last} -> Map.put(headers, "x-amz-copy-source-range", "bytes=#{first}-#{last}")
      _ -> headers
    end
    |> Map.put("x-amz-copy-source", "/#{src_bucket}/#{src_object}")

    request(client, :put, dest_bucket, dest_object, headers: headers)
    |> Parsers.parse_upload_part_copy
  end

  def complete_multipart_upload(client, bucket, object, upload_id, parts) do
    parts_xml = parts
    |> Enum.map(fn {part_number, etag}->
      ["<Part>",
        "<PartNumber>", Integer.to_string(part_number), "</PartNumber>",
        "<ETag>", etag, "</ETag>",
      "</Part>"]
    end)

    body = ["<CompleteMultipartUpload>", parts_xml, "</CompleteMultipartUpload>"]
    |> IO.iodata_to_binary

    request(client, :post, bucket, object, params: %{"uploadId" => upload_id}, body: body)
    |> Parsers.parse_complete_multipart_upload
  end

  def abort_multipart_upload(client, bucket, object, upload_id) do
    request(client, :delete, bucket, object, params: %{"uploadId" => upload_id})
  end

  def list_parts(client, bucket, object, upload_id, opts \\ []) do
    params = opts
    |> Enum.into(%{})
    |> Map.merge(%{"uploadId" => upload_id})

    request(client, :get, bucket, object, params: params)
    |> Parsers.parse_list_parts
  end

  @one_week 60 * 60 * 24 * 7
  def presigned_url(client, http_method, bucket, object, opts \\ []) do
    expires_in = Keyword.get(opts, :expires_in, 3600)
    virtual_host = Keyword.get(opts, :virtual_host, false)
    case expires_in > @one_week do
      true -> {:error, "expires_in_exceeds_one_week"}
      false ->
        config = Config.parse_host_for_region(client).config
        url = url_to_sign(bucket, object, config, virtual_host)
        datetime = :calendar.universal_time
        {:ok, ExAws.Auth.presigned_url(
            http_method, url, client.service, datetime, client.config, expires_in)}
    end
  end

  defp request(%{__struct__: client_module} = client, action, bucket, path, data \\ []) do
    client_module.request(client, action, bucket, path, data)
  end

  defp url_to_sign(bucket, object, config, virtual_host) do
    object = ExAws.S3.Request.ensure_slash(object)
    case virtual_host do
      true -> "#{config[:scheme]}#{bucket}.#{config[:host]}#{object}"
      false -> "#{config[:scheme]}#{config[:host]}/#{bucket}#{object}"
    end
  end
end
