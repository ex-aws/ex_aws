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
           <Id>/hostedzone/ZONE_ID</Id>
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
          <Id>/hostedzone/ZONE_ID</Id>
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

  test "parsing a delete hosted zone response" do
    rsp = """
    <?xml version="1.0" encoding="UTF-8"?>
    <DeleteHostedZoneResponse>
       <ChangeInfo>
          <Comment>CHANGE_COMMENT</Comment>
          <Id>CHANGE_ID</Id>
          <Status>STATUS</Status>
          <SubmittedAt>2016-12-01</SubmittedAt>
       </ChangeInfo>
    </DeleteHostedZoneResponse>
    """
    |> to_success

    {:ok, %{body: parsed_doc}} = Parsers.parse(rsp, :delete_hosted_zone)
    assert parsed_doc == %{
      change_info: %{
        comment: "CHANGE_COMMENT",
        id: "CHANGE_ID",
        status: "STATUS",
        submitted_at: "2016-12-01"
      }
    }
  end

  test "parsing a change resource record sets" do
    rsp = """
    <?xml version="1.0" encoding="UTF-8"?>
    <ChangeResourceRecordSetsResponse>
       <ChangeInfo>
          <Comment>CHANGE_COMMENT</Comment>
          <Id>CHANGE_ID</Id>
          <Status>STATUS</Status>
          <SubmittedAt>2016-01-01</SubmittedAt>
       </ChangeInfo>
    </ChangeResourceRecordSetsResponse>
    """
    |> to_success

    {:ok, %{body: parsed_doc}} = Parsers.parse(rsp, :change_record_sets)
    assert parsed_doc == %{
      change_info: %{
        comment: "CHANGE_COMMENT",
        id: "CHANGE_ID",
        status: "STATUS",
        submitted_at: "2016-01-01"
      }
    }
  end

  test "parsing a list resource record sets" do
    rsp = """
    <?xml version="1.0" encoding="UTF-8"?>
    <ListResourceRecordSetsResponse>
       <IsTruncated>true</IsTruncated>
       <MaxItems>21</MaxItems>
       <NextRecordIdentifier>NEXT_IDENTIFIER</NextRecordIdentifier>
       <NextRecordName>NEXT_NAME</NextRecordName>
       <NextRecordType>NEXT_TYPE</NextRecordType>
       <ResourceRecordSets>
          <ResourceRecordSet>
             <AliasTarget>
                <DNSName>ALIAS_NAME</DNSName>
                <EvaluateTargetHealth>ALIAS_EVALUATE_TARGET_HEALTH</EvaluateTargetHealth>
                <HostedZoneId>ALIAS_HOSTED_ZONE_ID</HostedZoneId>
             </AliasTarget>
             <Failover>FAILOVER</Failover>
             <GeoLocation>
                <ContinentCode>CONTINENT_CODE</ContinentCode>
                <CountryCode>COUNTRY_CODE</CountryCode>
                <SubdivisionCode>SUBDIVISION_CODE</SubdivisionCode>
             </GeoLocation>
             <HealthCheckId>HEALTH_CHECK_ID</HealthCheckId>
             <Name>NAME</Name>
             <Region>REGION</Region>
             <ResourceRecords>
                <ResourceRecord>
                   <Value>VALUE_1</Value>
                </ResourceRecord>
                <ResourceRecord>
                   <Value>VALUE_2</Value>
                </ResourceRecord></ResourceRecords>
             <SetIdentifier>SET_IDENTIFIER</SetIdentifier>
             <TrafficPolicyInstanceId>TRAFFIC_POLICY_INSTANCE_ID</TrafficPolicyInstanceId>
             <TTL>500</TTL>
             <Type>NS</Type>
             <Weight>100</Weight>
          </ResourceRecordSet></ResourceRecordSets>
    </ListResourceRecordSetsResponse>
    """
    |> to_success

    {:ok, %{body: parsed_doc}} = Parsers.parse(rsp, :list_record_sets)
    assert parsed_doc == %{
      is_truncated: true,
      max_items: 21,
      next_record_identifier: "NEXT_IDENTIFIER",
      next_record_name: "NEXT_NAME",
      next_record_type: "NEXT_TYPE",
      record_sets: [
        %{
          alias_target: %{
            dns_name: "ALIAS_NAME",
            evaluate_target_health: "ALIAS_EVALUATE_TARGET_HEALTH",
            hosted_zone_id: "ALIAS_HOSTED_ZONE_ID"
          },
          failover: "FAILOVER",
          geo_location: %{
            continent_code: "CONTINENT_CODE",
            country_code: "COUNTRY_CODE",
            subdivision_code: "SUBDIVISION_CODE"
          },
          health_check_id: "HEALTH_CHECK_ID",
          name: "NAME",
          region: "REGION",
          values: ["VALUE_1", "VALUE_2"],
          set_identifier: "SET_IDENTIFIER",
          traffic_policy_instance_id: "TRAFFIC_POLICY_INSTANCE_ID",
          ttl: 500,
          type: "NS",
          weight: 100
        }
      ]
    }
  end
end
