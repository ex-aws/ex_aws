defmodule ExAws.S3.Impl do
  import ExAws.S3.Request

  @moduledoc "See ExAws.S3.Adapter for documentation"

  ## Buckets
  #############

  def list_buckets(adapter) do
    request(adapter, :get, "", "/")
  end

  def delete_bucket(adapter, bucket) do
    request(adapter, :delete, bucket, "/")
  end

  def delete_bucket_cors(adapter, bucket) do
    request(adapter, :delete, bucket, "/")
  end

  def delete_bucket_lifecycle(adapter, bucket) do
    request(adapter, :delete, bucket, "/")
  end

  def delete_bucket_policy(adapter, bucket) do
    request(adapter, :delete, bucket, "/")
  end

  def delete_bucket_replication(adapter, bucket) do
    request(adapter, :delete, bucket, "/")
  end

  def delete_bucket_tagging(adapter, bucket) do
    request(adapter, :delete, bucket, "/")
  end

  def delete_bucket_website(adapter, bucket) do
    request(adapter, :delete, bucket, "/")
  end

  def get_bucket_objects(adapter, bucket) do
    request(adapter, :get, bucket, "/")
  end

  def get_bucket_acl(adapter, bucket) do
    request(adapter, :get, bucket, "/")
  end

  def get_bucket_cors(adapter, bucket) do
    request(adapter, :get, bucket, "/")
  end

  def get_bucket_lifecycle(adapter, bucket) do
    request(adapter, :get, bucket, "/")
  end

  def get_bucket_policy(adapter, bucket) do
    request(adapter, :get, bucket, "/")
  end

  def get_bucket_location(adapter, bucket) do
    request(adapter, :get, bucket, "/")
  end

  def get_bucket_logging(adapter, bucket) do
    request(adapter, :get, bucket, "/")
  end

  def get_bucket_notification(adapter, bucket) do
    request(adapter, :get, bucket, "/")
  end

  def get_bucket_replication(adapter, bucket) do
    request(adapter, :get, bucket, "/")
  end

  def get_bucket_tagging(adapter, bucket) do
    request(adapter, :get, bucket, "/")
  end

  def get_bucket_object_versions(adapter, bucket) do
    request(adapter, :get, bucket, "/")
  end

  def get_bucket_request_payment(adapter, bucket) do
    request(adapter, :get, bucket, "/")
  end

  def get_bucket_versioning(adapter, bucket) do
    request(adapter, :get, bucket, "/")
  end

  def get_bucket_website(adapter, bucket) do
    request(adapter, :get, bucket, "/")
  end

  def head_bucket(adapter, bucket) do
    request(adapter, :head, bucket, "/")
  end

  def list_multipart_uploads(adapter, bucket, opts) do
    request(adapter, :get, bucket, "/")
  end

  def put_bucket(adapter, bucket, region) do
    request(adapter, :put, bucket, "/")
  end

  def put_bucket_acl(adapter, bucket, owner_id, owner_email, grants) do
    request(adapter, :put, bucket, "/")
  end

  def put_bucket_cors(adapter, bucket, cors_config) do
    request(adapter, :put, bucket, "/")
  end

  def put_bucket_lifecycle(adapter, bucket, livecycle_config) do
    request(adapter, :put, bucket, "/")
  end

  def put_bucket_policy(adapter, bucket, policy) do
    request(adapter, :put, bucket, "/")
  end

  def put_bucket_logging(adapter, bucket, logging_config) do
    request(adapter, :put, bucket, "/")
  end

  def put_bucket_notification(adapter, bucket, notification_config) do
    request(adapter, :put, bucket, "/")
  end

  def put_bucket_replication(adapter, bucket, replication_config) do
    request(adapter, :put, bucket, "/")
  end

  def put_bucket_tagging(adapter, bucket, tags) do
    request(adapter, :put, bucket, "/")
  end

  def put_bucket_requestpayment(adapter, bucket, payer) do
    request(adapter, :put, bucket, "/")
  end

  def put_bucket_versioning(adapter, bucket, version_config) do
    request(adapter, :put, bucket, "/")
  end

  def put_bucket_website(adapter, bucket, website_config) do
    request(adapter, :put, bucket, "/")
  end

  def delete_object(adapter, bucket) do
    request(adapter, :delete, bucket, "/")
  end

  def delete_multiple_objects(adapter, bucket, objects) do
    request(adapter, :post, bucket, "/")
  end

  ## Objects
  ###########

  def delete_object(adapter, bucket, object) do
    request(adapter, :delete, bucket, object)
  end

  def get_object(adapter, bucket, object, opts) do
    request(adapter, :get, bucket, object)
  end

  def get_object_acl(adapter, bucket, object, opts) do
    request(adapter, :get, bucket, object)
  end

  def get_object_torrent(adapter, bucket, object) do
    request(adapter, :get, bucket, object)
  end

  def head_object(adapter, bucket, object, opts) do
    request(adapter, :head, bucket, object)
  end

  def options_object(adapter, bucket, object, origin, request_method, request_headers) do
    request(adapter, :get, bucket, object)
  end

  def post_object(adapter, bucket, object) do
    request(adapter, :get, bucket, object)
  end

  def post_object_restore(adapter, bucket, object, version_id, number_of_days) do
    request(adapter, :get, bucket, object)
  end

  def put_object(adapter, bucket, object, opts) do
    request(adapter, :get, bucket, object)
  end

  def put_object_acl(adapter, bucket, object, acl) do
    request(adapter, :get, bucket, object)
  end

  def put_object_copy(adapter, dest_bucket, dest_object, src_bucket, src_object, opts) do
    request(adapter, :get, dest_bucket, dest_object)
  end

  def initiate_multipart_upload(adapter, bucket, object) do
    request(adapter, :get, bucket, object)
  end

  def upload_part(adapter, bucket, object, upload_id, part_number) do
    request(adapter, :get, bucket, object)
  end

  def upload_part_copy(adapter, dest_bucket, dest_object, src_bucket, src_object, opts) do
    request(adapter, :get, dest_bucket, dest_object)
  end

  def complete_multipart_upload(adapter, bucket, object, upload_id, parts) do
    request(adapter, :get, bucket, object)
  end

  def abort_multipart_upload(adapter, bucket, object) do
    request(adapter, :get, bucket, object)
  end

  def list_parts(adapter, bucket, object) do
    request(adapter, :ge, bucket, object)
  end

end
