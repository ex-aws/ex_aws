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

  @moduledoc """
  ## AWS CodePipeline

  AWS CodePipeline

  **Overview** This is the AWS CodePipeline API Reference. This guide
  provides descriptions of the actions and data types for AWS CodePipeline.
  Some functionality for your pipeline is only configurable through the API.
  For additional information, see the [AWS CodePipeline User
  Guide](http://docs.aws.amazon.com/pipelines/latest/userguide/welcome.html).

  You can use the AWS CodePipeline API to work with pipelines, stages,
  actions, gates, and transitions, as described below.

  *Pipelines* are models of automated release processes. Each pipeline is
  uniquely named, and consists of actions, gates, and stages.

  You can work with pipelines by calling: <ul> <li> `CreatePipeline`, which
  creates a uniquely-named pipeline.</li> <li> `DeletePipeline`, which
  deletes the specified pipeline.</li> <li> `GetPipeline`, which returns
  information about a pipeline structure.</li> <li> `GetPipelineState`, which
  returns information about the current state of the stages and actions of a
  pipeline.</li> <li> `ListPipelines`, which gets a summary of all of the
  pipelines associated with your account.</li> <li> `StartPipelineExecution`,
  which runs the the most recent revision of an artifact through the
  pipeline.</li> <li> `UpdatePipeline`, which updates a pipeline with edits
  or changes to the structure of the pipeline.</li> </ul> Pipelines include
  *stages*, which are which are logical groupings of gates and actions. Each
  stage contains one or more actions that must complete before the next stage
  begins. A stage will result in success or failure. If a stage fails, then
  the pipeline stops at that stage and will remain stopped until either a new
  version of an artifact appears in the source location, or a user takes
  action to re-run the most recent artifact through the pipeline. You can
  call `GetPipelineState`, which displays the status of a pipeline, including
  the status of stages in the pipeline, or `GetPipeline`, which returns the
  entire structure of the pipeline, including the stages of that pipeline.
  For more information about the structure of stages and actions, also refer
  to the <ulink
  url="http://docs.aws.amazon.com/codepipeline/latest/UserGuide/pipeline-structure.html">AWS
  CodePipeline Pipeline Structure Reference</ulink>.

  Pipeline stages include *actions*, which are categorized into categories
  such as source or build actions performed within a stage of a pipeline. For
  example, you can use a source action to import artifacts into a pipeline
  from a source such as Amazon S3. Like stages, you do not work with actions
  directly in most cases, but you do define and interact with actions when
  working with pipeline operations such as `CreatePipeline` and
  `GetPipelineState`.

  Pipelines also include *transitions*, which allow the transition of
  artifacts from one stage to the next in a pipeline after the actions in one
  stage complete.

  You can work with transitions by calling:

  <ul> <li> `DisableStageTransition`, which prevents artifacts from
  transitioning to the next stage in a pipeline.</li> <li>
  `EnableStageTransition`, which enables transition of artifacts between
  stages in a pipeline. </li> </ul> **Using the API to integrate with AWS
  CodePipeline**

  For third-party integrators or developers who want to create their own
  integrations with AWS CodePipeline, the expected sequence varies from the
  standard API user. In order to integrate with AWS CodePipeline, developers
  will need to work with the following items:

  <ul> <li>Jobs, which are instances of an action. For example, a job for a
  source action might import a revision of an artifact from a source. You can
  work with jobs by calling:

  <ul> <li> `AcknowledgeJob`, which confirms whether a job worker has
  received the specified job,</li> <li> `GetJobDetails`, which returns the
  details of a job,</li> <li> `PollForJobs`, which determines whether there
  are any jobs to act upon, </li> <li> `PutJobFailureResult`, which provides
  details of a job failure, and</li> <li> `PutJobSuccessResult`, which
  provides details of a job success.</li> </ul> </li> <li>Third party jobs,
  which are instances of an action created by a partner action and integrated
  into AWS CodePipeline. Partner actions are created by members of the AWS
  Partner Network. You can work with third party jobs by calling:

  <ul> <li> `AcknowledgeThirdPartyJob`, which confirms whether a job worker
  has received the specified job,</li> <li> `GetThirdPartyJobDetails`, which
  requests the details of a job for a partner action,</li> <li>
  `PollForThirdPartyJobs`, which determines whether there are any jobs to act
  upon, </li> <li> `PutThirdPartyJobFailureResult`, which provides details of
  a job failure, and</li> <li> `PutThirdPartyJobSuccessResult`, which
  provides details of a job success.</li> </ul> </li> </ul>
  """


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
