defmodule ExAws.Route53 do
  @moduledoc """
  Operations on AWS Route53
  """

  @type list_hosted_zones_opts :: [
    {:marker, binary} |
    {:max_items, 1..100}
  ]
  @doc "List hosted zones"
  @spec list_hosted_zones(opts :: list_hosted_zones_opts) :: ExAws.Operation.RestQuery.t
  def list_hosted_zones(opts \\ []) do
    opts = opts
            |> Map.new
            |> Map.put(:maxitems, opts[:max_items])
            |> Map.delete(:max_items)
            |> Enum.reject(fn {_, v} -> is_nil(v) end)
            |> Enum.into(%{})
    request(:get, :list_hosted_zones, opts)
  end

  ## Request
  ######################

  defp request(http_method, action, params) do
    %ExAws.Operation.RestQuery{
      http_method: http_method,
      path: "/2013-04-01/hostedzone",
      params: params,
      service: :route53,
      action: action,
      parser: &ExAws.Route53.Parsers.parse/2
    }
  end
end
