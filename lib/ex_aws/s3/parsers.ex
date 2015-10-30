if Code.ensure_loaded?(SweetXml) do
  defmodule ExAws.S3.Parsers do
    import SweetXml, only: [sigil_x: 2]

    def parse_list_objects({:ok, resp = %{body: xml}}) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//ListBucketResult",
        name: ~x"./Name/text()",
        is_truncated: ~x"./IsTruncated/text()",
        prefix: ~x"./Prefix/text()",
        marker: ~x"./Marker/text()",
        max_keys: ~x"./MaxKeys/text()",
        next_marker: ~x"./NextMarker/text()",
        contents: [
          ~x"./Contents"l,
          key: ~x"./Key/text()",
          last_modified: ~x"./LastModified/text()",
          e_tag: ~x"./ETag/text()",
          size: ~x"./Size/text()",
          storage_class: ~x"./StorageClass/text()",
          owner: [
            ~x"./Owner"o,
            id: ~x"./ID/text()",
            display_name: ~x"./DisplayName/text()"
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

    def parse_initiate_multipart_upload(val), do: val
    def parse_upload_part_copy(val), do: val
    def parse_complete_multipart_upload(val), do: val
    def parse_list_parts(val), do: val

  end
else
  defmodule ExAws.S3.Parsers do
    def parse_list_objects(val), do: val
    def parse_initiate_multipart_upload(val), do: val
    def parse_upload_part_copy(val), do: val
    def parse_complete_multipart_upload(val), do: val
    def parse_list_parts(val), do: val
  end

end
