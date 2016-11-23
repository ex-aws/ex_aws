defmodule ExAws.Route53.ParsersTest do
  use ExUnit.Case, async: true
  import Support.ParserHelpers

  alias ExAws.Route53.Parsers

  test "parsing a list hosted zones response" do
    rsp = """
    <?xml version="1.0" encoding="UTF-8"?>
    <ListHostedZonesResponse>
     <HostedZones>
        <HostedZone>
           <CallerReference>CALLER_REFERENCE</CallerReference>
           <Config>
              <Comment>Zone comment</Comment>
              <PrivateZone>false</PrivateZone>
           </Config>
           <Id>ZONE_ID</Id>
           <Name>ZONE_NAME</Name>
           <ResourceRecordSetCount>5</ResourceRecordSetCount>
        </HostedZone>
     </HostedZones>
     <IsTruncated>true</IsTruncated>
     <Marker>MARKER_ID</Marker>
     <MaxItems>20</MaxItems>
     <NextMarker>NEXT_MARKER_ID</NextMarker>
    </ListHostedZonesResponse>
    """
    |> to_success

    {:ok, %{body: parsed_doc}} = Parsers.parse(rsp, :list_hosted_zones)
    assert parsed_doc == %{
      is_truncated: true,
      marker: "MARKER_ID",
      next_marker: "NEXT_MARKER_ID",
      max_items: 20,
      hosted_zones: [%{
        id: "ZONE_ID",
        name: "ZONE_NAME",
        record_set_count: 5,
        comment: "Zone comment",
        caller_reference: "CALLER_REFERENCE"
      }]
    }
  end

  test "parsing a create hosted zone response" do
    rsp = """
    <?xml version="1.0" encoding="UTF-8"?>
    <CreateHostedZoneResponse>
       <ChangeInfo>
          <Comment>CHANGE_COMMENT</Comment>
          <Id>CHANGE_ID</Id>
          <Status>STATUS</Status>
          <SubmittedAt>2016-11-23</SubmittedAt>
       </ChangeInfo>
       <DelegationSet>
          <CallerReference>CALLER_REFERENCE_ID</CallerReference>
          <Id>DELEGATION_SET_ID</Id>
          <NameServers>
             <NameServer>NAME_SERVER</NameServer>
           </NameServers>
       </DelegationSet>
       <HostedZone>
          <CallerReference>CALLER_REFERENCE_ID</CallerReference>
          <Config>
             <Comment>ZONE_COMMENT</Comment>
             <PrivateZone>false</PrivateZone>
          </Config>
          <Id>ZONE_ID</Id>
          <Name>ZONE_NAME</Name>
          <ResourceRecordSetCount>15</ResourceRecordSetCount>
       </HostedZone>
       <VPC>
          <VPCId>VPC_ID</VPCId>
          <VPCRegion>VPC_REGION</VPCRegion>
       </VPC>
    </CreateHostedZoneResponse>
    """
    |> to_success

    {:ok, %{body: parsed_doc}} = Parsers.parse(rsp, :create_hosted_zone)
    assert parsed_doc == %{
      change_info: %{
        comment: "CHANGE_COMMENT",
        id: "CHANGE_ID",
        status: "STATUS",
        submitted_at: "2016-11-23"
      },
      delegation_set: %{
        caller_reference: "CALLER_REFERENCE_ID",
        id: "DELEGATION_SET_ID",
        name_servers: ["NAME_SERVER"]
      },
      hosted_zone: %{
        caller_reference: "CALLER_REFERENCE_ID",
        config: %{
          comment: "ZONE_COMMENT",
          private: false
        },
        id: "ZONE_ID",
        name: "ZONE_NAME",
        record_set_count: 15
      },
      vpc: %{
        vpc_id: "VPC_ID",
        vpc_region: "VPC_REGION"
      }
    }
  end
end
