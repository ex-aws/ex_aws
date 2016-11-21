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
    assert parsed_doc[:is_truncated] == true
    assert parsed_doc[:marker] == "MARKER_ID"
    assert parsed_doc[:next_marker] == "NEXT_MARKER_ID"
    assert parsed_doc[:max_items] == 20
    assert parsed_doc[:hosted_zones] == [%{
      id: "ZONE_ID",
      name: "ZONE_NAME",
      record_sets_count: 5,
      comment: "Zone comment",
      caller_reference: "CALLER_REFERENCE"
    }]
  end
end
