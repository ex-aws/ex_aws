if Code.ensure_loaded?(SweetXml) do
  defmodule ExAws.Route53.Parsers do
    import SweetXml, only: [sigil_x: 2, transform_by: 2]

    def parse({:ok, %{body: xml}=resp}, :list_hosted_zones) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//ListHostedZonesResponse",
        is_truncated: ~x"./IsTruncated/text()"s |> transform_by(&(&1 == "true")),
        marker: ~x"./Marker/text()"s,
        max_items: ~x"./MaxItems/text()"i,
        next_marker: ~x"./NextMarker/text()"s,
        hosted_zones: [
          ~x"./HostedZones/HostedZone"l,
          id:  id_node_xpath,
          name:  ~x"./Name/text()"s,
          record_set_count:  ~x"./ResourceRecordSetCount/text()"i,
          caller_reference:  ~x"./CallerReference/text()"s,
          comment:  ~x"./Config/Comment/text()"s
        ]
      )

      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse({:ok, %{body: xml}=resp}, :create_hosted_zone) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//CreateHostedZoneResponse",
       change_info: [
         ~x"./ChangeInfo",
         comment: ~x"./Comment/text()"s,
         id: ~x"./Id/text()"s,
         status: ~x"./Status/text()"s,
         submitted_at: ~x"./SubmittedAt/text()"s
       ],
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
          id:  id_node_xpath,
         name:  ~x"./Name/text()"s,
         record_set_count:  ~x"./ResourceRecordSetCount/text()"i,
       ],
       vpc: [
         ~x"./VPC"o,
         vpc_id: ~x"./VPCId/text()"so,
         vpc_region: ~x"./VPCRegion/text()"so,
       ]
     )
      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse({:ok, %{body: xml}=resp}, :delete_hosted_zone) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//DeleteHostedZoneResponse",
       change_info: [
         ~x"./ChangeInfo",
         comment: ~x"./Comment/text()"s,
         id: ~x"./Id/text()"s,
         status: ~x"./Status/text()"s,
         submitted_at: ~x"./SubmittedAt/text()"s
       ]
     )
     {:ok, Map.put(resp, :body, parsed_body)}
    end

    defp id_node_xpath do
      ~x"./Id/text()"s |> transform_by(&String.replace(&1, ~r/^.+?\//, ""))
    end
  end
else
  defmodule ExAws.Route53.Parsers do
    def parse(val, _), do: val
  end
end
