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
    |> Enum.reject(&match?({:skip_resources, _}, &1))
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

  @spec create_stack(stack_name :: binary, opts :: create_stack_opts) :: ExAws.Operation.Query.t
  def create_stack(stack_name, opts \\ []) do
    query_params = opts
    |> Keyword.delete(:capabilities)
    |> Keyword.delete(:parameters)
    |> Keyword.delete(:notification_arns)
    |> Keyword.delete(:tags)
    |> Keyword.delete(:resource_types)
    |> Keyword.delete(:template_url)
    |> normalize_opts
    |> Map.merge(
      case opts[:capabilities] do
                 nil -> %{}
        capabilities -> capabilities_params(capabilities)
      end
    )
    |> Map.merge(
      case opts[:parameters] do
                nil -> %{}
         parameters -> parameters_params(parameters)
      end
    )
    |> Map.merge(
      case opts[:notification_arns] do
                        nil -> %{}
          notification_arns -> notification_arns_params(notification_arns)
      end
    )
    |> Map.merge(
      case opts[:tags] do
           nil -> %{}
          tags -> tags_params(tags)
      end
    )
    |> Map.merge(
      case opts[:resource_types] do
                   nil -> %{}
        resource_types -> resource_types_params(resource_types)
      end
    )
    |> Map.merge(%{"TemplateURL" => opts[:template_url]})
    |> Map.merge(%{"StackName" => stack_name})

    request(:create_stack, query_params)
  end

  @spec delete_stack(stack_name :: binary, opts :: delete_stack_opts) :: ExAws.Operation.Query.t
  def delete_stack(stack_name, opts \\ []) do
    delete_params = %{
      "StackName" => stack_name,
      "RoleARN" => opts[:role_arn]
    }
    |> Map.merge(
      case opts[:retain_resources] do
                     nil -> %{}
        retain_resources -> retain_resources_params(retain_resources)
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
    |> Enum.reject(&match?({:status_filter, _}, &1))
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

  def resources_to_skip_params(resources) do
    resources
    |> Enum.with_index(1)
    |> Enum.flat_map(fn {resource, i} -> %{"ResourcesToSkip.member.#{i}" => resource} end)
    |> Enum.into(%{})
  end

  def stack_filter_params(filters) do
    filters
    |> Enum.with_index(1)
    |> Enum.flat_map(fn {filter, i} -> %{"StackStatusFilter.member.#{i}" => to_arg(filter)} end)
    |> Enum.into(%{})
  end

  defp to_arg(result), do: result |> Atom.to_string |> String.upcase

  def capabilities_params(capabilities) do
    capabilities
    |> Enum.with_index(1)
    |> Enum.flat_map(fn {capability, i} -> %{"Capabilities.member.#{i}" => to_arg(capability)} end)
    |> Enum.into(%{})
  end

  def parameters_params(parameters) do
    parameters
    |> Enum.with_index(1)
    |> Enum.flat_map(fn {{parameter_key, parameter_value, use_previous_value}, i} ->
      %{"Parameters.member.#{i}.ParameterKey" => Atom.to_string(parameter_key),
      "Parameters.member.#{i}.ParameterValue" => parameter_value,
      "Parameters.member.#{i}.UsePreviousValue" => use_previous_value}
    end)
    |> Enum.into(%{})
  end

  def notification_arns_params(notification_arns) do
    notification_arns
    |> Enum.with_index(1)
    |> Enum.flat_map(fn {notification_arn, i} -> %{"NotificationARNs.member.#{i}" => notification_arn} end)
    |> Enum.into(%{})
  end

  def tags_params(tags) do
    tags
    |> Enum.with_index(1)
    |> Enum.flat_map(fn {{key, value}, i} ->
      %{"Tags.member.#{i}.Key" => Atom.to_string(key), "Tags.member.#{i}.Value" => value}
    end)
    |> Enum.into(%{})
  end

  def resource_types_params(resource_types) do
    resource_types
    |> Enum.with_index(1)
    |> Enum.flat_map(fn {resource_type, i} -> %{"ResourceTypes.member.#{i}" => resource_type} end)
    |> Enum.into(%{})
  end

  def retain_resources_params(retain_resources) do
    retain_resources
    |> Enum.with_index(1)
    |> Enum.flat_map(fn {retain_resource, i} -> %{"RetainResources.member.#{i}" => retain_resource} end)
    |> Enum.into(%{})
  end
end
