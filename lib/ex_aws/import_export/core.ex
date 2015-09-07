defmodule ExAws.ImportExport.Core do
  @actions [
    "CancelJob",
    "CreateJob",
    "GetShippingLabel",
    "GetStatus",
    "ListJobs",
    "UpdateJob"]

  @moduledoc """
  ## AWS Import/Export

  AWS Import/Export Service

  AWS Import/Export accelerates transferring large amounts of data between
  the AWS cloud and portable storage devices that you mail to us. AWS
  Import/Export transfers data directly onto and off of your storage devices
  using Amazon's high-speed internal network and bypassing the Internet. For
  large data sets, AWS Import/Export is often faster than Internet transfer
  and more cost effective than upgrading your connectivity.
  """

  @type api_version :: binary

  @type artifact :: [
    description: description,
    url: url,
  ]

  @type artifact_list :: [artifact]

  @type bucket_permission_exception :: [
    message: error_message,
  ]

  @type cancel_job_input :: [
    api_version: api_version,
    job_id: job_id,
  ]

  @type cancel_job_output :: [
    success: success,
  ]

  @type canceled_job_id_exception :: [
    message: error_message,
  ]

  @type carrier :: binary

  @type create_job_input :: [
    api_version: api_version,
    job_type: job_type,
    manifest: manifest,
    manifest_addendum: manifest_addendum,
    validate_only: validate_only,
  ]

  @type create_job_output :: [
    artifact_list: artifact_list,
    job_id: job_id,
    job_type: job_type,
    signature: signature,
    signature_file_contents: signature_file_contents,
    warning_message: warning_message,
  ]

  @type create_job_quota_exceeded_exception :: [
    message: error_message,
  ]

  @type creation_date :: integer

  @type current_manifest :: binary

  @type description :: binary

  @type error_count :: integer

  @type error_message :: binary

  @type expired_job_id_exception :: [
    message: error_message,
  ]

  @type generic_string :: binary

  @type get_shipping_label_input :: [
    api_version: generic_string,
    city: generic_string,
    company: generic_string,
    country: generic_string,
    job_ids: job_id_list,
    name: generic_string,
    phone_number: generic_string,
    postal_code: generic_string,
    state_or_province: generic_string,
    street1: generic_string,
    street2: generic_string,
    street3: generic_string,
  ]

  @type get_shipping_label_output :: [
    shipping_label_url: generic_string,
    warning: generic_string,
  ]

  @type get_status_input :: [
    api_version: api_version,
    job_id: job_id,
  ]

  @type get_status_output :: [
    artifact_list: artifact_list,
    carrier: carrier,
    creation_date: creation_date,
    current_manifest: current_manifest,
    error_count: error_count,
    job_id: job_id,
    job_type: job_type,
    location_code: location_code,
    location_message: location_message,
    log_bucket: log_bucket,
    log_key: log_key,
    progress_code: progress_code,
    progress_message: progress_message,
    signature: signature,
    signature_file_contents: signature,
    tracking_number: tracking_number,
  ]

  @type invalid_access_key_id_exception :: [
    message: error_message,
  ]

  @type invalid_address_exception :: [
    message: error_message,
  ]

  @type invalid_customs_exception :: [
    message: error_message,
  ]

  @type invalid_file_system_exception :: [
    message: error_message,
  ]

  @type invalid_job_id_exception :: [
    message: error_message,
  ]

  @type invalid_manifest_field_exception :: [
    message: error_message,
  ]

  @type invalid_parameter_exception :: [
    message: error_message,
  ]

  @type invalid_version_exception :: [
    message: error_message,
  ]

  @type is_canceled :: boolean

  @type is_truncated :: boolean

  @type job :: [
    creation_date: creation_date,
    is_canceled: is_canceled,
    job_id: job_id,
    job_type: job_type,
  ]

  @type job_id :: binary

  @type job_id_list :: [generic_string]

  @type job_type :: binary

  @type jobs_list :: [job]

  @type list_jobs_input :: [
    api_version: api_version,
    marker: marker,
    max_jobs: max_jobs,
  ]

  @type list_jobs_output :: [
    is_truncated: is_truncated,
    jobs: jobs_list,
  ]

  @type location_code :: binary

  @type location_message :: binary

  @type log_bucket :: binary

  @type log_key :: binary

  @type malformed_manifest_exception :: [
    message: error_message,
  ]

  @type manifest :: binary

  @type manifest_addendum :: binary

  @type marker :: binary

  @type max_jobs :: integer

  @type missing_customs_exception :: [
    message: error_message,
  ]

  @type missing_manifest_field_exception :: [
    message: error_message,
  ]

  @type missing_parameter_exception :: [
    message: error_message,
  ]

  @type multiple_regions_exception :: [
    message: error_message,
  ]

  @type no_such_bucket_exception :: [
    message: error_message,
  ]

  @type progress_code :: binary

  @type progress_message :: binary

  @type signature :: binary

  @type signature_file_contents :: binary

  @type success :: boolean

  @type tracking_number :: binary

  @type url :: binary

  @type unable_to_cancel_job_id_exception :: [
    message: error_message,
  ]

  @type unable_to_update_job_id_exception :: [
    message: error_message,
  ]

  @type update_job_input :: [
    api_version: api_version,
    job_id: job_id,
    job_type: job_type,
    manifest: manifest,
    validate_only: validate_only,
  ]

  @type update_job_output :: [
    artifact_list: artifact_list,
    success: success,
    warning_message: warning_message,
  ]

  @type validate_only :: boolean

  @type warning_message :: binary




  @doc """
  CancelJob

  This operation cancels a specified job. Only the job owner can cancel it.
  The operation fails if the job has already started or is complete.
  """

  @spec cancel_job(client :: ExAws.ImportExport.t, input :: cancel_job_input) :: ExAws.Request.Query.response_t
  def cancel_job(client, input) do
    request(client, "/?Operation=CancelJob", "CancelJob", input)
  end

  @doc """
  Same as `cancel_job/2` but raise on error.
  """
  @spec cancel_job!(client :: ExAws.ImportExport.t, input :: cancel_job_input) :: ExAws.Request.Query.success_t | no_return
  def cancel_job!(client, input) do
    case cancel_job(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateJob

  This operation initiates the process of scheduling an upload or download of
  your data. You include in the request a manifest that describes the data
  transfer specifics. The response to the request includes a job ID, which
  you can use in other operations, a signature that you use to identify your
  storage device, and the address where you should ship your storage device.
  """

  @spec create_job(client :: ExAws.ImportExport.t, input :: create_job_input) :: ExAws.Request.Query.response_t
  def create_job(client, input) do
    request(client, "/?Operation=CreateJob", "CreateJob", input)
  end

  @doc """
  Same as `create_job/2` but raise on error.
  """
  @spec create_job!(client :: ExAws.ImportExport.t, input :: create_job_input) :: ExAws.Request.Query.success_t | no_return
  def create_job!(client, input) do
    case create_job(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetShippingLabel

  This operation generates a pre-paid UPS shipping label that you will use to
  ship your device to AWS for processing.
  """

  @spec get_shipping_label(client :: ExAws.ImportExport.t, input :: get_shipping_label_input) :: ExAws.Request.Query.response_t
  def get_shipping_label(client, input) do
    request(client, "/?Operation=GetShippingLabel", "GetShippingLabel", input)
  end

  @doc """
  Same as `get_shipping_label/2` but raise on error.
  """
  @spec get_shipping_label!(client :: ExAws.ImportExport.t, input :: get_shipping_label_input) :: ExAws.Request.Query.success_t | no_return
  def get_shipping_label!(client, input) do
    case get_shipping_label(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetStatus

  This operation returns information about a job, including where the job is
  in the processing pipeline, the status of the results, and the signature
  value associated with the job. You can only return information about jobs
  you own.
  """

  @spec get_status(client :: ExAws.ImportExport.t, input :: get_status_input) :: ExAws.Request.Query.response_t
  def get_status(client, input) do
    request(client, "/?Operation=GetStatus", "GetStatus", input)
  end

  @doc """
  Same as `get_status/2` but raise on error.
  """
  @spec get_status!(client :: ExAws.ImportExport.t, input :: get_status_input) :: ExAws.Request.Query.success_t | no_return
  def get_status!(client, input) do
    case get_status(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListJobs

  This operation returns the jobs associated with the requester. AWS
  Import/Export lists the jobs in reverse chronological order based on the
  date of creation. For example if Job Test1 was created 2009Dec30 and Test2
  was created 2010Feb05, the ListJobs operation would return Test2 followed
  by Test1.
  """

  @spec list_jobs(client :: ExAws.ImportExport.t, input :: list_jobs_input) :: ExAws.Request.Query.response_t
  def list_jobs(client, input) do
    request(client, "/?Operation=ListJobs", "ListJobs", input)
  end

  @doc """
  Same as `list_jobs/2` but raise on error.
  """
  @spec list_jobs!(client :: ExAws.ImportExport.t, input :: list_jobs_input) :: ExAws.Request.Query.success_t | no_return
  def list_jobs!(client, input) do
    case list_jobs(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateJob

  You use this operation to change the parameters specified in the original
  manifest file by supplying a new manifest file. The manifest file attached
  to this request replaces the original manifest file. You can only use the
  operation after a CreateJob request but before the data transfer starts and
  you can only use it on jobs you own.
  """

  @spec update_job(client :: ExAws.ImportExport.t, input :: update_job_input) :: ExAws.Request.Query.response_t
  def update_job(client, input) do
    request(client, "/?Operation=UpdateJob", "UpdateJob", input)
  end

  @doc """
  Same as `update_job/2` but raise on error.
  """
  @spec update_job!(client :: ExAws.ImportExport.t, input :: update_job_input) :: ExAws.Request.Query.success_t | no_return
  def update_job!(client, input) do
    case update_job(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  defp request(%{__struct__: client_module} = client, uri, action, input) do
    apply(client_module, :request, [client, uri, action, input])
  end
end
