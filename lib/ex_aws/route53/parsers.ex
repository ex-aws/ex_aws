if Code.ensure_loaded?(SweetXml) do
  defmodule ExAws.Route53.Parsers do
    import SweetXml, only: [sigil_x: 2, transform_by: 2]

    def parse({:ok, resp}, :list_hosted_zones) do
      resp |> parse_xml(~x"//ListHostedZonesResponse",
        is_truncated: ~x"./IsTruncated/text()"s |> transform_by(&(&1 == "true")),
        marker: ~x"./Marker/text()"s,
        max_items: ~x"./MaxItems/text()"i,
        next_marker: ~x"./NextMarker/text()"s,
        hosted_zones: [
          ~x"./HostedZones/HostedZone"l,
          id:  id_node,
          name:  ~x"./Name/text()"s,
          record_set_count:  ~x"./ResourceRecordSetCount/text()"i,
          caller_reference:  ~x"./CallerReference/text()"s,
          comment:  ~x"./Config/Comment/text()"s
        ]
      )
    end

    def parse({:ok, resp}, :create_hosted_zone) do
      resp |> parse_xml(~x"//CreateHostedZoneResponse",
       change_info: change_info_node,
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
           private: ~x"./PrivateZone/text()"so |> transform_by(&(&1 == "true")),
         ],
          id:  id_node,
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
      resp |> parse_xml(~x"//DeleteHostedZoneResponse", change_info: change_info_node)
    end

    def parse({:ok, resp}, :change_record_sets) do
      resp |> parse_xml(~x"//ChangeResourceRecordSetsResponse", change_info: change_info_node)
    end

    defp id_node do
      ~x"./Id/text()"s |> transform_by(&String.replace(&1, ~r/^.+?\//, ""))
    end

    defp change_info_node do
      [
         ~x"./ChangeInfo",
         comment: ~x"./Comment/text()"s,
         id: id_node,
         status: ~x"./Status/text()"s,
         submitted_at: ~x"./SubmittedAt/text()"s
       ]
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
