if Code.ensure_loaded?(SweetXml) do
  defmodule ExAws.S3.Parsers do
    import SweetXml, only: [sigil_x: 2]

    def parse_upload({:ok, resp = %{body: xml}}) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//CompleteMultipartUploadResult",
        location: ~x"./Location/text()"s,
        bucket: ~x"./Bucket/text()"s,
        key: ~x"./Key/text()"s,
        eTag: ~x"./ETag/text()"s
      )

      {:ok, %{resp | body: parsed_body}}
    end

    def parse_list_objects({:ok, resp = %{body: xml}}) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//ListBucketResult",
        name: ~x"./Name/text()"s,
        is_truncated: ~x"./IsTruncated/text()"s,
        prefix: ~x"./Prefix/text()"s,
        marker: ~x"./Marker/text()"s,
        max_keys: ~x"./MaxKeys/text()"s,
        next_marker: ~x"./NextMarker/text()"s,
        contents: [
          ~x"./Contents"l,
          key: ~x"./Key/text()"s,
          last_modified: ~x"./LastModified/text()"s,
          e_tag: ~x"./ETag/text()"s,
          size: ~x"./Size/text()"s,
          storage_class: ~x"./StorageClass/text()"s,
          owner: [
            ~x"./Owner"o,
            id: ~x"./ID/text()"s,
            display_name: ~x"./DisplayName/text()"s
          ]
        ],
        common_prefixes: [
          ~x"./CommonPrefixes"l,
          prefix: ~x"./Prefix/text()"s
        ]
      )

      {:ok, %{resp | body: parsed_body}}
    end
    def parse_list_objects(val), do: val

    def parse_all_my_buckets_result({:ok, resp = %{body: xml}}) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//ListAllMyBucketsResult",
        owner: [
          ~x"./Owner",
          id: ~x"./ID/text()"s,
          display_name: ~x"./DisplayName/text()"s
        ],
        buckets: [
          ~x".//Bucket"l,
          name: ~x"./Name/text()"s,
          creation_date: ~x"./CreationDate/text()"s
        ]
      )

      {:ok, %{resp | body: parsed_body}}
    end
    def parse_all_my_buckets_result(val), do: val

    def parse_initiate_multipart_upload({:ok, resp = %{body: xml}}) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//InitiateMultipartUploadResult",
        bucket: ~x"./Bucket/text()"s,
        key: ~x"./Key/text()"s,
        upload_id: ~x"./UploadId/text()"s
      )

      {:ok, %{resp | body: parsed_body}}
    end
    def parse_initiate_multipart_upload(val), do: val

    def parse_upload_part_copy(val), do: val
    def parse_complete_multipart_upload(val), do: val

    def parse_list_multipart_uploads({:ok, %{body: xml} = resp}) do
      parsed_body = SweetXml.xpath(xml, ~x"//ListMultipartUploadsResult",
        bucket: ~x"./Bucket/text()"s,
        key_marker: ~x"./KeyMarker/text()"s,
        upload_id_marker: ~x"./UploadIdMarker/text()"s,
        uploads: [~x"./Upload"l,
          key: ~x"./Key/text()"s,
          upload_id: ~x"./UploadId/text()"s,
        ]
      )
      {:ok, %{resp | body: parsed_body}}
    end
    def parse_list_multipart_uploads(val), do: val

    def parse_list_parts(val), do: val

  end
else
  defmodule ExAws.S3.Parsers do
    defp missing_xml_parser(), do: raise ExAws.Error, "Missing XML parser. Please see docs"
    def upload(_val), do: missing_xml_parser()
    def parse_list_objects(_val), do: missing_xml_parser()
    def parse_all_my_buckets_result(_val), do: missing_xml_parser()
    def parse_initiate_multipart_upload(_val), do: missing_xml_parser()
    def parse_upload_part_copy(_val), do: missing_xml_parser()
    def parse_complete_multipart_upload(_val), do: missing_xml_parser()
    def parse_list_multipart_uploads(_val), do: missing_xml_parser()
    def parse_list_parts(_val), do: missing_xml_parser()
  end

end
