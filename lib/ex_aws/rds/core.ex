defmodule ExAws.RDS.Core do
  @actions [
    "AddSourceIdentifierToSubscription",
    "AddTagsToResource",
    "ApplyPendingMaintenanceAction",
    "AuthorizeDBSecurityGroupIngress",
    "CopyDBClusterSnapshot",
    "CopyDBParameterGroup",
    "CopyDBSnapshot",
    "CopyOptionGroup",
    "CreateDBCluster",
    "CreateDBClusterParameterGroup",
    "CreateDBClusterSnapshot",
    "CreateDBInstance",
    "CreateDBInstanceReadReplica",
    "CreateDBParameterGroup",
    "CreateDBSecurityGroup",
    "CreateDBSnapshot",
    "CreateDBSubnetGroup",
    "CreateEventSubscription",
    "CreateOptionGroup",
    "DeleteDBCluster",
    "DeleteDBClusterParameterGroup",
    "DeleteDBClusterSnapshot",
    "DeleteDBInstance",
    "DeleteDBParameterGroup",
    "DeleteDBSecurityGroup",
    "DeleteDBSnapshot",
    "DeleteDBSubnetGroup",
    "DeleteEventSubscription",
    "DeleteOptionGroup",
    "DescribeAccountAttributes",
    "DescribeCertificates",
    "DescribeDBClusterParameterGroups",
    "DescribeDBClusterParameters",
    "DescribeDBClusterSnapshots",
    "DescribeDBClusters",
    "DescribeDBEngineVersions",
    "DescribeDBInstances",
    "DescribeDBLogFiles",
    "DescribeDBParameterGroups",
    "DescribeDBParameters",
    "DescribeDBSecurityGroups",
    "DescribeDBSnapshots",
    "DescribeDBSubnetGroups",
    "DescribeEngineDefaultClusterParameters",
    "DescribeEngineDefaultParameters",
    "DescribeEventCategories",
    "DescribeEventSubscriptions",
    "DescribeEvents",
    "DescribeOptionGroupOptions",
    "DescribeOptionGroups",
    "DescribeOrderableDBInstanceOptions",
    "DescribePendingMaintenanceActions",
    "DescribeReservedDBInstances",
    "DescribeReservedDBInstancesOfferings",
    "DownloadDBLogFilePortion",
    "FailoverDBCluster",
    "ListTagsForResource",
    "ModifyDBCluster",
    "ModifyDBClusterParameterGroup",
    "ModifyDBInstance",
    "ModifyDBParameterGroup",
    "ModifyDBSubnetGroup",
    "ModifyEventSubscription",
    "ModifyOptionGroup",
    "PromoteReadReplica",
    "PurchaseReservedDBInstancesOffering",
    "RebootDBInstance",
    "RemoveSourceIdentifierFromSubscription",
    "RemoveTagsFromResource",
    "ResetDBClusterParameterGroup",
    "ResetDBParameterGroup",
    "RestoreDBClusterFromSnapshot",
    "RestoreDBClusterToPointInTime",
    "RestoreDBInstanceFromDBSnapshot",
    "RestoreDBInstanceToPointInTime",
    "RevokeDBSecurityGroupIngress"]

  @moduledoc """
  ## Amazon Relational Database Service

  Amazon Relational Database Service

  Amazon Relational Database Service (Amazon RDS) is a web service that makes
  it easier to set up, operate, and scale a relational database in the cloud.
  It provides cost-efficient, resizeable capacity for an industry-standard
  relational database and manages common database administration tasks,
  freeing up developers to focus on what makes their applications and
  businesses unique.

  Amazon RDS gives you access to the capabilities of a MySQL, PostgreSQL,
  Microsoft SQL Server, Oracle, or Aurora database server. This means the
  code, applications, and tools you already use today with your existing
  databases work with Amazon RDS without modification. Amazon RDS
  automatically backs up your database and maintains the database software
  that powers your DB instance. Amazon RDS is flexible: you can scale your
  database instance's compute resources and storage capacity to meet your
  application's demand. As with all Amazon Web Services, there are no
  up-front investments, and you pay only for the resources you use.

  This is an interface reference for Amazon RDS. It contains documentation
  for a programming or command line interface you can use to manage Amazon
  RDS. Note that Amazon RDS is asynchronous, which means that some interfaces
  might require techniques such as polling or callback functions to determine
  when a command has been applied. In this reference, the parameter
  descriptions indicate whether a command is applied immediately, on the next
  instance reboot, or during the maintenance window. For a summary of the
  Amazon RDS interfaces, go to [Available RDS
  Interfaces](http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Welcome.html#Welcome.Interfaces).
  """

  @type account_attributes_message :: [
    account_quotas: account_quota_list,
  ]

  @type account_quota :: [
    account_quota_name: binary,
    max: long,
    used: long,
  ]

  @type account_quota_list :: [account_quota]

  @type add_source_identifier_to_subscription_message :: [
    source_identifier: binary,
    subscription_name: binary,
  ]

  @type add_source_identifier_to_subscription_result :: [
    event_subscription: event_subscription,
  ]

  @type add_tags_to_resource_message :: [
    resource_name: binary,
    tags: tag_list,
  ]

  @type apply_method :: binary

  @type apply_pending_maintenance_action_message :: [
    apply_action: binary,
    opt_in_type: binary,
    resource_identifier: binary,
  ]

  @type apply_pending_maintenance_action_result :: [
    resource_pending_maintenance_actions: resource_pending_maintenance_actions,
  ]

  @type authorization_already_exists_fault :: [
  ]

  @type authorization_not_found_fault :: [
  ]

  @type authorization_quota_exceeded_fault :: [
  ]

  @type authorize_db_security_group_ingress_message :: [
    cidrip: binary,
    db_security_group_name: binary,
    e_c2_security_group_id: binary,
    e_c2_security_group_name: binary,
    e_c2_security_group_owner_id: binary,
  ]

  @type authorize_db_security_group_ingress_result :: [
    db_security_group: db_security_group,
  ]

  @type availability_zone :: [
    name: binary,
  ]

  @type availability_zone_list :: [availability_zone]

  @type availability_zones :: [binary]

  @type boolean_optional :: boolean

  @type certificate :: [
    certificate_identifier: binary,
    certificate_type: binary,
    thumbprint: binary,
    valid_from: t_stamp,
    valid_till: t_stamp,
  ]

  @type certificate_list :: [certificate]

  @type certificate_message :: [
    certificates: certificate_list,
    marker: binary,
  ]

  @type certificate_not_found_fault :: [
  ]

  @type character_set :: [
    character_set_description: binary,
    character_set_name: binary,
  ]

  @type copy_db_cluster_snapshot_message :: [
    source_db_cluster_snapshot_identifier: binary,
    tags: tag_list,
    target_db_cluster_snapshot_identifier: binary,
  ]

  @type copy_db_cluster_snapshot_result :: [
    db_cluster_snapshot: db_cluster_snapshot,
  ]

  @type copy_db_parameter_group_message :: [
    source_db_parameter_group_identifier: binary,
    tags: tag_list,
    target_db_parameter_group_description: binary,
    target_db_parameter_group_identifier: binary,
  ]

  @type copy_db_parameter_group_result :: [
    db_parameter_group: db_parameter_group,
  ]

  @type copy_db_snapshot_message :: [
    source_db_snapshot_identifier: binary,
    tags: tag_list,
    target_db_snapshot_identifier: binary,
  ]

  @type copy_db_snapshot_result :: [
    db_snapshot: db_snapshot,
  ]

  @type copy_option_group_message :: [
    source_option_group_identifier: binary,
    tags: tag_list,
    target_option_group_description: binary,
    target_option_group_identifier: binary,
  ]

  @type copy_option_group_result :: [
    option_group: option_group,
  ]

  @type create_db_cluster_message :: [
    availability_zones: availability_zones,
    backup_retention_period: integer_optional,
    character_set_name: binary,
    db_cluster_identifier: binary,
    db_cluster_parameter_group_name: binary,
    db_subnet_group_name: binary,
    database_name: binary,
    engine: binary,
    engine_version: binary,
    master_user_password: binary,
    master_username: binary,
    option_group_name: binary,
    port: integer_optional,
    preferred_backup_window: binary,
    preferred_maintenance_window: binary,
    tags: tag_list,
    vpc_security_group_ids: vpc_security_group_id_list,
  ]

  @type create_db_cluster_parameter_group_message :: [
    db_cluster_parameter_group_name: binary,
    db_parameter_group_family: binary,
    description: binary,
    tags: tag_list,
  ]

  @type create_db_cluster_parameter_group_result :: [
    db_cluster_parameter_group: db_cluster_parameter_group,
  ]

  @type create_db_cluster_result :: [
    db_cluster: db_cluster,
  ]

  @type create_db_cluster_snapshot_message :: [
    db_cluster_identifier: binary,
    db_cluster_snapshot_identifier: binary,
    tags: tag_list,
  ]

  @type create_db_cluster_snapshot_result :: [
    db_cluster_snapshot: db_cluster_snapshot,
  ]

  @type create_db_instance_message :: [
    allocated_storage: integer_optional,
    auto_minor_version_upgrade: boolean_optional,
    availability_zone: binary,
    backup_retention_period: integer_optional,
    character_set_name: binary,
    db_cluster_identifier: binary,
    db_instance_class: binary,
    db_instance_identifier: binary,
    db_name: binary,
    db_parameter_group_name: binary,
    db_security_groups: db_security_group_name_list,
    db_subnet_group_name: binary,
    engine: binary,
    engine_version: binary,
    iops: integer_optional,
    kms_key_id: binary,
    license_model: binary,
    master_user_password: binary,
    master_username: binary,
    multi_az: boolean_optional,
    option_group_name: binary,
    port: integer_optional,
    preferred_backup_window: binary,
    preferred_maintenance_window: binary,
    publicly_accessible: boolean_optional,
    storage_encrypted: boolean_optional,
    storage_type: binary,
    tags: tag_list,
    tde_credential_arn: binary,
    tde_credential_password: binary,
    vpc_security_group_ids: vpc_security_group_id_list,
  ]

  @type create_db_instance_read_replica_message :: [
    auto_minor_version_upgrade: boolean_optional,
    availability_zone: binary,
    db_instance_class: binary,
    db_instance_identifier: binary,
    db_subnet_group_name: binary,
    iops: integer_optional,
    option_group_name: binary,
    port: integer_optional,
    publicly_accessible: boolean_optional,
    source_db_instance_identifier: binary,
    storage_type: binary,
    tags: tag_list,
  ]

  @type create_db_instance_read_replica_result :: [
    db_instance: db_instance,
  ]

  @type create_db_instance_result :: [
    db_instance: db_instance,
  ]

  @type create_db_parameter_group_message :: [
    db_parameter_group_family: binary,
    db_parameter_group_name: binary,
    description: binary,
    tags: tag_list,
  ]

  @type create_db_parameter_group_result :: [
    db_parameter_group: db_parameter_group,
  ]

  @type create_db_security_group_message :: [
    db_security_group_description: binary,
    db_security_group_name: binary,
    tags: tag_list,
  ]

  @type create_db_security_group_result :: [
    db_security_group: db_security_group,
  ]

  @type create_db_snapshot_message :: [
    db_instance_identifier: binary,
    db_snapshot_identifier: binary,
    tags: tag_list,
  ]

  @type create_db_snapshot_result :: [
    db_snapshot: db_snapshot,
  ]

  @type create_db_subnet_group_message :: [
    db_subnet_group_description: binary,
    db_subnet_group_name: binary,
    subnet_ids: subnet_identifier_list,
    tags: tag_list,
  ]

  @type create_db_subnet_group_result :: [
    db_subnet_group: db_subnet_group,
  ]

  @type create_event_subscription_message :: [
    enabled: boolean_optional,
    event_categories: event_categories_list,
    sns_topic_arn: binary,
    source_ids: source_ids_list,
    source_type: binary,
    subscription_name: binary,
    tags: tag_list,
  ]

  @type create_event_subscription_result :: [
    event_subscription: event_subscription,
  ]

  @type create_option_group_message :: [
    engine_name: binary,
    major_engine_version: binary,
    option_group_description: binary,
    option_group_name: binary,
    tags: tag_list,
  ]

  @type create_option_group_result :: [
    option_group: option_group,
  ]

  @type db_cluster :: [
    allocated_storage: integer_optional,
    availability_zones: availability_zones,
    backup_retention_period: integer_optional,
    character_set_name: binary,
    db_cluster_identifier: binary,
    db_cluster_members: db_cluster_member_list,
    db_cluster_option_group_memberships: db_cluster_option_group_memberships,
    db_cluster_parameter_group: binary,
    db_subnet_group: binary,
    database_name: binary,
    earliest_restorable_time: t_stamp,
    endpoint: binary,
    engine: binary,
    engine_version: binary,
    latest_restorable_time: t_stamp,
    master_username: binary,
    percent_progress: binary,
    port: integer_optional,
    preferred_backup_window: binary,
    preferred_maintenance_window: binary,
    status: binary,
    vpc_security_groups: vpc_security_group_membership_list,
  ]

  @type db_cluster_already_exists_fault :: [
  ]

  @type db_cluster_list :: [db_cluster]

  @type db_cluster_member :: [
    db_cluster_parameter_group_status: binary,
    db_instance_identifier: binary,
    is_cluster_writer: boolean,
  ]

  @type db_cluster_member_list :: [db_cluster_member]

  @type db_cluster_message :: [
    db_clusters: db_cluster_list,
    marker: binary,
  ]

  @type db_cluster_not_found_fault :: [
  ]

  @type db_cluster_option_group_memberships :: [db_cluster_option_group_status]

  @type db_cluster_option_group_status :: [
    db_cluster_option_group_name: binary,
    status: binary,
  ]

  @type db_cluster_parameter_group :: [
    db_cluster_parameter_group_name: binary,
    db_parameter_group_family: binary,
    description: binary,
  ]

  @type db_cluster_parameter_group_details :: [
    marker: binary,
    parameters: parameters_list,
  ]

  @type db_cluster_parameter_group_list :: [db_cluster_parameter_group]

  @type db_cluster_parameter_group_name_message :: [
    db_cluster_parameter_group_name: binary,
  ]

  @type db_cluster_parameter_group_not_found_fault :: [
  ]

  @type db_cluster_parameter_groups_message :: [
    db_cluster_parameter_groups: db_cluster_parameter_group_list,
    marker: binary,
  ]

  @type db_cluster_quota_exceeded_fault :: [
  ]

  @type db_cluster_snapshot :: [
    allocated_storage: integer,
    availability_zones: availability_zones,
    cluster_create_time: t_stamp,
    db_cluster_identifier: binary,
    db_cluster_snapshot_identifier: binary,
    engine: binary,
    engine_version: binary,
    license_model: binary,
    master_username: binary,
    percent_progress: integer,
    port: integer,
    snapshot_create_time: t_stamp,
    snapshot_type: binary,
    status: binary,
    vpc_id: binary,
  ]

  @type db_cluster_snapshot_already_exists_fault :: [
  ]

  @type db_cluster_snapshot_list :: [db_cluster_snapshot]

  @type db_cluster_snapshot_message :: [
    db_cluster_snapshots: db_cluster_snapshot_list,
    marker: binary,
  ]

  @type db_cluster_snapshot_not_found_fault :: [
  ]

  @type db_engine_version :: [
    db_engine_description: binary,
    db_engine_version_description: binary,
    db_parameter_group_family: binary,
    default_character_set: character_set,
    engine: binary,
    engine_version: binary,
    supported_character_sets: supported_character_sets_list,
  ]

  @type db_engine_version_list :: [db_engine_version]

  @type db_engine_version_message :: [
    db_engine_versions: db_engine_version_list,
    marker: binary,
  ]

  @type db_instance :: [
    allocated_storage: integer,
    auto_minor_version_upgrade: boolean,
    availability_zone: binary,
    backup_retention_period: integer,
    ca_certificate_identifier: binary,
    character_set_name: binary,
    db_cluster_identifier: binary,
    db_instance_class: binary,
    db_instance_identifier: binary,
    db_instance_status: binary,
    db_name: binary,
    db_parameter_groups: db_parameter_group_status_list,
    db_security_groups: db_security_group_membership_list,
    db_subnet_group: db_subnet_group,
    db_instance_port: integer,
    dbi_resource_id: binary,
    endpoint: endpoint,
    engine: binary,
    engine_version: binary,
    instance_create_time: t_stamp,
    iops: integer_optional,
    kms_key_id: binary,
    latest_restorable_time: t_stamp,
    license_model: binary,
    master_username: binary,
    multi_az: boolean,
    option_group_memberships: option_group_membership_list,
    pending_modified_values: pending_modified_values,
    preferred_backup_window: binary,
    preferred_maintenance_window: binary,
    publicly_accessible: boolean,
    read_replica_db_instance_identifiers: read_replica_db_instance_identifier_list,
    read_replica_source_db_instance_identifier: binary,
    secondary_availability_zone: binary,
    status_infos: db_instance_status_info_list,
    storage_encrypted: boolean,
    storage_type: binary,
    tde_credential_arn: binary,
    vpc_security_groups: vpc_security_group_membership_list,
  ]

  @type db_instance_already_exists_fault :: [
  ]

  @type db_instance_list :: [db_instance]

  @type db_instance_message :: [
    db_instances: db_instance_list,
    marker: binary,
  ]

  @type db_instance_not_found_fault :: [
  ]

  @type db_instance_status_info :: [
    message: binary,
    normal: boolean,
    status: binary,
    status_type: binary,
  ]

  @type db_instance_status_info_list :: [db_instance_status_info]

  @type db_log_file_not_found_fault :: [
  ]

  @type db_parameter_group :: [
    db_parameter_group_family: binary,
    db_parameter_group_name: binary,
    description: binary,
  ]

  @type db_parameter_group_already_exists_fault :: [
  ]

  @type db_parameter_group_details :: [
    marker: binary,
    parameters: parameters_list,
  ]

  @type db_parameter_group_list :: [db_parameter_group]

  @type db_parameter_group_name_message :: [
    db_parameter_group_name: binary,
  ]

  @type db_parameter_group_not_found_fault :: [
  ]

  @type db_parameter_group_quota_exceeded_fault :: [
  ]

  @type db_parameter_group_status :: [
    db_parameter_group_name: binary,
    parameter_apply_status: binary,
  ]

  @type db_parameter_group_status_list :: [db_parameter_group_status]

  @type db_parameter_groups_message :: [
    db_parameter_groups: db_parameter_group_list,
    marker: binary,
  ]

  @type db_security_group :: [
    db_security_group_description: binary,
    db_security_group_name: binary,
    e_c2_security_groups: ec2_security_group_list,
    ip_ranges: ip_range_list,
    owner_id: binary,
    vpc_id: binary,
  ]

  @type db_security_group_already_exists_fault :: [
  ]

  @type db_security_group_membership :: [
    db_security_group_name: binary,
    status: binary,
  ]

  @type db_security_group_membership_list :: [db_security_group_membership]

  @type db_security_group_message :: [
    db_security_groups: db_security_groups,
    marker: binary,
  ]

  @type db_security_group_name_list :: [binary]

  @type db_security_group_not_found_fault :: [
  ]

  @type db_security_group_not_supported_fault :: [
  ]

  @type db_security_group_quota_exceeded_fault :: [
  ]

  @type db_security_groups :: [db_security_group]

  @type db_snapshot :: [
    allocated_storage: integer,
    availability_zone: binary,
    db_instance_identifier: binary,
    db_snapshot_identifier: binary,
    encrypted: boolean,
    engine: binary,
    engine_version: binary,
    instance_create_time: t_stamp,
    iops: integer_optional,
    kms_key_id: binary,
    license_model: binary,
    master_username: binary,
    option_group_name: binary,
    percent_progress: integer,
    port: integer,
    snapshot_create_time: t_stamp,
    snapshot_type: binary,
    source_db_snapshot_identifier: binary,
    source_region: binary,
    status: binary,
    storage_type: binary,
    tde_credential_arn: binary,
    vpc_id: binary,
  ]

  @type db_snapshot_already_exists_fault :: [
  ]

  @type db_snapshot_list :: [db_snapshot]

  @type db_snapshot_message :: [
    db_snapshots: db_snapshot_list,
    marker: binary,
  ]

  @type db_snapshot_not_found_fault :: [
  ]

  @type db_subnet_group :: [
    db_subnet_group_description: binary,
    db_subnet_group_name: binary,
    subnet_group_status: binary,
    subnets: subnet_list,
    vpc_id: binary,
  ]

  @type db_subnet_group_already_exists_fault :: [
  ]

  @type db_subnet_group_does_not_cover_enough_a_zs :: [
  ]

  @type db_subnet_group_message :: [
    db_subnet_groups: db_subnet_groups,
    marker: binary,
  ]

  @type db_subnet_group_not_allowed_fault :: [
  ]

  @type db_subnet_group_not_found_fault :: [
  ]

  @type db_subnet_group_quota_exceeded_fault :: [
  ]

  @type db_subnet_groups :: [db_subnet_group]

  @type db_subnet_quota_exceeded_fault :: [
  ]

  @type db_upgrade_dependency_failure_fault :: [
  ]

  @type delete_db_cluster_message :: [
    db_cluster_identifier: binary,
    final_db_snapshot_identifier: binary,
    skip_final_snapshot: boolean,
  ]

  @type delete_db_cluster_parameter_group_message :: [
    db_cluster_parameter_group_name: binary,
  ]

  @type delete_db_cluster_result :: [
    db_cluster: db_cluster,
  ]

  @type delete_db_cluster_snapshot_message :: [
    db_cluster_snapshot_identifier: binary,
  ]

  @type delete_db_cluster_snapshot_result :: [
    db_cluster_snapshot: db_cluster_snapshot,
  ]

  @type delete_db_instance_message :: [
    db_instance_identifier: binary,
    final_db_snapshot_identifier: binary,
    skip_final_snapshot: boolean,
  ]

  @type delete_db_instance_result :: [
    db_instance: db_instance,
  ]

  @type delete_db_parameter_group_message :: [
    db_parameter_group_name: binary,
  ]

  @type delete_db_security_group_message :: [
    db_security_group_name: binary,
  ]

  @type delete_db_snapshot_message :: [
    db_snapshot_identifier: binary,
  ]

  @type delete_db_snapshot_result :: [
    db_snapshot: db_snapshot,
  ]

  @type delete_db_subnet_group_message :: [
    db_subnet_group_name: binary,
  ]

  @type delete_event_subscription_message :: [
    subscription_name: binary,
  ]

  @type delete_event_subscription_result :: [
    event_subscription: event_subscription,
  ]

  @type delete_option_group_message :: [
    option_group_name: binary,
  ]

  @type describe_account_attributes_message :: [
  ]

  @type describe_certificates_message :: [
    certificate_identifier: binary,
    filters: filter_list,
    marker: binary,
    max_records: integer_optional,
  ]

  @type describe_db_cluster_parameter_groups_message :: [
    db_cluster_parameter_group_name: binary,
    filters: filter_list,
    marker: binary,
    max_records: integer_optional,
  ]

  @type describe_db_cluster_parameters_message :: [
    db_cluster_parameter_group_name: binary,
    filters: filter_list,
    marker: binary,
    max_records: integer_optional,
    source: binary,
  ]

  @type describe_db_cluster_snapshots_message :: [
    db_cluster_identifier: binary,
    db_cluster_snapshot_identifier: binary,
    filters: filter_list,
    marker: binary,
    max_records: integer_optional,
    snapshot_type: binary,
  ]

  @type describe_db_clusters_message :: [
    db_cluster_identifier: binary,
    filters: filter_list,
    marker: binary,
    max_records: integer_optional,
  ]

  @type describe_db_engine_versions_message :: [
    db_parameter_group_family: binary,
    default_only: boolean,
    engine: binary,
    engine_version: binary,
    filters: filter_list,
    list_supported_character_sets: boolean_optional,
    marker: binary,
    max_records: integer_optional,
  ]

  @type describe_db_instances_message :: [
    db_instance_identifier: binary,
    filters: filter_list,
    marker: binary,
    max_records: integer_optional,
  ]

  @type describe_db_log_files_details :: [
    last_written: long,
    log_file_name: binary,
    size: long,
  ]

  @type describe_db_log_files_list :: [describe_db_log_files_details]

  @type describe_db_log_files_message :: [
    db_instance_identifier: binary,
    file_last_written: long,
    file_size: long,
    filename_contains: binary,
    filters: filter_list,
    marker: binary,
    max_records: integer_optional,
  ]

  @type describe_db_log_files_response :: [
    describe_db_log_files: describe_db_log_files_list,
    marker: binary,
  ]

  @type describe_db_parameter_groups_message :: [
    db_parameter_group_name: binary,
    filters: filter_list,
    marker: binary,
    max_records: integer_optional,
  ]

  @type describe_db_parameters_message :: [
    db_parameter_group_name: binary,
    filters: filter_list,
    marker: binary,
    max_records: integer_optional,
    source: binary,
  ]

  @type describe_db_security_groups_message :: [
    db_security_group_name: binary,
    filters: filter_list,
    marker: binary,
    max_records: integer_optional,
  ]

  @type describe_db_snapshots_message :: [
    db_instance_identifier: binary,
    db_snapshot_identifier: binary,
    filters: filter_list,
    marker: binary,
    max_records: integer_optional,
    snapshot_type: binary,
  ]

  @type describe_db_subnet_groups_message :: [
    db_subnet_group_name: binary,
    filters: filter_list,
    marker: binary,
    max_records: integer_optional,
  ]

  @type describe_engine_default_cluster_parameters_message :: [
    db_parameter_group_family: binary,
    filters: filter_list,
    marker: binary,
    max_records: integer_optional,
  ]

  @type describe_engine_default_cluster_parameters_result :: [
    engine_defaults: engine_defaults,
  ]

  @type describe_engine_default_parameters_message :: [
    db_parameter_group_family: binary,
    filters: filter_list,
    marker: binary,
    max_records: integer_optional,
  ]

  @type describe_engine_default_parameters_result :: [
    engine_defaults: engine_defaults,
  ]

  @type describe_event_categories_message :: [
    filters: filter_list,
    source_type: binary,
  ]

  @type describe_event_subscriptions_message :: [
    filters: filter_list,
    marker: binary,
    max_records: integer_optional,
    subscription_name: binary,
  ]

  @type describe_events_message :: [
    duration: integer_optional,
    end_time: t_stamp,
    event_categories: event_categories_list,
    filters: filter_list,
    marker: binary,
    max_records: integer_optional,
    source_identifier: binary,
    source_type: source_type,
    start_time: t_stamp,
  ]

  @type describe_option_group_options_message :: [
    engine_name: binary,
    filters: filter_list,
    major_engine_version: binary,
    marker: binary,
    max_records: integer_optional,
  ]

  @type describe_option_groups_message :: [
    engine_name: binary,
    filters: filter_list,
    major_engine_version: binary,
    marker: binary,
    max_records: integer_optional,
    option_group_name: binary,
  ]

  @type describe_orderable_db_instance_options_message :: [
    db_instance_class: binary,
    engine: binary,
    engine_version: binary,
    filters: filter_list,
    license_model: binary,
    marker: binary,
    max_records: integer_optional,
    vpc: boolean_optional,
  ]

  @type describe_pending_maintenance_actions_message :: [
    filters: filter_list,
    marker: binary,
    max_records: integer_optional,
    resource_identifier: binary,
  ]

  @type describe_reserved_db_instances_message :: [
    db_instance_class: binary,
    duration: binary,
    filters: filter_list,
    marker: binary,
    max_records: integer_optional,
    multi_az: boolean_optional,
    offering_type: binary,
    product_description: binary,
    reserved_db_instance_id: binary,
    reserved_db_instances_offering_id: binary,
  ]

  @type describe_reserved_db_instances_offerings_message :: [
    db_instance_class: binary,
    duration: binary,
    filters: filter_list,
    marker: binary,
    max_records: integer_optional,
    multi_az: boolean_optional,
    offering_type: binary,
    product_description: binary,
    reserved_db_instances_offering_id: binary,
  ]

  @type double :: float

  @type download_db_log_file_portion_details :: [
    additional_data_pending: boolean,
    log_file_data: binary,
    marker: binary,
  ]

  @type download_db_log_file_portion_message :: [
    db_instance_identifier: binary,
    log_file_name: binary,
    marker: binary,
    number_of_lines: integer,
  ]

  @type ec2_security_group :: [
    e_c2_security_group_id: binary,
    e_c2_security_group_name: binary,
    e_c2_security_group_owner_id: binary,
    status: binary,
  ]

  @type ec2_security_group_list :: [ec2_security_group]

  @type endpoint :: [
    address: binary,
    port: integer,
  ]

  @type engine_defaults :: [
    db_parameter_group_family: binary,
    marker: binary,
    parameters: parameters_list,
  ]

  @type event :: [
    date: t_stamp,
    event_categories: event_categories_list,
    message: binary,
    source_identifier: binary,
    source_type: source_type,
  ]

  @type event_categories_list :: [binary]

  @type event_categories_map :: [
    event_categories: event_categories_list,
    source_type: binary,
  ]

  @type event_categories_map_list :: [event_categories_map]

  @type event_categories_message :: [
    event_categories_map_list: event_categories_map_list,
  ]

  @type event_list :: [event]

  @type event_subscription :: [
    cust_subscription_id: binary,
    customer_aws_id: binary,
    enabled: boolean,
    event_categories_list: event_categories_list,
    sns_topic_arn: binary,
    source_ids_list: source_ids_list,
    source_type: binary,
    status: binary,
    subscription_creation_time: binary,
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

  @type failover_db_cluster_message :: [
    db_cluster_identifier: binary,
  ]

  @type failover_db_cluster_result :: [
    db_cluster: db_cluster,
  ]

  @type filter :: [
    name: binary,
    values: filter_value_list,
  ]

  @type filter_list :: [filter]

  @type filter_value_list :: [binary]

  @type ip_range :: [
    cidrip: binary,
    status: binary,
  ]

  @type ip_range_list :: [ip_range]

  @type instance_quota_exceeded_fault :: [
  ]

  @type insufficient_db_cluster_capacity_fault :: [
  ]

  @type insufficient_db_instance_capacity_fault :: [
  ]

  @type insufficient_storage_cluster_capacity_fault :: [
  ]

  @type integer_optional :: integer

  @type invalid_db_cluster_snapshot_state_fault :: [
  ]

  @type invalid_db_cluster_state_fault :: [
  ]

  @type invalid_db_instance_state_fault :: [
  ]

  @type invalid_db_parameter_group_state_fault :: [
  ]

  @type invalid_db_security_group_state_fault :: [
  ]

  @type invalid_db_snapshot_state_fault :: [
  ]

  @type invalid_db_subnet_group_fault :: [
  ]

  @type invalid_db_subnet_group_state_fault :: [
  ]

  @type invalid_db_subnet_state_fault :: [
  ]

  @type invalid_event_subscription_state_fault :: [
  ]

  @type invalid_option_group_state_fault :: [
  ]

  @type invalid_restore_fault :: [
  ]

  @type invalid_subnet :: [
  ]

  @type invalid_vpc_network_state_fault :: [
  ]

  @type kms_key_not_accessible_fault :: [
  ]

  @type key_list :: [binary]

  @type list_tags_for_resource_message :: [
    filters: filter_list,
    resource_name: binary,
  ]

  @type long :: integer

  @type modify_db_cluster_message :: [
    apply_immediately: boolean,
    backup_retention_period: integer_optional,
    db_cluster_identifier: binary,
    db_cluster_parameter_group_name: binary,
    master_user_password: binary,
    new_db_cluster_identifier: binary,
    option_group_name: binary,
    port: integer_optional,
    preferred_backup_window: binary,
    preferred_maintenance_window: binary,
    vpc_security_group_ids: vpc_security_group_id_list,
  ]

  @type modify_db_cluster_parameter_group_message :: [
    db_cluster_parameter_group_name: binary,
    parameters: parameters_list,
  ]

  @type modify_db_cluster_result :: [
    db_cluster: db_cluster,
  ]

  @type modify_db_instance_message :: [
    allocated_storage: integer_optional,
    allow_major_version_upgrade: boolean,
    apply_immediately: boolean,
    auto_minor_version_upgrade: boolean_optional,
    backup_retention_period: integer_optional,
    ca_certificate_identifier: binary,
    db_instance_class: binary,
    db_instance_identifier: binary,
    db_parameter_group_name: binary,
    db_security_groups: db_security_group_name_list,
    engine_version: binary,
    iops: integer_optional,
    master_user_password: binary,
    multi_az: boolean_optional,
    new_db_instance_identifier: binary,
    option_group_name: binary,
    preferred_backup_window: binary,
    preferred_maintenance_window: binary,
    storage_type: binary,
    tde_credential_arn: binary,
    tde_credential_password: binary,
    vpc_security_group_ids: vpc_security_group_id_list,
  ]

  @type modify_db_instance_result :: [
    db_instance: db_instance,
  ]

  @type modify_db_parameter_group_message :: [
    db_parameter_group_name: binary,
    parameters: parameters_list,
  ]

  @type modify_db_subnet_group_message :: [
    db_subnet_group_description: binary,
    db_subnet_group_name: binary,
    subnet_ids: subnet_identifier_list,
  ]

  @type modify_db_subnet_group_result :: [
    db_subnet_group: db_subnet_group,
  ]

  @type modify_event_subscription_message :: [
    enabled: boolean_optional,
    event_categories: event_categories_list,
    sns_topic_arn: binary,
    source_type: binary,
    subscription_name: binary,
  ]

  @type modify_event_subscription_result :: [
    event_subscription: event_subscription,
  ]

  @type modify_option_group_message :: [
    apply_immediately: boolean,
    option_group_name: binary,
    options_to_include: option_configuration_list,
    options_to_remove: option_names_list,
  ]

  @type modify_option_group_result :: [
    option_group: option_group,
  ]

  @type option :: [
    db_security_group_memberships: db_security_group_membership_list,
    option_description: binary,
    option_name: binary,
    option_settings: option_setting_configuration_list,
    permanent: boolean,
    persistent: boolean,
    port: integer_optional,
    vpc_security_group_memberships: vpc_security_group_membership_list,
  ]

  @type option_configuration :: [
    db_security_group_memberships: db_security_group_name_list,
    option_name: binary,
    option_settings: option_settings_list,
    port: integer_optional,
    vpc_security_group_memberships: vpc_security_group_id_list,
  ]

  @type option_configuration_list :: [option_configuration]

  @type option_group :: [
    allows_vpc_and_non_vpc_instance_memberships: boolean,
    engine_name: binary,
    major_engine_version: binary,
    option_group_description: binary,
    option_group_name: binary,
    options: options_list,
    vpc_id: binary,
  ]

  @type option_group_already_exists_fault :: [
  ]

  @type option_group_membership :: [
    option_group_name: binary,
    status: binary,
  ]

  @type option_group_membership_list :: [option_group_membership]

  @type option_group_not_found_fault :: [
  ]

  @type option_group_option :: [
    default_port: integer_optional,
    description: binary,
    engine_name: binary,
    major_engine_version: binary,
    minimum_required_minor_engine_version: binary,
    name: binary,
    option_group_option_settings: option_group_option_settings_list,
    options_depended_on: options_depended_on,
    permanent: boolean,
    persistent: boolean,
    port_required: boolean,
  ]

  @type option_group_option_setting :: [
    allowed_values: binary,
    apply_type: binary,
    default_value: binary,
    is_modifiable: boolean,
    setting_description: binary,
    setting_name: binary,
  ]

  @type option_group_option_settings_list :: [option_group_option_setting]

  @type option_group_options_list :: [option_group_option]

  @type option_group_options_message :: [
    marker: binary,
    option_group_options: option_group_options_list,
  ]

  @type option_group_quota_exceeded_fault :: [
  ]

  @type option_groups :: [
    marker: binary,
    option_groups_list: option_groups_list,
  ]

  @type option_groups_list :: [option_group]

  @type option_names_list :: [binary]

  @type option_setting :: [
    allowed_values: binary,
    apply_type: binary,
    data_type: binary,
    default_value: binary,
    description: binary,
    is_collection: boolean,
    is_modifiable: boolean,
    name: binary,
    value: binary,
  ]

  @type option_setting_configuration_list :: [option_setting]

  @type option_settings_list :: [option_setting]

  @type options_depended_on :: [binary]

  @type options_list :: [option]

  @type orderable_db_instance_option :: [
    availability_zones: availability_zone_list,
    db_instance_class: binary,
    engine: binary,
    engine_version: binary,
    license_model: binary,
    multi_az_capable: boolean,
    read_replica_capable: boolean,
    storage_type: binary,
    supports_iops: boolean,
    supports_storage_encryption: boolean,
    vpc: boolean,
  ]

  @type orderable_db_instance_options_list :: [orderable_db_instance_option]

  @type orderable_db_instance_options_message :: [
    marker: binary,
    orderable_db_instance_options: orderable_db_instance_options_list,
  ]

  @type parameter :: [
    allowed_values: binary,
    apply_method: apply_method,
    apply_type: binary,
    data_type: binary,
    description: binary,
    is_modifiable: boolean,
    minimum_engine_version: binary,
    parameter_name: binary,
    parameter_value: binary,
    source: binary,
  ]

  @type parameters_list :: [parameter]

  @type pending_maintenance_action :: [
    action: binary,
    auto_applied_after_date: t_stamp,
    current_apply_date: t_stamp,
    description: binary,
    forced_apply_date: t_stamp,
    opt_in_status: binary,
  ]

  @type pending_maintenance_action_details :: [pending_maintenance_action]

  @type pending_maintenance_actions :: [resource_pending_maintenance_actions]

  @type pending_maintenance_actions_message :: [
    marker: binary,
    pending_maintenance_actions: pending_maintenance_actions,
  ]

  @type pending_modified_values :: [
    allocated_storage: integer_optional,
    backup_retention_period: integer_optional,
    ca_certificate_identifier: binary,
    db_instance_class: binary,
    db_instance_identifier: binary,
    engine_version: binary,
    iops: integer_optional,
    master_user_password: binary,
    multi_az: boolean_optional,
    port: integer_optional,
    storage_type: binary,
  ]

  @type point_in_time_restore_not_enabled_fault :: [
  ]

  @type promote_read_replica_message :: [
    backup_retention_period: integer_optional,
    db_instance_identifier: binary,
    preferred_backup_window: binary,
  ]

  @type promote_read_replica_result :: [
    db_instance: db_instance,
  ]

  @type provisioned_iops_not_available_in_az_fault :: [
  ]

  @type purchase_reserved_db_instances_offering_message :: [
    db_instance_count: integer_optional,
    reserved_db_instance_id: binary,
    reserved_db_instances_offering_id: binary,
    tags: tag_list,
  ]

  @type purchase_reserved_db_instances_offering_result :: [
    reserved_db_instance: reserved_db_instance,
  ]

  @type read_replica_db_instance_identifier_list :: [binary]

  @type reboot_db_instance_message :: [
    db_instance_identifier: binary,
    force_failover: boolean_optional,
  ]

  @type reboot_db_instance_result :: [
    db_instance: db_instance,
  ]

  @type recurring_charge :: [
    recurring_charge_amount: double,
    recurring_charge_frequency: binary,
  ]

  @type recurring_charge_list :: [recurring_charge]

  @type remove_source_identifier_from_subscription_message :: [
    source_identifier: binary,
    subscription_name: binary,
  ]

  @type remove_source_identifier_from_subscription_result :: [
    event_subscription: event_subscription,
  ]

  @type remove_tags_from_resource_message :: [
    resource_name: binary,
    tag_keys: key_list,
  ]

  @type reserved_db_instance :: [
    currency_code: binary,
    db_instance_class: binary,
    db_instance_count: integer,
    duration: integer,
    fixed_price: double,
    multi_az: boolean,
    offering_type: binary,
    product_description: binary,
    recurring_charges: recurring_charge_list,
    reserved_db_instance_id: binary,
    reserved_db_instances_offering_id: binary,
    start_time: t_stamp,
    state: binary,
    usage_price: double,
  ]

  @type reserved_db_instance_already_exists_fault :: [
  ]

  @type reserved_db_instance_list :: [reserved_db_instance]

  @type reserved_db_instance_message :: [
    marker: binary,
    reserved_db_instances: reserved_db_instance_list,
  ]

  @type reserved_db_instance_not_found_fault :: [
  ]

  @type reserved_db_instance_quota_exceeded_fault :: [
  ]

  @type reserved_db_instances_offering :: [
    currency_code: binary,
    db_instance_class: binary,
    duration: integer,
    fixed_price: double,
    multi_az: boolean,
    offering_type: binary,
    product_description: binary,
    recurring_charges: recurring_charge_list,
    reserved_db_instances_offering_id: binary,
    usage_price: double,
  ]

  @type reserved_db_instances_offering_list :: [reserved_db_instances_offering]

  @type reserved_db_instances_offering_message :: [
    marker: binary,
    reserved_db_instances_offerings: reserved_db_instances_offering_list,
  ]

  @type reserved_db_instances_offering_not_found_fault :: [
  ]

  @type reset_db_cluster_parameter_group_message :: [
    db_cluster_parameter_group_name: binary,
    parameters: parameters_list,
    reset_all_parameters: boolean,
  ]

  @type reset_db_parameter_group_message :: [
    db_parameter_group_name: binary,
    parameters: parameters_list,
    reset_all_parameters: boolean,
  ]

  @type resource_not_found_fault :: [
  ]

  @type resource_pending_maintenance_actions :: [
    pending_maintenance_action_details: pending_maintenance_action_details,
    resource_identifier: binary,
  ]

  @type restore_db_cluster_from_snapshot_message :: [
    availability_zones: availability_zones,
    db_cluster_identifier: binary,
    db_subnet_group_name: binary,
    database_name: binary,
    engine: binary,
    engine_version: binary,
    option_group_name: binary,
    port: integer_optional,
    snapshot_identifier: binary,
    tags: tag_list,
    vpc_security_group_ids: vpc_security_group_id_list,
  ]

  @type restore_db_cluster_from_snapshot_result :: [
    db_cluster: db_cluster,
  ]

  @type restore_db_cluster_to_point_in_time_message :: [
    db_cluster_identifier: binary,
    db_subnet_group_name: binary,
    option_group_name: binary,
    port: integer_optional,
    restore_to_time: t_stamp,
    source_db_cluster_identifier: binary,
    tags: tag_list,
    use_latest_restorable_time: boolean,
    vpc_security_group_ids: vpc_security_group_id_list,
  ]

  @type restore_db_cluster_to_point_in_time_result :: [
    db_cluster: db_cluster,
  ]

  @type restore_db_instance_from_db_snapshot_message :: [
    auto_minor_version_upgrade: boolean_optional,
    availability_zone: binary,
    db_instance_class: binary,
    db_instance_identifier: binary,
    db_name: binary,
    db_snapshot_identifier: binary,
    db_subnet_group_name: binary,
    engine: binary,
    iops: integer_optional,
    license_model: binary,
    multi_az: boolean_optional,
    option_group_name: binary,
    port: integer_optional,
    publicly_accessible: boolean_optional,
    storage_type: binary,
    tags: tag_list,
    tde_credential_arn: binary,
    tde_credential_password: binary,
  ]

  @type restore_db_instance_from_db_snapshot_result :: [
    db_instance: db_instance,
  ]

  @type restore_db_instance_to_point_in_time_message :: [
    auto_minor_version_upgrade: boolean_optional,
    availability_zone: binary,
    db_instance_class: binary,
    db_name: binary,
    db_subnet_group_name: binary,
    engine: binary,
    iops: integer_optional,
    license_model: binary,
    multi_az: boolean_optional,
    option_group_name: binary,
    port: integer_optional,
    publicly_accessible: boolean_optional,
    restore_time: t_stamp,
    source_db_instance_identifier: binary,
    storage_type: binary,
    tags: tag_list,
    target_db_instance_identifier: binary,
    tde_credential_arn: binary,
    tde_credential_password: binary,
    use_latest_restorable_time: boolean,
  ]

  @type restore_db_instance_to_point_in_time_result :: [
    db_instance: db_instance,
  ]

  @type revoke_db_security_group_ingress_message :: [
    cidrip: binary,
    db_security_group_name: binary,
    e_c2_security_group_id: binary,
    e_c2_security_group_name: binary,
    e_c2_security_group_owner_id: binary,
  ]

  @type revoke_db_security_group_ingress_result :: [
    db_security_group: db_security_group,
  ]

  @type sns_invalid_topic_fault :: [
  ]

  @type sns_no_authorization_fault :: [
  ]

  @type sns_topic_arn_not_found_fault :: [
  ]

  @type snapshot_quota_exceeded_fault :: [
  ]

  @type source_ids_list :: [binary]

  @type source_not_found_fault :: [
  ]

  @type source_type :: binary

  @type storage_quota_exceeded_fault :: [
  ]

  @type storage_type_not_supported_fault :: [
  ]

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

  @type subscription_not_found_fault :: [
  ]

  @type supported_character_sets_list :: [character_set]

  @type t_stamp :: integer

  @type tag :: [
    key: binary,
    value: binary,
  ]

  @type tag_list :: [tag]

  @type tag_list_message :: [
    tag_list: tag_list,
  ]

  @type vpc_security_group_id_list :: [binary]

  @type vpc_security_group_membership :: [
    status: binary,
    vpc_security_group_id: binary,
  ]

  @type vpc_security_group_membership_list :: [vpc_security_group_membership]




  @doc """
  AddSourceIdentifierToSubscription

  Adds a source identifier to an existing RDS event notification
  subscription.
  """

  @spec add_source_identifier_to_subscription(client :: ExAws.RDS.t, input :: add_source_identifier_to_subscription_message) :: ExAws.Request.Query.response_t
  def add_source_identifier_to_subscription(client, input) do
    request(client, "/", "AddSourceIdentifierToSubscription", input)
  end

  @doc """
  Same as `add_source_identifier_to_subscription/2` but raise on error.
  """
  @spec add_source_identifier_to_subscription!(client :: ExAws.RDS.t, input :: add_source_identifier_to_subscription_message) :: ExAws.Request.Query.success_t | no_return
  def add_source_identifier_to_subscription!(client, input) do
    case add_source_identifier_to_subscription(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  AddTagsToResource

  Adds metadata tags to an Amazon RDS resource. These tags can also be used
  with cost allocation reporting to track cost associated with Amazon RDS
  resources, or used in a Condition statement in an IAM policy for Amazon
  RDS.

  For an overview on tagging Amazon RDS resources, see [Tagging Amazon RDS
  Resources](http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Overview.Tagging.html).
  """

  @spec add_tags_to_resource(client :: ExAws.RDS.t, input :: add_tags_to_resource_message) :: ExAws.Request.Query.response_t
  def add_tags_to_resource(client, input) do
    request(client, "/", "AddTagsToResource", input)
  end

  @doc """
  Same as `add_tags_to_resource/2` but raise on error.
  """
  @spec add_tags_to_resource!(client :: ExAws.RDS.t, input :: add_tags_to_resource_message) :: ExAws.Request.Query.success_t | no_return
  def add_tags_to_resource!(client, input) do
    case add_tags_to_resource(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ApplyPendingMaintenanceAction

  Applies a pending maintenance action to a resource (for example, to a DB
  instance).
  """

  @spec apply_pending_maintenance_action(client :: ExAws.RDS.t, input :: apply_pending_maintenance_action_message) :: ExAws.Request.Query.response_t
  def apply_pending_maintenance_action(client, input) do
    request(client, "/", "ApplyPendingMaintenanceAction", input)
  end

  @doc """
  Same as `apply_pending_maintenance_action/2` but raise on error.
  """
  @spec apply_pending_maintenance_action!(client :: ExAws.RDS.t, input :: apply_pending_maintenance_action_message) :: ExAws.Request.Query.success_t | no_return
  def apply_pending_maintenance_action!(client, input) do
    case apply_pending_maintenance_action(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  AuthorizeDBSecurityGroupIngress

  Enables ingress to a DBSecurityGroup using one of two forms of
  authorization. First, EC2 or VPC security groups can be added to the
  DBSecurityGroup if the application using the database is running on EC2 or
  VPC instances. Second, IP ranges are available if the application accessing
  your database is running on the Internet. Required parameters for this API
  are one of CIDR range, EC2SecurityGroupId for VPC, or
  (EC2SecurityGroupOwnerId and either EC2SecurityGroupName or
  EC2SecurityGroupId for non-VPC).

  Note: You cannot authorize ingress from an EC2 security group in one region
  to an Amazon RDS DB instance in another. You cannot authorize ingress from
  a VPC security group in one VPC to an Amazon RDS DB instance in another.
  For an overview of CIDR ranges, go to the [Wikipedia
  Tutorial](http://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing).
  """

  @spec authorize_db_security_group_ingress(client :: ExAws.RDS.t, input :: authorize_db_security_group_ingress_message) :: ExAws.Request.Query.response_t
  def authorize_db_security_group_ingress(client, input) do
    request(client, "/", "AuthorizeDBSecurityGroupIngress", input)
  end

  @doc """
  Same as `authorize_db_security_group_ingress/2` but raise on error.
  """
  @spec authorize_db_security_group_ingress!(client :: ExAws.RDS.t, input :: authorize_db_security_group_ingress_message) :: ExAws.Request.Query.success_t | no_return
  def authorize_db_security_group_ingress!(client, input) do
    case authorize_db_security_group_ingress(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CopyDBClusterSnapshot

  Creates a snapshot of a DB cluster. For more information on Amazon Aurora,
  see [Aurora on Amazon
  RDS](http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Aurora.html)
  in the *Amazon RDS User Guide.*
  """

  @spec copy_db_cluster_snapshot(client :: ExAws.RDS.t, input :: copy_db_cluster_snapshot_message) :: ExAws.Request.Query.response_t
  def copy_db_cluster_snapshot(client, input) do
    request(client, "/", "CopyDBClusterSnapshot", input)
  end

  @doc """
  Same as `copy_db_cluster_snapshot/2` but raise on error.
  """
  @spec copy_db_cluster_snapshot!(client :: ExAws.RDS.t, input :: copy_db_cluster_snapshot_message) :: ExAws.Request.Query.success_t | no_return
  def copy_db_cluster_snapshot!(client, input) do
    case copy_db_cluster_snapshot(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CopyDBParameterGroup

  Copies the specified DB parameter group.
  """

  @spec copy_db_parameter_group(client :: ExAws.RDS.t, input :: copy_db_parameter_group_message) :: ExAws.Request.Query.response_t
  def copy_db_parameter_group(client, input) do
    request(client, "/", "CopyDBParameterGroup", input)
  end

  @doc """
  Same as `copy_db_parameter_group/2` but raise on error.
  """
  @spec copy_db_parameter_group!(client :: ExAws.RDS.t, input :: copy_db_parameter_group_message) :: ExAws.Request.Query.success_t | no_return
  def copy_db_parameter_group!(client, input) do
    case copy_db_parameter_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CopyDBSnapshot

  Copies the specified DBSnapshot. The source DBSnapshot must be in the
  "available" state.
  """

  @spec copy_db_snapshot(client :: ExAws.RDS.t, input :: copy_db_snapshot_message) :: ExAws.Request.Query.response_t
  def copy_db_snapshot(client, input) do
    request(client, "/", "CopyDBSnapshot", input)
  end

  @doc """
  Same as `copy_db_snapshot/2` but raise on error.
  """
  @spec copy_db_snapshot!(client :: ExAws.RDS.t, input :: copy_db_snapshot_message) :: ExAws.Request.Query.success_t | no_return
  def copy_db_snapshot!(client, input) do
    case copy_db_snapshot(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CopyOptionGroup

  Copies the specified option group.
  """

  @spec copy_option_group(client :: ExAws.RDS.t, input :: copy_option_group_message) :: ExAws.Request.Query.response_t
  def copy_option_group(client, input) do
    request(client, "/", "CopyOptionGroup", input)
  end

  @doc """
  Same as `copy_option_group/2` but raise on error.
  """
  @spec copy_option_group!(client :: ExAws.RDS.t, input :: copy_option_group_message) :: ExAws.Request.Query.success_t | no_return
  def copy_option_group!(client, input) do
    case copy_option_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateDBCluster

  Creates a new Amazon Aurora DB cluster. For more information on Amazon
  Aurora, see [Aurora on Amazon
  RDS](http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Aurora.html)
  in the *Amazon RDS User Guide.*
  """

  @spec create_db_cluster(client :: ExAws.RDS.t, input :: create_db_cluster_message) :: ExAws.Request.Query.response_t
  def create_db_cluster(client, input) do
    request(client, "/", "CreateDBCluster", input)
  end

  @doc """
  Same as `create_db_cluster/2` but raise on error.
  """
  @spec create_db_cluster!(client :: ExAws.RDS.t, input :: create_db_cluster_message) :: ExAws.Request.Query.success_t | no_return
  def create_db_cluster!(client, input) do
    case create_db_cluster(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateDBClusterParameterGroup

  Creates a new DB cluster parameter group.

  Parameters in a DB cluster parameter group apply to all of the instances in
  a DB cluster.

  A DB cluster parameter group is initially created with the default
  parameters for the database engine used by instances in the DB cluster. To
  provide custom values for any of the parameters, you must modify the group
  after creating it using `ModifyDBClusterParameterGroup`. Once you've
  created a DB cluster parameter group, you need to associate it with your DB
  cluster using `ModifyDBCluster`. When you associate a new DB cluster
  parameter group with a running DB cluster, you need to reboot the DB
  instances in the DB cluster without failover for the new DB cluster
  parameter group and associated settings to take effect.

  ** After you create a DB cluster parameter group, you should wait at least
  5 minutes before creating your first DB cluster that uses that DB cluster
  parameter group as the default parameter group. This allows Amazon RDS to
  fully complete the create action before the DB cluster parameter group is
  used as the default for a new DB cluster. This is especially important for
  parameters that are critical when creating the default database for a DB
  cluster, such as the character set for the default database defined by the
  `character_set_database` parameter. You can use the *Parameter Groups*
  option of the [Amazon RDS console](https://console.aws.amazon.com/rds/) or
  the `DescribeDBClusterParameters` command to verify that your DB cluster
  parameter group has been created or modified.

  ** For more information on Amazon Aurora, see [Aurora on Amazon
  RDS](http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Aurora.html)
  in the *Amazon RDS User Guide.*
  """

  @spec create_db_cluster_parameter_group(client :: ExAws.RDS.t, input :: create_db_cluster_parameter_group_message) :: ExAws.Request.Query.response_t
  def create_db_cluster_parameter_group(client, input) do
    request(client, "/", "CreateDBClusterParameterGroup", input)
  end

  @doc """
  Same as `create_db_cluster_parameter_group/2` but raise on error.
  """
  @spec create_db_cluster_parameter_group!(client :: ExAws.RDS.t, input :: create_db_cluster_parameter_group_message) :: ExAws.Request.Query.success_t | no_return
  def create_db_cluster_parameter_group!(client, input) do
    case create_db_cluster_parameter_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateDBClusterSnapshot

  Creates a snapshot of a DB cluster. For more information on Amazon Aurora,
  see [Aurora on Amazon
  RDS](http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Aurora.html)
  in the *Amazon RDS User Guide.*
  """

  @spec create_db_cluster_snapshot(client :: ExAws.RDS.t, input :: create_db_cluster_snapshot_message) :: ExAws.Request.Query.response_t
  def create_db_cluster_snapshot(client, input) do
    request(client, "/", "CreateDBClusterSnapshot", input)
  end

  @doc """
  Same as `create_db_cluster_snapshot/2` but raise on error.
  """
  @spec create_db_cluster_snapshot!(client :: ExAws.RDS.t, input :: create_db_cluster_snapshot_message) :: ExAws.Request.Query.success_t | no_return
  def create_db_cluster_snapshot!(client, input) do
    case create_db_cluster_snapshot(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateDBInstance

  Creates a new DB instance.
  """

  @spec create_db_instance(client :: ExAws.RDS.t, input :: create_db_instance_message) :: ExAws.Request.Query.response_t
  def create_db_instance(client, input) do
    request(client, "/", "CreateDBInstance", input)
  end

  @doc """
  Same as `create_db_instance/2` but raise on error.
  """
  @spec create_db_instance!(client :: ExAws.RDS.t, input :: create_db_instance_message) :: ExAws.Request.Query.success_t | no_return
  def create_db_instance!(client, input) do
    case create_db_instance(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateDBInstanceReadReplica

  Creates a DB instance for a DB instance running MySQL or PostgreSQL that
  acts as a Read Replica of a source DB instance.

  All Read Replica DB instances are created as Single-AZ deployments with
  backups disabled. All other DB instance attributes (including DB security
  groups and DB parameter groups) are inherited from the source DB instance,
  except as specified below.

  ** The source DB instance must have backup retention enabled.

  **
  """

  @spec create_db_instance_read_replica(client :: ExAws.RDS.t, input :: create_db_instance_read_replica_message) :: ExAws.Request.Query.response_t
  def create_db_instance_read_replica(client, input) do
    request(client, "/", "CreateDBInstanceReadReplica", input)
  end

  @doc """
  Same as `create_db_instance_read_replica/2` but raise on error.
  """
  @spec create_db_instance_read_replica!(client :: ExAws.RDS.t, input :: create_db_instance_read_replica_message) :: ExAws.Request.Query.success_t | no_return
  def create_db_instance_read_replica!(client, input) do
    case create_db_instance_read_replica(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateDBParameterGroup

  Creates a new DB parameter group.

  A DB parameter group is initially created with the default parameters for
  the database engine used by the DB instance. To provide custom values for
  any of the parameters, you must modify the group after creating it using
  *ModifyDBParameterGroup*. Once you've created a DB parameter group, you
  need to associate it with your DB instance using *ModifyDBInstance*. When
  you associate a new DB parameter group with a running DB instance, you need
  to reboot the DB instance without failover for the new DB parameter group
  and associated settings to take effect.

  ** After you create a DB parameter group, you should wait at least 5
  minutes before creating your first DB instance that uses that DB parameter
  group as the default parameter group. This allows Amazon RDS to fully
  complete the create action before the parameter group is used as the
  default for a new DB instance. This is especially important for parameters
  that are critical when creating the default database for a DB instance,
  such as the character set for the default database defined by the
  `character_set_database` parameter. You can use the *Parameter Groups*
  option of the [Amazon RDS console](https://console.aws.amazon.com/rds/) or
  the *DescribeDBParameters* command to verify that your DB parameter group
  has been created or modified.

  **
  """

  @spec create_db_parameter_group(client :: ExAws.RDS.t, input :: create_db_parameter_group_message) :: ExAws.Request.Query.response_t
  def create_db_parameter_group(client, input) do
    request(client, "/", "CreateDBParameterGroup", input)
  end

  @doc """
  Same as `create_db_parameter_group/2` but raise on error.
  """
  @spec create_db_parameter_group!(client :: ExAws.RDS.t, input :: create_db_parameter_group_message) :: ExAws.Request.Query.success_t | no_return
  def create_db_parameter_group!(client, input) do
    case create_db_parameter_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateDBSecurityGroup

  Creates a new DB security group. DB security groups control access to a DB
  instance.
  """

  @spec create_db_security_group(client :: ExAws.RDS.t, input :: create_db_security_group_message) :: ExAws.Request.Query.response_t
  def create_db_security_group(client, input) do
    request(client, "/", "CreateDBSecurityGroup", input)
  end

  @doc """
  Same as `create_db_security_group/2` but raise on error.
  """
  @spec create_db_security_group!(client :: ExAws.RDS.t, input :: create_db_security_group_message) :: ExAws.Request.Query.success_t | no_return
  def create_db_security_group!(client, input) do
    case create_db_security_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateDBSnapshot

  Creates a DBSnapshot. The source DBInstance must be in "available" state.
  """

  @spec create_db_snapshot(client :: ExAws.RDS.t, input :: create_db_snapshot_message) :: ExAws.Request.Query.response_t
  def create_db_snapshot(client, input) do
    request(client, "/", "CreateDBSnapshot", input)
  end

  @doc """
  Same as `create_db_snapshot/2` but raise on error.
  """
  @spec create_db_snapshot!(client :: ExAws.RDS.t, input :: create_db_snapshot_message) :: ExAws.Request.Query.success_t | no_return
  def create_db_snapshot!(client, input) do
    case create_db_snapshot(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateDBSubnetGroup

  Creates a new DB subnet group. DB subnet groups must contain at least one
  subnet in at least two AZs in the region.
  """

  @spec create_db_subnet_group(client :: ExAws.RDS.t, input :: create_db_subnet_group_message) :: ExAws.Request.Query.response_t
  def create_db_subnet_group(client, input) do
    request(client, "/", "CreateDBSubnetGroup", input)
  end

  @doc """
  Same as `create_db_subnet_group/2` but raise on error.
  """
  @spec create_db_subnet_group!(client :: ExAws.RDS.t, input :: create_db_subnet_group_message) :: ExAws.Request.Query.success_t | no_return
  def create_db_subnet_group!(client, input) do
    case create_db_subnet_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateEventSubscription

  Creates an RDS event notification subscription. This action requires a
  topic ARN (Amazon Resource Name) created by either the RDS console, the SNS
  console, or the SNS API. To obtain an ARN with SNS, you must create a topic
  in Amazon SNS and subscribe to the topic. The ARN is displayed in the SNS
  console.

  You can specify the type of source (SourceType) you want to be notified of,
  provide a list of RDS sources (SourceIds) that triggers the events, and
  provide a list of event categories (EventCategories) for events you want to
  be notified of. For example, you can specify SourceType = db-instance,
  SourceIds = mydbinstance1, mydbinstance2 and EventCategories =
  Availability, Backup.

  If you specify both the SourceType and SourceIds, such as SourceType =
  db-instance and SourceIdentifier = myDBInstance1, you will be notified of
  all the db-instance events for the specified source. If you specify a
  SourceType but do not specify a SourceIdentifier, you will receive notice
  of the events for that source type for all your RDS sources. If you do not
  specify either the SourceType nor the SourceIdentifier, you will be
  notified of events generated from all RDS sources belonging to your
  customer account.
  """

  @spec create_event_subscription(client :: ExAws.RDS.t, input :: create_event_subscription_message) :: ExAws.Request.Query.response_t
  def create_event_subscription(client, input) do
    request(client, "/", "CreateEventSubscription", input)
  end

  @doc """
  Same as `create_event_subscription/2` but raise on error.
  """
  @spec create_event_subscription!(client :: ExAws.RDS.t, input :: create_event_subscription_message) :: ExAws.Request.Query.success_t | no_return
  def create_event_subscription!(client, input) do
    case create_event_subscription(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateOptionGroup

  Creates a new option group. You can create up to 20 option groups.
  """

  @spec create_option_group(client :: ExAws.RDS.t, input :: create_option_group_message) :: ExAws.Request.Query.response_t
  def create_option_group(client, input) do
    request(client, "/", "CreateOptionGroup", input)
  end

  @doc """
  Same as `create_option_group/2` but raise on error.
  """
  @spec create_option_group!(client :: ExAws.RDS.t, input :: create_option_group_message) :: ExAws.Request.Query.success_t | no_return
  def create_option_group!(client, input) do
    case create_option_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteDBCluster

  The DeleteDBCluster action deletes a previously provisioned DB cluster. A
  successful response from the web service indicates the request was received
  correctly. When you delete a DB cluster, all automated backups for that DB
  cluster are deleted and cannot be recovered. Manual DB cluster snapshots of
  the DB cluster to be deleted are not deleted.

  For more information on Amazon Aurora, see [Aurora on Amazon
  RDS](http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Aurora.html)
  in the *Amazon RDS User Guide.*
  """

  @spec delete_db_cluster(client :: ExAws.RDS.t, input :: delete_db_cluster_message) :: ExAws.Request.Query.response_t
  def delete_db_cluster(client, input) do
    request(client, "/", "DeleteDBCluster", input)
  end

  @doc """
  Same as `delete_db_cluster/2` but raise on error.
  """
  @spec delete_db_cluster!(client :: ExAws.RDS.t, input :: delete_db_cluster_message) :: ExAws.Request.Query.success_t | no_return
  def delete_db_cluster!(client, input) do
    case delete_db_cluster(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteDBClusterParameterGroup

  Deletes a specified DB cluster parameter group. The DB cluster parameter
  group to be deleted cannot be associated with any DB clusters.

  For more information on Amazon Aurora, see [Aurora on Amazon
  RDS](http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Aurora.html)
  in the *Amazon RDS User Guide.*
  """

  @spec delete_db_cluster_parameter_group(client :: ExAws.RDS.t, input :: delete_db_cluster_parameter_group_message) :: ExAws.Request.Query.response_t
  def delete_db_cluster_parameter_group(client, input) do
    request(client, "/", "DeleteDBClusterParameterGroup", input)
  end

  @doc """
  Same as `delete_db_cluster_parameter_group/2` but raise on error.
  """
  @spec delete_db_cluster_parameter_group!(client :: ExAws.RDS.t, input :: delete_db_cluster_parameter_group_message) :: ExAws.Request.Query.success_t | no_return
  def delete_db_cluster_parameter_group!(client, input) do
    case delete_db_cluster_parameter_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteDBClusterSnapshot

  Deletes a DB cluster snapshot. If the snapshot is being copied, the copy
  operation is terminated.

  Note:The DB cluster snapshot must be in the `available` state to be
  deleted. For more information on Amazon Aurora, see [Aurora on Amazon
  RDS](http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Aurora.html)
  in the *Amazon RDS User Guide.*
  """

  @spec delete_db_cluster_snapshot(client :: ExAws.RDS.t, input :: delete_db_cluster_snapshot_message) :: ExAws.Request.Query.response_t
  def delete_db_cluster_snapshot(client, input) do
    request(client, "/", "DeleteDBClusterSnapshot", input)
  end

  @doc """
  Same as `delete_db_cluster_snapshot/2` but raise on error.
  """
  @spec delete_db_cluster_snapshot!(client :: ExAws.RDS.t, input :: delete_db_cluster_snapshot_message) :: ExAws.Request.Query.success_t | no_return
  def delete_db_cluster_snapshot!(client, input) do
    case delete_db_cluster_snapshot(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteDBInstance

  The DeleteDBInstance action deletes a previously provisioned DB instance. A
  successful response from the web service indicates the request was received
  correctly. When you delete a DB instance, all automated backups for that
  instance are deleted and cannot be recovered. Manual DB snapshots of the DB
  instance to be deleted are not deleted.

  If a final DB snapshot is requested the status of the RDS instance will be
  "deleting" until the DB snapshot is created. The API action
  `DescribeDBInstance` is used to monitor the status of this operation. The
  action cannot be canceled or reverted once submitted.

  Note that when a DB instance is in a failure state and has a status of
  'failed', 'incompatible-restore', or 'incompatible-network', it can only be
  deleted when the SkipFinalSnapshot parameter is set to "true".
  """

  @spec delete_db_instance(client :: ExAws.RDS.t, input :: delete_db_instance_message) :: ExAws.Request.Query.response_t
  def delete_db_instance(client, input) do
    request(client, "/", "DeleteDBInstance", input)
  end

  @doc """
  Same as `delete_db_instance/2` but raise on error.
  """
  @spec delete_db_instance!(client :: ExAws.RDS.t, input :: delete_db_instance_message) :: ExAws.Request.Query.success_t | no_return
  def delete_db_instance!(client, input) do
    case delete_db_instance(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteDBParameterGroup

  Deletes a specified DBParameterGroup. The DBParameterGroup to be deleted
  cannot be associated with any DB instances.
  """

  @spec delete_db_parameter_group(client :: ExAws.RDS.t, input :: delete_db_parameter_group_message) :: ExAws.Request.Query.response_t
  def delete_db_parameter_group(client, input) do
    request(client, "/", "DeleteDBParameterGroup", input)
  end

  @doc """
  Same as `delete_db_parameter_group/2` but raise on error.
  """
  @spec delete_db_parameter_group!(client :: ExAws.RDS.t, input :: delete_db_parameter_group_message) :: ExAws.Request.Query.success_t | no_return
  def delete_db_parameter_group!(client, input) do
    case delete_db_parameter_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteDBSecurityGroup

  Deletes a DB security group.

  Note:The specified DB security group must not be associated with any DB
  instances.
  """

  @spec delete_db_security_group(client :: ExAws.RDS.t, input :: delete_db_security_group_message) :: ExAws.Request.Query.response_t
  def delete_db_security_group(client, input) do
    request(client, "/", "DeleteDBSecurityGroup", input)
  end

  @doc """
  Same as `delete_db_security_group/2` but raise on error.
  """
  @spec delete_db_security_group!(client :: ExAws.RDS.t, input :: delete_db_security_group_message) :: ExAws.Request.Query.success_t | no_return
  def delete_db_security_group!(client, input) do
    case delete_db_security_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteDBSnapshot

  Deletes a DBSnapshot. If the snapshot is being copied, the copy operation
  is terminated.

  Note:The DBSnapshot must be in the `available` state to be deleted.
  """

  @spec delete_db_snapshot(client :: ExAws.RDS.t, input :: delete_db_snapshot_message) :: ExAws.Request.Query.response_t
  def delete_db_snapshot(client, input) do
    request(client, "/", "DeleteDBSnapshot", input)
  end

  @doc """
  Same as `delete_db_snapshot/2` but raise on error.
  """
  @spec delete_db_snapshot!(client :: ExAws.RDS.t, input :: delete_db_snapshot_message) :: ExAws.Request.Query.success_t | no_return
  def delete_db_snapshot!(client, input) do
    case delete_db_snapshot(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteDBSubnetGroup

  Deletes a DB subnet group.

  Note:The specified database subnet group must not be associated with any DB
  instances.
  """

  @spec delete_db_subnet_group(client :: ExAws.RDS.t, input :: delete_db_subnet_group_message) :: ExAws.Request.Query.response_t
  def delete_db_subnet_group(client, input) do
    request(client, "/", "DeleteDBSubnetGroup", input)
  end

  @doc """
  Same as `delete_db_subnet_group/2` but raise on error.
  """
  @spec delete_db_subnet_group!(client :: ExAws.RDS.t, input :: delete_db_subnet_group_message) :: ExAws.Request.Query.success_t | no_return
  def delete_db_subnet_group!(client, input) do
    case delete_db_subnet_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteEventSubscription

  Deletes an RDS event notification subscription.
  """

  @spec delete_event_subscription(client :: ExAws.RDS.t, input :: delete_event_subscription_message) :: ExAws.Request.Query.response_t
  def delete_event_subscription(client, input) do
    request(client, "/", "DeleteEventSubscription", input)
  end

  @doc """
  Same as `delete_event_subscription/2` but raise on error.
  """
  @spec delete_event_subscription!(client :: ExAws.RDS.t, input :: delete_event_subscription_message) :: ExAws.Request.Query.success_t | no_return
  def delete_event_subscription!(client, input) do
    case delete_event_subscription(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteOptionGroup

  Deletes an existing option group.
  """

  @spec delete_option_group(client :: ExAws.RDS.t, input :: delete_option_group_message) :: ExAws.Request.Query.response_t
  def delete_option_group(client, input) do
    request(client, "/", "DeleteOptionGroup", input)
  end

  @doc """
  Same as `delete_option_group/2` but raise on error.
  """
  @spec delete_option_group!(client :: ExAws.RDS.t, input :: delete_option_group_message) :: ExAws.Request.Query.success_t | no_return
  def delete_option_group!(client, input) do
    case delete_option_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeAccountAttributes

  Lists all of the attributes for a customer account. The attributes include
  Amazon RDS quotas for the account, such as the number of DB instances
  allowed. The description for a quota includes the quota name, current usage
  toward that quota, and the quota's maximum value.

  This command does not take any parameters.
  """

  @spec describe_account_attributes(client :: ExAws.RDS.t, input :: describe_account_attributes_message) :: ExAws.Request.Query.response_t
  def describe_account_attributes(client, input) do
    request(client, "/", "DescribeAccountAttributes", input)
  end

  @doc """
  Same as `describe_account_attributes/2` but raise on error.
  """
  @spec describe_account_attributes!(client :: ExAws.RDS.t, input :: describe_account_attributes_message) :: ExAws.Request.Query.success_t | no_return
  def describe_account_attributes!(client, input) do
    case describe_account_attributes(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeCertificates

  Lists the set of CA certificates provided by Amazon RDS for this AWS
  account.
  """

  @spec describe_certificates(client :: ExAws.RDS.t, input :: describe_certificates_message) :: ExAws.Request.Query.response_t
  def describe_certificates(client, input) do
    request(client, "/", "DescribeCertificates", input)
  end

  @doc """
  Same as `describe_certificates/2` but raise on error.
  """
  @spec describe_certificates!(client :: ExAws.RDS.t, input :: describe_certificates_message) :: ExAws.Request.Query.success_t | no_return
  def describe_certificates!(client, input) do
    case describe_certificates(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeDBClusterParameterGroups

  Returns a list of `DBClusterParameterGroup` descriptions. If a
  `DBClusterParameterGroupName` parameter is specified, the list will contain
  only the description of the specified DB cluster parameter group.

  For more information on Amazon Aurora, see [Aurora on Amazon
  RDS](http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Aurora.html)
  in the *Amazon RDS User Guide.*
  """

  @spec describe_db_cluster_parameter_groups(client :: ExAws.RDS.t, input :: describe_db_cluster_parameter_groups_message) :: ExAws.Request.Query.response_t
  def describe_db_cluster_parameter_groups(client, input) do
    request(client, "/", "DescribeDBClusterParameterGroups", input)
  end

  @doc """
  Same as `describe_db_cluster_parameter_groups/2` but raise on error.
  """
  @spec describe_db_cluster_parameter_groups!(client :: ExAws.RDS.t, input :: describe_db_cluster_parameter_groups_message) :: ExAws.Request.Query.success_t | no_return
  def describe_db_cluster_parameter_groups!(client, input) do
    case describe_db_cluster_parameter_groups(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeDBClusterParameters

  Returns the detailed parameter list for a particular DB cluster parameter
  group.

  For more information on Amazon Aurora, see [Aurora on Amazon
  RDS](http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Aurora.html)
  in the *Amazon RDS User Guide.*
  """

  @spec describe_db_cluster_parameters(client :: ExAws.RDS.t, input :: describe_db_cluster_parameters_message) :: ExAws.Request.Query.response_t
  def describe_db_cluster_parameters(client, input) do
    request(client, "/", "DescribeDBClusterParameters", input)
  end

  @doc """
  Same as `describe_db_cluster_parameters/2` but raise on error.
  """
  @spec describe_db_cluster_parameters!(client :: ExAws.RDS.t, input :: describe_db_cluster_parameters_message) :: ExAws.Request.Query.success_t | no_return
  def describe_db_cluster_parameters!(client, input) do
    case describe_db_cluster_parameters(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeDBClusterSnapshots

  Returns information about DB cluster snapshots. This API supports
  pagination.

  For more information on Amazon Aurora, see [Aurora on Amazon
  RDS](http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Aurora.html)
  in the *Amazon RDS User Guide.*
  """

  @spec describe_db_cluster_snapshots(client :: ExAws.RDS.t, input :: describe_db_cluster_snapshots_message) :: ExAws.Request.Query.response_t
  def describe_db_cluster_snapshots(client, input) do
    request(client, "/", "DescribeDBClusterSnapshots", input)
  end

  @doc """
  Same as `describe_db_cluster_snapshots/2` but raise on error.
  """
  @spec describe_db_cluster_snapshots!(client :: ExAws.RDS.t, input :: describe_db_cluster_snapshots_message) :: ExAws.Request.Query.success_t | no_return
  def describe_db_cluster_snapshots!(client, input) do
    case describe_db_cluster_snapshots(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeDBClusters

  Returns information about provisioned Aurora DB clusters. This API supports
  pagination.

  For more information on Amazon Aurora, see [Aurora on Amazon
  RDS](http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Aurora.html)
  in the *Amazon RDS User Guide.*
  """

  @spec describe_db_clusters(client :: ExAws.RDS.t, input :: describe_db_clusters_message) :: ExAws.Request.Query.response_t
  def describe_db_clusters(client, input) do
    request(client, "/", "DescribeDBClusters", input)
  end

  @doc """
  Same as `describe_db_clusters/2` but raise on error.
  """
  @spec describe_db_clusters!(client :: ExAws.RDS.t, input :: describe_db_clusters_message) :: ExAws.Request.Query.success_t | no_return
  def describe_db_clusters!(client, input) do
    case describe_db_clusters(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeDBEngineVersions

  Returns a list of the available DB engines.
  """

  @spec describe_db_engine_versions(client :: ExAws.RDS.t, input :: describe_db_engine_versions_message) :: ExAws.Request.Query.response_t
  def describe_db_engine_versions(client, input) do
    request(client, "/", "DescribeDBEngineVersions", input)
  end

  @doc """
  Same as `describe_db_engine_versions/2` but raise on error.
  """
  @spec describe_db_engine_versions!(client :: ExAws.RDS.t, input :: describe_db_engine_versions_message) :: ExAws.Request.Query.success_t | no_return
  def describe_db_engine_versions!(client, input) do
    case describe_db_engine_versions(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeDBInstances

  Returns information about provisioned RDS instances. This API supports
  pagination.
  """

  @spec describe_db_instances(client :: ExAws.RDS.t, input :: describe_db_instances_message) :: ExAws.Request.Query.response_t
  def describe_db_instances(client, input) do
    request(client, "/", "DescribeDBInstances", input)
  end

  @doc """
  Same as `describe_db_instances/2` but raise on error.
  """
  @spec describe_db_instances!(client :: ExAws.RDS.t, input :: describe_db_instances_message) :: ExAws.Request.Query.success_t | no_return
  def describe_db_instances!(client, input) do
    case describe_db_instances(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeDBLogFiles

  Returns a list of DB log files for the DB instance.
  """

  @spec describe_db_log_files(client :: ExAws.RDS.t, input :: describe_db_log_files_message) :: ExAws.Request.Query.response_t
  def describe_db_log_files(client, input) do
    request(client, "/", "DescribeDBLogFiles", input)
  end

  @doc """
  Same as `describe_db_log_files/2` but raise on error.
  """
  @spec describe_db_log_files!(client :: ExAws.RDS.t, input :: describe_db_log_files_message) :: ExAws.Request.Query.success_t | no_return
  def describe_db_log_files!(client, input) do
    case describe_db_log_files(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeDBParameterGroups

  Returns a list of `DBParameterGroup` descriptions. If a
  `DBParameterGroupName` is specified, the list will contain only the
  description of the specified DB parameter group.
  """

  @spec describe_db_parameter_groups(client :: ExAws.RDS.t, input :: describe_db_parameter_groups_message) :: ExAws.Request.Query.response_t
  def describe_db_parameter_groups(client, input) do
    request(client, "/", "DescribeDBParameterGroups", input)
  end

  @doc """
  Same as `describe_db_parameter_groups/2` but raise on error.
  """
  @spec describe_db_parameter_groups!(client :: ExAws.RDS.t, input :: describe_db_parameter_groups_message) :: ExAws.Request.Query.success_t | no_return
  def describe_db_parameter_groups!(client, input) do
    case describe_db_parameter_groups(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeDBParameters

  Returns the detailed parameter list for a particular DB parameter group.
  """

  @spec describe_db_parameters(client :: ExAws.RDS.t, input :: describe_db_parameters_message) :: ExAws.Request.Query.response_t
  def describe_db_parameters(client, input) do
    request(client, "/", "DescribeDBParameters", input)
  end

  @doc """
  Same as `describe_db_parameters/2` but raise on error.
  """
  @spec describe_db_parameters!(client :: ExAws.RDS.t, input :: describe_db_parameters_message) :: ExAws.Request.Query.success_t | no_return
  def describe_db_parameters!(client, input) do
    case describe_db_parameters(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeDBSecurityGroups

  Returns a list of `DBSecurityGroup` descriptions. If a
  `DBSecurityGroupName` is specified, the list will contain only the
  descriptions of the specified DB security group.
  """

  @spec describe_db_security_groups(client :: ExAws.RDS.t, input :: describe_db_security_groups_message) :: ExAws.Request.Query.response_t
  def describe_db_security_groups(client, input) do
    request(client, "/", "DescribeDBSecurityGroups", input)
  end

  @doc """
  Same as `describe_db_security_groups/2` but raise on error.
  """
  @spec describe_db_security_groups!(client :: ExAws.RDS.t, input :: describe_db_security_groups_message) :: ExAws.Request.Query.success_t | no_return
  def describe_db_security_groups!(client, input) do
    case describe_db_security_groups(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeDBSnapshots

  Returns information about DB snapshots. This API supports pagination.
  """

  @spec describe_db_snapshots(client :: ExAws.RDS.t, input :: describe_db_snapshots_message) :: ExAws.Request.Query.response_t
  def describe_db_snapshots(client, input) do
    request(client, "/", "DescribeDBSnapshots", input)
  end

  @doc """
  Same as `describe_db_snapshots/2` but raise on error.
  """
  @spec describe_db_snapshots!(client :: ExAws.RDS.t, input :: describe_db_snapshots_message) :: ExAws.Request.Query.success_t | no_return
  def describe_db_snapshots!(client, input) do
    case describe_db_snapshots(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeDBSubnetGroups

  Returns a list of DBSubnetGroup descriptions. If a DBSubnetGroupName is
  specified, the list will contain only the descriptions of the specified
  DBSubnetGroup.

  For an overview of CIDR ranges, go to the [Wikipedia
  Tutorial](http://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing).
  """

  @spec describe_db_subnet_groups(client :: ExAws.RDS.t, input :: describe_db_subnet_groups_message) :: ExAws.Request.Query.response_t
  def describe_db_subnet_groups(client, input) do
    request(client, "/", "DescribeDBSubnetGroups", input)
  end

  @doc """
  Same as `describe_db_subnet_groups/2` but raise on error.
  """
  @spec describe_db_subnet_groups!(client :: ExAws.RDS.t, input :: describe_db_subnet_groups_message) :: ExAws.Request.Query.success_t | no_return
  def describe_db_subnet_groups!(client, input) do
    case describe_db_subnet_groups(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeEngineDefaultClusterParameters

  Returns the default engine and system parameter information for the cluster
  database engine.

  For more information on Amazon Aurora, see [Aurora on Amazon
  RDS](http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Aurora.html)
  in the *Amazon RDS User Guide.*
  """

  @spec describe_engine_default_cluster_parameters(client :: ExAws.RDS.t, input :: describe_engine_default_cluster_parameters_message) :: ExAws.Request.Query.response_t
  def describe_engine_default_cluster_parameters(client, input) do
    request(client, "/", "DescribeEngineDefaultClusterParameters", input)
  end

  @doc """
  Same as `describe_engine_default_cluster_parameters/2` but raise on error.
  """
  @spec describe_engine_default_cluster_parameters!(client :: ExAws.RDS.t, input :: describe_engine_default_cluster_parameters_message) :: ExAws.Request.Query.success_t | no_return
  def describe_engine_default_cluster_parameters!(client, input) do
    case describe_engine_default_cluster_parameters(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeEngineDefaultParameters

  Returns the default engine and system parameter information for the
  specified database engine.
  """

  @spec describe_engine_default_parameters(client :: ExAws.RDS.t, input :: describe_engine_default_parameters_message) :: ExAws.Request.Query.response_t
  def describe_engine_default_parameters(client, input) do
    request(client, "/", "DescribeEngineDefaultParameters", input)
  end

  @doc """
  Same as `describe_engine_default_parameters/2` but raise on error.
  """
  @spec describe_engine_default_parameters!(client :: ExAws.RDS.t, input :: describe_engine_default_parameters_message) :: ExAws.Request.Query.success_t | no_return
  def describe_engine_default_parameters!(client, input) do
    case describe_engine_default_parameters(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeEventCategories

  Displays a list of categories for all event source types, or, if specified,
  for a specified source type. You can see a list of the event categories and
  source types in the [
  Events](http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Events.html)
  topic in the *Amazon RDS User Guide.*
  """

  @spec describe_event_categories(client :: ExAws.RDS.t, input :: describe_event_categories_message) :: ExAws.Request.Query.response_t
  def describe_event_categories(client, input) do
    request(client, "/", "DescribeEventCategories", input)
  end

  @doc """
  Same as `describe_event_categories/2` but raise on error.
  """
  @spec describe_event_categories!(client :: ExAws.RDS.t, input :: describe_event_categories_message) :: ExAws.Request.Query.success_t | no_return
  def describe_event_categories!(client, input) do
    case describe_event_categories(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeEventSubscriptions

  Lists all the subscription descriptions for a customer account. The
  description for a subscription includes SubscriptionName, SNSTopicARN,
  CustomerID, SourceType, SourceID, CreationTime, and Status.

  If you specify a SubscriptionName, lists the description for that
  subscription.
  """

  @spec describe_event_subscriptions(client :: ExAws.RDS.t, input :: describe_event_subscriptions_message) :: ExAws.Request.Query.response_t
  def describe_event_subscriptions(client, input) do
    request(client, "/", "DescribeEventSubscriptions", input)
  end

  @doc """
  Same as `describe_event_subscriptions/2` but raise on error.
  """
  @spec describe_event_subscriptions!(client :: ExAws.RDS.t, input :: describe_event_subscriptions_message) :: ExAws.Request.Query.success_t | no_return
  def describe_event_subscriptions!(client, input) do
    case describe_event_subscriptions(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeEvents

  Returns events related to DB instances, DB security groups, DB snapshots,
  and DB parameter groups for the past 14 days. Events specific to a
  particular DB instance, DB security group, database snapshot, or DB
  parameter group can be obtained by providing the name as a parameter. By
  default, the past hour of events are returned.
  """

  @spec describe_events(client :: ExAws.RDS.t, input :: describe_events_message) :: ExAws.Request.Query.response_t
  def describe_events(client, input) do
    request(client, "/", "DescribeEvents", input)
  end

  @doc """
  Same as `describe_events/2` but raise on error.
  """
  @spec describe_events!(client :: ExAws.RDS.t, input :: describe_events_message) :: ExAws.Request.Query.success_t | no_return
  def describe_events!(client, input) do
    case describe_events(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeOptionGroupOptions

  Describes all available options.
  """

  @spec describe_option_group_options(client :: ExAws.RDS.t, input :: describe_option_group_options_message) :: ExAws.Request.Query.response_t
  def describe_option_group_options(client, input) do
    request(client, "/", "DescribeOptionGroupOptions", input)
  end

  @doc """
  Same as `describe_option_group_options/2` but raise on error.
  """
  @spec describe_option_group_options!(client :: ExAws.RDS.t, input :: describe_option_group_options_message) :: ExAws.Request.Query.success_t | no_return
  def describe_option_group_options!(client, input) do
    case describe_option_group_options(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeOptionGroups

  Describes the available option groups.
  """

  @spec describe_option_groups(client :: ExAws.RDS.t, input :: describe_option_groups_message) :: ExAws.Request.Query.response_t
  def describe_option_groups(client, input) do
    request(client, "/", "DescribeOptionGroups", input)
  end

  @doc """
  Same as `describe_option_groups/2` but raise on error.
  """
  @spec describe_option_groups!(client :: ExAws.RDS.t, input :: describe_option_groups_message) :: ExAws.Request.Query.success_t | no_return
  def describe_option_groups!(client, input) do
    case describe_option_groups(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeOrderableDBInstanceOptions

  Returns a list of orderable DB instance options for the specified engine.
  """

  @spec describe_orderable_db_instance_options(client :: ExAws.RDS.t, input :: describe_orderable_db_instance_options_message) :: ExAws.Request.Query.response_t
  def describe_orderable_db_instance_options(client, input) do
    request(client, "/", "DescribeOrderableDBInstanceOptions", input)
  end

  @doc """
  Same as `describe_orderable_db_instance_options/2` but raise on error.
  """
  @spec describe_orderable_db_instance_options!(client :: ExAws.RDS.t, input :: describe_orderable_db_instance_options_message) :: ExAws.Request.Query.success_t | no_return
  def describe_orderable_db_instance_options!(client, input) do
    case describe_orderable_db_instance_options(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribePendingMaintenanceActions

  Returns a list of resources (for example, DB instances) that have at least
  one pending maintenance action.
  """

  @spec describe_pending_maintenance_actions(client :: ExAws.RDS.t, input :: describe_pending_maintenance_actions_message) :: ExAws.Request.Query.response_t
  def describe_pending_maintenance_actions(client, input) do
    request(client, "/", "DescribePendingMaintenanceActions", input)
  end

  @doc """
  Same as `describe_pending_maintenance_actions/2` but raise on error.
  """
  @spec describe_pending_maintenance_actions!(client :: ExAws.RDS.t, input :: describe_pending_maintenance_actions_message) :: ExAws.Request.Query.success_t | no_return
  def describe_pending_maintenance_actions!(client, input) do
    case describe_pending_maintenance_actions(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeReservedDBInstances

  Returns information about reserved DB instances for this account, or about
  a specified reserved DB instance.
  """

  @spec describe_reserved_db_instances(client :: ExAws.RDS.t, input :: describe_reserved_db_instances_message) :: ExAws.Request.Query.response_t
  def describe_reserved_db_instances(client, input) do
    request(client, "/", "DescribeReservedDBInstances", input)
  end

  @doc """
  Same as `describe_reserved_db_instances/2` but raise on error.
  """
  @spec describe_reserved_db_instances!(client :: ExAws.RDS.t, input :: describe_reserved_db_instances_message) :: ExAws.Request.Query.success_t | no_return
  def describe_reserved_db_instances!(client, input) do
    case describe_reserved_db_instances(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeReservedDBInstancesOfferings

  Lists available reserved DB instance offerings.
  """

  @spec describe_reserved_db_instances_offerings(client :: ExAws.RDS.t, input :: describe_reserved_db_instances_offerings_message) :: ExAws.Request.Query.response_t
  def describe_reserved_db_instances_offerings(client, input) do
    request(client, "/", "DescribeReservedDBInstancesOfferings", input)
  end

  @doc """
  Same as `describe_reserved_db_instances_offerings/2` but raise on error.
  """
  @spec describe_reserved_db_instances_offerings!(client :: ExAws.RDS.t, input :: describe_reserved_db_instances_offerings_message) :: ExAws.Request.Query.success_t | no_return
  def describe_reserved_db_instances_offerings!(client, input) do
    case describe_reserved_db_instances_offerings(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DownloadDBLogFilePortion

  Downloads all or a portion of the specified log file, up to 1 MB in size.
  """

  @spec download_db_log_file_portion(client :: ExAws.RDS.t, input :: download_db_log_file_portion_message) :: ExAws.Request.Query.response_t
  def download_db_log_file_portion(client, input) do
    request(client, "/", "DownloadDBLogFilePortion", input)
  end

  @doc """
  Same as `download_db_log_file_portion/2` but raise on error.
  """
  @spec download_db_log_file_portion!(client :: ExAws.RDS.t, input :: download_db_log_file_portion_message) :: ExAws.Request.Query.success_t | no_return
  def download_db_log_file_portion!(client, input) do
    case download_db_log_file_portion(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  FailoverDBCluster

  Forces a failover for a DB cluster.

  A failover for a DB cluster promotes one of the read-only instances in the
  DB cluster to the master DB instance (the cluster writer) and deletes the
  current primary instance.

  Amazon Aurora will automatically fail over to a read-only instance, if one
  exists, when the primary instance fails. You can force a failover when you
  want to simulate a failure of a DB instance for testing. Because each
  instance in a DB cluster has its own endpoint address, you will need to
  clean up and re-establish any existing connections that use those endpoint
  addresses when the failover is complete.

  For more information on Amazon Aurora, see [Aurora on Amazon
  RDS](http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Aurora.html)
  in the *Amazon RDS User Guide.*
  """

  @spec failover_db_cluster(client :: ExAws.RDS.t, input :: failover_db_cluster_message) :: ExAws.Request.Query.response_t
  def failover_db_cluster(client, input) do
    request(client, "/", "FailoverDBCluster", input)
  end

  @doc """
  Same as `failover_db_cluster/2` but raise on error.
  """
  @spec failover_db_cluster!(client :: ExAws.RDS.t, input :: failover_db_cluster_message) :: ExAws.Request.Query.success_t | no_return
  def failover_db_cluster!(client, input) do
    case failover_db_cluster(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListTagsForResource

  Lists all tags on an Amazon RDS resource.

  For an overview on tagging an Amazon RDS resource, see [Tagging Amazon RDS
  Resources](http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Overview.Tagging.html).
  """

  @spec list_tags_for_resource(client :: ExAws.RDS.t, input :: list_tags_for_resource_message) :: ExAws.Request.Query.response_t
  def list_tags_for_resource(client, input) do
    request(client, "/", "ListTagsForResource", input)
  end

  @doc """
  Same as `list_tags_for_resource/2` but raise on error.
  """
  @spec list_tags_for_resource!(client :: ExAws.RDS.t, input :: list_tags_for_resource_message) :: ExAws.Request.Query.success_t | no_return
  def list_tags_for_resource!(client, input) do
    case list_tags_for_resource(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ModifyDBCluster

  Modify a setting for an Amazon Aurora DB cluster. You can change one or
  more database configuration parameters by specifying these parameters and
  the new values in the request. For more information on Amazon Aurora, see
  [Aurora on Amazon
  RDS](http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Aurora.html)
  in the *Amazon RDS User Guide.*
  """

  @spec modify_db_cluster(client :: ExAws.RDS.t, input :: modify_db_cluster_message) :: ExAws.Request.Query.response_t
  def modify_db_cluster(client, input) do
    request(client, "/", "ModifyDBCluster", input)
  end

  @doc """
  Same as `modify_db_cluster/2` but raise on error.
  """
  @spec modify_db_cluster!(client :: ExAws.RDS.t, input :: modify_db_cluster_message) :: ExAws.Request.Query.success_t | no_return
  def modify_db_cluster!(client, input) do
    case modify_db_cluster(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ModifyDBClusterParameterGroup

  Modifies the parameters of a DB cluster parameter group. To modify more
  than one parameter, submit a list of the following: `ParameterName`,
  `ParameterValue`, and `ApplyMethod`. A maximum of 20 parameters can be
  modified in a single request.

  For more information on Amazon Aurora, see [Aurora on Amazon
  RDS](http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Aurora.html)
  in the *Amazon RDS User Guide.*

  Note: Changes to dynamic parameters are applied immediately. Changes to
  static parameters require a reboot without failover to the DB cluster
  associated with the parameter group before the change can take effect.

  ** After you create a DB cluster parameter group, you should wait at least
  5 minutes before creating your first DB cluster that uses that DB cluster
  parameter group as the default parameter group. This allows Amazon RDS to
  fully complete the create action before the parameter group is used as the
  default for a new DB cluster. This is especially important for parameters
  that are critical when creating the default database for a DB cluster, such
  as the character set for the default database defined by the
  `character_set_database` parameter. You can use the *Parameter Groups*
  option of the [Amazon RDS console](https://console.aws.amazon.com/rds/) or
  the `DescribeDBClusterParameters` command to verify that your DB cluster
  parameter group has been created or modified.

  **
  """

  @spec modify_db_cluster_parameter_group(client :: ExAws.RDS.t, input :: modify_db_cluster_parameter_group_message) :: ExAws.Request.Query.response_t
  def modify_db_cluster_parameter_group(client, input) do
    request(client, "/", "ModifyDBClusterParameterGroup", input)
  end

  @doc """
  Same as `modify_db_cluster_parameter_group/2` but raise on error.
  """
  @spec modify_db_cluster_parameter_group!(client :: ExAws.RDS.t, input :: modify_db_cluster_parameter_group_message) :: ExAws.Request.Query.success_t | no_return
  def modify_db_cluster_parameter_group!(client, input) do
    case modify_db_cluster_parameter_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ModifyDBInstance

  Modify settings for a DB instance. You can change one or more database
  configuration parameters by specifying these parameters and the new values
  in the request.
  """

  @spec modify_db_instance(client :: ExAws.RDS.t, input :: modify_db_instance_message) :: ExAws.Request.Query.response_t
  def modify_db_instance(client, input) do
    request(client, "/", "ModifyDBInstance", input)
  end

  @doc """
  Same as `modify_db_instance/2` but raise on error.
  """
  @spec modify_db_instance!(client :: ExAws.RDS.t, input :: modify_db_instance_message) :: ExAws.Request.Query.success_t | no_return
  def modify_db_instance!(client, input) do
    case modify_db_instance(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ModifyDBParameterGroup

  Modifies the parameters of a DB parameter group. To modify more than one
  parameter, submit a list of the following: `ParameterName`,
  `ParameterValue`, and `ApplyMethod`. A maximum of 20 parameters can be
  modified in a single request.

  Note: Changes to dynamic parameters are applied immediately. Changes to
  static parameters require a reboot without failover to the DB instance
  associated with the parameter group before the change can take effect.

  ** After you modify a DB parameter group, you should wait at least 5
  minutes before creating your first DB instance that uses that DB parameter
  group as the default parameter group. This allows Amazon RDS to fully
  complete the modify action before the parameter group is used as the
  default for a new DB instance. This is especially important for parameters
  that are critical when creating the default database for a DB instance,
  such as the character set for the default database defined by the
  `character_set_database` parameter. You can use the *Parameter Groups*
  option of the [Amazon RDS console](https://console.aws.amazon.com/rds/) or
  the *DescribeDBParameters* command to verify that your DB parameter group
  has been created or modified.

  **
  """

  @spec modify_db_parameter_group(client :: ExAws.RDS.t, input :: modify_db_parameter_group_message) :: ExAws.Request.Query.response_t
  def modify_db_parameter_group(client, input) do
    request(client, "/", "ModifyDBParameterGroup", input)
  end

  @doc """
  Same as `modify_db_parameter_group/2` but raise on error.
  """
  @spec modify_db_parameter_group!(client :: ExAws.RDS.t, input :: modify_db_parameter_group_message) :: ExAws.Request.Query.success_t | no_return
  def modify_db_parameter_group!(client, input) do
    case modify_db_parameter_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ModifyDBSubnetGroup

  Modifies an existing DB subnet group. DB subnet groups must contain at
  least one subnet in at least two AZs in the region.
  """

  @spec modify_db_subnet_group(client :: ExAws.RDS.t, input :: modify_db_subnet_group_message) :: ExAws.Request.Query.response_t
  def modify_db_subnet_group(client, input) do
    request(client, "/", "ModifyDBSubnetGroup", input)
  end

  @doc """
  Same as `modify_db_subnet_group/2` but raise on error.
  """
  @spec modify_db_subnet_group!(client :: ExAws.RDS.t, input :: modify_db_subnet_group_message) :: ExAws.Request.Query.success_t | no_return
  def modify_db_subnet_group!(client, input) do
    case modify_db_subnet_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ModifyEventSubscription

  Modifies an existing RDS event notification subscription. Note that you
  cannot modify the source identifiers using this call; to change source
  identifiers for a subscription, use the `AddSourceIdentifierToSubscription`
  and `RemoveSourceIdentifierFromSubscription` calls.

  You can see a list of the event categories for a given SourceType in the
  [Events](http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Events.html)
  topic in the Amazon RDS User Guide or by using the
  **DescribeEventCategories** action.
  """

  @spec modify_event_subscription(client :: ExAws.RDS.t, input :: modify_event_subscription_message) :: ExAws.Request.Query.response_t
  def modify_event_subscription(client, input) do
    request(client, "/", "ModifyEventSubscription", input)
  end

  @doc """
  Same as `modify_event_subscription/2` but raise on error.
  """
  @spec modify_event_subscription!(client :: ExAws.RDS.t, input :: modify_event_subscription_message) :: ExAws.Request.Query.success_t | no_return
  def modify_event_subscription!(client, input) do
    case modify_event_subscription(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ModifyOptionGroup

  Modifies an existing option group.
  """

  @spec modify_option_group(client :: ExAws.RDS.t, input :: modify_option_group_message) :: ExAws.Request.Query.response_t
  def modify_option_group(client, input) do
    request(client, "/", "ModifyOptionGroup", input)
  end

  @doc """
  Same as `modify_option_group/2` but raise on error.
  """
  @spec modify_option_group!(client :: ExAws.RDS.t, input :: modify_option_group_message) :: ExAws.Request.Query.success_t | no_return
  def modify_option_group!(client, input) do
    case modify_option_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  PromoteReadReplica

  Promotes a Read Replica DB instance to a standalone DB instance.

  Note: We recommend that you enable automated backups on your Read Replica
  before promoting the Read Replica. This ensures that no backup is taken
  during the promotion process. Once the instance is promoted to a primary
  instance, backups are taken based on your backup settings.
  """

  @spec promote_read_replica(client :: ExAws.RDS.t, input :: promote_read_replica_message) :: ExAws.Request.Query.response_t
  def promote_read_replica(client, input) do
    request(client, "/", "PromoteReadReplica", input)
  end

  @doc """
  Same as `promote_read_replica/2` but raise on error.
  """
  @spec promote_read_replica!(client :: ExAws.RDS.t, input :: promote_read_replica_message) :: ExAws.Request.Query.success_t | no_return
  def promote_read_replica!(client, input) do
    case promote_read_replica(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  PurchaseReservedDBInstancesOffering

  Purchases a reserved DB instance offering.
  """

  @spec purchase_reserved_db_instances_offering(client :: ExAws.RDS.t, input :: purchase_reserved_db_instances_offering_message) :: ExAws.Request.Query.response_t
  def purchase_reserved_db_instances_offering(client, input) do
    request(client, "/", "PurchaseReservedDBInstancesOffering", input)
  end

  @doc """
  Same as `purchase_reserved_db_instances_offering/2` but raise on error.
  """
  @spec purchase_reserved_db_instances_offering!(client :: ExAws.RDS.t, input :: purchase_reserved_db_instances_offering_message) :: ExAws.Request.Query.success_t | no_return
  def purchase_reserved_db_instances_offering!(client, input) do
    case purchase_reserved_db_instances_offering(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RebootDBInstance

  Rebooting a DB instance restarts the database engine service. A reboot also
  applies to the DB instance any modifications to the associated DB parameter
  group that were pending. Rebooting a DB instance results in a momentary
  outage of the instance, during which the DB instance status is set to
  rebooting. If the RDS instance is configured for MultiAZ, it is possible
  that the reboot will be conducted through a failover. An Amazon RDS event
  is created when the reboot is completed.

  If your DB instance is deployed in multiple Availability Zones, you can
  force a failover from one AZ to the other during the reboot. You might
  force a failover to test the availability of your DB instance deployment or
  to restore operations to the original AZ after a failover occurs.

  The time required to reboot is a function of the specific database engine's
  crash recovery process. To improve the reboot time, we recommend that you
  reduce database activities as much as possible during the reboot process to
  reduce rollback activity for in-transit transactions.
  """

  @spec reboot_db_instance(client :: ExAws.RDS.t, input :: reboot_db_instance_message) :: ExAws.Request.Query.response_t
  def reboot_db_instance(client, input) do
    request(client, "/", "RebootDBInstance", input)
  end

  @doc """
  Same as `reboot_db_instance/2` but raise on error.
  """
  @spec reboot_db_instance!(client :: ExAws.RDS.t, input :: reboot_db_instance_message) :: ExAws.Request.Query.success_t | no_return
  def reboot_db_instance!(client, input) do
    case reboot_db_instance(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RemoveSourceIdentifierFromSubscription

  Removes a source identifier from an existing RDS event notification
  subscription.
  """

  @spec remove_source_identifier_from_subscription(client :: ExAws.RDS.t, input :: remove_source_identifier_from_subscription_message) :: ExAws.Request.Query.response_t
  def remove_source_identifier_from_subscription(client, input) do
    request(client, "/", "RemoveSourceIdentifierFromSubscription", input)
  end

  @doc """
  Same as `remove_source_identifier_from_subscription/2` but raise on error.
  """
  @spec remove_source_identifier_from_subscription!(client :: ExAws.RDS.t, input :: remove_source_identifier_from_subscription_message) :: ExAws.Request.Query.success_t | no_return
  def remove_source_identifier_from_subscription!(client, input) do
    case remove_source_identifier_from_subscription(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RemoveTagsFromResource

  Removes metadata tags from an Amazon RDS resource.

  For an overview on tagging an Amazon RDS resource, see [Tagging Amazon RDS
  Resources](http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Overview.Tagging.html).
  """

  @spec remove_tags_from_resource(client :: ExAws.RDS.t, input :: remove_tags_from_resource_message) :: ExAws.Request.Query.response_t
  def remove_tags_from_resource(client, input) do
    request(client, "/", "RemoveTagsFromResource", input)
  end

  @doc """
  Same as `remove_tags_from_resource/2` but raise on error.
  """
  @spec remove_tags_from_resource!(client :: ExAws.RDS.t, input :: remove_tags_from_resource_message) :: ExAws.Request.Query.success_t | no_return
  def remove_tags_from_resource!(client, input) do
    case remove_tags_from_resource(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ResetDBClusterParameterGroup

  Modifies the parameters of a DB cluster parameter group to the default
  value. To reset specific parameters submit a list of the following:
  `ParameterName` and `ApplyMethod`. To reset the entire DB cluster parameter
  group, specify the `DBClusterParameterGroupName` and `ResetAllParameters`
  parameters.

  When resetting the entire group, dynamic parameters are updated immediately
  and static parameters are set to `pending-reboot` to take effect on the
  next DB instance restart or `RebootDBInstance` request. You must call
  `RebootDBInstance` for every DB instance in your DB cluster that you want
  the updated static parameter to apply to.

  For more information on Amazon Aurora, see [Aurora on Amazon
  RDS](http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Aurora.html)
  in the *Amazon RDS User Guide.*
  """

  @spec reset_db_cluster_parameter_group(client :: ExAws.RDS.t, input :: reset_db_cluster_parameter_group_message) :: ExAws.Request.Query.response_t
  def reset_db_cluster_parameter_group(client, input) do
    request(client, "/", "ResetDBClusterParameterGroup", input)
  end

  @doc """
  Same as `reset_db_cluster_parameter_group/2` but raise on error.
  """
  @spec reset_db_cluster_parameter_group!(client :: ExAws.RDS.t, input :: reset_db_cluster_parameter_group_message) :: ExAws.Request.Query.success_t | no_return
  def reset_db_cluster_parameter_group!(client, input) do
    case reset_db_cluster_parameter_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ResetDBParameterGroup

  Modifies the parameters of a DB parameter group to the engine/system
  default value. To reset specific parameters submit a list of the following:
  `ParameterName` and `ApplyMethod`. To reset the entire DB parameter group,
  specify the `DBParameterGroup` name and `ResetAllParameters` parameters.
  When resetting the entire group, dynamic parameters are updated immediately
  and static parameters are set to `pending-reboot` to take effect on the
  next DB instance restart or `RebootDBInstance` request.
  """

  @spec reset_db_parameter_group(client :: ExAws.RDS.t, input :: reset_db_parameter_group_message) :: ExAws.Request.Query.response_t
  def reset_db_parameter_group(client, input) do
    request(client, "/", "ResetDBParameterGroup", input)
  end

  @doc """
  Same as `reset_db_parameter_group/2` but raise on error.
  """
  @spec reset_db_parameter_group!(client :: ExAws.RDS.t, input :: reset_db_parameter_group_message) :: ExAws.Request.Query.success_t | no_return
  def reset_db_parameter_group!(client, input) do
    case reset_db_parameter_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RestoreDBClusterFromSnapshot

  Creates a new DB cluster from a DB cluster snapshot. The target DB cluster
  is created from the source DB cluster restore point with the same
  configuration as the original source DB cluster, except that the new DB
  cluster is created with the default security group.

  For more information on Amazon Aurora, see [Aurora on Amazon
  RDS](http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Aurora.html)
  in the *Amazon RDS User Guide.*
  """

  @spec restore_db_cluster_from_snapshot(client :: ExAws.RDS.t, input :: restore_db_cluster_from_snapshot_message) :: ExAws.Request.Query.response_t
  def restore_db_cluster_from_snapshot(client, input) do
    request(client, "/", "RestoreDBClusterFromSnapshot", input)
  end

  @doc """
  Same as `restore_db_cluster_from_snapshot/2` but raise on error.
  """
  @spec restore_db_cluster_from_snapshot!(client :: ExAws.RDS.t, input :: restore_db_cluster_from_snapshot_message) :: ExAws.Request.Query.success_t | no_return
  def restore_db_cluster_from_snapshot!(client, input) do
    case restore_db_cluster_from_snapshot(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RestoreDBClusterToPointInTime

  Restores a DB cluster to an arbitrary point in time. Users can restore to
  any point in time before `LatestRestorableTime` for up to
  `BackupRetentionPeriod` days. The target DB cluster is created from the
  source DB cluster with the same configuration as the original DB cluster,
  except that the new DB cluster is created with the default DB security
  group.

  For more information on Amazon Aurora, see [Aurora on Amazon
  RDS](http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Aurora.html)
  in the *Amazon RDS User Guide.*
  """

  @spec restore_db_cluster_to_point_in_time(client :: ExAws.RDS.t, input :: restore_db_cluster_to_point_in_time_message) :: ExAws.Request.Query.response_t
  def restore_db_cluster_to_point_in_time(client, input) do
    request(client, "/", "RestoreDBClusterToPointInTime", input)
  end

  @doc """
  Same as `restore_db_cluster_to_point_in_time/2` but raise on error.
  """
  @spec restore_db_cluster_to_point_in_time!(client :: ExAws.RDS.t, input :: restore_db_cluster_to_point_in_time_message) :: ExAws.Request.Query.success_t | no_return
  def restore_db_cluster_to_point_in_time!(client, input) do
    case restore_db_cluster_to_point_in_time(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RestoreDBInstanceFromDBSnapshot

  Creates a new DB instance from a DB snapshot. The target database is
  created from the source database restore point with the most of original
  configuration, but in a system chosen availability zone with the default
  security group, the default subnet group, and the default DB parameter
  group. By default, the new DB instance is created as a single-AZ deployment
  except when the instance is a SQL Server instance that has an option group
  that is associated with mirroring; in this case, the instance becomes a
  mirrored AZ deployment and not a single-AZ deployment.

  If your intent is to replace your original DB instance with the new,
  restored DB instance, then rename your original DB instance before you call
  the RestoreDBInstanceFromDBSnapshot action. RDS does not allow two DB
  instances with the same name. Once you have renamed your original DB
  instance with a different identifier, then you can pass the original name
  of the DB instance as the DBInstanceIdentifier in the call to the
  RestoreDBInstanceFromDBSnapshot action. The result is that you will replace
  the original DB instance with the DB instance created from the snapshot.
  """

  @spec restore_db_instance_from_db_snapshot(client :: ExAws.RDS.t, input :: restore_db_instance_from_db_snapshot_message) :: ExAws.Request.Query.response_t
  def restore_db_instance_from_db_snapshot(client, input) do
    request(client, "/", "RestoreDBInstanceFromDBSnapshot", input)
  end

  @doc """
  Same as `restore_db_instance_from_db_snapshot/2` but raise on error.
  """
  @spec restore_db_instance_from_db_snapshot!(client :: ExAws.RDS.t, input :: restore_db_instance_from_db_snapshot_message) :: ExAws.Request.Query.success_t | no_return
  def restore_db_instance_from_db_snapshot!(client, input) do
    case restore_db_instance_from_db_snapshot(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RestoreDBInstanceToPointInTime

  Restores a DB instance to an arbitrary point-in-time. Users can restore to
  any point in time before the LatestRestorableTime for up to
  BackupRetentionPeriod days. The target database is created with the most of
  original configuration, but in a system chosen availability zone with the
  default security group, the default subnet group, and the default DB
  parameter group. By default, the new DB instance is created as a single-AZ
  deployment except when the instance is a SQL Server instance that has an
  option group that is associated with mirroring; in this case, the instance
  becomes a mirrored deployment and not a single-AZ deployment.
  """

  @spec restore_db_instance_to_point_in_time(client :: ExAws.RDS.t, input :: restore_db_instance_to_point_in_time_message) :: ExAws.Request.Query.response_t
  def restore_db_instance_to_point_in_time(client, input) do
    request(client, "/", "RestoreDBInstanceToPointInTime", input)
  end

  @doc """
  Same as `restore_db_instance_to_point_in_time/2` but raise on error.
  """
  @spec restore_db_instance_to_point_in_time!(client :: ExAws.RDS.t, input :: restore_db_instance_to_point_in_time_message) :: ExAws.Request.Query.success_t | no_return
  def restore_db_instance_to_point_in_time!(client, input) do
    case restore_db_instance_to_point_in_time(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RevokeDBSecurityGroupIngress

  Revokes ingress from a DBSecurityGroup for previously authorized IP ranges
  or EC2 or VPC Security Groups. Required parameters for this API are one of
  CIDRIP, EC2SecurityGroupId for VPC, or (EC2SecurityGroupOwnerId and either
  EC2SecurityGroupName or EC2SecurityGroupId).
  """

  @spec revoke_db_security_group_ingress(client :: ExAws.RDS.t, input :: revoke_db_security_group_ingress_message) :: ExAws.Request.Query.response_t
  def revoke_db_security_group_ingress(client, input) do
    request(client, "/", "RevokeDBSecurityGroupIngress", input)
  end

  @doc """
  Same as `revoke_db_security_group_ingress/2` but raise on error.
  """
  @spec revoke_db_security_group_ingress!(client :: ExAws.RDS.t, input :: revoke_db_security_group_ingress_message) :: ExAws.Request.Query.success_t | no_return
  def revoke_db_security_group_ingress!(client, input) do
    case revoke_db_security_group_ingress(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  defp request(%{__struct__: client_module} = client, uri, action, input) do
    apply(client_module, :request, [client, uri, action, input])
  end
end
