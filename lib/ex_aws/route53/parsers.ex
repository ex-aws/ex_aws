if Code.ensure_loaded?(SweetXml) do
  defmodule ExAws.Route53.Parsers do
    import SweetXml, only: [sigil_x: 2]

    def parse({:ok, %{body: xml}=resp}, :list_hosted_zones) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//ListHostedZonesResponse",
        is_truncated: ~x"./IsTruncated/text()"s,
        marker: ~x"./Marker/text()"s,
        max_items: ~x"./MaxItems/text()"i,
        next_marker: ~x"./NextMarker/text()"s,
        hosted_zones: [
          ~x"./HostedZones/HostedZone"l,
          id:  ~x"./Id/text()"s,
          name:  ~x"./Name/text()"s,
          record_sets_count:  ~x"./ResourceRecordSetCount/text()"i,
          caller_reference:  ~x"./CallerReference/text()"s,
          comment:  ~x"./Config/Comment/text()"s
        ]
      )
      |> (&Map.put(&1, :is_truncated, &1[:is_truncated] == "true")).()

      {:ok, Map.put(resp, :body, parsed_body)}
    end
  end
else
  defmodule ExAws.Route53.Parsers do
    def parse(val, _), do: val
  end
end
