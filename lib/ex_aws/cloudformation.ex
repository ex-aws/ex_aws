defmodule ExAws.Cloudformation do
  @moduledoc """
  Operations on Cloudformation
  """

  import ExAws.Utils

  @version "2010-05-15"

  #####################
  ### Stack Actions ###
  #####################

  @spec describe_stack_resource(stack_name :: binary, logical_resource_id :: binary) :: ExAws.Operation.Query.t
  def describe_stack_resource(stack_name, logical_resource_id) do
    query_params = %{
      "Version"   => @version,
      "StackName" => stack_name,
      "LogicalResourceId" => logical_resource_id
    }

    request(:describe_stack_resource, query_params)
  end

  @spec list_stack_resources(stack_name :: binary) :: ExAws.Operation.Query.t
  @spec list_stack_resources(stack_name :: binary, opts :: [next_token: binary]) :: ExAws.Operation.Query.t
  def list_stack_resources(stack_name, opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
      "Version" => @version,
      "StackName" => stack_name
      })

    request(:list_stack_resources, query_params)
  end

  ########################
  ### Helper Functions ###
  ########################

  defp request(action, params) do
    action_string = action |> Atom.to_string |> Macro.camelize

    %ExAws.Operation.Query{
      path: "/",
      params: params |> Map.put("Action", action_string),
      service: :cloudformation,
      action: action,
      parser: &ExAws.Cloudformation.Parsers.parse/2
    }
  end

  defp normalize_opts(opts) do
    opts
    |> Enum.into(%{})
    |> camelize_keys
  end
end
