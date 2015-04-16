defmodule ExAws.S3.Adapter do
  use Behaviour

  ## Bucket functions

  # Delete
  defcallback delete_bucket(bucket :: binary) :: ExAws.Request.response_t

  defcallback delete_bucket_cors(bucket :: binary) :: ExAws.Request.response_t

  defcallback delete_bucket_lifecycle(bucket :: binary) :: ExAws.Request.response_t

  defcallback delete_bucket_policy(bucket :: binary) :: ExAws.Request.response_t

  defcallback delete_bucket_replication(bucket :: binary) :: ExAws.Request.response_t

  defcallback delete_bucket_tagging(bucket :: binary) :: ExAws.Request.response_t

  defcallback delete_bucket_website(bucket :: binary) :: ExAws.Request.response_t

  # Get
  defcallback list_buckets() :: ExAws.Request.response_t

  defcallback get_bucket_objects(bucket :: binary) :: ExAws.Request.response_t

  defcallback get_bucket_acl(bucket :: binary) :: ExAws.Request.response_t

  defcallback get_bucket_cors(bucket :: binary) :: ExAws.Request.response_t

  defcallback get_bucket_lifecycle(bucket :: binary) :: ExAws.Request.response_t

  defcallback get_bucket_policy(bucket :: binary) :: ExAws.Request.response_t

  defcallback get_bucket_location(bucket :: binary) :: ExAws.Request.response_t

  defcallback get_bucket_logging(bucket :: binary) :: ExAws.Request.response_t

  defcallback get_bucket_notification(bucket :: binary) :: ExAws.Request.response_t

  defcallback get_bucket_replication(bucket :: binary) :: ExAws.Request.response_t

  defcallback get_bucket_tagging(bucket :: binary) :: ExAws.Request.response_t

  defcallback get_bucket_object_versions(bucket :: binary) :: ExAws.Request.response_t

  defcallback get_bucket_request_payment(bucket :: binary) :: ExAws.Request.response_t

  defcallback get_bucket_versioning(bucket :: binary) :: ExAws.Request.response_t

  defcallback get_bucket_website(bucket :: binary) :: ExAws.Request.response_t

  defcallback head_bucket() :: ExAws.Request.response_t

  defcallback list_multipart_uploads(bucket :: binary) :: ExAws.Request.response_t

  defcallback put_bucket(bucket :: binary, region :: binary) :: ExAws.Request.response_t

  defcallback create_bucket(bucket :: binary, region :: binary) :: ExAws.Request.response_t

  defcallback put_bucket_acl(
    name        :: binary,
    owner_id    :: binary,
    owner_email :: binary,
    grants      :: %{}) :: ExAws.Request.response_t

  defcallback put_bucket_cors(bucket :: binary, cors_config :: %{}) :: ExAws.Request.response_t

  defcallback put_bucket_lifecycle(bucket :: binary, lifecycle_config :: %{}) :: ExAws.Request.response_t

  defcallback put_bucket_policy(bucket :: binary, policy :: %{}) :: ExAws.Request.response_t

  defcallback put_bucket_logging(bucket :: binary, logging_config :: %{}) :: ExAws.Request.response_t

  defcallback put_bucket_notification(bucket :: binary, notification_config :: %{}) :: ExAws.Request.response_t

  defcallback put_bucket_replication(bucket :: binary, replication_config :: %{}) :: ExAws.Request.response_t

  defcallback put_bucket_tagging(bucket :: binary) :: ExAws.Request.response_t

  defcallback put_bucket_requestpayment(bucket :: binary) :: ExAws.Request.response_t

  defcallback put_bucket_versioning(bucket :: binary) :: ExAws.Request.response_t

  defcallback put_bucket_website(bucket :: binary) :: ExAws.Request.response_t


  ## Object functions
  defcallback delete_object(bucket :: binary, object :: binary) :: ExAws.Request.response_t

  defcallback delete_multiple_objects(
    bucket  :: binary,
    objects :: [binary | {binary, binary}, ...]):: ExAws.Request.response_t

  defcallback get_object(bucket :: binary, object :: binary) :: ExAws.Request.response_t
  defcallback get_object(bucket :: binary, object :: binary, opts :: %{}) :: ExAws.Request.response_t

  defcallback get_object_acl(bucket :: binary, object :: binary) :: ExAws.Request.response_t
  defcallback get_object_acl(bucket :: binary, object :: binary, opts :: %{}) :: ExAws.Request.response_t

  defcallback get_object_torrent(bucket :: binary, object :: binary) :: ExAws.Request.response_t

  defcallback head_object(bucket :: binary, object :: binary) :: ExAws.Request.response_t
  defcallback head_object(bucket :: binary, object :: binary, opts :: %{}) :: ExAws.Request.response_t

  defcallback options_object(
    bucket         :: binary,
    object         :: binary,
    origin         :: binary,
    request_method :: atom) :: ExAws.Request.response_t
  defcallback options_object(
    bucket          :: binary,
    object          :: binary,
    origin          :: binary,
    request_method  :: atom,
    request_headers :: [binary, ...]) :: ExAws.Request.response_t

  @doc "Alias for put_object"
  defcallback post_object(bucket :: binary, object :: binary) :: ExAws.Request.response_t
  defcallback post_object(bucket :: binary, object :: binary, opts :: %{}) :: ExAws.Request.response_t

  defcallback post_object_restore() :: ExAws.Request.response_t

  defcallback put_object(bucket :: binary, object :: binary) :: ExAws.Request.response_t
  defcallback put_object(bucket :: binary, object :: binary, opts :: %{}) :: ExAws.Request.response_t

  defcallback put_object_acl(bucket :: binary, object :: binary, acl :: %{}) :: ExAws.Request.response_t

  defcallback put_object_copy() :: ExAws.Request.response_t

  defcallback initiate_multipart_upload(bucket :: binary, object :: binary) :: ExAws.Request.response_t
  defcallback initiate_multipart_upload(bucket :: binary, object :: binary, opts :: %{}) :: ExAws.Request.response_t

  defcallback upload_part(
    bucket      :: binary,
    object      :: binary,
    upload_id   :: binary,
    part_number :: pos_integer) :: ExAws.Request.response_t

  defcallback upload_part_copy() :: ExAws.Request.response_t

  defcallback complete_multipart_upload(
    bucket    :: binary,
    object    :: binary,
    upload_id :: binary,
    parts     :: %{} ) :: ExAws.Request.response_t

  defcallback abort_multipart_upload() :: ExAws.Request.response_t

  defcallback list_parts() :: ExAws.Request.response_t

end
