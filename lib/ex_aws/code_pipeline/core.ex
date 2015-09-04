defmodule ExAws.CodePipeline.Core do
  @actions [
    "AcknowledgeJob",
    "AcknowledgeThirdPartyJob",
    "CreateCustomActionType",
    "CreatePipeline",
    "DeleteCustomActionType",
    "DeletePipeline",
    "DisableStageTransition",
    "EnableStageTransition",
    "GetJobDetails",
    "GetPipeline",
    "GetPipelineState",
    "GetThirdPartyJobDetails",
    "ListActionTypes",
    "ListPipelines",
    "PollForJobs",
    "PollForThirdPartyJobs",
    "PutActionRevision",
    "PutJobFailureResult",
    "PutJobSuccessResult",
    "PutThirdPartyJobFailureResult",
    "PutThirdPartyJobSuccessResult",
    "StartPipelineExecution",
    "UpdatePipeline"]


  @doc """
  AcknowledgeJob

  Returns information about a specified job and whether that job has been
  received by the job worker. Only used for custom actions.
  """
  def acknowledge_job(client, input) do
    request(client, "AcknowledgeJob", input)
  end

  @doc """
  AcknowledgeThirdPartyJob

  Confirms a job worker has received the specified job. Only used for partner
  actions.
  """
  def acknowledge_third_party_job(client, input) do
    request(client, "AcknowledgeThirdPartyJob", input)
  end

  @doc """
  CreateCustomActionType

  Creates a new custom action that can be used in all pipelines associated
  with the AWS account. Only used for custom actions.
  """
  def create_custom_action_type(client, input) do
    request(client, "CreateCustomActionType", input)
  end

  @doc """
  CreatePipeline

  Creates a pipeline.
  """
  def create_pipeline(client, input) do
    request(client, "CreatePipeline", input)
  end

  @doc """
  DeleteCustomActionType

  Marks a custom action as deleted. PollForJobs for the custom action will
  fail after the action is marked for deletion. Only used for custom actions.

  <important>You cannot recreate a custom action after it has been deleted
  unless you increase the version number of the action.

  </important>
  """
  def delete_custom_action_type(client, input) do
    request(client, "DeleteCustomActionType", input)
  end

  @doc """
  DeletePipeline

  Deletes the specified pipeline.
  """
  def delete_pipeline(client, input) do
    request(client, "DeletePipeline", input)
  end

  @doc """
  DisableStageTransition

  Prevents artifacts in a pipeline from transitioning to the next stage in
  the pipeline.
  """
  def disable_stage_transition(client, input) do
    request(client, "DisableStageTransition", input)
  end

  @doc """
  EnableStageTransition

  Enables artifacts in a pipeline to transition to a stage in a pipeline.
  """
  def enable_stage_transition(client, input) do
    request(client, "EnableStageTransition", input)
  end

  @doc """
  GetJobDetails

  Returns information about a job. Only used for custom actions.

  <important>When this API is called, AWS CodePipeline returns temporary
  credentials for the Amazon S3 bucket used to store artifacts for the
  pipeline, if the action requires access to that Amazon S3 bucket for input
  or output artifacts. Additionally, this API returns any secret values
  defined for the action.

  </important>
  """
  def get_job_details(client, input) do
    request(client, "GetJobDetails", input)
  end

  @doc """
  GetPipeline

  Returns the metadata, structure, stages, and actions of a pipeline. Can be
  used to return the entire structure of a pipeline in JSON format, which can
  then be modified and used to update the pipeline structure with
  `UpdatePipeline`.
  """
  def get_pipeline(client, input) do
    request(client, "GetPipeline", input)
  end

  @doc """
  GetPipelineState

  Returns information about the state of a pipeline, including the stages,
  actions, and details about the last run of the pipeline.
  """
  def get_pipeline_state(client, input) do
    request(client, "GetPipelineState", input)
  end

  @doc """
  GetThirdPartyJobDetails

  Requests the details of a job for a third party action. Only used for
  partner actions.

  <important>When this API is called, AWS CodePipeline returns temporary
  credentials for the Amazon S3 bucket used to store artifacts for the
  pipeline, if the action requires access to that Amazon S3 bucket for input
  or output artifacts. Additionally, this API returns any secret values
  defined for the action.

  </important>
  """
  def get_third_party_job_details(client, input) do
    request(client, "GetThirdPartyJobDetails", input)
  end

  @doc """
  ListActionTypes

  Gets a summary of all AWS CodePipeline action types associated with your
  account.
  """
  def list_action_types(client, input) do
    request(client, "ListActionTypes", input)
  end

  @doc """
  ListPipelines

  Gets a summary of all of the pipelines associated with your account.
  """
  def list_pipelines(client, input) do
    request(client, "ListPipelines", input)
  end

  @doc """
  PollForJobs

  Returns information about any jobs for AWS CodePipeline to act upon.

  <important>When this API is called, AWS CodePipeline returns temporary
  credentials for the Amazon S3 bucket used to store artifacts for the
  pipeline, if the action requires access to that Amazon S3 bucket for input
  or output artifacts. Additionally, this API returns any secret values
  defined for the action.

  </important>
  """
  def poll_for_jobs(client, input) do
    request(client, "PollForJobs", input)
  end

  @doc """
  PollForThirdPartyJobs

  Determines whether there are any third party jobs for a job worker to act
  on. Only used for partner actions.

  <important>When this API is called, AWS CodePipeline returns temporary
  credentials for the Amazon S3 bucket used to store artifacts for the
  pipeline, if the action requires access to that Amazon S3 bucket for input
  or output artifacts.

  </important>
  """
  def poll_for_third_party_jobs(client, input) do
    request(client, "PollForThirdPartyJobs", input)
  end

  @doc """
  PutActionRevision

  Provides information to AWS CodePipeline about new revisions to a source.
  """
  def put_action_revision(client, input) do
    request(client, "PutActionRevision", input)
  end

  @doc """
  PutJobFailureResult

  Represents the failure of a job as returned to the pipeline by a job
  worker. Only used for custom actions.
  """
  def put_job_failure_result(client, input) do
    request(client, "PutJobFailureResult", input)
  end

  @doc """
  PutJobSuccessResult

  Represents the success of a job as returned to the pipeline by a job
  worker. Only used for custom actions.
  """
  def put_job_success_result(client, input) do
    request(client, "PutJobSuccessResult", input)
  end

  @doc """
  PutThirdPartyJobFailureResult

  Represents the failure of a third party job as returned to the pipeline by
  a job worker. Only used for partner actions.
  """
  def put_third_party_job_failure_result(client, input) do
    request(client, "PutThirdPartyJobFailureResult", input)
  end

  @doc """
  PutThirdPartyJobSuccessResult

  Represents the success of a third party job as returned to the pipeline by
  a job worker. Only used for partner actions.
  """
  def put_third_party_job_success_result(client, input) do
    request(client, "PutThirdPartyJobSuccessResult", input)
  end

  @doc """
  StartPipelineExecution

  Starts the specified pipeline. Specifically, it begins processing the
  latest commit to the source location specified as part of the pipeline.
  """
  def start_pipeline_execution(client, input) do
    request(client, "StartPipelineExecution", input)
  end

  @doc """
  UpdatePipeline

  Updates a specified pipeline with edits or changes to its structure. Use a
  JSON file with the pipeline structure in conjunction with UpdatePipeline to
  provide the full structure of the pipeline. Updating the pipeline increases
  the version number of the pipeline by 1.
  """
  def update_pipeline(client, input) do
    request(client, "UpdatePipeline", input)
  end


  defp request(%{__struct__: client_module} = client, action, input) do
    client_module.request(client, action, input)
  end
end
