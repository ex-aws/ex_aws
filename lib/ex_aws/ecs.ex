defmodule ExAws.ECS do
  import ExAws.Utils, only: [camelize_keys: 1, camelize_keys: 2]
  require Logger

  @namespace "AmazonEC2ContainerServiceV20141113"


  @spec create_cluster(cluster_name :: binary) :: ExAws.Operation.JSON.t
  def create_cluster(cluster_name) do
    request(:create_cluster, %{"clusterName" => cluster_name})
  end
  @spec create_cluster() :: ExAws.Operation.JSON.t
  def create_cluster() do
    request(:create_cluster)
  end


  @spec create_service(service_name :: binary, task_definition :: binary, desired_count :: pos_integer) :: ExAws.Operation.JSON.t
  @spec create_service(service_name :: binary, task_definition :: binary, desired_count :: pos_integer, opts :: Keyword.t) :: ExAws.Operation.JSON.t
  def create_service(service_name, task_definition, desired_count, opts \\ []) do
    data = opts
    |> normalize_opts
    |> Map.merge(%{"serviceName" => service_name, "taskDefinition" => task_definition, "desiredCount" => desired_count})

    request(:create_service, data)
  end

  @spec delete_cluster(cluster_name :: binary) :: ExAws.Operation.JSON.t
  def delete_cluster(cluster_name) do
    data = %{"cluster" => cluster_name}
    request(:delete_cluster, data)
  end

  @spec delete_service(service :: binary) :: ExAws.Operation.JSON.t
  def delete_service(service) do
    request(:delete_service, %{"service" => service})
  end
  @spec delete_service(service :: binary, cluster :: binary) :: ExAws.Operation.JSON.t
  def delete_service(service, cluster) do
    request(:delete_service, %{"service" => service, "cluster" => cluster})
  end

  @type deregister_container_instance_opts :: [
    {:cluster, binary} |
    {:force, boolean}
  ]
  @spec deregister_container_instance(container_instance :: binary) :: ExAws.Operation.JSON.t
  @spec deregister_container_instance(container_instance :: binary, opts :: deregister_container_instance_opts) :: ExAws.Operation.JSON.t
  def deregister_container_instance(container_instance, opts \\ []) do
    data = opts
    |> normalize_opts
    |> Map.merge(%{"containerInstance" => container_instance})

    request(:deregister_container_instance, data)
  end

  @spec deregister_task_definition(task_definition :: binary) :: ExAws.Operation.JSON.t
  def deregister_task_definition(task_definition) do
    data = %{"taskDefinition" => task_definition}

    request(:deregister_task_definition, data)
  end

  @spec describe_clusters() :: ExAws.Operation.JSON.t
  def describe_clusters() do
    request(:describe_clusters)
  end
  @spec describe_clusters(clusters :: list(binary)) :: ExAws.Operation.JSON.t
  def describe_clusters(clusters) do
    request(:describe_clusters , %{"clusters" => clusters})
  end


  @spec describe_container_instances(container_instances :: list(binary)) :: ExAws.Operation.JSON.t
  def describe_container_instances(container_instances) do
    request(:describe_container_instances, %{"containerInstances" => container_instances})
  end
  @spec describe_container_instances(container_instances :: list(binary), cluster :: binary) :: ExAws.Operation.JSON.t
  def describe_container_instances(container_instances, cluster) do
    request(:describe_container_instances, %{"containerInstances" => container_instances, "cluster" => cluster})
  end

  @spec describe_services(services :: list(binary)) :: ExAws.Operation.JSON.t
  def describe_services(services) do
    request(:describe_services, %{"services" => services})
  end
  @spec describe_services(services :: list(binary), cluster :: binary) :: ExAws.Operation.JSON.t
  def describe_services(services, cluster) do
    request(:describe_services, %{"services" => services, "cluster" => cluster})
  end

  @spec describe_task_definition(task_definition :: binary) :: ExAws.Operation.JSON.t
  def describe_task_definition(task_definition) do
    request(:describe_task_definition, %{"taskDefinition" => task_definition})
  end

  @spec describe_tasks(tasks :: list(binary)) :: ExAws.Operation.JSON.t
  def describe_tasks(tasks) do
    request(:describe_tasks, %{"tasks" => tasks})
  end
  @spec describe_tasks(tasks :: list(binary), cluster :: binary) :: ExAws.Operation.JSON.t
  def describe_tasks(tasks, cluster) do
    request(:describe_tasks, %{"tasks" => tasks, "cluster" => cluster})
  end

  @type discover_poll_endpoint_opts :: [
    {:cluster, binary} |
    {:container_instance, binary}
  ]
  @spec discover_poll_endpoint() :: ExAws.Operation.JSON.t
  @spec discover_poll_endpoint(opts :: discover_poll_endpoint_opts) :: ExAws.Operation.JSON.t
  def discover_poll_endpoint(opts \\ []) do
    data = opts
    |> normalize_opts
    request(:discover_poll_endpoint_opts, data)
  end

  @type list_clusters_opts :: [
    {:max_results, 1..100} |
    {:next_token, binary}
  ]
  @spec list_clusters() :: ExAws.Operation.JSON.t
  @spec list_clusters(opts :: list_clusters_opts) :: ExAws.Operation.JSON.t
  def list_clusters(opts \\ []) do
    data = opts
    |> normalize_opts
    request(:list_clusters, data)
  end

  @type list_container_instances_opts :: [
    {:cluster, binary} |
    {:max_results, 1..100} |
    {:next_token, binary}
  ]

  @spec list_container_instances() :: ExAws.Operation.JSON.t
  @spec list_container_instances(opts :: list_container_instances_opts) :: ExAws.Operation.JSON.t
  def list_container_instances(opts \\ []) do
    data = opts
    |> normalize_opts
    request(:list_container_instances, data)
  end

  @type list_services_opts :: [
    {:cluster, binary} |
    {:max_results, 1..10} |
    {:next_token, binary}
  ]
  @spec list_services() :: ExAws.Operation.JSON.t
  @spec list_services(opts :: list_services_opts) :: ExAws.Operation.JSON.t
  def list_services(opts \\ []) do
    data = opts
    |> normalize_opts
    request(:list_services, data)
  end

  @type list_task_definition_families_opts :: [
    {:family_prefix, binary} |
    {:max_results, 1..100} |
    {:next_token, binary} |
    {:status, binary}
  ]
  @spec list_task_definition_families() :: ExAws.Operation.JSON.t
  @spec list_task_definition_families(opts :: list_task_definition_families_opts) :: ExAws.Operation.JSON.t
  def list_task_definition_families(opts \\ []) do
    data = opts
    |> normalize_opts
    request(:list_task_definition_families, data)
  end

  @type list_task_definitions_opts :: [
    {:family_prefix, binary} |
    {:max_results, 1..100} |
    {:next_token, binary} |
    {:sort, binary} |
    {:status, binary}
  ]
  @spec list_task_definitions() :: ExAws.Operation.JSON.t
  @spec list_task_definitions(opts :: list_task_definitions_opts) :: ExAws.Operation.JSON.t
  def list_task_definitions(opts \\ []) do
    data = opts
    |> normalize_opts
    request(:list_task_definitions, data)
  end

  @type list_tasks_opts :: [
    {:cluster, binary} |
    {:container_instance, binary} |
    {:desired_status, binary} |
    {:family, binary} |
    {:max_results, 1..100} |
    {:next_token, binary} |
    {:service_name, binary} |
    {:started_by, binary}
  ]
  @spec list_tasks() :: ExAws.Operation.JSON.t
  @spec list_tasks(opts :: list_tasks_opts) :: ExAws.Operation.JSON.t
  def list_tasks(opts \\ []) do
    data = opts
    |> normalize_opts
    request(:list_tasks, data)
  end


  @spec register_container_instance() :: ExAws.Operation.JSON.t
  @spec register_container_instance(opts :: Keyword.t) :: ExAws.Operation.JSON.t
  def register_container_instance(opts \\ []) do
    data = opts
    |> normalize_opts

    request(:register_container_instance, data)
  end

  # http://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_KeyValuePair.html
  @type key_value_pair :: [
    {:name, binary} |
    {:value, binary}
  ]

  # http://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_HostEntry.html
  @type host_entry :: [
    {:hostname, binary} |
    {:ip_address, binary }
  ]
  # http://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_RegisterTaskDefinition.html
  @type log_drivers :: [
    :"json-file" |
    :syslog |
    :journald |
    :gelf |
    :fluentd |
    :awslogs |
    :splunk
  ]
  @type log_configuration :: [
    {:log_driver, log_drivers} |
    {:options, map}
  ]

  # http://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_MountPoint.html
  @type mount_point :: [
    {:container_path, binary} |
    {:read_only, boolean} |
    {:source_volume, binary}
  ]

  # http://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_PortMapping.html
  @type protocols :: [
    :tcp |
    :udp
  ]
  @type port_mapping :: [
    {:container_port, 1..65535} |
    {:host_port, 0..65535} |
    {:protocol, protocols}
  ]

  # http://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_Ulimit.html
  @type ulimit :: [
    {:hard_limit, pos_integer} |
    {:name, binary} |
    {:soft_limit, pos_integer}
  ]

  # http://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_VolumeFrom.html
  @type volume_from :: [
    {:read_only, boolean} |
    {:source_container, binary}
  ]

  # http://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ContainerDefinition.html
  @type container_definition :: [
    {:command, list(binary)} |
    {:cpu, pos_integer} |
    {:disable_networking, boolean} |
    {:dns_search_domains, list(binary)} |
    {:dns_servers, list(binary)} |
    {:docker_labels, map} |
    {:docker_security_options, list(binary)} |
    {:entry_point, list(binary)} |
    {:environment, list(key_value_pair)} |
    {:essential, boolean} |
    {:extra_hosts, list(host_entry)} |
    {:hostname, binary} |
    {:image, binary} |
    {:links, list(binary)} |
    {:log_configuration, log_configuration} |
    {:memory, pos_integer} |
    {:memory_reservation, pos_integer} |
    {:mount_points, list(mount_point)} |
    {:name, binary} |
    {:port_mappings, list(port_mapping)} |
    {:privileged, boolean} |
    {:readonly_root_filesystem, boolean} |
    {:ulimits, list(ulimit)} |
    {:user, binary} |
    {:volumes_from, list(volume_from)} |
    {:working_directory, binary}
  ]

  # http://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_HostVolumeProperties.html
  @type host_volume_properties :: [
    {:source_path, binary}
  ]

  @type network_modes :: [
    :bridge |
    :host |
    :none
  ]

  # http://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_Volume.html
  @type volume :: [
    {:host, host_volume_properties} |
    {:name, binary}
  ]

  @type register_task_definition_opts :: [
    {:network_mode, network_modes} |
    {:task_role_arn, binary} |
    {:volumes, list(volume)}
  ]

  @spec register_task_definition(container_definitions :: list(container_definition), family :: binary, opts :: register_task_definition_opts) :: ExAws.Operation.JSON.t
  def register_task_definition(container_definitions, family, opts \\[]) do
    required = %{
      "containerDefinitions" => pascalize_keys(container_definitions),
      "family" => family}
    data = opts
    |> normalize_opts
    |> Map.merge(required)

    request(:register_task_definition, data)
  end

  # http://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ContainerOverride.html
  @type container_override :: [
    {:command, list(binary)} |
    {:environment, list(key_value_pair)} |
    {:name, binary}
  ]
  #http://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_TaskOverride.html
  @type task_override :: [
    {:container_overrides, list(container_override)} |
    {:task_role_arn, binary}
  ]
  # http://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_RunTask.html
  @type run_task_opts :: [
    {:cluster, binary} |
    {:count, 1..10} |
    {:overrides, task_override} |
    {:started_by, binary}
  ]
  @spec run_task(task_definition :: binary) :: ExAws.Operation.JSON.t
  @spec run_task(task_definition :: binary, opts :: run_task_opts) :: ExAws.Operation.JSON.t
  def run_task(task_definition, opts \\ []) do
    data = opts
    |> normalize_opts
    |> Map.merge(%{"taskDefinition" => task_definition})
    request(:run_task, data)
  end

  # http://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_StartTask.html
  @type start_task_opts :: [
    {:cluster, binary} |
    {:overrides, task_override} |
    {:started_by, binary}
  ]
  @spec start_task(task_definition :: binary, container_instances :: nonempty_list(binary)) :: ExAws.Operation.JSON.t
  @spec start_task(task_definition :: binary, container_instances :: nonempty_list(binary), opts :: start_task_opts) :: ExAws.Operation.JSON.t
  def start_task(task_definition, container_instances, opts \\ []) do
    data = opts
    |> normalize_opts
    |> Map.merge(%{"taskDefinition" => task_definition, "containerInstances" => container_instances})
    request(:start_task, data)
  end

  # http://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_StopTask.html
  @type stop_task_opts :: [
    {:cluster, binary} |
    {:reason, binary}
  ]
  @spec stop_task(task :: binary) :: ExAws.Operation.JSON.t
  @spec stop_task(task :: binary, opts :: stop_task_opts) :: ExAws.Operation.JSON.t
  def stop_task(task, opts \\ []) do
    data = opts
    |> normalize_opts
    |> Map.merge(%{"task" => task})
    request(:stop_task, data)
  end

  @spec submit_container_state_change() :: ExAws.Operation.JSON.t
  @spec submit_container_state_change(opts :: Keyword.t) :: ExAws.Operation.JSON.t
  def submit_container_state_change(opts \\ []) do
    data = opts
    |> normalize_opts
    request(:submit_container_state_change, data)
  end

  @spec submit_task_state_change() :: ExAws.Operation.JSON.t
  @spec submit_task_state_change(opts :: Keyword.t) :: ExAws.Operation.JSON.t
  def submit_task_state_change(opts \\ []) do
    data = opts
    |> normalize_opts
    request(:submit_task_state_change, data)
  end

  @spec update_container_agent(container_instance :: binary) :: ExAws.Operation.JSON.t
  def update_container_agent(container_instance) do
    data = %{"containerInstance" => container_instance}
    request(:update_container_agent, data)
  end
  @spec update_container_agent(container_instance :: binary, cluster :: binary) :: ExAws.Operation.JSON.t
  def update_container_agent(container_instance, cluster) do
    data = %{"containerInstance" => container_instance, "cluster" => cluster}
    request(:update_container_agent, data)
  end

  def update_service(opts \\ []) do
    data = opts
    |> normalize_opts
    |> Map.merge(%{})
    request(:update_service, data)
  end


  ## Private parts


  defp pascalize_keys(opts) when is_map(opts) do
    opts
    |> Enum.map(&pascalize_key/1)
    |> Enum.into(%{})
  end
  defp pascalize_keys([]), do: []
  defp pascalize_keys([head | tail]) do
    [pascalize_keys(head)] ++ pascalize_keys(tail)
  end
  defp pascalize_keys(bool) when is_boolean(bool), do: bool
  defp pascalize_keys(atom) when is_atom(atom), do: Atom.to_string(atom)
  defp pascalize_key({k, v}) when is_binary(k) do
    value = pascalize_keys(v)
    {k, value}
  end
  defp pascalize_key({k, v}) when is_atom(k) do
    key = k |> Atom.to_string |> pascalize
    value = pascalize_keys(v)
    {key, value}
  end
  defp pascalize_keys(other), do: other

  defp pascalize(word) do
    case Regex.split(~r/(?:^|[-_])|(?=[A-Z])/, to_string(word)) do
      words -> words |> pascalize_list(:lower)
                     |> Enum.join
    end
  end

  defp pascalize_list([], :upper), do: []
  defp pascalize_list([h|tail], :lower) do
    [lowercase(h)] ++ pascalize_list(tail, :upper)
  end
  defp pascalize_list([h|tail], :upper) do
    [capitalize(h)] ++ pascalize_list(tail, :upper)
  end

  defp capitalize(word), do: String.capitalize(word)
  defp lowercase(word), do: String.downcase(word)

  defp normalize_opts(opts) do
    opts
    |> Enum.into(%{})
    |> pascalize_keys
  end

  defp request(action), do: request(action, %{})
  defp request(action, data, opts \\ %{}) do
    operation =
      action
      |> Atom.to_string
      |> Macro.camelize

    ExAws.Operation.JSON.new(:ecs, %{
      data: data,
      headers: [
        {"x-amz-target", "#{@namespace}.#{operation}"},
        {"content-type", "application/x-amz-json-1.1"}
      ]
    } |> Map.merge(opts))
  end

end
