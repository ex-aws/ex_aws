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

    def config_root do
      Application.get_all_env(:my_aws_config_root)
    end
  end
  ```
  ExAws now expects the config for that S3 client to live under

  ```elixir
  config :my_aws_config_root
    s3: [] # S3 config goes here
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
  defcallback list_buckets(opts :: Keyword.t) :: ExAws.Request.response_t

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
  defcallback get_bucket_object_versions(bucket :: binary, opts :: Keyword.t) :: ExAws.Request.response_t

  @doc "Get bucket payment configuration"
  defcallback get_bucket_request_payment(bucket :: binary) :: ExAws.Request.response_t

  @doc "Get bucket versioning"
  defcallback get_bucket_versioning(bucket :: binary) :: ExAws.Request.response_t

  @doc "Get bucket website"
  defcallback get_bucket_website(bucket :: binary) :: ExAws.Request.response_t

  @doc "Determine if a bucket exists"
  defcallback head_bucket(bucket :: binary) :: ExAws.Request.response_t

  @doc "List multipart uploads for a bucket"
  defcallback list_multipart_uploads(bucket :: binary) :: ExAws.Request.response_t
  defcallback list_multipart_uploads(bucket :: binary, opts :: Keyword.t) :: ExAws.Request.response_t

  @doc "Creates a bucket. Same as create_bucket/2"
  defcallback put_bucket(bucket :: binary, region :: binary) :: ExAws.Request.response_t

  @doc "Update or create a bucket bucket access control"
  defcallback put_bucket_acl(bucket :: binary, grants :: %{}) :: ExAws.Request.response_t

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
  defcallback get_object(bucket :: binary, object :: binary, opts :: Keyword.t) :: ExAws.Request.response_t

  @doc "Get an object's access control policy"
  defcallback get_object_acl(bucket :: binary, object :: binary) :: ExAws.Request.response_t
  defcallback get_object_acl(bucket :: binary, object :: binary, opts :: Keyword.t) :: ExAws.Request.response_t

  @doc "Get a torrent for a bucket"
  defcallback get_object_torrent(bucket :: binary, object :: binary) :: ExAws.Request.response_t

  @doc "Determine of an object exists"
  defcallback head_object(bucket :: binary, object :: binary) :: ExAws.Request.response_t
  defcallback head_object(bucket :: binary, object :: binary, opts :: Keyword.t) :: ExAws.Request.response_t

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
  defcallback post_object(bucket :: binary, object :: binary, opts :: Keyword.t) :: ExAws.Request.response_t

  @doc "Restore an object to a particular version FIXME"
  defcallback post_object_restore(
    bucket         :: binary,
    object         :: binary,
    version_id     :: binary,
    number_of_days :: pos_integer) :: ExAws.Request.response_t

  @doc "Create an object within a bucket"
  defcallback put_object(bucket :: binary, object :: binary, body :: binary) :: ExAws.Request.response_t
  defcallback put_object(bucket :: binary, object :: binary, body :: binary, opts :: Keyword.t) :: ExAws.Request.response_t

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
  defcallback initiate_multipart_upload(bucket :: binary, object :: binary, opts :: Keyword.t) :: ExAws.Request.response_t

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
  defcallback list_parts(bucket :: binary, object :: binary, upload_id :: binary, opts :: Keyword.t) :: ExAws.Request.response_t

  @doc """
  Enables custom request handling.

  By default this just forwards the request to the ExAws.S3.Request.request/4.
  However, this can be overriden in your client to provide pre-request adjustments to headers, params, etc.
  """
  defcallback request(client :: %{}, http_method :: atom, bucket :: binary, path :: binary) :: ExAws.Request.response_t
  defcallback request(client :: %{}, http_method :: atom, bucket :: binary, path :: binary, data :: Keyword.t) :: ExAws.Request.response_t

  @doc "Retrieves the root AWS config for this client"
  defcallback config_root() :: Keyword.t

  defmacro __using__(opts) do
    boilerplate = __MODULE__
    |> ExAws.Client.generate_boilerplate(opts)

    quote do
      defstruct config: nil, service: :s3
      unquote(boilerplate)

      @doc false
      def request(client, http_method, bucket, path, data \\ []) do
        ExAws.S3.Request.request(client, http_method, bucket, path, data)
      end

      defoverridable config_root: 0, request: 4, request: 5

    end
  end

end
