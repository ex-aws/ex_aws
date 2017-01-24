if Code.ensure_loaded?(SweetXml) do
  defmodule ExAws.Route53.Parsers do
    use ExAws.Operation.Query.Parser
    import SweetXml, only: [sigil_x: 2, transform_by: 2]

    def parse({:ok, resp}, :list_hosted_zones) do
      resp |> parse_xml(~x"//ListHostedZonesResponse",
        is_truncated: ~x"./IsTruncated/text()"s |> to_boolean,
        marker: ~x"./Marker/text()"s,
        max_items: ~x"./MaxItems/text()"i,
        next_marker: ~x"./NextMarker/text()"s,
        hosted_zones: [
          ~x"./HostedZones/HostedZone"l,
          id:  id_node(),
          name:  ~x"./Name/text()"s,
          record_set_count:  ~x"./ResourceRecordSetCount/text()"i,
          caller_reference:  ~x"./CallerReference/text()"s,
          comment:  ~x"./Config/Comment/text()"s
        ]
      )
    end

    def parse({:ok, resp}, :create_hosted_zone) do
      resp |> parse_xml(~x"//CreateHostedZoneResponse",
       change_info: change_info_node(),
       delegation_set: [
         ~x"./DelegationSet",
         caller_reference: ~x"./CallerReference/text()"so,
         id: ~x"./Id/text()"so,
         name_servers: ~x"./NameServers/NameServer/text()"ls
       ],
       hosted_zone: [
         ~x"./HostedZone",
         caller_reference: ~x"./CallerReference/text()"s,
         config: [
           ~x"./Config",
           comment: ~x"./Comment/text()"so,
           private: ~x"./PrivateZone/text()"so |> to_boolean,
         ],
          id:  id_node(),
         name:  ~x"./Name/text()"s,
         record_set_count:  ~x"./ResourceRecordSetCount/text()"i,
       ],
       vpc: [
         ~x"./VPC"o,
         vpc_id: ~x"./VPCId/text()"so,
         vpc_region: ~x"./VPCRegion/text()"so,
       ]
     )
    end

    def parse({:ok, resp}, :delete_hosted_zone) do
      resp |> parse_xml(~x"//DeleteHostedZoneResponse", change_info: change_info_node())
    end

    def parse({:ok, resp}, :change_record_sets) do
      resp |> parse_xml(~x"//ChangeResourceRecordSetsResponse", change_info: change_info_node())
    end

    def parse({:ok, resp}, :list_record_sets) do
      resp |> decode_entities |> parse_xml(~x"//ListResourceRecordSetsResponse",
        is_truncated: ~x"./IsTruncated/text()"s |> to_boolean,
        max_items: ~x"./MaxItems/text()"i,
        next_record_identifier: ~x"./NextRecordIdentifier/text()"so,
        next_record_name: ~x"./NextRecordName/text()"so,
        next_record_type: ~x"./NextRecordType/text()"so,
        record_sets: [
          ~x"./ResourceRecordSets/ResourceRecordSet"l,
          alias_target: [
            ~x"./AliasTarget"o,
            dns_name: ~x"./DNSName/text()"s,
            evaluate_target_health: ~x"./EvaluateTargetHealth/text()"s,
            hosted_zone_id: ~x"./HostedZoneId/text()"s
          ],
          failover: ~x"./Failover/text()"so,
          geo_location: [
            ~x"./GeoLocation"o,
            continent_code: ~x"./ContinentCode/text()"s,
            country_code: ~x"./CountryCode/text()"s,
            subdivision_code: ~x"./SubdivisionCode/text()"s
          ],
          health_check_id: ~x"./HealthCheckId/text()"so,
          name: ~x"./Name/text()"s,
          region: ~x"./Region/text()"so,
          values: ~x"./ResourceRecords/ResourceRecord/Value/text()"sl,
          set_identifier: ~x"./SetIdentifier/text()"so,
          traffic_policy_instance_id: ~x"./TrafficPolicyInstanceId/text()"so,
          ttl: ~x"./TTL/text()"i,
          type: ~x"./Type/text()"s,
          weight: ~x"./Weight/text()"Io
        ]
      )
    end

    def parse(val, _), do: val

    defp id_node do
      ~x"./Id/text()"s |> transform_by(&String.replace(&1, ~r/^.+?\//, ""))
    end

    defp to_boolean(xpath) do
      xpath |> transform_by(&(&1 == "true"))
    end

    defp change_info_node do
      [
         ~x"./ChangeInfo",
         comment: ~x"./Comment/text()"s,
         id: id_node(),
         status: ~x"./Status/text()"s,
         submitted_at: ~x"./SubmittedAt/text()"s
       ]
    end

    defp decode_entities(resp) do
      resp |> Map.update(:body, "", &String.replace(&1, "&quot;", "\""))
    end

    defp parse_xml(%{body: xml} = resp, xpath, elements) do
      parsed_body = xml |> SweetXml.xpath(xpath, elements)
     {:ok, Map.put(resp, :body, parsed_body)}
    end
  end
else
  defmodule ExAws.Route53.Parsers do
    def parse(val, _), do: val
  end
end
