defmodule ExAws.Redshift.Core do
  @actions [
    "AuthorizeClusterSecurityGroupIngress",
    "AuthorizeSnapshotAccess",
    "CopyClusterSnapshot",
    "CreateCluster",
    "CreateClusterParameterGroup",
    "CreateClusterSecurityGroup",
    "CreateClusterSnapshot",
    "CreateClusterSubnetGroup",
    "CreateEventSubscription",
    "CreateHsmClientCertificate",
    "CreateHsmConfiguration",
    "CreateSnapshotCopyGrant",
    "CreateTags",
    "DeleteCluster",
    "DeleteClusterParameterGroup",
    "DeleteClusterSecurityGroup",
    "DeleteClusterSnapshot",
    "DeleteClusterSubnetGroup",
    "DeleteEventSubscription",
    "DeleteHsmClientCertificate",
    "DeleteHsmConfiguration",
    "DeleteSnapshotCopyGrant",
    "DeleteTags",
    "DescribeClusterParameterGroups",
    "DescribeClusterParameters",
    "DescribeClusterSecurityGroups",
    "DescribeClusterSnapshots",
    "DescribeClusterSubnetGroups",
    "DescribeClusterVersions",
    "DescribeClusters",
    "DescribeDefaultClusterParameters",
    "DescribeEventCategories",
    "DescribeEventSubscriptions",
    "DescribeEvents",
    "DescribeHsmClientCertificates",
    "DescribeHsmConfigurations",
    "DescribeLoggingStatus",
    "DescribeOrderableClusterOptions",
    "DescribeReservedNodeOfferings",
    "DescribeReservedNodes",
    "DescribeResize",
    "DescribeSnapshotCopyGrants",
    "DescribeTags",
    "DisableLogging",
    "DisableSnapshotCopy",
    "EnableLogging",
    "EnableSnapshotCopy",
    "ModifyCluster",
    "ModifyClusterParameterGroup",
    "ModifyClusterSubnetGroup",
    "ModifyEventSubscription",
    "ModifySnapshotCopyRetentionPeriod",
    "PurchaseReservedNodeOffering",
    "RebootCluster",
    "ResetClusterParameterGroup",
    "RestoreFromClusterSnapshot",
    "RevokeClusterSecurityGroupIngress",
    "RevokeSnapshotAccess",
    "RotateEncryptionKey"]

  @moduledoc """
  ## Amazon Redshift

  Amazon Redshift

  **Overview** This is an interface reference for Amazon Redshift. It
  contains documentation for one of the programming or command line
  interfaces you can use to manage Amazon Redshift clusters. Note that Amazon
  Redshift is asynchronous, which means that some interfaces may require
  techniques, such as polling or asynchronous callback handlers, to determine
  when a command has been applied. In this reference, the parameter
  descriptions indicate whether a change is applied immediately, on the next
  instance reboot, or during the next maintenance window. For a summary of
  the Amazon Redshift cluster management interfaces, go to [Using the Amazon
  Redshift Management Interfaces
  ](http://docs.aws.amazon.com/redshift/latest/mgmt/using-aws-sdk.html).

  Amazon Redshift manages all the work of setting up, operating, and scaling
  a data warehouse: provisioning capacity, monitoring and backing up the
  cluster, and applying patches and upgrades to the Amazon Redshift engine.
  You can focus on using your data to acquire new insights for your business
  and customers.

  If you are a first-time user of Amazon Redshift, we recommend that you
  begin by reading the The [Amazon Redshift Getting Started
  Guide](http://docs.aws.amazon.com/redshift/latest/gsg/getting-started.html)

  If you are a database developer, the [Amazon Redshift Database Developer
  Guide](http://docs.aws.amazon.com/redshift/latest/dg/welcome.html) explains
  how to design, build, query, and maintain the databases that make up your
  data warehouse.
  """

  @type access_to_snapshot_denied_fault :: [
  ]

  @type account_with_restore_access :: [
    account_id: binary,
  ]

  @type accounts_with_restore_access_list :: [account_with_restore_access]

  @type authorization_already_exists_fault :: [
  ]

  @type authorization_not_found_fault :: [
  ]

  @type authorization_quota_exceeded_fault :: [
  ]

  @type authorize_cluster_security_group_ingress_message :: [
    cidrip: binary,
    cluster_security_group_name: binary,
    e_c2_security_group_name: binary,
    e_c2_security_group_owner_id: binary,
  ]

  @type authorize_cluster_security_group_ingress_result :: [
    cluster_security_group: cluster_security_group,
  ]

  @type authorize_snapshot_access_message :: [
    account_with_restore_access: binary,
    snapshot_cluster_identifier: binary,
    snapshot_identifier: binary,
  ]

  @type authorize_snapshot_access_result :: [
    snapshot: snapshot,
  ]

  @type availability_zone :: [
    name: binary,
  ]

  @type availability_zone_list :: [availability_zone]

  @type boolean_optional :: boolean

  @type bucket_not_found_fault :: [
  ]

  @type cluster :: [
    allow_version_upgrade: boolean,
    automated_snapshot_retention_period: integer,
    availability_zone: binary,
    cluster_create_time: t_stamp,
    cluster_identifier: binary,
    cluster_nodes: cluster_nodes_list,
    cluster_parameter_groups: cluster_parameter_group_status_list,
    cluster_public_key: binary,
    cluster_revision_number: binary,
    cluster_security_groups: cluster_security_group_membership_list,
    cluster_snapshot_copy_status: cluster_snapshot_copy_status,
    cluster_status: binary,
    cluster_subnet_group_name: binary,
    cluster_version: binary,
    db_name: binary,
    elastic_ip_status: elastic_ip_status,
    encrypted: boolean,
    endpoint: endpoint,
    hsm_status: hsm_status,
    kms_key_id: binary,
    master_username: binary,
    modify_status: binary,
    node_type: binary,
    number_of_nodes: integer,
    pending_modified_values: pending_modified_values,
    preferred_maintenance_window: binary,
    publicly_accessible: boolean,
    restore_status: restore_status,
    tags: tag_list,
    vpc_id: binary,
    vpc_security_groups: vpc_security_group_membership_list,
  ]

  @type cluster_already_exists_fault :: [
  ]

  @type cluster_list :: [cluster]

  @type cluster_node :: [
    node_role: binary,
    private_ip_address: binary,
    public_ip_address: binary,
  ]

  @type cluster_nodes_list :: [cluster_node]

  @type cluster_not_found_fault :: [
  ]

  @type cluster_parameter_group :: [
    description: binary,
    parameter_group_family: binary,
    parameter_group_name: binary,
    tags: tag_list,
  ]

  @type cluster_parameter_group_already_exists_fault :: [
  ]

  @type cluster_parameter_group_details :: [
    marker: binary,
    parameters: parameters_list,
  ]

  @type cluster_parameter_group_name_message :: [
    parameter_group_name: binary,
    parameter_group_status: binary,
  ]

  @type cluster_parameter_group_not_found_fault :: [
  ]

  @type cluster_parameter_group_quota_exceeded_fault :: [
  ]

  @type cluster_parameter_group_status :: [
    cluster_parameter_status_list: cluster_parameter_status_list,
    parameter_apply_status: binary,
    parameter_group_name: binary,
  ]

  @type cluster_parameter_group_status_list :: [cluster_parameter_group_status]

  @type cluster_parameter_groups_message :: [
    marker: binary,
    parameter_groups: parameter_group_list,
  ]

  @type cluster_parameter_status :: [
    parameter_apply_error_description: binary,
    parameter_apply_status: binary,
    parameter_name: binary,
  ]

  @type cluster_parameter_status_list :: [cluster_parameter_status]

  @type cluster_quota_exceeded_fault :: [
  ]

  @type cluster_security_group :: [
    cluster_security_group_name: binary,
    description: binary,
    e_c2_security_groups: ec2_security_group_list,
    ip_ranges: ip_range_list,
    tags: tag_list,
  ]

  @type cluster_security_group_already_exists_fault :: [
  ]

  @type cluster_security_group_membership :: [
    cluster_security_group_name: binary,
    status: binary,
  ]

  @type cluster_security_group_membership_list :: [cluster_security_group_membership]

  @type cluster_security_group_message :: [
    cluster_security_groups: cluster_security_groups,
    marker: binary,
  ]

  @type cluster_security_group_name_list :: [binary]

  @type cluster_security_group_not_found_fault :: [
  ]

  @type cluster_security_group_quota_exceeded_fault :: [
  ]

  @type cluster_security_groups :: [cluster_security_group]

  @type cluster_snapshot_already_exists_fault :: [
  ]

  @type cluster_snapshot_copy_status :: [
    destination_region: binary,
    retention_period: long,
    snapshot_copy_grant_name: binary,
  ]

  @type cluster_snapshot_not_found_fault :: [
  ]

  @type cluster_snapshot_quota_exceeded_fault :: [
  ]

  @type cluster_subnet_group :: [
    cluster_subnet_group_name: binary,
    description: binary,
    subnet_group_status: binary,
    subnets: subnet_list,
    tags: tag_list,
    vpc_id: binary,
  ]

  @type cluster_subnet_group_already_exists_fault :: [
  ]

  @type cluster_subnet_group_message :: [
    cluster_subnet_groups: cluster_subnet_groups,
    marker: binary,
  ]

  @type cluster_subnet_group_not_found_fault :: [
  ]

  @type cluster_subnet_group_quota_exceeded_fault :: [
  ]

  @type cluster_subnet_groups :: [cluster_subnet_group]

  @type cluster_subnet_quota_exceeded_fault :: [
  ]

  @type cluster_version :: [
    cluster_parameter_group_family: binary,
    cluster_version: binary,
    description: binary,
  ]

  @type cluster_version_list :: [cluster_version]

  @type cluster_versions_message :: [
    cluster_versions: cluster_version_list,
    marker: binary,
  ]

  @type clusters_message :: [
    clusters: cluster_list,
    marker: binary,
  ]

  @type copy_cluster_snapshot_message :: [
    source_snapshot_cluster_identifier: binary,
    source_snapshot_identifier: binary,
    target_snapshot_identifier: binary,
  ]

  @type copy_cluster_snapshot_result :: [
    snapshot: snapshot,
  ]

  @type copy_to_region_disabled_fault :: [
  ]

  @type create_cluster_message :: [
    allow_version_upgrade: boolean_optional,
    automated_snapshot_retention_period: integer_optional,
    availability_zone: binary,
    cluster_identifier: binary,
    cluster_parameter_group_name: binary,
    cluster_security_groups: cluster_security_group_name_list,
    cluster_subnet_group_name: binary,
    cluster_type: binary,
    cluster_version: binary,
    db_name: binary,
    elastic_ip: binary,
    encrypted: boolean_optional,
    hsm_client_certificate_identifier: binary,
    hsm_configuration_identifier: binary,
    kms_key_id: binary,
    master_user_password: binary,
    master_username: binary,
    node_type: binary,
    number_of_nodes: integer_optional,
    port: integer_optional,
    preferred_maintenance_window: binary,
    publicly_accessible: boolean_optional,
    tags: tag_list,
    vpc_security_group_ids: vpc_security_group_id_list,
  ]

  @type create_cluster_parameter_group_message :: [
    description: binary,
    parameter_group_family: binary,
    parameter_group_name: binary,
    tags: tag_list,
  ]

  @type create_cluster_parameter_group_result :: [
    cluster_parameter_group: cluster_parameter_group,
  ]

  @type create_cluster_result :: [
    cluster: cluster,
  ]

  @type create_cluster_security_group_message :: [
    cluster_security_group_name: binary,
    description: binary,
    tags: tag_list,
  ]

  @type create_cluster_security_group_result :: [
    cluster_security_group: cluster_security_group,
  ]

  @type create_cluster_snapshot_message :: [
    cluster_identifier: binary,
    snapshot_identifier: binary,
    tags: tag_list,
  ]

  @type create_cluster_snapshot_result :: [
    snapshot: snapshot,
  ]

  @type create_cluster_subnet_group_message :: [
    cluster_subnet_group_name: binary,
    description: binary,
    subnet_ids: subnet_identifier_list,
    tags: tag_list,
  ]

  @type create_cluster_subnet_group_result :: [
    cluster_subnet_group: cluster_subnet_group,
  ]

  @type create_event_subscription_message :: [
    enabled: boolean_optional,
    event_categories: event_categories_list,
    severity: binary,
    sns_topic_arn: binary,
    source_ids: source_ids_list,
    source_type: binary,
    subscription_name: binary,
    tags: tag_list,
  ]

  @type create_event_subscription_result :: [
    event_subscription: event_subscription,
  ]

  @type create_hsm_client_certificate_message :: [
    hsm_client_certificate_identifier: binary,
    tags: tag_list,
  ]

  @type create_hsm_client_certificate_result :: [
    hsm_client_certificate: hsm_client_certificate,
  ]

  @type create_hsm_configuration_message :: [
    description: binary,
    hsm_configuration_identifier: binary,
    hsm_ip_address: binary,
    hsm_partition_name: binary,
    hsm_partition_password: binary,
    hsm_server_public_certificate: binary,
    tags: tag_list,
  ]

  @type create_hsm_configuration_result :: [
    hsm_configuration: hsm_configuration,
  ]

  @type create_snapshot_copy_grant_message :: [
    kms_key_id: binary,
    snapshot_copy_grant_name: binary,
    tags: tag_list,
  ]

  @type create_snapshot_copy_grant_result :: [
    snapshot_copy_grant: snapshot_copy_grant,
  ]

  @type create_tags_message :: [
    resource_name: binary,
    tags: tag_list,
  ]

  @type default_cluster_parameters :: [
    marker: binary,
    parameter_group_family: binary,
    parameters: parameters_list,
  ]

  @type delete_cluster_message :: [
    cluster_identifier: binary,
    final_cluster_snapshot_identifier: binary,
    skip_final_cluster_snapshot: boolean,
  ]

  @type delete_cluster_parameter_group_message :: [
    parameter_group_name: binary,
  ]

  @type delete_cluster_result :: [
    cluster: cluster,
  ]

  @type delete_cluster_security_group_message :: [
    cluster_security_group_name: binary,
  ]

  @type delete_cluster_snapshot_message :: [
    snapshot_cluster_identifier: binary,
    snapshot_identifier: binary,
  ]

  @type delete_cluster_snapshot_result :: [
    snapshot: snapshot,
  ]

  @type delete_cluster_subnet_group_message :: [
    cluster_subnet_group_name: binary,
  ]

  @type delete_event_subscription_message :: [
    subscription_name: binary,
  ]

  @type delete_hsm_client_certificate_message :: [
    hsm_client_certificate_identifier: binary,
  ]

  @type delete_hsm_configuration_message :: [
    hsm_configuration_identifier: binary,
  ]

  @type delete_snapshot_copy_grant_message :: [
    snapshot_copy_grant_name: binary,
  ]

  @type delete_tags_message :: [
    resource_name: binary,
    tag_keys: tag_key_list,
  ]

  @type describe_cluster_parameter_groups_message :: [
    marker: binary,
    max_records: integer_optional,
    parameter_group_name: binary,
    tag_keys: tag_key_list,
    tag_values: tag_value_list,
  ]

  @type describe_cluster_parameters_message :: [
    marker: binary,
    max_records: integer_optional,
    parameter_group_name: binary,
    source: binary,
  ]

  @type describe_cluster_security_groups_message :: [
    cluster_security_group_name: binary,
    marker: binary,
    max_records: integer_optional,
    tag_keys: tag_key_list,
    tag_values: tag_value_list,
  ]

  @type describe_cluster_snapshots_message :: [
    cluster_identifier: binary,
    end_time: t_stamp,
    marker: binary,
    max_records: integer_optional,
    owner_account: binary,
    snapshot_identifier: binary,
    snapshot_type: binary,
    start_time: t_stamp,
    tag_keys: tag_key_list,
    tag_values: tag_value_list,
  ]

  @type describe_cluster_subnet_groups_message :: [
    cluster_subnet_group_name: binary,
    marker: binary,
    max_records: integer_optional,
    tag_keys: tag_key_list,
    tag_values: tag_value_list,
  ]

  @type describe_cluster_versions_message :: [
    cluster_parameter_group_family: binary,
    cluster_version: binary,
    marker: binary,
    max_records: integer_optional,
  ]

  @type describe_clusters_message :: [
    cluster_identifier: binary,
    marker: binary,
    max_records: integer_optional,
    tag_keys: tag_key_list,
    tag_values: tag_value_list,
  ]

  @type describe_default_cluster_parameters_message :: [
    marker: binary,
    max_records: integer_optional,
    parameter_group_family: binary,
  ]

  @type describe_default_cluster_parameters_result :: [
    default_cluster_parameters: default_cluster_parameters,
  ]

  @type describe_event_categories_message :: [
    source_type: binary,
  ]

  @type describe_event_subscriptions_message :: [
    marker: binary,
    max_records: integer_optional,
    subscription_name: binary,
  ]

  @type describe_events_message :: [
    duration: integer_optional,
    end_time: t_stamp,
    marker: binary,
    max_records: integer_optional,
    source_identifier: binary,
    source_type: source_type,
    start_time: t_stamp,
  ]

  @type describe_hsm_client_certificates_message :: [
    hsm_client_certificate_identifier: binary,
    marker: binary,
    max_records: integer_optional,
    tag_keys: tag_key_list,
    tag_values: tag_value_list,
  ]

  @type describe_hsm_configurations_message :: [
    hsm_configuration_identifier: binary,
    marker: binary,
    max_records: integer_optional,
    tag_keys: tag_key_list,
    tag_values: tag_value_list,
  ]

  @type describe_logging_status_message :: [
    cluster_identifier: binary,
  ]

  @type describe_orderable_cluster_options_message :: [
    cluster_version: binary,
    marker: binary,
    max_records: integer_optional,
    node_type: binary,
  ]

  @type describe_reserved_node_offerings_message :: [
    marker: binary,
    max_records: integer_optional,
    reserved_node_offering_id: binary,
  ]

  @type describe_reserved_nodes_message :: [
    marker: binary,
    max_records: integer_optional,
    reserved_node_id: binary,
  ]

  @type describe_resize_message :: [
    cluster_identifier: binary,
  ]

  @type describe_snapshot_copy_grants_message :: [
    marker: binary,
    max_records: integer_optional,
    snapshot_copy_grant_name: binary,
    tag_keys: tag_key_list,
    tag_values: tag_value_list,
  ]

  @type describe_tags_message :: [
    marker: binary,
    max_records: integer_optional,
    resource_name: binary,
    resource_type: binary,
    tag_keys: tag_key_list,
    tag_values: tag_value_list,
  ]

  @type disable_logging_message :: [
    cluster_identifier: binary,
  ]

  @type disable_snapshot_copy_message :: [
    cluster_identifier: binary,
  ]

  @type disable_snapshot_copy_result :: [
    cluster: cluster,
  ]

  @type double :: float

  @type double_optional :: float

  @type ec2_security_group :: [
    e_c2_security_group_name: binary,
    e_c2_security_group_owner_id: binary,
    status: binary,
    tags: tag_list,
  ]

  @type ec2_security_group_list :: [ec2_security_group]

  @type elastic_ip_status :: [
    elastic_ip: binary,
    status: binary,
  ]

  @type enable_logging_message :: [
    bucket_name: binary,
    cluster_identifier: binary,
    s3_key_prefix: binary,
  ]

  @type enable_snapshot_copy_message :: [
    cluster_identifier: binary,
    destination_region: binary,
    retention_period: integer_optional,
    snapshot_copy_grant_name: binary,
  ]

  @type enable_snapshot_copy_result :: [
    cluster: cluster,
  ]

  @type endpoint :: [
    address: binary,
    port: integer,
  ]

  @type event :: [
    date: t_stamp,
    event_categories: event_categories_list,
    event_id: binary,
    message: binary,
    severity: binary,
    source_identifier: binary,
    source_type: source_type,
  ]

  @type event_categories_list :: [binary]

  @type event_categories_map :: [
    events: event_info_map_list,
    source_type: binary,
  ]

  @type event_categories_map_list :: [event_categories_map]

  @type event_categories_message :: [
    event_categories_map_list: event_categories_map_list,
  ]

  @type event_info_map :: [
    event_categories: event_categories_list,
    event_description: binary,
    event_id: binary,
    severity: binary,
  ]

  @type event_info_map_list :: [event_info_map]

  @type event_list :: [event]

  @type event_subscription :: [
    cust_subscription_id: binary,
    customer_aws_id: binary,
    enabled: boolean,
    event_categories_list: event_categories_list,
    severity: binary,
    sns_topic_arn: binary,
    source_ids_list: source_ids_list,
    source_type: binary,
    status: binary,
    subscription_creation_time: t_stamp,
    tags: tag_list,
  ]

  @type event_subscription_quota_exceeded_fault :: [
  ]

  @type event_subscriptions_list :: [event_subscription]

  @type event_subscriptions_message :: [
    event_subscriptions_list: event_subscriptions_list,
    marker: binary,
  ]

  @type events_message :: [
    events: event_list,
    marker: binary,
  ]

  @type hsm_client_certificate :: [
    hsm_client_certificate_identifier: binary,
    hsm_client_certificate_public_key: binary,
    tags: tag_list,
  ]

  @type hsm_client_certificate_already_exists_fault :: [
  ]

  @type hsm_client_certificate_list :: [hsm_client_certificate]

  @type hsm_client_certificate_message :: [
    hsm_client_certificates: hsm_client_certificate_list,
    marker: binary,
  ]

  @type hsm_client_certificate_not_found_fault :: [
  ]

  @type hsm_client_certificate_quota_exceeded_fault :: [
  ]

  @type hsm_configuration :: [
    description: binary,
    hsm_configuration_identifier: binary,
    hsm_ip_address: binary,
    hsm_partition_name: binary,
    tags: tag_list,
  ]

  @type hsm_configuration_already_exists_fault :: [
  ]

  @type hsm_configuration_list :: [hsm_configuration]

  @type hsm_configuration_message :: [
    hsm_configurations: hsm_configuration_list,
    marker: binary,
  ]

  @type hsm_configuration_not_found_fault :: [
  ]

  @type hsm_configuration_quota_exceeded_fault :: [
  ]

  @type hsm_status :: [
    hsm_client_certificate_identifier: binary,
    hsm_configuration_identifier: binary,
    status: binary,
  ]

  @type ip_range :: [
    cidrip: binary,
    status: binary,
    tags: tag_list,
  ]

  @type ip_range_list :: [ip_range]

  @type import_tables_completed :: [binary]

  @type import_tables_in_progress :: [binary]

  @type import_tables_not_started :: [binary]

  @type incompatible_orderable_options :: [
  ]

  @type insufficient_cluster_capacity_fault :: [
  ]

  @type insufficient_s3_bucket_policy_fault :: [
  ]

  @type integer_optional :: integer

  @type invalid_cluster_parameter_group_state_fault :: [
  ]

  @type invalid_cluster_security_group_state_fault :: [
  ]

  @type invalid_cluster_snapshot_state_fault :: [
  ]

  @type invalid_cluster_state_fault :: [
  ]

  @type invalid_cluster_subnet_group_state_fault :: [
  ]

  @type invalid_cluster_subnet_state_fault :: [
  ]

  @type invalid_elastic_ip_fault :: [
  ]

  @type invalid_hsm_client_certificate_state_fault :: [
  ]

  @type invalid_hsm_configuration_state_fault :: [
  ]

  @type invalid_restore_fault :: [
  ]

  @type invalid_s3_bucket_name_fault :: [
  ]

  @type invalid_s3_key_prefix_fault :: [
  ]

  @type invalid_snapshot_copy_grant_state_fault :: [
  ]

  @type invalid_subnet :: [
  ]

  @type invalid_subscription_state_fault :: [
  ]

  @type invalid_tag_fault :: [
  ]

  @type invalid_vpc_network_state_fault :: [
  ]

  @type limit_exceeded_fault :: [
  ]

  @type logging_status :: [
    bucket_name: binary,
    last_failure_message: binary,
    last_failure_time: t_stamp,
    last_successful_delivery_time: t_stamp,
    logging_enabled: boolean,
    s3_key_prefix: binary,
  ]

  @type long :: integer

  @type long_optional :: integer

  @type modify_cluster_message :: [
    allow_version_upgrade: boolean_optional,
    automated_snapshot_retention_period: integer_optional,
    cluster_identifier: binary,
    cluster_parameter_group_name: binary,
    cluster_security_groups: cluster_security_group_name_list,
    cluster_type: binary,
    cluster_version: binary,
    hsm_client_certificate_identifier: binary,
    hsm_configuration_identifier: binary,
    master_user_password: binary,
    new_cluster_identifier: binary,
    node_type: binary,
    number_of_nodes: integer_optional,
    preferred_maintenance_window: binary,
    vpc_security_group_ids: vpc_security_group_id_list,
  ]

  @type modify_cluster_parameter_group_message :: [
    parameter_group_name: binary,
    parameters: parameters_list,
  ]

  @type modify_cluster_result :: [
    cluster: cluster,
  ]

  @type modify_cluster_subnet_group_message :: [
    cluster_subnet_group_name: binary,
    description: binary,
    subnet_ids: subnet_identifier_list,
  ]

  @type modify_cluster_subnet_group_result :: [
    cluster_subnet_group: cluster_subnet_group,
  ]

  @type modify_event_subscription_message :: [
    enabled: boolean_optional,
    event_categories: event_categories_list,
    severity: binary,
    sns_topic_arn: binary,
    source_ids: source_ids_list,
    source_type: binary,
    subscription_name: binary,
  ]

  @type modify_event_subscription_result :: [
    event_subscription: event_subscription,
  ]

  @type modify_snapshot_copy_retention_period_message :: [
    cluster_identifier: binary,
    retention_period: integer,
  ]

  @type modify_snapshot_copy_retention_period_result :: [
    cluster: cluster,
  ]

  @type number_of_nodes_per_cluster_limit_exceeded_fault :: [
  ]

  @type number_of_nodes_quota_exceeded_fault :: [
  ]

  @type orderable_cluster_option :: [
    availability_zones: availability_zone_list,
    cluster_type: binary,
    cluster_version: binary,
    node_type: binary,
  ]

  @type orderable_cluster_options_list :: [orderable_cluster_option]

  @type orderable_cluster_options_message :: [
    marker: binary,
    orderable_cluster_options: orderable_cluster_options_list,
  ]

  @type parameter :: [
    allowed_values: binary,
    apply_type: parameter_apply_type,
    data_type: binary,
    description: binary,
    is_modifiable: boolean,
    minimum_engine_version: binary,
    parameter_name: binary,
    parameter_value: binary,
    source: binary,
  ]

  @type parameter_apply_type :: binary

  @type parameter_group_list :: [cluster_parameter_group]

  @type parameters_list :: [parameter]

  @type pending_modified_values :: [
    automated_snapshot_retention_period: integer_optional,
    cluster_identifier: binary,
    cluster_type: binary,
    cluster_version: binary,
    master_user_password: binary,
    node_type: binary,
    number_of_nodes: integer_optional,
  ]

  @type purchase_reserved_node_offering_message :: [
    node_count: integer_optional,
    reserved_node_offering_id: binary,
  ]

  @type purchase_reserved_node_offering_result :: [
    reserved_node: reserved_node,
  ]

  @type reboot_cluster_message :: [
    cluster_identifier: binary,
  ]

  @type reboot_cluster_result :: [
    cluster: cluster,
  ]

  @type recurring_charge :: [
    recurring_charge_amount: double,
    recurring_charge_frequency: binary,
  ]

  @type recurring_charge_list :: [recurring_charge]

  @type reserved_node :: [
    currency_code: binary,
    duration: integer,
    fixed_price: double,
    node_count: integer,
    node_type: binary,
    offering_type: binary,
    recurring_charges: recurring_charge_list,
    reserved_node_id: binary,
    reserved_node_offering_id: binary,
    start_time: t_stamp,
    state: binary,
    usage_price: double,
  ]

  @type reserved_node_already_exists_fault :: [
  ]

  @type reserved_node_list :: [reserved_node]

  @type reserved_node_not_found_fault :: [
  ]

  @type reserved_node_offering :: [
    currency_code: binary,
    duration: integer,
    fixed_price: double,
    node_type: binary,
    offering_type: binary,
    recurring_charges: recurring_charge_list,
    reserved_node_offering_id: binary,
    usage_price: double,
  ]

  @type reserved_node_offering_list :: [reserved_node_offering]

  @type reserved_node_offering_not_found_fault :: [
  ]

  @type reserved_node_offerings_message :: [
    marker: binary,
    reserved_node_offerings: reserved_node_offering_list,
  ]

  @type reserved_node_quota_exceeded_fault :: [
  ]

  @type reserved_nodes_message :: [
    marker: binary,
    reserved_nodes: reserved_node_list,
  ]

  @type reset_cluster_parameter_group_message :: [
    parameter_group_name: binary,
    parameters: parameters_list,
    reset_all_parameters: boolean,
  ]

  @type resize_not_found_fault :: [
  ]

  @type resize_progress_message :: [
    avg_resize_rate_in_mega_bytes_per_second: double_optional,
    elapsed_time_in_seconds: long_optional,
    estimated_time_to_completion_in_seconds: long_optional,
    import_tables_completed: import_tables_completed,
    import_tables_in_progress: import_tables_in_progress,
    import_tables_not_started: import_tables_not_started,
    progress_in_mega_bytes: long_optional,
    status: binary,
    target_cluster_type: binary,
    target_node_type: binary,
    target_number_of_nodes: integer_optional,
    total_resize_data_in_mega_bytes: long_optional,
  ]

  @type resource_not_found_fault :: [
  ]

  @type restorable_node_type_list :: [binary]

  @type restore_from_cluster_snapshot_message :: [
    allow_version_upgrade: boolean_optional,
    automated_snapshot_retention_period: integer_optional,
    availability_zone: binary,
    cluster_identifier: binary,
    cluster_parameter_group_name: binary,
    cluster_security_groups: cluster_security_group_name_list,
    cluster_subnet_group_name: binary,
    elastic_ip: binary,
    hsm_client_certificate_identifier: binary,
    hsm_configuration_identifier: binary,
    kms_key_id: binary,
    node_type: binary,
    owner_account: binary,
    port: integer_optional,
    preferred_maintenance_window: binary,
    publicly_accessible: boolean_optional,
    snapshot_cluster_identifier: binary,
    snapshot_identifier: binary,
    vpc_security_group_ids: vpc_security_group_id_list,
  ]

  @type restore_from_cluster_snapshot_result :: [
    cluster: cluster,
  ]

  @type restore_status :: [
    current_restore_rate_in_mega_bytes_per_second: double,
    elapsed_time_in_seconds: long,
    estimated_time_to_completion_in_seconds: long,
    progress_in_mega_bytes: long,
    snapshot_size_in_mega_bytes: long,
    status: binary,
  ]

  @type revoke_cluster_security_group_ingress_message :: [
    cidrip: binary,
    cluster_security_group_name: binary,
    e_c2_security_group_name: binary,
    e_c2_security_group_owner_id: binary,
  ]

  @type revoke_cluster_security_group_ingress_result :: [
    cluster_security_group: cluster_security_group,
  ]

  @type revoke_snapshot_access_message :: [
    account_with_restore_access: binary,
    snapshot_cluster_identifier: binary,
    snapshot_identifier: binary,
  ]

  @type revoke_snapshot_access_result :: [
    snapshot: snapshot,
  ]

  @type rotate_encryption_key_message :: [
    cluster_identifier: binary,
  ]

  @type rotate_encryption_key_result :: [
    cluster: cluster,
  ]

  @type sns_invalid_topic_fault :: [
  ]

  @type sns_no_authorization_fault :: [
  ]

  @type sns_topic_arn_not_found_fault :: [
  ]

  @type snapshot :: [
    accounts_with_restore_access: accounts_with_restore_access_list,
    actual_incremental_backup_size_in_mega_bytes: double,
    availability_zone: binary,
    backup_progress_in_mega_bytes: double,
    cluster_create_time: t_stamp,
    cluster_identifier: binary,
    cluster_version: binary,
    current_backup_rate_in_mega_bytes_per_second: double,
    db_name: binary,
    elapsed_time_in_seconds: long,
    encrypted: boolean,
    encrypted_with_hsm: boolean,
    estimated_seconds_to_completion: long,
    kms_key_id: binary,
    master_username: binary,
    node_type: binary,
    number_of_nodes: integer,
    owner_account: binary,
    port: integer,
    restorable_node_types: restorable_node_type_list,
    snapshot_create_time: t_stamp,
    snapshot_identifier: binary,
    snapshot_type: binary,
    source_region: binary,
    status: binary,
    tags: tag_list,
    total_backup_size_in_mega_bytes: double,
    vpc_id: binary,
  ]

  @type snapshot_copy_already_disabled_fault :: [
  ]

  @type snapshot_copy_already_enabled_fault :: [
  ]

  @type snapshot_copy_disabled_fault :: [
  ]

  @type snapshot_copy_grant :: [
    kms_key_id: binary,
    snapshot_copy_grant_name: binary,
    tags: tag_list,
  ]

  @type snapshot_copy_grant_already_exists_fault :: [
  ]

  @type snapshot_copy_grant_list :: [snapshot_copy_grant]

  @type snapshot_copy_grant_message :: [
    marker: binary,
    snapshot_copy_grants: snapshot_copy_grant_list,
  ]

  @type snapshot_copy_grant_not_found_fault :: [
  ]

  @type snapshot_copy_grant_quota_exceeded_fault :: [
  ]

  @type snapshot_list :: [snapshot]

  @type snapshot_message :: [
    marker: binary,
    snapshots: snapshot_list,
  ]

  @type source_ids_list :: [binary]

  @type source_not_found_fault :: [
  ]

  @type source_type :: binary

  @type subnet :: [
    subnet_availability_zone: availability_zone,
    subnet_identifier: binary,
    subnet_status: binary,
  ]

  @type subnet_already_in_use :: [
  ]

  @type subnet_identifier_list :: [binary]

  @type subnet_list :: [subnet]

  @type subscription_already_exist_fault :: [
  ]

  @type subscription_category_not_found_fault :: [
  ]

  @type subscription_event_id_not_found_fault :: [
  ]

  @type subscription_not_found_fault :: [
  ]

  @type subscription_severity_not_found_fault :: [
  ]

  @type t_stamp :: integer

  @type tag :: [
    key: binary,
    value: binary,
  ]

  @type tag_key_list :: [binary]

  @type tag_limit_exceeded_fault :: [
  ]

  @type tag_list :: [tag]

  @type tag_value_list :: [binary]

  @type tagged_resource :: [
    resource_name: binary,
    resource_type: binary,
    tag: tag,
  ]

  @type tagged_resource_list :: [tagged_resource]

  @type tagged_resource_list_message :: [
    marker: binary,
    tagged_resources: tagged_resource_list,
  ]

  @type unauthorized_operation :: [
  ]

  @type unknown_snapshot_copy_region_fault :: [
  ]

  @type unsupported_operation_fault :: [
  ]

  @type unsupported_option_fault :: [
  ]

  @type vpc_security_group_id_list :: [binary]

  @type vpc_security_group_membership :: [
    status: binary,
    vpc_security_group_id: binary,
  ]

  @type vpc_security_group_membership_list :: [vpc_security_group_membership]




  @doc """
  AuthorizeClusterSecurityGroupIngress

  Adds an inbound (ingress) rule to an Amazon Redshift security group.
  Depending on whether the application accessing your cluster is running on
  the Internet or an EC2 instance, you can authorize inbound access to either
  a Classless Interdomain Routing (CIDR) IP address range or an EC2 security
  group. You can add as many as 20 ingress rules to an Amazon Redshift
  security group.

  Note: The EC2 security group must be defined in the AWS region where the
  cluster resides. For an overview of CIDR blocks, see the Wikipedia article
  on [Classless Inter-Domain
  Routing](http://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing).

  You must also associate the security group with a cluster so that clients
  running on these IP addresses or the EC2 instance are authorized to connect
  to the cluster. For information about managing security groups, go to
  [Working with Security
  Groups](http://docs.aws.amazon.com/redshift/latest/mgmt/working-with-security-groups.html)
  in the *Amazon Redshift Cluster Management Guide*.
  """

  @spec authorize_cluster_security_group_ingress(client :: ExAws.Redshift.t, input :: authorize_cluster_security_group_ingress_message) :: ExAws.Request.Query.response_t
  def authorize_cluster_security_group_ingress(client, input) do
    request(client, "/", "AuthorizeClusterSecurityGroupIngress", input)
  end

  @doc """
  Same as `authorize_cluster_security_group_ingress/2` but raise on error.
  """
  @spec authorize_cluster_security_group_ingress!(client :: ExAws.Redshift.t, input :: authorize_cluster_security_group_ingress_message) :: ExAws.Request.Query.success_t | no_return
  def authorize_cluster_security_group_ingress!(client, input) do
    case authorize_cluster_security_group_ingress(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  AuthorizeSnapshotAccess

  Authorizes the specified AWS customer account to restore the specified
  snapshot.

  For more information about working with snapshots, go to [Amazon Redshift
  Snapshots](http://docs.aws.amazon.com/redshift/latest/mgmt/working-with-snapshots.html)
  in the *Amazon Redshift Cluster Management Guide*.
  """

  @spec authorize_snapshot_access(client :: ExAws.Redshift.t, input :: authorize_snapshot_access_message) :: ExAws.Request.Query.response_t
  def authorize_snapshot_access(client, input) do
    request(client, "/", "AuthorizeSnapshotAccess", input)
  end

  @doc """
  Same as `authorize_snapshot_access/2` but raise on error.
  """
  @spec authorize_snapshot_access!(client :: ExAws.Redshift.t, input :: authorize_snapshot_access_message) :: ExAws.Request.Query.success_t | no_return
  def authorize_snapshot_access!(client, input) do
    case authorize_snapshot_access(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CopyClusterSnapshot

  Copies the specified automated cluster snapshot to a new manual cluster
  snapshot. The source must be an automated snapshot and it must be in the
  available state.

  When you delete a cluster, Amazon Redshift deletes any automated snapshots
  of the cluster. Also, when the retention period of the snapshot expires,
  Amazon Redshift automatically deletes it. If you want to keep an automated
  snapshot for a longer period, you can make a manual copy of the snapshot.
  Manual snapshots are retained until you delete them.

  For more information about working with snapshots, go to [Amazon Redshift
  Snapshots](http://docs.aws.amazon.com/redshift/latest/mgmt/working-with-snapshots.html)
  in the *Amazon Redshift Cluster Management Guide*.
  """

  @spec copy_cluster_snapshot(client :: ExAws.Redshift.t, input :: copy_cluster_snapshot_message) :: ExAws.Request.Query.response_t
  def copy_cluster_snapshot(client, input) do
    request(client, "/", "CopyClusterSnapshot", input)
  end

  @doc """
  Same as `copy_cluster_snapshot/2` but raise on error.
  """
  @spec copy_cluster_snapshot!(client :: ExAws.Redshift.t, input :: copy_cluster_snapshot_message) :: ExAws.Request.Query.success_t | no_return
  def copy_cluster_snapshot!(client, input) do
    case copy_cluster_snapshot(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateCluster

  Creates a new cluster. To create the cluster in virtual private cloud
  (VPC), you must provide cluster subnet group name. If you don't provide a
  cluster subnet group name or the cluster security group parameter, Amazon
  Redshift creates a non-VPC cluster, it associates the default cluster
  security group with the cluster. For more information about managing
  clusters, go to [Amazon Redshift
  Clusters](http://docs.aws.amazon.com/redshift/latest/mgmt/working-with-clusters.html)
  in the *Amazon Redshift Cluster Management Guide* .
  """

  @spec create_cluster(client :: ExAws.Redshift.t, input :: create_cluster_message) :: ExAws.Request.Query.response_t
  def create_cluster(client, input) do
    request(client, "/", "CreateCluster", input)
  end

  @doc """
  Same as `create_cluster/2` but raise on error.
  """
  @spec create_cluster!(client :: ExAws.Redshift.t, input :: create_cluster_message) :: ExAws.Request.Query.success_t | no_return
  def create_cluster!(client, input) do
    case create_cluster(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateClusterParameterGroup

  Creates an Amazon Redshift parameter group.

  Creating parameter groups is independent of creating clusters. You can
  associate a cluster with a parameter group when you create the cluster. You
  can also associate an existing cluster with a parameter group after the
  cluster is created by using `ModifyCluster`.

  Parameters in the parameter group define specific behavior that applies to
  the databases you create on the cluster. For more information about
  parameters and parameter groups, go to [Amazon Redshift Parameter
  Groups](http://docs.aws.amazon.com/redshift/latest/mgmt/working-with-parameter-groups.html)
  in the *Amazon Redshift Cluster Management Guide*.
  """

  @spec create_cluster_parameter_group(client :: ExAws.Redshift.t, input :: create_cluster_parameter_group_message) :: ExAws.Request.Query.response_t
  def create_cluster_parameter_group(client, input) do
    request(client, "/", "CreateClusterParameterGroup", input)
  end

  @doc """
  Same as `create_cluster_parameter_group/2` but raise on error.
  """
  @spec create_cluster_parameter_group!(client :: ExAws.Redshift.t, input :: create_cluster_parameter_group_message) :: ExAws.Request.Query.success_t | no_return
  def create_cluster_parameter_group!(client, input) do
    case create_cluster_parameter_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateClusterSecurityGroup

  Creates a new Amazon Redshift security group. You use security groups to
  control access to non-VPC clusters.

  For information about managing security groups, go to [Amazon Redshift
  Cluster Security
  Groups](http://docs.aws.amazon.com/redshift/latest/mgmt/working-with-security-groups.html)
  in the *Amazon Redshift Cluster Management Guide*.
  """

  @spec create_cluster_security_group(client :: ExAws.Redshift.t, input :: create_cluster_security_group_message) :: ExAws.Request.Query.response_t
  def create_cluster_security_group(client, input) do
    request(client, "/", "CreateClusterSecurityGroup", input)
  end

  @doc """
  Same as `create_cluster_security_group/2` but raise on error.
  """
  @spec create_cluster_security_group!(client :: ExAws.Redshift.t, input :: create_cluster_security_group_message) :: ExAws.Request.Query.success_t | no_return
  def create_cluster_security_group!(client, input) do
    case create_cluster_security_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateClusterSnapshot

  Creates a manual snapshot of the specified cluster. The cluster must be in
  the `available` state.

  For more information about working with snapshots, go to [Amazon Redshift
  Snapshots](http://docs.aws.amazon.com/redshift/latest/mgmt/working-with-snapshots.html)
  in the *Amazon Redshift Cluster Management Guide*.
  """

  @spec create_cluster_snapshot(client :: ExAws.Redshift.t, input :: create_cluster_snapshot_message) :: ExAws.Request.Query.response_t
  def create_cluster_snapshot(client, input) do
    request(client, "/", "CreateClusterSnapshot", input)
  end

  @doc """
  Same as `create_cluster_snapshot/2` but raise on error.
  """
  @spec create_cluster_snapshot!(client :: ExAws.Redshift.t, input :: create_cluster_snapshot_message) :: ExAws.Request.Query.success_t | no_return
  def create_cluster_snapshot!(client, input) do
    case create_cluster_snapshot(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateClusterSubnetGroup

  Creates a new Amazon Redshift subnet group. You must provide a list of one
  or more subnets in your existing Amazon Virtual Private Cloud (Amazon VPC)
  when creating Amazon Redshift subnet group.

  For information about subnet groups, go to [Amazon Redshift Cluster Subnet
  Groups](http://docs.aws.amazon.com/redshift/latest/mgmt/working-with-cluster-subnet-groups.html)
  in the *Amazon Redshift Cluster Management Guide*.
  """

  @spec create_cluster_subnet_group(client :: ExAws.Redshift.t, input :: create_cluster_subnet_group_message) :: ExAws.Request.Query.response_t
  def create_cluster_subnet_group(client, input) do
    request(client, "/", "CreateClusterSubnetGroup", input)
  end

  @doc """
  Same as `create_cluster_subnet_group/2` but raise on error.
  """
  @spec create_cluster_subnet_group!(client :: ExAws.Redshift.t, input :: create_cluster_subnet_group_message) :: ExAws.Request.Query.success_t | no_return
  def create_cluster_subnet_group!(client, input) do
    case create_cluster_subnet_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateEventSubscription

  Creates an Amazon Redshift event notification subscription. This action
  requires an ARN (Amazon Resource Name) of an Amazon SNS topic created by
  either the Amazon Redshift console, the Amazon SNS console, or the Amazon
  SNS API. To obtain an ARN with Amazon SNS, you must create a topic in
  Amazon SNS and subscribe to the topic. The ARN is displayed in the SNS
  console.

  You can specify the source type, and lists of Amazon Redshift source IDs,
  event categories, and event severities. Notifications will be sent for all
  events you want that match those criteria. For example, you can specify
  source type = cluster, source ID = my-cluster-1 and mycluster2, event
  categories = Availability, Backup, and severity = ERROR. The subscription
  will only send notifications for those ERROR events in the Availability and
  Backup categories for the specified clusters.

  If you specify both the source type and source IDs, such as source type =
  cluster and source identifier = my-cluster-1, notifications will be sent
  for all the cluster events for my-cluster-1. If you specify a source type
  but do not specify a source identifier, you will receive notice of the
  events for the objects of that type in your AWS account. If you do not
  specify either the SourceType nor the SourceIdentifier, you will be
  notified of events generated from all Amazon Redshift sources belonging to
  your AWS account. You must specify a source type if you specify a source
  ID.
  """

  @spec create_event_subscription(client :: ExAws.Redshift.t, input :: create_event_subscription_message) :: ExAws.Request.Query.response_t
  def create_event_subscription(client, input) do
    request(client, "/", "CreateEventSubscription", input)
  end

  @doc """
  Same as `create_event_subscription/2` but raise on error.
  """
  @spec create_event_subscription!(client :: ExAws.Redshift.t, input :: create_event_subscription_message) :: ExAws.Request.Query.success_t | no_return
  def create_event_subscription!(client, input) do
    case create_event_subscription(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateHsmClientCertificate

  Creates an HSM client certificate that an Amazon Redshift cluster will use
  to connect to the client's HSM in order to store and retrieve the keys used
  to encrypt the cluster databases.

  The command returns a public key, which you must store in the HSM. In
  addition to creating the HSM certificate, you must create an Amazon
  Redshift HSM configuration that provides a cluster the information needed
  to store and use encryption keys in the HSM. For more information, go to
  [Hardware Security
  Modules](http://docs.aws.amazon.com/redshift/latest/mgmt/working-with-HSM.html)
  in the Amazon Redshift Cluster Management Guide.
  """

  @spec create_hsm_client_certificate(client :: ExAws.Redshift.t, input :: create_hsm_client_certificate_message) :: ExAws.Request.Query.response_t
  def create_hsm_client_certificate(client, input) do
    request(client, "/", "CreateHsmClientCertificate", input)
  end

  @doc """
  Same as `create_hsm_client_certificate/2` but raise on error.
  """
  @spec create_hsm_client_certificate!(client :: ExAws.Redshift.t, input :: create_hsm_client_certificate_message) :: ExAws.Request.Query.success_t | no_return
  def create_hsm_client_certificate!(client, input) do
    case create_hsm_client_certificate(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateHsmConfiguration

  Creates an HSM configuration that contains the information required by an
  Amazon Redshift cluster to store and use database encryption keys in a
  Hardware Security Module (HSM). After creating the HSM configuration, you
  can specify it as a parameter when creating a cluster. The cluster will
  then store its encryption keys in the HSM.

  In addition to creating an HSM configuration, you must also create an HSM
  client certificate. For more information, go to [Hardware Security
  Modules](http://docs.aws.amazon.com/redshift/latest/mgmt/working-with-HSM.html)
  in the Amazon Redshift Cluster Management Guide.
  """

  @spec create_hsm_configuration(client :: ExAws.Redshift.t, input :: create_hsm_configuration_message) :: ExAws.Request.Query.response_t
  def create_hsm_configuration(client, input) do
    request(client, "/", "CreateHsmConfiguration", input)
  end

  @doc """
  Same as `create_hsm_configuration/2` but raise on error.
  """
  @spec create_hsm_configuration!(client :: ExAws.Redshift.t, input :: create_hsm_configuration_message) :: ExAws.Request.Query.success_t | no_return
  def create_hsm_configuration!(client, input) do
    case create_hsm_configuration(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateSnapshotCopyGrant

  Creates a snapshot copy grant that permits Amazon Redshift to use a
  customer master key (CMK) from AWS Key Management Service (AWS KMS) to
  encrypt copied snapshots in a destination region.

  For more information about managing snapshot copy grants, go to [Amazon
  Redshift Database
  Encryption](http://docs.aws.amazon.com/redshift/latest/mgmt/working-with-db-encryption.html)
  in the *Amazon Redshift Cluster Management Guide*.
  """

  @spec create_snapshot_copy_grant(client :: ExAws.Redshift.t, input :: create_snapshot_copy_grant_message) :: ExAws.Request.Query.response_t
  def create_snapshot_copy_grant(client, input) do
    request(client, "/", "CreateSnapshotCopyGrant", input)
  end

  @doc """
  Same as `create_snapshot_copy_grant/2` but raise on error.
  """
  @spec create_snapshot_copy_grant!(client :: ExAws.Redshift.t, input :: create_snapshot_copy_grant_message) :: ExAws.Request.Query.success_t | no_return
  def create_snapshot_copy_grant!(client, input) do
    case create_snapshot_copy_grant(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateTags

  Adds one or more tags to a specified resource.

  A resource can have up to 10 tags. If you try to create more than 10 tags
  for a resource, you will receive an error and the attempt will fail.

  If you specify a key that already exists for the resource, the value for
  that key will be updated with the new value.
  """

  @spec create_tags(client :: ExAws.Redshift.t, input :: create_tags_message) :: ExAws.Request.Query.response_t
  def create_tags(client, input) do
    request(client, "/", "CreateTags", input)
  end

  @doc """
  Same as `create_tags/2` but raise on error.
  """
  @spec create_tags!(client :: ExAws.Redshift.t, input :: create_tags_message) :: ExAws.Request.Query.success_t | no_return
  def create_tags!(client, input) do
    case create_tags(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteCluster

  Deletes a previously provisioned cluster. A successful response from the
  web service indicates that the request was received correctly. Use
  `DescribeClusters` to monitor the status of the deletion. The delete
  operation cannot be canceled or reverted once submitted. For more
  information about managing clusters, go to [Amazon Redshift
  Clusters](http://docs.aws.amazon.com/redshift/latest/mgmt/working-with-clusters.html)
  in the *Amazon Redshift Cluster Management Guide* .

  If you want to shut down the cluster and retain it for future use, set
  *SkipFinalClusterSnapshot* to `false` and specify a name for
  *FinalClusterSnapshotIdentifier*. You can later restore this snapshot to
  resume using the cluster. If a final cluster snapshot is requested, the
  status of the cluster will be "final-snapshot" while the snapshot is being
  taken, then it's "deleting" once Amazon Redshift begins deleting the
  cluster.

  For more information about managing clusters, go to [Amazon Redshift
  Clusters](http://docs.aws.amazon.com/redshift/latest/mgmt/working-with-clusters.html)
  in the *Amazon Redshift Cluster Management Guide* .
  """

  @spec delete_cluster(client :: ExAws.Redshift.t, input :: delete_cluster_message) :: ExAws.Request.Query.response_t
  def delete_cluster(client, input) do
    request(client, "/", "DeleteCluster", input)
  end

  @doc """
  Same as `delete_cluster/2` but raise on error.
  """
  @spec delete_cluster!(client :: ExAws.Redshift.t, input :: delete_cluster_message) :: ExAws.Request.Query.success_t | no_return
  def delete_cluster!(client, input) do
    case delete_cluster(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteClusterParameterGroup

  Deletes a specified Amazon Redshift parameter group. Note:You cannot delete
  a parameter group if it is associated with a cluster.
  """

  @spec delete_cluster_parameter_group(client :: ExAws.Redshift.t, input :: delete_cluster_parameter_group_message) :: ExAws.Request.Query.response_t
  def delete_cluster_parameter_group(client, input) do
    request(client, "/", "DeleteClusterParameterGroup", input)
  end

  @doc """
  Same as `delete_cluster_parameter_group/2` but raise on error.
  """
  @spec delete_cluster_parameter_group!(client :: ExAws.Redshift.t, input :: delete_cluster_parameter_group_message) :: ExAws.Request.Query.success_t | no_return
  def delete_cluster_parameter_group!(client, input) do
    case delete_cluster_parameter_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteClusterSecurityGroup

  Deletes an Amazon Redshift security group.

  Note:You cannot delete a security group that is associated with any
  clusters. You cannot delete the default security group. For information
  about managing security groups, go to [Amazon Redshift Cluster Security
  Groups](http://docs.aws.amazon.com/redshift/latest/mgmt/working-with-security-groups.html)
  in the *Amazon Redshift Cluster Management Guide*.
  """

  @spec delete_cluster_security_group(client :: ExAws.Redshift.t, input :: delete_cluster_security_group_message) :: ExAws.Request.Query.response_t
  def delete_cluster_security_group(client, input) do
    request(client, "/", "DeleteClusterSecurityGroup", input)
  end

  @doc """
  Same as `delete_cluster_security_group/2` but raise on error.
  """
  @spec delete_cluster_security_group!(client :: ExAws.Redshift.t, input :: delete_cluster_security_group_message) :: ExAws.Request.Query.success_t | no_return
  def delete_cluster_security_group!(client, input) do
    case delete_cluster_security_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteClusterSnapshot

  Deletes the specified manual snapshot. The snapshot must be in the
  `available` state, with no other users authorized to access the snapshot.

  Unlike automated snapshots, manual snapshots are retained even after you
  delete your cluster. Amazon Redshift does not delete your manual snapshots.
  You must delete manual snapshot explicitly to avoid getting charged. If
  other accounts are authorized to access the snapshot, you must revoke all
  of the authorizations before you can delete the snapshot.
  """

  @spec delete_cluster_snapshot(client :: ExAws.Redshift.t, input :: delete_cluster_snapshot_message) :: ExAws.Request.Query.response_t
  def delete_cluster_snapshot(client, input) do
    request(client, "/", "DeleteClusterSnapshot", input)
  end

  @doc """
  Same as `delete_cluster_snapshot/2` but raise on error.
  """
  @spec delete_cluster_snapshot!(client :: ExAws.Redshift.t, input :: delete_cluster_snapshot_message) :: ExAws.Request.Query.success_t | no_return
  def delete_cluster_snapshot!(client, input) do
    case delete_cluster_snapshot(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteClusterSubnetGroup

  Deletes the specified cluster subnet group.
  """

  @spec delete_cluster_subnet_group(client :: ExAws.Redshift.t, input :: delete_cluster_subnet_group_message) :: ExAws.Request.Query.response_t
  def delete_cluster_subnet_group(client, input) do
    request(client, "/", "DeleteClusterSubnetGroup", input)
  end

  @doc """
  Same as `delete_cluster_subnet_group/2` but raise on error.
  """
  @spec delete_cluster_subnet_group!(client :: ExAws.Redshift.t, input :: delete_cluster_subnet_group_message) :: ExAws.Request.Query.success_t | no_return
  def delete_cluster_subnet_group!(client, input) do
    case delete_cluster_subnet_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteEventSubscription

  Deletes an Amazon Redshift event notification subscription.
  """

  @spec delete_event_subscription(client :: ExAws.Redshift.t, input :: delete_event_subscription_message) :: ExAws.Request.Query.response_t
  def delete_event_subscription(client, input) do
    request(client, "/", "DeleteEventSubscription", input)
  end

  @doc """
  Same as `delete_event_subscription/2` but raise on error.
  """
  @spec delete_event_subscription!(client :: ExAws.Redshift.t, input :: delete_event_subscription_message) :: ExAws.Request.Query.success_t | no_return
  def delete_event_subscription!(client, input) do
    case delete_event_subscription(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteHsmClientCertificate

  Deletes the specified HSM client certificate.
  """

  @spec delete_hsm_client_certificate(client :: ExAws.Redshift.t, input :: delete_hsm_client_certificate_message) :: ExAws.Request.Query.response_t
  def delete_hsm_client_certificate(client, input) do
    request(client, "/", "DeleteHsmClientCertificate", input)
  end

  @doc """
  Same as `delete_hsm_client_certificate/2` but raise on error.
  """
  @spec delete_hsm_client_certificate!(client :: ExAws.Redshift.t, input :: delete_hsm_client_certificate_message) :: ExAws.Request.Query.success_t | no_return
  def delete_hsm_client_certificate!(client, input) do
    case delete_hsm_client_certificate(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteHsmConfiguration

  Deletes the specified Amazon Redshift HSM configuration.
  """

  @spec delete_hsm_configuration(client :: ExAws.Redshift.t, input :: delete_hsm_configuration_message) :: ExAws.Request.Query.response_t
  def delete_hsm_configuration(client, input) do
    request(client, "/", "DeleteHsmConfiguration", input)
  end

  @doc """
  Same as `delete_hsm_configuration/2` but raise on error.
  """
  @spec delete_hsm_configuration!(client :: ExAws.Redshift.t, input :: delete_hsm_configuration_message) :: ExAws.Request.Query.success_t | no_return
  def delete_hsm_configuration!(client, input) do
    case delete_hsm_configuration(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteSnapshotCopyGrant

  Deletes the specified snapshot copy grant.
  """

  @spec delete_snapshot_copy_grant(client :: ExAws.Redshift.t, input :: delete_snapshot_copy_grant_message) :: ExAws.Request.Query.response_t
  def delete_snapshot_copy_grant(client, input) do
    request(client, "/", "DeleteSnapshotCopyGrant", input)
  end

  @doc """
  Same as `delete_snapshot_copy_grant/2` but raise on error.
  """
  @spec delete_snapshot_copy_grant!(client :: ExAws.Redshift.t, input :: delete_snapshot_copy_grant_message) :: ExAws.Request.Query.success_t | no_return
  def delete_snapshot_copy_grant!(client, input) do
    case delete_snapshot_copy_grant(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteTags

  Deletes a tag or tags from a resource. You must provide the ARN of the
  resource from which you want to delete the tag or tags.
  """

  @spec delete_tags(client :: ExAws.Redshift.t, input :: delete_tags_message) :: ExAws.Request.Query.response_t
  def delete_tags(client, input) do
    request(client, "/", "DeleteTags", input)
  end

  @doc """
  Same as `delete_tags/2` but raise on error.
  """
  @spec delete_tags!(client :: ExAws.Redshift.t, input :: delete_tags_message) :: ExAws.Request.Query.success_t | no_return
  def delete_tags!(client, input) do
    case delete_tags(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeClusterParameterGroups

  Returns a list of Amazon Redshift parameter groups, including parameter
  groups you created and the default parameter group. For each parameter
  group, the response includes the parameter group name, description, and
  parameter group family name. You can optionally specify a name to retrieve
  the description of a specific parameter group.

  For more information about parameters and parameter groups, go to [Amazon
  Redshift Parameter
  Groups](http://docs.aws.amazon.com/redshift/latest/mgmt/working-with-parameter-groups.html)
  in the *Amazon Redshift Cluster Management Guide*.

  If you specify both tag keys and tag values in the same request, Amazon
  Redshift returns all parameter groups that match any combination of the
  specified keys and values. For example, if you have `owner` and
  `environment` for tag keys, and `admin` and `test` for tag values, all
  parameter groups that have any combination of those values are returned.

  If both tag keys and values are omitted from the request, parameter groups
  are returned regardless of whether they have tag keys or values associated
  with them.
  """

  @spec describe_cluster_parameter_groups(client :: ExAws.Redshift.t, input :: describe_cluster_parameter_groups_message) :: ExAws.Request.Query.response_t
  def describe_cluster_parameter_groups(client, input) do
    request(client, "/", "DescribeClusterParameterGroups", input)
  end

  @doc """
  Same as `describe_cluster_parameter_groups/2` but raise on error.
  """
  @spec describe_cluster_parameter_groups!(client :: ExAws.Redshift.t, input :: describe_cluster_parameter_groups_message) :: ExAws.Request.Query.success_t | no_return
  def describe_cluster_parameter_groups!(client, input) do
    case describe_cluster_parameter_groups(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeClusterParameters

  Returns a detailed list of parameters contained within the specified Amazon
  Redshift parameter group. For each parameter the response includes
  information such as parameter name, description, data type, value, whether
  the parameter value is modifiable, and so on.

  You can specify *source* filter to retrieve parameters of only specific
  type. For example, to retrieve parameters that were modified by a user
  action such as from `ModifyClusterParameterGroup`, you can specify *source*
  equal to *user*.

  For more information about parameters and parameter groups, go to [Amazon
  Redshift Parameter
  Groups](http://docs.aws.amazon.com/redshift/latest/mgmt/working-with-parameter-groups.html)
  in the *Amazon Redshift Cluster Management Guide*.
  """

  @spec describe_cluster_parameters(client :: ExAws.Redshift.t, input :: describe_cluster_parameters_message) :: ExAws.Request.Query.response_t
  def describe_cluster_parameters(client, input) do
    request(client, "/", "DescribeClusterParameters", input)
  end

  @doc """
  Same as `describe_cluster_parameters/2` but raise on error.
  """
  @spec describe_cluster_parameters!(client :: ExAws.Redshift.t, input :: describe_cluster_parameters_message) :: ExAws.Request.Query.success_t | no_return
  def describe_cluster_parameters!(client, input) do
    case describe_cluster_parameters(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeClusterSecurityGroups

  Returns information about Amazon Redshift security groups. If the name of a
  security group is specified, the response will contain only information
  about only that security group.

  For information about managing security groups, go to [Amazon Redshift
  Cluster Security
  Groups](http://docs.aws.amazon.com/redshift/latest/mgmt/working-with-security-groups.html)
  in the *Amazon Redshift Cluster Management Guide*.

  If you specify both tag keys and tag values in the same request, Amazon
  Redshift returns all security groups that match any combination of the
  specified keys and values. For example, if you have `owner` and
  `environment` for tag keys, and `admin` and `test` for tag values, all
  security groups that have any combination of those values are returned.

  If both tag keys and values are omitted from the request, security groups
  are returned regardless of whether they have tag keys or values associated
  with them.
  """

  @spec describe_cluster_security_groups(client :: ExAws.Redshift.t, input :: describe_cluster_security_groups_message) :: ExAws.Request.Query.response_t
  def describe_cluster_security_groups(client, input) do
    request(client, "/", "DescribeClusterSecurityGroups", input)
  end

  @doc """
  Same as `describe_cluster_security_groups/2` but raise on error.
  """
  @spec describe_cluster_security_groups!(client :: ExAws.Redshift.t, input :: describe_cluster_security_groups_message) :: ExAws.Request.Query.success_t | no_return
  def describe_cluster_security_groups!(client, input) do
    case describe_cluster_security_groups(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeClusterSnapshots

  Returns one or more snapshot objects, which contain metadata about your
  cluster snapshots. By default, this operation returns information about all
  snapshots of all clusters that are owned by you AWS customer account. No
  information is returned for snapshots owned by inactive AWS customer
  accounts.

  If you specify both tag keys and tag values in the same request, Amazon
  Redshift returns all snapshots that match any combination of the specified
  keys and values. For example, if you have `owner` and `environment` for tag
  keys, and `admin` and `test` for tag values, all snapshots that have any
  combination of those values are returned. Only snapshots that you own are
  returned in the response; shared snapshots are not returned with the tag
  key and tag value request parameters.

  If both tag keys and values are omitted from the request, snapshots are
  returned regardless of whether they have tag keys or values associated with
  them.
  """

  @spec describe_cluster_snapshots(client :: ExAws.Redshift.t, input :: describe_cluster_snapshots_message) :: ExAws.Request.Query.response_t
  def describe_cluster_snapshots(client, input) do
    request(client, "/", "DescribeClusterSnapshots", input)
  end

  @doc """
  Same as `describe_cluster_snapshots/2` but raise on error.
  """
  @spec describe_cluster_snapshots!(client :: ExAws.Redshift.t, input :: describe_cluster_snapshots_message) :: ExAws.Request.Query.success_t | no_return
  def describe_cluster_snapshots!(client, input) do
    case describe_cluster_snapshots(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeClusterSubnetGroups

  Returns one or more cluster subnet group objects, which contain metadata
  about your cluster subnet groups. By default, this operation returns
  information about all cluster subnet groups that are defined in you AWS
  account.

  If you specify both tag keys and tag values in the same request, Amazon
  Redshift returns all subnet groups that match any combination of the
  specified keys and values. For example, if you have `owner` and
  `environment` for tag keys, and `admin` and `test` for tag values, all
  subnet groups that have any combination of those values are returned.

  If both tag keys and values are omitted from the request, subnet groups are
  returned regardless of whether they have tag keys or values associated with
  them.
  """

  @spec describe_cluster_subnet_groups(client :: ExAws.Redshift.t, input :: describe_cluster_subnet_groups_message) :: ExAws.Request.Query.response_t
  def describe_cluster_subnet_groups(client, input) do
    request(client, "/", "DescribeClusterSubnetGroups", input)
  end

  @doc """
  Same as `describe_cluster_subnet_groups/2` but raise on error.
  """
  @spec describe_cluster_subnet_groups!(client :: ExAws.Redshift.t, input :: describe_cluster_subnet_groups_message) :: ExAws.Request.Query.success_t | no_return
  def describe_cluster_subnet_groups!(client, input) do
    case describe_cluster_subnet_groups(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeClusterVersions

  Returns descriptions of the available Amazon Redshift cluster versions. You
  can call this operation even before creating any clusters to learn more
  about the Amazon Redshift versions. For more information about managing
  clusters, go to [Amazon Redshift
  Clusters](http://docs.aws.amazon.com/redshift/latest/mgmt/working-with-clusters.html)
  in the *Amazon Redshift Cluster Management Guide*
  """

  @spec describe_cluster_versions(client :: ExAws.Redshift.t, input :: describe_cluster_versions_message) :: ExAws.Request.Query.response_t
  def describe_cluster_versions(client, input) do
    request(client, "/", "DescribeClusterVersions", input)
  end

  @doc """
  Same as `describe_cluster_versions/2` but raise on error.
  """
  @spec describe_cluster_versions!(client :: ExAws.Redshift.t, input :: describe_cluster_versions_message) :: ExAws.Request.Query.success_t | no_return
  def describe_cluster_versions!(client, input) do
    case describe_cluster_versions(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeClusters

  Returns properties of provisioned clusters including general cluster
  properties, cluster database properties, maintenance and backup properties,
  and security and access properties. This operation supports pagination. For
  more information about managing clusters, go to [Amazon Redshift
  Clusters](http://docs.aws.amazon.com/redshift/latest/mgmt/working-with-clusters.html)
  in the *Amazon Redshift Cluster Management Guide* .

  If you specify both tag keys and tag values in the same request, Amazon
  Redshift returns all clusters that match any combination of the specified
  keys and values. For example, if you have `owner` and `environment` for tag
  keys, and `admin` and `test` for tag values, all clusters that have any
  combination of those values are returned.

  If both tag keys and values are omitted from the request, clusters are
  returned regardless of whether they have tag keys or values associated with
  them.
  """

  @spec describe_clusters(client :: ExAws.Redshift.t, input :: describe_clusters_message) :: ExAws.Request.Query.response_t
  def describe_clusters(client, input) do
    request(client, "/", "DescribeClusters", input)
  end

  @doc """
  Same as `describe_clusters/2` but raise on error.
  """
  @spec describe_clusters!(client :: ExAws.Redshift.t, input :: describe_clusters_message) :: ExAws.Request.Query.success_t | no_return
  def describe_clusters!(client, input) do
    case describe_clusters(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeDefaultClusterParameters

  Returns a list of parameter settings for the specified parameter group
  family.

  For more information about parameters and parameter groups, go to [Amazon
  Redshift Parameter
  Groups](http://docs.aws.amazon.com/redshift/latest/mgmt/working-with-parameter-groups.html)
  in the *Amazon Redshift Cluster Management Guide*.
  """

  @spec describe_default_cluster_parameters(client :: ExAws.Redshift.t, input :: describe_default_cluster_parameters_message) :: ExAws.Request.Query.response_t
  def describe_default_cluster_parameters(client, input) do
    request(client, "/", "DescribeDefaultClusterParameters", input)
  end

  @doc """
  Same as `describe_default_cluster_parameters/2` but raise on error.
  """
  @spec describe_default_cluster_parameters!(client :: ExAws.Redshift.t, input :: describe_default_cluster_parameters_message) :: ExAws.Request.Query.success_t | no_return
  def describe_default_cluster_parameters!(client, input) do
    case describe_default_cluster_parameters(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeEventCategories

  Displays a list of event categories for all event source types, or for a
  specified source type. For a list of the event categories and source types,
  go to [Amazon Redshift Event
  Notifications](http://docs.aws.amazon.com/redshift/latest/mgmt/working-with-event-notifications.html).
  """

  @spec describe_event_categories(client :: ExAws.Redshift.t, input :: describe_event_categories_message) :: ExAws.Request.Query.response_t
  def describe_event_categories(client, input) do
    request(client, "/", "DescribeEventCategories", input)
  end

  @doc """
  Same as `describe_event_categories/2` but raise on error.
  """
  @spec describe_event_categories!(client :: ExAws.Redshift.t, input :: describe_event_categories_message) :: ExAws.Request.Query.success_t | no_return
  def describe_event_categories!(client, input) do
    case describe_event_categories(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeEventSubscriptions

  Lists descriptions of all the Amazon Redshift event notifications
  subscription for a customer account. If you specify a subscription name,
  lists the description for that subscription.
  """

  @spec describe_event_subscriptions(client :: ExAws.Redshift.t, input :: describe_event_subscriptions_message) :: ExAws.Request.Query.response_t
  def describe_event_subscriptions(client, input) do
    request(client, "/", "DescribeEventSubscriptions", input)
  end

  @doc """
  Same as `describe_event_subscriptions/2` but raise on error.
  """
  @spec describe_event_subscriptions!(client :: ExAws.Redshift.t, input :: describe_event_subscriptions_message) :: ExAws.Request.Query.success_t | no_return
  def describe_event_subscriptions!(client, input) do
    case describe_event_subscriptions(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeEvents

  Returns events related to clusters, security groups, snapshots, and
  parameter groups for the past 14 days. Events specific to a particular
  cluster, security group, snapshot or parameter group can be obtained by
  providing the name as a parameter. By default, the past hour of events are
  returned.
  """

  @spec describe_events(client :: ExAws.Redshift.t, input :: describe_events_message) :: ExAws.Request.Query.response_t
  def describe_events(client, input) do
    request(client, "/", "DescribeEvents", input)
  end

  @doc """
  Same as `describe_events/2` but raise on error.
  """
  @spec describe_events!(client :: ExAws.Redshift.t, input :: describe_events_message) :: ExAws.Request.Query.success_t | no_return
  def describe_events!(client, input) do
    case describe_events(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeHsmClientCertificates

  Returns information about the specified HSM client certificate. If no
  certificate ID is specified, returns information about all the HSM
  certificates owned by your AWS customer account.

  If you specify both tag keys and tag values in the same request, Amazon
  Redshift returns all HSM client certificates that match any combination of
  the specified keys and values. For example, if you have `owner` and
  `environment` for tag keys, and `admin` and `test` for tag values, all HSM
  client certificates that have any combination of those values are returned.

  If both tag keys and values are omitted from the request, HSM client
  certificates are returned regardless of whether they have tag keys or
  values associated with them.
  """

  @spec describe_hsm_client_certificates(client :: ExAws.Redshift.t, input :: describe_hsm_client_certificates_message) :: ExAws.Request.Query.response_t
  def describe_hsm_client_certificates(client, input) do
    request(client, "/", "DescribeHsmClientCertificates", input)
  end

  @doc """
  Same as `describe_hsm_client_certificates/2` but raise on error.
  """
  @spec describe_hsm_client_certificates!(client :: ExAws.Redshift.t, input :: describe_hsm_client_certificates_message) :: ExAws.Request.Query.success_t | no_return
  def describe_hsm_client_certificates!(client, input) do
    case describe_hsm_client_certificates(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeHsmConfigurations

  Returns information about the specified Amazon Redshift HSM configuration.
  If no configuration ID is specified, returns information about all the HSM
  configurations owned by your AWS customer account.

  If you specify both tag keys and tag values in the same request, Amazon
  Redshift returns all HSM connections that match any combination of the
  specified keys and values. For example, if you have `owner` and
  `environment` for tag keys, and `admin` and `test` for tag values, all HSM
  connections that have any combination of those values are returned.

  If both tag keys and values are omitted from the request, HSM connections
  are returned regardless of whether they have tag keys or values associated
  with them.
  """

  @spec describe_hsm_configurations(client :: ExAws.Redshift.t, input :: describe_hsm_configurations_message) :: ExAws.Request.Query.response_t
  def describe_hsm_configurations(client, input) do
    request(client, "/", "DescribeHsmConfigurations", input)
  end

  @doc """
  Same as `describe_hsm_configurations/2` but raise on error.
  """
  @spec describe_hsm_configurations!(client :: ExAws.Redshift.t, input :: describe_hsm_configurations_message) :: ExAws.Request.Query.success_t | no_return
  def describe_hsm_configurations!(client, input) do
    case describe_hsm_configurations(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeLoggingStatus

  Describes whether information, such as queries and connection attempts, is
  being logged for the specified Amazon Redshift cluster.
  """

  @spec describe_logging_status(client :: ExAws.Redshift.t, input :: describe_logging_status_message) :: ExAws.Request.Query.response_t
  def describe_logging_status(client, input) do
    request(client, "/", "DescribeLoggingStatus", input)
  end

  @doc """
  Same as `describe_logging_status/2` but raise on error.
  """
  @spec describe_logging_status!(client :: ExAws.Redshift.t, input :: describe_logging_status_message) :: ExAws.Request.Query.success_t | no_return
  def describe_logging_status!(client, input) do
    case describe_logging_status(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeOrderableClusterOptions

  Returns a list of orderable cluster options. Before you create a new
  cluster you can use this operation to find what options are available, such
  as the EC2 Availability Zones (AZ) in the specific AWS region that you can
  specify, and the node types you can request. The node types differ by
  available storage, memory, CPU and price. With the cost involved you might
  want to obtain a list of cluster options in the specific region and specify
  values when creating a cluster. For more information about managing
  clusters, go to [Amazon Redshift
  Clusters](http://docs.aws.amazon.com/redshift/latest/mgmt/working-with-clusters.html)
  in the *Amazon Redshift Cluster Management Guide*
  """

  @spec describe_orderable_cluster_options(client :: ExAws.Redshift.t, input :: describe_orderable_cluster_options_message) :: ExAws.Request.Query.response_t
  def describe_orderable_cluster_options(client, input) do
    request(client, "/", "DescribeOrderableClusterOptions", input)
  end

  @doc """
  Same as `describe_orderable_cluster_options/2` but raise on error.
  """
  @spec describe_orderable_cluster_options!(client :: ExAws.Redshift.t, input :: describe_orderable_cluster_options_message) :: ExAws.Request.Query.success_t | no_return
  def describe_orderable_cluster_options!(client, input) do
    case describe_orderable_cluster_options(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeReservedNodeOfferings

  Returns a list of the available reserved node offerings by Amazon Redshift
  with their descriptions including the node type, the fixed and recurring
  costs of reserving the node and duration the node will be reserved for you.
  These descriptions help you determine which reserve node offering you want
  to purchase. You then use the unique offering ID in you call to
  `PurchaseReservedNodeOffering` to reserve one or more nodes for your Amazon
  Redshift cluster.

  For more information about reserved node offerings, go to [Purchasing
  Reserved
  Nodes](http://docs.aws.amazon.com/redshift/latest/mgmt/purchase-reserved-node-instance.html)
  in the *Amazon Redshift Cluster Management Guide*.
  """

  @spec describe_reserved_node_offerings(client :: ExAws.Redshift.t, input :: describe_reserved_node_offerings_message) :: ExAws.Request.Query.response_t
  def describe_reserved_node_offerings(client, input) do
    request(client, "/", "DescribeReservedNodeOfferings", input)
  end

  @doc """
  Same as `describe_reserved_node_offerings/2` but raise on error.
  """
  @spec describe_reserved_node_offerings!(client :: ExAws.Redshift.t, input :: describe_reserved_node_offerings_message) :: ExAws.Request.Query.success_t | no_return
  def describe_reserved_node_offerings!(client, input) do
    case describe_reserved_node_offerings(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeReservedNodes

  Returns the descriptions of the reserved nodes.
  """

  @spec describe_reserved_nodes(client :: ExAws.Redshift.t, input :: describe_reserved_nodes_message) :: ExAws.Request.Query.response_t
  def describe_reserved_nodes(client, input) do
    request(client, "/", "DescribeReservedNodes", input)
  end

  @doc """
  Same as `describe_reserved_nodes/2` but raise on error.
  """
  @spec describe_reserved_nodes!(client :: ExAws.Redshift.t, input :: describe_reserved_nodes_message) :: ExAws.Request.Query.success_t | no_return
  def describe_reserved_nodes!(client, input) do
    case describe_reserved_nodes(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeResize

  Returns information about the last resize operation for the specified
  cluster. If no resize operation has ever been initiated for the specified
  cluster, a `HTTP 404` error is returned. If a resize operation was
  initiated and completed, the status of the resize remains as `SUCCEEDED`
  until the next resize.

  A resize operation can be requested using `ModifyCluster` and specifying a
  different number or type of nodes for the cluster.
  """

  @spec describe_resize(client :: ExAws.Redshift.t, input :: describe_resize_message) :: ExAws.Request.Query.response_t
  def describe_resize(client, input) do
    request(client, "/", "DescribeResize", input)
  end

  @doc """
  Same as `describe_resize/2` but raise on error.
  """
  @spec describe_resize!(client :: ExAws.Redshift.t, input :: describe_resize_message) :: ExAws.Request.Query.success_t | no_return
  def describe_resize!(client, input) do
    case describe_resize(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeSnapshotCopyGrants

  Returns a list of snapshot copy grants owned by the AWS account in the
  destination region.

  For more information about managing snapshot copy grants, go to [Amazon
  Redshift Database
  Encryption](http://docs.aws.amazon.com/redshift/latest/mgmt/working-with-db-encryption.html)
  in the *Amazon Redshift Cluster Management Guide*.
  """

  @spec describe_snapshot_copy_grants(client :: ExAws.Redshift.t, input :: describe_snapshot_copy_grants_message) :: ExAws.Request.Query.response_t
  def describe_snapshot_copy_grants(client, input) do
    request(client, "/", "DescribeSnapshotCopyGrants", input)
  end

  @doc """
  Same as `describe_snapshot_copy_grants/2` but raise on error.
  """
  @spec describe_snapshot_copy_grants!(client :: ExAws.Redshift.t, input :: describe_snapshot_copy_grants_message) :: ExAws.Request.Query.success_t | no_return
  def describe_snapshot_copy_grants!(client, input) do
    case describe_snapshot_copy_grants(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeTags

  Returns a list of tags. You can return tags from a specific resource by
  specifying an ARN, or you can return all tags for a given type of resource,
  such as clusters, snapshots, and so on.

  The following are limitations for `DescribeTags`:

  - You cannot specify an ARN and a resource-type value together in the same
  request.

  - You cannot use the `MaxRecords` and `Marker` parameters together with the
  ARN parameter.

  - The `MaxRecords` parameter can be a range from 10 to 50 results to return
  in a request.

  If you specify both tag keys and tag values in the same request, Amazon
  Redshift returns all resources that match any combination of the specified
  keys and values. For example, if you have `owner` and `environment` for tag
  keys, and `admin` and `test` for tag values, all resources that have any
  combination of those values are returned.

  If both tag keys and values are omitted from the request, resources are
  returned regardless of whether they have tag keys or values associated with
  them.
  """

  @spec describe_tags(client :: ExAws.Redshift.t, input :: describe_tags_message) :: ExAws.Request.Query.response_t
  def describe_tags(client, input) do
    request(client, "/", "DescribeTags", input)
  end

  @doc """
  Same as `describe_tags/2` but raise on error.
  """
  @spec describe_tags!(client :: ExAws.Redshift.t, input :: describe_tags_message) :: ExAws.Request.Query.success_t | no_return
  def describe_tags!(client, input) do
    case describe_tags(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DisableLogging

  Stops logging information, such as queries and connection attempts, for the
  specified Amazon Redshift cluster.
  """

  @spec disable_logging(client :: ExAws.Redshift.t, input :: disable_logging_message) :: ExAws.Request.Query.response_t
  def disable_logging(client, input) do
    request(client, "/", "DisableLogging", input)
  end

  @doc """
  Same as `disable_logging/2` but raise on error.
  """
  @spec disable_logging!(client :: ExAws.Redshift.t, input :: disable_logging_message) :: ExAws.Request.Query.success_t | no_return
  def disable_logging!(client, input) do
    case disable_logging(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DisableSnapshotCopy

  Disables the automatic copying of snapshots from one region to another
  region for a specified cluster.

  If your cluster and its snapshots are encrypted using a customer master key
  (CMK) from AWS KMS, use `DeleteSnapshotCopyGrant` to delete the grant that
  grants Amazon Redshift permission to the CMK in the destination region.
  """

  @spec disable_snapshot_copy(client :: ExAws.Redshift.t, input :: disable_snapshot_copy_message) :: ExAws.Request.Query.response_t
  def disable_snapshot_copy(client, input) do
    request(client, "/", "DisableSnapshotCopy", input)
  end

  @doc """
  Same as `disable_snapshot_copy/2` but raise on error.
  """
  @spec disable_snapshot_copy!(client :: ExAws.Redshift.t, input :: disable_snapshot_copy_message) :: ExAws.Request.Query.success_t | no_return
  def disable_snapshot_copy!(client, input) do
    case disable_snapshot_copy(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  EnableLogging

  Starts logging information, such as queries and connection attempts, for
  the specified Amazon Redshift cluster.
  """

  @spec enable_logging(client :: ExAws.Redshift.t, input :: enable_logging_message) :: ExAws.Request.Query.response_t
  def enable_logging(client, input) do
    request(client, "/", "EnableLogging", input)
  end

  @doc """
  Same as `enable_logging/2` but raise on error.
  """
  @spec enable_logging!(client :: ExAws.Redshift.t, input :: enable_logging_message) :: ExAws.Request.Query.success_t | no_return
  def enable_logging!(client, input) do
    case enable_logging(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  EnableSnapshotCopy

  Enables the automatic copy of snapshots from one region to another region
  for a specified cluster.
  """

  @spec enable_snapshot_copy(client :: ExAws.Redshift.t, input :: enable_snapshot_copy_message) :: ExAws.Request.Query.response_t
  def enable_snapshot_copy(client, input) do
    request(client, "/", "EnableSnapshotCopy", input)
  end

  @doc """
  Same as `enable_snapshot_copy/2` but raise on error.
  """
  @spec enable_snapshot_copy!(client :: ExAws.Redshift.t, input :: enable_snapshot_copy_message) :: ExAws.Request.Query.success_t | no_return
  def enable_snapshot_copy!(client, input) do
    case enable_snapshot_copy(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ModifyCluster

  Modifies the settings for a cluster. For example, you can add another
  security or parameter group, update the preferred maintenance window, or
  change the master user password. Resetting a cluster password or modifying
  the security groups associated with a cluster do not need a reboot.
  However, modifying a parameter group requires a reboot for parameters to
  take effect. For more information about managing clusters, go to [Amazon
  Redshift
  Clusters](http://docs.aws.amazon.com/redshift/latest/mgmt/working-with-clusters.html)
  in the *Amazon Redshift Cluster Management Guide* .

  You can also change node type and the number of nodes to scale up or down
  the cluster. When resizing a cluster, you must specify both the number of
  nodes and the node type even if one of the parameters does not change.
  """

  @spec modify_cluster(client :: ExAws.Redshift.t, input :: modify_cluster_message) :: ExAws.Request.Query.response_t
  def modify_cluster(client, input) do
    request(client, "/", "ModifyCluster", input)
  end

  @doc """
  Same as `modify_cluster/2` but raise on error.
  """
  @spec modify_cluster!(client :: ExAws.Redshift.t, input :: modify_cluster_message) :: ExAws.Request.Query.success_t | no_return
  def modify_cluster!(client, input) do
    case modify_cluster(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ModifyClusterParameterGroup

  Modifies the parameters of a parameter group.

  For more information about parameters and parameter groups, go to [Amazon
  Redshift Parameter
  Groups](http://docs.aws.amazon.com/redshift/latest/mgmt/working-with-parameter-groups.html)
  in the *Amazon Redshift Cluster Management Guide*.
  """

  @spec modify_cluster_parameter_group(client :: ExAws.Redshift.t, input :: modify_cluster_parameter_group_message) :: ExAws.Request.Query.response_t
  def modify_cluster_parameter_group(client, input) do
    request(client, "/", "ModifyClusterParameterGroup", input)
  end

  @doc """
  Same as `modify_cluster_parameter_group/2` but raise on error.
  """
  @spec modify_cluster_parameter_group!(client :: ExAws.Redshift.t, input :: modify_cluster_parameter_group_message) :: ExAws.Request.Query.success_t | no_return
  def modify_cluster_parameter_group!(client, input) do
    case modify_cluster_parameter_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ModifyClusterSubnetGroup

  Modifies a cluster subnet group to include the specified list of VPC
  subnets. The operation replaces the existing list of subnets with the new
  list of subnets.
  """

  @spec modify_cluster_subnet_group(client :: ExAws.Redshift.t, input :: modify_cluster_subnet_group_message) :: ExAws.Request.Query.response_t
  def modify_cluster_subnet_group(client, input) do
    request(client, "/", "ModifyClusterSubnetGroup", input)
  end

  @doc """
  Same as `modify_cluster_subnet_group/2` but raise on error.
  """
  @spec modify_cluster_subnet_group!(client :: ExAws.Redshift.t, input :: modify_cluster_subnet_group_message) :: ExAws.Request.Query.success_t | no_return
  def modify_cluster_subnet_group!(client, input) do
    case modify_cluster_subnet_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ModifyEventSubscription

  Modifies an existing Amazon Redshift event notification subscription.
  """

  @spec modify_event_subscription(client :: ExAws.Redshift.t, input :: modify_event_subscription_message) :: ExAws.Request.Query.response_t
  def modify_event_subscription(client, input) do
    request(client, "/", "ModifyEventSubscription", input)
  end

  @doc """
  Same as `modify_event_subscription/2` but raise on error.
  """
  @spec modify_event_subscription!(client :: ExAws.Redshift.t, input :: modify_event_subscription_message) :: ExAws.Request.Query.success_t | no_return
  def modify_event_subscription!(client, input) do
    case modify_event_subscription(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ModifySnapshotCopyRetentionPeriod

  Modifies the number of days to retain automated snapshots in the
  destination region after they are copied from the source region.
  """

  @spec modify_snapshot_copy_retention_period(client :: ExAws.Redshift.t, input :: modify_snapshot_copy_retention_period_message) :: ExAws.Request.Query.response_t
  def modify_snapshot_copy_retention_period(client, input) do
    request(client, "/", "ModifySnapshotCopyRetentionPeriod", input)
  end

  @doc """
  Same as `modify_snapshot_copy_retention_period/2` but raise on error.
  """
  @spec modify_snapshot_copy_retention_period!(client :: ExAws.Redshift.t, input :: modify_snapshot_copy_retention_period_message) :: ExAws.Request.Query.success_t | no_return
  def modify_snapshot_copy_retention_period!(client, input) do
    case modify_snapshot_copy_retention_period(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  PurchaseReservedNodeOffering

  Allows you to purchase reserved nodes. Amazon Redshift offers a predefined
  set of reserved node offerings. You can purchase one or more of the
  offerings. You can call the `DescribeReservedNodeOfferings` API to obtain
  the available reserved node offerings. You can call this API by providing a
  specific reserved node offering and the number of nodes you want to
  reserve.

  For more information about reserved node offerings, go to [Purchasing
  Reserved
  Nodes](http://docs.aws.amazon.com/redshift/latest/mgmt/purchase-reserved-node-instance.html)
  in the *Amazon Redshift Cluster Management Guide*.
  """

  @spec purchase_reserved_node_offering(client :: ExAws.Redshift.t, input :: purchase_reserved_node_offering_message) :: ExAws.Request.Query.response_t
  def purchase_reserved_node_offering(client, input) do
    request(client, "/", "PurchaseReservedNodeOffering", input)
  end

  @doc """
  Same as `purchase_reserved_node_offering/2` but raise on error.
  """
  @spec purchase_reserved_node_offering!(client :: ExAws.Redshift.t, input :: purchase_reserved_node_offering_message) :: ExAws.Request.Query.success_t | no_return
  def purchase_reserved_node_offering!(client, input) do
    case purchase_reserved_node_offering(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RebootCluster

  Reboots a cluster. This action is taken as soon as possible. It results in
  a momentary outage to the cluster, during which the cluster status is set
  to `rebooting`. A cluster event is created when the reboot is completed.
  Any pending cluster modifications (see `ModifyCluster`) are applied at this
  reboot. For more information about managing clusters, go to [Amazon
  Redshift
  Clusters](http://docs.aws.amazon.com/redshift/latest/mgmt/working-with-clusters.html)
  in the *Amazon Redshift Cluster Management Guide*
  """

  @spec reboot_cluster(client :: ExAws.Redshift.t, input :: reboot_cluster_message) :: ExAws.Request.Query.response_t
  def reboot_cluster(client, input) do
    request(client, "/", "RebootCluster", input)
  end

  @doc """
  Same as `reboot_cluster/2` but raise on error.
  """
  @spec reboot_cluster!(client :: ExAws.Redshift.t, input :: reboot_cluster_message) :: ExAws.Request.Query.success_t | no_return
  def reboot_cluster!(client, input) do
    case reboot_cluster(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ResetClusterParameterGroup

  Sets one or more parameters of the specified parameter group to their
  default values and sets the source values of the parameters to
  "engine-default". To reset the entire parameter group specify the
  *ResetAllParameters* parameter. For parameter changes to take effect you
  must reboot any associated clusters.
  """

  @spec reset_cluster_parameter_group(client :: ExAws.Redshift.t, input :: reset_cluster_parameter_group_message) :: ExAws.Request.Query.response_t
  def reset_cluster_parameter_group(client, input) do
    request(client, "/", "ResetClusterParameterGroup", input)
  end

  @doc """
  Same as `reset_cluster_parameter_group/2` but raise on error.
  """
  @spec reset_cluster_parameter_group!(client :: ExAws.Redshift.t, input :: reset_cluster_parameter_group_message) :: ExAws.Request.Query.success_t | no_return
  def reset_cluster_parameter_group!(client, input) do
    case reset_cluster_parameter_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RestoreFromClusterSnapshot

  Creates a new cluster from a snapshot. By default, Amazon Redshift creates
  the resulting cluster with the same configuration as the original cluster
  from which the snapshot was created, except that the new cluster is created
  with the default cluster security and parameter groups. After Amazon
  Redshift creates the cluster, you can use the `ModifyCluster` API to
  associate a different security group and different parameter group with the
  restored cluster. If you are using a DS node type, you can also choose to
  change to another DS node type of the same size during restore.

  If you restore a cluster into a VPC, you must provide a cluster subnet
  group where you want the cluster restored.

  For more information about working with snapshots, go to [Amazon Redshift
  Snapshots](http://docs.aws.amazon.com/redshift/latest/mgmt/working-with-snapshots.html)
  in the *Amazon Redshift Cluster Management Guide*.
  """

  @spec restore_from_cluster_snapshot(client :: ExAws.Redshift.t, input :: restore_from_cluster_snapshot_message) :: ExAws.Request.Query.response_t
  def restore_from_cluster_snapshot(client, input) do
    request(client, "/", "RestoreFromClusterSnapshot", input)
  end

  @doc """
  Same as `restore_from_cluster_snapshot/2` but raise on error.
  """
  @spec restore_from_cluster_snapshot!(client :: ExAws.Redshift.t, input :: restore_from_cluster_snapshot_message) :: ExAws.Request.Query.success_t | no_return
  def restore_from_cluster_snapshot!(client, input) do
    case restore_from_cluster_snapshot(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RevokeClusterSecurityGroupIngress

  Revokes an ingress rule in an Amazon Redshift security group for a
  previously authorized IP range or Amazon EC2 security group. To add an
  ingress rule, see `AuthorizeClusterSecurityGroupIngress`. For information
  about managing security groups, go to [Amazon Redshift Cluster Security
  Groups](http://docs.aws.amazon.com/redshift/latest/mgmt/working-with-security-groups.html)
  in the *Amazon Redshift Cluster Management Guide*.
  """

  @spec revoke_cluster_security_group_ingress(client :: ExAws.Redshift.t, input :: revoke_cluster_security_group_ingress_message) :: ExAws.Request.Query.response_t
  def revoke_cluster_security_group_ingress(client, input) do
    request(client, "/", "RevokeClusterSecurityGroupIngress", input)
  end

  @doc """
  Same as `revoke_cluster_security_group_ingress/2` but raise on error.
  """
  @spec revoke_cluster_security_group_ingress!(client :: ExAws.Redshift.t, input :: revoke_cluster_security_group_ingress_message) :: ExAws.Request.Query.success_t | no_return
  def revoke_cluster_security_group_ingress!(client, input) do
    case revoke_cluster_security_group_ingress(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RevokeSnapshotAccess

  Removes the ability of the specified AWS customer account to restore the
  specified snapshot. If the account is currently restoring the snapshot, the
  restore will run to completion.

  For more information about working with snapshots, go to [Amazon Redshift
  Snapshots](http://docs.aws.amazon.com/redshift/latest/mgmt/working-with-snapshots.html)
  in the *Amazon Redshift Cluster Management Guide*.
  """

  @spec revoke_snapshot_access(client :: ExAws.Redshift.t, input :: revoke_snapshot_access_message) :: ExAws.Request.Query.response_t
  def revoke_snapshot_access(client, input) do
    request(client, "/", "RevokeSnapshotAccess", input)
  end

  @doc """
  Same as `revoke_snapshot_access/2` but raise on error.
  """
  @spec revoke_snapshot_access!(client :: ExAws.Redshift.t, input :: revoke_snapshot_access_message) :: ExAws.Request.Query.success_t | no_return
  def revoke_snapshot_access!(client, input) do
    case revoke_snapshot_access(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RotateEncryptionKey

  Rotates the encryption keys for a cluster.
  """

  @spec rotate_encryption_key(client :: ExAws.Redshift.t, input :: rotate_encryption_key_message) :: ExAws.Request.Query.response_t
  def rotate_encryption_key(client, input) do
    request(client, "/", "RotateEncryptionKey", input)
  end

  @doc """
  Same as `rotate_encryption_key/2` but raise on error.
  """
  @spec rotate_encryption_key!(client :: ExAws.Redshift.t, input :: rotate_encryption_key_message) :: ExAws.Request.Query.success_t | no_return
  def rotate_encryption_key!(client, input) do
    case rotate_encryption_key(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  defp request(%{__struct__: client_module} = client, uri, action, input) do
    apply(client_module, :request, [client, uri, action, input])
  end
end
