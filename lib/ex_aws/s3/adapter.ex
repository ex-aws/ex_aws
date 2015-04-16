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
  defcallback list_buckets(opts :: %{}) :: ExAws.Request.response_t

  defcallback list_objects(bucket :: binary) :: ExAws.Request.response_t

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
  defcallback list_multipart_uploads(bucket :: binary, opts :: %{}) :: ExAws.Request.response_t

  defcallback put_bucket(bucket :: binary, region :: binary) :: ExAws.Request.response_t

  defcallback create_bucket(bucket :: binary, region :: binary) :: ExAws.Request.response_t

  defcallback put_bucket_acl(
    bucket      :: binary,
    owner_id    :: binary,
    owner_email :: binary,
    grants      :: %{}) :: ExAws.Request.response_t

  defcallback put_bucket_cors(bucket :: binary, cors_config :: %{}) :: ExAws.Request.response_t

  defcallback put_bucket_lifecycle(bucket :: binary, lifecycle_config :: %{}) :: ExAws.Request.response_t

  defcallback put_bucket_policy(bucket :: binary, policy :: %{}) :: ExAws.Request.response_t

  defcallback put_bucket_logging(bucket :: binary, logging_config :: %{}) :: ExAws.Request.response_t

  defcallback put_bucket_notification(bucket :: binary, notification_config :: %{}) :: ExAws.Request.response_t

  defcallback put_bucket_replication(bucket :: binary, replication_config :: %{}) :: ExAws.Request.response_t

  defcallback put_bucket_tagging(bucket :: binary, tags :: %{}) :: ExAws.Request.response_t

  defcallback put_bucket_requestpayment(bucket :: binary, payer :: :requester | :bucket_owner) :: ExAws.Request.response_t

  defcallback put_bucket_versioning(bucket :: binary, version_config :: binary) :: ExAws.Request.response_t

  defcallback put_bucket_website(bucket :: binary, website_config :: binary) :: ExAws.Request.response_t


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

  defcallback post_object(bucket :: binary, object :: binary) :: ExAws.Request.response_t
  defcallback post_object(bucket :: binary, object :: binary, opts :: %{}) :: ExAws.Request.response_t

  defcallback post_object_restore(
    bucket         :: binary,
    object         :: binary,
    version_id     :: binary,
    number_of_days :: pos_integer) :: ExAws.Request.response_t

  defcallback put_object(bucket :: binary, object :: binary, body :: binary) :: ExAws.Request.response_t
  defcallback put_object(bucket :: binary, object :: binary, body :: binary, opts :: %{}) :: ExAws.Request.response_t

  defcallback put_object_acl(bucket :: binary, object :: binary, acl :: %{}) :: ExAws.Request.response_t

  defcallback put_object_copy(
    dest_bucket :: binary,
    dest_object :: binary,
    src_bucket  :: binary,
    src_object  :: binary) :: ExAws.Request.response_t
  defcallback put_object_copy(
    dest_bucket :: binary,
    dest_object :: binary,
    src_bucket  :: binary,
    src_object  :: binary,
    opts        :: %{}) :: ExAws.Request.response_t

  defcallback initiate_multipart_upload(bucket :: binary, object :: binary) :: ExAws.Request.response_t
  defcallback initiate_multipart_upload(bucket :: binary, object :: binary, opts :: %{}) :: ExAws.Request.response_t

  defcallback upload_part(
    bucket      :: binary,
    object      :: binary,
    upload_id   :: binary,
    part_number :: pos_integer) :: ExAws.Request.response_t

  defcallback upload_part_copy(
    dest_bucket :: binary,
    dest_object :: binary,
    src_bucket  :: binary,
    src_object  :: binary) :: ExAws.Request.response_t
  defcallback upload_part_copy(
    dest_bucket :: binary,
    dest_object :: binary,
    src_bucket  :: binary,
    src_object  :: binary,
    opts        :: %{}) :: ExAws.Request.response_t

  defcallback complete_multipart_upload(
    bucket    :: binary,
    object    :: binary,
    upload_id :: binary,
    parts     :: %{}) :: ExAws.Request.response_t

  defcallback abort_multipart_upload(bucket :: binary, object :: binary, upload_id :: binary) :: ExAws.Request.response_t

  defcallback list_parts(bucket :: binary, object :: binary, upload_id :: binary) :: ExAws.Request.response_t
  defcallback list_parts(bucket :: binary, object :: binary, upload_id :: binary, opts :: %{}) :: ExAws.Request.response_t

  defmacro __using__(using_opts) do
    quote bind_quoted: [using_opts: using_opts, behavior_module: __MODULE__] do
      @otp_app Keyword.get(using_opts, :otp_app)
      @behaviour behavior_module

      def delete_bucket(bucket) do
        ExAws.S3.Impl.delete_bucket(__MODULE__, bucket)
      end

      def delete_bucket_cors(bucket) do
        ExAws.S3.Impl.delete_bucket_cors(__MODULE__, bucket)
      end

      def delete_bucket_lifecycle(bucket) do
        ExAws.S3.Impl.delete_bucket_lifecycle(__MODULE__, bucket)
      end

      def delete_bucket_policy(bucket) do
        ExAws.S3.Impl.delete_bucket_policy(__MODULE__, bucket)
      end

      def delete_bucket_replication(bucket) do
        ExAws.S3.Impl.delete_bucket_replication(__MODULE__, bucket)
      end

      def delete_bucket_tagging(bucket) do
        ExAws.S3.Impl.delete_bucket_tagging(__MODULE__, bucket)
      end

      def delete_bucket_website(bucket) do
        ExAws.S3.Impl.delete_bucket_website(__MODULE__, bucket)
      end

      def list_buckets(opts \\ %{}) do
        ExAws.S3.Impl.list_buckets(__MODULE__, opts)
      end

      def list_objects(bucket) do
        ExAws.S3.Impl.list_objects(__MODULE__, bucket)
      end

      def get_bucket_acl(bucket) do
        ExAws.S3.Impl.get_bucket_acl(__MODULE__, bucket)
      end

      def get_bucket_cors(bucket) do
        ExAws.S3.Impl.get_bucket_cors(__MODULE__, bucket)
      end

      def get_bucket_lifecycle(bucket) do
        ExAws.S3.Impl.get_bucket_lifecycle(__MODULE__, bucket)
      end

      def get_bucket_policy(bucket) do
        ExAws.S3.Impl.get_bucket_policy(__MODULE__, bucket)
      end

      def get_bucket_location(bucket) do
        ExAws.S3.Impl.get_bucket_location(__MODULE__, bucket)
      end

      def get_bucket_logging(bucket) do
        ExAws.S3.Impl.get_bucket_logging(__MODULE__, bucket)
      end

      def get_bucket_notification(bucket) do
        ExAws.S3.Impl.get_bucket_notification(__MODULE__, bucket)
      end

      def get_bucket_replication(bucket) do
        ExAws.S3.Impl.get_bucket_replication(__MODULE__, bucket)
      end

      def get_bucket_tagging(bucket) do
        ExAws.S3.Impl.get_bucket_tagging(__MODULE__, bucket)
      end

      def get_bucket_object_versions(bucket) do
        ExAws.S3.Impl.get_bucket_object_versions(__MODULE__, bucket)
      end

      def get_bucket_request_payment(bucket) do
        ExAws.S3.Impl.get_bucket_request_payment(__MODULE__, bucket)
      end

      def get_bucket_versioning(bucket) do
        ExAws.S3.Impl.get_bucket_versioning(__MODULE__, bucket)
      end

      def get_bucket_website(bucket) do
        ExAws.S3.Impl.get_bucket_website(__MODULE__, bucket)
      end

      def head_bucket() do
        ExAws.S3.Impl.head_bucket(__MODULE__)
      end

      def list_multipart_uploads(bucket, opts \\ %{}) do
        ExAws.S3.Impl.list_multipart_uploads(__MODULE__, bucket, opts)
      end

      def put_bucket(bucket, region) do
        ExAws.S3.Impl.put_bucket(__MODULE__, bucket, region)
      end

      defdelegate create_bucket(bucket, region), to: __MODULE__, as: :put_bucket

      def put_bucket_acl(bucket, owner_id, owner_email, grants) do
        ExAws.S3.Impl.put_bucket_acl(__MODULE__, bucket, owner_id, owner_email, grants)
      end

      def put_bucket_cors(bucket, cors_config) do
        ExAws.S3.Impl.put_bucket_cors(__MODULE__, bucket, cors_config)
      end

      def put_bucket_lifecycle(bucket, livecycle_config) do
        ExAws.S3.Impl.put_bucket_lifecycle(__MODULE__, bucket, livecycle_config)
      end

      def put_bucket_policy(bucket, policy) do
        ExAws.S3.Impl.put_bucket_policy(__MODULE__, bucket, policy)
      end

      def put_bucket_logging(bucket, logging_config) do
        ExAws.S3.Impl.put_bucket_logging(__MODULE__, bucket, logging_config)
      end

      def put_bucket_notification(bucket, notification_config) do
        ExAws.S3.Impl.put_bucket_notification(__MODULE__, bucket, notification_config)
      end

      def put_bucket_replication(bucket, replication_config) do
        ExAws.S3.Impl.put_bucket_replication(__MODULE__, bucket, replication_config)
      end

      def put_bucket_tagging(bucket, tags) do
        ExAws.S3.Impl.put_bucket_tagging(__MODULE__, bucket, tags)
      end

      def put_bucket_requestpayment(bucket, payer) do
        ExAws.S3.Impl.put_bucket_requestpayment(__MODULE__, bucket, payer)
      end

      def put_bucket_versioning(bucket, version_config) do
        ExAws.S3.Impl.put_bucket_versioning(__MODULE__, bucket, version_config)
      end

      def put_bucket_website(bucket, website_config) do
        ExAws.S3.Impl.put_bucket_website(__MODULE__, bucket, website_config)
      end

      def delete_object(bucket, object) do
        ExAws.S3.Impl.delete_object(__MODULE__, bucket, object)
      end

      def delete_multiple_objects(bucket, objects) do
        ExAws.S3.Impl.delete_multiple_objects(__MODULE__, bucket, objects)
      end

      def get_object(bucket, object, opts \\ %{}) do
        ExAws.S3.Impl.get_object(__MODULE__, bucket, opts)
      end

      def get_object_acl(bucket, object, opts \\ %{}) do
        ExAws.S3.Impl.get_object_acl(__MODULE__, bucket, opts)
      end

      def get_object_torrent(bucket, object) do
        ExAws.S3.Impl.get_object_torrent(__MODULE__, bucket, object)
      end

      def head_object(bucket, object, opts \\ %{}) do
        ExAws.S3.Impl.head_object(__MODULE__, bucket, object, opts)
      end

      def options_object(bucket, object, origin, request_method, request_headers \\ []) do
        ExAws.S3.Impl.options_object(__MODULE__, bucket, object, origin, request_method, request_headers)
      end

      def post_object(bucket, object, opts \\ %{}) do
        ExAws.S3.Impl.post_object(__MODULE__, bucket, object, opts)
      end

      def post_object_restore(bucket, object, version_id, number_of_days) do
        ExAws.S3.Impl.post_object_restore(__MODULE__, bucket, object, version_id, number_of_days)
      end

      def put_object(bucket, object, body, opts \\ %{}) do
        ExAws.S3.Impl.put_object(__MODULE__, bucket, object, body, opts)
      end

      def put_object_acl(bucket, object, acl) do
        ExAws.S3.Impl.put_object_acl(__MODULE__, bucket, object, acl)
      end

      def put_object_copy(dest_bucket, dest_object, src_bucket, src_object, opts \\ %{}) do
        ExAws.S3.Impl.put_object_copy(__MODULE__, dest_bucket, dest_object, src_bucket, src_object, opts)
      end

      def initiate_multipart_upload(bucket, object, opts \\ %{}) do
        ExAws.S3.Impl.initiate_multipart_upload(__MODULE__, bucket, object, opts)
      end

      def upload_part(bucket, object, upload_id, part_number) do
        ExAws.S3.Impl.upload_part(__MODULE__, bucket, object, upload_id, part_number)
      end

      def upload_part_copy(dest_bucket, dest_object, src_bucket, src_object, opts \\ %{}) do
        ExAws.S3.Impl.upload_part_copy(__MODULE__, dest_bucket, dest_object, src_bucket, src_object, opts)
      end

      def complete_multipart_upload(bucket, object, upload_id, parts) do
        ExAws.S3.Impl.complete_multipart_upload(__MODULE__, bucket, object, upload_id, parts)
      end

      def abort_multipart_upload(bucket, object, upload_id) do
        ExAws.S3.Impl.abort_multipart_upload(__MODULE__, bucket, object, upload_id)
      end

      def list_parts(bucket, object, upload_id, opts \\ %{}) do
        ExAws.S3.Impl.list_parts(__MODULE__, bucket, object, upload_id, opts)
      end

      @doc false
      def service, do: :s3

      @doc false
      def config_root, do: Application.get_env(@otp_app, :ex_aws)

      @doc false
      def config, do: __MODULE__ |> ExAws.Config.get

      defoverridable config: 0, config_root: 0

    end
  end

end
