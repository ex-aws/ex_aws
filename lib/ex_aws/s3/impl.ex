defmodule ExAws.S3.Impl do
  import ExAws.S3.Request

  @moduledoc "See ExAws.S3.Adapter for documentation"

  ## Buckets
  #############

  def list_buckets(adapter, opts) do
    adapter.request(:get, "", "/", params: opts)
  end

  def delete_bucket(adapter, bucket) do
    adapter.request(:delete, bucket, "/")
  end

  def delete_bucket_cors(adapter, bucket) do
    adapter.request(:delete, bucket, "/", resource: "cors")
  end

  def delete_bucket_lifecycle(adapter, bucket) do
    adapter.request(:delete, bucket, "/", resource: "lifecycle")
  end

  def delete_bucket_policy(adapter, bucket) do
    adapter.request(:delete, bucket, "/", resource: "policy")
  end

  def delete_bucket_replication(adapter, bucket) do
    adapter.request(:delete, bucket, "/", resource: "replication")
  end

  def delete_bucket_tagging(adapter, bucket) do
    adapter.request(:delete, bucket, "/", resource: "tagging")
  end

  def delete_bucket_website(adapter, bucket) do
    adapter.request(:delete, bucket, "/", resource: "website")
  end

  def list_objects(adapter, bucket, opts) do
    adapter.request(:get, bucket, "/", params: opts)
  end

  def get_bucket_acl(adapter, bucket) do
    adapter.request(:get, bucket, "/", resource: "acl")
  end

  def get_bucket_cors(adapter, bucket) do
    adapter.request(:get, bucket, "/", resource: "cors")
  end

  def get_bucket_lifecycle(adapter, bucket) do
    adapter.request(:get, bucket, "/", resource: "lifecycle")
  end

  def get_bucket_policy(adapter, bucket) do
    adapter.request(:get, bucket, "/", resource: "policy")
  end

  def get_bucket_location(adapter, bucket) do
    adapter.request(:get, bucket, "/", resource: "location")
  end

  def get_bucket_logging(adapter, bucket) do
    adapter.request(:get, bucket, "/", resource: "logging")
  end

  def get_bucket_notification(adapter, bucket) do
    adapter.request(:get, bucket, "/", resource: "notification")
  end

  def get_bucket_replication(adapter, bucket) do
    adapter.request(:get, bucket, "/", resource: "replication")
  end

  def get_bucket_tagging(adapter, bucket) do
    adapter.request(:get, bucket, "/", resource: "tagging")
  end

  def get_bucket_object_versions(adapter, bucket, opts) do
    adapter.request(:get, bucket, "/", resource: "versions", params: opts)
  end

  def get_bucket_request_payment(adapter, bucket) do
    adapter.request(:get, bucket, "/", resource: "requestPayment")
  end

  def get_bucket_versioning(adapter, bucket) do
    adapter.request(:get, bucket, "/", resource: "versioning")
  end

  def get_bucket_website(adapter, bucket) do
    adapter.request(:get, bucket, "/", resource: "website")
  end

  def head_bucket(adapter, bucket) do
    adapter.request(:head, bucket, "/")
  end

  def list_multipart_uploads(adapter, bucket, opts) do
    adapter.request(:get, bucket, "/", resource: "uploads", params: opts)
  end

  def put_bucket(adapter, bucket, region, opts) do
    body = """
    <CreateBucketConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
      <LocationConstraint>#{region}</LocationConstraint>
    </CreateBucketConfiguration>
    """
    adapter.request(:put, bucket, "/", body: body, headers: opts)
  end

  def put_bucket_acl(adapter, bucket, _owner_id, _owner_email, _grants) do
    raise "not yet implimented"
    adapter.request(:put, bucket, "/")
  end

  def put_bucket_cors(adapter, bucket, _cors_config) do
    raise "not yet implimented"
    adapter.request(:put, bucket, "/")
  end

  def put_bucket_lifecycle(adapter, bucket, _livecycle_config) do
    raise "not yet implimented"
    adapter.request(:put, bucket, "/")
  end

  def put_bucket_policy(adapter, bucket, _policy) do
    raise "not yet implimented"
    adapter.request(:put, bucket, "/")
  end

  def put_bucket_logging(adapter, bucket, _logging_config) do
    raise "not yet implimented"
    adapter.request(:put, bucket, "/")
  end

  def put_bucket_notification(adapter, bucket, _notification_config) do
    raise "not yet implimented"
    adapter.request(:put, bucket, "/")
  end

  def put_bucket_replication(adapter, bucket, _replication_config) do
    raise "not yet implimented"
    adapter.request(:put, bucket, "/")
  end

  def put_bucket_tagging(adapter, bucket, _tags) do
    raise "not yet implimented"
    adapter.request(:put, bucket, "/")
  end

  def put_bucket_requestpayment(adapter, bucket, _payer) do
    raise "not yet implimented"
    adapter.request(:put, bucket, "/")
  end

  def put_bucket_versioning(adapter, bucket, _version_config) do
    raise "not yet implimented"
    adapter.request(:put, bucket, "/")
  end

  def put_bucket_website(adapter, bucket, _website_config) do
    raise "not yet implimented"
    adapter.request(:put, bucket, "/")
  end

  ## Objects
  ###########

  def delete_object(adapter, bucket, object, opts) do
    adapter.request(:delete, bucket, object, headers: opts)
  end

  def delete_multiple_objects(adapter, bucket, objects) do
    raise "not yet implimented"
    adapter.request(:post, bucket, "/?delete")
  end

  def get_object(adapter, bucket, object, opts) do
    param_keys = ["response-content-type", "response-content-language", "response-expires", "response-cache-control", "response-content-disposition", "response-content-encoding"]
    response_opts = opts
    |> Map.take(param_keys)
    headers = :maps.without(param_keys, opts)
    adapter.request(:get, bucket, object, headers: headers, params: response_opts)
  end

  def get_object_acl(adapter, bucket, object, opts) do
    adapter.request(:get, bucket, object, resource: "acl", headers: opts)
  end

  def get_object_torrent(adapter, bucket, object) do
    adapter.request(:get, bucket, object, resource: "torrent")
  end

  def head_object(adapter, bucket, object, opts) do
    adapter.request(:head, bucket, object, headers: opts)
  end

  def options_object(adapter, bucket, object, origin, request_method, request_headers) do
    headers = [
      {"Origin", origin},
      {"Access-Control-Request-Method", request_method},
      {"Access-Control-Request-Headers", request_headers |> Enum.join(",")},
    ]
    adapter.request(:options, bucket, object, headers: headers)
  end

  def post_object(adapter, bucket, object) do
    raise "not yet implimented"
    adapter.request(:get, bucket, object)
  end

  def post_object_restore(adapter, bucket, object, _version_id, _number_of_days) do
    raise "not yet implimented"
    adapter.request(:get, bucket, object)
  end

  def put_object(adapter, bucket, object, body, opts) do
    headers = [
      {"Content-Type", "binary/octet-stream"} |
      opts |> Map.to_list
    ]
    adapter.request(:put, bucket, object, body: body, headers: headers)
  end

  def put_object_acl(adapter, bucket, object, _acl) do
    raise "not yet implimented"
    adapter.request(:get, bucket, object)
  end

  def put_object_copy(adapter, dest_bucket, dest_object, _src_bucket, _src_object, _opts) do
    raise "not yet implimented"
    adapter.request(:get, dest_bucket, dest_object)
  end

  def initiate_multipart_upload(adapter, bucket, object) do
    raise "not yet implimented"
    adapter.request(:get, bucket, object)
  end

  def upload_part(adapter, bucket, object, _upload_id, _part_number) do
    raise "not yet implimented"
    adapter.request(:get, bucket, object)
  end

  def upload_part_copy(adapter, dest_bucket, dest_object, _src_bucket, _src_object, _opts) do
    raise "not yet implimented"
    adapter.request(:get, dest_bucket, dest_object)
  end

  def complete_multipart_upload(adapter, bucket, object, _upload_id, _parts) do
    raise "not yet implimented"
    adapter.request(:get, bucket, object)
  end

  def abort_multipart_upload(adapter, bucket, object) do
    raise "not yet implimented"
    adapter.request(:get, bucket, object)
  end

  def list_parts(adapter, bucket, object, upload_id, opts) do
    params = %{"uploadId" => upload_id}
    |> Map.merge(opts)
    adapter.request(:get, bucket, object, params: params)
  end

end
