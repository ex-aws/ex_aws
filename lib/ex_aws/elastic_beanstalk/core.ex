defmodule ExAws.ElasticBeanstalk.Core do
  @actions [
    "AbortEnvironmentUpdate",
    "CheckDNSAvailability",
    "CreateApplication",
    "CreateApplicationVersion",
    "CreateConfigurationTemplate",
    "CreateEnvironment",
    "CreateStorageLocation",
    "DeleteApplication",
    "DeleteApplicationVersion",
    "DeleteConfigurationTemplate",
    "DeleteEnvironmentConfiguration",
    "DescribeApplicationVersions",
    "DescribeApplications",
    "DescribeConfigurationOptions",
    "DescribeConfigurationSettings",
    "DescribeEnvironmentHealth",
    "DescribeEnvironmentResources",
    "DescribeEnvironments",
    "DescribeEvents",
    "DescribeInstancesHealth",
    "ListAvailableSolutionStacks",
    "RebuildEnvironment",
    "RequestEnvironmentInfo",
    "RestartAppServer",
    "RetrieveEnvironmentInfo",
    "SwapEnvironmentCNAMEs",
    "TerminateEnvironment",
    "UpdateApplication",
    "UpdateApplicationVersion",
    "UpdateConfigurationTemplate",
    "UpdateEnvironment",
    "ValidateConfigurationSettings"]

  @moduledoc """
  ## AWS Elastic Beanstalk

  AWS Elastic Beanstalk

  This is the AWS Elastic Beanstalk API Reference. This guide provides
  detailed information about AWS Elastic Beanstalk actions, data types,
  parameters, and errors.

  AWS Elastic Beanstalk is a tool that makes it easy for you to create,
  deploy, and manage scalable, fault-tolerant applications running on Amazon
  Web Services cloud resources.

  For more information about this product, go to the [AWS Elastic
  Beanstalk](http://aws.amazon.com/elasticbeanstalk/) details page. The
  location of the latest AWS Elastic Beanstalk WSDL is
  [http://elasticbeanstalk.s3.amazonaws.com/doc/2010-12-01/AWSElasticBeanstalk.wsdl](http://elasticbeanstalk.s3.amazonaws.com/doc/2010-12-01/AWSElasticBeanstalk.wsdl).
  To install the Software Development Kits (SDKs), Integrated Development
  Environment (IDE) Toolkits, and command line tools that enable you to
  access the API, go to [Tools for Amazon Web
  Services](https://aws.amazon.com/tools/).

  **Endpoints**

  For a list of region-specific endpoints that AWS Elastic Beanstalk
  supports, go to [Regions and
  Endpoints](http://docs.aws.amazon.com/general/latest/gr/rande.html#elasticbeanstalk_region)
  in the *Amazon Web Services Glossary*.
  """

  @type abort_environment_update_message :: [
    environment_id: environment_id,
    environment_name: environment_name,
  ]

  @type abortable_operation_in_progress :: boolean

  @type application_description :: [
    application_name: application_name,
    configuration_templates: configuration_template_names_list,
    date_created: creation_date,
    date_updated: update_date,
    description: description,
    versions: version_labels_list,
  ]

  @type application_description_list :: [application_description]

  @type application_description_message :: [
    application: application_description,
  ]

  @type application_descriptions_message :: [
    applications: application_description_list,
  ]

  @type application_metrics :: [
    duration: nullable_integer,
    latency: latency,
    request_count: request_count,
    status_codes: status_codes,
  ]

  @type application_name :: binary

  @type application_names_list :: [application_name]

  @type application_version_description :: [
    application_name: application_name,
    date_created: creation_date,
    date_updated: update_date,
    description: description,
    source_bundle: s3_location,
    version_label: version_label,
  ]

  @type application_version_description_list :: [application_version_description]

  @type application_version_description_message :: [
    application_version: application_version_description,
  ]

  @type application_version_descriptions_message :: [
    application_versions: application_version_description_list,
  ]

  @type auto_create_application :: boolean

  @type auto_scaling_group :: [
    name: resource_id,
  ]

  @type auto_scaling_group_list :: [auto_scaling_group]

  @type available_solution_stack_details_list :: [solution_stack_description]

  @type available_solution_stack_names_list :: [solution_stack_name]

  @type cpu_utilization :: [
    io_wait: nullable_double,
    irq: nullable_double,
    idle: nullable_double,
    nice: nullable_double,
    soft_irq: nullable_double,
    system: nullable_double,
    user: nullable_double,
  ]

  @type cause :: binary

  @type causes :: [cause]

  @type check_dns_availability_message :: [
    cname_prefix: dns_cname_prefix,
  ]

  @type check_dns_availability_result_message :: [
    available: cname_availability,
    fully_qualified_cname: dns_cname,
  ]

  @type cname_availability :: boolean

  @type configuration_deployment_status :: binary

  @type configuration_option_default_value :: binary

  @type configuration_option_description :: [
    change_severity: configuration_option_severity,
    default_value: configuration_option_default_value,
    max_length: option_restriction_max_length,
    max_value: option_restriction_max_value,
    min_value: option_restriction_min_value,
    name: configuration_option_name,
    namespace: option_namespace,
    regex: option_restriction_regex,
    user_defined: user_defined_option,
    value_options: configuration_option_possible_values,
    value_type: configuration_option_value_type,
  ]

  @type configuration_option_descriptions_list :: [configuration_option_description]

  @type configuration_option_name :: binary

  @type configuration_option_possible_value :: binary

  @type configuration_option_possible_values :: [configuration_option_possible_value]

  @type configuration_option_setting :: [
    namespace: option_namespace,
    option_name: configuration_option_name,
    resource_name: resource_name,
    value: configuration_option_value,
  ]

  @type configuration_option_settings_list :: [configuration_option_setting]

  @type configuration_option_severity :: binary

  @type configuration_option_value :: binary

  @type configuration_option_value_type :: binary

  @type configuration_options_description :: [
    options: configuration_option_descriptions_list,
    solution_stack_name: solution_stack_name,
  ]

  @type configuration_settings_description :: [
    application_name: application_name,
    date_created: creation_date,
    date_updated: update_date,
    deployment_status: configuration_deployment_status,
    description: description,
    environment_name: environment_name,
    option_settings: configuration_option_settings_list,
    solution_stack_name: solution_stack_name,
    template_name: configuration_template_name,
  ]

  @type configuration_settings_description_list :: [configuration_settings_description]

  @type configuration_settings_descriptions :: [
    configuration_settings: configuration_settings_description_list,
  ]

  @type configuration_settings_validation_messages :: [
    messages: validation_messages_list,
  ]

  @type configuration_template_name :: binary

  @type configuration_template_names_list :: [configuration_template_name]

  @type create_application_message :: [
    application_name: application_name,
    description: description,
  ]

  @type create_application_version_message :: [
    application_name: application_name,
    auto_create_application: auto_create_application,
    description: description,
    source_bundle: s3_location,
    version_label: version_label,
  ]

  @type create_configuration_template_message :: [
    application_name: application_name,
    description: description,
    environment_id: environment_id,
    option_settings: configuration_option_settings_list,
    solution_stack_name: solution_stack_name,
    source_configuration: source_configuration,
    template_name: configuration_template_name,
  ]

  @type create_environment_message :: [
    application_name: application_name,
    cname_prefix: dns_cname_prefix,
    description: description,
    environment_name: environment_name,
    option_settings: configuration_option_settings_list,
    options_to_remove: options_specifier_list,
    solution_stack_name: solution_stack_name,
    tags: tags,
    template_name: configuration_template_name,
    tier: environment_tier,
    version_label: version_label,
  ]

  @type create_storage_location_result_message :: [
    s3_bucket: s3_bucket,
  ]

  @type creation_date :: integer

  @type dns_cname :: binary

  @type dns_cname_prefix :: binary

  @type delete_application_message :: [
    application_name: application_name,
    terminate_env_by_force: terminate_env_force,
  ]

  @type delete_application_version_message :: [
    application_name: application_name,
    delete_source_bundle: delete_source_bundle,
    version_label: version_label,
  ]

  @type delete_configuration_template_message :: [
    application_name: application_name,
    template_name: configuration_template_name,
  ]

  @type delete_environment_configuration_message :: [
    application_name: application_name,
    environment_name: environment_name,
  ]

  @type delete_source_bundle :: boolean

  @type describe_application_versions_message :: [
    application_name: application_name,
    version_labels: version_labels_list,
  ]

  @type describe_applications_message :: [
    application_names: application_names_list,
  ]

  @type describe_configuration_options_message :: [
    application_name: application_name,
    environment_name: environment_name,
    options: options_specifier_list,
    solution_stack_name: solution_stack_name,
    template_name: configuration_template_name,
  ]

  @type describe_configuration_settings_message :: [
    application_name: application_name,
    environment_name: environment_name,
    template_name: configuration_template_name,
  ]

  @type describe_environment_health_request :: [
    attribute_names: environment_health_attributes,
    environment_id: environment_id,
    environment_name: environment_name,
  ]

  @type describe_environment_health_result :: [
    application_metrics: application_metrics,
    causes: causes,
    color: binary,
    environment_name: environment_name,
    health_status: binary,
    instances_health: instance_health_summary,
    refreshed_at: refreshed_at,
    status: environment_health,
  ]

  @type describe_environment_resources_message :: [
    environment_id: environment_id,
    environment_name: environment_name,
  ]

  @type describe_environments_message :: [
    application_name: application_name,
    environment_ids: environment_id_list,
    environment_names: environment_names_list,
    include_deleted: include_deleted,
    included_deleted_back_to: include_deleted_back_to,
    version_label: version_label,
  ]

  @type describe_events_message :: [
    application_name: application_name,
    end_time: time_filter_end,
    environment_id: environment_id,
    environment_name: environment_name,
    max_records: max_records,
    next_token: token,
    request_id: request_id,
    severity: event_severity,
    start_time: time_filter_start,
    template_name: configuration_template_name,
    version_label: version_label,
  ]

  @type describe_instances_health_request :: [
    attribute_names: instances_health_attributes,
    environment_id: environment_id,
    environment_name: environment_name,
    next_token: next_token,
  ]

  @type describe_instances_health_result :: [
    instance_health_list: instance_health_list,
    next_token: next_token,
    refreshed_at: refreshed_at,
  ]

  @type description :: binary

  @type ec2_instance_id :: binary

  @type elastic_beanstalk_service_exception :: [
    message: exception_message,
  ]

  @type endpoint_url :: binary

  @type environment_description :: [
    abortable_operation_in_progress: abortable_operation_in_progress,
    application_name: application_name,
    cname: dns_cname,
    date_created: creation_date,
    date_updated: update_date,
    description: description,
    endpoint_url: endpoint_url,
    environment_id: environment_id,
    environment_name: environment_name,
    health: environment_health,
    health_status: environment_health_status,
    resources: environment_resources_description,
    solution_stack_name: solution_stack_name,
    status: environment_status,
    template_name: configuration_template_name,
    tier: environment_tier,
    version_label: version_label,
  ]

  @type environment_descriptions_list :: [environment_description]

  @type environment_descriptions_message :: [
    environments: environment_descriptions_list,
  ]

  @type environment_health :: binary

  @type environment_health_attribute :: binary

  @type environment_health_attributes :: [environment_health_attribute]

  @type environment_health_status :: binary

  @type environment_id :: binary

  @type environment_id_list :: [environment_id]

  @type environment_info_description :: [
    ec2_instance_id: ec2_instance_id,
    info_type: environment_info_type,
    message: message,
    sample_timestamp: sample_timestamp,
  ]

  @type environment_info_description_list :: [environment_info_description]

  @type environment_info_type :: binary

  @type environment_name :: binary

  @type environment_names_list :: [environment_name]

  @type environment_resource_description :: [
    auto_scaling_groups: auto_scaling_group_list,
    environment_name: environment_name,
    instances: instance_list,
    launch_configurations: launch_configuration_list,
    load_balancers: load_balancer_list,
    queues: queue_list,
    triggers: trigger_list,
  ]

  @type environment_resource_descriptions_message :: [
    environment_resources: environment_resource_description,
  ]

  @type environment_resources_description :: [
    load_balancer: load_balancer_description,
  ]

  @type environment_status :: binary

  @type environment_tier :: [
    name: binary,
    type: binary,
    version: binary,
  ]

  @type event_date :: integer

  @type event_description :: [
    application_name: application_name,
    environment_name: environment_name,
    event_date: event_date,
    message: event_message,
    request_id: request_id,
    severity: event_severity,
    template_name: configuration_template_name,
    version_label: version_label,
  ]

  @type event_description_list :: [event_description]

  @type event_descriptions_message :: [
    events: event_description_list,
    next_token: token,
  ]

  @type event_message :: binary

  @type event_severity :: binary

  @type exception_message :: binary

  @type file_type_extension :: binary

  @type include_deleted :: boolean

  @type include_deleted_back_to :: integer

  @type instance :: [
    id: resource_id,
  ]

  @type instance_health_list :: [single_instance_health]

  @type instance_health_summary :: [
    degraded: nullable_integer,
    info: nullable_integer,
    no_data: nullable_integer,
    ok: nullable_integer,
    pending: nullable_integer,
    severe: nullable_integer,
    unknown: nullable_integer,
    warning: nullable_integer,
  ]

  @type instance_id :: binary

  @type instance_list :: [instance]

  @type instances_health_attribute :: binary

  @type instances_health_attributes :: [instances_health_attribute]

  @type insufficient_privileges_exception :: [
  ]

  @type invalid_request_exception :: [
  ]

  @type latency :: [
    p10: nullable_double,
    p50: nullable_double,
    p75: nullable_double,
    p85: nullable_double,
    p90: nullable_double,
    p95: nullable_double,
    p99: nullable_double,
    p999: nullable_double,
  ]

  @type launch_configuration :: [
    name: resource_id,
  ]

  @type launch_configuration_list :: [launch_configuration]

  @type launched_at :: integer

  @type list_available_solution_stacks_result_message :: [
    solution_stack_details: available_solution_stack_details_list,
    solution_stacks: available_solution_stack_names_list,
  ]

  @type listener :: [
    port: integer,
    protocol: binary,
  ]

  @type load_average :: [load_average_value]

  @type load_average_value :: float

  @type load_balancer :: [
    name: resource_id,
  ]

  @type load_balancer_description :: [
    domain: binary,
    listeners: load_balancer_listeners_description,
    load_balancer_name: binary,
  ]

  @type load_balancer_list :: [load_balancer]

  @type load_balancer_listeners_description :: [listener]

  @type max_records :: integer

  @type message :: binary

  @type next_token :: binary

  @type nullable_double :: float

  @type nullable_integer :: integer

  @type operation_in_progress_exception :: [
  ]

  @type option_namespace :: binary

  @type option_restriction_max_length :: integer

  @type option_restriction_max_value :: integer

  @type option_restriction_min_value :: integer

  @type option_restriction_regex :: [
    label: regex_label,
    pattern: regex_pattern,
  ]

  @type option_specification :: [
    namespace: option_namespace,
    option_name: configuration_option_name,
    resource_name: resource_name,
  ]

  @type options_specifier_list :: [option_specification]

  @type queue :: [
    name: binary,
    url: binary,
  ]

  @type queue_list :: [queue]

  @type rebuild_environment_message :: [
    environment_id: environment_id,
    environment_name: environment_name,
  ]

  @type refreshed_at :: integer

  @type regex_label :: binary

  @type regex_pattern :: binary

  @type request_count :: integer

  @type request_environment_info_message :: [
    environment_id: environment_id,
    environment_name: environment_name,
    info_type: environment_info_type,
  ]

  @type request_id :: binary

  @type resource_id :: binary

  @type resource_name :: binary

  @type restart_app_server_message :: [
    environment_id: environment_id,
    environment_name: environment_name,
  ]

  @type retrieve_environment_info_message :: [
    environment_id: environment_id,
    environment_name: environment_name,
    info_type: environment_info_type,
  ]

  @type retrieve_environment_info_result_message :: [
    environment_info: environment_info_description_list,
  ]

  @type s3_bucket :: binary

  @type s3_key :: binary

  @type s3_location :: [
    s3_bucket: s3_bucket,
    s3_key: s3_key,
  ]

  @type s3_location_not_in_service_region_exception :: [
  ]

  @type s3_subscription_required_exception :: [
  ]

  @type sample_timestamp :: integer

  @type single_instance_health :: [
    application_metrics: application_metrics,
    causes: causes,
    color: binary,
    health_status: binary,
    instance_id: instance_id,
    launched_at: launched_at,
    system: system_status,
  ]

  @type solution_stack_description :: [
    permitted_file_types: solution_stack_file_type_list,
    solution_stack_name: solution_stack_name,
  ]

  @type solution_stack_file_type_list :: [file_type_extension]

  @type solution_stack_name :: binary

  @type source_bundle_deletion_exception :: [
  ]

  @type source_configuration :: [
    application_name: application_name,
    template_name: configuration_template_name,
  ]

  @type status_codes :: [
    status2xx: nullable_integer,
    status3xx: nullable_integer,
    status4xx: nullable_integer,
    status5xx: nullable_integer,
  ]

  @type swap_environment_cnam_es_message :: [
    destination_environment_id: environment_id,
    destination_environment_name: environment_name,
    source_environment_id: environment_id,
    source_environment_name: environment_name,
  ]

  @type system_status :: [
    cpu_utilization: cpu_utilization,
    load_average: load_average,
  ]

  @type tag :: [
    key: tag_key,
    value: tag_value,
  ]

  @type tag_key :: binary

  @type tag_value :: binary

  @type tags :: [tag]

  @type terminate_env_force :: boolean

  @type terminate_environment_message :: [
    environment_id: environment_id,
    environment_name: environment_name,
    terminate_resources: terminate_environment_resources,
  ]

  @type terminate_environment_resources :: boolean

  @type time_filter_end :: integer

  @type time_filter_start :: integer

  @type token :: binary

  @type too_many_application_versions_exception :: [
  ]

  @type too_many_applications_exception :: [
  ]

  @type too_many_buckets_exception :: [
  ]

  @type too_many_configuration_templates_exception :: [
  ]

  @type too_many_environments_exception :: [
  ]

  @type trigger :: [
    name: resource_id,
  ]

  @type trigger_list :: [trigger]

  @type update_application_message :: [
    application_name: application_name,
    description: description,
  ]

  @type update_application_version_message :: [
    application_name: application_name,
    description: description,
    version_label: version_label,
  ]

  @type update_configuration_template_message :: [
    application_name: application_name,
    description: description,
    option_settings: configuration_option_settings_list,
    options_to_remove: options_specifier_list,
    template_name: configuration_template_name,
  ]

  @type update_date :: integer

  @type update_environment_message :: [
    description: description,
    environment_id: environment_id,
    environment_name: environment_name,
    option_settings: configuration_option_settings_list,
    options_to_remove: options_specifier_list,
    solution_stack_name: solution_stack_name,
    template_name: configuration_template_name,
    tier: environment_tier,
    version_label: version_label,
  ]

  @type user_defined_option :: boolean

  @type validate_configuration_settings_message :: [
    application_name: application_name,
    environment_name: environment_name,
    option_settings: configuration_option_settings_list,
    template_name: configuration_template_name,
  ]

  @type validation_message :: [
    message: validation_message_string,
    namespace: option_namespace,
    option_name: configuration_option_name,
    severity: validation_severity,
  ]

  @type validation_message_string :: binary

  @type validation_messages_list :: [validation_message]

  @type validation_severity :: binary

  @type version_label :: binary

  @type version_labels_list :: [version_label]




  @doc """
  AbortEnvironmentUpdate

  Cancels in-progress environment configuration update or application version
  deployment.
  """

  @spec abort_environment_update(client :: ExAws.ElasticBeanstalk.t, input :: abort_environment_update_message) :: ExAws.Request.Query.response_t
  def abort_environment_update(client, input) do
    request(client, "/", "AbortEnvironmentUpdate", input)
  end

  @doc """
  Same as `abort_environment_update/2` but raise on error.
  """
  @spec abort_environment_update!(client :: ExAws.ElasticBeanstalk.t, input :: abort_environment_update_message) :: ExAws.Request.Query.success_t | no_return
  def abort_environment_update!(client, input) do
    case abort_environment_update(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CheckDNSAvailability

  Checks if the specified CNAME is available.
  """

  @spec check_dns_availability(client :: ExAws.ElasticBeanstalk.t, input :: check_dns_availability_message) :: ExAws.Request.Query.response_t
  def check_dns_availability(client, input) do
    request(client, "/", "CheckDNSAvailability", input)
  end

  @doc """
  Same as `check_dns_availability/2` but raise on error.
  """
  @spec check_dns_availability!(client :: ExAws.ElasticBeanstalk.t, input :: check_dns_availability_message) :: ExAws.Request.Query.success_t | no_return
  def check_dns_availability!(client, input) do
    case check_dns_availability(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateApplication

  Creates an application that has one configuration template named `default`
  and no application versions.
  """

  @spec create_application(client :: ExAws.ElasticBeanstalk.t, input :: create_application_message) :: ExAws.Request.Query.response_t
  def create_application(client, input) do
    request(client, "/", "CreateApplication", input)
  end

  @doc """
  Same as `create_application/2` but raise on error.
  """
  @spec create_application!(client :: ExAws.ElasticBeanstalk.t, input :: create_application_message) :: ExAws.Request.Query.success_t | no_return
  def create_application!(client, input) do
    case create_application(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateApplicationVersion

  Creates an application version for the specified application.

  Note:Once you create an application version with a specified Amazon S3
  bucket and key location, you cannot change that Amazon S3 location. If you
  change the Amazon S3 location, you receive an exception when you attempt to
  launch an environment from the application version.
  """

  @spec create_application_version(client :: ExAws.ElasticBeanstalk.t, input :: create_application_version_message) :: ExAws.Request.Query.response_t
  def create_application_version(client, input) do
    request(client, "/", "CreateApplicationVersion", input)
  end

  @doc """
  Same as `create_application_version/2` but raise on error.
  """
  @spec create_application_version!(client :: ExAws.ElasticBeanstalk.t, input :: create_application_version_message) :: ExAws.Request.Query.success_t | no_return
  def create_application_version!(client, input) do
    case create_application_version(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateConfigurationTemplate

  Creates a configuration template. Templates are associated with a specific
  application and are used to deploy different versions of the application
  with the same configuration settings.

  Related Topics

  - `DescribeConfigurationOptions`

  - `DescribeConfigurationSettings`

  - `ListAvailableSolutionStacks`
  """

  @spec create_configuration_template(client :: ExAws.ElasticBeanstalk.t, input :: create_configuration_template_message) :: ExAws.Request.Query.response_t
  def create_configuration_template(client, input) do
    request(client, "/", "CreateConfigurationTemplate", input)
  end

  @doc """
  Same as `create_configuration_template/2` but raise on error.
  """
  @spec create_configuration_template!(client :: ExAws.ElasticBeanstalk.t, input :: create_configuration_template_message) :: ExAws.Request.Query.success_t | no_return
  def create_configuration_template!(client, input) do
    case create_configuration_template(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateEnvironment

  Launches an environment for the specified application using the specified
  configuration.
  """

  @spec create_environment(client :: ExAws.ElasticBeanstalk.t, input :: create_environment_message) :: ExAws.Request.Query.response_t
  def create_environment(client, input) do
    request(client, "/", "CreateEnvironment", input)
  end

  @doc """
  Same as `create_environment/2` but raise on error.
  """
  @spec create_environment!(client :: ExAws.ElasticBeanstalk.t, input :: create_environment_message) :: ExAws.Request.Query.success_t | no_return
  def create_environment!(client, input) do
    case create_environment(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateStorageLocation

  Creates the Amazon S3 storage location for the account.

  This location is used to store user log files.
  """

  @spec create_storage_location(client :: ExAws.ElasticBeanstalk.t) :: ExAws.Request.Query.response_t
  def create_storage_location(client) do
    request(client, "/", "CreateStorageLocation", [])
  end

  @doc """
  Same as `create_storage_location/2` but raise on error.
  """
  @spec create_storage_location!(client :: ExAws.ElasticBeanstalk.t) :: ExAws.Request.Query.success_t | no_return
  def create_storage_location!(client) do
    case create_storage_location(client) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteApplication

  Deletes the specified application along with all associated versions and
  configurations. The application versions will not be deleted from your
  Amazon S3 bucket.

  Note:You cannot delete an application that has a running environment.
  """

  @spec delete_application(client :: ExAws.ElasticBeanstalk.t, input :: delete_application_message) :: ExAws.Request.Query.response_t
  def delete_application(client, input) do
    request(client, "/", "DeleteApplication", input)
  end

  @doc """
  Same as `delete_application/2` but raise on error.
  """
  @spec delete_application!(client :: ExAws.ElasticBeanstalk.t, input :: delete_application_message) :: ExAws.Request.Query.success_t | no_return
  def delete_application!(client, input) do
    case delete_application(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteApplicationVersion

  Deletes the specified version from the specified application.

  Note:You cannot delete an application version that is associated with a
  running environment.
  """

  @spec delete_application_version(client :: ExAws.ElasticBeanstalk.t, input :: delete_application_version_message) :: ExAws.Request.Query.response_t
  def delete_application_version(client, input) do
    request(client, "/", "DeleteApplicationVersion", input)
  end

  @doc """
  Same as `delete_application_version/2` but raise on error.
  """
  @spec delete_application_version!(client :: ExAws.ElasticBeanstalk.t, input :: delete_application_version_message) :: ExAws.Request.Query.success_t | no_return
  def delete_application_version!(client, input) do
    case delete_application_version(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteConfigurationTemplate

  Deletes the specified configuration template.

  Note:When you launch an environment using a configuration template, the
  environment gets a copy of the template. You can delete or modify the
  environment's copy of the template without affecting the running
  environment.
  """

  @spec delete_configuration_template(client :: ExAws.ElasticBeanstalk.t, input :: delete_configuration_template_message) :: ExAws.Request.Query.response_t
  def delete_configuration_template(client, input) do
    request(client, "/", "DeleteConfigurationTemplate", input)
  end

  @doc """
  Same as `delete_configuration_template/2` but raise on error.
  """
  @spec delete_configuration_template!(client :: ExAws.ElasticBeanstalk.t, input :: delete_configuration_template_message) :: ExAws.Request.Query.success_t | no_return
  def delete_configuration_template!(client, input) do
    case delete_configuration_template(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteEnvironmentConfiguration

  Deletes the draft configuration associated with the running environment.

  Updating a running environment with any configuration changes creates a
  draft configuration set. You can get the draft configuration using
  `DescribeConfigurationSettings` while the update is in progress or if the
  update fails. The `DeploymentStatus` for the draft configuration indicates
  whether the deployment is in process or has failed. The draft configuration
  remains in existence until it is deleted with this action.
  """

  @spec delete_environment_configuration(client :: ExAws.ElasticBeanstalk.t, input :: delete_environment_configuration_message) :: ExAws.Request.Query.response_t
  def delete_environment_configuration(client, input) do
    request(client, "/", "DeleteEnvironmentConfiguration", input)
  end

  @doc """
  Same as `delete_environment_configuration/2` but raise on error.
  """
  @spec delete_environment_configuration!(client :: ExAws.ElasticBeanstalk.t, input :: delete_environment_configuration_message) :: ExAws.Request.Query.success_t | no_return
  def delete_environment_configuration!(client, input) do
    case delete_environment_configuration(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeApplicationVersions

  Returns descriptions for existing application versions.
  """

  @spec describe_application_versions(client :: ExAws.ElasticBeanstalk.t, input :: describe_application_versions_message) :: ExAws.Request.Query.response_t
  def describe_application_versions(client, input) do
    request(client, "/", "DescribeApplicationVersions", input)
  end

  @doc """
  Same as `describe_application_versions/2` but raise on error.
  """
  @spec describe_application_versions!(client :: ExAws.ElasticBeanstalk.t, input :: describe_application_versions_message) :: ExAws.Request.Query.success_t | no_return
  def describe_application_versions!(client, input) do
    case describe_application_versions(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeApplications

  Returns the descriptions of existing applications.
  """

  @spec describe_applications(client :: ExAws.ElasticBeanstalk.t, input :: describe_applications_message) :: ExAws.Request.Query.response_t
  def describe_applications(client, input) do
    request(client, "/", "DescribeApplications", input)
  end

  @doc """
  Same as `describe_applications/2` but raise on error.
  """
  @spec describe_applications!(client :: ExAws.ElasticBeanstalk.t, input :: describe_applications_message) :: ExAws.Request.Query.success_t | no_return
  def describe_applications!(client, input) do
    case describe_applications(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeConfigurationOptions

  Describes the configuration options that are used in a particular
  configuration template or environment, or that a specified solution stack
  defines. The description includes the values the options, their default
  values, and an indication of the required action on a running environment
  if an option value is changed.
  """

  @spec describe_configuration_options(client :: ExAws.ElasticBeanstalk.t, input :: describe_configuration_options_message) :: ExAws.Request.Query.response_t
  def describe_configuration_options(client, input) do
    request(client, "/", "DescribeConfigurationOptions", input)
  end

  @doc """
  Same as `describe_configuration_options/2` but raise on error.
  """
  @spec describe_configuration_options!(client :: ExAws.ElasticBeanstalk.t, input :: describe_configuration_options_message) :: ExAws.Request.Query.success_t | no_return
  def describe_configuration_options!(client, input) do
    case describe_configuration_options(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeConfigurationSettings

  Returns a description of the settings for the specified configuration set,
  that is, either a configuration template or the configuration set
  associated with a running environment.

  When describing the settings for the configuration set associated with a
  running environment, it is possible to receive two sets of setting
  descriptions. One is the deployed configuration set, and the other is a
  draft configuration of an environment that is either in the process of
  deployment or that failed to deploy.

  Related Topics

  - `DeleteEnvironmentConfiguration`
  """

  @spec describe_configuration_settings(client :: ExAws.ElasticBeanstalk.t, input :: describe_configuration_settings_message) :: ExAws.Request.Query.response_t
  def describe_configuration_settings(client, input) do
    request(client, "/", "DescribeConfigurationSettings", input)
  end

  @doc """
  Same as `describe_configuration_settings/2` but raise on error.
  """
  @spec describe_configuration_settings!(client :: ExAws.ElasticBeanstalk.t, input :: describe_configuration_settings_message) :: ExAws.Request.Query.success_t | no_return
  def describe_configuration_settings!(client, input) do
    case describe_configuration_settings(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeEnvironmentHealth

  Returns information about the overall health of the specified environment.
  The **DescribeEnvironmentHealth** operation is only available with AWS
  Elastic Beanstalk Enhanced Health.
  """

  @spec describe_environment_health(client :: ExAws.ElasticBeanstalk.t, input :: describe_environment_health_request) :: ExAws.Request.Query.response_t
  def describe_environment_health(client, input) do
    request(client, "/", "DescribeEnvironmentHealth", input)
  end

  @doc """
  Same as `describe_environment_health/2` but raise on error.
  """
  @spec describe_environment_health!(client :: ExAws.ElasticBeanstalk.t, input :: describe_environment_health_request) :: ExAws.Request.Query.success_t | no_return
  def describe_environment_health!(client, input) do
    case describe_environment_health(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeEnvironmentResources

  Returns AWS resources for this environment.
  """

  @spec describe_environment_resources(client :: ExAws.ElasticBeanstalk.t, input :: describe_environment_resources_message) :: ExAws.Request.Query.response_t
  def describe_environment_resources(client, input) do
    request(client, "/", "DescribeEnvironmentResources", input)
  end

  @doc """
  Same as `describe_environment_resources/2` but raise on error.
  """
  @spec describe_environment_resources!(client :: ExAws.ElasticBeanstalk.t, input :: describe_environment_resources_message) :: ExAws.Request.Query.success_t | no_return
  def describe_environment_resources!(client, input) do
    case describe_environment_resources(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeEnvironments

  Returns descriptions for existing environments.
  """

  @spec describe_environments(client :: ExAws.ElasticBeanstalk.t, input :: describe_environments_message) :: ExAws.Request.Query.response_t
  def describe_environments(client, input) do
    request(client, "/", "DescribeEnvironments", input)
  end

  @doc """
  Same as `describe_environments/2` but raise on error.
  """
  @spec describe_environments!(client :: ExAws.ElasticBeanstalk.t, input :: describe_environments_message) :: ExAws.Request.Query.success_t | no_return
  def describe_environments!(client, input) do
    case describe_environments(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeEvents

  Returns list of event descriptions matching criteria up to the last 6
  weeks.

  Note: This action returns the most recent 1,000 events from the specified
  `NextToken`.
  """

  @spec describe_events(client :: ExAws.ElasticBeanstalk.t, input :: describe_events_message) :: ExAws.Request.Query.response_t
  def describe_events(client, input) do
    request(client, "/", "DescribeEvents", input)
  end

  @doc """
  Same as `describe_events/2` but raise on error.
  """
  @spec describe_events!(client :: ExAws.ElasticBeanstalk.t, input :: describe_events_message) :: ExAws.Request.Query.success_t | no_return
  def describe_events!(client, input) do
    case describe_events(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeInstancesHealth

  Returns more detailed information about the health of the specified
  instances (for example, CPU utilization, load average, and causes). The
  **DescribeInstancesHealth** operation is only available with AWS Elastic
  Beanstalk Enhanced Health.
  """

  @spec describe_instances_health(client :: ExAws.ElasticBeanstalk.t, input :: describe_instances_health_request) :: ExAws.Request.Query.response_t
  def describe_instances_health(client, input) do
    request(client, "/", "DescribeInstancesHealth", input)
  end

  @doc """
  Same as `describe_instances_health/2` but raise on error.
  """
  @spec describe_instances_health!(client :: ExAws.ElasticBeanstalk.t, input :: describe_instances_health_request) :: ExAws.Request.Query.success_t | no_return
  def describe_instances_health!(client, input) do
    case describe_instances_health(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListAvailableSolutionStacks

  Returns a list of the available solution stack names.
  """

  @spec list_available_solution_stacks(client :: ExAws.ElasticBeanstalk.t) :: ExAws.Request.Query.response_t
  def list_available_solution_stacks(client) do
    request(client, "/", "ListAvailableSolutionStacks", [])
  end

  @doc """
  Same as `list_available_solution_stacks/2` but raise on error.
  """
  @spec list_available_solution_stacks!(client :: ExAws.ElasticBeanstalk.t) :: ExAws.Request.Query.success_t | no_return
  def list_available_solution_stacks!(client) do
    case list_available_solution_stacks(client) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RebuildEnvironment

  Deletes and recreates all of the AWS resources (for example: the Auto
  Scaling group, load balancer, etc.) for a specified environment and forces
  a restart.
  """

  @spec rebuild_environment(client :: ExAws.ElasticBeanstalk.t, input :: rebuild_environment_message) :: ExAws.Request.Query.response_t
  def rebuild_environment(client, input) do
    request(client, "/", "RebuildEnvironment", input)
  end

  @doc """
  Same as `rebuild_environment/2` but raise on error.
  """
  @spec rebuild_environment!(client :: ExAws.ElasticBeanstalk.t, input :: rebuild_environment_message) :: ExAws.Request.Query.success_t | no_return
  def rebuild_environment!(client, input) do
    case rebuild_environment(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RequestEnvironmentInfo

  Initiates a request to compile the specified type of information of the
  deployed environment.

  Setting the `InfoType` to `tail` compiles the last lines from the
  application server log files of every Amazon EC2 instance in your
  environment.

  Setting the `InfoType` to `bundle` compresses the application server log
  files for every Amazon EC2 instance into a `.zip` file. Legacy and .NET
  containers do not support bundle logs.

  Use `RetrieveEnvironmentInfo` to obtain the set of logs.

  Related Topics

  - `RetrieveEnvironmentInfo`
  """

  @spec request_environment_info(client :: ExAws.ElasticBeanstalk.t, input :: request_environment_info_message) :: ExAws.Request.Query.response_t
  def request_environment_info(client, input) do
    request(client, "/", "RequestEnvironmentInfo", input)
  end

  @doc """
  Same as `request_environment_info/2` but raise on error.
  """
  @spec request_environment_info!(client :: ExAws.ElasticBeanstalk.t, input :: request_environment_info_message) :: ExAws.Request.Query.success_t | no_return
  def request_environment_info!(client, input) do
    case request_environment_info(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RestartAppServer

  Causes the environment to restart the application container server running
  on each Amazon EC2 instance.
  """

  @spec restart_app_server(client :: ExAws.ElasticBeanstalk.t, input :: restart_app_server_message) :: ExAws.Request.Query.response_t
  def restart_app_server(client, input) do
    request(client, "/", "RestartAppServer", input)
  end

  @doc """
  Same as `restart_app_server/2` but raise on error.
  """
  @spec restart_app_server!(client :: ExAws.ElasticBeanstalk.t, input :: restart_app_server_message) :: ExAws.Request.Query.success_t | no_return
  def restart_app_server!(client, input) do
    case restart_app_server(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RetrieveEnvironmentInfo

  Retrieves the compiled information from a `RequestEnvironmentInfo` request.

  Related Topics

  - `RequestEnvironmentInfo`
  """

  @spec retrieve_environment_info(client :: ExAws.ElasticBeanstalk.t, input :: retrieve_environment_info_message) :: ExAws.Request.Query.response_t
  def retrieve_environment_info(client, input) do
    request(client, "/", "RetrieveEnvironmentInfo", input)
  end

  @doc """
  Same as `retrieve_environment_info/2` but raise on error.
  """
  @spec retrieve_environment_info!(client :: ExAws.ElasticBeanstalk.t, input :: retrieve_environment_info_message) :: ExAws.Request.Query.success_t | no_return
  def retrieve_environment_info!(client, input) do
    case retrieve_environment_info(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  SwapEnvironmentCNAMEs

  Swaps the CNAMEs of two environments.
  """

  @spec swap_environment_cnam_es(client :: ExAws.ElasticBeanstalk.t, input :: swap_environment_cnam_es_message) :: ExAws.Request.Query.response_t
  def swap_environment_cnam_es(client, input) do
    request(client, "/", "SwapEnvironmentCNAMEs", input)
  end

  @doc """
  Same as `swap_environment_cnam_es/2` but raise on error.
  """
  @spec swap_environment_cnam_es!(client :: ExAws.ElasticBeanstalk.t, input :: swap_environment_cnam_es_message) :: ExAws.Request.Query.success_t | no_return
  def swap_environment_cnam_es!(client, input) do
    case swap_environment_cnam_es(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  TerminateEnvironment

  Terminates the specified environment.
  """

  @spec terminate_environment(client :: ExAws.ElasticBeanstalk.t, input :: terminate_environment_message) :: ExAws.Request.Query.response_t
  def terminate_environment(client, input) do
    request(client, "/", "TerminateEnvironment", input)
  end

  @doc """
  Same as `terminate_environment/2` but raise on error.
  """
  @spec terminate_environment!(client :: ExAws.ElasticBeanstalk.t, input :: terminate_environment_message) :: ExAws.Request.Query.success_t | no_return
  def terminate_environment!(client, input) do
    case terminate_environment(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateApplication

  Updates the specified application to have the specified properties.

  Note: If a property (for example, `description`) is not provided, the value
  remains unchanged. To clear these properties, specify an empty string.
  """

  @spec update_application(client :: ExAws.ElasticBeanstalk.t, input :: update_application_message) :: ExAws.Request.Query.response_t
  def update_application(client, input) do
    request(client, "/", "UpdateApplication", input)
  end

  @doc """
  Same as `update_application/2` but raise on error.
  """
  @spec update_application!(client :: ExAws.ElasticBeanstalk.t, input :: update_application_message) :: ExAws.Request.Query.success_t | no_return
  def update_application!(client, input) do
    case update_application(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateApplicationVersion

  Updates the specified application version to have the specified properties.

  Note: If a property (for example, `description`) is not provided, the value
  remains unchanged. To clear properties, specify an empty string.
  """

  @spec update_application_version(client :: ExAws.ElasticBeanstalk.t, input :: update_application_version_message) :: ExAws.Request.Query.response_t
  def update_application_version(client, input) do
    request(client, "/", "UpdateApplicationVersion", input)
  end

  @doc """
  Same as `update_application_version/2` but raise on error.
  """
  @spec update_application_version!(client :: ExAws.ElasticBeanstalk.t, input :: update_application_version_message) :: ExAws.Request.Query.success_t | no_return
  def update_application_version!(client, input) do
    case update_application_version(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateConfigurationTemplate

  Updates the specified configuration template to have the specified
  properties or configuration option values.

  Note: If a property (for example, `ApplicationName`) is not provided, its
  value remains unchanged. To clear such properties, specify an empty string.
  Related Topics

  - `DescribeConfigurationOptions`
  """

  @spec update_configuration_template(client :: ExAws.ElasticBeanstalk.t, input :: update_configuration_template_message) :: ExAws.Request.Query.response_t
  def update_configuration_template(client, input) do
    request(client, "/", "UpdateConfigurationTemplate", input)
  end

  @doc """
  Same as `update_configuration_template/2` but raise on error.
  """
  @spec update_configuration_template!(client :: ExAws.ElasticBeanstalk.t, input :: update_configuration_template_message) :: ExAws.Request.Query.success_t | no_return
  def update_configuration_template!(client, input) do
    case update_configuration_template(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateEnvironment

  Updates the environment description, deploys a new application version,
  updates the configuration settings to an entirely new configuration
  template, or updates select configuration option values in the running
  environment.

  Attempting to update both the release and configuration is not allowed and
  AWS Elastic Beanstalk returns an `InvalidParameterCombination` error.

  When updating the configuration settings to a new template or individual
  settings, a draft configuration is created and
  `DescribeConfigurationSettings` for this environment returns two setting
  descriptions with different `DeploymentStatus` values.
  """

  @spec update_environment(client :: ExAws.ElasticBeanstalk.t, input :: update_environment_message) :: ExAws.Request.Query.response_t
  def update_environment(client, input) do
    request(client, "/", "UpdateEnvironment", input)
  end

  @doc """
  Same as `update_environment/2` but raise on error.
  """
  @spec update_environment!(client :: ExAws.ElasticBeanstalk.t, input :: update_environment_message) :: ExAws.Request.Query.success_t | no_return
  def update_environment!(client, input) do
    case update_environment(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ValidateConfigurationSettings

  Takes a set of configuration settings and either a configuration template
  or environment, and determines whether those values are valid.

  This action returns a list of messages indicating any errors or warnings
  associated with the selection of option values.
  """

  @spec validate_configuration_settings(client :: ExAws.ElasticBeanstalk.t, input :: validate_configuration_settings_message) :: ExAws.Request.Query.response_t
  def validate_configuration_settings(client, input) do
    request(client, "/", "ValidateConfigurationSettings", input)
  end

  @doc """
  Same as `validate_configuration_settings/2` but raise on error.
  """
  @spec validate_configuration_settings!(client :: ExAws.ElasticBeanstalk.t, input :: validate_configuration_settings_message) :: ExAws.Request.Query.success_t | no_return
  def validate_configuration_settings!(client, input) do
    case validate_configuration_settings(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  defp request(%{__struct__: client_module} = client, uri, action, input) do
    apply(client_module, :request, [client, uri, action, input])
  end
end
