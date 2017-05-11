defmodule ExAws.Cloudformation do
  @moduledoc """
  Operations on Cloudformation
  """

  import ExAws.Utils

  @version "2010-05-15"

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
    |> Map.merge(%{ "StackName" => stack_name })

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
    |> Map.merge(%{ "StackName" => stack_name })

    request(:list_stack_resources, query_params)
  end

  @doc "Returns the description for the specified stack; if no stack name was specified, then it returns the description for all the stacks created."
  @spec describe_stacks(stack_name :: binary) :: ExAws.Operation.Query.t
  def describe_stacks(stack_name \\ nil, opts \\ []) do
    normalized_params = opts
    |> normalize_opts
    
    query_params =
    if is_nil(stack_name) || stack_name == "" do
      normalized_params
    else
      normalized_params
      |> Map.merge(%{ "StackName" => stack_name })
    end

    request(:describe_stacks, query_params)
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
    |> Enum.with_index
    |> Enum.flat_map(fn {r, idx} -> %{"ResourcesToSkip.member.#{idx+1}" => r} end)
    |> Enum.into(%{})
  end

  def stack_filter_params(filters) do
    to_arg = fn f -> f |> Atom.to_string |> String.upcase end

    filters
    |> Enum.with_index
    |> Enum.flat_map(fn {f, idx} -> %{"StackStatusFilter.member.#{idx+1}" => to_arg.(f)} end)
    |> Enum.into(%{})
  end
end
