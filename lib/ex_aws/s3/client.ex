defmodule ExAws.S3.Client do
  use Behaviour

  @moduledoc """
  The purpose of this module is to surface the ExAws.S3 API tied to a single
  configuration chosen, such that it does not need passed in with every request.

  Usage:
  ```
  defmodule MyApp.S3 do
    use ExAws.S3.Client, otp_app: :my_otp_app
  end
  ```

  In your config
  ```
  config :my_otp_app, ExAws,
    s3: [], # S3 config goes here
  ```

  You can now use MyApp.S3 as the root module for the S3 api without needing
  to pass in a particular configuration.
  This enables different otp apps to configure their AWS configuration separately.

  The alignment with a particular OTP app while convenient is however entirely optional.
  The following also works:

  ```
  defmodule MyApp.S3 do
    use ExAws.S3.Client

    def config do
      [
        s3: [], # Config goes here
      ]
    end
  end
  ```

  This is in fact how the functions in ExAws.S3 that do not require a config work.
  Default config values can be found in ExAws.Config. The default configuration is always used,
  and then the configuration of a particular client is merged in and overrides the defaults.
  """

  ## Bucket functions

  # Delete
  @doc "Delete a bucket"
  defcallback delete_bucket(bucket :: binary) :: ExAws.Request.response_t

  @doc "Delete a bucket cors"
  defcallback delete_bucket_cors(bucket :: binary) :: ExAws.Request.response_t

  @doc "Delete a bucket lifecycle"
  defcallback delete_bucket_lifecycle(bucket :: binary) :: ExAws.Request.response_t

  @doc "Delete a bucket policy"
  defcallback delete_bucket_policy(bucket :: binary) :: ExAws.Request.response_t

  @doc "Delete a bucket replication"
  defcallback delete_bucket_replication(bucket :: binary) :: ExAws.Request.response_t

  @doc "Delete a bucket tagging"
  defcallback delete_bucket_tagging(bucket :: binary) :: ExAws.Request.response_t

  @doc "Delete a bucket website"
  defcallback delete_bucket_website(bucket :: binary) :: ExAws.Request.response_t

  # Get
  @doc "List buckets"
  defcallback list_buckets() :: ExAws.Request.response_t
  defcallback list_buckets(opts :: %{}) :: ExAws.Request.response_t

  @doc "List objects in bucket"
  defcallback list_objects(bucket :: binary) :: ExAws.Request.response_t

  @doc "Get bucket acl"
  defcallback get_bucket_acl(bucket :: binary) :: ExAws.Request.response_t

  @doc "Get bucket cors"
  defcallback get_bucket_cors(bucket :: binary) :: ExAws.Request.response_t

  @doc "Get bucket lifecycle"
  defcallback get_bucket_lifecycle(bucket :: binary) :: ExAws.Request.response_t

  @doc "Get bucket policy"
  defcallback get_bucket_policy(bucket :: binary) :: ExAws.Request.response_t

  @doc "Get bucket location"
  defcallback get_bucket_location(bucket :: binary) :: ExAws.Request.response_t

  @doc "Get bucket logging"
  defcallback get_bucket_logging(bucket :: binary) :: ExAws.Request.response_t

  @doc "Get bucket notification"
  defcallback get_bucket_notification(bucket :: binary) :: ExAws.Request.response_t

  @doc "Get bucket replication"
  defcallback get_bucket_replication(bucket :: binary) :: ExAws.Request.response_t

  @doc "Get bucket tagging"
  defcallback get_bucket_tagging(bucket :: binary) :: ExAws.Request.response_t

  @doc "Get bucket object versions"
  defcallback get_bucket_object_versions(bucket :: binary) :: ExAws.Request.response_t
  defcallback get_bucket_object_versions(bucket :: binary, opts :: %{}) :: ExAws.Request.response_t

  @doc "Get bucket payment configuration"
  defcallback get_bucket_request_payment(bucket :: binary) :: ExAws.Request.response_t

  @doc "Get bucket versioning"
  defcallback get_bucket_versioning(bucket :: binary) :: ExAws.Request.response_t

  @doc "Get bucket website"
  defcallback get_bucket_website(bucket :: binary) :: ExAws.Request.response_t

  @doc "Determine if a bucket exists"
  defcallback head_bucket() :: ExAws.Request.response_t

  @doc "List multipart uploads for a bucket"
  defcallback list_multipart_uploads(bucket :: binary) :: ExAws.Request.response_t
  defcallback list_multipart_uploads(bucket :: binary, opts :: %{}) :: ExAws.Request.response_t

  @doc "Creates a bucket. Same as create_bucket/2"
  defcallback put_bucket(bucket :: binary, region :: binary) :: ExAws.Request.response_t

  @doc "Creates a bucket. Same as put_bucket/2"
  defcallback create_bucket(bucket :: binary, region :: binary) :: ExAws.Request.response_t

  @doc "Update or create a bucket bucket access control"
  defcallback put_bucket_acl(
    bucket      :: binary,
    owner_id    :: binary,
    owner_email :: binary,
    grants      :: %{}) :: ExAws.Request.response_t

  @doc "Update or create a bucket CORS policy"
  defcallback put_bucket_cors(bucket :: binary, cors_config :: %{}) :: ExAws.Request.response_t

  @doc "Update or create a bucket lifecycle configuration"
  defcallback put_bucket_lifecycle(bucket :: binary, lifecycle_config :: %{}) :: ExAws.Request.response_t

  @doc "Update or create a bucket policy configuration"
  defcallback put_bucket_policy(bucket :: binary, policy :: %{}) :: ExAws.Request.response_t

  @doc "Update or create a bucket logging configuration"
  defcallback put_bucket_logging(bucket :: binary, logging_config :: %{}) :: ExAws.Request.response_t

  @doc "Update or create a bucket notification configuration"
  defcallback put_bucket_notification(bucket :: binary, notification_config :: %{}) :: ExAws.Request.response_t

  @doc "Update or create a bucket replication configuration"
  defcallback put_bucket_replication(bucket :: binary, replication_config :: %{}) :: ExAws.Request.response_t

  @doc "Update or create a bucket tagging configuration"
  defcallback put_bucket_tagging(bucket :: binary, tags :: %{}) :: ExAws.Request.response_t

  @doc "Update or create a bucket requestpayment configuration"
  defcallback put_bucket_requestpayment(bucket :: binary, payer :: :requester | :bucket_owner) :: ExAws.Request.response_t

  @doc "Update or create a bucket versioning configuration"
  defcallback put_bucket_versioning(bucket :: binary, version_config :: binary) :: ExAws.Request.response_t

  @doc "Update or create a bucket website configuration"
  defcallback put_bucket_website(bucket :: binary, website_config :: binary) :: ExAws.Request.response_t


  ## Object functions
  @doc "Delete object object in bucket"
  defcallback delete_object(bucket :: binary, object :: binary) :: ExAws.Request.response_t

  @doc "Delete multiple objects within a bucket"
  defcallback delete_multiple_objects(
    bucket  :: binary,
    objects :: [binary | {binary, binary}, ...]):: ExAws.Request.response_t

  @doc "Get an object from a bucket"
  defcallback get_object(bucket :: binary, object :: binary) :: ExAws.Request.response_t
  defcallback get_object(bucket :: binary, object :: binary, opts :: %{}) :: ExAws.Request.response_t

  @doc "Get an object's access control policy"
  defcallback get_object_acl(bucket :: binary, object :: binary) :: ExAws.Request.response_t
  defcallback get_object_acl(bucket :: binary, object :: binary, opts :: %{}) :: ExAws.Request.response_t

  @doc "Get a torrent for a bucket"
  defcallback get_object_torrent(bucket :: binary, object :: binary) :: ExAws.Request.response_t

  @doc "Determine of an object exists"
  defcallback head_object(bucket :: binary, object :: binary) :: ExAws.Request.response_t
  defcallback head_object(bucket :: binary, object :: binary, opts :: %{}) :: ExAws.Request.response_t

  @doc "Determine the CORS configuration for an object"
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

  @doc """
  Create an object within a bucket.

  Generally speaking put_object ought to be used. AWS POST object exists to
  support the AWS UI.
  """
  defcallback post_object(bucket :: binary, object :: binary) :: ExAws.Request.response_t
  defcallback post_object(bucket :: binary, object :: binary, opts :: %{}) :: ExAws.Request.response_t

  @doc "Restore an object to a particular version FIXME"
  defcallback post_object_restore(
    bucket         :: binary,
    object         :: binary,
    version_id     :: binary,
    number_of_days :: pos_integer) :: ExAws.Request.response_t

  @doc "Create an object within a bucket"
  defcallback put_object(bucket :: binary, object :: binary, body :: binary) :: ExAws.Request.response_t
  defcallback put_object(bucket :: binary, object :: binary, body :: binary, opts :: %{}) :: ExAws.Request.response_t

  @doc "Create or update an object's access control FIXME"
  defcallback put_object_acl(bucket :: binary, object :: binary, acl :: %{}) :: ExAws.Request.response_t

  @doc "Copy an object"
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

  @doc "Initiate a multipart upload"
  defcallback initiate_multipart_upload(bucket :: binary, object :: binary) :: ExAws.Request.response_t
  defcallback initiate_multipart_upload(bucket :: binary, object :: binary, opts :: %{}) :: ExAws.Request.response_t

  @doc "Upload a part for a multipart upload"
  defcallback upload_part(
    bucket      :: binary,
    object      :: binary,
    upload_id   :: binary,
    part_number :: pos_integer) :: ExAws.Request.response_t

  @doc "Upload a part for a multipart copy"
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

  @doc "Complete a multipart upload"
  defcallback complete_multipart_upload(
    bucket    :: binary,
    object    :: binary,
    upload_id :: binary,
    parts     :: %{}) :: ExAws.Request.response_t

  @doc "Abort a multipart upload"
  defcallback abort_multipart_upload(bucket :: binary, object :: binary, upload_id :: binary) :: ExAws.Request.response_t

  @doc "List the parts of a multipart upload"
  defcallback list_parts(bucket :: binary, object :: binary, upload_id :: binary) :: ExAws.Request.response_t
  defcallback list_parts(bucket :: binary, object :: binary, upload_id :: binary, opts :: %{}) :: ExAws.Request.response_t

  @doc """
  Enables custom request handling.

  By default this just forwards the request to the ExAws.S3.Request.request/4.
  However, this can be overriden in your client to provide pre-request adjustments to headers, params, etc.
  """
  defcallback request(http_method :: atom, bucket :: binary, path :: binary) :: ExAws.Request.response_t
  defcallback request(http_method :: atom, bucket :: binary, path :: binary, data :: Keyword.t) :: ExAws.Request.response_t

  defmacro __using__(using_opts) do
    quote bind_quoted: [using_opts: using_opts, behavior_module: __MODULE__] do
      @otp_app Keyword.get(using_opts, :otp_app)
      @behaviour behavior_module

      @moduledoc false

      @doc false
      def delete_bucket(bucket) do
        ExAws.S3.Impl.delete_bucket(__MODULE__, bucket)
      end

      @doc false
      def delete_bucket_cors(bucket) do
        ExAws.S3.Impl.delete_bucket_cors(__MODULE__, bucket)
      end

      @doc false
      def delete_bucket_lifecycle(bucket) do
        ExAws.S3.Impl.delete_bucket_lifecycle(__MODULE__, bucket)
      end

      @doc false
      def delete_bucket_policy(bucket) do
        ExAws.S3.Impl.delete_bucket_policy(__MODULE__, bucket)
      end

      @doc false
      def delete_bucket_replication(bucket) do
        ExAws.S3.Impl.delete_bucket_replication(__MODULE__, bucket)
      end

      @doc false
      def delete_bucket_tagging(bucket) do
        ExAws.S3.Impl.delete_bucket_tagging(__MODULE__, bucket)
      end

      @doc false
      def delete_bucket_website(bucket) do
        ExAws.S3.Impl.delete_bucket_website(__MODULE__, bucket)
      end

      @doc false
      def list_buckets(opts \\ %{}) do
        ExAws.S3.Impl.list_buckets(__MODULE__, opts)
      end

      @doc false
      def list_objects(bucket) do
        ExAws.S3.Impl.list_objects(__MODULE__, bucket)
      end

      @doc false
      def get_bucket_acl(bucket) do
        ExAws.S3.Impl.get_bucket_acl(__MODULE__, bucket)
      end

      @doc false
      def get_bucket_cors(bucket) do
        ExAws.S3.Impl.get_bucket_cors(__MODULE__, bucket)
      end

      @doc false
      def get_bucket_lifecycle(bucket) do
        ExAws.S3.Impl.get_bucket_lifecycle(__MODULE__, bucket)
      end

      @doc false
      def get_bucket_policy(bucket) do
        ExAws.S3.Impl.get_bucket_policy(__MODULE__, bucket)
      end

      @doc false
      def get_bucket_location(bucket) do
        ExAws.S3.Impl.get_bucket_location(__MODULE__, bucket)
      end

      @doc false
      def get_bucket_logging(bucket) do
        ExAws.S3.Impl.get_bucket_logging(__MODULE__, bucket)
      end

      @doc false
      def get_bucket_notification(bucket) do
        ExAws.S3.Impl.get_bucket_notification(__MODULE__, bucket)
      end

      @doc false
      def get_bucket_replication(bucket) do
        ExAws.S3.Impl.get_bucket_replication(__MODULE__, bucket)
      end

      @doc false
      def get_bucket_tagging(bucket) do
        ExAws.S3.Impl.get_bucket_tagging(__MODULE__, bucket)
      end

      @doc false
      def get_bucket_object_versions(bucket, opts \\ %{}) do
        ExAws.S3.Impl.get_bucket_object_versions(__MODULE__, bucket, opts)
      end

      @doc false
      def get_bucket_request_payment(bucket) do
        ExAws.S3.Impl.get_bucket_request_payment(__MODULE__, bucket)
      end

      @doc false
      def get_bucket_versioning(bucket) do
        ExAws.S3.Impl.get_bucket_versioning(__MODULE__, bucket)
      end

      @doc false
      def get_bucket_website(bucket) do
        ExAws.S3.Impl.get_bucket_website(__MODULE__, bucket)
      end

      @doc false
      def head_bucket() do
        ExAws.S3.Impl.head_bucket(__MODULE__)
      end

      @doc false
      def list_multipart_uploads(bucket, opts \\ %{}) do
        ExAws.S3.Impl.list_multipart_uploads(__MODULE__, bucket, opts)
      end

      @doc false
      def put_bucket(bucket, region) do
        ExAws.S3.Impl.put_bucket(__MODULE__, bucket, region)
      end

      defdelegate create_bucket(bucket, region), to: __MODULE__, as: :put_bucket

      @doc false
      def put_bucket_acl(bucket, owner_id, owner_email, grants) do
        ExAws.S3.Impl.put_bucket_acl(__MODULE__, bucket, owner_id, owner_email, grants)
      end

      @doc false
      def put_bucket_cors(bucket, cors_config) do
        ExAws.S3.Impl.put_bucket_cors(__MODULE__, bucket, cors_config)
      end

      @doc false
      def put_bucket_lifecycle(bucket, livecycle_config) do
        ExAws.S3.Impl.put_bucket_lifecycle(__MODULE__, bucket, livecycle_config)
      end

      @doc false
      def put_bucket_policy(bucket, policy) do
        ExAws.S3.Impl.put_bucket_policy(__MODULE__, bucket, policy)
      end

      @doc false
      def put_bucket_logging(bucket, logging_config) do
        ExAws.S3.Impl.put_bucket_logging(__MODULE__, bucket, logging_config)
      end

      @doc false
      def put_bucket_notification(bucket, notification_config) do
        ExAws.S3.Impl.put_bucket_notification(__MODULE__, bucket, notification_config)
      end

      @doc false
      def put_bucket_replication(bucket, replication_config) do
        ExAws.S3.Impl.put_bucket_replication(__MODULE__, bucket, replication_config)
      end

      @doc false
      def put_bucket_tagging(bucket, tags) do
        ExAws.S3.Impl.put_bucket_tagging(__MODULE__, bucket, tags)
      end

      @doc false
      def put_bucket_requestpayment(bucket, payer) do
        ExAws.S3.Impl.put_bucket_requestpayment(__MODULE__, bucket, payer)
      end

      @doc false
      def put_bucket_versioning(bucket, version_config) do
        ExAws.S3.Impl.put_bucket_versioning(__MODULE__, bucket, version_config)
      end

      @doc false
      def put_bucket_website(bucket, website_config) do
        ExAws.S3.Impl.put_bucket_website(__MODULE__, bucket, website_config)
      end

      @doc false
      def delete_object(bucket, object, opts \\ %{}) do
        ExAws.S3.Impl.delete_object(__MODULE__, bucket, object, opts)
      end

      @doc false
      def delete_multiple_objects(bucket, objects) do
        ExAws.S3.Impl.delete_multiple_objects(__MODULE__, bucket, objects)
      end

      @doc false
      def get_object(bucket, object, opts \\ %{}) do
        ExAws.S3.Impl.get_object(__MODULE__, bucket, opts)
      end

      @doc false
      def get_object_acl(bucket, object, opts \\ %{}) do
        ExAws.S3.Impl.get_object_acl(__MODULE__, bucket, opts)
      end

      @doc false
      def get_object_torrent(bucket, object) do
        ExAws.S3.Impl.get_object_torrent(__MODULE__, bucket, object)
      end

      @doc false
      def head_object(bucket, object, opts \\ %{}) do
        ExAws.S3.Impl.head_object(__MODULE__, bucket, object, opts)
      end

      @doc false
      def options_object(bucket, object, origin, request_method, request_headers \\ []) do
        ExAws.S3.Impl.options_object(__MODULE__, bucket, object, origin, request_method, request_headers)
      end

      @doc false
      def post_object(bucket, object, opts \\ %{}) do
        ExAws.S3.Impl.post_object(__MODULE__, bucket, object, opts)
      end

      @doc false
      def post_object_restore(bucket, object, version_id, number_of_days) do
        ExAws.S3.Impl.post_object_restore(__MODULE__, bucket, object, version_id, number_of_days)
      end

      @doc false
      def put_object(bucket, object, body, opts \\ %{}) do
        ExAws.S3.Impl.put_object(__MODULE__, bucket, object, body, opts)
      end

      @doc false
      def put_object_acl(bucket, object, acl) do
        ExAws.S3.Impl.put_object_acl(__MODULE__, bucket, object, acl)
      end

      @doc false
      def put_object_copy(dest_bucket, dest_object, src_bucket, src_object, opts \\ %{}) do
        ExAws.S3.Impl.put_object_copy(__MODULE__, dest_bucket, dest_object, src_bucket, src_object, opts)
      end

      @doc false
      def initiate_multipart_upload(bucket, object, opts \\ %{}) do
        ExAws.S3.Impl.initiate_multipart_upload(__MODULE__, bucket, object, opts)
      end

      @doc false
      def upload_part(bucket, object, upload_id, part_number) do
        ExAws.S3.Impl.upload_part(__MODULE__, bucket, object, upload_id, part_number)
      end

      @doc false
      def upload_part_copy(dest_bucket, dest_object, src_bucket, src_object, opts \\ %{}) do
        ExAws.S3.Impl.upload_part_copy(__MODULE__, dest_bucket, dest_object, src_bucket, src_object, opts)
      end

      @doc false
      def complete_multipart_upload(bucket, object, upload_id, parts) do
        ExAws.S3.Impl.complete_multipart_upload(__MODULE__, bucket, object, upload_id, parts)
      end

      @doc false
      def abort_multipart_upload(bucket, object, upload_id) do
        ExAws.S3.Impl.abort_multipart_upload(__MODULE__, bucket, object, upload_id)
      end

      @doc false
      def list_parts(bucket, object, upload_id, opts \\ %{}) do
        ExAws.S3.Impl.list_parts(__MODULE__, bucket, object, upload_id, opts)
      end

      @doc false
      def request(http_method, bucket, path, data \\ []) do
        ExAws.S3.Request.request(__MODULE__, http_method, bucket, path, data)
      end

      @doc false
      def service, do: :s3

      @doc false
      def config_root, do: Application.get_env(@otp_app, :ex_aws)

      @doc false
      def config, do: __MODULE__ |> ExAws.Config.get

      defoverridable config: 0, config_root: 0, request: 3, request: 4

    end
  end

end
