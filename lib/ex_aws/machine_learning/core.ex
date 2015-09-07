defmodule ExAws.MachineLearning.Core do
  import ExAws.Core.JSON, only: [format_input: 1]
  @actions [
    "CreateBatchPrediction",
    "CreateDataSourceFromRDS",
    "CreateDataSourceFromRedshift",
    "CreateDataSourceFromS3",
    "CreateEvaluation",
    "CreateMLModel",
    "CreateRealtimeEndpoint",
    "DeleteBatchPrediction",
    "DeleteDataSource",
    "DeleteEvaluation",
    "DeleteMLModel",
    "DeleteRealtimeEndpoint",
    "DescribeBatchPredictions",
    "DescribeDataSources",
    "DescribeEvaluations",
    "DescribeMLModels",
    "GetBatchPrediction",
    "GetDataSource",
    "GetEvaluation",
    "GetMLModel",
    "Predict",
    "UpdateBatchPrediction",
    "UpdateDataSource",
    "UpdateEvaluation",
    "UpdateMLModel"]

  @moduledoc """
  ## Amazon Machine Learning

  Definition of the public APIs exposed by Amazon Machine Learning
  """

  @type algorithm :: binary

  @type aws_user_arn :: binary

  @type batch_prediction :: [
    batch_prediction_data_source_id: entity_id,
    batch_prediction_id: entity_id,
    created_at: epoch_time,
    created_by_iam_user: aws_user_arn,
    input_data_location_s3: s3_url,
    last_updated_at: epoch_time,
    ml_model_id: entity_id,
    message: message,
    name: entity_name,
    output_uri: s3_url,
    status: entity_status,
  ]

  @type batch_prediction_filter_variable :: binary

  @type batch_predictions :: [batch_prediction]

  @type comparator_value :: binary

  @type compute_statistics :: boolean

  @type create_batch_prediction_input :: [
    batch_prediction_data_source_id: entity_id,
    batch_prediction_id: entity_id,
    batch_prediction_name: entity_name,
    ml_model_id: entity_id,
    output_uri: s3_url,
  ]

  @type create_batch_prediction_output :: [
    batch_prediction_id: entity_id,
  ]

  @type create_data_source_from_rds_input :: [
    compute_statistics: compute_statistics,
    data_source_id: entity_id,
    data_source_name: entity_name,
    rds_data: rds_data_spec,
    role_arn: role_arn,
  ]

  @type create_data_source_from_rds_output :: [
    data_source_id: entity_id,
  ]

  @type create_data_source_from_redshift_input :: [
    compute_statistics: compute_statistics,
    data_source_id: entity_id,
    data_source_name: entity_name,
    data_spec: redshift_data_spec,
    role_arn: role_arn,
  ]

  @type create_data_source_from_redshift_output :: [
    data_source_id: entity_id,
  ]

  @type create_data_source_from_s3_input :: [
    compute_statistics: compute_statistics,
    data_source_id: entity_id,
    data_source_name: entity_name,
    data_spec: s3_data_spec,
  ]

  @type create_data_source_from_s3_output :: [
    data_source_id: entity_id,
  ]

  @type create_evaluation_input :: [
    evaluation_data_source_id: entity_id,
    evaluation_id: entity_id,
    evaluation_name: entity_name,
    ml_model_id: entity_id,
  ]

  @type create_evaluation_output :: [
    evaluation_id: entity_id,
  ]

  @type create_ml_model_input :: [
    ml_model_id: entity_id,
    ml_model_name: entity_name,
    ml_model_type: ml_model_type,
    parameters: training_parameters,
    recipe: recipe,
    recipe_uri: s3_url,
    training_data_source_id: entity_id,
  ]

  @type create_ml_model_output :: [
    ml_model_id: entity_id,
  ]

  @type create_realtime_endpoint_input :: [
    ml_model_id: entity_id,
  ]

  @type create_realtime_endpoint_output :: [
    ml_model_id: entity_id,
    realtime_endpoint_info: realtime_endpoint_info,
  ]

  @type data_rearrangement :: binary

  @type data_schema :: binary

  @type data_source :: [
    compute_statistics: compute_statistics,
    created_at: epoch_time,
    created_by_iam_user: aws_user_arn,
    data_location_s3: s3_url,
    data_rearrangement: data_rearrangement,
    data_size_in_bytes: long_type,
    data_source_id: entity_id,
    last_updated_at: epoch_time,
    message: message,
    name: entity_name,
    number_of_files: long_type,
    rds_metadata: rds_metadata,
    redshift_metadata: redshift_metadata,
    role_arn: role_arn,
    status: entity_status,
  ]

  @type data_source_filter_variable :: binary

  @type data_sources :: [data_source]

  @type delete_batch_prediction_input :: [
    batch_prediction_id: entity_id,
  ]

  @type delete_batch_prediction_output :: [
    batch_prediction_id: entity_id,
  ]

  @type delete_data_source_input :: [
    data_source_id: entity_id,
  ]

  @type delete_data_source_output :: [
    data_source_id: entity_id,
  ]

  @type delete_evaluation_input :: [
    evaluation_id: entity_id,
  ]

  @type delete_evaluation_output :: [
    evaluation_id: entity_id,
  ]

  @type delete_ml_model_input :: [
    ml_model_id: entity_id,
  ]

  @type delete_ml_model_output :: [
    ml_model_id: entity_id,
  ]

  @type delete_realtime_endpoint_input :: [
    ml_model_id: entity_id,
  ]

  @type delete_realtime_endpoint_output :: [
    ml_model_id: entity_id,
    realtime_endpoint_info: realtime_endpoint_info,
  ]

  @type describe_batch_predictions_input :: [
    eq: comparator_value,
    filter_variable: batch_prediction_filter_variable,
    ge: comparator_value,
    gt: comparator_value,
    le: comparator_value,
    lt: comparator_value,
    limit: page_limit,
    ne: comparator_value,
    next_token: string_type,
    prefix: comparator_value,
    sort_order: sort_order,
  ]

  @type describe_batch_predictions_output :: [
    next_token: string_type,
    results: batch_predictions,
  ]

  @type describe_data_sources_input :: [
    eq: comparator_value,
    filter_variable: data_source_filter_variable,
    ge: comparator_value,
    gt: comparator_value,
    le: comparator_value,
    lt: comparator_value,
    limit: page_limit,
    ne: comparator_value,
    next_token: string_type,
    prefix: comparator_value,
    sort_order: sort_order,
  ]

  @type describe_data_sources_output :: [
    next_token: string_type,
    results: data_sources,
  ]

  @type describe_evaluations_input :: [
    eq: comparator_value,
    filter_variable: evaluation_filter_variable,
    ge: comparator_value,
    gt: comparator_value,
    le: comparator_value,
    lt: comparator_value,
    limit: page_limit,
    ne: comparator_value,
    next_token: string_type,
    prefix: comparator_value,
    sort_order: sort_order,
  ]

  @type describe_evaluations_output :: [
    next_token: string_type,
    results: evaluations,
  ]

  @type describe_ml_models_input :: [
    eq: comparator_value,
    filter_variable: ml_model_filter_variable,
    ge: comparator_value,
    gt: comparator_value,
    le: comparator_value,
    lt: comparator_value,
    limit: page_limit,
    ne: comparator_value,
    next_token: string_type,
    prefix: comparator_value,
    sort_order: sort_order,
  ]

  @type describe_ml_models_output :: [
    next_token: string_type,
    results: ml_models,
  ]

  @type details_attributes :: binary

  @type details_map :: [{details_attributes, details_value}]

  @type details_value :: binary

  @type edp_pipeline_id :: binary

  @type edp_resource_role :: binary

  @type edp_security_group_id :: binary

  @type edp_security_group_ids :: [edp_security_group_id]

  @type edp_service_role :: binary

  @type edp_subnet_id :: binary

  @type entity_id :: binary

  @type entity_name :: binary

  @type entity_status :: binary

  @type epoch_time :: integer

  @type error_code :: integer

  @type error_message :: binary

  @type evaluation :: [
    created_at: epoch_time,
    created_by_iam_user: aws_user_arn,
    evaluation_data_source_id: entity_id,
    evaluation_id: entity_id,
    input_data_location_s3: s3_url,
    last_updated_at: epoch_time,
    ml_model_id: entity_id,
    message: message,
    name: entity_name,
    performance_metrics: performance_metrics,
    status: entity_status,
  ]

  @type evaluation_filter_variable :: binary

  @type evaluations :: [evaluation]

  @type get_batch_prediction_input :: [
    batch_prediction_id: entity_id,
  ]

  @type get_batch_prediction_output :: [
    batch_prediction_data_source_id: entity_id,
    batch_prediction_id: entity_id,
    created_at: epoch_time,
    created_by_iam_user: aws_user_arn,
    input_data_location_s3: s3_url,
    last_updated_at: epoch_time,
    log_uri: presigned_s3_url,
    ml_model_id: entity_id,
    message: message,
    name: entity_name,
    output_uri: s3_url,
    status: entity_status,
  ]

  @type get_data_source_input :: [
    data_source_id: entity_id,
    verbose: verbose,
  ]

  @type get_data_source_output :: [
    compute_statistics: compute_statistics,
    created_at: epoch_time,
    created_by_iam_user: aws_user_arn,
    data_location_s3: s3_url,
    data_rearrangement: data_rearrangement,
    data_size_in_bytes: long_type,
    data_source_id: entity_id,
    data_source_schema: data_schema,
    last_updated_at: epoch_time,
    log_uri: presigned_s3_url,
    message: message,
    name: entity_name,
    number_of_files: long_type,
    rds_metadata: rds_metadata,
    redshift_metadata: redshift_metadata,
    role_arn: role_arn,
    status: entity_status,
  ]

  @type get_evaluation_input :: [
    evaluation_id: entity_id,
  ]

  @type get_evaluation_output :: [
    created_at: epoch_time,
    created_by_iam_user: aws_user_arn,
    evaluation_data_source_id: entity_id,
    evaluation_id: entity_id,
    input_data_location_s3: s3_url,
    last_updated_at: epoch_time,
    log_uri: presigned_s3_url,
    ml_model_id: entity_id,
    message: message,
    name: entity_name,
    performance_metrics: performance_metrics,
    status: entity_status,
  ]

  @type get_ml_model_input :: [
    ml_model_id: entity_id,
    verbose: verbose,
  ]

  @type get_ml_model_output :: [
    created_at: epoch_time,
    created_by_iam_user: aws_user_arn,
    endpoint_info: realtime_endpoint_info,
    input_data_location_s3: s3_url,
    last_updated_at: epoch_time,
    log_uri: presigned_s3_url,
    ml_model_id: entity_id,
    ml_model_type: ml_model_type,
    message: message,
    name: ml_model_name,
    recipe: recipe,
    schema: data_schema,
    score_threshold: score_threshold,
    score_threshold_last_updated_at: epoch_time,
    size_in_bytes: long_type,
    status: entity_status,
    training_data_source_id: entity_id,
    training_parameters: training_parameters,
  ]

  @type idempotent_parameter_mismatch_exception :: [
    code: error_code,
    message: error_message,
  ]

  @type integer_type :: integer

  @type internal_server_exception :: [
    code: error_code,
    message: error_message,
  ]

  @type invalid_input_exception :: [
    code: error_code,
    message: error_message,
  ]

  @type label :: binary

  @type limit_exceeded_exception :: [
    code: error_code,
    message: error_message,
  ]

  @type long_type :: integer

  @type ml_model :: [
    algorithm: algorithm,
    created_at: epoch_time,
    created_by_iam_user: aws_user_arn,
    endpoint_info: realtime_endpoint_info,
    input_data_location_s3: s3_url,
    last_updated_at: epoch_time,
    ml_model_id: entity_id,
    ml_model_type: ml_model_type,
    message: message,
    name: ml_model_name,
    score_threshold: score_threshold,
    score_threshold_last_updated_at: epoch_time,
    size_in_bytes: long_type,
    status: entity_status,
    training_data_source_id: entity_id,
    training_parameters: training_parameters,
  ]

  @type ml_model_filter_variable :: binary

  @type ml_model_name :: binary

  @type ml_model_type :: binary

  @type ml_models :: [ml_model]

  @type message :: binary

  @type page_limit :: integer

  @type performance_metrics :: [
    properties: performance_metrics_properties,
  ]

  @type performance_metrics_properties :: [{performance_metrics_property_key, performance_metrics_property_value}]

  @type performance_metrics_property_key :: binary

  @type performance_metrics_property_value :: binary

  @type predict_input :: [
    ml_model_id: entity_id,
    predict_endpoint: vip_url,
    record: machine_learning_record,
  ]

  @type predict_output :: [
    prediction: prediction,
  ]

  @type prediction :: [
    details: details_map,
    predicted_label: label,
    predicted_scores: score_value_per_label_map,
    predicted_value: float_label,
  ]

  @type predictor_not_mounted_exception :: [
    message: error_message,
  ]

  @type presigned_s3_url :: binary

  @type rds_data_spec :: [
    data_rearrangement: data_rearrangement,
    data_schema: data_schema,
    data_schema_uri: s3_url,
    database_credentials: rds_database_credentials,
    database_information: rds_database,
    resource_role: edp_resource_role,
    s3_staging_location: s3_url,
    security_group_ids: edp_security_group_ids,
    select_sql_query: rds_select_sql_query,
    service_role: edp_service_role,
    subnet_id: edp_subnet_id,
  ]

  @type rds_database :: [
    database_name: rds_database_name,
    instance_identifier: rds_instance_identifier,
  ]

  @type rds_database_credentials :: [
    password: rds_database_password,
    username: rds_database_username,
  ]

  @type rds_database_name :: binary

  @type rds_database_password :: binary

  @type rds_database_username :: binary

  @type rds_instance_identifier :: binary

  @type rds_metadata :: [
    data_pipeline_id: edp_pipeline_id,
    database: rds_database,
    database_user_name: rds_database_username,
    resource_role: edp_resource_role,
    select_sql_query: rds_select_sql_query,
    service_role: edp_service_role,
  ]

  @type rds_select_sql_query :: binary

  @type realtime_endpoint_info :: [
    created_at: epoch_time,
    endpoint_status: realtime_endpoint_status,
    endpoint_url: vip_url,
    peak_requests_per_second: integer_type,
  ]

  @type realtime_endpoint_status :: binary

  @type recipe :: binary

  @type machine_learning_record :: [{variable_name, variable_value}]

  @type redshift_cluster_identifier :: binary

  @type redshift_data_spec :: [
    data_rearrangement: data_rearrangement,
    data_schema: data_schema,
    data_schema_uri: s3_url,
    database_credentials: redshift_database_credentials,
    database_information: redshift_database,
    s3_staging_location: s3_url,
    select_sql_query: redshift_select_sql_query,
  ]

  @type redshift_database :: [
    cluster_identifier: redshift_cluster_identifier,
    database_name: redshift_database_name,
  ]

  @type redshift_database_credentials :: [
    password: redshift_database_password,
    username: redshift_database_username,
  ]

  @type redshift_database_name :: binary

  @type redshift_database_password :: binary

  @type redshift_database_username :: binary

  @type redshift_metadata :: [
    database_user_name: redshift_database_username,
    redshift_database: redshift_database,
    select_sql_query: redshift_select_sql_query,
  ]

  @type redshift_select_sql_query :: binary

  @type resource_not_found_exception :: [
    code: error_code,
    message: error_message,
  ]

  @type role_arn :: binary

  @type s3_data_spec :: [
    data_location_s3: s3_url,
    data_rearrangement: data_rearrangement,
    data_schema: data_schema,
    data_schema_location_s3: s3_url,
  ]

  @type s3_url :: binary

  @type score_threshold :: float

  @type score_value :: float

  @type score_value_per_label_map :: [{label, score_value}]

  @type sort_order :: binary

  @type string_type :: binary

  @type training_parameters :: [{string_type, string_type}]

  @type update_batch_prediction_input :: [
    batch_prediction_id: entity_id,
    batch_prediction_name: entity_name,
  ]

  @type update_batch_prediction_output :: [
    batch_prediction_id: entity_id,
  ]

  @type update_data_source_input :: [
    data_source_id: entity_id,
    data_source_name: entity_name,
  ]

  @type update_data_source_output :: [
    data_source_id: entity_id,
  ]

  @type update_evaluation_input :: [
    evaluation_id: entity_id,
    evaluation_name: entity_name,
  ]

  @type update_evaluation_output :: [
    evaluation_id: entity_id,
  ]

  @type update_ml_model_input :: [
    ml_model_id: entity_id,
    ml_model_name: entity_name,
    score_threshold: score_threshold,
  ]

  @type update_ml_model_output :: [
    ml_model_id: entity_id,
  ]

  @type variable_name :: binary

  @type variable_value :: binary

  @type verbose :: boolean

  @type vip_url :: binary

  @type float_label :: float





  @doc """
  CreateBatchPrediction

  Generates predictions for a group of observations. The observations to
  process exist in one or more data files referenced by a `DataSource`. This
  operation creates a new `BatchPrediction`, and uses an `MLModel` and the
  data files referenced by the `DataSource` as information sources.

  `CreateBatchPrediction` is an asynchronous operation. In response to
  `CreateBatchPrediction`, Amazon Machine Learning (Amazon ML) immediately
  returns and sets the `BatchPrediction` status to `PENDING`. After the
  `BatchPrediction` completes, Amazon ML sets the status to `COMPLETED`.

  You can poll for status updates by using the `GetBatchPrediction` operation
  and checking the `Status` parameter of the result. After the `COMPLETED`
  status appears, the results are available in the location specified by the
  `OutputUri` parameter.
  """

  @spec create_batch_prediction(client :: ExAws.MachineLearning.t, input :: create_batch_prediction_input) :: ExAws.Request.JSON.response_t
  def create_batch_prediction(client, input) do
    request(client, "CreateBatchPrediction", format_input(input))
  end

  @doc """
  Same as `create_batch_prediction/2` but raise on error.
  """
  @spec create_batch_prediction!(client :: ExAws.MachineLearning.t, input :: create_batch_prediction_input) :: ExAws.Request.JSON.success_t | no_return
  def create_batch_prediction!(client, input) do
    case create_batch_prediction(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateDataSourceFromRDS

  Creates a `DataSource` object from an [ Amazon Relational Database
  Service](http://aws.amazon.com/rds/) (Amazon RDS). A `DataSource`
  references data that can be used to perform `CreateMLModel`,
  `CreateEvaluation`, or `CreateBatchPrediction` operations.

  `CreateDataSourceFromRDS` is an asynchronous operation. In response to
  `CreateDataSourceFromRDS`, Amazon Machine Learning (Amazon ML) immediately
  returns and sets the `DataSource` status to `PENDING`. After the
  `DataSource` is created and ready for use, Amazon ML sets the `Status`
  parameter to `COMPLETED`. `DataSource` in `COMPLETED` or `PENDING` status
  can only be used to perform `CreateMLModel`, `CreateEvaluation`, or
  `CreateBatchPrediction` operations.

  If Amazon ML cannot accept the input source, it sets the `Status` parameter
  to `FAILED` and includes an error message in the `Message` attribute of the
  `GetDataSource` operation response.
  """

  @spec create_data_source_from_rds(client :: ExAws.MachineLearning.t, input :: create_data_source_from_rds_input) :: ExAws.Request.JSON.response_t
  def create_data_source_from_rds(client, input) do
    request(client, "CreateDataSourceFromRDS", format_input(input))
  end

  @doc """
  Same as `create_data_source_from_rds/2` but raise on error.
  """
  @spec create_data_source_from_rds!(client :: ExAws.MachineLearning.t, input :: create_data_source_from_rds_input) :: ExAws.Request.JSON.success_t | no_return
  def create_data_source_from_rds!(client, input) do
    case create_data_source_from_rds(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateDataSourceFromRedshift

  Creates a `DataSource` from [Amazon
  Redshift](http://aws.amazon.com/redshift/). A `DataSource` references data
  that can be used to perform either `CreateMLModel`, `CreateEvaluation` or
  `CreateBatchPrediction` operations.

  `CreateDataSourceFromRedshift` is an asynchronous operation. In response to
  `CreateDataSourceFromRedshift`, Amazon Machine Learning (Amazon ML)
  immediately returns and sets the `DataSource` status to `PENDING`. After
  the `DataSource` is created and ready for use, Amazon ML sets the `Status`
  parameter to `COMPLETED`. `DataSource` in `COMPLETED` or `PENDING` status
  can only be used to perform `CreateMLModel`, `CreateEvaluation`, or
  `CreateBatchPrediction` operations.

  If Amazon ML cannot accept the input source, it sets the `Status` parameter
  to `FAILED` and includes an error message in the `Message` attribute of the
  `GetDataSource` operation response.

  The observations should exist in the database hosted on an Amazon Redshift
  cluster and should be specified by a `SelectSqlQuery`. Amazon ML executes [
  Unload](http://docs.aws.amazon.com/redshift/latest/dg/t_Unloading_tables.html)
  command in Amazon Redshift to transfer the result set of `SelectSqlQuery`
  to `S3StagingLocation.`

  After the `DataSource` is created, it's ready for use in evaluations and
  batch predictions. If you plan to use the `DataSource` to train an
  `MLModel`, the `DataSource` requires another item -- a recipe. A recipe
  describes the observation variables that participate in training an
  `MLModel`. A recipe describes how each input variable will be used in
  training. Will the variable be included or excluded from training? Will the
  variable be manipulated, for example, combined with another variable or
  split apart into word combinations? The recipe provides answers to these
  questions. For more information, see the Amazon Machine Learning Developer
  Guide.
  """

  @spec create_data_source_from_redshift(client :: ExAws.MachineLearning.t, input :: create_data_source_from_redshift_input) :: ExAws.Request.JSON.response_t
  def create_data_source_from_redshift(client, input) do
    request(client, "CreateDataSourceFromRedshift", format_input(input))
  end

  @doc """
  Same as `create_data_source_from_redshift/2` but raise on error.
  """
  @spec create_data_source_from_redshift!(client :: ExAws.MachineLearning.t, input :: create_data_source_from_redshift_input) :: ExAws.Request.JSON.success_t | no_return
  def create_data_source_from_redshift!(client, input) do
    case create_data_source_from_redshift(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateDataSourceFromS3

  Creates a `DataSource` object. A `DataSource` references data that can be
  used to perform `CreateMLModel`, `CreateEvaluation`, or
  `CreateBatchPrediction` operations.

  `CreateDataSourceFromS3` is an asynchronous operation. In response to
  `CreateDataSourceFromS3`, Amazon Machine Learning (Amazon ML) immediately
  returns and sets the `DataSource` status to `PENDING`. After the
  `DataSource` is created and ready for use, Amazon ML sets the `Status`
  parameter to `COMPLETED`. `DataSource` in `COMPLETED` or `PENDING` status
  can only be used to perform `CreateMLModel`, `CreateEvaluation` or
  `CreateBatchPrediction` operations.

  If Amazon ML cannot accept the input source, it sets the `Status` parameter
  to `FAILED` and includes an error message in the `Message` attribute of the
  `GetDataSource` operation response.

  The observation data used in a `DataSource` should be ready to use; that
  is, it should have a consistent structure, and missing data values should
  be kept to a minimum. The observation data must reside in one or more CSV
  files in an Amazon Simple Storage Service (Amazon S3) bucket, along with a
  schema that describes the data items by name and type. The same schema must
  be used for all of the data files referenced by the `DataSource`.

  After the `DataSource` has been created, it's ready to use in evaluations
  and batch predictions. If you plan to use the `DataSource` to train an
  `MLModel`, the `DataSource` requires another item: a recipe. A recipe
  describes the observation variables that participate in training an
  `MLModel`. A recipe describes how each input variable will be used in
  training. Will the variable be included or excluded from training? Will the
  variable be manipulated, for example, combined with another variable, or
  split apart into word combinations? The recipe provides answers to these
  questions. For more information, see the [Amazon Machine Learning Developer
  Guide](http://docs.aws.amazon.com/machine-learning/latest/dg).
  """

  @spec create_data_source_from_s3(client :: ExAws.MachineLearning.t, input :: create_data_source_from_s3_input) :: ExAws.Request.JSON.response_t
  def create_data_source_from_s3(client, input) do
    request(client, "CreateDataSourceFromS3", format_input(input))
  end

  @doc """
  Same as `create_data_source_from_s3/2` but raise on error.
  """
  @spec create_data_source_from_s3!(client :: ExAws.MachineLearning.t, input :: create_data_source_from_s3_input) :: ExAws.Request.JSON.success_t | no_return
  def create_data_source_from_s3!(client, input) do
    case create_data_source_from_s3(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateEvaluation

  Creates a new `Evaluation` of an `MLModel`. An `MLModel` is evaluated on a
  set of observations associated to a `DataSource`. Like a `DataSource` for
  an `MLModel`, the `DataSource` for an `Evaluation` contains values for the
  Target Variable. The `Evaluation` compares the predicted result for each
  observation to the actual outcome and provides a summary so that you know
  how effective the `MLModel` functions on the test data. Evaluation
  generates a relevant performance metric such as BinaryAUC, RegressionRMSE
  or MulticlassAvgFScore based on the corresponding `MLModelType`: `BINARY`,
  `REGRESSION` or `MULTICLASS`.

  `CreateEvaluation` is an asynchronous operation. In response to
  `CreateEvaluation`, Amazon Machine Learning (Amazon ML) immediately returns
  and sets the evaluation status to `PENDING`. After the `Evaluation` is
  created and ready for use, Amazon ML sets the status to `COMPLETED`.

  You can use the `GetEvaluation` operation to check progress of the
  evaluation during the creation operation.
  """

  @spec create_evaluation(client :: ExAws.MachineLearning.t, input :: create_evaluation_input) :: ExAws.Request.JSON.response_t
  def create_evaluation(client, input) do
    request(client, "CreateEvaluation", format_input(input))
  end

  @doc """
  Same as `create_evaluation/2` but raise on error.
  """
  @spec create_evaluation!(client :: ExAws.MachineLearning.t, input :: create_evaluation_input) :: ExAws.Request.JSON.success_t | no_return
  def create_evaluation!(client, input) do
    case create_evaluation(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateMLModel

  Creates a new `MLModel` using the data files and the recipe as information
  sources.

  An `MLModel` is nearly immutable. Users can only update the `MLModelName`
  and the `ScoreThreshold` in an `MLModel` without creating a new `MLModel`.

  `CreateMLModel` is an asynchronous operation. In response to
  `CreateMLModel`, Amazon Machine Learning (Amazon ML) immediately returns
  and sets the `MLModel` status to `PENDING`. After the `MLModel` is created
  and ready for use, Amazon ML sets the status to `COMPLETED`.

  You can use the `GetMLModel` operation to check progress of the `MLModel`
  during the creation operation.

  `CreateMLModel` requires a `DataSource` with computed statistics, which can
  be created by setting `ComputeStatistics` to `true` in
  `CreateDataSourceFromRDS`, `CreateDataSourceFromS3`, or
  `CreateDataSourceFromRedshift` operations.
  """

  @spec create_ml_model(client :: ExAws.MachineLearning.t, input :: create_ml_model_input) :: ExAws.Request.JSON.response_t
  def create_ml_model(client, input) do
    request(client, "CreateMLModel", format_input(input))
  end

  @doc """
  Same as `create_ml_model/2` but raise on error.
  """
  @spec create_ml_model!(client :: ExAws.MachineLearning.t, input :: create_ml_model_input) :: ExAws.Request.JSON.success_t | no_return
  def create_ml_model!(client, input) do
    case create_ml_model(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateRealtimeEndpoint

  Creates a real-time endpoint for the `MLModel`. The endpoint contains the
  URI of the `MLModel`; that is, the location to send real-time prediction
  requests for the specified `MLModel`.
  """

  @spec create_realtime_endpoint(client :: ExAws.MachineLearning.t, input :: create_realtime_endpoint_input) :: ExAws.Request.JSON.response_t
  def create_realtime_endpoint(client, input) do
    request(client, "CreateRealtimeEndpoint", format_input(input))
  end

  @doc """
  Same as `create_realtime_endpoint/2` but raise on error.
  """
  @spec create_realtime_endpoint!(client :: ExAws.MachineLearning.t, input :: create_realtime_endpoint_input) :: ExAws.Request.JSON.success_t | no_return
  def create_realtime_endpoint!(client, input) do
    case create_realtime_endpoint(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteBatchPrediction

  Assigns the DELETED status to a `BatchPrediction`, rendering it unusable.

  After using the `DeleteBatchPrediction` operation, you can use the
  `GetBatchPrediction` operation to verify that the status of the
  `BatchPrediction` changed to DELETED.

  <caution><title>Caution</title> The result of the `DeleteBatchPrediction`
  operation is irreversible.

  </caution>
  """

  @spec delete_batch_prediction(client :: ExAws.MachineLearning.t, input :: delete_batch_prediction_input) :: ExAws.Request.JSON.response_t
  def delete_batch_prediction(client, input) do
    request(client, "DeleteBatchPrediction", format_input(input))
  end

  @doc """
  Same as `delete_batch_prediction/2` but raise on error.
  """
  @spec delete_batch_prediction!(client :: ExAws.MachineLearning.t, input :: delete_batch_prediction_input) :: ExAws.Request.JSON.success_t | no_return
  def delete_batch_prediction!(client, input) do
    case delete_batch_prediction(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteDataSource

  Assigns the DELETED status to a `DataSource`, rendering it unusable.

  After using the `DeleteDataSource` operation, you can use the
  `GetDataSource` operation to verify that the status of the `DataSource`
  changed to DELETED.

  <caution><title>Caution</title> The results of the `DeleteDataSource`
  operation are irreversible.

  </caution>
  """

  @spec delete_data_source(client :: ExAws.MachineLearning.t, input :: delete_data_source_input) :: ExAws.Request.JSON.response_t
  def delete_data_source(client, input) do
    request(client, "DeleteDataSource", format_input(input))
  end

  @doc """
  Same as `delete_data_source/2` but raise on error.
  """
  @spec delete_data_source!(client :: ExAws.MachineLearning.t, input :: delete_data_source_input) :: ExAws.Request.JSON.success_t | no_return
  def delete_data_source!(client, input) do
    case delete_data_source(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteEvaluation

  Assigns the `DELETED` status to an `Evaluation`, rendering it unusable.

  After invoking the `DeleteEvaluation` operation, you can use the
  `GetEvaluation` operation to verify that the status of the `Evaluation`
  changed to `DELETED`.

  <caution><title>Caution</title> The results of the `DeleteEvaluation`
  operation are irreversible.

  </caution>
  """

  @spec delete_evaluation(client :: ExAws.MachineLearning.t, input :: delete_evaluation_input) :: ExAws.Request.JSON.response_t
  def delete_evaluation(client, input) do
    request(client, "DeleteEvaluation", format_input(input))
  end

  @doc """
  Same as `delete_evaluation/2` but raise on error.
  """
  @spec delete_evaluation!(client :: ExAws.MachineLearning.t, input :: delete_evaluation_input) :: ExAws.Request.JSON.success_t | no_return
  def delete_evaluation!(client, input) do
    case delete_evaluation(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteMLModel

  Assigns the DELETED status to an `MLModel`, rendering it unusable.

  After using the `DeleteMLModel` operation, you can use the `GetMLModel`
  operation to verify that the status of the `MLModel` changed to DELETED.

  <caution><title>Caution</title> The result of the `DeleteMLModel` operation
  is irreversible.

  </caution>
  """

  @spec delete_ml_model(client :: ExAws.MachineLearning.t, input :: delete_ml_model_input) :: ExAws.Request.JSON.response_t
  def delete_ml_model(client, input) do
    request(client, "DeleteMLModel", format_input(input))
  end

  @doc """
  Same as `delete_ml_model/2` but raise on error.
  """
  @spec delete_ml_model!(client :: ExAws.MachineLearning.t, input :: delete_ml_model_input) :: ExAws.Request.JSON.success_t | no_return
  def delete_ml_model!(client, input) do
    case delete_ml_model(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteRealtimeEndpoint

  Deletes a real time endpoint of an `MLModel`.
  """

  @spec delete_realtime_endpoint(client :: ExAws.MachineLearning.t, input :: delete_realtime_endpoint_input) :: ExAws.Request.JSON.response_t
  def delete_realtime_endpoint(client, input) do
    request(client, "DeleteRealtimeEndpoint", format_input(input))
  end

  @doc """
  Same as `delete_realtime_endpoint/2` but raise on error.
  """
  @spec delete_realtime_endpoint!(client :: ExAws.MachineLearning.t, input :: delete_realtime_endpoint_input) :: ExAws.Request.JSON.success_t | no_return
  def delete_realtime_endpoint!(client, input) do
    case delete_realtime_endpoint(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeBatchPredictions

  Returns a list of `BatchPrediction` operations that match the search
  criteria in the request.
  """

  @spec describe_batch_predictions(client :: ExAws.MachineLearning.t, input :: describe_batch_predictions_input) :: ExAws.Request.JSON.response_t
  def describe_batch_predictions(client, input) do
    request(client, "DescribeBatchPredictions", format_input(input))
  end

  @doc """
  Same as `describe_batch_predictions/2` but raise on error.
  """
  @spec describe_batch_predictions!(client :: ExAws.MachineLearning.t, input :: describe_batch_predictions_input) :: ExAws.Request.JSON.success_t | no_return
  def describe_batch_predictions!(client, input) do
    case describe_batch_predictions(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeDataSources

  Returns a list of `DataSource` that match the search criteria in the
  request.
  """

  @spec describe_data_sources(client :: ExAws.MachineLearning.t, input :: describe_data_sources_input) :: ExAws.Request.JSON.response_t
  def describe_data_sources(client, input) do
    request(client, "DescribeDataSources", format_input(input))
  end

  @doc """
  Same as `describe_data_sources/2` but raise on error.
  """
  @spec describe_data_sources!(client :: ExAws.MachineLearning.t, input :: describe_data_sources_input) :: ExAws.Request.JSON.success_t | no_return
  def describe_data_sources!(client, input) do
    case describe_data_sources(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeEvaluations

  Returns a list of `DescribeEvaluations` that match the search criteria in
  the request.
  """

  @spec describe_evaluations(client :: ExAws.MachineLearning.t, input :: describe_evaluations_input) :: ExAws.Request.JSON.response_t
  def describe_evaluations(client, input) do
    request(client, "DescribeEvaluations", format_input(input))
  end

  @doc """
  Same as `describe_evaluations/2` but raise on error.
  """
  @spec describe_evaluations!(client :: ExAws.MachineLearning.t, input :: describe_evaluations_input) :: ExAws.Request.JSON.success_t | no_return
  def describe_evaluations!(client, input) do
    case describe_evaluations(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeMLModels

  Returns a list of `MLModel` that match the search criteria in the request.
  """

  @spec describe_ml_models(client :: ExAws.MachineLearning.t, input :: describe_ml_models_input) :: ExAws.Request.JSON.response_t
  def describe_ml_models(client, input) do
    request(client, "DescribeMLModels", format_input(input))
  end

  @doc """
  Same as `describe_ml_models/2` but raise on error.
  """
  @spec describe_ml_models!(client :: ExAws.MachineLearning.t, input :: describe_ml_models_input) :: ExAws.Request.JSON.success_t | no_return
  def describe_ml_models!(client, input) do
    case describe_ml_models(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetBatchPrediction

  Returns a `BatchPrediction` that includes detailed metadata, status, and
  data file information for a `Batch Prediction` request.
  """

  @spec get_batch_prediction(client :: ExAws.MachineLearning.t, input :: get_batch_prediction_input) :: ExAws.Request.JSON.response_t
  def get_batch_prediction(client, input) do
    request(client, "GetBatchPrediction", format_input(input))
  end

  @doc """
  Same as `get_batch_prediction/2` but raise on error.
  """
  @spec get_batch_prediction!(client :: ExAws.MachineLearning.t, input :: get_batch_prediction_input) :: ExAws.Request.JSON.success_t | no_return
  def get_batch_prediction!(client, input) do
    case get_batch_prediction(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetDataSource

  Returns a `DataSource` that includes metadata and data file information, as
  well as the current status of the `DataSource`.

  `GetDataSource` provides results in normal or verbose format. The verbose
  format adds the schema description and the list of files pointed to by the
  DataSource to the normal format.
  """

  @spec get_data_source(client :: ExAws.MachineLearning.t, input :: get_data_source_input) :: ExAws.Request.JSON.response_t
  def get_data_source(client, input) do
    request(client, "GetDataSource", format_input(input))
  end

  @doc """
  Same as `get_data_source/2` but raise on error.
  """
  @spec get_data_source!(client :: ExAws.MachineLearning.t, input :: get_data_source_input) :: ExAws.Request.JSON.success_t | no_return
  def get_data_source!(client, input) do
    case get_data_source(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetEvaluation

  Returns an `Evaluation` that includes metadata as well as the current
  status of the `Evaluation`.
  """

  @spec get_evaluation(client :: ExAws.MachineLearning.t, input :: get_evaluation_input) :: ExAws.Request.JSON.response_t
  def get_evaluation(client, input) do
    request(client, "GetEvaluation", format_input(input))
  end

  @doc """
  Same as `get_evaluation/2` but raise on error.
  """
  @spec get_evaluation!(client :: ExAws.MachineLearning.t, input :: get_evaluation_input) :: ExAws.Request.JSON.success_t | no_return
  def get_evaluation!(client, input) do
    case get_evaluation(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetMLModel

  Returns an `MLModel` that includes detailed metadata, and data source
  information as well as the current status of the `MLModel`.

  `GetMLModel` provides results in normal or verbose format.
  """

  @spec get_ml_model(client :: ExAws.MachineLearning.t, input :: get_ml_model_input) :: ExAws.Request.JSON.response_t
  def get_ml_model(client, input) do
    request(client, "GetMLModel", format_input(input))
  end

  @doc """
  Same as `get_ml_model/2` but raise on error.
  """
  @spec get_ml_model!(client :: ExAws.MachineLearning.t, input :: get_ml_model_input) :: ExAws.Request.JSON.success_t | no_return
  def get_ml_model!(client, input) do
    case get_ml_model(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  Predict

  Generates a prediction for the observation using the specified `MLModel`.

  Note:<title>Note</title> Not all response parameters will be populated
  because this is dependent on the type of requested model.
  """

  @spec predict(client :: ExAws.MachineLearning.t, input :: predict_input) :: ExAws.Request.JSON.response_t
  def predict(client, input) do
    request(client, "Predict", format_input(input))
  end

  @doc """
  Same as `predict/2` but raise on error.
  """
  @spec predict!(client :: ExAws.MachineLearning.t, input :: predict_input) :: ExAws.Request.JSON.success_t | no_return
  def predict!(client, input) do
    case predict(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateBatchPrediction

  Updates the `BatchPredictionName` of a `BatchPrediction`.

  You can use the `GetBatchPrediction` operation to view the contents of the
  updated data element.
  """

  @spec update_batch_prediction(client :: ExAws.MachineLearning.t, input :: update_batch_prediction_input) :: ExAws.Request.JSON.response_t
  def update_batch_prediction(client, input) do
    request(client, "UpdateBatchPrediction", format_input(input))
  end

  @doc """
  Same as `update_batch_prediction/2` but raise on error.
  """
  @spec update_batch_prediction!(client :: ExAws.MachineLearning.t, input :: update_batch_prediction_input) :: ExAws.Request.JSON.success_t | no_return
  def update_batch_prediction!(client, input) do
    case update_batch_prediction(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateDataSource

  Updates the `DataSourceName` of a `DataSource`.

  You can use the `GetDataSource` operation to view the contents of the
  updated data element.
  """

  @spec update_data_source(client :: ExAws.MachineLearning.t, input :: update_data_source_input) :: ExAws.Request.JSON.response_t
  def update_data_source(client, input) do
    request(client, "UpdateDataSource", format_input(input))
  end

  @doc """
  Same as `update_data_source/2` but raise on error.
  """
  @spec update_data_source!(client :: ExAws.MachineLearning.t, input :: update_data_source_input) :: ExAws.Request.JSON.success_t | no_return
  def update_data_source!(client, input) do
    case update_data_source(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateEvaluation

  Updates the `EvaluationName` of an `Evaluation`.

  You can use the `GetEvaluation` operation to view the contents of the
  updated data element.
  """

  @spec update_evaluation(client :: ExAws.MachineLearning.t, input :: update_evaluation_input) :: ExAws.Request.JSON.response_t
  def update_evaluation(client, input) do
    request(client, "UpdateEvaluation", format_input(input))
  end

  @doc """
  Same as `update_evaluation/2` but raise on error.
  """
  @spec update_evaluation!(client :: ExAws.MachineLearning.t, input :: update_evaluation_input) :: ExAws.Request.JSON.success_t | no_return
  def update_evaluation!(client, input) do
    case update_evaluation(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateMLModel

  Updates the `MLModelName` and the `ScoreThreshold` of an `MLModel`.

  You can use the `GetMLModel` operation to view the contents of the updated
  data element.
  """

  @spec update_ml_model(client :: ExAws.MachineLearning.t, input :: update_ml_model_input) :: ExAws.Request.JSON.response_t
  def update_ml_model(client, input) do
    request(client, "UpdateMLModel", format_input(input))
  end

  @doc """
  Same as `update_ml_model/2` but raise on error.
  """
  @spec update_ml_model!(client :: ExAws.MachineLearning.t, input :: update_ml_model_input) :: ExAws.Request.JSON.success_t | no_return
  def update_ml_model!(client, input) do
    case update_ml_model(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  defp request(%{__struct__: client_module} = client, action, input) do
    apply(client_module, :request, [client, action, input])
  end
end
