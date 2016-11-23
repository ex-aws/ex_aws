defmodule ExAws.Route53 do
  import ExAws.Utils, only: [uuid: 0]
  import ExAws.Xml, only: [add_optional_node: 2]

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
    request(:get, :list_hosted_zones, params: opts)
  end

  @type create_hosted_zone_opts :: [
    {:name, binary} |
    {:comment, binary} |
    {:private, boolean} |
    {:vpc_is, binary} |
    {:vpc_region, binary}
  ]
  @doc "Create hosted zone"
  @spec create_hosted_zone(opts :: create_hosted_zone_opts) :: ExAws.Operation.RestQuery.t
  def create_hosted_zone(opts \\ []) do
    payload = {
      :CreateHostedZoneRequest, %{xmlns: "https://route53.amazonaws.com/doc/2013-04-01/"}, [
       {:CallerReference, nil, uuid},
       {:Name, nil, opts[:name]}]
    } |> add_optional_node(
          {:HostedZoneConfig, nil, nil}
          |> add_optional_node({:Comment, nil, opts[:comment]})
          |> add_optional_node({:PrivateZone, nil, opts[:private]})
    ) |> add_optional_node({
         :VPC, nil, [
           {:VPCId, nil, opts[:vpc_id]},
           {:VPCRegion, nil, opts[:vpc_region]}]
    }) |> XmlBuilder.doc
    request(:post, :create_hosted_zone, body: payload)
  end

  ## Request
  ######################

  defp request(http_method, action, opts) do
    %ExAws.Operation.RestQuery{
      http_method: http_method,
      path: "/2013-04-01/hostedzone",
      params: Keyword.get(opts, :params, %{}),
      body: Keyword.get(opts, :body, ""),
      service: :route53,
      action: action,
      parser: &ExAws.Route53.Parsers.parse/2
    }
  end
end
