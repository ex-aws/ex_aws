defmodule ExAws.Error.SweetXMLNotFound do
  defexception message: """
    The package sweet_xml is not found, and needs to be included in your
    application. If it is loaded, make sure it is loaded before ex_aws in your
    application list.
    """
end

if Code.ensure_loaded?(SweetXml) do
  defmodule ExAws.S3.Parsers do
    import SweetXml, only: [sigil_x: 2]

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
    alias ExAws.Error.SweetXMLNotFound

    def parse_list_objects(val), do: raise SweetXMLNotFound
    def parse_initiate_multipart_upload(val), do: raise SweetXMLNotFound
    def parse_upload_part_copy(val), do: raise SweetXMLNotFound
    def parse_complete_multipart_upload(val), do: raise SweetXMLNotFound
    def parse_list_parts(val), do: raise SweetXMLNotFound
  end
end
