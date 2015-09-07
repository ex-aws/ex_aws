defmodule ExAws.OpsWorks.Core do
  import ExAws.Core.JSON, only: [format_input: 1]
  @actions [
    "AssignInstance",
    "AssignVolume",
    "AssociateElasticIp",
    "AttachElasticLoadBalancer",
    "CloneStack",
    "CreateApp",
    "CreateDeployment",
    "CreateInstance",
    "CreateLayer",
    "CreateStack",
    "CreateUserProfile",
    "DeleteApp",
    "DeleteInstance",
    "DeleteLayer",
    "DeleteStack",
    "DeleteUserProfile",
    "DeregisterEcsCluster",
    "DeregisterElasticIp",
    "DeregisterInstance",
    "DeregisterRdsDbInstance",
    "DeregisterVolume",
    "DescribeAgentVersions",
    "DescribeApps",
    "DescribeCommands",
    "DescribeDeployments",
    "DescribeEcsClusters",
    "DescribeElasticIps",
    "DescribeElasticLoadBalancers",
    "DescribeInstances",
    "DescribeLayers",
    "DescribeLoadBasedAutoScaling",
    "DescribeMyUserProfile",
    "DescribePermissions",
    "DescribeRaidArrays",
    "DescribeRdsDbInstances",
    "DescribeServiceErrors",
    "DescribeStackProvisioningParameters",
    "DescribeStackSummary",
    "DescribeStacks",
    "DescribeTimeBasedAutoScaling",
    "DescribeUserProfiles",
    "DescribeVolumes",
    "DetachElasticLoadBalancer",
    "DisassociateElasticIp",
    "GetHostnameSuggestion",
    "GrantAccess",
    "RebootInstance",
    "RegisterEcsCluster",
    "RegisterElasticIp",
    "RegisterInstance",
    "RegisterRdsDbInstance",
    "RegisterVolume",
    "SetLoadBasedAutoScaling",
    "SetPermission",
    "SetTimeBasedAutoScaling",
    "StartInstance",
    "StartStack",
    "StopInstance",
    "StopStack",
    "UnassignInstance",
    "UnassignVolume",
    "UpdateApp",
    "UpdateElasticIp",
    "UpdateInstance",
    "UpdateLayer",
    "UpdateMyUserProfile",
    "UpdateRdsDbInstance",
    "UpdateStack",
    "UpdateUserProfile",
    "UpdateVolume"]

  @moduledoc """
  ## AWS OpsWorks

  AWS OpsWorks

  Welcome to the *AWS OpsWorks API Reference*. This guide provides
  descriptions, syntax, and usage examples about AWS OpsWorks actions and
  data types, including common parameters and error codes.

  AWS OpsWorks is an application management service that provides an
  integrated experience for overseeing the complete application lifecycle.
  For information about this product, go to the [AWS
  OpsWorks](http://aws.amazon.com/opsworks/) details page.

  **SDKs and CLI**

  The most common way to use the AWS OpsWorks API is by using the AWS Command
  Line Interface (CLI) or by using one of the AWS SDKs to implement
  applications in your preferred language. For more information, see:

  - [AWS
  CLI](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html)

  - [AWS SDK for
  Java](http://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/services/opsworks/AWSOpsWorksClient.html)

  - [AWS SDK for
  .NET](http://docs.aws.amazon.com/sdkfornet/latest/apidocs/html/N_Amazon_OpsWorks.htm)

  - [AWS SDK for PHP
  2](http://docs.aws.amazon.com/aws-sdk-php-2/latest/class-Aws.OpsWorks.OpsWorksClient.html)

  - [AWS SDK for
  Ruby](http://docs.aws.amazon.com/AWSRubySDK/latest/AWS/OpsWorks/Client.html)

  - [AWS SDK for
  Node.js](http://aws.amazon.com/documentation/sdkforjavascript/)

  - [AWS SDK for
  Python(Boto)](http://docs.pythonboto.org/en/latest/ref/opsworks.html)

  **Endpoints**

  AWS OpsWorks supports only one endpoint, opsworks.us-east-1.amazonaws.com
  (HTTPS), so you must connect to that endpoint. You can then use the API to
  direct AWS OpsWorks to create stacks in any AWS Region.

  **Chef Versions**

  When you call `CreateStack`, `CloneStack`, or `UpdateStack` we recommend
  you use the `ConfigurationManager` parameter to specify the Chef version.
  The recommended value for Linux stacks, which is also the default value, is
  currently 11.10. Windows stacks use Chef 12.2. For more information, see
  [Chef
  Versions](http://docs.aws.amazon.com/opsworks/latest/userguide/workingcookbook-chef11.html).

  Note:You can also specify Chef 11.4 or Chef 0.9 for your Linux stack.
  However, Chef 0.9 has been deprecated. We do not recommend using Chef 0.9
  for new stacks, and we recommend migrating your existing Chef 0.9 stacks to
  Chef 11.10 as soon as possible.
  """

  @type agent_version :: [
    configuration_manager: stack_configuration_manager,
    version: binary,
  ]

  @type agent_versions :: [agent_version]

  @type app :: [
    app_id: binary,
    app_source: source,
    attributes: app_attributes,
    created_at: binary,
    data_sources: data_sources,
    description: binary,
    domains: strings,
    enable_ssl: boolean,
    environment: environment_variables,
    name: binary,
    shortname: binary,
    ssl_configuration: ssl_configuration,
    stack_id: binary,
    type: app_type,
  ]

  @type app_attributes :: [{app_attributes_keys, binary}]

  @type app_attributes_keys :: binary

  @type app_type :: binary

  @type apps :: [app]

  @type architecture :: binary

  @type assign_instance_request :: [
    instance_id: binary,
    layer_ids: strings,
  ]

  @type assign_volume_request :: [
    instance_id: binary,
    volume_id: binary,
  ]

  @type associate_elastic_ip_request :: [
    elastic_ip: binary,
    instance_id: binary,
  ]

  @type attach_elastic_load_balancer_request :: [
    elastic_load_balancer_name: binary,
    layer_id: binary,
  ]

  @type auto_scaling_thresholds :: [
    alarms: strings,
    cpu_threshold: double,
    ignore_metrics_time: minute,
    instance_count: integer,
    load_threshold: double,
    memory_threshold: double,
    thresholds_wait_time: minute,
  ]

  @type auto_scaling_type :: binary

  @type block_device_mapping :: [
    device_name: binary,
    ebs: ebs_block_device,
    no_device: binary,
    virtual_name: binary,
  ]

  @type block_device_mappings :: [block_device_mapping]

  @type chef_configuration :: [
    berkshelf_version: binary,
    manage_berkshelf: boolean,
  ]

  @type clone_stack_request :: [
    agent_version: binary,
    attributes: stack_attributes,
    chef_configuration: chef_configuration,
    clone_app_ids: strings,
    clone_permissions: boolean,
    configuration_manager: stack_configuration_manager,
    custom_cookbooks_source: source,
    custom_json: binary,
    default_availability_zone: binary,
    default_instance_profile_arn: binary,
    default_os: binary,
    default_root_device_type: root_device_type,
    default_ssh_key_name: binary,
    default_subnet_id: binary,
    hostname_theme: binary,
    name: binary,
    region: binary,
    service_role_arn: binary,
    source_stack_id: binary,
    use_custom_cookbooks: boolean,
    use_opsworks_security_groups: boolean,
    vpc_id: binary,
  ]

  @type clone_stack_result :: [
    stack_id: binary,
  ]

  @type command :: [
    acknowledged_at: date_time,
    command_id: binary,
    completed_at: date_time,
    created_at: date_time,
    deployment_id: binary,
    exit_code: integer,
    instance_id: binary,
    log_url: binary,
    status: binary,
    type: binary,
  ]

  @type commands :: [command]

  @type create_app_request :: [
    app_source: source,
    attributes: app_attributes,
    data_sources: data_sources,
    description: binary,
    domains: strings,
    enable_ssl: boolean,
    environment: environment_variables,
    name: binary,
    shortname: binary,
    ssl_configuration: ssl_configuration,
    stack_id: binary,
    type: app_type,
  ]

  @type create_app_result :: [
    app_id: binary,
  ]

  @type create_deployment_request :: [
    app_id: binary,
    command: deployment_command,
    comment: binary,
    custom_json: binary,
    instance_ids: strings,
    stack_id: binary,
  ]

  @type create_deployment_result :: [
    deployment_id: binary,
  ]

  @type create_instance_request :: [
    agent_version: binary,
    ami_id: binary,
    architecture: architecture,
    auto_scaling_type: auto_scaling_type,
    availability_zone: binary,
    block_device_mappings: block_device_mappings,
    ebs_optimized: boolean,
    hostname: binary,
    install_updates_on_boot: boolean,
    instance_type: binary,
    layer_ids: strings,
    os: binary,
    root_device_type: root_device_type,
    ssh_key_name: binary,
    stack_id: binary,
    subnet_id: binary,
    virtualization_type: binary,
  ]

  @type create_instance_result :: [
    instance_id: binary,
  ]

  @type create_layer_request :: [
    attributes: layer_attributes,
    auto_assign_elastic_ips: boolean,
    auto_assign_public_ips: boolean,
    custom_instance_profile_arn: binary,
    custom_json: binary,
    custom_recipes: recipes,
    custom_security_group_ids: strings,
    enable_auto_healing: boolean,
    install_updates_on_boot: boolean,
    lifecycle_event_configuration: lifecycle_event_configuration,
    name: binary,
    packages: strings,
    shortname: binary,
    stack_id: binary,
    type: layer_type,
    use_ebs_optimized_instances: boolean,
    volume_configurations: volume_configurations,
  ]

  @type create_layer_result :: [
    layer_id: binary,
  ]

  @type create_stack_request :: [
    agent_version: binary,
    attributes: stack_attributes,
    chef_configuration: chef_configuration,
    configuration_manager: stack_configuration_manager,
    custom_cookbooks_source: source,
    custom_json: binary,
    default_availability_zone: binary,
    default_instance_profile_arn: binary,
    default_os: binary,
    default_root_device_type: root_device_type,
    default_ssh_key_name: binary,
    default_subnet_id: binary,
    hostname_theme: binary,
    name: binary,
    region: binary,
    service_role_arn: binary,
    use_custom_cookbooks: boolean,
    use_opsworks_security_groups: boolean,
    vpc_id: binary,
  ]

  @type create_stack_result :: [
    stack_id: binary,
  ]

  @type create_user_profile_request :: [
    allow_self_management: boolean,
    iam_user_arn: binary,
    ssh_public_key: binary,
    ssh_username: binary,
  ]

  @type create_user_profile_result :: [
    iam_user_arn: binary,
  ]

  @type daily_auto_scaling_schedule :: [{hour, switch}]

  @type data_source :: [
    arn: binary,
    database_name: binary,
    type: binary,
  ]

  @type data_sources :: [data_source]

  @type date_time :: binary

  @type delete_app_request :: [
    app_id: binary,
  ]

  @type delete_instance_request :: [
    delete_elastic_ip: boolean,
    delete_volumes: boolean,
    instance_id: binary,
  ]

  @type delete_layer_request :: [
    layer_id: binary,
  ]

  @type delete_stack_request :: [
    stack_id: binary,
  ]

  @type delete_user_profile_request :: [
    iam_user_arn: binary,
  ]

  @type deployment :: [
    app_id: binary,
    command: deployment_command,
    comment: binary,
    completed_at: date_time,
    created_at: date_time,
    custom_json: binary,
    deployment_id: binary,
    duration: integer,
    iam_user_arn: binary,
    instance_ids: strings,
    stack_id: binary,
    status: binary,
  ]

  @type deployment_command :: [
    args: deployment_command_args,
    name: deployment_command_name,
  ]

  @type deployment_command_args :: [{binary, strings}]

  @type deployment_command_name :: binary

  @type deployments :: [deployment]

  @type deregister_ecs_cluster_request :: [
    ecs_cluster_arn: binary,
  ]

  @type deregister_elastic_ip_request :: [
    elastic_ip: binary,
  ]

  @type deregister_instance_request :: [
    instance_id: binary,
  ]

  @type deregister_rds_db_instance_request :: [
    rds_db_instance_arn: binary,
  ]

  @type deregister_volume_request :: [
    volume_id: binary,
  ]

  @type describe_agent_versions_request :: [
    configuration_manager: stack_configuration_manager,
    stack_id: binary,
  ]

  @type describe_agent_versions_result :: [
    agent_versions: agent_versions,
  ]

  @type describe_apps_request :: [
    app_ids: strings,
    stack_id: binary,
  ]

  @type describe_apps_result :: [
    apps: apps,
  ]

  @type describe_commands_request :: [
    command_ids: strings,
    deployment_id: binary,
    instance_id: binary,
  ]

  @type describe_commands_result :: [
    commands: commands,
  ]

  @type describe_deployments_request :: [
    app_id: binary,
    deployment_ids: strings,
    stack_id: binary,
  ]

  @type describe_deployments_result :: [
    deployments: deployments,
  ]

  @type describe_ecs_clusters_request :: [
    ecs_cluster_arns: strings,
    max_results: integer,
    next_token: binary,
    stack_id: binary,
  ]

  @type describe_ecs_clusters_result :: [
    ecs_clusters: ecs_clusters,
    next_token: binary,
  ]

  @type describe_elastic_ips_request :: [
    instance_id: binary,
    ips: strings,
    stack_id: binary,
  ]

  @type describe_elastic_ips_result :: [
    elastic_ips: elastic_ips,
  ]

  @type describe_elastic_load_balancers_request :: [
    layer_ids: strings,
    stack_id: binary,
  ]

  @type describe_elastic_load_balancers_result :: [
    elastic_load_balancers: elastic_load_balancers,
  ]

  @type describe_instances_request :: [
    instance_ids: strings,
    layer_id: binary,
    stack_id: binary,
  ]

  @type describe_instances_result :: [
    instances: instances,
  ]

  @type describe_layers_request :: [
    layer_ids: strings,
    stack_id: binary,
  ]

  @type describe_layers_result :: [
    layers: layers,
  ]

  @type describe_load_based_auto_scaling_request :: [
    layer_ids: strings,
  ]

  @type describe_load_based_auto_scaling_result :: [
    load_based_auto_scaling_configurations: load_based_auto_scaling_configurations,
  ]

  @type describe_my_user_profile_result :: [
    user_profile: self_user_profile,
  ]

  @type describe_permissions_request :: [
    iam_user_arn: binary,
    stack_id: binary,
  ]

  @type describe_permissions_result :: [
    permissions: permissions,
  ]

  @type describe_raid_arrays_request :: [
    instance_id: binary,
    raid_array_ids: strings,
    stack_id: binary,
  ]

  @type describe_raid_arrays_result :: [
    raid_arrays: raid_arrays,
  ]

  @type describe_rds_db_instances_request :: [
    rds_db_instance_arns: strings,
    stack_id: binary,
  ]

  @type describe_rds_db_instances_result :: [
    rds_db_instances: rds_db_instances,
  ]

  @type describe_service_errors_request :: [
    instance_id: binary,
    service_error_ids: strings,
    stack_id: binary,
  ]

  @type describe_service_errors_result :: [
    service_errors: service_errors,
  ]

  @type describe_stack_provisioning_parameters_request :: [
    stack_id: binary,
  ]

  @type describe_stack_provisioning_parameters_result :: [
    agent_installer_url: binary,
    parameters: parameters,
  ]

  @type describe_stack_summary_request :: [
    stack_id: binary,
  ]

  @type describe_stack_summary_result :: [
    stack_summary: stack_summary,
  ]

  @type describe_stacks_request :: [
    stack_ids: strings,
  ]

  @type describe_stacks_result :: [
    stacks: stacks,
  ]

  @type describe_time_based_auto_scaling_request :: [
    instance_ids: strings,
  ]

  @type describe_time_based_auto_scaling_result :: [
    time_based_auto_scaling_configurations: time_based_auto_scaling_configurations,
  ]

  @type describe_user_profiles_request :: [
    iam_user_arns: strings,
  ]

  @type describe_user_profiles_result :: [
    user_profiles: user_profiles,
  ]

  @type describe_volumes_request :: [
    instance_id: binary,
    raid_array_id: binary,
    stack_id: binary,
    volume_ids: strings,
  ]

  @type describe_volumes_result :: [
    volumes: volumes,
  ]

  @type detach_elastic_load_balancer_request :: [
    elastic_load_balancer_name: binary,
    layer_id: binary,
  ]

  @type disassociate_elastic_ip_request :: [
    elastic_ip: binary,
  ]

  @type double :: float

  @type ebs_block_device :: [
    delete_on_termination: boolean,
    iops: integer,
    snapshot_id: binary,
    volume_size: integer,
    volume_type: volume_type,
  ]

  @type ecs_cluster :: [
    ecs_cluster_arn: binary,
    ecs_cluster_name: binary,
    registered_at: date_time,
    stack_id: binary,
  ]

  @type ecs_clusters :: [ecs_cluster]

  @type elastic_ip :: [
    domain: binary,
    instance_id: binary,
    ip: binary,
    name: binary,
    region: binary,
  ]

  @type elastic_ips :: [elastic_ip]

  @type elastic_load_balancer :: [
    availability_zones: strings,
    dns_name: binary,
    ec2_instance_ids: strings,
    elastic_load_balancer_name: binary,
    layer_id: binary,
    region: binary,
    stack_id: binary,
    subnet_ids: strings,
    vpc_id: binary,
  ]

  @type elastic_load_balancers :: [elastic_load_balancer]

  @type environment_variable :: [
    key: binary,
    secure: boolean,
    value: binary,
  ]

  @type environment_variables :: [environment_variable]

  @type get_hostname_suggestion_request :: [
    layer_id: binary,
  ]

  @type get_hostname_suggestion_result :: [
    hostname: binary,
    layer_id: binary,
  ]

  @type grant_access_request :: [
    instance_id: binary,
    valid_for_in_minutes: valid_for_in_minutes,
  ]

  @type grant_access_result :: [
    temporary_credential: temporary_credential,
  ]

  @type hour :: binary

  @type instance :: [
    agent_version: binary,
    ami_id: binary,
    architecture: architecture,
    auto_scaling_type: auto_scaling_type,
    availability_zone: binary,
    block_device_mappings: block_device_mappings,
    created_at: date_time,
    ebs_optimized: boolean,
    ec2_instance_id: binary,
    ecs_cluster_arn: binary,
    ecs_container_instance_arn: binary,
    elastic_ip: binary,
    hostname: binary,
    infrastructure_class: binary,
    install_updates_on_boot: boolean,
    instance_id: binary,
    instance_profile_arn: binary,
    instance_type: binary,
    last_service_error_id: binary,
    layer_ids: strings,
    os: binary,
    platform: binary,
    private_dns: binary,
    private_ip: binary,
    public_dns: binary,
    public_ip: binary,
    registered_by: binary,
    reported_agent_version: binary,
    reported_os: reported_os,
    root_device_type: root_device_type,
    root_device_volume_id: binary,
    security_group_ids: strings,
    ssh_host_dsa_key_fingerprint: binary,
    ssh_host_rsa_key_fingerprint: binary,
    ssh_key_name: binary,
    stack_id: binary,
    status: binary,
    subnet_id: binary,
    virtualization_type: virtualization_type,
  ]

  @type instance_identity :: [
    document: binary,
    signature: binary,
  ]

  @type instances :: [instance]

  @type instances_count :: [
    assigning: integer,
    booting: integer,
    connection_lost: integer,
    deregistering: integer,
    online: integer,
    pending: integer,
    rebooting: integer,
    registered: integer,
    registering: integer,
    requested: integer,
    running_setup: integer,
    setup_failed: integer,
    shutting_down: integer,
    start_failed: integer,
    stopped: integer,
    stopping: integer,
    terminated: integer,
    terminating: integer,
    unassigning: integer,
  ]

  @type layer :: [
    attributes: layer_attributes,
    auto_assign_elastic_ips: boolean,
    auto_assign_public_ips: boolean,
    created_at: date_time,
    custom_instance_profile_arn: binary,
    custom_json: binary,
    custom_recipes: recipes,
    custom_security_group_ids: strings,
    default_recipes: recipes,
    default_security_group_names: strings,
    enable_auto_healing: boolean,
    install_updates_on_boot: boolean,
    layer_id: binary,
    lifecycle_event_configuration: lifecycle_event_configuration,
    name: binary,
    packages: strings,
    shortname: binary,
    stack_id: binary,
    type: layer_type,
    use_ebs_optimized_instances: boolean,
    volume_configurations: volume_configurations,
  ]

  @type layer_attributes :: [{layer_attributes_keys, binary}]

  @type layer_attributes_keys :: binary

  @type layer_type :: binary

  @type layers :: [layer]

  @type lifecycle_event_configuration :: [
    shutdown: shutdown_event_configuration,
  ]

  @type load_based_auto_scaling_configuration :: [
    down_scaling: auto_scaling_thresholds,
    enable: boolean,
    layer_id: binary,
    up_scaling: auto_scaling_thresholds,
  ]

  @type load_based_auto_scaling_configurations :: [load_based_auto_scaling_configuration]

  @type minute :: integer

  @type parameters :: [{binary, binary}]

  @type permission :: [
    allow_ssh: boolean,
    allow_sudo: boolean,
    iam_user_arn: binary,
    level: binary,
    stack_id: binary,
  ]

  @type permissions :: [permission]

  @type raid_array :: [
    availability_zone: binary,
    created_at: date_time,
    device: binary,
    instance_id: binary,
    iops: integer,
    mount_point: binary,
    name: binary,
    number_of_disks: integer,
    raid_array_id: binary,
    raid_level: integer,
    size: integer,
    stack_id: binary,
    volume_type: binary,
  ]

  @type raid_arrays :: [raid_array]

  @type rds_db_instance :: [
    address: binary,
    db_instance_identifier: binary,
    db_password: binary,
    db_user: binary,
    engine: binary,
    missing_on_rds: boolean,
    rds_db_instance_arn: binary,
    region: binary,
    stack_id: binary,
  ]

  @type rds_db_instances :: [rds_db_instance]

  @type reboot_instance_request :: [
    instance_id: binary,
  ]

  @type recipes :: [
    configure: strings,
    deploy: strings,
    setup: strings,
    shutdown: strings,
    undeploy: strings,
  ]

  @type register_ecs_cluster_request :: [
    ecs_cluster_arn: binary,
    stack_id: binary,
  ]

  @type register_ecs_cluster_result :: [
    ecs_cluster_arn: binary,
  ]

  @type register_elastic_ip_request :: [
    elastic_ip: binary,
    stack_id: binary,
  ]

  @type register_elastic_ip_result :: [
    elastic_ip: binary,
  ]

  @type register_instance_request :: [
    hostname: binary,
    instance_identity: instance_identity,
    private_ip: binary,
    public_ip: binary,
    rsa_public_key: binary,
    rsa_public_key_fingerprint: binary,
    stack_id: binary,
  ]

  @type register_instance_result :: [
    instance_id: binary,
  ]

  @type register_rds_db_instance_request :: [
    db_password: binary,
    db_user: binary,
    rds_db_instance_arn: binary,
    stack_id: binary,
  ]

  @type register_volume_request :: [
    ec2_volume_id: binary,
    stack_id: binary,
  ]

  @type register_volume_result :: [
    volume_id: binary,
  ]

  @type reported_os :: [
    family: binary,
    name: binary,
    version: binary,
  ]

  @type resource_not_found_exception :: [
    message: binary,
  ]

  @type root_device_type :: binary

  @type self_user_profile :: [
    iam_user_arn: binary,
    name: binary,
    ssh_public_key: binary,
    ssh_username: binary,
  ]

  @type service_error :: [
    created_at: date_time,
    instance_id: binary,
    message: binary,
    service_error_id: binary,
    stack_id: binary,
    type: binary,
  ]

  @type service_errors :: [service_error]

  @type set_load_based_auto_scaling_request :: [
    down_scaling: auto_scaling_thresholds,
    enable: boolean,
    layer_id: binary,
    up_scaling: auto_scaling_thresholds,
  ]

  @type set_permission_request :: [
    allow_ssh: boolean,
    allow_sudo: boolean,
    iam_user_arn: binary,
    level: binary,
    stack_id: binary,
  ]

  @type set_time_based_auto_scaling_request :: [
    auto_scaling_schedule: weekly_auto_scaling_schedule,
    instance_id: binary,
  ]

  @type shutdown_event_configuration :: [
    delay_until_elb_connections_drained: boolean,
    execution_timeout: integer,
  ]

  @type source :: [
    password: binary,
    revision: binary,
    ssh_key: binary,
    type: source_type,
    url: binary,
    username: binary,
  ]

  @type source_type :: binary

  @type ssl_configuration :: [
    certificate: binary,
    chain: binary,
    private_key: binary,
  ]

  @type stack :: [
    agent_version: binary,
    arn: binary,
    attributes: stack_attributes,
    chef_configuration: chef_configuration,
    configuration_manager: stack_configuration_manager,
    created_at: date_time,
    custom_cookbooks_source: source,
    custom_json: binary,
    default_availability_zone: binary,
    default_instance_profile_arn: binary,
    default_os: binary,
    default_root_device_type: root_device_type,
    default_ssh_key_name: binary,
    default_subnet_id: binary,
    hostname_theme: binary,
    name: binary,
    region: binary,
    service_role_arn: binary,
    stack_id: binary,
    use_custom_cookbooks: boolean,
    use_opsworks_security_groups: boolean,
    vpc_id: binary,
  ]

  @type stack_attributes :: [{stack_attributes_keys, binary}]

  @type stack_attributes_keys :: binary

  @type stack_configuration_manager :: [
    name: binary,
    version: binary,
  ]

  @type stack_summary :: [
    apps_count: integer,
    arn: binary,
    instances_count: instances_count,
    layers_count: integer,
    name: binary,
    stack_id: binary,
  ]

  @type stacks :: [stack]

  @type start_instance_request :: [
    instance_id: binary,
  ]

  @type start_stack_request :: [
    stack_id: binary,
  ]

  @type stop_instance_request :: [
    instance_id: binary,
  ]

  @type stop_stack_request :: [
    stack_id: binary,
  ]

  @type strings :: [binary]

  @type switch :: binary

  @type temporary_credential :: [
    instance_id: binary,
    password: binary,
    username: binary,
    valid_for_in_minutes: integer,
  ]

  @type time_based_auto_scaling_configuration :: [
    auto_scaling_schedule: weekly_auto_scaling_schedule,
    instance_id: binary,
  ]

  @type time_based_auto_scaling_configurations :: [time_based_auto_scaling_configuration]

  @type unassign_instance_request :: [
    instance_id: binary,
  ]

  @type unassign_volume_request :: [
    volume_id: binary,
  ]

  @type update_app_request :: [
    app_id: binary,
    app_source: source,
    attributes: app_attributes,
    data_sources: data_sources,
    description: binary,
    domains: strings,
    enable_ssl: boolean,
    environment: environment_variables,
    name: binary,
    ssl_configuration: ssl_configuration,
    type: app_type,
  ]

  @type update_elastic_ip_request :: [
    elastic_ip: binary,
    name: binary,
  ]

  @type update_instance_request :: [
    agent_version: binary,
    ami_id: binary,
    architecture: architecture,
    auto_scaling_type: auto_scaling_type,
    ebs_optimized: boolean,
    hostname: binary,
    install_updates_on_boot: boolean,
    instance_id: binary,
    instance_type: binary,
    layer_ids: strings,
    os: binary,
    ssh_key_name: binary,
  ]

  @type update_layer_request :: [
    attributes: layer_attributes,
    auto_assign_elastic_ips: boolean,
    auto_assign_public_ips: boolean,
    custom_instance_profile_arn: binary,
    custom_json: binary,
    custom_recipes: recipes,
    custom_security_group_ids: strings,
    enable_auto_healing: boolean,
    install_updates_on_boot: boolean,
    layer_id: binary,
    lifecycle_event_configuration: lifecycle_event_configuration,
    name: binary,
    packages: strings,
    shortname: binary,
    use_ebs_optimized_instances: boolean,
    volume_configurations: volume_configurations,
  ]

  @type update_my_user_profile_request :: [
    ssh_public_key: binary,
  ]

  @type update_rds_db_instance_request :: [
    db_password: binary,
    db_user: binary,
    rds_db_instance_arn: binary,
  ]

  @type update_stack_request :: [
    agent_version: binary,
    attributes: stack_attributes,
    chef_configuration: chef_configuration,
    configuration_manager: stack_configuration_manager,
    custom_cookbooks_source: source,
    custom_json: binary,
    default_availability_zone: binary,
    default_instance_profile_arn: binary,
    default_os: binary,
    default_root_device_type: root_device_type,
    default_ssh_key_name: binary,
    default_subnet_id: binary,
    hostname_theme: binary,
    name: binary,
    service_role_arn: binary,
    stack_id: binary,
    use_custom_cookbooks: boolean,
    use_opsworks_security_groups: boolean,
  ]

  @type update_user_profile_request :: [
    allow_self_management: boolean,
    iam_user_arn: binary,
    ssh_public_key: binary,
    ssh_username: binary,
  ]

  @type update_volume_request :: [
    mount_point: binary,
    name: binary,
    volume_id: binary,
  ]

  @type user_profile :: [
    allow_self_management: boolean,
    iam_user_arn: binary,
    name: binary,
    ssh_public_key: binary,
    ssh_username: binary,
  ]

  @type user_profiles :: [user_profile]

  @type valid_for_in_minutes :: integer

  @type validation_exception :: [
    message: binary,
  ]

  @type virtualization_type :: binary

  @type volume :: [
    availability_zone: binary,
    device: binary,
    ec2_volume_id: binary,
    instance_id: binary,
    iops: integer,
    mount_point: binary,
    name: binary,
    raid_array_id: binary,
    region: binary,
    size: integer,
    status: binary,
    volume_id: binary,
    volume_type: binary,
  ]

  @type volume_configuration :: [
    iops: integer,
    mount_point: binary,
    number_of_disks: integer,
    raid_level: integer,
    size: integer,
    volume_type: binary,
  ]

  @type volume_configurations :: [volume_configuration]

  @type volume_type :: binary

  @type volumes :: [volume]

  @type weekly_auto_scaling_schedule :: [
    friday: daily_auto_scaling_schedule,
    monday: daily_auto_scaling_schedule,
    saturday: daily_auto_scaling_schedule,
    sunday: daily_auto_scaling_schedule,
    thursday: daily_auto_scaling_schedule,
    tuesday: daily_auto_scaling_schedule,
    wednesday: daily_auto_scaling_schedule,
  ]





  @doc """
  AssignInstance

  Assign a registered instance to a layer.

  - You can assign registered on-premises instances to any layer type.

  - You can assign registered Amazon EC2 instances only to custom layers.

  - You cannot use this action with instances that were created with AWS
  OpsWorks.

  **Required Permissions**: To use this action, an AWS Identity and Access
  Management (IAM) user must have a Manage permissions level for the stack or
  an attached policy that explicitly grants permissions. For more information
  on user permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec assign_instance(client :: ExAws.OpsWorks.t, input :: assign_instance_request) :: ExAws.Request.JSON.response_t
  def assign_instance(client, input) do
    request(client, "AssignInstance", format_input(input))
  end

  @doc """
  Same as `assign_instance/2` but raise on error.
  """
  @spec assign_instance!(client :: ExAws.OpsWorks.t, input :: assign_instance_request) :: ExAws.Request.JSON.success_t | no_return
  def assign_instance!(client, input) do
    case assign_instance(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  AssignVolume

  Assigns one of the stack's registered Amazon EBS volumes to a specified
  instance. The volume must first be registered with the stack by calling
  `RegisterVolume`. After you register the volume, you must call
  `UpdateVolume` to specify a mount point before calling `AssignVolume`. For
  more information, see [Resource
  Management](http://docs.aws.amazon.com/opsworks/latest/userguide/resources.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec assign_volume(client :: ExAws.OpsWorks.t, input :: assign_volume_request) :: ExAws.Request.JSON.response_t
  def assign_volume(client, input) do
    request(client, "AssignVolume", format_input(input))
  end

  @doc """
  Same as `assign_volume/2` but raise on error.
  """
  @spec assign_volume!(client :: ExAws.OpsWorks.t, input :: assign_volume_request) :: ExAws.Request.JSON.success_t | no_return
  def assign_volume!(client, input) do
    case assign_volume(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  AssociateElasticIp

  Associates one of the stack's registered Elastic IP addresses with a
  specified instance. The address must first be registered with the stack by
  calling `RegisterElasticIp`. For more information, see [Resource
  Management](http://docs.aws.amazon.com/opsworks/latest/userguide/resources.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec associate_elastic_ip(client :: ExAws.OpsWorks.t, input :: associate_elastic_ip_request) :: ExAws.Request.JSON.response_t
  def associate_elastic_ip(client, input) do
    request(client, "AssociateElasticIp", format_input(input))
  end

  @doc """
  Same as `associate_elastic_ip/2` but raise on error.
  """
  @spec associate_elastic_ip!(client :: ExAws.OpsWorks.t, input :: associate_elastic_ip_request) :: ExAws.Request.JSON.success_t | no_return
  def associate_elastic_ip!(client, input) do
    case associate_elastic_ip(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  AttachElasticLoadBalancer

  Attaches an Elastic Load Balancing load balancer to a specified layer. For
  more information, see [Elastic Load
  Balancing](http://docs.aws.amazon.com/opsworks/latest/userguide/load-balancer-elb.html).

  Note: You must create the Elastic Load Balancing instance separately, by
  using the Elastic Load Balancing console, API, or CLI. For more
  information, see [ Elastic Load Balancing Developer
  Guide](http://docs.aws.amazon.com/ElasticLoadBalancing/latest/DeveloperGuide/Welcome.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec attach_elastic_load_balancer(client :: ExAws.OpsWorks.t, input :: attach_elastic_load_balancer_request) :: ExAws.Request.JSON.response_t
  def attach_elastic_load_balancer(client, input) do
    request(client, "AttachElasticLoadBalancer", format_input(input))
  end

  @doc """
  Same as `attach_elastic_load_balancer/2` but raise on error.
  """
  @spec attach_elastic_load_balancer!(client :: ExAws.OpsWorks.t, input :: attach_elastic_load_balancer_request) :: ExAws.Request.JSON.success_t | no_return
  def attach_elastic_load_balancer!(client, input) do
    case attach_elastic_load_balancer(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CloneStack

  Creates a clone of a specified stack. For more information, see [Clone a
  Stack](http://docs.aws.amazon.com/opsworks/latest/userguide/workingstacks-cloning.html).
  By default, all parameters are set to the values used by the parent stack.

  **Required Permissions**: To use this action, an IAM user must have an
  attached policy that explicitly grants permissions. For more information on
  user permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec clone_stack(client :: ExAws.OpsWorks.t, input :: clone_stack_request) :: ExAws.Request.JSON.response_t
  def clone_stack(client, input) do
    request(client, "CloneStack", format_input(input))
  end

  @doc """
  Same as `clone_stack/2` but raise on error.
  """
  @spec clone_stack!(client :: ExAws.OpsWorks.t, input :: clone_stack_request) :: ExAws.Request.JSON.success_t | no_return
  def clone_stack!(client, input) do
    case clone_stack(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateApp

  Creates an app for a specified stack. For more information, see [Creating
  Apps](http://docs.aws.amazon.com/opsworks/latest/userguide/workingapps-creating.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec create_app(client :: ExAws.OpsWorks.t, input :: create_app_request) :: ExAws.Request.JSON.response_t
  def create_app(client, input) do
    request(client, "CreateApp", format_input(input))
  end

  @doc """
  Same as `create_app/2` but raise on error.
  """
  @spec create_app!(client :: ExAws.OpsWorks.t, input :: create_app_request) :: ExAws.Request.JSON.success_t | no_return
  def create_app!(client, input) do
    case create_app(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateDeployment

  Runs deployment or stack commands. For more information, see [Deploying
  Apps](http://docs.aws.amazon.com/opsworks/latest/userguide/workingapps-deploying.html)
  and [Run Stack
  Commands](http://docs.aws.amazon.com/opsworks/latest/userguide/workingstacks-commands.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Deploy or Manage permissions level for the stack, or an attached policy
  that explicitly grants permissions. For more information on user
  permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec create_deployment(client :: ExAws.OpsWorks.t, input :: create_deployment_request) :: ExAws.Request.JSON.response_t
  def create_deployment(client, input) do
    request(client, "CreateDeployment", format_input(input))
  end

  @doc """
  Same as `create_deployment/2` but raise on error.
  """
  @spec create_deployment!(client :: ExAws.OpsWorks.t, input :: create_deployment_request) :: ExAws.Request.JSON.success_t | no_return
  def create_deployment!(client, input) do
    case create_deployment(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateInstance

  Creates an instance in a specified stack. For more information, see [Adding
  an Instance to a
  Layer](http://docs.aws.amazon.com/opsworks/latest/userguide/workinginstances-add.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec create_instance(client :: ExAws.OpsWorks.t, input :: create_instance_request) :: ExAws.Request.JSON.response_t
  def create_instance(client, input) do
    request(client, "CreateInstance", format_input(input))
  end

  @doc """
  Same as `create_instance/2` but raise on error.
  """
  @spec create_instance!(client :: ExAws.OpsWorks.t, input :: create_instance_request) :: ExAws.Request.JSON.success_t | no_return
  def create_instance!(client, input) do
    case create_instance(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateLayer

  Creates a layer. For more information, see [How to Create a
  Layer](http://docs.aws.amazon.com/opsworks/latest/userguide/workinglayers-basics-create.html).

  Note: You should use **CreateLayer** for noncustom layer types such as PHP
  App Server only if the stack does not have an existing layer of that type.
  A stack can have at most one instance of each noncustom layer; if you
  attempt to create a second instance, **CreateLayer** fails. A stack can
  have an arbitrary number of custom layers, so you can call **CreateLayer**
  as many times as you like for that layer type.

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec create_layer(client :: ExAws.OpsWorks.t, input :: create_layer_request) :: ExAws.Request.JSON.response_t
  def create_layer(client, input) do
    request(client, "CreateLayer", format_input(input))
  end

  @doc """
  Same as `create_layer/2` but raise on error.
  """
  @spec create_layer!(client :: ExAws.OpsWorks.t, input :: create_layer_request) :: ExAws.Request.JSON.success_t | no_return
  def create_layer!(client, input) do
    case create_layer(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateStack

  Creates a new stack. For more information, see [Create a New
  Stack](http://docs.aws.amazon.com/opsworks/latest/userguide/workingstacks-edit.html).

  **Required Permissions**: To use this action, an IAM user must have an
  attached policy that explicitly grants permissions. For more information on
  user permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec create_stack(client :: ExAws.OpsWorks.t, input :: create_stack_request) :: ExAws.Request.JSON.response_t
  def create_stack(client, input) do
    request(client, "CreateStack", format_input(input))
  end

  @doc """
  Same as `create_stack/2` but raise on error.
  """
  @spec create_stack!(client :: ExAws.OpsWorks.t, input :: create_stack_request) :: ExAws.Request.JSON.success_t | no_return
  def create_stack!(client, input) do
    case create_stack(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateUserProfile

  Creates a new user profile.

  **Required Permissions**: To use this action, an IAM user must have an
  attached policy that explicitly grants permissions. For more information on
  user permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec create_user_profile(client :: ExAws.OpsWorks.t, input :: create_user_profile_request) :: ExAws.Request.JSON.response_t
  def create_user_profile(client, input) do
    request(client, "CreateUserProfile", format_input(input))
  end

  @doc """
  Same as `create_user_profile/2` but raise on error.
  """
  @spec create_user_profile!(client :: ExAws.OpsWorks.t, input :: create_user_profile_request) :: ExAws.Request.JSON.success_t | no_return
  def create_user_profile!(client, input) do
    case create_user_profile(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteApp

  Deletes a specified app.

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec delete_app(client :: ExAws.OpsWorks.t, input :: delete_app_request) :: ExAws.Request.JSON.response_t
  def delete_app(client, input) do
    request(client, "DeleteApp", format_input(input))
  end

  @doc """
  Same as `delete_app/2` but raise on error.
  """
  @spec delete_app!(client :: ExAws.OpsWorks.t, input :: delete_app_request) :: ExAws.Request.JSON.success_t | no_return
  def delete_app!(client, input) do
    case delete_app(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteInstance

  Deletes a specified instance, which terminates the associated Amazon EC2
  instance. You must stop an instance before you can delete it.

  For more information, see [Deleting
  Instances](http://docs.aws.amazon.com/opsworks/latest/userguide/workinginstances-delete.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec delete_instance(client :: ExAws.OpsWorks.t, input :: delete_instance_request) :: ExAws.Request.JSON.response_t
  def delete_instance(client, input) do
    request(client, "DeleteInstance", format_input(input))
  end

  @doc """
  Same as `delete_instance/2` but raise on error.
  """
  @spec delete_instance!(client :: ExAws.OpsWorks.t, input :: delete_instance_request) :: ExAws.Request.JSON.success_t | no_return
  def delete_instance!(client, input) do
    case delete_instance(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteLayer

  Deletes a specified layer. You must first stop and then delete all
  associated instances or unassign registered instances. For more
  information, see [How to Delete a
  Layer](http://docs.aws.amazon.com/opsworks/latest/userguide/workinglayers-basics-delete.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec delete_layer(client :: ExAws.OpsWorks.t, input :: delete_layer_request) :: ExAws.Request.JSON.response_t
  def delete_layer(client, input) do
    request(client, "DeleteLayer", format_input(input))
  end

  @doc """
  Same as `delete_layer/2` but raise on error.
  """
  @spec delete_layer!(client :: ExAws.OpsWorks.t, input :: delete_layer_request) :: ExAws.Request.JSON.success_t | no_return
  def delete_layer!(client, input) do
    case delete_layer(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteStack

  Deletes a specified stack. You must first delete all instances, layers, and
  apps or deregister registered instances. For more information, see [Shut
  Down a
  Stack](http://docs.aws.amazon.com/opsworks/latest/userguide/workingstacks-shutting.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec delete_stack(client :: ExAws.OpsWorks.t, input :: delete_stack_request) :: ExAws.Request.JSON.response_t
  def delete_stack(client, input) do
    request(client, "DeleteStack", format_input(input))
  end

  @doc """
  Same as `delete_stack/2` but raise on error.
  """
  @spec delete_stack!(client :: ExAws.OpsWorks.t, input :: delete_stack_request) :: ExAws.Request.JSON.success_t | no_return
  def delete_stack!(client, input) do
    case delete_stack(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteUserProfile

  Deletes a user profile.

  **Required Permissions**: To use this action, an IAM user must have an
  attached policy that explicitly grants permissions. For more information on
  user permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec delete_user_profile(client :: ExAws.OpsWorks.t, input :: delete_user_profile_request) :: ExAws.Request.JSON.response_t
  def delete_user_profile(client, input) do
    request(client, "DeleteUserProfile", format_input(input))
  end

  @doc """
  Same as `delete_user_profile/2` but raise on error.
  """
  @spec delete_user_profile!(client :: ExAws.OpsWorks.t, input :: delete_user_profile_request) :: ExAws.Request.JSON.success_t | no_return
  def delete_user_profile!(client, input) do
    case delete_user_profile(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeregisterEcsCluster

  Deregisters a specified Amazon ECS cluster from a stack. For more
  information, see [ Resource
  Management](http://docs.aws.amazon.com/opsworks/latest/userguide/workinglayers-ecscluster.html#workinglayers-ecscluster-delete).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see <a
  href="http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html">`.
  """

  @spec deregister_ecs_cluster(client :: ExAws.OpsWorks.t, input :: deregister_ecs_cluster_request) :: ExAws.Request.JSON.response_t
  def deregister_ecs_cluster(client, input) do
    request(client, "DeregisterEcsCluster", format_input(input))
  end

  @doc """
  Same as `deregister_ecs_cluster/2` but raise on error.
  """
  @spec deregister_ecs_cluster!(client :: ExAws.OpsWorks.t, input :: deregister_ecs_cluster_request) :: ExAws.Request.JSON.success_t | no_return
  def deregister_ecs_cluster!(client, input) do
    case deregister_ecs_cluster(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeregisterElasticIp

  Deregisters a specified Elastic IP address. The address can then be
  registered by another stack. For more information, see [Resource
  Management](http://docs.aws.amazon.com/opsworks/latest/userguide/resources.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec deregister_elastic_ip(client :: ExAws.OpsWorks.t, input :: deregister_elastic_ip_request) :: ExAws.Request.JSON.response_t
  def deregister_elastic_ip(client, input) do
    request(client, "DeregisterElasticIp", format_input(input))
  end

  @doc """
  Same as `deregister_elastic_ip/2` but raise on error.
  """
  @spec deregister_elastic_ip!(client :: ExAws.OpsWorks.t, input :: deregister_elastic_ip_request) :: ExAws.Request.JSON.success_t | no_return
  def deregister_elastic_ip!(client, input) do
    case deregister_elastic_ip(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeregisterInstance

  Deregister a registered Amazon EC2 or on-premises instance. This action
  removes the instance from the stack and returns it to your control. This
  action can not be used with instances that were created with AWS OpsWorks.

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec deregister_instance(client :: ExAws.OpsWorks.t, input :: deregister_instance_request) :: ExAws.Request.JSON.response_t
  def deregister_instance(client, input) do
    request(client, "DeregisterInstance", format_input(input))
  end

  @doc """
  Same as `deregister_instance/2` but raise on error.
  """
  @spec deregister_instance!(client :: ExAws.OpsWorks.t, input :: deregister_instance_request) :: ExAws.Request.JSON.success_t | no_return
  def deregister_instance!(client, input) do
    case deregister_instance(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeregisterRdsDbInstance

  Deregisters an Amazon RDS instance.

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec deregister_rds_db_instance(client :: ExAws.OpsWorks.t, input :: deregister_rds_db_instance_request) :: ExAws.Request.JSON.response_t
  def deregister_rds_db_instance(client, input) do
    request(client, "DeregisterRdsDbInstance", format_input(input))
  end

  @doc """
  Same as `deregister_rds_db_instance/2` but raise on error.
  """
  @spec deregister_rds_db_instance!(client :: ExAws.OpsWorks.t, input :: deregister_rds_db_instance_request) :: ExAws.Request.JSON.success_t | no_return
  def deregister_rds_db_instance!(client, input) do
    case deregister_rds_db_instance(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeregisterVolume

  Deregisters an Amazon EBS volume. The volume can then be registered by
  another stack. For more information, see [Resource
  Management](http://docs.aws.amazon.com/opsworks/latest/userguide/resources.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec deregister_volume(client :: ExAws.OpsWorks.t, input :: deregister_volume_request) :: ExAws.Request.JSON.response_t
  def deregister_volume(client, input) do
    request(client, "DeregisterVolume", format_input(input))
  end

  @doc """
  Same as `deregister_volume/2` but raise on error.
  """
  @spec deregister_volume!(client :: ExAws.OpsWorks.t, input :: deregister_volume_request) :: ExAws.Request.JSON.success_t | no_return
  def deregister_volume!(client, input) do
    case deregister_volume(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeAgentVersions

  Describes the available AWS OpsWorks agent versions. You must specify a
  stack ID or a configuration manager. `DescribeAgentVersions` returns a list
  of available agent versions for the specified stack or configuration
  manager.
  """

  @spec describe_agent_versions(client :: ExAws.OpsWorks.t, input :: describe_agent_versions_request) :: ExAws.Request.JSON.response_t
  def describe_agent_versions(client, input) do
    request(client, "DescribeAgentVersions", format_input(input))
  end

  @doc """
  Same as `describe_agent_versions/2` but raise on error.
  """
  @spec describe_agent_versions!(client :: ExAws.OpsWorks.t, input :: describe_agent_versions_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_agent_versions!(client, input) do
    case describe_agent_versions(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeApps

  Requests a description of a specified set of apps.

  Note: You must specify at least one of the parameters.

  **Required Permissions**: To use this action, an IAM user must have a Show,
  Deploy, or Manage permissions level for the stack, or an attached policy
  that explicitly grants permissions. For more information on user
  permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec describe_apps(client :: ExAws.OpsWorks.t, input :: describe_apps_request) :: ExAws.Request.JSON.response_t
  def describe_apps(client, input) do
    request(client, "DescribeApps", format_input(input))
  end

  @doc """
  Same as `describe_apps/2` but raise on error.
  """
  @spec describe_apps!(client :: ExAws.OpsWorks.t, input :: describe_apps_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_apps!(client, input) do
    case describe_apps(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeCommands

  Describes the results of specified commands.

  Note: You must specify at least one of the parameters.

  **Required Permissions**: To use this action, an IAM user must have a Show,
  Deploy, or Manage permissions level for the stack, or an attached policy
  that explicitly grants permissions. For more information on user
  permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec describe_commands(client :: ExAws.OpsWorks.t, input :: describe_commands_request) :: ExAws.Request.JSON.response_t
  def describe_commands(client, input) do
    request(client, "DescribeCommands", format_input(input))
  end

  @doc """
  Same as `describe_commands/2` but raise on error.
  """
  @spec describe_commands!(client :: ExAws.OpsWorks.t, input :: describe_commands_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_commands!(client, input) do
    case describe_commands(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeDeployments

  Requests a description of a specified set of deployments.

  Note: You must specify at least one of the parameters.

  **Required Permissions**: To use this action, an IAM user must have a Show,
  Deploy, or Manage permissions level for the stack, or an attached policy
  that explicitly grants permissions. For more information on user
  permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec describe_deployments(client :: ExAws.OpsWorks.t, input :: describe_deployments_request) :: ExAws.Request.JSON.response_t
  def describe_deployments(client, input) do
    request(client, "DescribeDeployments", format_input(input))
  end

  @doc """
  Same as `describe_deployments/2` but raise on error.
  """
  @spec describe_deployments!(client :: ExAws.OpsWorks.t, input :: describe_deployments_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_deployments!(client, input) do
    case describe_deployments(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeEcsClusters

  Describes Amazon ECS clusters that are registered with a stack. If you
  specify only a stack ID, you can use the `MaxResults` and `NextToken`
  parameters to paginate the response. However, AWS OpsWorks currently
  supports only one cluster per layer, so the result set has a maximum of one
  element.

  **Required Permissions**: To use this action, an IAM user must have a Show,
  Deploy, or Manage permissions level for the stack or an attached policy
  that explicitly grants permission. For more information on user
  permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec describe_ecs_clusters(client :: ExAws.OpsWorks.t, input :: describe_ecs_clusters_request) :: ExAws.Request.JSON.response_t
  def describe_ecs_clusters(client, input) do
    request(client, "DescribeEcsClusters", format_input(input))
  end

  @doc """
  Same as `describe_ecs_clusters/2` but raise on error.
  """
  @spec describe_ecs_clusters!(client :: ExAws.OpsWorks.t, input :: describe_ecs_clusters_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_ecs_clusters!(client, input) do
    case describe_ecs_clusters(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeElasticIps

  Describes [Elastic IP
  addresses](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html).

  Note: You must specify at least one of the parameters.

  **Required Permissions**: To use this action, an IAM user must have a Show,
  Deploy, or Manage permissions level for the stack, or an attached policy
  that explicitly grants permissions. For more information on user
  permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec describe_elastic_ips(client :: ExAws.OpsWorks.t, input :: describe_elastic_ips_request) :: ExAws.Request.JSON.response_t
  def describe_elastic_ips(client, input) do
    request(client, "DescribeElasticIps", format_input(input))
  end

  @doc """
  Same as `describe_elastic_ips/2` but raise on error.
  """
  @spec describe_elastic_ips!(client :: ExAws.OpsWorks.t, input :: describe_elastic_ips_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_elastic_ips!(client, input) do
    case describe_elastic_ips(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeElasticLoadBalancers

  Describes a stack's Elastic Load Balancing instances.

  Note: You must specify at least one of the parameters.

  **Required Permissions**: To use this action, an IAM user must have a Show,
  Deploy, or Manage permissions level for the stack, or an attached policy
  that explicitly grants permissions. For more information on user
  permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec describe_elastic_load_balancers(client :: ExAws.OpsWorks.t, input :: describe_elastic_load_balancers_request) :: ExAws.Request.JSON.response_t
  def describe_elastic_load_balancers(client, input) do
    request(client, "DescribeElasticLoadBalancers", format_input(input))
  end

  @doc """
  Same as `describe_elastic_load_balancers/2` but raise on error.
  """
  @spec describe_elastic_load_balancers!(client :: ExAws.OpsWorks.t, input :: describe_elastic_load_balancers_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_elastic_load_balancers!(client, input) do
    case describe_elastic_load_balancers(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeInstances

  Requests a description of a set of instances.

  Note: You must specify at least one of the parameters.

  **Required Permissions**: To use this action, an IAM user must have a Show,
  Deploy, or Manage permissions level for the stack, or an attached policy
  that explicitly grants permissions. For more information on user
  permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec describe_instances(client :: ExAws.OpsWorks.t, input :: describe_instances_request) :: ExAws.Request.JSON.response_t
  def describe_instances(client, input) do
    request(client, "DescribeInstances", format_input(input))
  end

  @doc """
  Same as `describe_instances/2` but raise on error.
  """
  @spec describe_instances!(client :: ExAws.OpsWorks.t, input :: describe_instances_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_instances!(client, input) do
    case describe_instances(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeLayers

  Requests a description of one or more layers in a specified stack.

  Note: You must specify at least one of the parameters.

  **Required Permissions**: To use this action, an IAM user must have a Show,
  Deploy, or Manage permissions level for the stack, or an attached policy
  that explicitly grants permissions. For more information on user
  permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec describe_layers(client :: ExAws.OpsWorks.t, input :: describe_layers_request) :: ExAws.Request.JSON.response_t
  def describe_layers(client, input) do
    request(client, "DescribeLayers", format_input(input))
  end

  @doc """
  Same as `describe_layers/2` but raise on error.
  """
  @spec describe_layers!(client :: ExAws.OpsWorks.t, input :: describe_layers_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_layers!(client, input) do
    case describe_layers(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeLoadBasedAutoScaling

  Describes load-based auto scaling configurations for specified layers.

  Note: You must specify at least one of the parameters.

  **Required Permissions**: To use this action, an IAM user must have a Show,
  Deploy, or Manage permissions level for the stack, or an attached policy
  that explicitly grants permissions. For more information on user
  permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec describe_load_based_auto_scaling(client :: ExAws.OpsWorks.t, input :: describe_load_based_auto_scaling_request) :: ExAws.Request.JSON.response_t
  def describe_load_based_auto_scaling(client, input) do
    request(client, "DescribeLoadBasedAutoScaling", format_input(input))
  end

  @doc """
  Same as `describe_load_based_auto_scaling/2` but raise on error.
  """
  @spec describe_load_based_auto_scaling!(client :: ExAws.OpsWorks.t, input :: describe_load_based_auto_scaling_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_load_based_auto_scaling!(client, input) do
    case describe_load_based_auto_scaling(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeMyUserProfile

  Describes a user's SSH information.

  **Required Permissions**: To use this action, an IAM user must have
  self-management enabled or an attached policy that explicitly grants
  permissions. For more information on user permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec describe_my_user_profile(client :: ExAws.OpsWorks.t) :: ExAws.Request.JSON.response_t
  def describe_my_user_profile(client) do
    request(client, "DescribeMyUserProfile", %{})
  end

  @doc """
  Same as `describe_my_user_profile/2` but raise on error.
  """
  @spec describe_my_user_profile!(client :: ExAws.OpsWorks.t) :: ExAws.Request.JSON.success_t | no_return
  def describe_my_user_profile!(client) do
    case describe_my_user_profile(client) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribePermissions

  Describes the permissions for a specified stack.

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec describe_permissions(client :: ExAws.OpsWorks.t, input :: describe_permissions_request) :: ExAws.Request.JSON.response_t
  def describe_permissions(client, input) do
    request(client, "DescribePermissions", format_input(input))
  end

  @doc """
  Same as `describe_permissions/2` but raise on error.
  """
  @spec describe_permissions!(client :: ExAws.OpsWorks.t, input :: describe_permissions_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_permissions!(client, input) do
    case describe_permissions(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeRaidArrays

  Describe an instance's RAID arrays.

  Note: You must specify at least one of the parameters.

  **Required Permissions**: To use this action, an IAM user must have a Show,
  Deploy, or Manage permissions level for the stack, or an attached policy
  that explicitly grants permissions. For more information on user
  permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec describe_raid_arrays(client :: ExAws.OpsWorks.t, input :: describe_raid_arrays_request) :: ExAws.Request.JSON.response_t
  def describe_raid_arrays(client, input) do
    request(client, "DescribeRaidArrays", format_input(input))
  end

  @doc """
  Same as `describe_raid_arrays/2` but raise on error.
  """
  @spec describe_raid_arrays!(client :: ExAws.OpsWorks.t, input :: describe_raid_arrays_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_raid_arrays!(client, input) do
    case describe_raid_arrays(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeRdsDbInstances

  Describes Amazon RDS instances.

  **Required Permissions**: To use this action, an IAM user must have a Show,
  Deploy, or Manage permissions level for the stack, or an attached policy
  that explicitly grants permissions. For more information on user
  permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec describe_rds_db_instances(client :: ExAws.OpsWorks.t, input :: describe_rds_db_instances_request) :: ExAws.Request.JSON.response_t
  def describe_rds_db_instances(client, input) do
    request(client, "DescribeRdsDbInstances", format_input(input))
  end

  @doc """
  Same as `describe_rds_db_instances/2` but raise on error.
  """
  @spec describe_rds_db_instances!(client :: ExAws.OpsWorks.t, input :: describe_rds_db_instances_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_rds_db_instances!(client, input) do
    case describe_rds_db_instances(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeServiceErrors

  Describes AWS OpsWorks service errors.

  **Required Permissions**: To use this action, an IAM user must have a Show,
  Deploy, or Manage permissions level for the stack, or an attached policy
  that explicitly grants permissions. For more information on user
  permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec describe_service_errors(client :: ExAws.OpsWorks.t, input :: describe_service_errors_request) :: ExAws.Request.JSON.response_t
  def describe_service_errors(client, input) do
    request(client, "DescribeServiceErrors", format_input(input))
  end

  @doc """
  Same as `describe_service_errors/2` but raise on error.
  """
  @spec describe_service_errors!(client :: ExAws.OpsWorks.t, input :: describe_service_errors_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_service_errors!(client, input) do
    case describe_service_errors(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeStackProvisioningParameters

  Requests a description of a stack's provisioning parameters.

  **Required Permissions**: To use this action, an IAM user must have a Show,
  Deploy, or Manage permissions level for the stack or an attached policy
  that explicitly grants permissions. For more information on user
  permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec describe_stack_provisioning_parameters(client :: ExAws.OpsWorks.t, input :: describe_stack_provisioning_parameters_request) :: ExAws.Request.JSON.response_t
  def describe_stack_provisioning_parameters(client, input) do
    request(client, "DescribeStackProvisioningParameters", format_input(input))
  end

  @doc """
  Same as `describe_stack_provisioning_parameters/2` but raise on error.
  """
  @spec describe_stack_provisioning_parameters!(client :: ExAws.OpsWorks.t, input :: describe_stack_provisioning_parameters_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_stack_provisioning_parameters!(client, input) do
    case describe_stack_provisioning_parameters(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeStackSummary

  Describes the number of layers and apps in a specified stack, and the
  number of instances in each state, such as `running_setup` or `online`.

  **Required Permissions**: To use this action, an IAM user must have a Show,
  Deploy, or Manage permissions level for the stack, or an attached policy
  that explicitly grants permissions. For more information on user
  permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec describe_stack_summary(client :: ExAws.OpsWorks.t, input :: describe_stack_summary_request) :: ExAws.Request.JSON.response_t
  def describe_stack_summary(client, input) do
    request(client, "DescribeStackSummary", format_input(input))
  end

  @doc """
  Same as `describe_stack_summary/2` but raise on error.
  """
  @spec describe_stack_summary!(client :: ExAws.OpsWorks.t, input :: describe_stack_summary_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_stack_summary!(client, input) do
    case describe_stack_summary(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeStacks

  Requests a description of one or more stacks.

  **Required Permissions**: To use this action, an IAM user must have a Show,
  Deploy, or Manage permissions level for the stack, or an attached policy
  that explicitly grants permissions. For more information on user
  permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec describe_stacks(client :: ExAws.OpsWorks.t, input :: describe_stacks_request) :: ExAws.Request.JSON.response_t
  def describe_stacks(client, input) do
    request(client, "DescribeStacks", format_input(input))
  end

  @doc """
  Same as `describe_stacks/2` but raise on error.
  """
  @spec describe_stacks!(client :: ExAws.OpsWorks.t, input :: describe_stacks_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_stacks!(client, input) do
    case describe_stacks(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeTimeBasedAutoScaling

  Describes time-based auto scaling configurations for specified instances.

  Note: You must specify at least one of the parameters.

  **Required Permissions**: To use this action, an IAM user must have a Show,
  Deploy, or Manage permissions level for the stack, or an attached policy
  that explicitly grants permissions. For more information on user
  permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec describe_time_based_auto_scaling(client :: ExAws.OpsWorks.t, input :: describe_time_based_auto_scaling_request) :: ExAws.Request.JSON.response_t
  def describe_time_based_auto_scaling(client, input) do
    request(client, "DescribeTimeBasedAutoScaling", format_input(input))
  end

  @doc """
  Same as `describe_time_based_auto_scaling/2` but raise on error.
  """
  @spec describe_time_based_auto_scaling!(client :: ExAws.OpsWorks.t, input :: describe_time_based_auto_scaling_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_time_based_auto_scaling!(client, input) do
    case describe_time_based_auto_scaling(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeUserProfiles

  Describe specified users.

  **Required Permissions**: To use this action, an IAM user must have an
  attached policy that explicitly grants permissions. For more information on
  user permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec describe_user_profiles(client :: ExAws.OpsWorks.t, input :: describe_user_profiles_request) :: ExAws.Request.JSON.response_t
  def describe_user_profiles(client, input) do
    request(client, "DescribeUserProfiles", format_input(input))
  end

  @doc """
  Same as `describe_user_profiles/2` but raise on error.
  """
  @spec describe_user_profiles!(client :: ExAws.OpsWorks.t, input :: describe_user_profiles_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_user_profiles!(client, input) do
    case describe_user_profiles(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeVolumes

  Describes an instance's Amazon EBS volumes.

  Note: You must specify at least one of the parameters.

  **Required Permissions**: To use this action, an IAM user must have a Show,
  Deploy, or Manage permissions level for the stack, or an attached policy
  that explicitly grants permissions. For more information on user
  permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec describe_volumes(client :: ExAws.OpsWorks.t, input :: describe_volumes_request) :: ExAws.Request.JSON.response_t
  def describe_volumes(client, input) do
    request(client, "DescribeVolumes", format_input(input))
  end

  @doc """
  Same as `describe_volumes/2` but raise on error.
  """
  @spec describe_volumes!(client :: ExAws.OpsWorks.t, input :: describe_volumes_request) :: ExAws.Request.JSON.success_t | no_return
  def describe_volumes!(client, input) do
    case describe_volumes(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DetachElasticLoadBalancer

  Detaches a specified Elastic Load Balancing instance from its layer.

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec detach_elastic_load_balancer(client :: ExAws.OpsWorks.t, input :: detach_elastic_load_balancer_request) :: ExAws.Request.JSON.response_t
  def detach_elastic_load_balancer(client, input) do
    request(client, "DetachElasticLoadBalancer", format_input(input))
  end

  @doc """
  Same as `detach_elastic_load_balancer/2` but raise on error.
  """
  @spec detach_elastic_load_balancer!(client :: ExAws.OpsWorks.t, input :: detach_elastic_load_balancer_request) :: ExAws.Request.JSON.success_t | no_return
  def detach_elastic_load_balancer!(client, input) do
    case detach_elastic_load_balancer(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DisassociateElasticIp

  Disassociates an Elastic IP address from its instance. The address remains
  registered with the stack. For more information, see [Resource
  Management](http://docs.aws.amazon.com/opsworks/latest/userguide/resources.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec disassociate_elastic_ip(client :: ExAws.OpsWorks.t, input :: disassociate_elastic_ip_request) :: ExAws.Request.JSON.response_t
  def disassociate_elastic_ip(client, input) do
    request(client, "DisassociateElasticIp", format_input(input))
  end

  @doc """
  Same as `disassociate_elastic_ip/2` but raise on error.
  """
  @spec disassociate_elastic_ip!(client :: ExAws.OpsWorks.t, input :: disassociate_elastic_ip_request) :: ExAws.Request.JSON.success_t | no_return
  def disassociate_elastic_ip!(client, input) do
    case disassociate_elastic_ip(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GetHostnameSuggestion

  Gets a generated host name for the specified layer, based on the current
  host name theme.

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec get_hostname_suggestion(client :: ExAws.OpsWorks.t, input :: get_hostname_suggestion_request) :: ExAws.Request.JSON.response_t
  def get_hostname_suggestion(client, input) do
    request(client, "GetHostnameSuggestion", format_input(input))
  end

  @doc """
  Same as `get_hostname_suggestion/2` but raise on error.
  """
  @spec get_hostname_suggestion!(client :: ExAws.OpsWorks.t, input :: get_hostname_suggestion_request) :: ExAws.Request.JSON.success_t | no_return
  def get_hostname_suggestion!(client, input) do
    case get_hostname_suggestion(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  GrantAccess

  Note:This action can be used only with Windows stacks. Grants RDP access to
  a Windows instance for a specified time period.
  """

  @spec grant_access(client :: ExAws.OpsWorks.t, input :: grant_access_request) :: ExAws.Request.JSON.response_t
  def grant_access(client, input) do
    request(client, "GrantAccess", format_input(input))
  end

  @doc """
  Same as `grant_access/2` but raise on error.
  """
  @spec grant_access!(client :: ExAws.OpsWorks.t, input :: grant_access_request) :: ExAws.Request.JSON.success_t | no_return
  def grant_access!(client, input) do
    case grant_access(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RebootInstance

  Reboots a specified instance. For more information, see [Starting,
  Stopping, and Rebooting
  Instances](http://docs.aws.amazon.com/opsworks/latest/userguide/workinginstances-starting.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec reboot_instance(client :: ExAws.OpsWorks.t, input :: reboot_instance_request) :: ExAws.Request.JSON.response_t
  def reboot_instance(client, input) do
    request(client, "RebootInstance", format_input(input))
  end

  @doc """
  Same as `reboot_instance/2` but raise on error.
  """
  @spec reboot_instance!(client :: ExAws.OpsWorks.t, input :: reboot_instance_request) :: ExAws.Request.JSON.success_t | no_return
  def reboot_instance!(client, input) do
    case reboot_instance(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RegisterEcsCluster

  Registers a specified Amazon ECS cluster with a stack. You can register
  only one cluster with a stack. A cluster can be registered with only one
  stack. For more information, see [ Resource
  Management](http://docs.aws.amazon.com/opsworks/latest/userguide/workinglayers-ecscluster.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [ Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec register_ecs_cluster(client :: ExAws.OpsWorks.t, input :: register_ecs_cluster_request) :: ExAws.Request.JSON.response_t
  def register_ecs_cluster(client, input) do
    request(client, "RegisterEcsCluster", format_input(input))
  end

  @doc """
  Same as `register_ecs_cluster/2` but raise on error.
  """
  @spec register_ecs_cluster!(client :: ExAws.OpsWorks.t, input :: register_ecs_cluster_request) :: ExAws.Request.JSON.success_t | no_return
  def register_ecs_cluster!(client, input) do
    case register_ecs_cluster(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RegisterElasticIp

  Registers an Elastic IP address with a specified stack. An address can be
  registered with only one stack at a time. If the address is already
  registered, you must first deregister it by calling `DeregisterElasticIp`.
  For more information, see [Resource
  Management](http://docs.aws.amazon.com/opsworks/latest/userguide/resources.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec register_elastic_ip(client :: ExAws.OpsWorks.t, input :: register_elastic_ip_request) :: ExAws.Request.JSON.response_t
  def register_elastic_ip(client, input) do
    request(client, "RegisterElasticIp", format_input(input))
  end

  @doc """
  Same as `register_elastic_ip/2` but raise on error.
  """
  @spec register_elastic_ip!(client :: ExAws.OpsWorks.t, input :: register_elastic_ip_request) :: ExAws.Request.JSON.success_t | no_return
  def register_elastic_ip!(client, input) do
    case register_elastic_ip(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RegisterInstance

  Registers instances with a specified stack that were created outside of AWS
  OpsWorks.

  Note:We do not recommend using this action to register instances. The
  complete registration operation has two primary steps, installing the AWS
  OpsWorks agent on the instance and registering the instance with the stack.
  `RegisterInstance` handles only the second step. You should instead use the
  AWS CLI `register` command, which performs the entire registration
  operation. For more information, see [ Registering an Instance with an AWS
  OpsWorks
  Stack](http://docs.aws.amazon.com/opsworks/latest/userguide/registered-instances-register.html).
  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec register_instance(client :: ExAws.OpsWorks.t, input :: register_instance_request) :: ExAws.Request.JSON.response_t
  def register_instance(client, input) do
    request(client, "RegisterInstance", format_input(input))
  end

  @doc """
  Same as `register_instance/2` but raise on error.
  """
  @spec register_instance!(client :: ExAws.OpsWorks.t, input :: register_instance_request) :: ExAws.Request.JSON.success_t | no_return
  def register_instance!(client, input) do
    case register_instance(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RegisterRdsDbInstance

  Registers an Amazon RDS instance with a stack.

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec register_rds_db_instance(client :: ExAws.OpsWorks.t, input :: register_rds_db_instance_request) :: ExAws.Request.JSON.response_t
  def register_rds_db_instance(client, input) do
    request(client, "RegisterRdsDbInstance", format_input(input))
  end

  @doc """
  Same as `register_rds_db_instance/2` but raise on error.
  """
  @spec register_rds_db_instance!(client :: ExAws.OpsWorks.t, input :: register_rds_db_instance_request) :: ExAws.Request.JSON.success_t | no_return
  def register_rds_db_instance!(client, input) do
    case register_rds_db_instance(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RegisterVolume

  Registers an Amazon EBS volume with a specified stack. A volume can be
  registered with only one stack at a time. If the volume is already
  registered, you must first deregister it by calling `DeregisterVolume`. For
  more information, see [Resource
  Management](http://docs.aws.amazon.com/opsworks/latest/userguide/resources.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec register_volume(client :: ExAws.OpsWorks.t, input :: register_volume_request) :: ExAws.Request.JSON.response_t
  def register_volume(client, input) do
    request(client, "RegisterVolume", format_input(input))
  end

  @doc """
  Same as `register_volume/2` but raise on error.
  """
  @spec register_volume!(client :: ExAws.OpsWorks.t, input :: register_volume_request) :: ExAws.Request.JSON.success_t | no_return
  def register_volume!(client, input) do
    case register_volume(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  SetLoadBasedAutoScaling

  Specify the load-based auto scaling configuration for a specified layer.
  For more information, see [Managing Load with Time-based and Load-based
  Instances](http://docs.aws.amazon.com/opsworks/latest/userguide/workinginstances-autoscaling.html).

  Note: To use load-based auto scaling, you must create a set of load-based
  auto scaling instances. Load-based auto scaling operates only on the
  instances from that set, so you must ensure that you have created enough
  instances to handle the maximum anticipated load.

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec set_load_based_auto_scaling(client :: ExAws.OpsWorks.t, input :: set_load_based_auto_scaling_request) :: ExAws.Request.JSON.response_t
  def set_load_based_auto_scaling(client, input) do
    request(client, "SetLoadBasedAutoScaling", format_input(input))
  end

  @doc """
  Same as `set_load_based_auto_scaling/2` but raise on error.
  """
  @spec set_load_based_auto_scaling!(client :: ExAws.OpsWorks.t, input :: set_load_based_auto_scaling_request) :: ExAws.Request.JSON.success_t | no_return
  def set_load_based_auto_scaling!(client, input) do
    case set_load_based_auto_scaling(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  SetPermission

  Specifies a user's permissions. For more information, see [Security and
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/workingsecurity.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec set_permission(client :: ExAws.OpsWorks.t, input :: set_permission_request) :: ExAws.Request.JSON.response_t
  def set_permission(client, input) do
    request(client, "SetPermission", format_input(input))
  end

  @doc """
  Same as `set_permission/2` but raise on error.
  """
  @spec set_permission!(client :: ExAws.OpsWorks.t, input :: set_permission_request) :: ExAws.Request.JSON.success_t | no_return
  def set_permission!(client, input) do
    case set_permission(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  SetTimeBasedAutoScaling

  Specify the time-based auto scaling configuration for a specified instance.
  For more information, see [Managing Load with Time-based and Load-based
  Instances](http://docs.aws.amazon.com/opsworks/latest/userguide/workinginstances-autoscaling.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec set_time_based_auto_scaling(client :: ExAws.OpsWorks.t, input :: set_time_based_auto_scaling_request) :: ExAws.Request.JSON.response_t
  def set_time_based_auto_scaling(client, input) do
    request(client, "SetTimeBasedAutoScaling", format_input(input))
  end

  @doc """
  Same as `set_time_based_auto_scaling/2` but raise on error.
  """
  @spec set_time_based_auto_scaling!(client :: ExAws.OpsWorks.t, input :: set_time_based_auto_scaling_request) :: ExAws.Request.JSON.success_t | no_return
  def set_time_based_auto_scaling!(client, input) do
    case set_time_based_auto_scaling(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  StartInstance

  Starts a specified instance. For more information, see [Starting, Stopping,
  and Rebooting
  Instances](http://docs.aws.amazon.com/opsworks/latest/userguide/workinginstances-starting.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec start_instance(client :: ExAws.OpsWorks.t, input :: start_instance_request) :: ExAws.Request.JSON.response_t
  def start_instance(client, input) do
    request(client, "StartInstance", format_input(input))
  end

  @doc """
  Same as `start_instance/2` but raise on error.
  """
  @spec start_instance!(client :: ExAws.OpsWorks.t, input :: start_instance_request) :: ExAws.Request.JSON.success_t | no_return
  def start_instance!(client, input) do
    case start_instance(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  StartStack

  Starts a stack's instances.

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec start_stack(client :: ExAws.OpsWorks.t, input :: start_stack_request) :: ExAws.Request.JSON.response_t
  def start_stack(client, input) do
    request(client, "StartStack", format_input(input))
  end

  @doc """
  Same as `start_stack/2` but raise on error.
  """
  @spec start_stack!(client :: ExAws.OpsWorks.t, input :: start_stack_request) :: ExAws.Request.JSON.success_t | no_return
  def start_stack!(client, input) do
    case start_stack(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  StopInstance

  Stops a specified instance. When you stop a standard instance, the data
  disappears and must be reinstalled when you restart the instance. You can
  stop an Amazon EBS-backed instance without losing data. For more
  information, see [Starting, Stopping, and Rebooting
  Instances](http://docs.aws.amazon.com/opsworks/latest/userguide/workinginstances-starting.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec stop_instance(client :: ExAws.OpsWorks.t, input :: stop_instance_request) :: ExAws.Request.JSON.response_t
  def stop_instance(client, input) do
    request(client, "StopInstance", format_input(input))
  end

  @doc """
  Same as `stop_instance/2` but raise on error.
  """
  @spec stop_instance!(client :: ExAws.OpsWorks.t, input :: stop_instance_request) :: ExAws.Request.JSON.success_t | no_return
  def stop_instance!(client, input) do
    case stop_instance(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  StopStack

  Stops a specified stack.

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec stop_stack(client :: ExAws.OpsWorks.t, input :: stop_stack_request) :: ExAws.Request.JSON.response_t
  def stop_stack(client, input) do
    request(client, "StopStack", format_input(input))
  end

  @doc """
  Same as `stop_stack/2` but raise on error.
  """
  @spec stop_stack!(client :: ExAws.OpsWorks.t, input :: stop_stack_request) :: ExAws.Request.JSON.success_t | no_return
  def stop_stack!(client, input) do
    case stop_stack(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UnassignInstance

  Unassigns a registered instance from all of it's layers. The instance
  remains in the stack as an unassigned instance and can be assigned to
  another layer, as needed. You cannot use this action with instances that
  were created with AWS OpsWorks.

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec unassign_instance(client :: ExAws.OpsWorks.t, input :: unassign_instance_request) :: ExAws.Request.JSON.response_t
  def unassign_instance(client, input) do
    request(client, "UnassignInstance", format_input(input))
  end

  @doc """
  Same as `unassign_instance/2` but raise on error.
  """
  @spec unassign_instance!(client :: ExAws.OpsWorks.t, input :: unassign_instance_request) :: ExAws.Request.JSON.success_t | no_return
  def unassign_instance!(client, input) do
    case unassign_instance(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UnassignVolume

  Unassigns an assigned Amazon EBS volume. The volume remains registered with
  the stack. For more information, see [Resource
  Management](http://docs.aws.amazon.com/opsworks/latest/userguide/resources.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec unassign_volume(client :: ExAws.OpsWorks.t, input :: unassign_volume_request) :: ExAws.Request.JSON.response_t
  def unassign_volume(client, input) do
    request(client, "UnassignVolume", format_input(input))
  end

  @doc """
  Same as `unassign_volume/2` but raise on error.
  """
  @spec unassign_volume!(client :: ExAws.OpsWorks.t, input :: unassign_volume_request) :: ExAws.Request.JSON.success_t | no_return
  def unassign_volume!(client, input) do
    case unassign_volume(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateApp

  Updates a specified app.

  **Required Permissions**: To use this action, an IAM user must have a
  Deploy or Manage permissions level for the stack, or an attached policy
  that explicitly grants permissions. For more information on user
  permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec update_app(client :: ExAws.OpsWorks.t, input :: update_app_request) :: ExAws.Request.JSON.response_t
  def update_app(client, input) do
    request(client, "UpdateApp", format_input(input))
  end

  @doc """
  Same as `update_app/2` but raise on error.
  """
  @spec update_app!(client :: ExAws.OpsWorks.t, input :: update_app_request) :: ExAws.Request.JSON.success_t | no_return
  def update_app!(client, input) do
    case update_app(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateElasticIp

  Updates a registered Elastic IP address's name. For more information, see
  [Resource
  Management](http://docs.aws.amazon.com/opsworks/latest/userguide/resources.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec update_elastic_ip(client :: ExAws.OpsWorks.t, input :: update_elastic_ip_request) :: ExAws.Request.JSON.response_t
  def update_elastic_ip(client, input) do
    request(client, "UpdateElasticIp", format_input(input))
  end

  @doc """
  Same as `update_elastic_ip/2` but raise on error.
  """
  @spec update_elastic_ip!(client :: ExAws.OpsWorks.t, input :: update_elastic_ip_request) :: ExAws.Request.JSON.success_t | no_return
  def update_elastic_ip!(client, input) do
    case update_elastic_ip(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateInstance

  Updates a specified instance.

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec update_instance(client :: ExAws.OpsWorks.t, input :: update_instance_request) :: ExAws.Request.JSON.response_t
  def update_instance(client, input) do
    request(client, "UpdateInstance", format_input(input))
  end

  @doc """
  Same as `update_instance/2` but raise on error.
  """
  @spec update_instance!(client :: ExAws.OpsWorks.t, input :: update_instance_request) :: ExAws.Request.JSON.success_t | no_return
  def update_instance!(client, input) do
    case update_instance(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateLayer

  Updates a specified layer.

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec update_layer(client :: ExAws.OpsWorks.t, input :: update_layer_request) :: ExAws.Request.JSON.response_t
  def update_layer(client, input) do
    request(client, "UpdateLayer", format_input(input))
  end

  @doc """
  Same as `update_layer/2` but raise on error.
  """
  @spec update_layer!(client :: ExAws.OpsWorks.t, input :: update_layer_request) :: ExAws.Request.JSON.success_t | no_return
  def update_layer!(client, input) do
    case update_layer(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateMyUserProfile

  Updates a user's SSH public key.

  **Required Permissions**: To use this action, an IAM user must have
  self-management enabled or an attached policy that explicitly grants
  permissions. For more information on user permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec update_my_user_profile(client :: ExAws.OpsWorks.t, input :: update_my_user_profile_request) :: ExAws.Request.JSON.response_t
  def update_my_user_profile(client, input) do
    request(client, "UpdateMyUserProfile", format_input(input))
  end

  @doc """
  Same as `update_my_user_profile/2` but raise on error.
  """
  @spec update_my_user_profile!(client :: ExAws.OpsWorks.t, input :: update_my_user_profile_request) :: ExAws.Request.JSON.success_t | no_return
  def update_my_user_profile!(client, input) do
    case update_my_user_profile(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateRdsDbInstance

  Updates an Amazon RDS instance.

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec update_rds_db_instance(client :: ExAws.OpsWorks.t, input :: update_rds_db_instance_request) :: ExAws.Request.JSON.response_t
  def update_rds_db_instance(client, input) do
    request(client, "UpdateRdsDbInstance", format_input(input))
  end

  @doc """
  Same as `update_rds_db_instance/2` but raise on error.
  """
  @spec update_rds_db_instance!(client :: ExAws.OpsWorks.t, input :: update_rds_db_instance_request) :: ExAws.Request.JSON.success_t | no_return
  def update_rds_db_instance!(client, input) do
    case update_rds_db_instance(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateStack

  Updates a specified stack.

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec update_stack(client :: ExAws.OpsWorks.t, input :: update_stack_request) :: ExAws.Request.JSON.response_t
  def update_stack(client, input) do
    request(client, "UpdateStack", format_input(input))
  end

  @doc """
  Same as `update_stack/2` but raise on error.
  """
  @spec update_stack!(client :: ExAws.OpsWorks.t, input :: update_stack_request) :: ExAws.Request.JSON.success_t | no_return
  def update_stack!(client, input) do
    case update_stack(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateUserProfile

  Updates a specified user profile.

  **Required Permissions**: To use this action, an IAM user must have an
  attached policy that explicitly grants permissions. For more information on
  user permissions, see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec update_user_profile(client :: ExAws.OpsWorks.t, input :: update_user_profile_request) :: ExAws.Request.JSON.response_t
  def update_user_profile(client, input) do
    request(client, "UpdateUserProfile", format_input(input))
  end

  @doc """
  Same as `update_user_profile/2` but raise on error.
  """
  @spec update_user_profile!(client :: ExAws.OpsWorks.t, input :: update_user_profile_request) :: ExAws.Request.JSON.success_t | no_return
  def update_user_profile!(client, input) do
    case update_user_profile(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  UpdateVolume

  Updates an Amazon EBS volume's name or mount point. For more information,
  see [Resource
  Management](http://docs.aws.amazon.com/opsworks/latest/userguide/resources.html).

  **Required Permissions**: To use this action, an IAM user must have a
  Manage permissions level for the stack, or an attached policy that
  explicitly grants permissions. For more information on user permissions,
  see [Managing User
  Permissions](http://docs.aws.amazon.com/opsworks/latest/userguide/opsworks-security-users.html).
  """

  @spec update_volume(client :: ExAws.OpsWorks.t, input :: update_volume_request) :: ExAws.Request.JSON.response_t
  def update_volume(client, input) do
    request(client, "UpdateVolume", format_input(input))
  end

  @doc """
  Same as `update_volume/2` but raise on error.
  """
  @spec update_volume!(client :: ExAws.OpsWorks.t, input :: update_volume_request) :: ExAws.Request.JSON.success_t | no_return
  def update_volume!(client, input) do
    case update_volume(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  defp request(%{__struct__: client_module} = client, action, input) do
    apply(client_module, :request, [client, action, input])
  end
end
