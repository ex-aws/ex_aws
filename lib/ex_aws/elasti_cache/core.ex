defmodule ExAws.ElastiCache.Core do
  @actions [
    "AddTagsToResource",
    "AuthorizeCacheSecurityGroupIngress",
    "CopySnapshot",
    "CreateCacheCluster",
    "CreateCacheParameterGroup",
    "CreateCacheSecurityGroup",
    "CreateCacheSubnetGroup",
    "CreateReplicationGroup",
    "CreateSnapshot",
    "DeleteCacheCluster",
    "DeleteCacheParameterGroup",
    "DeleteCacheSecurityGroup",
    "DeleteCacheSubnetGroup",
    "DeleteReplicationGroup",
    "DeleteSnapshot",
    "DescribeCacheClusters",
    "DescribeCacheEngineVersions",
    "DescribeCacheParameterGroups",
    "DescribeCacheParameters",
    "DescribeCacheSecurityGroups",
    "DescribeCacheSubnetGroups",
    "DescribeEngineDefaultParameters",
    "DescribeEvents",
    "DescribeReplicationGroups",
    "DescribeReservedCacheNodes",
    "DescribeReservedCacheNodesOfferings",
    "DescribeSnapshots",
    "ListTagsForResource",
    "ModifyCacheCluster",
    "ModifyCacheParameterGroup",
    "ModifyCacheSubnetGroup",
    "ModifyReplicationGroup",
    "PurchaseReservedCacheNodesOffering",
    "RebootCacheCluster",
    "RemoveTagsFromResource",
    "ResetCacheParameterGroup",
    "RevokeCacheSecurityGroupIngress"]

  @moduledoc """
  ## Amazon ElastiCache

  Amazon ElastiCache

  Amazon ElastiCache is a web service that makes it easier to set up,
  operate, and scale a distributed cache in the cloud.

  With ElastiCache, customers gain all of the benefits of a high-performance,
  in-memory cache with far less of the administrative burden of launching and
  managing a distributed cache. The service makes setup, scaling, and cluster
  failure handling much simpler than in a self-managed cache deployment.

  In addition, through integration with Amazon CloudWatch, customers get
  enhanced visibility into the key performance statistics associated with
  their cache and can receive alarms if a part of their cache runs hot.
  """

  @type az_mode :: binary

  @type add_tags_to_resource_message :: [
    resource_name: binary,
    tags: tag_list,
  ]

  @type authorization_already_exists_fault :: [
  ]

  @type authorization_not_found_fault :: [
  ]

  @type authorize_cache_security_group_ingress_message :: [
    cache_security_group_name: binary,
    e_c2_security_group_name: binary,
    e_c2_security_group_owner_id: binary,
  ]

  @type authorize_cache_security_group_ingress_result :: [
    cache_security_group: cache_security_group,
  ]

  @type automatic_failover_status :: binary

  @type availability_zone :: [
    name: binary,
  ]

  @type availability_zones_list :: [binary]

  @type aws_query_error_message :: binary

  @type boolean_optional :: boolean

  @type cache_cluster :: [
    auto_minor_version_upgrade: boolean,
    cache_cluster_create_time: t_stamp,
    cache_cluster_id: binary,
    cache_cluster_status: binary,
    cache_node_type: binary,
    cache_nodes: cache_node_list,
    cache_parameter_group: cache_parameter_group_status,
    cache_security_groups: cache_security_group_membership_list,
    cache_subnet_group_name: binary,
    client_download_landing_page: binary,
    configuration_endpoint: endpoint,
    engine: binary,
    engine_version: binary,
    notification_configuration: notification_configuration,
    num_cache_nodes: integer_optional,
    pending_modified_values: pending_modified_values,
    preferred_availability_zone: binary,
    preferred_maintenance_window: binary,
    replication_group_id: binary,
    security_groups: security_group_membership_list,
    snapshot_retention_limit: integer_optional,
    snapshot_window: binary,
  ]

  @type cache_cluster_already_exists_fault :: [
  ]

  @type cache_cluster_list :: [cache_cluster]

  @type cache_cluster_message :: [
    cache_clusters: cache_cluster_list,
    marker: binary,
  ]

  @type cache_cluster_not_found_fault :: [
  ]

  @type cache_engine_version :: [
    cache_engine_description: binary,
    cache_engine_version_description: binary,
    cache_parameter_group_family: binary,
    engine: binary,
    engine_version: binary,
  ]

  @type cache_engine_version_list :: [cache_engine_version]

  @type cache_engine_version_message :: [
    cache_engine_versions: cache_engine_version_list,
    marker: binary,
  ]

  @type cache_node :: [
    cache_node_create_time: t_stamp,
    cache_node_id: binary,
    cache_node_status: binary,
    customer_availability_zone: binary,
    endpoint: endpoint,
    parameter_group_status: binary,
    source_cache_node_id: binary,
  ]

  @type cache_node_ids_list :: [binary]

  @type cache_node_list :: [cache_node]

  @type cache_node_type_specific_parameter :: [
    allowed_values: binary,
    cache_node_type_specific_values: cache_node_type_specific_value_list,
    data_type: binary,
    description: binary,
    is_modifiable: boolean,
    minimum_engine_version: binary,
    parameter_name: binary,
    source: binary,
  ]

  @type cache_node_type_specific_parameters_list :: [cache_node_type_specific_parameter]

  @type cache_node_type_specific_value :: [
    cache_node_type: binary,
    value: binary,
  ]

  @type cache_node_type_specific_value_list :: [cache_node_type_specific_value]

  @type cache_parameter_group :: [
    cache_parameter_group_family: binary,
    cache_parameter_group_name: binary,
    description: binary,
  ]

  @type cache_parameter_group_already_exists_fault :: [
  ]

  @type cache_parameter_group_details :: [
    cache_node_type_specific_parameters: cache_node_type_specific_parameters_list,
    marker: binary,
    parameters: parameters_list,
  ]

  @type cache_parameter_group_list :: [cache_parameter_group]

  @type cache_parameter_group_name_message :: [
    cache_parameter_group_name: binary,
  ]

  @type cache_parameter_group_not_found_fault :: [
  ]

  @type cache_parameter_group_quota_exceeded_fault :: [
  ]

  @type cache_parameter_group_status :: [
    cache_node_ids_to_reboot: cache_node_ids_list,
    cache_parameter_group_name: binary,
    parameter_apply_status: binary,
  ]

  @type cache_parameter_groups_message :: [
    cache_parameter_groups: cache_parameter_group_list,
    marker: binary,
  ]

  @type cache_security_group :: [
    cache_security_group_name: binary,
    description: binary,
    e_c2_security_groups: ec2_security_group_list,
    owner_id: binary,
  ]

  @type cache_security_group_already_exists_fault :: [
  ]

  @type cache_security_group_membership :: [
    cache_security_group_name: binary,
    status: binary,
  ]

  @type cache_security_group_membership_list :: [cache_security_group_membership]

  @type cache_security_group_message :: [
    cache_security_groups: cache_security_groups,
    marker: binary,
  ]

  @type cache_security_group_name_list :: [binary]

  @type cache_security_group_not_found_fault :: [
  ]

  @type cache_security_group_quota_exceeded_fault :: [
  ]

  @type cache_security_groups :: [cache_security_group]

  @type cache_subnet_group :: [
    cache_subnet_group_description: binary,
    cache_subnet_group_name: binary,
    subnets: subnet_list,
    vpc_id: binary,
  ]

  @type cache_subnet_group_already_exists_fault :: [
  ]

  @type cache_subnet_group_in_use :: [
  ]

  @type cache_subnet_group_message :: [
    cache_subnet_groups: cache_subnet_groups,
    marker: binary,
  ]

  @type cache_subnet_group_not_found_fault :: [
  ]

  @type cache_subnet_group_quota_exceeded_fault :: [
  ]

  @type cache_subnet_groups :: [cache_subnet_group]

  @type cache_subnet_quota_exceeded_fault :: [
  ]

  @type cluster_id_list :: [binary]

  @type cluster_quota_for_customer_exceeded_fault :: [
  ]

  @type copy_snapshot_message :: [
    source_snapshot_name: binary,
    target_snapshot_name: binary,
  ]

  @type copy_snapshot_result :: [
    snapshot: snapshot,
  ]

  @type create_cache_cluster_message :: [
    az_mode: az_mode,
    auto_minor_version_upgrade: boolean_optional,
    cache_cluster_id: binary,
    cache_node_type: binary,
    cache_parameter_group_name: binary,
    cache_security_group_names: cache_security_group_name_list,
    cache_subnet_group_name: binary,
    engine: binary,
    engine_version: binary,
    notification_topic_arn: binary,
    num_cache_nodes: integer_optional,
    port: integer_optional,
    preferred_availability_zone: binary,
    preferred_availability_zones: preferred_availability_zone_list,
    preferred_maintenance_window: binary,
    replication_group_id: binary,
    security_group_ids: security_group_ids_list,
    snapshot_arns: snapshot_arns_list,
    snapshot_name: binary,
    snapshot_retention_limit: integer_optional,
    snapshot_window: binary,
    tags: tag_list,
  ]

  @type create_cache_cluster_result :: [
    cache_cluster: cache_cluster,
  ]

  @type create_cache_parameter_group_message :: [
    cache_parameter_group_family: binary,
    cache_parameter_group_name: binary,
    description: binary,
  ]

  @type create_cache_parameter_group_result :: [
    cache_parameter_group: cache_parameter_group,
  ]

  @type create_cache_security_group_message :: [
    cache_security_group_name: binary,
    description: binary,
  ]

  @type create_cache_security_group_result :: [
    cache_security_group: cache_security_group,
  ]

  @type create_cache_subnet_group_message :: [
    cache_subnet_group_description: binary,
    cache_subnet_group_name: binary,
    subnet_ids: subnet_identifier_list,
  ]

  @type create_cache_subnet_group_result :: [
    cache_subnet_group: cache_subnet_group,
  ]

  @type create_replication_group_message :: [
    auto_minor_version_upgrade: boolean_optional,
    automatic_failover_enabled: boolean_optional,
    cache_node_type: binary,
    cache_parameter_group_name: binary,
    cache_security_group_names: cache_security_group_name_list,
    cache_subnet_group_name: binary,
    engine: binary,
    engine_version: binary,
    notification_topic_arn: binary,
    num_cache_clusters: integer_optional,
    port: integer_optional,
    preferred_cache_cluster_a_zs: availability_zones_list,
    preferred_maintenance_window: binary,
    primary_cluster_id: binary,
    replication_group_description: binary,
    replication_group_id: binary,
    security_group_ids: security_group_ids_list,
    snapshot_arns: snapshot_arns_list,
    snapshot_name: binary,
    snapshot_retention_limit: integer_optional,
    snapshot_window: binary,
    tags: tag_list,
  ]

  @type create_replication_group_result :: [
    replication_group: replication_group,
  ]

  @type create_snapshot_message :: [
    cache_cluster_id: binary,
    snapshot_name: binary,
  ]

  @type create_snapshot_result :: [
    snapshot: snapshot,
  ]

  @type delete_cache_cluster_message :: [
    cache_cluster_id: binary,
    final_snapshot_identifier: binary,
  ]

  @type delete_cache_cluster_result :: [
    cache_cluster: cache_cluster,
  ]

  @type delete_cache_parameter_group_message :: [
    cache_parameter_group_name: binary,
  ]

  @type delete_cache_security_group_message :: [
    cache_security_group_name: binary,
  ]

  @type delete_cache_subnet_group_message :: [
    cache_subnet_group_name: binary,
  ]

  @type delete_replication_group_message :: [
    final_snapshot_identifier: binary,
    replication_group_id: binary,
    retain_primary_cluster: boolean_optional,
  ]

  @type delete_replication_group_result :: [
    replication_group: replication_group,
  ]

  @type delete_snapshot_message :: [
    snapshot_name: binary,
  ]

  @type delete_snapshot_result :: [
    snapshot: snapshot,
  ]

  @type describe_cache_clusters_message :: [
    cache_cluster_id: binary,
    marker: binary,
    max_records: integer_optional,
    show_cache_node_info: boolean_optional,
  ]

  @type describe_cache_engine_versions_message :: [
    cache_parameter_group_family: binary,
    default_only: boolean,
    engine: binary,
    engine_version: binary,
    marker: binary,
    max_records: integer_optional,
  ]

  @type describe_cache_parameter_groups_message :: [
    cache_parameter_group_name: binary,
    marker: binary,
    max_records: integer_optional,
  ]

  @type describe_cache_parameters_message :: [
    cache_parameter_group_name: binary,
    marker: binary,
    max_records: integer_optional,
    source: binary,
  ]

  @type describe_cache_security_groups_message :: [
    cache_security_group_name: binary,
    marker: binary,
    max_records: integer_optional,
  ]

  @type describe_cache_subnet_groups_message :: [
    cache_subnet_group_name: binary,
    marker: binary,
    max_records: integer_optional,
  ]

  @type describe_engine_default_parameters_message :: [
    cache_parameter_group_family: binary,
    marker: binary,
    max_records: integer_optional,
  ]

  @type describe_engine_default_parameters_result :: [
    engine_defaults: engine_defaults,
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

  @type describe_replication_groups_message :: [
    marker: binary,
    max_records: integer_optional,
    replication_group_id: binary,
  ]

  @type describe_reserved_cache_nodes_message :: [
    cache_node_type: binary,
    duration: binary,
    marker: binary,
    max_records: integer_optional,
    offering_type: binary,
    product_description: binary,
    reserved_cache_node_id: binary,
    reserved_cache_nodes_offering_id: binary,
  ]

  @type describe_reserved_cache_nodes_offerings_message :: [
    cache_node_type: binary,
    duration: binary,
    marker: binary,
    max_records: integer_optional,
    offering_type: binary,
    product_description: binary,
    reserved_cache_nodes_offering_id: binary,
  ]

  @type describe_snapshots_list_message :: [
    marker: binary,
    snapshots: snapshot_list,
  ]

  @type describe_snapshots_message :: [
    cache_cluster_id: binary,
    marker: binary,
    max_records: integer_optional,
    snapshot_name: binary,
    snapshot_source: binary,
  ]

  @type double :: float

  @type ec2_security_group :: [
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
    cache_node_type_specific_parameters: cache_node_type_specific_parameters_list,
    cache_parameter_group_family: binary,
    marker: binary,
    parameters: parameters_list,
  ]

  @type event :: [
    date: t_stamp,
    message: binary,
    source_identifier: binary,
    source_type: source_type,
  ]

  @type event_list :: [event]

  @type events_message :: [
    events: event_list,
    marker: binary,
  ]

  @type insufficient_cache_cluster_capacity_fault :: [
  ]

  @type integer_optional :: integer

  @type invalid_arn_fault :: [
  ]

  @type invalid_cache_cluster_state_fault :: [
  ]

  @type invalid_cache_parameter_group_state_fault :: [
  ]

  @type invalid_cache_security_group_state_fault :: [
  ]

  @type invalid_parameter_combination_exception :: [
    message: aws_query_error_message,
  ]

  @type invalid_parameter_value_exception :: [
    message: aws_query_error_message,
  ]

  @type invalid_replication_group_state_fault :: [
  ]

  @type invalid_snapshot_state_fault :: [
  ]

  @type invalid_subnet :: [
  ]

  @type invalid_vpc_network_state_fault :: [
  ]

  @type key_list :: [binary]

  @type list_tags_for_resource_message :: [
    resource_name: binary,
  ]

  @type modify_cache_cluster_message :: [
    az_mode: az_mode,
    apply_immediately: boolean,
    auto_minor_version_upgrade: boolean_optional,
    cache_cluster_id: binary,
    cache_node_ids_to_remove: cache_node_ids_list,
    cache_parameter_group_name: binary,
    cache_security_group_names: cache_security_group_name_list,
    engine_version: binary,
    new_availability_zones: preferred_availability_zone_list,
    notification_topic_arn: binary,
    notification_topic_status: binary,
    num_cache_nodes: integer_optional,
    preferred_maintenance_window: binary,
    security_group_ids: security_group_ids_list,
    snapshot_retention_limit: integer_optional,
    snapshot_window: binary,
  ]

  @type modify_cache_cluster_result :: [
    cache_cluster: cache_cluster,
  ]

  @type modify_cache_parameter_group_message :: [
    cache_parameter_group_name: binary,
    parameter_name_values: parameter_name_value_list,
  ]

  @type modify_cache_subnet_group_message :: [
    cache_subnet_group_description: binary,
    cache_subnet_group_name: binary,
    subnet_ids: subnet_identifier_list,
  ]

  @type modify_cache_subnet_group_result :: [
    cache_subnet_group: cache_subnet_group,
  ]

  @type modify_replication_group_message :: [
    apply_immediately: boolean,
    auto_minor_version_upgrade: boolean_optional,
    automatic_failover_enabled: boolean_optional,
    cache_parameter_group_name: binary,
    cache_security_group_names: cache_security_group_name_list,
    engine_version: binary,
    notification_topic_arn: binary,
    notification_topic_status: binary,
    preferred_maintenance_window: binary,
    primary_cluster_id: binary,
    replication_group_description: binary,
    replication_group_id: binary,
    security_group_ids: security_group_ids_list,
    snapshot_retention_limit: integer_optional,
    snapshot_window: binary,
    snapshotting_cluster_id: binary,
  ]

  @type modify_replication_group_result :: [
    replication_group: replication_group,
  ]

  @type node_group :: [
    node_group_id: binary,
    node_group_members: node_group_member_list,
    primary_endpoint: endpoint,
    status: binary,
  ]

  @type node_group_list :: [node_group]

  @type node_group_member :: [
    cache_cluster_id: binary,
    cache_node_id: binary,
    current_role: binary,
    preferred_availability_zone: binary,
    read_endpoint: endpoint,
  ]

  @type node_group_member_list :: [node_group_member]

  @type node_quota_for_cluster_exceeded_fault :: [
  ]

  @type node_quota_for_customer_exceeded_fault :: [
  ]

  @type node_snapshot :: [
    cache_node_create_time: t_stamp,
    cache_node_id: binary,
    cache_size: binary,
    snapshot_create_time: t_stamp,
  ]

  @type node_snapshot_list :: [node_snapshot]

  @type notification_configuration :: [
    topic_arn: binary,
    topic_status: binary,
  ]

  @type parameter :: [
    allowed_values: binary,
    data_type: binary,
    description: binary,
    is_modifiable: boolean,
    minimum_engine_version: binary,
    parameter_name: binary,
    parameter_value: binary,
    source: binary,
  ]

  @type parameter_name_value :: [
    parameter_name: binary,
    parameter_value: binary,
  ]

  @type parameter_name_value_list :: [parameter_name_value]

  @type parameters_list :: [parameter]

  @type pending_automatic_failover_status :: binary

  @type pending_modified_values :: [
    cache_node_ids_to_remove: cache_node_ids_list,
    engine_version: binary,
    num_cache_nodes: integer_optional,
  ]

  @type preferred_availability_zone_list :: [binary]

  @type purchase_reserved_cache_nodes_offering_message :: [
    cache_node_count: integer_optional,
    reserved_cache_node_id: binary,
    reserved_cache_nodes_offering_id: binary,
  ]

  @type purchase_reserved_cache_nodes_offering_result :: [
    reserved_cache_node: reserved_cache_node,
  ]

  @type reboot_cache_cluster_message :: [
    cache_cluster_id: binary,
    cache_node_ids_to_reboot: cache_node_ids_list,
  ]

  @type reboot_cache_cluster_result :: [
    cache_cluster: cache_cluster,
  ]

  @type recurring_charge :: [
    recurring_charge_amount: double,
    recurring_charge_frequency: binary,
  ]

  @type recurring_charge_list :: [recurring_charge]

  @type remove_tags_from_resource_message :: [
    resource_name: binary,
    tag_keys: key_list,
  ]

  @type replication_group :: [
    automatic_failover: automatic_failover_status,
    description: binary,
    member_clusters: cluster_id_list,
    node_groups: node_group_list,
    pending_modified_values: replication_group_pending_modified_values,
    replication_group_id: binary,
    snapshotting_cluster_id: binary,
    status: binary,
  ]

  @type replication_group_already_exists_fault :: [
  ]

  @type replication_group_list :: [replication_group]

  @type replication_group_message :: [
    marker: binary,
    replication_groups: replication_group_list,
  ]

  @type replication_group_not_found_fault :: [
  ]

  @type replication_group_pending_modified_values :: [
    automatic_failover_status: pending_automatic_failover_status,
    primary_cluster_id: binary,
  ]

  @type reserved_cache_node :: [
    cache_node_count: integer,
    cache_node_type: binary,
    duration: integer,
    fixed_price: double,
    offering_type: binary,
    product_description: binary,
    recurring_charges: recurring_charge_list,
    reserved_cache_node_id: binary,
    reserved_cache_nodes_offering_id: binary,
    start_time: t_stamp,
    state: binary,
    usage_price: double,
  ]

  @type reserved_cache_node_already_exists_fault :: [
  ]

  @type reserved_cache_node_list :: [reserved_cache_node]

  @type reserved_cache_node_message :: [
    marker: binary,
    reserved_cache_nodes: reserved_cache_node_list,
  ]

  @type reserved_cache_node_not_found_fault :: [
  ]

  @type reserved_cache_node_quota_exceeded_fault :: [
  ]

  @type reserved_cache_nodes_offering :: [
    cache_node_type: binary,
    duration: integer,
    fixed_price: double,
    offering_type: binary,
    product_description: binary,
    recurring_charges: recurring_charge_list,
    reserved_cache_nodes_offering_id: binary,
    usage_price: double,
  ]

  @type reserved_cache_nodes_offering_list :: [reserved_cache_nodes_offering]

  @type reserved_cache_nodes_offering_message :: [
    marker: binary,
    reserved_cache_nodes_offerings: reserved_cache_nodes_offering_list,
  ]

  @type reserved_cache_nodes_offering_not_found_fault :: [
  ]

  @type reset_cache_parameter_group_message :: [
    cache_parameter_group_name: binary,
    parameter_name_values: parameter_name_value_list,
    reset_all_parameters: boolean,
  ]

  @type revoke_cache_security_group_ingress_message :: [
    cache_security_group_name: binary,
    e_c2_security_group_name: binary,
    e_c2_security_group_owner_id: binary,
  ]

  @type revoke_cache_security_group_ingress_result :: [
    cache_security_group: cache_security_group,
  ]

  @type security_group_ids_list :: [binary]

  @type security_group_membership :: [
    security_group_id: binary,
    status: binary,
  ]

  @type security_group_membership_list :: [security_group_membership]

  @type snapshot :: [
    auto_minor_version_upgrade: boolean,
    cache_cluster_create_time: t_stamp,
    cache_cluster_id: binary,
    cache_node_type: binary,
    cache_parameter_group_name: binary,
    cache_subnet_group_name: binary,
    engine: binary,
    engine_version: binary,
    node_snapshots: node_snapshot_list,
    num_cache_nodes: integer_optional,
    port: integer_optional,
    preferred_availability_zone: binary,
    preferred_maintenance_window: binary,
    snapshot_name: binary,
    snapshot_retention_limit: integer_optional,
    snapshot_source: binary,
    snapshot_status: binary,
    snapshot_window: binary,
    topic_arn: binary,
    vpc_id: binary,
  ]

  @type snapshot_already_exists_fault :: [
  ]

  @type snapshot_arns_list :: [binary]

  @type snapshot_feature_not_supported_fault :: [
  ]

  @type snapshot_list :: [snapshot]

  @type snapshot_not_found_fault :: [
  ]

  @type snapshot_quota_exceeded_fault :: [
  ]

  @type source_type :: binary

  @type subnet :: [
    subnet_availability_zone: availability_zone,
    subnet_identifier: binary,
  ]

  @type subnet_identifier_list :: [binary]

  @type subnet_in_use :: [
  ]

  @type subnet_list :: [subnet]

  @type t_stamp :: integer

  @type tag :: [
    key: binary,
    value: binary,
  ]

  @type tag_list :: [tag]

  @type tag_list_message :: [
    tag_list: tag_list,
  ]

  @type tag_not_found_fault :: [
  ]

  @type tag_quota_per_resource_exceeded :: [
  ]




  @doc """
  AddTagsToResource

  The *AddTagsToResource* action adds up to 10 cost allocation tags to the
  named resource. A *cost allocation tag* is a key-value pair where the key
  and value are case-sensitive. Cost allocation tags can be used to
  categorize and track your AWS costs.

  When you apply tags to your ElastiCache resources, AWS generates a cost
  allocation report as a comma-separated value (CSV) file with your usage and
  costs aggregated by your tags. You can apply tags that represent business
  categories (such as cost centers, application names, or owners) to organize
  your costs across multiple services. For more information, see [Using Cost
  Allocation Tags in Amazon
  ElastiCache](http://docs.aws.amazon.com/AmazonElastiCache/latest/UserGuide/Tagging.html).
  """

  @spec add_tags_to_resource(client :: ExAws.ElastiCache.t, input :: add_tags_to_resource_message) :: ExAws.Request.Query.response_t
  def add_tags_to_resource(client, input) do
    request(client, "/", "AddTagsToResource", input)
  end

  @doc """
  Same as `add_tags_to_resource/2` but raise on error.
  """
  @spec add_tags_to_resource!(client :: ExAws.ElastiCache.t, input :: add_tags_to_resource_message) :: ExAws.Request.Query.success_t | no_return
  def add_tags_to_resource!(client, input) do
    case add_tags_to_resource(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  AuthorizeCacheSecurityGroupIngress

  The *AuthorizeCacheSecurityGroupIngress* action allows network ingress to a
  cache security group. Applications using ElastiCache must be running on
  Amazon EC2, and Amazon EC2 security groups are used as the authorization
  mechanism.

  Note:You cannot authorize ingress from an Amazon EC2 security group in one
  region to an ElastiCache cluster in another region.
  """

  @spec authorize_cache_security_group_ingress(client :: ExAws.ElastiCache.t, input :: authorize_cache_security_group_ingress_message) :: ExAws.Request.Query.response_t
  def authorize_cache_security_group_ingress(client, input) do
    request(client, "/", "AuthorizeCacheSecurityGroupIngress", input)
  end

  @doc """
  Same as `authorize_cache_security_group_ingress/2` but raise on error.
  """
  @spec authorize_cache_security_group_ingress!(client :: ExAws.ElastiCache.t, input :: authorize_cache_security_group_ingress_message) :: ExAws.Request.Query.success_t | no_return
  def authorize_cache_security_group_ingress!(client, input) do
    case authorize_cache_security_group_ingress(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CopySnapshot

  The *CopySnapshot* action makes a copy of an existing snapshot.
  """

  @spec copy_snapshot(client :: ExAws.ElastiCache.t, input :: copy_snapshot_message) :: ExAws.Request.Query.response_t
  def copy_snapshot(client, input) do
    request(client, "/", "CopySnapshot", input)
  end

  @doc """
  Same as `copy_snapshot/2` but raise on error.
  """
  @spec copy_snapshot!(client :: ExAws.ElastiCache.t, input :: copy_snapshot_message) :: ExAws.Request.Query.success_t | no_return
  def copy_snapshot!(client, input) do
    case copy_snapshot(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateCacheCluster

  The *CreateCacheCluster* action creates a cache cluster. All nodes in the
  cache cluster run the same protocol-compliant cache engine software, either
  Memcached or Redis.
  """

  @spec create_cache_cluster(client :: ExAws.ElastiCache.t, input :: create_cache_cluster_message) :: ExAws.Request.Query.response_t
  def create_cache_cluster(client, input) do
    request(client, "/", "CreateCacheCluster", input)
  end

  @doc """
  Same as `create_cache_cluster/2` but raise on error.
  """
  @spec create_cache_cluster!(client :: ExAws.ElastiCache.t, input :: create_cache_cluster_message) :: ExAws.Request.Query.success_t | no_return
  def create_cache_cluster!(client, input) do
    case create_cache_cluster(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateCacheParameterGroup

  The *CreateCacheParameterGroup* action creates a new cache parameter group.
  A cache parameter group is a collection of parameters that you apply to all
  of the nodes in a cache cluster.
  """

  @spec create_cache_parameter_group(client :: ExAws.ElastiCache.t, input :: create_cache_parameter_group_message) :: ExAws.Request.Query.response_t
  def create_cache_parameter_group(client, input) do
    request(client, "/", "CreateCacheParameterGroup", input)
  end

  @doc """
  Same as `create_cache_parameter_group/2` but raise on error.
  """
  @spec create_cache_parameter_group!(client :: ExAws.ElastiCache.t, input :: create_cache_parameter_group_message) :: ExAws.Request.Query.success_t | no_return
  def create_cache_parameter_group!(client, input) do
    case create_cache_parameter_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateCacheSecurityGroup

  The *CreateCacheSecurityGroup* action creates a new cache security group.
  Use a cache security group to control access to one or more cache clusters.

  Cache security groups are only used when you are creating a cache cluster
  outside of an Amazon Virtual Private Cloud (VPC). If you are creating a
  cache cluster inside of a VPC, use a cache subnet group instead. For more
  information, see
  [CreateCacheSubnetGroup](http://docs.aws.amazon.com/AmazonElastiCache/latest/APIReference/API_CreateCacheSubnetGroup.html).
  """

  @spec create_cache_security_group(client :: ExAws.ElastiCache.t, input :: create_cache_security_group_message) :: ExAws.Request.Query.response_t
  def create_cache_security_group(client, input) do
    request(client, "/", "CreateCacheSecurityGroup", input)
  end

  @doc """
  Same as `create_cache_security_group/2` but raise on error.
  """
  @spec create_cache_security_group!(client :: ExAws.ElastiCache.t, input :: create_cache_security_group_message) :: ExAws.Request.Query.success_t | no_return
  def create_cache_security_group!(client, input) do
    case create_cache_security_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateCacheSubnetGroup

  The *CreateCacheSubnetGroup* action creates a new cache subnet group.

  Use this parameter only when you are creating a cluster in an Amazon
  Virtual Private Cloud (VPC).
  """

  @spec create_cache_subnet_group(client :: ExAws.ElastiCache.t, input :: create_cache_subnet_group_message) :: ExAws.Request.Query.response_t
  def create_cache_subnet_group(client, input) do
    request(client, "/", "CreateCacheSubnetGroup", input)
  end

  @doc """
  Same as `create_cache_subnet_group/2` but raise on error.
  """
  @spec create_cache_subnet_group!(client :: ExAws.ElastiCache.t, input :: create_cache_subnet_group_message) :: ExAws.Request.Query.success_t | no_return
  def create_cache_subnet_group!(client, input) do
    case create_cache_subnet_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateReplicationGroup

  The *CreateReplicationGroup* action creates a replication group. A
  replication group is a collection of cache clusters, where one of the cache
  clusters is a read/write primary and the others are read-only replicas.
  Writes to the primary are automatically propagated to the replicas.

  When you create a replication group, you must specify an existing cache
  cluster that is in the primary role. When the replication group has been
  successfully created, you can add one or more read replica replicas to it,
  up to a total of five read replicas.

  **Note:** This action is valid only for Redis.
  """

  @spec create_replication_group(client :: ExAws.ElastiCache.t, input :: create_replication_group_message) :: ExAws.Request.Query.response_t
  def create_replication_group(client, input) do
    request(client, "/", "CreateReplicationGroup", input)
  end

  @doc """
  Same as `create_replication_group/2` but raise on error.
  """
  @spec create_replication_group!(client :: ExAws.ElastiCache.t, input :: create_replication_group_message) :: ExAws.Request.Query.success_t | no_return
  def create_replication_group!(client, input) do
    case create_replication_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateSnapshot

  The *CreateSnapshot* action creates a copy of an entire cache cluster at a
  specific moment in time.
  """

  @spec create_snapshot(client :: ExAws.ElastiCache.t, input :: create_snapshot_message) :: ExAws.Request.Query.response_t
  def create_snapshot(client, input) do
    request(client, "/", "CreateSnapshot", input)
  end

  @doc """
  Same as `create_snapshot/2` but raise on error.
  """
  @spec create_snapshot!(client :: ExAws.ElastiCache.t, input :: create_snapshot_message) :: ExAws.Request.Query.success_t | no_return
  def create_snapshot!(client, input) do
    case create_snapshot(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteCacheCluster

  The *DeleteCacheCluster* action deletes a previously provisioned cache
  cluster. *DeleteCacheCluster* deletes all associated cache nodes, node
  endpoints and the cache cluster itself. When you receive a successful
  response from this action, Amazon ElastiCache immediately begins deleting
  the cache cluster; you cannot cancel or revert this action.

  This API cannot be used to delete a cache cluster that is the last read
  replica of a replication group that has Multi-AZ mode enabled.
  """

  @spec delete_cache_cluster(client :: ExAws.ElastiCache.t, input :: delete_cache_cluster_message) :: ExAws.Request.Query.response_t
  def delete_cache_cluster(client, input) do
    request(client, "/", "DeleteCacheCluster", input)
  end

  @doc """
  Same as `delete_cache_cluster/2` but raise on error.
  """
  @spec delete_cache_cluster!(client :: ExAws.ElastiCache.t, input :: delete_cache_cluster_message) :: ExAws.Request.Query.success_t | no_return
  def delete_cache_cluster!(client, input) do
    case delete_cache_cluster(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteCacheParameterGroup

  The *DeleteCacheParameterGroup* action deletes the specified cache
  parameter group. You cannot delete a cache parameter group if it is
  associated with any cache clusters.
  """

  @spec delete_cache_parameter_group(client :: ExAws.ElastiCache.t, input :: delete_cache_parameter_group_message) :: ExAws.Request.Query.response_t
  def delete_cache_parameter_group(client, input) do
    request(client, "/", "DeleteCacheParameterGroup", input)
  end

  @doc """
  Same as `delete_cache_parameter_group/2` but raise on error.
  """
  @spec delete_cache_parameter_group!(client :: ExAws.ElastiCache.t, input :: delete_cache_parameter_group_message) :: ExAws.Request.Query.success_t | no_return
  def delete_cache_parameter_group!(client, input) do
    case delete_cache_parameter_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteCacheSecurityGroup

  The *DeleteCacheSecurityGroup* action deletes a cache security group.

  Note:You cannot delete a cache security group if it is associated with any
  cache clusters.
  """

  @spec delete_cache_security_group(client :: ExAws.ElastiCache.t, input :: delete_cache_security_group_message) :: ExAws.Request.Query.response_t
  def delete_cache_security_group(client, input) do
    request(client, "/", "DeleteCacheSecurityGroup", input)
  end

  @doc """
  Same as `delete_cache_security_group/2` but raise on error.
  """
  @spec delete_cache_security_group!(client :: ExAws.ElastiCache.t, input :: delete_cache_security_group_message) :: ExAws.Request.Query.success_t | no_return
  def delete_cache_security_group!(client, input) do
    case delete_cache_security_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteCacheSubnetGroup

  The *DeleteCacheSubnetGroup* action deletes a cache subnet group.

  Note:You cannot delete a cache subnet group if it is associated with any
  cache clusters.
  """

  @spec delete_cache_subnet_group(client :: ExAws.ElastiCache.t, input :: delete_cache_subnet_group_message) :: ExAws.Request.Query.response_t
  def delete_cache_subnet_group(client, input) do
    request(client, "/", "DeleteCacheSubnetGroup", input)
  end

  @doc """
  Same as `delete_cache_subnet_group/2` but raise on error.
  """
  @spec delete_cache_subnet_group!(client :: ExAws.ElastiCache.t, input :: delete_cache_subnet_group_message) :: ExAws.Request.Query.success_t | no_return
  def delete_cache_subnet_group!(client, input) do
    case delete_cache_subnet_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteReplicationGroup

  The *DeleteReplicationGroup* action deletes an existing replication group.
  By default, this action deletes the entire replication group, including the
  primary cluster and all of the read replicas. You can optionally delete
  only the read replicas, while retaining the primary cluster.

  When you receive a successful response from this action, Amazon ElastiCache
  immediately begins deleting the selected resources; you cannot cancel or
  revert this action.
  """

  @spec delete_replication_group(client :: ExAws.ElastiCache.t, input :: delete_replication_group_message) :: ExAws.Request.Query.response_t
  def delete_replication_group(client, input) do
    request(client, "/", "DeleteReplicationGroup", input)
  end

  @doc """
  Same as `delete_replication_group/2` but raise on error.
  """
  @spec delete_replication_group!(client :: ExAws.ElastiCache.t, input :: delete_replication_group_message) :: ExAws.Request.Query.success_t | no_return
  def delete_replication_group!(client, input) do
    case delete_replication_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteSnapshot

  The *DeleteSnapshot* action deletes an existing snapshot. When you receive
  a successful response from this action, ElastiCache immediately begins
  deleting the snapshot; you cannot cancel or revert this action.
  """

  @spec delete_snapshot(client :: ExAws.ElastiCache.t, input :: delete_snapshot_message) :: ExAws.Request.Query.response_t
  def delete_snapshot(client, input) do
    request(client, "/", "DeleteSnapshot", input)
  end

  @doc """
  Same as `delete_snapshot/2` but raise on error.
  """
  @spec delete_snapshot!(client :: ExAws.ElastiCache.t, input :: delete_snapshot_message) :: ExAws.Request.Query.success_t | no_return
  def delete_snapshot!(client, input) do
    case delete_snapshot(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeCacheClusters

  The *DescribeCacheClusters* action returns information about all
  provisioned cache clusters if no cache cluster identifier is specified, or
  about a specific cache cluster if a cache cluster identifier is supplied.

  By default, abbreviated information about the cache clusters(s) will be
  returned. You can use the optional *ShowDetails* flag to retrieve detailed
  information about the cache nodes associated with the cache clusters. These
  details include the DNS address and port for the cache node endpoint.

  If the cluster is in the CREATING state, only cluster level information
  will be displayed until all of the nodes are successfully provisioned.

  If the cluster is in the DELETING state, only cluster level information
  will be displayed.

  If cache nodes are currently being added to the cache cluster, node
  endpoint information and creation time for the additional nodes will not be
  displayed until they are completely provisioned. When the cache cluster
  state is *available*, the cluster is ready for use.

  If cache nodes are currently being removed from the cache cluster, no
  endpoint information for the removed nodes is displayed.
  """

  @spec describe_cache_clusters(client :: ExAws.ElastiCache.t, input :: describe_cache_clusters_message) :: ExAws.Request.Query.response_t
  def describe_cache_clusters(client, input) do
    request(client, "/", "DescribeCacheClusters", input)
  end

  @doc """
  Same as `describe_cache_clusters/2` but raise on error.
  """
  @spec describe_cache_clusters!(client :: ExAws.ElastiCache.t, input :: describe_cache_clusters_message) :: ExAws.Request.Query.success_t | no_return
  def describe_cache_clusters!(client, input) do
    case describe_cache_clusters(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeCacheEngineVersions

  The *DescribeCacheEngineVersions* action returns a list of the available
  cache engines and their versions.
  """

  @spec describe_cache_engine_versions(client :: ExAws.ElastiCache.t, input :: describe_cache_engine_versions_message) :: ExAws.Request.Query.response_t
  def describe_cache_engine_versions(client, input) do
    request(client, "/", "DescribeCacheEngineVersions", input)
  end

  @doc """
  Same as `describe_cache_engine_versions/2` but raise on error.
  """
  @spec describe_cache_engine_versions!(client :: ExAws.ElastiCache.t, input :: describe_cache_engine_versions_message) :: ExAws.Request.Query.success_t | no_return
  def describe_cache_engine_versions!(client, input) do
    case describe_cache_engine_versions(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeCacheParameterGroups

  The *DescribeCacheParameterGroups* action returns a list of cache parameter
  group descriptions. If a cache parameter group name is specified, the list
  will contain only the descriptions for that group.
  """

  @spec describe_cache_parameter_groups(client :: ExAws.ElastiCache.t, input :: describe_cache_parameter_groups_message) :: ExAws.Request.Query.response_t
  def describe_cache_parameter_groups(client, input) do
    request(client, "/", "DescribeCacheParameterGroups", input)
  end

  @doc """
  Same as `describe_cache_parameter_groups/2` but raise on error.
  """
  @spec describe_cache_parameter_groups!(client :: ExAws.ElastiCache.t, input :: describe_cache_parameter_groups_message) :: ExAws.Request.Query.success_t | no_return
  def describe_cache_parameter_groups!(client, input) do
    case describe_cache_parameter_groups(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeCacheParameters

  The *DescribeCacheParameters* action returns the detailed parameter list
  for a particular cache parameter group.
  """

  @spec describe_cache_parameters(client :: ExAws.ElastiCache.t, input :: describe_cache_parameters_message) :: ExAws.Request.Query.response_t
  def describe_cache_parameters(client, input) do
    request(client, "/", "DescribeCacheParameters", input)
  end

  @doc """
  Same as `describe_cache_parameters/2` but raise on error.
  """
  @spec describe_cache_parameters!(client :: ExAws.ElastiCache.t, input :: describe_cache_parameters_message) :: ExAws.Request.Query.success_t | no_return
  def describe_cache_parameters!(client, input) do
    case describe_cache_parameters(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeCacheSecurityGroups

  The *DescribeCacheSecurityGroups* action returns a list of cache security
  group descriptions. If a cache security group name is specified, the list
  will contain only the description of that group.
  """

  @spec describe_cache_security_groups(client :: ExAws.ElastiCache.t, input :: describe_cache_security_groups_message) :: ExAws.Request.Query.response_t
  def describe_cache_security_groups(client, input) do
    request(client, "/", "DescribeCacheSecurityGroups", input)
  end

  @doc """
  Same as `describe_cache_security_groups/2` but raise on error.
  """
  @spec describe_cache_security_groups!(client :: ExAws.ElastiCache.t, input :: describe_cache_security_groups_message) :: ExAws.Request.Query.success_t | no_return
  def describe_cache_security_groups!(client, input) do
    case describe_cache_security_groups(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeCacheSubnetGroups

  The *DescribeCacheSubnetGroups* action returns a list of cache subnet group
  descriptions. If a subnet group name is specified, the list will contain
  only the description of that group.
  """

  @spec describe_cache_subnet_groups(client :: ExAws.ElastiCache.t, input :: describe_cache_subnet_groups_message) :: ExAws.Request.Query.response_t
  def describe_cache_subnet_groups(client, input) do
    request(client, "/", "DescribeCacheSubnetGroups", input)
  end

  @doc """
  Same as `describe_cache_subnet_groups/2` but raise on error.
  """
  @spec describe_cache_subnet_groups!(client :: ExAws.ElastiCache.t, input :: describe_cache_subnet_groups_message) :: ExAws.Request.Query.success_t | no_return
  def describe_cache_subnet_groups!(client, input) do
    case describe_cache_subnet_groups(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeEngineDefaultParameters

  The *DescribeEngineDefaultParameters* action returns the default engine and
  system parameter information for the specified cache engine.
  """

  @spec describe_engine_default_parameters(client :: ExAws.ElastiCache.t, input :: describe_engine_default_parameters_message) :: ExAws.Request.Query.response_t
  def describe_engine_default_parameters(client, input) do
    request(client, "/", "DescribeEngineDefaultParameters", input)
  end

  @doc """
  Same as `describe_engine_default_parameters/2` but raise on error.
  """
  @spec describe_engine_default_parameters!(client :: ExAws.ElastiCache.t, input :: describe_engine_default_parameters_message) :: ExAws.Request.Query.success_t | no_return
  def describe_engine_default_parameters!(client, input) do
    case describe_engine_default_parameters(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeEvents

  The *DescribeEvents* action returns events related to cache clusters, cache
  security groups, and cache parameter groups. You can obtain events specific
  to a particular cache cluster, cache security group, or cache parameter
  group by providing the name as a parameter.

  By default, only the events occurring within the last hour are returned;
  however, you can retrieve up to 14 days' worth of events if necessary.
  """

  @spec describe_events(client :: ExAws.ElastiCache.t, input :: describe_events_message) :: ExAws.Request.Query.response_t
  def describe_events(client, input) do
    request(client, "/", "DescribeEvents", input)
  end

  @doc """
  Same as `describe_events/2` but raise on error.
  """
  @spec describe_events!(client :: ExAws.ElastiCache.t, input :: describe_events_message) :: ExAws.Request.Query.success_t | no_return
  def describe_events!(client, input) do
    case describe_events(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeReplicationGroups

  The *DescribeReplicationGroups* action returns information about a
  particular replication group. If no identifier is specified,
  *DescribeReplicationGroups* returns information about all replication
  groups.
  """

  @spec describe_replication_groups(client :: ExAws.ElastiCache.t, input :: describe_replication_groups_message) :: ExAws.Request.Query.response_t
  def describe_replication_groups(client, input) do
    request(client, "/", "DescribeReplicationGroups", input)
  end

  @doc """
  Same as `describe_replication_groups/2` but raise on error.
  """
  @spec describe_replication_groups!(client :: ExAws.ElastiCache.t, input :: describe_replication_groups_message) :: ExAws.Request.Query.success_t | no_return
  def describe_replication_groups!(client, input) do
    case describe_replication_groups(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeReservedCacheNodes

  The *DescribeReservedCacheNodes* action returns information about reserved
  cache nodes for this account, or about a specified reserved cache node.
  """

  @spec describe_reserved_cache_nodes(client :: ExAws.ElastiCache.t, input :: describe_reserved_cache_nodes_message) :: ExAws.Request.Query.response_t
  def describe_reserved_cache_nodes(client, input) do
    request(client, "/", "DescribeReservedCacheNodes", input)
  end

  @doc """
  Same as `describe_reserved_cache_nodes/2` but raise on error.
  """
  @spec describe_reserved_cache_nodes!(client :: ExAws.ElastiCache.t, input :: describe_reserved_cache_nodes_message) :: ExAws.Request.Query.success_t | no_return
  def describe_reserved_cache_nodes!(client, input) do
    case describe_reserved_cache_nodes(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeReservedCacheNodesOfferings

  The *DescribeReservedCacheNodesOfferings* action lists available reserved
  cache node offerings.
  """

  @spec describe_reserved_cache_nodes_offerings(client :: ExAws.ElastiCache.t, input :: describe_reserved_cache_nodes_offerings_message) :: ExAws.Request.Query.response_t
  def describe_reserved_cache_nodes_offerings(client, input) do
    request(client, "/", "DescribeReservedCacheNodesOfferings", input)
  end

  @doc """
  Same as `describe_reserved_cache_nodes_offerings/2` but raise on error.
  """
  @spec describe_reserved_cache_nodes_offerings!(client :: ExAws.ElastiCache.t, input :: describe_reserved_cache_nodes_offerings_message) :: ExAws.Request.Query.success_t | no_return
  def describe_reserved_cache_nodes_offerings!(client, input) do
    case describe_reserved_cache_nodes_offerings(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeSnapshots

  The *DescribeSnapshots* action returns information about cache cluster
  snapshots. By default, *DescribeSnapshots* lists all of your snapshots; it
  can optionally describe a single snapshot, or just the snapshots associated
  with a particular cache cluster.
  """

  @spec describe_snapshots(client :: ExAws.ElastiCache.t, input :: describe_snapshots_message) :: ExAws.Request.Query.response_t
  def describe_snapshots(client, input) do
    request(client, "/", "DescribeSnapshots", input)
  end

  @doc """
  Same as `describe_snapshots/2` but raise on error.
  """
  @spec describe_snapshots!(client :: ExAws.ElastiCache.t, input :: describe_snapshots_message) :: ExAws.Request.Query.success_t | no_return
  def describe_snapshots!(client, input) do
    case describe_snapshots(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ListTagsForResource

  The *ListTagsForResource* action lists all cost allocation tags currently
  on the named resource. A *cost allocation tag* is a key-value pair where
  the key is case-sensitive and the value is optional. Cost allocation tags
  can be used to categorize and track your AWS costs.

  You can have a maximum of 10 cost allocation tags on an ElastiCache
  resource. For more information, see [Using Cost Allocation Tags in Amazon
  ElastiCache](http://docs.aws.amazon.com/AmazonElastiCache/latest/UserGuide/BestPractices.html).
  """

  @spec list_tags_for_resource(client :: ExAws.ElastiCache.t, input :: list_tags_for_resource_message) :: ExAws.Request.Query.response_t
  def list_tags_for_resource(client, input) do
    request(client, "/", "ListTagsForResource", input)
  end

  @doc """
  Same as `list_tags_for_resource/2` but raise on error.
  """
  @spec list_tags_for_resource!(client :: ExAws.ElastiCache.t, input :: list_tags_for_resource_message) :: ExAws.Request.Query.success_t | no_return
  def list_tags_for_resource!(client, input) do
    case list_tags_for_resource(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ModifyCacheCluster

  The *ModifyCacheCluster* action modifies the settings for a cache cluster.
  You can use this action to change one or more cluster configuration
  parameters by specifying the parameters and the new values.
  """

  @spec modify_cache_cluster(client :: ExAws.ElastiCache.t, input :: modify_cache_cluster_message) :: ExAws.Request.Query.response_t
  def modify_cache_cluster(client, input) do
    request(client, "/", "ModifyCacheCluster", input)
  end

  @doc """
  Same as `modify_cache_cluster/2` but raise on error.
  """
  @spec modify_cache_cluster!(client :: ExAws.ElastiCache.t, input :: modify_cache_cluster_message) :: ExAws.Request.Query.success_t | no_return
  def modify_cache_cluster!(client, input) do
    case modify_cache_cluster(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ModifyCacheParameterGroup

  The *ModifyCacheParameterGroup* action modifies the parameters of a cache
  parameter group. You can modify up to 20 parameters in a single request by
  submitting a list parameter name and value pairs.
  """

  @spec modify_cache_parameter_group(client :: ExAws.ElastiCache.t, input :: modify_cache_parameter_group_message) :: ExAws.Request.Query.response_t
  def modify_cache_parameter_group(client, input) do
    request(client, "/", "ModifyCacheParameterGroup", input)
  end

  @doc """
  Same as `modify_cache_parameter_group/2` but raise on error.
  """
  @spec modify_cache_parameter_group!(client :: ExAws.ElastiCache.t, input :: modify_cache_parameter_group_message) :: ExAws.Request.Query.success_t | no_return
  def modify_cache_parameter_group!(client, input) do
    case modify_cache_parameter_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ModifyCacheSubnetGroup

  The *ModifyCacheSubnetGroup* action modifies an existing cache subnet
  group.
  """

  @spec modify_cache_subnet_group(client :: ExAws.ElastiCache.t, input :: modify_cache_subnet_group_message) :: ExAws.Request.Query.response_t
  def modify_cache_subnet_group(client, input) do
    request(client, "/", "ModifyCacheSubnetGroup", input)
  end

  @doc """
  Same as `modify_cache_subnet_group/2` but raise on error.
  """
  @spec modify_cache_subnet_group!(client :: ExAws.ElastiCache.t, input :: modify_cache_subnet_group_message) :: ExAws.Request.Query.success_t | no_return
  def modify_cache_subnet_group!(client, input) do
    case modify_cache_subnet_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ModifyReplicationGroup

  The *ModifyReplicationGroup* action modifies the settings for a replication
  group.
  """

  @spec modify_replication_group(client :: ExAws.ElastiCache.t, input :: modify_replication_group_message) :: ExAws.Request.Query.response_t
  def modify_replication_group(client, input) do
    request(client, "/", "ModifyReplicationGroup", input)
  end

  @doc """
  Same as `modify_replication_group/2` but raise on error.
  """
  @spec modify_replication_group!(client :: ExAws.ElastiCache.t, input :: modify_replication_group_message) :: ExAws.Request.Query.success_t | no_return
  def modify_replication_group!(client, input) do
    case modify_replication_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  PurchaseReservedCacheNodesOffering

  The *PurchaseReservedCacheNodesOffering* action allows you to purchase a
  reserved cache node offering.
  """

  @spec purchase_reserved_cache_nodes_offering(client :: ExAws.ElastiCache.t, input :: purchase_reserved_cache_nodes_offering_message) :: ExAws.Request.Query.response_t
  def purchase_reserved_cache_nodes_offering(client, input) do
    request(client, "/", "PurchaseReservedCacheNodesOffering", input)
  end

  @doc """
  Same as `purchase_reserved_cache_nodes_offering/2` but raise on error.
  """
  @spec purchase_reserved_cache_nodes_offering!(client :: ExAws.ElastiCache.t, input :: purchase_reserved_cache_nodes_offering_message) :: ExAws.Request.Query.success_t | no_return
  def purchase_reserved_cache_nodes_offering!(client, input) do
    case purchase_reserved_cache_nodes_offering(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RebootCacheCluster

  The *RebootCacheCluster* action reboots some, or all, of the cache nodes
  within a provisioned cache cluster. This API will apply any modified cache
  parameter groups to the cache cluster. The reboot action takes place as
  soon as possible, and results in a momentary outage to the cache cluster.
  During the reboot, the cache cluster status is set to REBOOTING.

  The reboot causes the contents of the cache (for each cache node being
  rebooted) to be lost.

  When the reboot is complete, a cache cluster event is created.
  """

  @spec reboot_cache_cluster(client :: ExAws.ElastiCache.t, input :: reboot_cache_cluster_message) :: ExAws.Request.Query.response_t
  def reboot_cache_cluster(client, input) do
    request(client, "/", "RebootCacheCluster", input)
  end

  @doc """
  Same as `reboot_cache_cluster/2` but raise on error.
  """
  @spec reboot_cache_cluster!(client :: ExAws.ElastiCache.t, input :: reboot_cache_cluster_message) :: ExAws.Request.Query.success_t | no_return
  def reboot_cache_cluster!(client, input) do
    case reboot_cache_cluster(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RemoveTagsFromResource

  The *RemoveTagsFromResource* action removes the tags identified by the
  `TagKeys` list from the named resource.
  """

  @spec remove_tags_from_resource(client :: ExAws.ElastiCache.t, input :: remove_tags_from_resource_message) :: ExAws.Request.Query.response_t
  def remove_tags_from_resource(client, input) do
    request(client, "/", "RemoveTagsFromResource", input)
  end

  @doc """
  Same as `remove_tags_from_resource/2` but raise on error.
  """
  @spec remove_tags_from_resource!(client :: ExAws.ElastiCache.t, input :: remove_tags_from_resource_message) :: ExAws.Request.Query.success_t | no_return
  def remove_tags_from_resource!(client, input) do
    case remove_tags_from_resource(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ResetCacheParameterGroup

  The *ResetCacheParameterGroup* action modifies the parameters of a cache
  parameter group to the engine or system default value. You can reset
  specific parameters by submitting a list of parameter names. To reset the
  entire cache parameter group, specify the *ResetAllParameters* and
  *CacheParameterGroupName* parameters.
  """

  @spec reset_cache_parameter_group(client :: ExAws.ElastiCache.t, input :: reset_cache_parameter_group_message) :: ExAws.Request.Query.response_t
  def reset_cache_parameter_group(client, input) do
    request(client, "/", "ResetCacheParameterGroup", input)
  end

  @doc """
  Same as `reset_cache_parameter_group/2` but raise on error.
  """
  @spec reset_cache_parameter_group!(client :: ExAws.ElastiCache.t, input :: reset_cache_parameter_group_message) :: ExAws.Request.Query.success_t | no_return
  def reset_cache_parameter_group!(client, input) do
    case reset_cache_parameter_group(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RevokeCacheSecurityGroupIngress

  The *RevokeCacheSecurityGroupIngress* action revokes ingress from a cache
  security group. Use this action to disallow access from an Amazon EC2
  security group that had been previously authorized.
  """

  @spec revoke_cache_security_group_ingress(client :: ExAws.ElastiCache.t, input :: revoke_cache_security_group_ingress_message) :: ExAws.Request.Query.response_t
  def revoke_cache_security_group_ingress(client, input) do
    request(client, "/", "RevokeCacheSecurityGroupIngress", input)
  end

  @doc """
  Same as `revoke_cache_security_group_ingress/2` but raise on error.
  """
  @spec revoke_cache_security_group_ingress!(client :: ExAws.ElastiCache.t, input :: revoke_cache_security_group_ingress_message) :: ExAws.Request.Query.success_t | no_return
  def revoke_cache_security_group_ingress!(client, input) do
    case revoke_cache_security_group_ingress(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  defp request(%{__struct__: client_module} = client, uri, action, input) do
    apply(client_module, :request, [client, uri, action, input])
  end
end
