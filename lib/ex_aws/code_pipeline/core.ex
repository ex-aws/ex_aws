defmodule ExAws.CodePipeline.Core do
  import ExAws.Core.JSON, only: [format_input: 1]
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

  You can work with pipelines by calling:

  - `CreatePipeline`, which creates a uniquely-named pipeline.

  - `DeletePipeline`, which deletes the specified pipeline.

  - `GetPipeline`, which returns information about a pipeline structure.

  - `GetPipelineState`, which returns information about the current state of
  the stages and actions of a pipeline.

  - `ListPipelines`, which gets a summary of all of the pipelines associated
  with your account.

  - `StartPipelineExecution`, which runs the the most recent revision of an
  artifact through the pipeline.

  - `UpdatePipeline`, which updates a pipeline with edits or changes to the
  structure of the pipeline.

  Pipelines include *stages*, which are which are logical groupings of gates
  and actions. Each stage contains one or more actions that must complete
  before the next stage begins. A stage will result in success or failure. If
  a stage fails, then the pipeline stops at that stage and will remain
  stopped until either a new version of an artifact appears in the source
  location, or a user takes action to re-run the most recent artifact through
  the pipeline. You can call `GetPipelineState`, which displays the status of
  a pipeline, including the status of stages in the pipeline, or
  `GetPipeline`, which returns the entire structure of the pipeline,
  including the stages of that pipeline. For more information about the
  structure of stages and actions, also refer to the <ulink
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

  - `DisableStageTransition`, which prevents artifacts from transitioning to
  the next stage in a pipeline.

  - `EnableStageTransition`, which enables transition of artifacts between
  stages in a pipeline.

  **Using the API to integrate with AWS CodePipeline**

  For third-party integrators or developers who want to create their own
  integrations with AWS CodePipeline, the expected sequence varies from the
  standard API user. In order to integrate with AWS CodePipeline, developers
  will need to work with the following items:

  - Jobs, which are instances of an action. For example, a job for a source
  action might import a revision of an artifact from a source. You can work
  with jobs by calling:

  - `AcknowledgeJob`, which confirms whether a job worker has received the
  specified job,

  - `GetJobDetails`, which returns the details of a job,

  - `PollForJobs`, which determines whether there are any jobs to act upon,

  - `PutJobFailureResult`, which provides details of a job failure, and

  - `PutJobSuccessResult`, which provides details of a job success.

  - Third party jobs, which are instances of an action created by a partner
  action and integrated into AWS CodePipeline. Partner actions are created by
  members of the AWS Partner Network. You can work with third party jobs by
  calling:

  - `AcknowledgeThirdPartyJob`, which confirms whether a job worker has
  received the specified job,

  - `GetThirdPartyJobDetails`, which requests the details of a job for a
  partner action,

  - `PollForThirdPartyJobs`, which determines whether there are any jobs to
  act upon,

  - `PutThirdPartyJobFailureResult`, which provides details of a job failure,
  and

  - `PutThirdPartyJobSuccessResult`, which provides details of a job success.
  """

  @type aws_session_credentials :: [
    access_key_id: access_key_id,
    secret_access_key: secret_access_key,
    session_token: session_token,
  ]

  @type access_key_id :: binary

  @type account_id :: binary

  @type acknowledge_job_input :: [
    job_id: job_id,
    nonce: nonce,
  ]

  @type acknowledge_job_output :: [
    status: job_status,
  ]

  @type acknowledge_third_party_job_input :: [
    client_token: client_token,
    job_id: third_party_job_id,
    nonce: nonce,
  ]

  @type acknowledge_third_party_job_output :: [
    status: job_status,
  ]

  @type action_category :: binary

  @type action_configuration :: [
    configuration: action_configuration_map,
  ]

  @type action_configuration_key :: binary

  @type action_configuration_map :: [{action_configuration_key, action_configuration_value}]

  @type action_configuration_property :: [
    description: description,
    key: boolean,
    name: action_configuration_key,
    queryable: boolean,
    required: boolean,
    secret: boolean,
    type: action_configuration_property_type,
  ]

  @type action_configuration_property_list :: [action_configuration_property]

  @type action_configuration_property_type :: binary

  @type action_configuration_queryable_value :: binary

  @type action_configuration_value :: binary

  @type action_context :: [
    name: action_name,
  ]

  @type action_declaration :: [
    action_type_id: action_type_id,
    configuration: action_configuration_map,
    input_artifacts: input_artifact_list,
    name: action_name,
    output_artifacts: output_artifact_list,
    role_arn: role_arn,
    run_order: action_run_order,
  ]

  @type action_execution :: [
    error_details: error_details,
    external_execution_id: execution_id,
    external_execution_url: url,
    last_status_change: timestamp,
    percent_complete: percentage,
    status: action_execution_status,
    summary: execution_summary,
  ]

  @type action_execution_status :: binary

  @type action_name :: binary

  @type action_not_found_exception :: [
  ]

  @type action_owner :: binary

  @type action_provider :: binary

  @type action_revision :: [
    created: timestamp,
    revision_change_id: revision_change_id,
    revision_id: revision_id,
  ]

  @type action_run_order :: integer

  @type action_state :: [
    action_name: action_name,
    current_revision: action_revision,
    entity_url: url,
    latest_execution: action_execution,
    revision_url: url,
  ]

  @type action_state_list :: [action_state]

  @type action_type :: [
    action_configuration_properties: action_configuration_property_list,
    id: action_type_id,
    input_artifact_details: artifact_details,
    output_artifact_details: artifact_details,
    settings: action_type_settings,
  ]

  @type action_type_id :: [
    category: action_category,
    owner: action_owner,
    provider: action_provider,
    version: version,
  ]

  @type action_type_list :: [action_type]

  @type action_type_not_found_exception :: [
  ]

  @type action_type_settings :: [
    entity_url_template: url_template,
    execution_url_template: url_template,
    revision_url_template: url_template,
    third_party_configuration_url: url,
  ]

  @type artifact :: [
    location: artifact_location,
    name: artifact_name,
    revision: revision,
  ]

  @type artifact_details :: [
    maximum_count: maximum_artifact_count,
    minimum_count: minimum_artifact_count,
  ]

  @type artifact_list :: [artifact]

  @type artifact_location :: [
    s3_location: s3_artifact_location,
    type: artifact_location_type,
  ]

  @type artifact_location_type :: binary

  @type artifact_name :: binary

  @type artifact_store :: [
    encryption_key: encryption_key,
    location: artifact_store_location,
    type: artifact_store_type,
  ]

  @type artifact_store_location :: binary

  @type artifact_store_type :: binary

  @type blocker_declaration :: [
    name: blocker_name,
    type: blocker_type,
  ]

  @type blocker_name :: binary

  @type blocker_type :: binary

  @type client_id :: binary

  @type client_token :: binary

  @type code :: binary

  @type continuation_token :: binary

  @type create_custom_action_type_input :: [
    category: action_category,
    configuration_properties: action_configuration_property_list,
    input_artifact_details: artifact_details,
    output_artifact_details: artifact_details,
    provider: action_provider,
    settings: action_type_settings,
    version: version,
  ]

  @type create_custom_action_type_output :: [
    action_type: action_type,
  ]

  @type create_pipeline_input :: [
    pipeline: pipeline_declaration,
  ]

  @type create_pipeline_output :: [
    pipeline: pipeline_declaration,
  ]

  @type current_revision :: [
    change_identifier: revision_change_identifier,
    revision: revision,
  ]

  @type delete_custom_action_type_input :: [
    category: action_category,
    provider: action_provider,
    version: version,
  ]

  @type delete_pipeline_input :: [
    name: pipeline_name,
  ]

  @type description :: binary

  @type disable_stage_transition_input :: [
    pipeline_name: pipeline_name,
    reason: disabled_reason,
    stage_name: stage_name,
    transition_type: stage_transition_type,
  ]

  @type disabled_reason :: binary

  @type enable_stage_transition_input :: [
    pipeline_name: pipeline_name,
    stage_name: stage_name,
    transition_type: stage_transition_type,
  ]

  @type enabled :: boolean

  @type encryption_key :: [
    id: encryption_key_id,
    type: encryption_key_type,
  ]

  @type encryption_key_id :: binary

  @type encryption_key_type :: binary

  @type error_details :: [
    code: code,
    message: message,
  ]

  @type execution_details :: [
    external_execution_id: execution_id,
    percent_complete: percentage,
    summary: execution_summary,
  ]

  @type execution_id :: binary

  @type execution_summary :: binary

  @type failure_details :: [
    external_execution_id: execution_id,
    message: message,
    type: failure_type,
  ]

  @type failure_type :: binary

  @type get_job_details_input :: [
    job_id: job_id,
  ]

  @type get_job_details_output :: [
    job_details: job_details,
  ]

  @type get_pipeline_input :: [
    name: pipeline_name,
    version: pipeline_version,
  ]

  @type get_pipeline_output :: [
    pipeline: pipeline_declaration,
  ]

  @type get_pipeline_state_input :: [
    name: pipeline_name,
  ]

  @type get_pipeline_state_output :: [
    created: timestamp,
    pipeline_name: pipeline_name,
    pipeline_version: pipeline_version,
    stage_states: stage_state_list,
    updated: timestamp,
  ]

  @type get_third_party_job_details_input :: [
    client_token: client_token,
    job_id: third_party_job_id,
  ]

  @type get_third_party_job_details_output :: [
    job_details: third_party_job_details,
  ]

  @type input_artifact :: [
    name: artifact_name,
  ]

  @type input_artifact_list :: [input_artifact]

  @type invalid_action_declaration_exception :: [
  ]

  @type invalid_blocker_declaration_exception :: [
  ]

  @type invalid_client_token_exception :: [
  ]

  @type invalid_job_exception :: [
  ]

  @type invalid_job_state_exception :: [
  ]

  @type invalid_next_token_exception :: [
  ]

  @type invalid_nonce_exception :: [
  ]

  @type invalid_stage_declaration_exception :: [
  ]

  @type invalid_structure_exception :: [
  ]

  @type job :: [
    account_id: account_id,
    data: job_data,
    id: job_id,
    nonce: nonce,
  ]

  @type job_data :: [
    action_configuration: action_configuration,
    action_type_id: action_type_id,
    artifact_credentials: aws_session_credentials,
    continuation_token: continuation_token,
    encryption_key: encryption_key,
    input_artifacts: artifact_list,
    output_artifacts: artifact_list,
    pipeline_context: pipeline_context,
  ]

  @type job_details :: [
    account_id: account_id,
    data: job_data,
    id: job_id,
  ]

  @type job_id :: binary

  @type job_list :: [job]

  @type job_not_found_exception :: [
  ]

  @type job_status :: binary

  @type last_changed_at :: integer

  @type last_changed_by :: binary

  @type limit_exceeded_exception :: [
  ]

  @type list_action_types_input :: [
    action_owner_filter: action_owner,
    next_token: next_token,
  ]

  @type list_action_types_output :: [
    action_types: action_type_list,
    next_token: next_token,
  ]

  @type list_pipelines_input :: [
    next_token: next_token,
  ]

  @type list_pipelines_output :: [
    next_token: next_token,
    pipelines: pipeline_list,
  ]

  @type max_batch_size :: integer

  @type maximum_artifact_count :: integer

  @type message :: binary

  @type minimum_artifact_count :: integer

  @type next_token :: binary

  @type nonce :: binary

  @type output_artifact :: [
    name: artifact_name,
  ]

  @type output_artifact_list :: [output_artifact]

  @type percentage :: integer

  @type pipeline_context :: [
    action: action_context,
    pipeline_name: pipeline_name,
    stage: stage_context,
  ]

  @type pipeline_declaration :: [
    artifact_store: artifact_store,
    name: pipeline_name,
    role_arn: role_arn,
    stages: pipeline_stage_declaration_list,
    version: pipeline_version,
  ]

  @type pipeline_execution_id :: binary

  @type pipeline_list :: [pipeline_summary]

  @type pipeline_name :: binary

  @type pipeline_name_in_use_exception :: [
  ]

  @type pipeline_not_found_exception :: [
  ]

  @type pipeline_stage_declaration_list :: [stage_declaration]

  @type pipeline_summary :: [
    created: timestamp,
    name: pipeline_name,
    updated: timestamp,
    version: pipeline_version,
  ]

  @type pipeline_version :: integer

  @type pipeline_version_not_found_exception :: [
  ]

  @type poll_for_jobs_input :: [
    action_type_id: action_type_id,
    max_batch_size: max_batch_size,
    query_param: query_param_map,
  ]

  @type poll_for_jobs_output :: [
    jobs: job_list,
  ]

  @type poll_for_third_party_jobs_input :: [
    action_type_id: action_type_id,
    max_batch_size: max_batch_size,
  ]

  @type poll_for_third_party_jobs_output :: [
    jobs: third_party_job_list,
  ]

  @type put_action_revision_input :: [
    action_name: action_name,
    action_revision: action_revision,
    pipeline_name: pipeline_name,
    stage_name: stage_name,
  ]

  @type put_action_revision_output :: [
    new_revision: boolean,
    pipeline_execution_id: pipeline_execution_id,
  ]

  @type put_job_failure_result_input :: [
    failure_details: failure_details,
    job_id: job_id,
  ]

  @type put_job_success_result_input :: [
    continuation_token: continuation_token,
    current_revision: current_revision,
    execution_details: execution_details,
    job_id: job_id,
  ]

  @type put_third_party_job_failure_result_input :: [
    client_token: client_token,
    failure_details: failure_details,
    job_id: third_party_job_id,
  ]

  @type put_third_party_job_success_result_input :: [
    client_token: client_token,
    continuation_token: continuation_token,
    current_revision: current_revision,
    execution_details: execution_details,
    job_id: third_party_job_id,
  ]

  @type query_param_map :: [{action_configuration_key, action_configuration_queryable_value}]

  @type revision :: binary

  @type revision_change_id :: binary

  @type revision_change_identifier :: binary

  @type revision_id :: binary

  @type role_arn :: binary

  @type s3_artifact_location :: [
    bucket_name: s3_bucket_name,
    object_key: s3_object_key,
  ]

  @type s3_bucket_name :: binary

  @type s3_object_key :: binary

  @type secret_access_key :: binary

  @type session_token :: binary

  @type stage_action_declaration_list :: [action_declaration]

  @type stage_blocker_declaration_list :: [blocker_declaration]

  @type stage_context :: [
    name: stage_name,
  ]

  @type stage_declaration :: [
    actions: stage_action_declaration_list,
    blockers: stage_blocker_declaration_list,
    name: stage_name,
  ]

  @type stage_name :: binary

  @type stage_not_found_exception :: [
  ]

  @type stage_state :: [
    action_states: action_state_list,
    inbound_transition_state: transition_state,
    stage_name: stage_name,
  ]

  @type stage_state_list :: [stage_state]

  @type stage_transition_type :: binary

  @type start_pipeline_execution_input :: [
    name: pipeline_name,
  ]

  @type start_pipeline_execution_output :: [
    pipeline_execution_id: pipeline_execution_id,
  ]

  @type third_party_job :: [
    client_id: client_id,
    job_id: job_id,
  ]

  @type third_party_job_data :: [
    action_configuration: action_configuration,
    action_type_id: action_type_id,
    artifact_credentials: aws_session_credentials,
    continuation_token: continuation_token,
    encryption_key: encryption_key,
    input_artifacts: artifact_list,
    output_artifacts: artifact_list,
    pipeline_context: pipeline_context,
  ]

  @type third_party_job_details :: [
    data: third_party_job_data,
    id: third_party_job_id,
    nonce: nonce,
  ]

  @type third_party_job_id :: binary

  @type third_party_job_list :: [third_party_job]

  @type timestamp :: integer

  @type transition_state :: [
    disabled_reason: disabled_reason,
    enabled: enabled,
    last_changed_at: last_changed_at,
    last_changed_by: last_changed_by,
  ]

  @type update_pipeline_input :: [
    pipeline: pipeline_declaration,
  ]

  @type update_pipeline_output :: [
    pipeline: pipeline_declaration,
  ]

  @type url :: binary

  @type url_template :: binary

  @type validation_exception :: [
  ]

  @type version :: binary





  @doc """
  AcknowledgeJob

  Returns information about a specified job and whether that job has been
  received by the job worker. Only used for custom actions.
  """

  @spec acknowledge_job(client :: ExAws.CodePipeline.t, input :: acknowledge_job_input) :: ExAws.Request.JSON.response_t
  def acknowledge_job(client, input) do
    request(client, "AcknowledgeJob", format_input(input))
  end

  @doc """
  Same as `acknowledge_job/2` but raise on error.
  """
  @spec acknowledge_job!(client :: ExAws.CodePipeline.t, input :: acknowledge_job_input) :: ExAws.Request.JSON.success_t | no_return
  def acknowledge_job!(client, input) do
    case acknowledge_job(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  AcknowledgeThirdPartyJob

  Confirms a job worker has received the specified job. Only used for partner
  actions.
  """

  @spec acknowledge_third_party_job(client :: ExAws.CodePipeline.t, input :: acknowledge_third_party_job_input) :: ExAws.Request.JSON.response_t
  def acknowledge_third_party_job(client, input) do
    request(client, "AcknowledgeThirdPartyJob", format_input(input))
  end

  @doc """
  Same as `acknowledge_third_party_job/2` but raise on error.
  """
  @spec acknowledge_third_party_job!(client :: ExAws.CodePipeline.t, input :: acknowledge_third_party_job_input) :: ExAws.Request.JSON.success_t | no_return
  def acknowledge_third_party_job!(client, input) do
    case acknowledge_third_party_job(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateCustomActionType

  Creates a new custom action that can be used in all pipelines associated
  with the AWS account. Only used for custom actions.
  """

  @spec create_custom_action_type(client :: ExAws.CodePipeline.t, input :: create_custom_action_type_input) :: ExAws.Request.JSON.response_t
  def create_custom_action_type(client, input) do
    request(client, "CreateCustomActionType", format_input(input))
  end

  @doc """
  Same as `create_custom_action_type/2` but raise on error.
  """
  @spec create_custom_action_type!(client :: ExAws.CodePipeline.t, input :: create_custom_action_type_input) :: ExAws.Request.JSON.success_t | no_return
  def create_custom_action_type!(client, input) do
    case create_custom_action_type(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreatePipeline

  Creates a pipeline.
  """

  @spec create_pipeline(client :: ExAws.CodePipeline.t, input :: create_pipeline_input) :: ExAws.Request.JSON.response_t
  def create_pipeline(client, input) do
    request(client, "CreatePipeline", format_input(input))
  end

  @doc """
  Same as `create_pipeline/2` but raise on error.
  """
  @spec create_pipeline!(client :: ExAws.CodePipeline.t, input :: create_pipeline_input) :: ExAws.Request.JSON.success_t | no_return
  def create_pipeline!(client, input) do
    case create_pipeline(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteCustomActionType

  Marks a custom action as deleted. PollForJobs for the custom action will
  fail after the action is marked for deletion. Only used for custom actions.

  **You cannot recreate a custom action after it has been deleted unless you
  increase the version number of the action.

  **
  """

  @spec delete_custom_action_type(client :: ExAws.CodePipeline.t, input :: delete_custom_action_type_input) :: ExAws.Request.JSON.response_t
  def delete_custom_action_type(client, input) do
    request(client, "DeleteCustomActionType", format_input(input))
  end

  @doc """
  Same as `delete_custom_action_type/2` but raise on error.
  """
  @spec delete_custom_action_type!(client :: ExAws.CodePipeline.t, input :: delete_custom_action_type_input) :: ExAws.Request.JSON.success_t | no_return
  def delete_custom_action_type!(client, input) do
    case delete_custom_action_type(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeletePipeline

  Deletes the specified pipeline.
  """

  @spec delete_pipeline(client :: ExAws.CodePipeline.t, input :: delete_pipeline_input) :: ExAws.Request.JSON.response_t
  def delete_pipeline(client, input) do
    request(client, "DeletePipeline", format_input(input))
  end

  @doc """
  Same as `delete_pipeline/2` but raise on error.
  """
  @spec delete_pipeline!(client :: ExAws.CodePipeline.t, input :: delete_pipeline_input) :: ExAws.Request.JSON.success_t | no_return
  def delete_pipeline!(client, input) do
    case delete_pipeline(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DisableStageTransition

  Prevents artifacts in a pipeline from transitioning to the next stage in
  the pipeline.
  """

  @spec disable_stage_transition(client :: ExAws.CodePipeline.t, input :: disable_stage_transition_input) :: ExAws.Request.JSON.response_t
  def disable_stage_transition(client, input) do
    request(client, "DisableStageTransition", format_input(input))
  end

  @doc """
  Same as `disable_stage_transition/2` but raise on error.
  """
  @spec disable_stage_transition!(client :: ExAws.CodePipeline.t, input :: disable_stage_transition_input) :: ExAws.Request.JSON.success_t | no_return
  def disable_stage_transition!(client, input) do
    case disable_stage_transition(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  EnableStageTransition

  Enables artifacts in a pipeline to transition to a stage in a pipeline.
  """

  @spec enable_stage_transition(client :: ExAws.CodePipeline.t, input :: enable_stage_transition_input) :: ExAws.Request.JSON.response_t
  def enable_stage_transition(client, input) do
    request(client, "EnableStageTransition", format_input(input))
  end

  @doc """
  Same as `enable_stage_transition/2` but raise on error.
  """
  @spec enable_stage_transition!(client :: ExAws.CodePipeline.t, input :: enable_stage_transition_input) :: ExAws.Request.JSON.success_t | no_return
  def enable_stage_transition!(client, input) do
    case enable_stage_transition(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetJobDetails

  Returns information about a job. Only used for custom actions.

  **When this API is called, AWS CodePipeline returns temporary credentials
  for the Amazon S3 bucket used to store artifacts for the pipeline, if the
  action requires access to that Amazon S3 bucket for input or output
  artifacts. Additionally, this API returns any secret values defined for the
  action.

  **
  """

  @spec get_job_details(client :: ExAws.CodePipeline.t, input :: get_job_details_input) :: ExAws.Request.JSON.response_t
  def get_job_details(client, input) do
    request(client, "GetJobDetails", format_input(input))
  end

  @doc """
  Same as `get_job_details/2` but raise on error.
  """
  @spec get_job_details!(client :: ExAws.CodePipeline.t, input :: get_job_details_input) :: ExAws.Request.JSON.success_t | no_return
  def get_job_details!(client, input) do
    case get_job_details(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetPipeline

  Returns the metadata, structure, stages, and actions of a pipeline. Can be
  used to return the entire structure of a pipeline in JSON format, which can
  then be modified and used to update the pipeline structure with
  `UpdatePipeline`.
  """

  @spec get_pipeline(client :: ExAws.CodePipeline.t, input :: get_pipeline_input) :: ExAws.Request.JSON.response_t
  def get_pipeline(client, input) do
    request(client, "GetPipeline", format_input(input))
  end

  @doc """
  Same as `get_pipeline/2` but raise on error.
  """
  @spec get_pipeline!(client :: ExAws.CodePipeline.t, input :: get_pipeline_input) :: ExAws.Request.JSON.success_t | no_return
  def get_pipeline!(client, input) do
    case get_pipeline(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetPipelineState

  Returns information about the state of a pipeline, including the stages,
  actions, and details about the last run of the pipeline.
  """

  @spec get_pipeline_state(client :: ExAws.CodePipeline.t, input :: get_pipeline_state_input) :: ExAws.Request.JSON.response_t
  def get_pipeline_state(client, input) do
    request(client, "GetPipelineState", format_input(input))
  end

  @doc """
  Same as `get_pipeline_state/2` but raise on error.
  """
  @spec get_pipeline_state!(client :: ExAws.CodePipeline.t, input :: get_pipeline_state_input) :: ExAws.Request.JSON.success_t | no_return
  def get_pipeline_state!(client, input) do
    case get_pipeline_state(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetThirdPartyJobDetails

  Requests the details of a job for a third party action. Only used for
  partner actions.

  **When this API is called, AWS CodePipeline returns temporary credentials
  for the Amazon S3 bucket used to store artifacts for the pipeline, if the
  action requires access to that Amazon S3 bucket for input or output
  artifacts. Additionally, this API returns any secret values defined for the
  action.

  **
  """

  @spec get_third_party_job_details(client :: ExAws.CodePipeline.t, input :: get_third_party_job_details_input) :: ExAws.Request.JSON.response_t
  def get_third_party_job_details(client, input) do
    request(client, "GetThirdPartyJobDetails", format_input(input))
  end

  @doc """
  Same as `get_third_party_job_details/2` but raise on error.
  """
  @spec get_third_party_job_details!(client :: ExAws.CodePipeline.t, input :: get_third_party_job_details_input) :: ExAws.Request.JSON.success_t | no_return
  def get_third_party_job_details!(client, input) do
    case get_third_party_job_details(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListActionTypes

  Gets a summary of all AWS CodePipeline action types associated with your
  account.
  """

  @spec list_action_types(client :: ExAws.CodePipeline.t, input :: list_action_types_input) :: ExAws.Request.JSON.response_t
  def list_action_types(client, input) do
    request(client, "ListActionTypes", format_input(input))
  end

  @doc """
  Same as `list_action_types/2` but raise on error.
  """
  @spec list_action_types!(client :: ExAws.CodePipeline.t, input :: list_action_types_input) :: ExAws.Request.JSON.success_t | no_return
  def list_action_types!(client, input) do
    case list_action_types(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListPipelines

  Gets a summary of all of the pipelines associated with your account.
  """

  @spec list_pipelines(client :: ExAws.CodePipeline.t, input :: list_pipelines_input) :: ExAws.Request.JSON.response_t
  def list_pipelines(client, input) do
    request(client, "ListPipelines", format_input(input))
  end

  @doc """
  Same as `list_pipelines/2` but raise on error.
  """
  @spec list_pipelines!(client :: ExAws.CodePipeline.t, input :: list_pipelines_input) :: ExAws.Request.JSON.success_t | no_return
  def list_pipelines!(client, input) do
    case list_pipelines(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  PollForJobs

  Returns information about any jobs for AWS CodePipeline to act upon.

  **When this API is called, AWS CodePipeline returns temporary credentials
  for the Amazon S3 bucket used to store artifacts for the pipeline, if the
  action requires access to that Amazon S3 bucket for input or output
  artifacts. Additionally, this API returns any secret values defined for the
  action.

  **
  """

  @spec poll_for_jobs(client :: ExAws.CodePipeline.t, input :: poll_for_jobs_input) :: ExAws.Request.JSON.response_t
  def poll_for_jobs(client, input) do
    request(client, "PollForJobs", format_input(input))
  end

  @doc """
  Same as `poll_for_jobs/2` but raise on error.
  """
  @spec poll_for_jobs!(client :: ExAws.CodePipeline.t, input :: poll_for_jobs_input) :: ExAws.Request.JSON.success_t | no_return
  def poll_for_jobs!(client, input) do
    case poll_for_jobs(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  PollForThirdPartyJobs

  Determines whether there are any third party jobs for a job worker to act
  on. Only used for partner actions.

  **When this API is called, AWS CodePipeline returns temporary credentials
  for the Amazon S3 bucket used to store artifacts for the pipeline, if the
  action requires access to that Amazon S3 bucket for input or output
  artifacts.

  **
  """

  @spec poll_for_third_party_jobs(client :: ExAws.CodePipeline.t, input :: poll_for_third_party_jobs_input) :: ExAws.Request.JSON.response_t
  def poll_for_third_party_jobs(client, input) do
    request(client, "PollForThirdPartyJobs", format_input(input))
  end

  @doc """
  Same as `poll_for_third_party_jobs/2` but raise on error.
  """
  @spec poll_for_third_party_jobs!(client :: ExAws.CodePipeline.t, input :: poll_for_third_party_jobs_input) :: ExAws.Request.JSON.success_t | no_return
  def poll_for_third_party_jobs!(client, input) do
    case poll_for_third_party_jobs(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  PutActionRevision

  Provides information to AWS CodePipeline about new revisions to a source.
  """

  @spec put_action_revision(client :: ExAws.CodePipeline.t, input :: put_action_revision_input) :: ExAws.Request.JSON.response_t
  def put_action_revision(client, input) do
    request(client, "PutActionRevision", format_input(input))
  end

  @doc """
  Same as `put_action_revision/2` but raise on error.
  """
  @spec put_action_revision!(client :: ExAws.CodePipeline.t, input :: put_action_revision_input) :: ExAws.Request.JSON.success_t | no_return
  def put_action_revision!(client, input) do
    case put_action_revision(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  PutJobFailureResult

  Represents the failure of a job as returned to the pipeline by a job
  worker. Only used for custom actions.
  """

  @spec put_job_failure_result(client :: ExAws.CodePipeline.t, input :: put_job_failure_result_input) :: ExAws.Request.JSON.response_t
  def put_job_failure_result(client, input) do
    request(client, "PutJobFailureResult", format_input(input))
  end

  @doc """
  Same as `put_job_failure_result/2` but raise on error.
  """
  @spec put_job_failure_result!(client :: ExAws.CodePipeline.t, input :: put_job_failure_result_input) :: ExAws.Request.JSON.success_t | no_return
  def put_job_failure_result!(client, input) do
    case put_job_failure_result(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  PutJobSuccessResult

  Represents the success of a job as returned to the pipeline by a job
  worker. Only used for custom actions.
  """

  @spec put_job_success_result(client :: ExAws.CodePipeline.t, input :: put_job_success_result_input) :: ExAws.Request.JSON.response_t
  def put_job_success_result(client, input) do
    request(client, "PutJobSuccessResult", format_input(input))
  end

  @doc """
  Same as `put_job_success_result/2` but raise on error.
  """
  @spec put_job_success_result!(client :: ExAws.CodePipeline.t, input :: put_job_success_result_input) :: ExAws.Request.JSON.success_t | no_return
  def put_job_success_result!(client, input) do
    case put_job_success_result(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  PutThirdPartyJobFailureResult

  Represents the failure of a third party job as returned to the pipeline by
  a job worker. Only used for partner actions.
  """

  @spec put_third_party_job_failure_result(client :: ExAws.CodePipeline.t, input :: put_third_party_job_failure_result_input) :: ExAws.Request.JSON.response_t
  def put_third_party_job_failure_result(client, input) do
    request(client, "PutThirdPartyJobFailureResult", format_input(input))
  end

  @doc """
  Same as `put_third_party_job_failure_result/2` but raise on error.
  """
  @spec put_third_party_job_failure_result!(client :: ExAws.CodePipeline.t, input :: put_third_party_job_failure_result_input) :: ExAws.Request.JSON.success_t | no_return
  def put_third_party_job_failure_result!(client, input) do
    case put_third_party_job_failure_result(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  PutThirdPartyJobSuccessResult

  Represents the success of a third party job as returned to the pipeline by
  a job worker. Only used for partner actions.
  """

  @spec put_third_party_job_success_result(client :: ExAws.CodePipeline.t, input :: put_third_party_job_success_result_input) :: ExAws.Request.JSON.response_t
  def put_third_party_job_success_result(client, input) do
    request(client, "PutThirdPartyJobSuccessResult", format_input(input))
  end

  @doc """
  Same as `put_third_party_job_success_result/2` but raise on error.
  """
  @spec put_third_party_job_success_result!(client :: ExAws.CodePipeline.t, input :: put_third_party_job_success_result_input) :: ExAws.Request.JSON.success_t | no_return
  def put_third_party_job_success_result!(client, input) do
    case put_third_party_job_success_result(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  StartPipelineExecution

  Starts the specified pipeline. Specifically, it begins processing the
  latest commit to the source location specified as part of the pipeline.
  """

  @spec start_pipeline_execution(client :: ExAws.CodePipeline.t, input :: start_pipeline_execution_input) :: ExAws.Request.JSON.response_t
  def start_pipeline_execution(client, input) do
    request(client, "StartPipelineExecution", format_input(input))
  end

  @doc """
  Same as `start_pipeline_execution/2` but raise on error.
  """
  @spec start_pipeline_execution!(client :: ExAws.CodePipeline.t, input :: start_pipeline_execution_input) :: ExAws.Request.JSON.success_t | no_return
  def start_pipeline_execution!(client, input) do
    case start_pipeline_execution(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdatePipeline

  Updates a specified pipeline with edits or changes to its structure. Use a
  JSON file with the pipeline structure in conjunction with UpdatePipeline to
  provide the full structure of the pipeline. Updating the pipeline increases
  the version number of the pipeline by 1.
  """

  @spec update_pipeline(client :: ExAws.CodePipeline.t, input :: update_pipeline_input) :: ExAws.Request.JSON.response_t
  def update_pipeline(client, input) do
    request(client, "UpdatePipeline", format_input(input))
  end

  @doc """
  Same as `update_pipeline/2` but raise on error.
  """
  @spec update_pipeline!(client :: ExAws.CodePipeline.t, input :: update_pipeline_input) :: ExAws.Request.JSON.success_t | no_return
  def update_pipeline!(client, input) do
    case update_pipeline(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  defp request(%{__struct__: client_module} = client, action, input) do
    apply(client_module, :request, [client, action, input])
  end
end
