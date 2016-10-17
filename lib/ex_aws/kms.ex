defmodule ExAws.KMS do
  @moduledoc """
  Operations on AWS KMS
  """

  import ExAws.Utils

  @version "2014-11-01"

  @spec list_keys() :: ExAws.Operation.RestQuery.t
  def list_keys(opts \\ []) do
    query_params = opts
    |> normalize_opts
    |> Map.merge(%{
          "Action"  => "ListKeys",
          "Version" => @version
                 })

    request(:list_keys, query_params, parser: &ExAws.KMS.Parsers.parse_list_keys/2)
  end

  ########################
  ### Helper Functions ###
  ########################

  defp request(action, params, opts \\ %{}) do
    %ExAws.Operation.Query{
      path: "/",
      params: params,
      action: action,
      service: :kms,
      parser: opts[:parser]
    }
  end

  defp normalize_opts(opts) do
    opts
    |> Enum.into(%{})
    |> camelize_keys
  end
end
