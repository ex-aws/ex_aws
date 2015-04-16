defmodule ExAws.S3Test do
  use ExUnit.Case, async: true

  test "#list_buckets" do
    assert {:ok, body} = ExAws.S3.list_buckets
    assert body |> String.contains?("ListAllMyBucketsResult")
  end

end
