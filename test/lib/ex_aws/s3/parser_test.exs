defmodule ExAws.S3.ParserTest do
  use ExUnit.Case, async: true

  test "#parse_list_objects parses CommonPrefixes" do
    list_objects_response = """
    <ListBucketResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
      <Name>example-bucket</Name>
      <Prefix></Prefix>
      <Marker></Marker>
      <MaxKeys>1000</MaxKeys>
      <Delimiter>/</Delimiter>
      <IsTruncated>false</IsTruncated>
      <Contents>
        <Key>sample.jpg</Key>
        <LastModified>2011-02-26T01:56:20.000Z</LastModified>
        <ETag>&quot;bf1d737a4d46a19f3bced6905cc8b902&quot;</ETag>
        <Size>142863</Size>
        <Owner>
        <ID>canonical-user-id</ID>
        <DisplayName>display-name</DisplayName>
        </Owner>
        <StorageClass>STANDARD</StorageClass>
      </Contents>
      <CommonPrefixes>
        <Prefix>photos/</Prefix>
      </CommonPrefixes>
    </ListBucketResult>
    """

    result = ExAws.S3.Parsers.parse_list_objects({:ok, %{body: list_objects_response}})
    {:ok, %{body: %{common_prefixes: prefixes}}} = result
    prefix_list = Enum.map(prefixes, &(Map.get(&1, :prefix)))

    assert ["photos/"] == prefix_list
  end
end
