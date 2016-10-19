defmodule ExAws.KMS do
  @moduledoc """
  Operations on AWS KMS
  """

  import ExAws.Utils

  @version "2014-11-01"

  @spec list_keys() :: ExAws.Operation.JSON.t
  def list_keys(opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"  => "ListKeys",
          "Version" => @version
                 })

    request(:list_keys, query_params)
  end

  ########################
  ### Helper Functions ###
  ########################

  defp request(action, params, opts \\ %{}) do
    operation =
      action
      |> Atom.to_string
      |> Macro.camelize

    ExAws.Operation.JSON.new(:kms, %{
          data: params,
          headers: [
            {"x-amz-target", "TrentService.#{operation}"},
            {"content-type", "application/x-amz-json-1.0"},
          ]
    } |> Map.merge(opts))
  end

  defp normalize_opts(opts) do
    opts
    |> Enum.into(%{})
    |> camelize_keys
  end
end
