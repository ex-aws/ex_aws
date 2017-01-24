defmodule ExAws.Route53 do
  import ExAws.Utils, only: [uuid: 0, upcase: 1, rename_keys: 2]
  import ExAws.Xml, only: [add_optional_node: 2]

  @moduledoc """
  Operations on AWS Route53
  """
  @type record_type :: [:a | :aaaa | :cname | :mx | :naptr | :ns | :ptr | :soa | :spf | :srv | :txt]

  @type list_hosted_zones_opts :: [
    {:marker, binary} |
    {:max_items, 1..100}
  ]
  @doc "List hosted zones"
  @spec list_hosted_zones(opts :: list_hosted_zones_opts) :: ExAws.Operation.RestQuery.t
  def list_hosted_zones(opts \\ []) do
    request(:get, :list_hosted_zones, params: opts)
  end

  @type create_hosted_zone_opts :: [
    {:name, binary} |
    {:comment, binary} |
    {:delegation_set, binary} |
    {:private, boolean} |
    {:vpc_is, binary} |
    {:vpc_region, binary}
  ]
  @doc "Create hosted zone"
  @spec create_hosted_zone(opts :: create_hosted_zone_opts) :: ExAws.Operation.RestQuery.t
  def create_hosted_zone(opts \\ []) do
    payload = {
      :CreateHostedZoneRequest, %{xmlns: "https://route53.amazonaws.com/doc/2013-04-01/"}, [
       {:CallerReference, nil, uuid()},
       {:Name, nil, opts[:name]}]
    } |> add_optional_node({:DelegationSetId, nil, opts[:delegation_set]})
      |> add_optional_node(
          {:HostedZoneConfig, nil, nil}
          |> add_optional_node({:Comment, nil, opts[:comment]})
          |> add_optional_node({:PrivateZone, nil, opts[:private]})
    ) |> add_optional_node({
         :VPC, nil, [
           {:VPCId, nil, opts[:vpc_id]},
           {:VPCRegion, nil, opts[:vpc_region]}]
    }) |> ExAws.Xml.build
    request(:post, :create_hosted_zone, body: payload)
  end

  @doc "Delete hosted zone"
  @spec delete_hosted_zone(id :: String.t) :: ExAws.Operation.RestQuery.t
  def delete_hosted_zone(id) do
    request(:delete, :delete_hosted_zone, path: "/#{id}")
  end

  @type record_action :: [:create | :delete | :upsert]
  @type record_opts :: [
    {:action, record_action} |
    {:name, binary} |
    {:type, record_type} |
    {:ttl, Integer.t} |
    {:records, [String.t, ...]}
  ]
  @type change_record_sets_opts :: [
    {:comment, binary} |
    {:action, record_action} |
    {:name, binary} |
    {:type, record_type} |
    {:ttl, non_neg_integer} |
    {:records, [String.t, ...]} |
    {:batch, [record_opts, ...]}
  ]
  @doc "Change resource record sets"
  @spec change_record_sets(id :: String.t, opts :: change_record_sets_opts) :: ExAws.Operation.RestQuery.t
  def change_record_sets(id, opts \\ []) do
    changes = opts |> Keyword.get(:batch, Map.new(opts)) |> List.wrap
    payload = {
      :ChangeResourceRecordSetsRequest, %{xmlns: "https://route53.amazonaws.com/doc/2013-04-01/"},[
       {:ChangeBatch, nil, [
         {:Changes, nil, [
           changes |> Enum.map(fn(change) ->
             {:Change, nil, [
               {:Action, nil, upcase(change[:action])},
               {:ResourceRecordSet, nil, [
                 {:Name, nil, change[:name]},
                 {:Type, nil, upcase(change[:type])},
                 {:TTL, nil, change[:ttl]},
                 {:ResourceRecords, nil, change |> Map.get(:records, []) |> Enum.map(fn value ->
                   {:ResourceRecord, nil, [
                     {:Value, nil, value}
                   ]}
                 end)}
               ]}
             ]}
           end)
         ]},
         {:Comment, nil, opts[:comment]}
       ]}
     ]
    } |> ExAws.Xml.build
    request(:post, :change_record_sets, path: "/#{id}/rrset", body: payload)
  end

  @doc "List resource record sets"
  @type list_record_sets_opts :: [
    {:identifier, binary} |
    {:name, binary} |
    {:type, record_type} |
    {:max_items, non_neg_integer}
  ]
  @spec list_record_sets(id :: String.t, opts :: list_record_sets_opts) :: ExAws.Operation.RestQuery.t
  def list_record_sets(id, opts \\ []) do
    request(:get, :list_record_sets, path: "/#{id}/rrset", params: opts)
  end

  ## Request
  ######################

  defp request(http_method, action, opts) do
    path = Keyword.get(opts, :path, "")
    params = opts |> Keyword.get(:params, []) |> rename_keys(max_items: :maxitems) |> Map.new
    %ExAws.Operation.RestQuery{
      http_method: http_method,
      path: "/2013-04-01/hostedzone#{path}",
      params: params,
      body: Keyword.get(opts, :body, ""),
      service: :route53,
      action: action,
      parser: &ExAws.Route53.Parsers.parse/2
    }
  end
end
