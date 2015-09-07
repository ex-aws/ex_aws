defmodule ExAws.DataPipeline.Core do
  import ExAws.Core.JSON, only: [format_input: 1]
  @actions [
    "ActivatePipeline",
    "AddTags",
    "CreatePipeline",
    "DeactivatePipeline",
    "DeletePipeline",
    "DescribeObjects",
    "DescribePipelines",
    "EvaluateExpression",
    "GetPipelineDefinition",
    "ListPipelines",
    "PollForTask",
    "PutPipelineDefinition",
    "QueryObjects",
    "RemoveTags",
    "ReportTaskProgress",
    "ReportTaskRunnerHeartbeat",
    "SetStatus",
    "SetTaskStatus",
    "ValidatePipelineDefinition"]

  @moduledoc """
  ## AWS Data Pipeline

  AWS Data Pipeline configures and manages a data-driven workflow called a
  pipeline. AWS Data Pipeline handles the details of scheduling and ensuring
  that data dependencies are met so that your application can focus on
  processing the data.

  AWS Data Pipeline provides a JAR implementation of a task runner called AWS
  Data Pipeline Task Runner. AWS Data Pipeline Task Runner provides logic for
  common data management scenarios, such as performing database queries and
  running data analysis using Amazon Elastic MapReduce (Amazon EMR). You can
  use AWS Data Pipeline Task Runner as your task runner, or you can write
  your own task runner to provide custom data management.

  AWS Data Pipeline implements two main sets of functionality. Use the first
  set to create a pipeline and define data sources, schedules, dependencies,
  and the transforms to be performed on the data. Use the second set in your
  task runner application to receive the next task ready for processing. The
  logic for performing the task, such as querying the data, running data
  analysis, or converting the data from one format to another, is contained
  within the task runner. The task runner performs the task assigned to it by
  the web service, reporting progress to the web service as it does so. When
  the task is done, the task runner reports the final success or failure of
  the task to the web service.
  """

  @type activate_pipeline_input :: [
    parameter_values: parameter_value_list,
    pipeline_id: id,
    start_timestamp: timestamp,
  ]

  @type activate_pipeline_output :: [
  ]

  @type add_tags_input :: [
    pipeline_id: id,
    tags: tag_list,
  ]

  @type add_tags_output :: [
  ]

  @type create_pipeline_input :: [
    description: binary,
    name: id,
    tags: tag_list,
    unique_id: id,
  ]

  @type create_pipeline_output :: [
    pipeline_id: id,
  ]

  @type deactivate_pipeline_input :: [
    cancel_active: cancel_active,
    pipeline_id: id,
  ]

  @type deactivate_pipeline_output :: [
  ]

  @type delete_pipeline_input :: [
    pipeline_id: id,
  ]

  @type describe_objects_input :: [
    evaluate_expressions: boolean,
    marker: binary,
    object_ids: id_list,
    pipeline_id: id,
  ]

  @type describe_objects_output :: [
    has_more_results: boolean,
    marker: binary,
    pipeline_objects: pipeline_object_list,
  ]

  @type describe_pipelines_input :: [
    pipeline_ids: id_list,
  ]

  @type describe_pipelines_output :: [
    pipeline_description_list: pipeline_description_list,
  ]

  @type evaluate_expression_input :: [
    expression: long_string,
    object_id: id,
    pipeline_id: id,
  ]

  @type evaluate_expression_output :: [
    evaluated_expression: long_string,
  ]

  @type field :: [
    key: field_name_string,
    ref_value: field_name_string,
    string_value: field_string_value,
  ]

  @type get_pipeline_definition_input :: [
    pipeline_id: id,
    version: binary,
  ]

  @type get_pipeline_definition_output :: [
    parameter_objects: parameter_object_list,
    parameter_values: parameter_value_list,
    pipeline_objects: pipeline_object_list,
  ]

  @type instance_identity :: [
    document: binary,
    signature: binary,
  ]

  @type internal_service_error :: [
    message: error_message,
  ]

  @type invalid_request_exception :: [
    message: error_message,
  ]

  @type list_pipelines_input :: [
    marker: binary,
  ]

  @type list_pipelines_output :: [
    has_more_results: boolean,
    marker: binary,
    pipeline_id_list: pipeline_list,
  ]

  @type operator :: [
    type: operator_type,
    values: string_list,
  ]

  @type operator_type :: binary

  @type parameter_attribute :: [
    key: attribute_name_string,
    string_value: attribute_value_string,
  ]

  @type parameter_attribute_list :: [parameter_attribute]

  @type parameter_object :: [
    attributes: parameter_attribute_list,
    id: field_name_string,
  ]

  @type parameter_object_list :: [parameter_object]

  @type parameter_value :: [
    id: field_name_string,
    string_value: field_string_value,
  ]

  @type parameter_value_list :: [parameter_value]

  @type pipeline_deleted_exception :: [
    message: error_message,
  ]

  @type pipeline_description :: [
    description: binary,
    fields: field_list,
    name: id,
    pipeline_id: id,
    tags: tag_list,
  ]

  @type pipeline_description_list :: [pipeline_description]

  @type pipeline_id_name :: [
    id: id,
    name: id,
  ]

  @type pipeline_not_found_exception :: [
    message: error_message,
  ]

  @type pipeline_object :: [
    fields: field_list,
    id: id,
    name: id,
  ]

  @type pipeline_object_list :: [pipeline_object]

  @type pipeline_object_map :: [{id, pipeline_object}]

  @type poll_for_task_input :: [
    hostname: id,
    instance_identity: instance_identity,
    worker_group: binary,
  ]

  @type poll_for_task_output :: [
    task_object: task_object,
  ]

  @type put_pipeline_definition_input :: [
    parameter_objects: parameter_object_list,
    parameter_values: parameter_value_list,
    pipeline_id: id,
    pipeline_objects: pipeline_object_list,
  ]

  @type put_pipeline_definition_output :: [
    errored: boolean,
    validation_errors: validation_errors,
    validation_warnings: validation_warnings,
  ]

  @type query :: [
    selectors: selector_list,
  ]

  @type query_objects_input :: [
    limit: int,
    marker: binary,
    pipeline_id: id,
    query: query,
    sphere: binary,
  ]

  @type query_objects_output :: [
    has_more_results: boolean,
    ids: id_list,
    marker: binary,
  ]

  @type remove_tags_input :: [
    pipeline_id: id,
    tag_keys: string_list,
  ]

  @type remove_tags_output :: [
  ]

  @type report_task_progress_input :: [
    fields: field_list,
    task_id: task_id,
  ]

  @type report_task_progress_output :: [
    canceled: boolean,
  ]

  @type report_task_runner_heartbeat_input :: [
    hostname: id,
    taskrunner_id: id,
    worker_group: binary,
  ]

  @type report_task_runner_heartbeat_output :: [
    terminate: boolean,
  ]

  @type selector :: [
    field_name: binary,
    operator: operator,
  ]

  @type selector_list :: [selector]

  @type set_status_input :: [
    object_ids: id_list,
    pipeline_id: id,
    status: binary,
  ]

  @type set_task_status_input :: [
    error_id: binary,
    error_message: error_message,
    error_stack_trace: binary,
    task_id: task_id,
    task_status: task_status,
  ]

  @type set_task_status_output :: [
  ]

  @type tag :: [
    key: tag_key,
    value: tag_value,
  ]

  @type task_not_found_exception :: [
    message: error_message,
  ]

  @type task_object :: [
    attempt_id: id,
    objects: pipeline_object_map,
    pipeline_id: id,
    task_id: task_id,
  ]

  @type task_status :: binary

  @type validate_pipeline_definition_input :: [
    parameter_objects: parameter_object_list,
    parameter_values: parameter_value_list,
    pipeline_id: id,
    pipeline_objects: pipeline_object_list,
  ]

  @type validate_pipeline_definition_output :: [
    errored: boolean,
    validation_errors: validation_errors,
    validation_warnings: validation_warnings,
  ]

  @type validation_error :: [
    errors: validation_messages,
    id: id,
  ]

  @type validation_errors :: [validation_error]

  @type validation_warning :: [
    id: id,
    warnings: validation_messages,
  ]

  @type validation_warnings :: [validation_warning]

  @type attribute_name_string :: binary

  @type attribute_value_string :: binary

  @type cancel_active :: boolean

  @type error_message :: binary

  @type field_list :: [field]

  @type field_name_string :: binary

  @type field_string_value :: binary

  @type id :: binary

  @type id_list :: [id]

  @type int :: integer

  @type long_string :: binary

  @type pipeline_list :: [pipeline_id_name]

  @type string_list :: [binary]

  @type tag_key :: binary

  @type tag_list :: [tag]

  @type tag_value :: binary

  @type task_id :: binary

  @type timestamp :: integer

  @type validation_message :: binary

  @type validation_messages :: [validation_message]





  @doc """
  ActivatePipeline

  Validates the specified pipeline and starts processing pipeline tasks. If
  the pipeline does not pass validation, activation fails.

  If you need to pause the pipeline to investigate an issue with a component,
  such as a data source or script, call `DeactivatePipeline`.

  To activate a finished pipeline, modify the end date for the pipeline and
  then activate it.
  """

  @spec activate_pipeline(client :: ExAws.DataPipeline.t, input :: activate_pipeline_input) :: ExAws.Request.JSON.response_t
  def activate_pipeline(client, input) do
    request(client, "ActivatePipeline", format_input(input))
  end

  @doc """
  Same as `activate_pipeline/2` but raise on error.
  """
  @spec activate_pipeline!(client :: ExAws.DataPipeline.t, input :: activate_pipeline_input) :: ExAws.Request.JSON.success_t | no_return
  def activate_pipeline!(client, input) do
    case activate_pipeline(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  AddTags

  Adds or modifies tags for the specified pipeline.
  """

  @spec add_tags(client :: ExAws.DataPipeline.t, input :: add_tags_input) :: ExAws.Request.JSON.response_t
  def add_tags(client, input) do
    request(client, "AddTags", format_input(input))
  end

  @doc """
  Same as `add_tags/2` but raise on error.
  """
  @spec add_tags!(client :: ExAws.DataPipeline.t, input :: add_tags_input) :: ExAws.Request.JSON.success_t | no_return
  def add_tags!(client, input) do
    case add_tags(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreatePipeline

  Creates a new, empty pipeline. Use `PutPipelineDefinition` to populate the
  pipeline.
  """

  @spec create_pipeline(client :: ExAws.DataPipeline.t, input :: create_pipeline_input) :: ExAws.Request.JSON.response_t
  def create_pipeline(client, input) do
    request(client, "CreatePipeline", format_input(input))
  end

  @doc """
  Same as `create_pipeline/2` but raise on error.
  """
  @spec create_pipeline!(client :: ExAws.DataPipeline.t, input :: create_pipeline_input) :: ExAws.Request.JSON.success_t | no_return
  def create_pipeline!(client, input) do
    case create_pipeline(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeactivatePipeline

  Deactivates the specified running pipeline. The pipeline is set to the
  `DEACTIVATING` state until the deactivation process completes.

  To resume a deactivated pipeline, use `ActivatePipeline`. By default, the
  pipeline resumes from the last completed execution. Optionally, you can
  specify the date and time to resume the pipeline.
  """

  @spec deactivate_pipeline(client :: ExAws.DataPipeline.t, input :: deactivate_pipeline_input) :: ExAws.Request.JSON.response_t
  def deactivate_pipeline(client, input) do
    request(client, "DeactivatePipeline", format_input(input))
  end

  @doc """
  Same as `deactivate_pipeline/2` but raise on error.
  """
  @spec deactivate_pipeline!(client :: ExAws.DataPipeline.t, input :: deactivate_pipeline_input) :: ExAws.Request.JSON.success_t | no_return
  def deactivate_pipeline!(client, input) do
    case deactivate_pipeline(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeletePipeline

  Deletes a pipeline, its pipeline definition, and its run history. AWS Data
  Pipeline attempts to cancel instances associated with the pipeline that are
  currently being processed by task runners.

  Deleting a pipeline cannot be undone. You cannot query or restore a deleted
  pipeline. To temporarily pause a pipeline instead of deleting it, call
  `SetStatus` with the status set to `PAUSE` on individual components.
  Components that are paused by `SetStatus` can be resumed.
  """

  @spec delete_pipeline(client :: ExAws.DataPipeline.t, input :: delete_pipeline_input) :: ExAws.Request.JSON.response_t
  def delete_pipeline(client, input) do
    request(client, "DeletePipeline", format_input(input))
  end

  @doc """
  Same as `delete_pipeline/2` but raise on error.
  """
  @spec delete_pipeline!(client :: ExAws.DataPipeline.t, input :: delete_pipeline_input) :: ExAws.Request.JSON.success_t | no_return
  def delete_pipeline!(client, input) do
    case delete_pipeline(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeObjects

  Gets the object definitions for a set of objects associated with the
  pipeline. Object definitions are composed of a set of fields that define
  the properties of the object.
  """

  @spec describe_objects(client :: ExAws.DataPipeline.t, input :: describe_objects_input) :: ExAws.Request.JSON.response_t
  def describe_objects(client, input) do
    request(client, "DescribeObjects", format_input(input))
  end

  @doc """
  Same as `describe_objects/2` but raise on error.
  """
  @spec describe_objects!(client :: ExAws.DataPipeline.t, input :: describe_objects_input) :: ExAws.Request.JSON.success_t | no_return
  def describe_objects!(client, input) do
    case describe_objects(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribePipelines

  Retrieves metadata about one or more pipelines. The information retrieved
  includes the name of the pipeline, the pipeline identifier, its current
  state, and the user account that owns the pipeline. Using account
  credentials, you can retrieve metadata about pipelines that you or your IAM
  users have created. If you are using an IAM user account, you can retrieve
  metadata about only those pipelines for which you have read permissions.

  To retrieve the full pipeline definition instead of metadata about the
  pipeline, call `GetPipelineDefinition`.
  """

  @spec describe_pipelines(client :: ExAws.DataPipeline.t, input :: describe_pipelines_input) :: ExAws.Request.JSON.response_t
  def describe_pipelines(client, input) do
    request(client, "DescribePipelines", format_input(input))
  end

  @doc """
  Same as `describe_pipelines/2` but raise on error.
  """
  @spec describe_pipelines!(client :: ExAws.DataPipeline.t, input :: describe_pipelines_input) :: ExAws.Request.JSON.success_t | no_return
  def describe_pipelines!(client, input) do
    case describe_pipelines(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  EvaluateExpression

  Task runners call `EvaluateExpression` to evaluate a string in the context
  of the specified object. For example, a task runner can evaluate SQL
  queries stored in Amazon S3.
  """

  @spec evaluate_expression(client :: ExAws.DataPipeline.t, input :: evaluate_expression_input) :: ExAws.Request.JSON.response_t
  def evaluate_expression(client, input) do
    request(client, "EvaluateExpression", format_input(input))
  end

  @doc """
  Same as `evaluate_expression/2` but raise on error.
  """
  @spec evaluate_expression!(client :: ExAws.DataPipeline.t, input :: evaluate_expression_input) :: ExAws.Request.JSON.success_t | no_return
  def evaluate_expression!(client, input) do
    case evaluate_expression(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetPipelineDefinition

  Gets the definition of the specified pipeline. You can call
  `GetPipelineDefinition` to retrieve the pipeline definition that you
  provided using `PutPipelineDefinition`.
  """

  @spec get_pipeline_definition(client :: ExAws.DataPipeline.t, input :: get_pipeline_definition_input) :: ExAws.Request.JSON.response_t
  def get_pipeline_definition(client, input) do
    request(client, "GetPipelineDefinition", format_input(input))
  end

  @doc """
  Same as `get_pipeline_definition/2` but raise on error.
  """
  @spec get_pipeline_definition!(client :: ExAws.DataPipeline.t, input :: get_pipeline_definition_input) :: ExAws.Request.JSON.success_t | no_return
  def get_pipeline_definition!(client, input) do
    case get_pipeline_definition(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListPipelines

  Lists the pipeline identifiers for all active pipelines that you have
  permission to access.
  """

  @spec list_pipelines(client :: ExAws.DataPipeline.t, input :: list_pipelines_input) :: ExAws.Request.JSON.response_t
  def list_pipelines(client, input) do
    request(client, "ListPipelines", format_input(input))
  end

  @doc """
  Same as `list_pipelines/2` but raise on error.
  """
  @spec list_pipelines!(client :: ExAws.DataPipeline.t, input :: list_pipelines_input) :: ExAws.Request.JSON.success_t | no_return
  def list_pipelines!(client, input) do
    case list_pipelines(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  PollForTask

  Task runners call `PollForTask` to receive a task to perform from AWS Data
  Pipeline. The task runner specifies which tasks it can perform by setting a
  value for the `workerGroup` parameter. The task returned can come from any
  of the pipelines that match the `workerGroup` value passed in by the task
  runner and that was launched using the IAM user credentials specified by
  the task runner.

  If tasks are ready in the work queue, `PollForTask` returns a response
  immediately. If no tasks are available in the queue, `PollForTask` uses
  long-polling and holds on to a poll connection for up to a 90 seconds,
  during which time the first newly scheduled task is handed to the task
  runner. To accomodate this, set the socket timeout in your task runner to
  90 seconds. The task runner should not call `PollForTask` again on the same
  `workerGroup` until it receives a response, and this can take up to 90
  seconds.
  """

  @spec poll_for_task(client :: ExAws.DataPipeline.t, input :: poll_for_task_input) :: ExAws.Request.JSON.response_t
  def poll_for_task(client, input) do
    request(client, "PollForTask", format_input(input))
  end

  @doc """
  Same as `poll_for_task/2` but raise on error.
  """
  @spec poll_for_task!(client :: ExAws.DataPipeline.t, input :: poll_for_task_input) :: ExAws.Request.JSON.success_t | no_return
  def poll_for_task!(client, input) do
    case poll_for_task(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  PutPipelineDefinition

  Adds tasks, schedules, and preconditions to the specified pipeline. You can
  use `PutPipelineDefinition` to populate a new pipeline.

  `PutPipelineDefinition` also validates the configuration as it adds it to
  the pipeline. Changes to the pipeline are saved unless one of the following
  three validation errors exists in the pipeline.

  - An object is missing a name or identifier field.

  - A string or reference field is empty.

  - The number of objects in the pipeline exceeds the maximum allowed
  objects.

  - The pipeline is in a FINISHED state.

  Pipeline object definitions are passed to the `PutPipelineDefinition`
  action and returned by the `GetPipelineDefinition` action.
  """

  @spec put_pipeline_definition(client :: ExAws.DataPipeline.t, input :: put_pipeline_definition_input) :: ExAws.Request.JSON.response_t
  def put_pipeline_definition(client, input) do
    request(client, "PutPipelineDefinition", format_input(input))
  end

  @doc """
  Same as `put_pipeline_definition/2` but raise on error.
  """
  @spec put_pipeline_definition!(client :: ExAws.DataPipeline.t, input :: put_pipeline_definition_input) :: ExAws.Request.JSON.success_t | no_return
  def put_pipeline_definition!(client, input) do
    case put_pipeline_definition(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  QueryObjects

  Queries the specified pipeline for the names of objects that match the
  specified set of conditions.
  """

  @spec query_objects(client :: ExAws.DataPipeline.t, input :: query_objects_input) :: ExAws.Request.JSON.response_t
  def query_objects(client, input) do
    request(client, "QueryObjects", format_input(input))
  end

  @doc """
  Same as `query_objects/2` but raise on error.
  """
  @spec query_objects!(client :: ExAws.DataPipeline.t, input :: query_objects_input) :: ExAws.Request.JSON.success_t | no_return
  def query_objects!(client, input) do
    case query_objects(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RemoveTags

  Removes existing tags from the specified pipeline.
  """

  @spec remove_tags(client :: ExAws.DataPipeline.t, input :: remove_tags_input) :: ExAws.Request.JSON.response_t
  def remove_tags(client, input) do
    request(client, "RemoveTags", format_input(input))
  end

  @doc """
  Same as `remove_tags/2` but raise on error.
  """
  @spec remove_tags!(client :: ExAws.DataPipeline.t, input :: remove_tags_input) :: ExAws.Request.JSON.success_t | no_return
  def remove_tags!(client, input) do
    case remove_tags(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ReportTaskProgress

  Task runners call `ReportTaskProgress` when assigned a task to acknowledge
  that it has the task. If the web service does not receive this
  acknowledgement within 2 minutes, it assigns the task in a subsequent
  `PollForTask` call. After this initial acknowledgement, the task runner
  only needs to report progress every 15 minutes to maintain its ownership of
  the task. You can change this reporting time from 15 minutes by specifying
  a `reportProgressTimeout` field in your pipeline.

  If a task runner does not report its status after 5 minutes, AWS Data
  Pipeline assumes that the task runner is unable to process the task and
  reassigns the task in a subsequent response to `PollForTask`. Task runners
  should call `ReportTaskProgress` every 60 seconds.
  """

  @spec report_task_progress(client :: ExAws.DataPipeline.t, input :: report_task_progress_input) :: ExAws.Request.JSON.response_t
  def report_task_progress(client, input) do
    request(client, "ReportTaskProgress", format_input(input))
  end

  @doc """
  Same as `report_task_progress/2` but raise on error.
  """
  @spec report_task_progress!(client :: ExAws.DataPipeline.t, input :: report_task_progress_input) :: ExAws.Request.JSON.success_t | no_return
  def report_task_progress!(client, input) do
    case report_task_progress(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ReportTaskRunnerHeartbeat

  Task runners call `ReportTaskRunnerHeartbeat` every 15 minutes to indicate
  that they are operational. If the AWS Data Pipeline Task Runner is launched
  on a resource managed by AWS Data Pipeline, the web service can use this
  call to detect when the task runner application has failed and restart a
  new instance.
  """

  @spec report_task_runner_heartbeat(client :: ExAws.DataPipeline.t, input :: report_task_runner_heartbeat_input) :: ExAws.Request.JSON.response_t
  def report_task_runner_heartbeat(client, input) do
    request(client, "ReportTaskRunnerHeartbeat", format_input(input))
  end

  @doc """
  Same as `report_task_runner_heartbeat/2` but raise on error.
  """
  @spec report_task_runner_heartbeat!(client :: ExAws.DataPipeline.t, input :: report_task_runner_heartbeat_input) :: ExAws.Request.JSON.success_t | no_return
  def report_task_runner_heartbeat!(client, input) do
    case report_task_runner_heartbeat(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  SetStatus

  Requests that the status of the specified physical or logical pipeline
  objects be updated in the specified pipeline. This update might not occur
  immediately, but is eventually consistent. The status that can be set
  depends on the type of object (for example, DataNode or Activity). You
  cannot perform this operation on `FINISHED` pipelines and attempting to do
  so returns `InvalidRequestException`.
  """

  @spec set_status(client :: ExAws.DataPipeline.t, input :: set_status_input) :: ExAws.Request.JSON.response_t
  def set_status(client, input) do
    request(client, "SetStatus", format_input(input))
  end

  @doc """
  Same as `set_status/2` but raise on error.
  """
  @spec set_status!(client :: ExAws.DataPipeline.t, input :: set_status_input) :: ExAws.Request.JSON.success_t | no_return
  def set_status!(client, input) do
    case set_status(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  SetTaskStatus

  Task runners call `SetTaskStatus` to notify AWS Data Pipeline that a task
  is completed and provide information about the final status. A task runner
  makes this call regardless of whether the task was sucessful. A task runner
  does not need to call `SetTaskStatus` for tasks that are canceled by the
  web service during a call to `ReportTaskProgress`.
  """

  @spec set_task_status(client :: ExAws.DataPipeline.t, input :: set_task_status_input) :: ExAws.Request.JSON.response_t
  def set_task_status(client, input) do
    request(client, "SetTaskStatus", format_input(input))
  end

  @doc """
  Same as `set_task_status/2` but raise on error.
  """
  @spec set_task_status!(client :: ExAws.DataPipeline.t, input :: set_task_status_input) :: ExAws.Request.JSON.success_t | no_return
  def set_task_status!(client, input) do
    case set_task_status(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ValidatePipelineDefinition

  Validates the specified pipeline definition to ensure that it is well
  formed and can be run without error.
  """

  @spec validate_pipeline_definition(client :: ExAws.DataPipeline.t, input :: validate_pipeline_definition_input) :: ExAws.Request.JSON.response_t
  def validate_pipeline_definition(client, input) do
    request(client, "ValidatePipelineDefinition", format_input(input))
  end

  @doc """
  Same as `validate_pipeline_definition/2` but raise on error.
  """
  @spec validate_pipeline_definition!(client :: ExAws.DataPipeline.t, input :: validate_pipeline_definition_input) :: ExAws.Request.JSON.success_t | no_return
  def validate_pipeline_definition!(client, input) do
    case validate_pipeline_definition(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  defp request(%{__struct__: client_module} = client, action, input) do
    apply(client_module, :request, [client, action, input])
  end
end
