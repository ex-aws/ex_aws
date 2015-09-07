defmodule ExAws.ElasticLoadBalancing.Core do
  @actions [
    "AddTags",
    "ApplySecurityGroupsToLoadBalancer",
    "AttachLoadBalancerToSubnets",
    "ConfigureHealthCheck",
    "CreateAppCookieStickinessPolicy",
    "CreateLBCookieStickinessPolicy",
    "CreateLoadBalancer",
    "CreateLoadBalancerListeners",
    "CreateLoadBalancerPolicy",
    "DeleteLoadBalancer",
    "DeleteLoadBalancerListeners",
    "DeleteLoadBalancerPolicy",
    "DeregisterInstancesFromLoadBalancer",
    "DescribeInstanceHealth",
    "DescribeLoadBalancerAttributes",
    "DescribeLoadBalancerPolicies",
    "DescribeLoadBalancerPolicyTypes",
    "DescribeLoadBalancers",
    "DescribeTags",
    "DetachLoadBalancerFromSubnets",
    "DisableAvailabilityZonesForLoadBalancer",
    "EnableAvailabilityZonesForLoadBalancer",
    "ModifyLoadBalancerAttributes",
    "RegisterInstancesWithLoadBalancer",
    "RemoveTags",
    "SetLoadBalancerListenerSSLCertificate",
    "SetLoadBalancerPoliciesForBackendServer",
    "SetLoadBalancerPoliciesOfListener"]

  @moduledoc """
  ## Elastic Load Balancing

  Elastic Load Balancing

  Elastic Load Balancing distributes incoming traffic across your EC2
  instances.

  For information about the features of Elastic Load Balancing, see [What Is
  Elastic Load
  Balancing?](http://docs.aws.amazon.com/ElasticLoadBalancing/latest/DeveloperGuide/elastic-load-balancing.html)
  in the *Elastic Load Balancing Developer Guide*.

  For information about the AWS regions supported by Elastic Load Balancing,
  see [Regions and Endpoints - Elastic Load
  Balancing](http://docs.aws.amazon.com/general/latest/gr/rande.html#elb_region)
  in the *Amazon Web Services General Reference*.

  All Elastic Load Balancing operations are *idempotent*, which means that
  they complete at most one time. If you repeat an operation, it succeeds
  with a 200 OK response code.
  """

  @type access_log :: [
    emit_interval: access_log_interval,
    enabled: access_log_enabled,
    s3_bucket_name: s3_bucket_name,
    s3_bucket_prefix: access_log_prefix,
  ]

  @type access_log_enabled :: boolean

  @type access_log_interval :: integer

  @type access_log_prefix :: binary

  @type access_point_name :: binary

  @type access_point_not_found_exception :: [
  ]

  @type access_point_port :: integer

  @type add_availability_zones_input :: [
    availability_zones: availability_zones,
    load_balancer_name: access_point_name,
  ]

  @type add_availability_zones_output :: [
    availability_zones: availability_zones,
  ]

  @type add_tags_input :: [
    load_balancer_names: load_balancer_names,
    tags: tag_list,
  ]

  @type add_tags_output :: [
  ]

  @type additional_attribute :: [
    key: string_val,
    value: string_val,
  ]

  @type additional_attributes :: [additional_attribute]

  @type app_cookie_stickiness_policies :: [app_cookie_stickiness_policy]

  @type app_cookie_stickiness_policy :: [
    cookie_name: cookie_name,
    policy_name: policy_name,
  ]

  @type apply_security_groups_to_load_balancer_input :: [
    load_balancer_name: access_point_name,
    security_groups: security_groups,
  ]

  @type apply_security_groups_to_load_balancer_output :: [
    security_groups: security_groups,
  ]

  @type attach_load_balancer_to_subnets_input :: [
    load_balancer_name: access_point_name,
    subnets: subnets,
  ]

  @type attach_load_balancer_to_subnets_output :: [
    subnets: subnets,
  ]

  @type attribute_name :: binary

  @type attribute_type :: binary

  @type attribute_value :: binary

  @type availability_zone :: binary

  @type availability_zones :: [availability_zone]

  @type backend_server_description :: [
    instance_port: instance_port,
    policy_names: policy_names,
  ]

  @type backend_server_descriptions :: [backend_server_description]

  @type cardinality :: binary

  @type certificate_not_found_exception :: [
  ]

  @type configure_health_check_input :: [
    health_check: health_check,
    load_balancer_name: access_point_name,
  ]

  @type configure_health_check_output :: [
    health_check: health_check,
  ]

  @type connection_draining :: [
    enabled: connection_draining_enabled,
    timeout: connection_draining_timeout,
  ]

  @type connection_draining_enabled :: boolean

  @type connection_draining_timeout :: integer

  @type connection_settings :: [
    idle_timeout: idle_timeout,
  ]

  @type cookie_expiration_period :: integer

  @type cookie_name :: binary

  @type create_access_point_input :: [
    availability_zones: availability_zones,
    listeners: listeners,
    load_balancer_name: access_point_name,
    scheme: load_balancer_scheme,
    security_groups: security_groups,
    subnets: subnets,
    tags: tag_list,
  ]

  @type create_access_point_output :: [
    dns_name: dns_name,
  ]

  @type create_app_cookie_stickiness_policy_input :: [
    cookie_name: cookie_name,
    load_balancer_name: access_point_name,
    policy_name: policy_name,
  ]

  @type create_app_cookie_stickiness_policy_output :: [
  ]

  @type create_lb_cookie_stickiness_policy_input :: [
    cookie_expiration_period: cookie_expiration_period,
    load_balancer_name: access_point_name,
    policy_name: policy_name,
  ]

  @type create_lb_cookie_stickiness_policy_output :: [
  ]

  @type create_load_balancer_listener_input :: [
    listeners: listeners,
    load_balancer_name: access_point_name,
  ]

  @type create_load_balancer_listener_output :: [
  ]

  @type create_load_balancer_policy_input :: [
    load_balancer_name: access_point_name,
    policy_attributes: policy_attributes,
    policy_name: policy_name,
    policy_type_name: policy_type_name,
  ]

  @type create_load_balancer_policy_output :: [
  ]

  @type created_time :: integer

  @type cross_zone_load_balancing :: [
    enabled: cross_zone_load_balancing_enabled,
  ]

  @type cross_zone_load_balancing_enabled :: boolean

  @type dns_name :: binary

  @type default_value :: binary

  @type delete_access_point_input :: [
    load_balancer_name: access_point_name,
  ]

  @type delete_access_point_output :: [
  ]

  @type delete_load_balancer_listener_input :: [
    load_balancer_name: access_point_name,
    load_balancer_ports: ports,
  ]

  @type delete_load_balancer_listener_output :: [
  ]

  @type delete_load_balancer_policy_input :: [
    load_balancer_name: access_point_name,
    policy_name: policy_name,
  ]

  @type delete_load_balancer_policy_output :: [
  ]

  @type deregister_end_points_input :: [
    instances: instances,
    load_balancer_name: access_point_name,
  ]

  @type deregister_end_points_output :: [
    instances: instances,
  ]

  @type describe_access_points_input :: [
    load_balancer_names: load_balancer_names,
    marker: marker,
    page_size: page_size,
  ]

  @type describe_access_points_output :: [
    load_balancer_descriptions: load_balancer_descriptions,
    next_marker: marker,
  ]

  @type describe_end_point_state_input :: [
    instances: instances,
    load_balancer_name: access_point_name,
  ]

  @type describe_end_point_state_output :: [
    instance_states: instance_states,
  ]

  @type describe_load_balancer_attributes_input :: [
    load_balancer_name: access_point_name,
  ]

  @type describe_load_balancer_attributes_output :: [
    load_balancer_attributes: load_balancer_attributes,
  ]

  @type describe_load_balancer_policies_input :: [
    load_balancer_name: access_point_name,
    policy_names: policy_names,
  ]

  @type describe_load_balancer_policies_output :: [
    policy_descriptions: policy_descriptions,
  ]

  @type describe_load_balancer_policy_types_input :: [
    policy_type_names: policy_type_names,
  ]

  @type describe_load_balancer_policy_types_output :: [
    policy_type_descriptions: policy_type_descriptions,
  ]

  @type describe_tags_input :: [
    load_balancer_names: load_balancer_names_max20,
  ]

  @type describe_tags_output :: [
    tag_descriptions: tag_descriptions,
  ]

  @type description :: binary

  @type detach_load_balancer_from_subnets_input :: [
    load_balancer_name: access_point_name,
    subnets: subnets,
  ]

  @type detach_load_balancer_from_subnets_output :: [
    subnets: subnets,
  ]

  @type duplicate_access_point_name_exception :: [
  ]

  @type duplicate_listener_exception :: [
  ]

  @type duplicate_policy_name_exception :: [
  ]

  @type duplicate_tag_keys_exception :: [
  ]

  @type end_point_port :: integer

  @type health_check :: [
    healthy_threshold: healthy_threshold,
    interval: health_check_interval,
    target: health_check_target,
    timeout: health_check_timeout,
    unhealthy_threshold: unhealthy_threshold,
  ]

  @type health_check_interval :: integer

  @type health_check_target :: binary

  @type health_check_timeout :: integer

  @type healthy_threshold :: integer

  @type idle_timeout :: integer

  @type instance :: [
    instance_id: instance_id,
  ]

  @type instance_id :: binary

  @type instance_port :: integer

  @type instance_state :: [
    description: description,
    instance_id: instance_id,
    reason_code: reason_code,
    state: state,
  ]

  @type instance_states :: [instance_state]

  @type instances :: [instance]

  @type invalid_configuration_request_exception :: [
  ]

  @type invalid_end_point_exception :: [
  ]

  @type invalid_scheme_exception :: [
  ]

  @type invalid_security_group_exception :: [
  ]

  @type invalid_subnet_exception :: [
  ]

  @type lb_cookie_stickiness_policies :: [lb_cookie_stickiness_policy]

  @type lb_cookie_stickiness_policy :: [
    cookie_expiration_period: cookie_expiration_period,
    policy_name: policy_name,
  ]

  @type listener :: [
    instance_port: instance_port,
    instance_protocol: protocol,
    load_balancer_port: access_point_port,
    protocol: protocol,
    ssl_certificate_id: ssl_certificate_id,
  ]

  @type listener_description :: [
    listener: listener,
    policy_names: policy_names,
  ]

  @type listener_descriptions :: [listener_description]

  @type listener_not_found_exception :: [
  ]

  @type listeners :: [listener]

  @type load_balancer_attribute_not_found_exception :: [
  ]

  @type load_balancer_attributes :: [
    access_log: access_log,
    additional_attributes: additional_attributes,
    connection_draining: connection_draining,
    connection_settings: connection_settings,
    cross_zone_load_balancing: cross_zone_load_balancing,
  ]

  @type load_balancer_description :: [
    availability_zones: availability_zones,
    backend_server_descriptions: backend_server_descriptions,
    canonical_hosted_zone_name: dns_name,
    canonical_hosted_zone_name_id: dns_name,
    created_time: created_time,
    dns_name: dns_name,
    health_check: health_check,
    instances: instances,
    listener_descriptions: listener_descriptions,
    load_balancer_name: access_point_name,
    policies: policies,
    scheme: load_balancer_scheme,
    security_groups: security_groups,
    source_security_group: source_security_group,
    subnets: subnets,
    vpc_id: vpc_id,
  ]

  @type load_balancer_descriptions :: [load_balancer_description]

  @type load_balancer_names :: [access_point_name]

  @type load_balancer_names_max20 :: [access_point_name]

  @type load_balancer_scheme :: binary

  @type marker :: binary

  @type modify_load_balancer_attributes_input :: [
    load_balancer_attributes: load_balancer_attributes,
    load_balancer_name: access_point_name,
  ]

  @type modify_load_balancer_attributes_output :: [
    load_balancer_attributes: load_balancer_attributes,
    load_balancer_name: access_point_name,
  ]

  @type page_size :: integer

  @type policies :: [
    app_cookie_stickiness_policies: app_cookie_stickiness_policies,
    lb_cookie_stickiness_policies: lb_cookie_stickiness_policies,
    other_policies: policy_names,
  ]

  @type policy_attribute :: [
    attribute_name: attribute_name,
    attribute_value: attribute_value,
  ]

  @type policy_attribute_description :: [
    attribute_name: attribute_name,
    attribute_value: attribute_value,
  ]

  @type policy_attribute_descriptions :: [policy_attribute_description]

  @type policy_attribute_type_description :: [
    attribute_name: attribute_name,
    attribute_type: attribute_type,
    cardinality: cardinality,
    default_value: default_value,
    description: description,
  ]

  @type policy_attribute_type_descriptions :: [policy_attribute_type_description]

  @type policy_attributes :: [policy_attribute]

  @type policy_description :: [
    policy_attribute_descriptions: policy_attribute_descriptions,
    policy_name: policy_name,
    policy_type_name: policy_type_name,
  ]

  @type policy_descriptions :: [policy_description]

  @type policy_name :: binary

  @type policy_names :: [policy_name]

  @type policy_not_found_exception :: [
  ]

  @type policy_type_description :: [
    description: description,
    policy_attribute_type_descriptions: policy_attribute_type_descriptions,
    policy_type_name: policy_type_name,
  ]

  @type policy_type_descriptions :: [policy_type_description]

  @type policy_type_name :: binary

  @type policy_type_names :: [policy_type_name]

  @type policy_type_not_found_exception :: [
  ]

  @type ports :: [access_point_port]

  @type protocol :: binary

  @type reason_code :: binary

  @type register_end_points_input :: [
    instances: instances,
    load_balancer_name: access_point_name,
  ]

  @type register_end_points_output :: [
    instances: instances,
  ]

  @type remove_availability_zones_input :: [
    availability_zones: availability_zones,
    load_balancer_name: access_point_name,
  ]

  @type remove_availability_zones_output :: [
    availability_zones: availability_zones,
  ]

  @type remove_tags_input :: [
    load_balancer_names: load_balancer_names,
    tags: tag_key_list,
  ]

  @type remove_tags_output :: [
  ]

  @type s3_bucket_name :: binary

  @type ssl_certificate_id :: binary

  @type security_group_id :: binary

  @type security_group_name :: binary

  @type security_group_owner_alias :: binary

  @type security_groups :: [security_group_id]

  @type set_load_balancer_listener_ssl_certificate_input :: [
    load_balancer_name: access_point_name,
    load_balancer_port: access_point_port,
    ssl_certificate_id: ssl_certificate_id,
  ]

  @type set_load_balancer_listener_ssl_certificate_output :: [
  ]

  @type set_load_balancer_policies_for_backend_server_input :: [
    instance_port: end_point_port,
    load_balancer_name: access_point_name,
    policy_names: policy_names,
  ]

  @type set_load_balancer_policies_for_backend_server_output :: [
  ]

  @type set_load_balancer_policies_of_listener_input :: [
    load_balancer_name: access_point_name,
    load_balancer_port: access_point_port,
    policy_names: policy_names,
  ]

  @type set_load_balancer_policies_of_listener_output :: [
  ]

  @type source_security_group :: [
    group_name: security_group_name,
    owner_alias: security_group_owner_alias,
  ]

  @type state :: binary

  @type string_val :: binary

  @type subnet_id :: binary

  @type subnet_not_found_exception :: [
  ]

  @type subnets :: [subnet_id]

  @type tag :: [
    key: tag_key,
    value: tag_value,
  ]

  @type tag_description :: [
    load_balancer_name: access_point_name,
    tags: tag_list,
  ]

  @type tag_descriptions :: [tag_description]

  @type tag_key :: binary

  @type tag_key_list :: [tag_key_only]

  @type tag_key_only :: [
    key: tag_key,
  ]

  @type tag_list :: [tag]

  @type tag_value :: binary

  @type too_many_access_points_exception :: [
  ]

  @type too_many_policies_exception :: [
  ]

  @type too_many_tags_exception :: [
  ]

  @type unhealthy_threshold :: integer

  @type vpc_id :: binary




  @doc """
  AddTags

  Adds the specified tags to the specified load balancer. Each load balancer
  can have a maximum of 10 tags.

  Each tag consists of a key and an optional value. If a tag with the same
  key is already associated with the load balancer, `AddTags` updates its
  value.

  For more information, see [Tag Your Load
  Balancer](http://docs.aws.amazon.com/ElasticLoadBalancing/latest/DeveloperGuide/add-remove-tags.html)
  in the *Elastic Load Balancing Developer Guide*.
  """

  @spec add_tags(client :: ExAws.ElasticLoadBalancing.t, input :: add_tags_input) :: ExAws.Request.Query.response_t
  def add_tags(client, input) do
    request(client, "/", "AddTags", input)
  end

  @doc """
  Same as `add_tags/2` but raise on error.
  """
  @spec add_tags!(client :: ExAws.ElasticLoadBalancing.t, input :: add_tags_input) :: ExAws.Request.Query.success_t | no_return
  def add_tags!(client, input) do
    case add_tags(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ApplySecurityGroupsToLoadBalancer

  Associates one or more security groups with your load balancer in a virtual
  private cloud (VPC). The specified security groups override the previously
  associated security groups.

  For more information, see [Security Groups for Load Balancers in a
  VPC](http://docs.aws.amazon.com/ElasticLoadBalancing/latest/DeveloperGuide/elb-security-groups.html#elb-vpc-security-groups)
  in the *Elastic Load Balancing Developer Guide*.
  """

  @spec apply_security_groups_to_load_balancer(client :: ExAws.ElasticLoadBalancing.t, input :: apply_security_groups_to_load_balancer_input) :: ExAws.Request.Query.response_t
  def apply_security_groups_to_load_balancer(client, input) do
    request(client, "/", "ApplySecurityGroupsToLoadBalancer", input)
  end

  @doc """
  Same as `apply_security_groups_to_load_balancer/2` but raise on error.
  """
  @spec apply_security_groups_to_load_balancer!(client :: ExAws.ElasticLoadBalancing.t, input :: apply_security_groups_to_load_balancer_input) :: ExAws.Request.Query.success_t | no_return
  def apply_security_groups_to_load_balancer!(client, input) do
    case apply_security_groups_to_load_balancer(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  AttachLoadBalancerToSubnets

  Adds one or more subnets to the set of configured subnets for the specified
  load balancer.

  The load balancer evenly distributes requests across all registered
  subnets. For more information, see [Add or Remove Subnets for Your Load
  Balancer in a
  VPC](http://docs.aws.amazon.com/ElasticLoadBalancing/latest/DeveloperGuide/elb-manage-subnets.html)
  in the *Elastic Load Balancing Developer Guide*.
  """

  @spec attach_load_balancer_to_subnets(client :: ExAws.ElasticLoadBalancing.t, input :: attach_load_balancer_to_subnets_input) :: ExAws.Request.Query.response_t
  def attach_load_balancer_to_subnets(client, input) do
    request(client, "/", "AttachLoadBalancerToSubnets", input)
  end

  @doc """
  Same as `attach_load_balancer_to_subnets/2` but raise on error.
  """
  @spec attach_load_balancer_to_subnets!(client :: ExAws.ElasticLoadBalancing.t, input :: attach_load_balancer_to_subnets_input) :: ExAws.Request.Query.success_t | no_return
  def attach_load_balancer_to_subnets!(client, input) do
    case attach_load_balancer_to_subnets(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ConfigureHealthCheck

  Specifies the health check settings to use when evaluating the health state
  of your back-end instances.

  For more information, see [Configure Health
  Checks](http://docs.aws.amazon.com/ElasticLoadBalancing/latest/DeveloperGuide/elb-healthchecks.html)
  in the *Elastic Load Balancing Developer Guide*.
  """

  @spec configure_health_check(client :: ExAws.ElasticLoadBalancing.t, input :: configure_health_check_input) :: ExAws.Request.Query.response_t
  def configure_health_check(client, input) do
    request(client, "/", "ConfigureHealthCheck", input)
  end

  @doc """
  Same as `configure_health_check/2` but raise on error.
  """
  @spec configure_health_check!(client :: ExAws.ElasticLoadBalancing.t, input :: configure_health_check_input) :: ExAws.Request.Query.success_t | no_return
  def configure_health_check!(client, input) do
    case configure_health_check(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateAppCookieStickinessPolicy

  Generates a stickiness policy with sticky session lifetimes that follow
  that of an application-generated cookie. This policy can be associated only
  with HTTP/HTTPS listeners.

  This policy is similar to the policy created by
  `CreateLBCookieStickinessPolicy`, except that the lifetime of the special
  Elastic Load Balancing cookie, `AWSELB`, follows the lifetime of the
  application-generated cookie specified in the policy configuration. The
  load balancer only inserts a new stickiness cookie when the application
  response includes a new application cookie.

  If the application cookie is explicitly removed or expires, the session
  stops being sticky until a new application cookie is issued.

  For more information, see [Application-Controlled Session
  Stickiness](http://docs.aws.amazon.com/ElasticLoadBalancing/latest/DeveloperGuide/elb-sticky-sessions.html#enable-sticky-sessions-application)
  in the *Elastic Load Balancing Developer Guide*.
  """

  @spec create_app_cookie_stickiness_policy(client :: ExAws.ElasticLoadBalancing.t, input :: create_app_cookie_stickiness_policy_input) :: ExAws.Request.Query.response_t
  def create_app_cookie_stickiness_policy(client, input) do
    request(client, "/", "CreateAppCookieStickinessPolicy", input)
  end

  @doc """
  Same as `create_app_cookie_stickiness_policy/2` but raise on error.
  """
  @spec create_app_cookie_stickiness_policy!(client :: ExAws.ElasticLoadBalancing.t, input :: create_app_cookie_stickiness_policy_input) :: ExAws.Request.Query.success_t | no_return
  def create_app_cookie_stickiness_policy!(client, input) do
    case create_app_cookie_stickiness_policy(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateLBCookieStickinessPolicy

  Generates a stickiness policy with sticky session lifetimes controlled by
  the lifetime of the browser (user-agent) or a specified expiration period.
  This policy can be associated only with HTTP/HTTPS listeners.

  When a load balancer implements this policy, the load balancer uses a
  special cookie to track the back-end server instance for each request. When
  the load balancer receives a request, it first checks to see if this cookie
  is present in the request. If so, the load balancer sends the request to
  the application server specified in the cookie. If not, the load balancer
  sends the request to a server that is chosen based on the existing
  load-balancing algorithm.

  A cookie is inserted into the response for binding subsequent requests from
  the same user to that server. The validity of the cookie is based on the
  cookie expiration time, which is specified in the policy configuration.

  For more information, see [Duration-Based Session
  Stickiness](http://docs.aws.amazon.com/ElasticLoadBalancing/latest/DeveloperGuide/elb-sticky-sessions.html#enable-sticky-sessions-duration)
  in the *Elastic Load Balancing Developer Guide*.
  """

  @spec create_lb_cookie_stickiness_policy(client :: ExAws.ElasticLoadBalancing.t, input :: create_lb_cookie_stickiness_policy_input) :: ExAws.Request.Query.response_t
  def create_lb_cookie_stickiness_policy(client, input) do
    request(client, "/", "CreateLBCookieStickinessPolicy", input)
  end

  @doc """
  Same as `create_lb_cookie_stickiness_policy/2` but raise on error.
  """
  @spec create_lb_cookie_stickiness_policy!(client :: ExAws.ElasticLoadBalancing.t, input :: create_lb_cookie_stickiness_policy_input) :: ExAws.Request.Query.success_t | no_return
  def create_lb_cookie_stickiness_policy!(client, input) do
    case create_lb_cookie_stickiness_policy(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateLoadBalancer

  Creates a load balancer.

  If the call completes successfully, a new load balancer is created with a
  unique Domain Name Service (DNS) name. The load balancer receives incoming
  traffic and routes it to the registered instances. For more information,
  see [How Elastic Load Balancing
  Works](http://docs.aws.amazon.com/ElasticLoadBalancing/latest/DeveloperGuide/how-elb-works.html)
  in the *Elastic Load Balancing Developer Guide*.

  You can create up to 20 load balancers per region per account. You can
  request an increase for the number of load balancers for your account. For
  more information, see [Elastic Load Balancing
  Limits](http://docs.aws.amazon.com/ElasticLoadBalancing/latest/DeveloperGuide/elb-limits.html)
  in the *Elastic Load Balancing Developer Guide*.
  """

  @spec create_load_balancer(client :: ExAws.ElasticLoadBalancing.t, input :: create_access_point_input) :: ExAws.Request.Query.response_t
  def create_load_balancer(client, input) do
    request(client, "/", "CreateLoadBalancer", input)
  end

  @doc """
  Same as `create_load_balancer/2` but raise on error.
  """
  @spec create_load_balancer!(client :: ExAws.ElasticLoadBalancing.t, input :: create_access_point_input) :: ExAws.Request.Query.success_t | no_return
  def create_load_balancer!(client, input) do
    case create_load_balancer(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateLoadBalancerListeners

  Creates one or more listeners for the specified load balancer. If a
  listener with the specified port does not already exist, it is created;
  otherwise, the properties of the new listener must match the properties of
  the existing listener.

  For more information, see [Add a Listener to Your Load
  Balancer](http://docs.aws.amazon.com/ElasticLoadBalancing/latest/DeveloperGuide/us-add-listener.html)
  in the *Elastic Load Balancing Developer Guide*.
  """

  @spec create_load_balancer_listeners(client :: ExAws.ElasticLoadBalancing.t, input :: create_load_balancer_listener_input) :: ExAws.Request.Query.response_t
  def create_load_balancer_listeners(client, input) do
    request(client, "/", "CreateLoadBalancerListeners", input)
  end

  @doc """
  Same as `create_load_balancer_listeners/2` but raise on error.
  """
  @spec create_load_balancer_listeners!(client :: ExAws.ElasticLoadBalancing.t, input :: create_load_balancer_listener_input) :: ExAws.Request.Query.success_t | no_return
  def create_load_balancer_listeners!(client, input) do
    case create_load_balancer_listeners(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  CreateLoadBalancerPolicy

  Creates a policy with the specified attributes for the specified load
  balancer.

  Policies are settings that are saved for your load balancer and that can be
  applied to the front-end listener or the back-end application server,
  depending on the policy type.
  """

  @spec create_load_balancer_policy(client :: ExAws.ElasticLoadBalancing.t, input :: create_load_balancer_policy_input) :: ExAws.Request.Query.response_t
  def create_load_balancer_policy(client, input) do
    request(client, "/", "CreateLoadBalancerPolicy", input)
  end

  @doc """
  Same as `create_load_balancer_policy/2` but raise on error.
  """
  @spec create_load_balancer_policy!(client :: ExAws.ElasticLoadBalancing.t, input :: create_load_balancer_policy_input) :: ExAws.Request.Query.success_t | no_return
  def create_load_balancer_policy!(client, input) do
    case create_load_balancer_policy(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteLoadBalancer

  Deletes the specified load balancer.

  If you are attempting to recreate a load balancer, you must reconfigure all
  settings. The DNS name associated with a deleted load balancer are no
  longer usable. The name and associated DNS record of the deleted load
  balancer no longer exist and traffic sent to any of its IP addresses is no
  longer delivered to back-end instances.

  If the load balancer does not exist or has already been deleted, the call
  to `DeleteLoadBalancer` still succeeds.
  """

  @spec delete_load_balancer(client :: ExAws.ElasticLoadBalancing.t, input :: delete_access_point_input) :: ExAws.Request.Query.response_t
  def delete_load_balancer(client, input) do
    request(client, "/", "DeleteLoadBalancer", input)
  end

  @doc """
  Same as `delete_load_balancer/2` but raise on error.
  """
  @spec delete_load_balancer!(client :: ExAws.ElasticLoadBalancing.t, input :: delete_access_point_input) :: ExAws.Request.Query.success_t | no_return
  def delete_load_balancer!(client, input) do
    case delete_load_balancer(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteLoadBalancerListeners

  Deletes the specified listeners from the specified load balancer.
  """

  @spec delete_load_balancer_listeners(client :: ExAws.ElasticLoadBalancing.t, input :: delete_load_balancer_listener_input) :: ExAws.Request.Query.response_t
  def delete_load_balancer_listeners(client, input) do
    request(client, "/", "DeleteLoadBalancerListeners", input)
  end

  @doc """
  Same as `delete_load_balancer_listeners/2` but raise on error.
  """
  @spec delete_load_balancer_listeners!(client :: ExAws.ElasticLoadBalancing.t, input :: delete_load_balancer_listener_input) :: ExAws.Request.Query.success_t | no_return
  def delete_load_balancer_listeners!(client, input) do
    case delete_load_balancer_listeners(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeleteLoadBalancerPolicy

  Deletes the specified policy from the specified load balancer. This policy
  must not be enabled for any listeners.
  """

  @spec delete_load_balancer_policy(client :: ExAws.ElasticLoadBalancing.t, input :: delete_load_balancer_policy_input) :: ExAws.Request.Query.response_t
  def delete_load_balancer_policy(client, input) do
    request(client, "/", "DeleteLoadBalancerPolicy", input)
  end

  @doc """
  Same as `delete_load_balancer_policy/2` but raise on error.
  """
  @spec delete_load_balancer_policy!(client :: ExAws.ElasticLoadBalancing.t, input :: delete_load_balancer_policy_input) :: ExAws.Request.Query.success_t | no_return
  def delete_load_balancer_policy!(client, input) do
    case delete_load_balancer_policy(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DeregisterInstancesFromLoadBalancer

  Deregisters the specified instances from the specified load balancer. After
  the instance is deregistered, it no longer receives traffic from the load
  balancer.

  You can use `DescribeLoadBalancers` to verify that the instance is
  deregistered from the load balancer.

  For more information, see [Deregister and Register Amazon EC2
  Instances](http://docs.aws.amazon.com/ElasticLoadBalancing/latest/DeveloperGuide/US_DeReg_Reg_Instances.html)
  in the *Elastic Load Balancing Developer Guide*.
  """

  @spec deregister_instances_from_load_balancer(client :: ExAws.ElasticLoadBalancing.t, input :: deregister_end_points_input) :: ExAws.Request.Query.response_t
  def deregister_instances_from_load_balancer(client, input) do
    request(client, "/", "DeregisterInstancesFromLoadBalancer", input)
  end

  @doc """
  Same as `deregister_instances_from_load_balancer/2` but raise on error.
  """
  @spec deregister_instances_from_load_balancer!(client :: ExAws.ElasticLoadBalancing.t, input :: deregister_end_points_input) :: ExAws.Request.Query.success_t | no_return
  def deregister_instances_from_load_balancer!(client, input) do
    case deregister_instances_from_load_balancer(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeInstanceHealth

  Describes the state of the specified instances registered with the
  specified load balancer. If no instances are specified, the call describes
  the state of all instances registered with the load balancer, not including
  any terminated instances.
  """

  @spec describe_instance_health(client :: ExAws.ElasticLoadBalancing.t, input :: describe_end_point_state_input) :: ExAws.Request.Query.response_t
  def describe_instance_health(client, input) do
    request(client, "/", "DescribeInstanceHealth", input)
  end

  @doc """
  Same as `describe_instance_health/2` but raise on error.
  """
  @spec describe_instance_health!(client :: ExAws.ElasticLoadBalancing.t, input :: describe_end_point_state_input) :: ExAws.Request.Query.success_t | no_return
  def describe_instance_health!(client, input) do
    case describe_instance_health(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeLoadBalancerAttributes

  Describes the attributes for the specified load balancer.
  """

  @spec describe_load_balancer_attributes(client :: ExAws.ElasticLoadBalancing.t, input :: describe_load_balancer_attributes_input) :: ExAws.Request.Query.response_t
  def describe_load_balancer_attributes(client, input) do
    request(client, "/", "DescribeLoadBalancerAttributes", input)
  end

  @doc """
  Same as `describe_load_balancer_attributes/2` but raise on error.
  """
  @spec describe_load_balancer_attributes!(client :: ExAws.ElasticLoadBalancing.t, input :: describe_load_balancer_attributes_input) :: ExAws.Request.Query.success_t | no_return
  def describe_load_balancer_attributes!(client, input) do
    case describe_load_balancer_attributes(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeLoadBalancerPolicies

  Describes the specified policies.

  If you specify a load balancer name, the action returns the descriptions of
  all policies created for the load balancer. If you specify a policy name
  associated with your load balancer, the action returns the description of
  that policy. If you don't specify a load balancer name, the action returns
  descriptions of the specified sample policies, or descriptions of all
  sample policies. The names of the sample policies have the `ELBSample-`
  prefix.
  """

  @spec describe_load_balancer_policies(client :: ExAws.ElasticLoadBalancing.t, input :: describe_load_balancer_policies_input) :: ExAws.Request.Query.response_t
  def describe_load_balancer_policies(client, input) do
    request(client, "/", "DescribeLoadBalancerPolicies", input)
  end

  @doc """
  Same as `describe_load_balancer_policies/2` but raise on error.
  """
  @spec describe_load_balancer_policies!(client :: ExAws.ElasticLoadBalancing.t, input :: describe_load_balancer_policies_input) :: ExAws.Request.Query.success_t | no_return
  def describe_load_balancer_policies!(client, input) do
    case describe_load_balancer_policies(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeLoadBalancerPolicyTypes

  Describes the specified load balancer policy types.

  You can use these policy types with `CreateLoadBalancerPolicy` to create
  policy configurations for a load balancer.
  """

  @spec describe_load_balancer_policy_types(client :: ExAws.ElasticLoadBalancing.t, input :: describe_load_balancer_policy_types_input) :: ExAws.Request.Query.response_t
  def describe_load_balancer_policy_types(client, input) do
    request(client, "/", "DescribeLoadBalancerPolicyTypes", input)
  end

  @doc """
  Same as `describe_load_balancer_policy_types/2` but raise on error.
  """
  @spec describe_load_balancer_policy_types!(client :: ExAws.ElasticLoadBalancing.t, input :: describe_load_balancer_policy_types_input) :: ExAws.Request.Query.success_t | no_return
  def describe_load_balancer_policy_types!(client, input) do
    case describe_load_balancer_policy_types(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeLoadBalancers

  Describes the specified the load balancers. If no load balancers are
  specified, the call describes all of your load balancers.
  """

  @spec describe_load_balancers(client :: ExAws.ElasticLoadBalancing.t, input :: describe_access_points_input) :: ExAws.Request.Query.response_t
  def describe_load_balancers(client, input) do
    request(client, "/", "DescribeLoadBalancers", input)
  end

  @doc """
  Same as `describe_load_balancers/2` but raise on error.
  """
  @spec describe_load_balancers!(client :: ExAws.ElasticLoadBalancing.t, input :: describe_access_points_input) :: ExAws.Request.Query.success_t | no_return
  def describe_load_balancers!(client, input) do
    case describe_load_balancers(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DescribeTags

  Describes the tags associated with the specified load balancers.
  """

  @spec describe_tags(client :: ExAws.ElasticLoadBalancing.t, input :: describe_tags_input) :: ExAws.Request.Query.response_t
  def describe_tags(client, input) do
    request(client, "/", "DescribeTags", input)
  end

  @doc """
  Same as `describe_tags/2` but raise on error.
  """
  @spec describe_tags!(client :: ExAws.ElasticLoadBalancing.t, input :: describe_tags_input) :: ExAws.Request.Query.success_t | no_return
  def describe_tags!(client, input) do
    case describe_tags(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DetachLoadBalancerFromSubnets

  Removes the specified subnets from the set of configured subnets for the
  load balancer.

  After a subnet is removed, all EC2 instances registered with the load
  balancer in the removed subnet go into the `OutOfService` state. Then, the
  load balancer balances the traffic among the remaining routable subnets.
  """

  @spec detach_load_balancer_from_subnets(client :: ExAws.ElasticLoadBalancing.t, input :: detach_load_balancer_from_subnets_input) :: ExAws.Request.Query.response_t
  def detach_load_balancer_from_subnets(client, input) do
    request(client, "/", "DetachLoadBalancerFromSubnets", input)
  end

  @doc """
  Same as `detach_load_balancer_from_subnets/2` but raise on error.
  """
  @spec detach_load_balancer_from_subnets!(client :: ExAws.ElasticLoadBalancing.t, input :: detach_load_balancer_from_subnets_input) :: ExAws.Request.Query.success_t | no_return
  def detach_load_balancer_from_subnets!(client, input) do
    case detach_load_balancer_from_subnets(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  DisableAvailabilityZonesForLoadBalancer

  Removes the specified Availability Zones from the set of Availability Zones
  for the specified load balancer.

  There must be at least one Availability Zone registered with a load
  balancer at all times. After an Availability Zone is removed, all instances
  registered with the load balancer that are in the removed Availability Zone
  go into the `OutOfService` state. Then, the load balancer attempts to
  equally balance the traffic among its remaining Availability Zones.

  For more information, see [Disable an Availability Zone from a
  Load-Balanced
  Application](http://docs.aws.amazon.com/ElasticLoadBalancing/latest/DeveloperGuide/US_ShrinkLBApp04.html)
  in the *Elastic Load Balancing Developer Guide*.
  """

  @spec disable_availability_zones_for_load_balancer(client :: ExAws.ElasticLoadBalancing.t, input :: remove_availability_zones_input) :: ExAws.Request.Query.response_t
  def disable_availability_zones_for_load_balancer(client, input) do
    request(client, "/", "DisableAvailabilityZonesForLoadBalancer", input)
  end

  @doc """
  Same as `disable_availability_zones_for_load_balancer/2` but raise on error.
  """
  @spec disable_availability_zones_for_load_balancer!(client :: ExAws.ElasticLoadBalancing.t, input :: remove_availability_zones_input) :: ExAws.Request.Query.success_t | no_return
  def disable_availability_zones_for_load_balancer!(client, input) do
    case disable_availability_zones_for_load_balancer(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  EnableAvailabilityZonesForLoadBalancer

  Adds the specified Availability Zones to the set of Availability Zones for
  the specified load balancer.

  The load balancer evenly distributes requests across all its registered
  Availability Zones that contain instances.

  For more information, see [Add Availability
  Zone](http://docs.aws.amazon.com/ElasticLoadBalancing/latest/DeveloperGuide/US_AddLBAvailabilityZone.html)
  in the *Elastic Load Balancing Developer Guide*.
  """

  @spec enable_availability_zones_for_load_balancer(client :: ExAws.ElasticLoadBalancing.t, input :: add_availability_zones_input) :: ExAws.Request.Query.response_t
  def enable_availability_zones_for_load_balancer(client, input) do
    request(client, "/", "EnableAvailabilityZonesForLoadBalancer", input)
  end

  @doc """
  Same as `enable_availability_zones_for_load_balancer/2` but raise on error.
  """
  @spec enable_availability_zones_for_load_balancer!(client :: ExAws.ElasticLoadBalancing.t, input :: add_availability_zones_input) :: ExAws.Request.Query.success_t | no_return
  def enable_availability_zones_for_load_balancer!(client, input) do
    case enable_availability_zones_for_load_balancer(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  ModifyLoadBalancerAttributes

  Modifies the attributes of the specified load balancer.

  You can modify the load balancer attributes, such as `AccessLogs`,
  `ConnectionDraining`, and `CrossZoneLoadBalancing` by either enabling or
  disabling them. Or, you can modify the load balancer attribute
  `ConnectionSettings` by specifying an idle connection timeout value for
  your load balancer.

  For more information, see the following in the *Elastic Load Balancing
  Developer Guide*:

  - [Cross-Zone Load
  Balancing](http://docs.aws.amazon.com/ElasticLoadBalancing/latest/DeveloperGuide/TerminologyandKeyConcepts.html#request-routing)

  - [Connection
  Draining](http://docs.aws.amazon.com/ElasticLoadBalancing/latest/DeveloperGuide/TerminologyandKeyConcepts.html#conn-drain)

  - [Access
  Logs](http://docs.aws.amazon.com/ElasticLoadBalancing/latest/DeveloperGuide/access-log-collection.html)

  - [Idle Connection
  Timeout](http://docs.aws.amazon.com/ElasticLoadBalancing/latest/DeveloperGuide/TerminologyandKeyConcepts.html#idle-timeout)
  """

  @spec modify_load_balancer_attributes(client :: ExAws.ElasticLoadBalancing.t, input :: modify_load_balancer_attributes_input) :: ExAws.Request.Query.response_t
  def modify_load_balancer_attributes(client, input) do
    request(client, "/", "ModifyLoadBalancerAttributes", input)
  end

  @doc """
  Same as `modify_load_balancer_attributes/2` but raise on error.
  """
  @spec modify_load_balancer_attributes!(client :: ExAws.ElasticLoadBalancing.t, input :: modify_load_balancer_attributes_input) :: ExAws.Request.Query.success_t | no_return
  def modify_load_balancer_attributes!(client, input) do
    case modify_load_balancer_attributes(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RegisterInstancesWithLoadBalancer

  Adds the specified instances to the specified load balancer.

  The instance must be a running instance in the same network as the load
  balancer (EC2-Classic or the same VPC). If you have EC2-Classic instances
  and a load balancer in a VPC with ClassicLink enabled, you can link the
  EC2-Classic instances to that VPC and then register the linked EC2-Classic
  instances with the load balancer in the VPC.

  Note that `RegisterInstanceWithLoadBalancer` completes when the request has
  been registered. Instance registration happens shortly afterwards. To check
  the state of the registered instances, use `DescribeLoadBalancers` or
  `DescribeInstanceHealth`.

  After the instance is registered, it starts receiving traffic and requests
  from the load balancer. Any instance that is not in one of the Availability
  Zones registered for the load balancer is moved to the `OutOfService`
  state. If an Availability Zone is added to the load balancer later, any
  instances registered with the load balancer move to the `InService` state.

  If you stop an instance registered with a load balancer and then start it,
  the IP addresses associated with the instance changes. Elastic Load
  Balancing cannot recognize the new IP address, which prevents it from
  routing traffic to the instances. We recommend that you use the following
  sequence: stop the instance, deregister the instance, start the instance,
  and then register the instance. To deregister instances from a load
  balancer, use `DeregisterInstancesFromLoadBalancer`.

  For more information, see [Deregister and Register EC2
  Instances](http://docs.aws.amazon.com/ElasticLoadBalancing/latest/DeveloperGuide/US_DeReg_Reg_Instances.html)
  in the *Elastic Load Balancing Developer Guide*.
  """

  @spec register_instances_with_load_balancer(client :: ExAws.ElasticLoadBalancing.t, input :: register_end_points_input) :: ExAws.Request.Query.response_t
  def register_instances_with_load_balancer(client, input) do
    request(client, "/", "RegisterInstancesWithLoadBalancer", input)
  end

  @doc """
  Same as `register_instances_with_load_balancer/2` but raise on error.
  """
  @spec register_instances_with_load_balancer!(client :: ExAws.ElasticLoadBalancing.t, input :: register_end_points_input) :: ExAws.Request.Query.success_t | no_return
  def register_instances_with_load_balancer!(client, input) do
    case register_instances_with_load_balancer(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  RemoveTags

  Removes one or more tags from the specified load balancer.
  """

  @spec remove_tags(client :: ExAws.ElasticLoadBalancing.t, input :: remove_tags_input) :: ExAws.Request.Query.response_t
  def remove_tags(client, input) do
    request(client, "/", "RemoveTags", input)
  end

  @doc """
  Same as `remove_tags/2` but raise on error.
  """
  @spec remove_tags!(client :: ExAws.ElasticLoadBalancing.t, input :: remove_tags_input) :: ExAws.Request.Query.success_t | no_return
  def remove_tags!(client, input) do
    case remove_tags(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  SetLoadBalancerListenerSSLCertificate

  Sets the certificate that terminates the specified listener's SSL
  connections. The specified certificate replaces any prior certificate that
  was used on the same load balancer and port.

  For more information about updating your SSL certificate, see [Updating an
  SSL Certificate for a Load
  Balancer](http://docs.aws.amazon.com/ElasticLoadBalancing/latest/DeveloperGuide/US_UpdatingLoadBalancerSSL.html)
  in the *Elastic Load Balancing Developer Guide*.
  """

  @spec set_load_balancer_listener_ssl_certificate(client :: ExAws.ElasticLoadBalancing.t, input :: set_load_balancer_listener_ssl_certificate_input) :: ExAws.Request.Query.response_t
  def set_load_balancer_listener_ssl_certificate(client, input) do
    request(client, "/", "SetLoadBalancerListenerSSLCertificate", input)
  end

  @doc """
  Same as `set_load_balancer_listener_ssl_certificate/2` but raise on error.
  """
  @spec set_load_balancer_listener_ssl_certificate!(client :: ExAws.ElasticLoadBalancing.t, input :: set_load_balancer_listener_ssl_certificate_input) :: ExAws.Request.Query.success_t | no_return
  def set_load_balancer_listener_ssl_certificate!(client, input) do
    case set_load_balancer_listener_ssl_certificate(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  SetLoadBalancerPoliciesForBackendServer

  Replaces the set of policies associated with the specified port on which
  the back-end server is listening with a new set of policies. At this time,
  only the back-end server authentication policy type can be applied to the
  back-end ports; this policy type is composed of multiple public key
  policies.

  Each time you use `SetLoadBalancerPoliciesForBackendServer` to enable the
  policies, use the `PolicyNames` parameter to list the policies that you
  want to enable.

  You can use `DescribeLoadBalancers` or `DescribeLoadBalancerPolicies` to
  verify that the policy is associated with the back-end server.
  """

  @spec set_load_balancer_policies_for_backend_server(client :: ExAws.ElasticLoadBalancing.t, input :: set_load_balancer_policies_for_backend_server_input) :: ExAws.Request.Query.response_t
  def set_load_balancer_policies_for_backend_server(client, input) do
    request(client, "/", "SetLoadBalancerPoliciesForBackendServer", input)
  end

  @doc """
  Same as `set_load_balancer_policies_for_backend_server/2` but raise on error.
  """
  @spec set_load_balancer_policies_for_backend_server!(client :: ExAws.ElasticLoadBalancing.t, input :: set_load_balancer_policies_for_backend_server_input) :: ExAws.Request.Query.success_t | no_return
  def set_load_balancer_policies_for_backend_server!(client, input) do
    case set_load_balancer_policies_for_backend_server(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  @doc """
  SetLoadBalancerPoliciesOfListener

  Associates, updates, or disables a policy with a listener for the specified
  load balancer. You can associate multiple policies with a listener.
  """

  @spec set_load_balancer_policies_of_listener(client :: ExAws.ElasticLoadBalancing.t, input :: set_load_balancer_policies_of_listener_input) :: ExAws.Request.Query.response_t
  def set_load_balancer_policies_of_listener(client, input) do
    request(client, "/", "SetLoadBalancerPoliciesOfListener", input)
  end

  @doc """
  Same as `set_load_balancer_policies_of_listener/2` but raise on error.
  """
  @spec set_load_balancer_policies_of_listener!(client :: ExAws.ElasticLoadBalancing.t, input :: set_load_balancer_policies_of_listener_input) :: ExAws.Request.Query.success_t | no_return
  def set_load_balancer_policies_of_listener!(client, input) do
    case set_load_balancer_policies_of_listener(client, input) do
      {:ok, results} -> results
      error -> raise "Error #{inspect(error)}"
    end
  end



  defp request(%{__struct__: client_module} = client, uri, action, input) do
    apply(client_module, :request, [client, uri, action, input])
  end
end
