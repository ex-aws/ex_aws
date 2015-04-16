defmodule ExAws.S3.Impl do
  use ExAws.Actions
  import ExAws.S3.Request

  @namespace "S3"
  @actions [
    delete_bucket: :delete,
    delete_bucket_cors: :delete,
    delete_bucket_lifecycle: :delete,
    delete_bucket_policy: :delete,
    delete_bucket_replication: :delete,
    delete_bucket_tagging: :delete,
    delete_bucket_website: :delete,
    list_buckets: :get,
    get_bucket_objects: :get,
    get_bucket_acl: :get,
    get_bucket_cors: :get,
    get_bucket_lifecycle: :get,
    get_bucket_policy: :get,
    get_bucket_location: :get,
    get_bucket_logging: :get,
    get_bucket_notification: :get,
    get_bucket_replication: :get,
    get_bucket_tagging: :get,
    get_bucket_object_versions: :get,
    get_bucket_request_payment: :get,
    get_bucket_versioning: :get,
    get_bucket_website: :get,
    head_bucket: :head,
    list_multipart_uploads: :get,
    put_bucket: :put,
    create_bucket: :put,
    put_bucket_acl: :put,
    put_bucket_cors: :put,
    put_bucket_lifecycle: :put,
    put_bucket_policy: :put,
    put_bucket_logging: :put,
    put_bucket_notification: :put,
    put_bucket_replication: :put,
    put_bucket_tagging: :put,
    put_bucket_requestpayment: :put,
    put_bucket_versioning: :put,
    put_bucket_website: :put,
    delete_object: :delete,
    delete_multiple_objects: :post,
    get_object: :get,
    get_object_acl: :get,
    get_object_torrent: :get,
    head_object: :head,
    head_object: :get,
    options_object: :get,
    post_object: :get,
    post_object_restore: :get,
    put_object: :get,
    put_object_acl: :get,
    put_object_copy: :get,
    initiate_multipart_upload: :get,
    upload_part: :get,
    upload_part_copy: :get,
    complete_multipart_upload: :get,
    abort_multipart_upload: :get,
    list_parts: :get]

  @moduledoc "See ExAws.S3.Adapter for documentation"

  def delete_bucket(adapter, bucket) do
    request(%{}, :delete_bucket, "/", adapter)
  end

  def delete_bucket_cors(adapter, bucket) do
    request(%{}, :delete_bucket_cors, "/", adapter)
  end

  def delete_bucket_lifecycle(adapter, bucket) do
    request(%{}, :delete_bucket_lifecycle, "/", adapter)
  end

  def delete_bucket_policy(adapter, bucket) do
    request(%{}, :delete_bucket_policy, "/", adapter)
  end

  def delete_bucket_replication(adapter, bucket) do
    request(%{}, :delete_bucket_replication, "/", adapter)
  end

  def delete_bucket_tagging(adapter, bucket) do
    request(%{}, :delete_bucket_tagging, "/", adapter)
  end

  def delete_bucket_website(adapter, bucket) do
    request(%{}, :delete_bucket_website, "/", adapter)
  end

  def list_buckets(adapter, bucket) do
    request(%{}, :list_buckets, "/", adapter)
  end

  def get_bucket_objects(adapter, bucket) do
    request(%{}, :get_bucket_objects, "/", adapter)
  end

  def get_bucket_acl(adapter, bucket) do
    request(%{}, :get_bucket_acl, "/", adapter)
  end

  def get_bucket_cors(adapter, bucket) do
    request(%{}, :get_bucket_cors, "/", adapter)
  end

  def get_bucket_lifecycle(adapter, bucket) do
    request(%{}, :get_bucket_lifecycle, "/", adapter)
  end

  def get_bucket_policy(adapter, bucket) do
    request(%{}, :get_bucket_policy, "/", adapter)
  end

  def get_bucket_location(adapter, bucket) do
    request(%{}, :get_bucket_location, "/", adapter)
  end

  def get_bucket_logging(adapter, bucket) do
    request(%{}, :get_bucket_logging, "/", adapter)
  end

  def get_bucket_notification(adapter, bucket) do
    request(%{}, :get_bucket_notification, "/", adapter)
  end

  def get_bucket_replication(adapter, bucket) do
    request(%{}, :get_bucket_replication, "/", adapter)
  end

  def get_bucket_tagging(adapter, bucket) do
    request(%{}, :get_bucket_tagging, "/", adapter)
  end

  def get_bucket_object_versions(adapter, bucket) do
    request(%{}, :get_bucket_object_versions, "/", adapter)
  end

  def get_bucket_request_payment(adapter, bucket) do
    request(%{}, :get_bucket_request_payment, "/", adapter)
  end

  def get_bucket_versioning(adapter, bucket) do
    request(%{}, :get_bucket_versioning, "/", adapter)
  end

  def get_bucket_website(adapter, bucket) do
    request(%{}, :get_bucket_website, "/", adapter)
  end

  def head_bucket(adapter, bucket) do
    request(%{}, :head_bucket, "/", adapter)
  end

  def list_multipart_uploads(adapter, bucket) do
    request(%{}, :list_multipart_uploads, "/", adapter)
  end

  def put_bucket(adapter, bucket) do
    request(%{}, :put_bucket, "/", adapter)
  end

  def create_bucket(adapter, bucket) do
    request(%{}, :create_bucket, "/", adapter)
  end

  def put_bucket_acl(adapter, bucket) do
    request(%{}, :put_bucket_acl, "/", adapter)
  end

  def put_bucket_cors(adapter, bucket) do
    request(%{}, :put_bucket_cors, "/", adapter)
  end

  def put_bucket_lifecycle(adapter, bucket) do
    request(%{}, :put_bucket_lifecycle, "/", adapter)
  end

  def put_bucket_policy(adapter, bucket) do
    request(%{}, :put_bucket_policy, "/", adapter)
  end

  def put_bucket_logging(adapter, bucket) do
    request(%{}, :put_bucket_logging, "/", adapter)
  end

  def put_bucket_notification(adapter, bucket) do
    request(%{}, :put_bucket_notification, "/", adapter)
  end

  def put_bucket_replication(adapter, bucket) do
    request(%{}, :put_bucket_replication, "/", adapter)
  end

  def put_bucket_tagging(adapter, bucket) do
    request(%{}, :put_bucket_tagging, "/", adapter)
  end

  def put_bucket_requestpayment(adapter, bucket) do
    request(%{}, :put_bucket_requestpayment, "/", adapter)
  end

  def put_bucket_versioning(adapter, bucket) do
    request(%{}, :put_bucket_versioning, "/", adapter)
  end

  def put_bucket_website(adapter, bucket) do
    request(%{}, :put_bucket_website, "/", adapter)
  end

  def delete_object(adapter, bucket) do
    request(%{}, :delete_object, "/", adapter)
  end

  def delete_multiple_objects(adapter, bucket) do
    request(%{}, :delete_multiple_objects, "/", adapter)
  end

  def get_object(adapter, bucket) do
    request(%{}, :get_object, "/", adapter)
  end

  def get_object_acl(adapter, bucket) do
    request(%{}, :get_object_acl, "/", adapter)
  end

  def get_object_torrent(adapter, bucket) do
    request(%{}, :get_object_torrent, "/", adapter)
  end

  def head_object(adapter, bucket) do
    request(%{}, :head_object, "/", adapter)
  end

  def head_object(adapter, bucket) do
    request(%{}, :head_object, "/", adapter)
  end

  def options_object(adapter, bucket) do
    request(%{}, :options_object, "/", adapter)
  end

  def post_object(adapter, bucket) do
    request(%{}, :post_object, "/", adapter)
  end

  def post_object_restore(adapter, bucket) do
    request(%{}, :post_object_restore, "/", adapter)
  end

  def put_object(adapter, bucket) do
    request(%{}, :put_object, "/", adapter)
  end

  def put_object_acl(adapter, bucket) do
    request(%{}, :put_object_acl, "/", adapter)
  end

  def put_object_copy(adapter, bucket) do
    request(%{}, :put_object_copy, "/", adapter)
  end

  def initiate_multipart_upload(adapter, bucket) do
    request(%{}, :initiate_multipart_upload, "/", adapter)
  end

  def upload_part(adapter, bucket) do
    request(%{}, :upload_part, "/", adapter)
  end

  def upload_part_copy(adapter, bucket) do
    request(%{}, :upload_part_copy, "/", adapter)
  end

  def complete_multipart_upload(adapter, bucket) do
    request(%{}, :complete_multipart_upload, "/", adapter)
  end

  def abort_multipart_upload(adapter, bucket) do
    request(%{}, :abort_multipart_upload, "/", adapter)
  end

  def list_parts(adapter, bucket) do
    request(%{}, :list_parts, "/", adapter)
  end

end
