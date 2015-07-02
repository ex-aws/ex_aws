defmodule ExAws.S3.Parsers do

  def parse_list_objects({:ok, resp = %{body: xml}}) do
    parsed_body = xml
    |> SweetXml.xpath(SweetXml.sigil_x("//ListBucketResult", []),
      name: SweetXml.sigil_x("./Name/text()", []),
      is_truncated: SweetXml.sigil_x("./IsTruncated/text()", []),
      prefix: SweetXml.sigil_x("./Prefix/text()", []),
      marker: SweetXml.sigil_x("./Marker/text()", []),
      max_keys: SweetXml.sigil_x("./MaxKeys/text()", []),
      next_marker: SweetXml.sigil_x("./NextMarker/text()", []),
      contents: [
        SweetXml.sigil_x("./Contents", 'l'),
        key: SweetXml.sigil_x("./Key/text()", []),
        last_modified: SweetXml.sigil_x("./LastModified/text()", []),
        e_tag: SweetXml.sigil_x("./ETag/text()", []),
        size: SweetXml.sigil_x("./Size/text()", []),
        storage_class: SweetXml.sigil_x("./StorageClass/text()", []),
        owner: [
          SweetXml.sigil_x("./Owner", []),
          id: SweetXml.sigil_x("./ID/text()", []),
          display_name: SweetXml.sigil_x("./DisplayName/text()", [])
        ]
      ]
    )
    |> list_objects_binaries

    {:ok, %{resp | body: parsed_body}}
  end
  def parse_list_objects(val), do: val

  defp list_objects_binaries(result) do
    Enum.into(result, %{}, fn
      {:contents, contents} -> {:contents, Enum.map(contents, &list_objects_binaries/1)}
      {:owner, v} -> {:owner, list_objects_binaries(v)}
      {k, nil} -> {k, nil}
      {k, v} -> {k, IO.chardata_to_string(v)}
    end)
  end

end
