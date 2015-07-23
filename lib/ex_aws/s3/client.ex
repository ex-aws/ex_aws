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

  # Common general types
  @type acl_opts :: [{:acl, canned_acl} | grant]
  @type grant :: {:grant_read, grantee}
    | {:grant_read_acp, grantee}
    | {:grant_write_acp, grantee}
    | {:grant_full_control, grantee}
  @type canned_acl :: :private
    | :public_read
    | :public_read_write
    | :authenticated_read
    | :bucket_owner_read
    | :bucket_owner_full_control
  @type grantee :: [ {:email, binary}
    | {:id, binary}
    | {:uri, binary}
  ]

  @type customer_encryption_opts :: [
    customer_algorithm: binary,
    customer_key: binary,
    customer_key_md5: binary]
  @type encryption_opts :: binary
    | [aws_kms_key_id: binary]
    | customer_encryption_opts

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

  @type list_objects_opts :: [
    {:delimiter, binary} |
    {:encoding_type, binary} |
    {:marker, binary} |
    {:max_keys, 0..1000} |
    {:prefix, binary}
  ]
  @doc "List objects in bucket"
  defcallback list_objects(bucket :: binary) :: ExAws.Request.response_t
  defcallback list_objects(bucket :: binary, opts :: list_objects_opts) :: ExAws.Request.response_t

  @doc "Same as list_objects/1,2 but returns the result and raises on failure."
  defcallback list_objects!(bucket :: binary) :: ExAws.Request.success_content
  defcallback list_objects!(bucket :: binary, opts :: list_objects_opts) :: ExAws.Request.success_content

  @doc "Stream list of objects in bucket"
  defcallback stream_objects!(bucket :: binary) :: Enumerable.t
  defcallback stream_objects!(bucket :: binary, opts :: list_objects_opts) :: Enumerable.t

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
  defcallback put_bucket_acl(bucket :: binary, opts :: acl_opts) :: ExAws.Request.response_t

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

  @doc "Update or create a bucket requestPayment configuration"
  defcallback put_bucket_request_payment(bucket :: binary, payer :: :requester | :bucket_owner) :: ExAws.Request.response_t

  @doc "Update or create a bucket versioning configuration"
  defcallback put_bucket_versioning(bucket :: binary, version_config :: binary) :: ExAws.Request.response_t

  @doc "Update or create a bucket website configuration"
  defcallback put_bucket_website(bucket :: binary, website_config :: binary) :: ExAws.Request.response_t


  ## Object functions
  @doc "Delete object object in bucket"
  defcallback delete_object(bucket :: binary, object :: binary) :: ExAws.Request.response_t

  @doc "Same as delete_object/2 but returns just the response or raises on error"
  defcallback delete_object!(bucket :: binary, object :: binary) :: ExAws.Request.success_content

  @doc "Delete multiple objects within a bucket"
  defcallback delete_multiple_objects(
    bucket  :: binary,
    objects :: [binary | {binary, binary}, ...]):: ExAws.Request.response_t
  defcallback delete_multiple_objects(
    bucket  :: binary,
    objects :: [binary | {binary, binary}, ...], opts :: [quiet: true]):: ExAws.Request.response_t

  @type get_object_response_opts :: [
    {:content_language, binary}
    | {:expires, binary}
    | {:cach_control, binary}
    | {:content_disposition, binary}
    | {:content_encoding, binary}
  ]
  @type get_object_opts :: [
    {:response, get_object_response_opts}
    | {:encryption, customer_encryption_opts}
    | {:range, binary}
    | {:if_modified_since, binary}
    | {:if_unmodified_since, binary}
    | {:if_match, binary}
    | {:if_none_match, binary}
  ]
  @doc "Get an object from a bucket"
  defcallback get_object(bucket :: binary, object :: binary) :: ExAws.Request.response_t
  defcallback get_object(bucket :: binary, object :: binary, opts :: get_object_opts) :: ExAws.Request.response_t

  @doc "Same as get_object/2,3 but returns just the response or raises on error"
  defcallback get_object!(bucket :: binary, object :: binary) :: ExAws.Request.success_content
  defcallback get_object!(bucket :: binary, object :: binary, opts :: get_object_opts) :: ExAws.Request.success_content

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

  @doc "Restore an object to a particular version FIXME"
  defcallback post_object_restore(
    bucket         :: binary,
    object         :: binary,
    version_id     :: binary,
    number_of_days :: pos_integer) :: ExAws.Request.response_t

  @type put_object_opts :: [ {:cache_control, binary}
    | {:content_disposition, binary}
    | {:content_encoding, binary}
    | {:content_length, binary}
    | {:content_type, binary}
    | {:expect, binary}
    | {:expires, binary}
    | {:storage_class, binary}
    | {:website_redirect_location, binary}
    | {:encryption, encryption_opts}
    | acl_opts
  ]
  @doc "Create an object within a bucket"
  defcallback put_object(bucket :: binary, object :: binary, body :: binary) :: ExAws.Request.response_t
  defcallback put_object(bucket :: binary, object :: binary, body :: binary, opts :: put_object_opts) :: ExAws.Request.response_t

  @doc "Same as put_object/2 but returns just the response or raises on error"
  defcallback put_object!(bucket :: binary, object :: binary, body :: binary) :: ExAws.Request.success_content
  defcallback put_object!(bucket :: binary, object :: binary, body :: binary, opts :: put_object_opts) :: ExAws.Request.success_content

  @doc "Create or update an object's access control FIXME"
  defcallback put_object_acl(bucket :: binary, object :: binary, acl :: acl_opts) :: ExAws.Request.response_t

  @doc "Same as put_object_acl/3 but raise on error"
  defcallback put_object_acl!(bucket :: binary, object :: binary, acl :: acl_opts) :: ExAws.Request.success_content

  @type pub_object_copy_opts :: [
    {:metadata_directive, :copy | :replace}
    | {:copy_source_if_modified_since, binary}
    | {:copy_source_if_unmodified_since, binary}
    | {:copy_source_if_match, binary}
    | {:copy_source_if_none_match, binary}
    | {:storage_class, :standard, :redunced_redundancy}
    | {:website_redirect_location, binary}
    | {:destination_encryption, encryption_opts}
    | {:source_encryption, customer_encryption_opts}
    | acl_opts
  ]

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
    opts        :: pub_object_copy_opts) :: ExAws.Request.response_t

  @doc "Same as put_object_copy but raise on error"
  defcallback put_object_copy!(
    dest_bucket :: binary,
    dest_object :: binary,
    src_bucket  :: binary,
    src_object  :: binary) :: ExAws.Request.success_content
  defcallback put_object_copy!(
    dest_bucket :: binary,
    dest_object :: binary,
    src_bucket  :: binary,
    src_object  :: binary,
    opts        :: pub_object_copy_opts) :: ExAws.Request.success_content

  @type initiate_multipart_upload_opts :: [ {:cache_control, binary}
    | {:content_disposition, binary}
    | {:content_encoding, binary}
    | {:content_type, binary}
    | {:expires, binary}
    | {:storage_class, :standard | :redunced_redundancy}
    | {:website_redirect_location, binary}
    | {:encryption, encryption_opts}
    | acl_opts
  ]

  @doc "Initiate a multipart upload"
  defcallback initiate_multipart_upload(bucket :: binary, object :: binary) :: ExAws.Request.response_t
  defcallback initiate_multipart_upload(bucket :: binary, object :: binary, opts :: initiate_multipart_upload_opts) :: ExAws.Request.response_t

  @doc "Upload a part for a multipart upload"
  defcallback upload_part(
    bucket      :: binary,
    object      :: binary,
    upload_id   :: binary,
    part_number :: pos_integer) :: ExAws.Request.response_t
  defcallback upload_part(
    bucket      :: binary,
    object      :: binary,
    upload_id   :: binary,
    part_number :: pos_integer,
    opts :: [encryption_opts | {:expect, binary}]) :: ExAws.Request.response_t

  @type upload_part_copy_opts :: [
    {:copy_source_range, Range.t}
    | {:copy_source_if_modified_since, binary}
    | {:copy_source_if_unmodified_since, binary}
    | {:copy_source_if_match, binary}
    | {:copy_source_if_none_match, binary}
    | {:destination_encryption, encryption_opts}
    | {:source_encryption, customer_encryption_opts}
  ]

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
    opts        :: upload_part_copy_opts) :: ExAws.Request.response_t

  @doc "Complete a multipart upload"
  defcallback complete_multipart_upload(
    bucket    :: binary,
    object    :: binary,
    upload_id :: binary,
    parts     :: [{binary | pos_integer, binary}, ...]) :: ExAws.Request.response_t

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
