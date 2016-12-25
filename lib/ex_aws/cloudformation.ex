defmodule ExAws.Cloudformation do
  @moduledoc """
  Operations on Cloudformation
  """

  import ExAws.Utils

  @version "2010-05-15"

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

    query_params = case opts[:status_filter] do
          nil ->  query_params
      filters -> stack_filter_params(filters) |> Map.merge(query_params)
    end

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

  def stack_filter_params(filters) do
    to_arg = fn f -> f |> Atom.to_string |> String.upcase end

    filters
    |> Enum.with_index
    |> Enum.flat_map(fn {f, idx} -> %{"StackStatusFilter.member.#{idx+1}" => to_arg.(f)} end)
    |> Enum.into(%{})
  end
end
