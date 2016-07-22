defmodule ExAws.S3IntegrationTest do
  use ExUnit.Case, async: true

  test "#list_buckets" do
    assert {:ok, %{body: body}} = ExAws.S3.list_buckets |> ExAws.request
    assert body |> String.contains?("ListAllMyBucketsResult")
  end

end
