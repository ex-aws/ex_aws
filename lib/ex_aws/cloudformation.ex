defmodule ExAws.Cloudformation do
  @moduledoc """
  Operations on Cloudformation
  """

  import ExAws.Utils

  @version "2010-05-15"

  @type accepted_capability_vals ::
    :capability_iam |
    :capability_named_iam


  @type on_failure_vals ::
    :do_nothing |
    :rollback |
    :delete

  @type parameter :: [
    parameter_key: binary,
    parameter_value: binary,
    use_previous_value: boolean
  ]

  @type tag :: {key :: atom, value :: binary}

  @type create_stack_opts :: [
    capabilities: [accepted_capability_vals, ...],
    disable_rollback: boolean,
    notification_arns: [binary, ...],
    on_failure: on_failure_vals,
    parameters: [parameter, ...],
    resource_types: [binary, ...],
    role_arn: binary,
    stack_policy_body: binary,
    stack_policy_url: binary,
    tags: [tag, ...],
    template_body: binary,
    template_url: binary,
    timeout_in_minutes: integer
  ]


  @type delete_stack_opts :: [
    retain_resources: [binary, ...],
    role_arn: binary
  ]

  @type continue_update_rollback_opts :: [
    role_arn: binary,
    skip_resources: [binary, ...]
  ]

  @type list_stacks_opts :: [
    next_token: binary,
    status_filter: [ExAws.Cloudformation.Parsers.stack_status, ...]
  ]

  @type describe_stack_resources_opts :: [
    logical_resource_id: binary,
    physical_resource_id: binary
  ]

  #####################
  ### Stack Actions ###
  #####################

  @spec cancel_update_stack(stack_name :: binary) :: ExAws.Operation.Query.t
  def cancel_update_stack(stack_name) do
    request(:cancel_update_stack, %{"StackName" => stack_name})
  end

  @spec continue_update_rollback(stack_name :: binary, opts :: list_stacks_opts) :: ExAws.Operation.Query.t
  def continue_update_rollback(stack_name, opts \\ []) do
    query_params = opts
    |> Keyword.delete(:skip_resources)
    |> normalize_opts
    |> Map.merge(
      case opts[:skip_resources] do
              nil -> %{}
        resources -> resources_to_skip_params(resources)
      end
    )
    |> Map.merge(%{ "StackName" => stack_name })

    request(:continue_update_rollback, query_params)
  end

  # key :: atom
  @create_stack_params_to_delete [
    :capabilities, :parameters,
    :notification_arns, :tags,
    :resource_types, :template_url
  ]

  # {key :: atom, transform_function_name :: atom}
  @create_stack_params_to_transform [
    {:capabilities, :transform_capabilities},
    {:parameters, :transform_parameters},
    {:notification_arns, :transform_notification_arns},
    {:tags, :transform_tags},
    {:resource_types, :transform_resource_types}
  ]

  @spec create_stack(stack_name :: binary, opts :: create_stack_opts) :: ExAws.Operation.Query.t
  def create_stack(stack_name, opts \\ []) do
    normal_params = opts
    |> Enum.reject(fn {key, _} -> key in @params_to_delete end)
    |> normalize_opts

    transformed_params = @params_to_transform
    |> Enum.flat_map(fn {key, transform_func} ->
      maybe_transform(function_name, opts[key])
    end)

    other_params =
      [{"StackName": stack_name}, {"TemplateURL", opts[:template_url] }]
      |> Enum.reject(fn {key, _value} -> value == nil end)

    query_params =
      Enum.concat([normal_params, transformed_params, other_params])
      |> Enum.into(%{})

    request(:create_stack, query_params)
  end

  @spec delete_stack(stack_name :: binary, opts :: delete_stack_opts) :: ExAws.Operation.Query.t
  def delete_stack(stack_name, opts \\ []) do
    delete_params = %{
      "StackName" => stack_name,
    }
    |> Map.merge(
      case opts[:role_arn] do
              nil -> %{}
         role_arn -> %{"RoleARN" => role_arn}
      end
    )
    |> Map.merge(
      case opts[:retain_resources] do
                     nil -> %{}
        retain_resources -> transform_retain_resources(retain_resources)
      end
    )

    request(:delete_stack, delete_params)
  end

  @spec describe_stack_resource(stack_name :: binary, logical_resource_id :: binary) :: ExAws.Operation.Query.t
  def describe_stack_resource(stack_name, logical_resource_id) do
    query_params = %{
      "StackName" => stack_name,
      "LogicalResourceId" => logical_resource_id
    }

    request(:describe_stack_resource, query_params)
  end

  @spec describe_stack_resources(stack_name :: binary, opts :: describe_stack_resources_opts) :: ExAws.Operation.Query.t
  def describe_stack_resources(stack_name, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{"StackName" => stack_name})

    request(:describe_stack_resources, query_params)
  end

  @spec list_stacks(opts :: list_stacks_opts) :: ExAws.Operation.Query.t
  def list_stacks(opts \\ []) do
    query_params = opts
    |> Keyword.delete(:status_filter)
    |> normalize_opts
    |> Map.merge(
       case opts[:status_filter] do
             nil -> %{}
         filters -> stack_filter_params(filters)
       end
    )
    request(:list_stacks, query_params)
  end

  @spec list_stack_resources(stack_name :: binary) :: ExAws.Operation.Query.t
  @spec list_stack_resources(stack_name :: binary, opts :: [next_token: binary]) :: ExAws.Operation.Query.t
  def list_stack_resources(stack_name, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{"StackName" => stack_name})

    request(:list_stack_resources, query_params)
  end

  ########################
  ### Helper Functions ###
  ########################

  defp request(action, params) do
    action_string = action |> Atom.to_string |> Macro.camelize

    %ExAws.Operation.Query{
      path: "/",
      params: params |> Map.put("Action", action_string) |> Map.put("Version", @version),
      service: :cloudformation,
      action: action,
      parser: &ExAws.Cloudformation.Parsers.parse/3
    }
  end

  defp normalize_opts(opts) do
    opts
    |> Enum.into(%{})
    |> camelize_keys
  end

  defp build_request_param(prefix, index, suffix \\ nil, value) do
    dot_suffix =
      if suffix != nil do ".#{suffix}" else "" end

    {"#{prefix}.member.#{index}#{dot_suffix}", value}
  end

  defp build_request_params(request_param, values) do
    values
    |> Enum.with_index(1)
    |> Enum.map(fn {value, index} -> build_request_param(request_param, index, value) end)
    |> Enum.into(%{})
  end

  def resources_to_skip_params(resources) do
    build_request_params("ResourcesToSkip", resources)
  end

  def stack_filter_params(filters) do
    filters_strings =
      filters
        |> Enum.map(fn filter -> to_arg(filter) end)

    build_request_params("StackStatusFilter", filters_strings)
  end

  defp to_arg(result), do: result |> Atom.to_string |> String.upcase

  def transform_capabilities(capabilities) do
    capabilities_strings =
      capabilities
        |> Enum.map(fn capability -> to_arg(capability) end)

    build_request_params("Capabilities", capabilities_strings)
  end

  def transform_parameters(parameters) do
    parameters
    |> Enum.with_index(1)
    |> Enum.flat_map(fn {parameter, i} ->
      [
       build_request_param("Parameters", i, "ParameterKey", parameter[:parameter_key]),
       build_request_param("Parameters", i, "ParameterValue", parameter[:parameter_value]),
       build_request_param("Parameters", i, "UsePreviousValue", parameter[:use_previous_value])
      ]
    end)
    |> Enum.filter(fn {_key, value} -> value != nil end)
    |> Enum.into(%{})
  end

  def transform_notification_arns(notification_arns) do
    build_request_params("NotificationARN", notification_arns)
  end


  def transform_tags(tags) do
    tags
    |> Enum.with_index(1)
    |> Enum.flat_map(fn {{key, value}, i} ->
      [
       build_request_param("Tags", i, "Key", Atom.to_string(key)),
       build_request_param("Tags", i, "Value", value)
      ]
    end)
    |> Enum.filter(fn {_key, value} -> value != nil end)
    |> Enum.into(%{})
  end

  def transform_resource_types(resource_types) do
    build_request_params("ResourceTypes", resource_types)
  end

  def transform_retain_resources(retain_resources) do
    build_request_params("RetainResources", retain_resources)
  end

  defp maybe_transform(func, value) when is_atom(func) do
    case value do
        nil -> %{}
      value -> apply(ExAws.Cloudformation, func, [value])
    end
  end
end
