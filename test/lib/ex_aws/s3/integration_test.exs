defmodule ExAws.S3IntegrationTest do
  use ExUnit.Case, async: true

  test "#list_buckets" do
    assert {:ok, %{body: body}} = ExAws.S3.list_buckets
    assert body |> String.contains?("ListAllMyBucketsResult")
  end

  test "#list_buckets in ap-southeast-1 region" do
    assert {:ok, %{body: body}} = ExAws.S3.list_buckets client: [region: "ap-southeast-1"]
    assert body |> String.contains?("ListAllMyBucketsResult")
  end

end
