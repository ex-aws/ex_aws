defmodule ExAws.S3IntegrationTest do
  use ExUnit.Case, async: true

  test "#list_buckets" do
    assert {:ok, %{body: body}} = ExAws.S3.list_buckets |> ExAws.request
    assert %{buckets: _} = body
  end

  test "#list_objects with stream! with delimiter (with no results)" do
    {:ok, %{body: %{buckets: [%{name: bucket} | _rest]}}} = ExAws.S3.list_buckets |> ExAws.request

    results = ExAws.S3.list_objects(bucket, delimiter: "/", prefix: "zzzyyyxxxwww") |> ExAws.stream! |> Enum.to_list

    assert [] = results
  end

  test "#list_objects with stream! with delimiter (folders, will not paginate)" do
    {:ok, %{body: %{buckets: [%{name: bucket} | _rest]}}} = ExAws.S3.list_buckets |> ExAws.request

    results = ExAws.S3.list_objects(bucket, delimiter: "/", prefix: "folders/short/") |> ExAws.stream! |> Enum.to_list

    assert [
      %{prefix: "folders/short/0001/"},
      %{prefix: "folders/short/0002/"},
      %{prefix: "folders/short/0003/"}
    ] = results
  end

  test "#list_objects with stream! with delimiter (folders, will paginate)" do
    {:ok, %{body: %{buckets: [%{name: bucket} | _rest]}}} = ExAws.S3.list_buckets |> ExAws.request

    results = ExAws.S3.list_objects(bucket, delimiter: "/", prefix: "folders/long/") |> ExAws.stream! |> Enum.to_list

    assert [%{prefix: "folders/long/0001/"} | _t] = results
    assert length(results) == 1200
  end

  test "#list_objects with stream! with delimiter (objects, will not paginate)" do
    {:ok, %{body: %{buckets: [%{name: bucket} | _rest]}}} = ExAws.S3.list_buckets |> ExAws.request

    results = ExAws.S3.list_objects(bucket, delimiter: "/", prefix: "objects/short/") |> ExAws.stream! |> Enum.to_list

    assert [
      %{e_tag: _, key: "objects/short/0001"},
      %{e_tag: _, key: "objects/short/0002"},
      %{e_tag: _, key: "objects/short/0003"},
    ] = results
  end

  test "#list_objects with stream! with delimiter (objects, will paginate)" do
    {:ok, %{body: %{buckets: [%{name: bucket} | _rest]}}} = ExAws.S3.list_buckets |> ExAws.request

    results = ExAws.S3.list_objects(bucket, delimiter: "/", prefix: "objects/long/") |> ExAws.stream! |> Enum.to_list

    assert [%{e_tag: _, key: "objects/long/0001"} | _t] = results
    assert length(results) == 1200
  end
end
