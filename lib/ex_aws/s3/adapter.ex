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

  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts, behavior_module: __MODULE__] do
      @otp_app Keyword.get(opts, :otp_app)
      @behaviour behavior_module

      def delete_bucket(bucket) do
        ExAws.S3.dellete_bucket(__MODULE__, bucket)
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

      def list_buckets() do
        ExAws.S3.Impl.list_buckets(__MODULE__)
      end

      def get_bucket_objects(bucket) do
        ExAws.S3.Impl.get_bucket_objects(__MODULE__, bucket)
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

      def head_bucket(bucket) do
        ExAws.S3.Impl.head_bucket(__MODULE__, bucket)
      end

      def list_multipart_uploads(bucket) do
        ExAws.S3.Impl.list_multipart_uploads(__MODULE__, bucket)
      end

      def put_bucket(bucket) do
        ExAws.S3.Impl.put_bucket(__MODULE__, bucket)
      end

      def create_bucket(bucket) do
        ExAws.S3.Impl.create_bucket(__MODULE__, bucket)
      end

      def put_bucket_acl(bucket) do
        ExAws.S3.Impl.put_bucket_acl(__MODULE__, bucket)
      end

      def put_bucket_cors(bucket) do
        ExAws.S3.Impl.put_bucket_cors(__MODULE__, bucket)
      end

      def put_bucket_lifecycle(bucket) do
        ExAws.S3.Impl.put_bucket_lifecycle(__MODULE__, bucket)
      end

      def put_bucket_policy(bucket) do
        ExAws.S3.Impl.put_bucket_policy(__MODULE__, bucket)
      end

      def put_bucket_logging(bucket) do
        ExAws.S3.Impl.put_bucket_logging(__MODULE__, bucket)
      end

      def put_bucket_notification(bucket) do
        ExAws.S3.Impl.put_bucket_notification(__MODULE__, bucket)
      end

      def put_bucket_replication(bucket) do
        ExAws.S3.Impl.put_bucket_replication(__MODULE__, bucket)
      end

      def put_bucket_tagging(bucket) do
        ExAws.S3.Impl.put_bucket_tagging(__MODULE__, bucket)
      end

      def put_bucket_requestpayment(bucket) do
        ExAws.S3.Impl.put_bucket_requestpayment(__MODULE__, bucket)
      end

      def put_bucket_versioning(bucket) do
        ExAws.S3.Impl.put_bucket_versioning(__MODULE__, bucket)
      end

      def put_bucket_website(bucket) do
        ExAws.S3.Impl.put_bucket_website(__MODULE__, bucket)
      end

      def delete_object(bucket) do
        ExAws.S3.Impl.delete_object(__MODULE__, bucket)
      end

      def delete_multiple_objects(bucket) do
        ExAws.S3.Impl.delete_multiple_objects(__MODULE__, bucket)
      end

      def get_object(bucket) do
        ExAws.S3.Impl.get_object(__MODULE__, bucket)
      end

      def get_object_acl(bucket) do
        ExAws.S3.Impl.get_object_acl(__MODULE__, bucket)
      end

      def get_object_torrent(bucket) do
        ExAws.S3.Impl.get_object_torrent(__MODULE__, bucket)
      end

      def head_object(bucket) do
        ExAws.S3.Impl.head_object(__MODULE__, bucket)
      end

      def head_object(bucket) do
        ExAws.S3.Impl.head_object(__MODULE__, bucket)
      end

      def options_object(bucket) do
        ExAws.S3.Impl.options_object(__MODULE__, bucket)
      end

      def post_object(bucket) do
        ExAws.S3.Impl.post_object(__MODULE__, bucket)
      end

      def post_object_restore(bucket) do
        ExAws.S3.Impl.post_object_restore(__MODULE__, bucket)
      end

      def put_object(bucket) do
        ExAws.S3.Impl.put_object(__MODULE__, bucket)
      end

      def put_object_acl(bucket) do
        ExAws.S3.Impl.put_object_acl(__MODULE__, bucket)
      end

      def put_object_copy(bucket) do
        ExAws.S3.Impl.put_object_copy(__MODULE__, bucket)
      end

      def initiate_multipart_upload(bucket) do
        ExAws.S3.Impl.initiate_multipart_upload(__MODULE__, bucket)
      end

      def upload_part(bucket) do
        ExAws.S3.Impl.upload_part(__MODULE__, bucket)
      end

      def upload_part_copy(bucket) do
        ExAws.S3.Impl.upload_part_copy(__MODULE__, bucket)
      end

      def complete_multipart_upload(bucket) do
        ExAws.S3.Impl.complete_multipart_upload(__MODULE__, bucket)
      end

      def abort_multipart_upload(bucket) do
        ExAws.S3.Impl.abort_multipart_upload(__MODULE__, bucket)
      end

      def list_parts(bucket) do
        ExAws.S3.Impl.list_parts(__MODULE__, bucket)
      end

      @doc false
      def service do
        :s3
      end

      @doc false
      def config_root, do: Application.get_env(@otp_app, :ex_aws)

      @doc false
      def config do
        __MODULE__ |> ExAws.Config.get
      end

      defoverridable config: 0, config_root: 0

    end
  end

end
